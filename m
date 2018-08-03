Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 047061F597
	for <e@80x24.org>; Fri,  3 Aug 2018 09:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeHCL2h (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 07:28:37 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:64331 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbeHCL2g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 07:28:36 -0400
Received: from [192.168.2.201] ([92.22.30.174])
        by smtp.talktalk.net with SMTP
        id lWSHfe4nHwhzSlWSHfDwWi; Fri, 03 Aug 2018 10:33:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533288787;
        bh=2k6hYx7p4VjLAm8sOvp7Y7CwFJgWzNzUADACh6oLbZ4=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Cr09hB4frp6VfeNIXbReb/wWffkvdljlC6ajgRWgP0b2PRZCWwXmW4/mqLhPKutr0
         vtfhwj3jpFg6To/ykeMO2y1fwpkm0MJSIDGepH7N8Fp3T0oCUsYQMi5QAvKsgXSZFw
         sRsF/BIBphdi8lwJ28xY20fvJbDVRN32wXHgMjag=
X-Originating-IP: [92.22.30.174]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=2xfjePbNG5I+/HyESt+5YA==:117
 a=2xfjePbNG5I+/HyESt+5YA==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=nN7BH9HXAAAA:8 a=5rxgeBVgAAAA:8 a=pGLkceISAAAA:8 a=9oeI_W8nhleS-lksfv0A:9
 a=MHZGPTcnjffcD9aJ:21 a=gThMiOi8Lk4gIvQy:21 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] sequencer: fix quoting in write_author_script
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180802112002.720-1-phillip.wood@talktalk.net>
 <20180802112002.720-3-phillip.wood@talktalk.net>
 <xmqqk1p83cig.fsf@gitster-ct.c.googlers.com>
 <CAPig+cQaaHfkR8jrXb-+PB4bSZbKLQzRkZNo+DNfz92hKO=04Q@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <c7b8629d-7b93-2fbf-6793-0d566e86a229@talktalk.net>
Date:   Fri, 3 Aug 2018 10:33:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cQaaHfkR8jrXb-+PB4bSZbKLQzRkZNo+DNfz92hKO=04Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPUyRN5MdrepslwTSps8Br88HN5orvYJxLyIsrIELlaIsVVjc1NpUG1XQHTj+Tr3QliT5I5/zfDQZNCbdHj39QaCCYnP9mxyp1S1KaUw4OZ9733Kp67h
 IQpMkBO8XK07arvIlpTcJtsPnoYc9FuWKGG8uuCkTAC6AYFU8S9jvUGpCeS5St2j6++MtGmXb5iS308DKWtSfq6Y1eLmWimnOUruUjhRTg+UJP3xWzx1Ii6j
 ZOa0l9IBkt1fiAdOpQjmcKeh8d6Ysr5YtiBHVUd1B4oGzsdIcKhB/PuhaWEZ6sAAHSE7Kx8GZEi54/BPr0kjERoLGijlDKI4I1lbNd8bRnQPSoKAFbBPYNqB
 UyM9ZHwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Eric and Junio
On 03/08/18 08:59, Eric Sunshine wrote:
> On Thu, Aug 2, 2018 at 1:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>> For other interactive rebases this only affects external scripts that
>>> read the author script and users whose git is upgraded from the shell
>>> version of rebase -i while rebase was stopped when the author contains
>>> "'". This is because the parsing in read_env_script() expected the
>>> broken quoting.
>>
>> I wasn't following the discussion, but is it the general consensus
>> that reading the broken a-i file is a requirement for the new code?
>> Not an objection phrased as a question.
>>
>> I do not think it is worth worrying about the "upgrade while rebase
>> was in progress" case, if it involves much more code than necessary
>> without its support, especially if the only thing the user needs to
>> do recover from such a situation is to say "rebase --abort" and then
>> to retry the same rebase with the fixed version that was installed
>> in the meantime. [...]
>>
>> [...] It still does look
>> unnecessarily ugly and over-engineered to have this (and the
>> "version" reading code), though, at least to me, but perhaps it is
>> just me.
> 
> It's not just you. I also questioned[1] if such backward compatibility
> was needed, and had concerns[2] about a version file being heavyweight
> and over-engineered.

If there isn't some backward compatibility then if git gets upgraded
while rebase is stopped then the author data will be silently corrupted
if it contains "'". read_author_ident() will error out but that is only
used for the root commit. read_env_script() which is used for normal
picks will not dequote the badly quoted value correctly and will not
return an error. It is unlikely but possible, I'll leave it to Junio to
decide if it is worth it

> 
> This is a lot of new code (possibly harboring its own bugs) for a
> situation unlikely to arise, and which becomes ever more unlikely as
> time passes. Also, unlike long-lived (years or decades) resources,
> such as a repository or pack file, for instance, for which a version
> number makes sense, this file is very short-lived, which makes it even
> more difficult to justify adding this much machinery for something so
> unlikely to arise in practice.

There is a precedent for adding backwards compatibility 84df4560ed
("rebase: extract code for writing basic state", 2011-02-06) though it
is much simpler. Part of the commit message reads

    Note that non-interactive rebase stores the sha1 of the
    original head in a file called orig-head, while interactive
    rebase stores it in a file called head. Change this by
    writing to orig-head in both cases. When reading, try to read
    from orig-head. If that fails, read from head instead. This
    protects users who upgraded git while they had an ongoing
    interactive rebase, while still making it possible to remove
    the code that reads from head at some point in the future.

Best Wishes

Phillip

> The overall aim of this series to fix these bugs is laudable, but I
> would be happy to see this one reduced to just a "bug fix" patch
> without all the backward-compatibility machinery (and wouldn't mind
> seeing patch 1/2 simplified[3], as well).
> 
> Thanks.
> 
> [1]: https://public-inbox.org/git/CAPig+cR5VHP8muo5_A_9t7OPZam8O_uPb0nd73B15Ye92n+p7Q@mail.gmail.com/
> [2]: https://public-inbox.org/git/CAPig+cTttbV2FjnoS_SZtwh2J4wwzsbK+48BAbt1cV0utynYzw@mail.gmail.com/
> [3]: https://public-inbox.org/git/CAPig+cSZ3Zm=qFcvGjyj_uStn=JMAYuskMa0O_2yxkKjaRWTSg@mail.gmail.com/
> 

