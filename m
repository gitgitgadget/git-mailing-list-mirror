Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8135B1F406
	for <e@80x24.org>; Thu, 10 May 2018 13:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935207AbeEJNtg (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 09:49:36 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:7930 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757097AbeEJNtf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 09:49:35 -0400
Received: from [192.168.2.201] ([92.22.23.119])
        by smtp.talktalk.net with SMTP
        id Glwqfohav51uyGlwqf98ZD; Thu, 10 May 2018 14:49:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1525960173;
        bh=PHLPdzO3OKprMfel0NMU9Fr9fZfjQ916gmPY47GeuTI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZOuueMgvyapZjYEEex4YXeEfOVl9mkAPhGdwlB3f9MCx1VdSw4kggkI39NQm20pDC
         h78dzDzW7Yg6/H1Wov3/XhjBMerJttX0P07rhqMW1JmEEfDyTRd8Tt1fM9hr5JjxVF
         PhLBR07D57Gkr1kBFYCI1jGCpYotrYCPw/cw1sxw=
X-Originating-IP: [92.22.23.119]
X-Spam: 0
X-OAuthority: v=2.3 cv=d9PbNyrE c=1 sm=1 tr=0 a=oWXjcmuSLv9+fGSLdn2kqg==:117
 a=oWXjcmuSLv9+fGSLdn2kqg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=uPZiAMpXAAAA:8 a=y5wdKUOQASCxUkfgMGkA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Regression in patch add?
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Oliver Joseph Ash <oliverjash@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     mqudsi@neosmart.net, Git Mailing List <git@vger.kernel.org>
References: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
 <20180510104136.8653-1-oliverjash@gmail.com>
 <CAN0heSq5SyPgoEURRVHupcabVu3jX+tmX+0U-6azrJDDgfZ5Gw@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <be321106-2f10-e678-8237-449d2dd30fee@talktalk.net>
Date:   Thu, 10 May 2018 14:49:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSq5SyPgoEURRVHupcabVu3jX+tmX+0U-6azrJDDgfZ5Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPUPJvS0izwSA3ai9keuUqsTn3VFnIV7s+Kzn5Kk+CGaArQu4mwlSvMsedx7Bo5K023tiyCmpJRX38W7gfuyeZb7ucPRRM+6jsHXCeIxzfbnU9DbQ8Ry
 FQNXa2FuuDcx5EmY8pLeGZFz7mmCJIP/yP8+FX5UnkjcecOwfCMqj1x55r1NCEYDH87HkHXclOnDEUsF1bO7pUdiTfTbT+5+VKL/NU4VyDXWBQbXrektkUOI
 wkgUbZqV7t98m4QMlcB6PHQYwuP2vlTY9HDwnWeuhlcKCqNtL+TFXCRdrkQG//SP4I6OV9fiHDMjLvzsunOgSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/05/18 13:17, Martin Ågren wrote:
> 
> On 10 May 2018 at 12:41, Oliver Joseph Ash <oliverjash@gmail.com> wrote:
>> I just ran into a similar problem: https://stackoverflow.com/questions/50258565/git-editing-hunks-fails-when-file-has-other-hunks
>>
>> I can reproduce on 2.17.0. The issue doesn't occur on 2.16.2, however.
>>
>> Is this a bug?
> 
> I would think so. Thanks for finding this thread. To keep history
> around, it would be nice to have your reproduction recipe on the list,
> not just on stackoverflow. That said, I cannot reproduce on v2.17.0
> using your recipe. I suspect there is something quite interesting going
> on here, considering how trivial your edit is.

Thanks Oliver for posting an example that we can test, that said I can't
reproduce it on Linux if the hunk is edited correctly. However if I
remove the leading space from the empty line between 'baz' and 'foo'
then I get the same error as you. Perhaps your editor is stripping
trailing white space? If so that will lead to problems when editing
diffs as the leading space is needed for apply to know that it's an
empty context line.

For the mailing list the hunk in question looks like
@@ -1,5 +1,5 @@
 foo
-bar
+bar1
 baz

 foo

I've tried using 'git apply --recount --cached' directly and was
surprised to see that it accepts the patch with the broken context line.
In 2.17.0 'add -p' no longer uses the --recount option, instead it
counts the patch it's self but stops counting when it runs out of lines
starting with [- +], this explains the difference from earlier versions.
It seems it's not uncommon for editors to strip the space from empty
context lines so maybe 'add -p' should take that into account when
recounting patches. I'm about to go off line for a couple of weeks so it
will probably be next month before I'm able to put a patch together
(assuming Junio agrees we should support broken hunks)

Best Wishes

Phillip


> As a shot in the dark, does your test involve unusual file systems,
> funny characters in filenames, ..? You are on some sort of Linux, right?
> 
> The first thing to try out might be something like
> 
> $ # create the initial file as before, with "bar"
> $ # git add, git commit ...
> $ # do the "change bar to bar1" everywhere
> $ git diff >test-patch
> $ git reset --hard
> $ # edit the *FIRST* hunk in test.patch like before (bar1 -> bar2)
> $ git apply --check test.patch && echo "ok..."
> $ git apply test.patch
> 
> Does that succeed at all?
> 
> $ git diff
> 
> should now show bar2 in the first hunk and bar1 in the second hunk,
> just like your edited test.patch.
> 
> If that works, it would seem that the problem is with `git add -p`, and
> how it is generating the patches for `git apply`. I have some ideas
> about how to debug from there, but ... How comfortable are you with
> building Git from the sources? Or with temporarily fiddling around with
> your Git installation? (git-add--interactive is a Perl script, so it
> would be possible to edit it in place to emit various debug
> information. That has potential for messing up royally, though.)
> 
> Martin
> 

