Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1A51F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389122AbfAPKeA (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:34:00 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:38230 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731965AbfAPKd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:33:59 -0500
Received: from [192.168.2.240] ([92.28.143.98])
        by smtp.talktalk.net with SMTP
        id jiWCgksMnAGVrjiWCg7OJ8; Wed, 16 Jan 2019 10:33:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1547634836;
        bh=DvrUDkoCB00xKt3uQ+TzqS5WX+xEp8s+nuWldHPAbe0=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=KtOihrF7agEW3H8AGmQw6zTYdNWrSdLk3HD5YZKWVO2lLZogWBNQgUeme43GfcJhz
         8OoMu9FUIUxvYPogEkN8X4IFJkjJhnk5UEYEuOxtm4b167e2dJ6vCPA7pbPajItdDt
         tfKIM/Qyi1Maxs9ROnk4/EXwZrzmBcyycYME5kH0=
X-Originating-IP: [92.28.143.98]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=j7EZ+OPOvdswaUU3zPu4lA==:117
 a=j7EZ+OPOvdswaUU3zPu4lA==:17 a=IkcTkHD0fZMA:10 a=cUh97MXDAAAA:20
 a=c8N2qxwPAAAA:8 a=yvH0ORhLAAAA:8 a=kkXSrVyLAAAA:8 a=HHGDD-5mAAAA:8
 a=pGLkceISAAAA:8 a=RdbUroKXAAAA:8 a=OEOMPt30AAAA:8 a=t1iREKK1AAAA:8
 a=L1Hje6E2uucSGtTHqd4A:9 a=QEXdDO2ut3YA:10 a=avDSiMLFTVQA:10
 a=z86bnWsfFWkCUr07FtHd:22 a=g16NiAzxEZCYhzHwdYj3:22 a=kWRtAMWQZpFwJH8yTbDI:22
 a=enGQBRq35Lfor7j-KrOS:22 a=v4PQfO9bYglRLCrpL3Dl:22 a=GwMASsXFoBx4fiRzfQgc:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Broken interactive rebase text after some UTF-8 characters
To:     Michal Nowak <mnowak@startmail.com>, git@vger.kernel.org
References: <a50734d9-4d30-5847-b5df-67a8458a36cb@startmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <339d4dbd-b1bd-cf88-12b0-2af42f35ded7@talktalk.net>
Date:   Wed, 16 Jan 2019 10:33:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <a50734d9-4d30-5847-b5df-67a8458a36cb@startmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHGFTKyjJrYgoPvnNI0RvxSS8QN6x0ap99aykGaz7gr+T2FIQ7iPiQ2Mv2lgOTBHHM8cHDHmf0VkkWWlHuvYOEIu+IgDO+TrYpdE/jhJUsu7kYjmAX/O
 UZdb+clmMR/GvQ/skZMLx8Gv5SEVJK/lHUrJRQ19H+meqU5xpA5PipRZJAHhajjG3xIXMj89rCN0RrNlO4ysjdGXXxXox4TiPew=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Michal

Thanks for the bug report, unfortunately I'm unable to reproduce it here 
using git 2.20.1 (see below). Knowing a little about how the todo list 
is created I cannot think how multibyte characters would break it. What 
command line were you using to start the rebase?

Best Wishes

Phillip

$ git clone --shallow-since='11-1-2019' 
https://github.com/illumos/illumos-gate.git
Cloning into 'illumos-gate'...
remote: Enumerating objects: 54348, done.
remote: Counting objects: 100% (54348/54348), done.
remote: Compressing objects: 100% (39008/39008), done.
remote: Total 54348 (delta 19671), reused 31187 (delta 11884), pack-reused 0
Receiving objects: 100% (54348/54348), 148.91 MiB | 1.18 MiB/s, done.
Resolving deltas: 100% (19671/19671), done.
Checking out files: 100% (47352/47352), done.

$ cd ~/src/illumos-gate
$ git log --oneline -1
f482e26c (HEAD -> master, origin/master, origin/HEAD) 10233 dboot: 
process_module() is missing newline at the end of the string Reviewed 
by: Sebastian Wiedenroth <wiedi@frubar.net> Reviewed by: Jason King 
<jbk@joyent.com> Reviewed by: Andy Stormont 
<astormont@racktopsystems.com> Approved by: Robert Mustacchi <rm@joyent.com>

$ GIT_SEQUENCE_EDITOR=cat git rebase -i 
08487eea68a2fa501b5042131c6db068089f82e1

hint: Waiting for your editor to close the file...
pick 1ea94c75 10202 loader: use screen-#rows to find bottom left 
co-ordinates Reviewed by: Toomas Soome <tsoome@me.com> Reviewed by: 
Gergő Mihály Doma <domag02@gmail.com> Approved by: Robert Mustacchi 
<rm@joyent.com>
pick cadd68ea 10078 smatch fixes for UCB Reviewed by: Andy Fiddaman 
<omnios@citrus-it.net> Reviewed by: Toomas Soome <tsoome@me.com> 
Reviewed by: Peter Tribble <peter.tribble@gmail.com> Approved by: Robert 
Mustacchi <rm@joyent.com>
pick 05ede3db 10079 smatch Makefile changes for usr/src/lib Reviewed by: 
Andy Fiddaman <andy@omniosce.org> Approved by: Robert Mustacchi 
<rm@joyent.com>
pick 5661bb76 10080 smatch Makefile changes for usr/src/cmd Reviewed by: 
Andy Fiddaman <andy@omniosce.org> Approved by: Robert Mustacchi 
<rm@joyent.com>
pick 15c07adc 10081 smatch indenting fixes for usr/src/uts Reviewed by: 
Toomas Soome <tsoome@me.com> Reviewed by: Peter Tribble 
<peter.tribble@gmail.com> Reviewed by: Andy Fiddaman <andy@omniosce.org> 
Approved by: Robert Mustacchi <rm@joyent.com>
pick c653bb47 10197 build smatch in parallel Reviewed by: Andy Fiddaman 
<andy@omniosce.org> Approved by: Robert Mustacchi <rm@joyent.com>
pick 161294fe 10217 mdb: r9w isn't r8w 10218 CONV_CAP_VAL_HW2_BUFSIZE 
wasn't updated 10219 AV_386_2_AVX512VPOPCDQ elfcap name should be 
consistent Reviewed by: Dan McDonald <danmcd@joyent.com> Reviewed by: 
Rob Johnston <rob.johnston@joyent.com> Reviewed by: Patrick Mooney 
<patrick.mooney@joyent.com> Reviewed by: Andy Fiddaman 
<andy@omniosce.org> Approved by: Dan McDonald <danmcd@joyent.com>
pick f482e26c 10233 dboot: process_module() is missing newline at the 
end of the string Reviewed by: Sebastian Wiedenroth <wiedi@frubar.net> 
Reviewed by: Jason King <jbk@joyent.com> Reviewed by: Andy Stormont 
<astormont@racktopsystems.com> Approved by: Robert Mustacchi <rm@joyent.com>

# Rebase 08487eea..f482e26c onto 08487eea (8 commands)
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup <commit> = like "squash", but discard this commit's log message
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified). Use -c <commit> to reword the commit message.
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out
Successfully rebased and updated refs/heads/master.


On 15/01/2019 19:29, Michal Nowak wrote:
> Hello,
> 
> on OpenIndiana 2018.10 (illumos kernel) line of the interactive rebase 
> text after a particular name (Gergő Mihály Doma) is broken:
> 
> pick 1ea94c756c 10202 loader: use screen-#rows to find bottom left 
> co-ordinates Reviewed by: Toomas Soome <tsoome@me.com> Reviewed by: 
> Gergő Mihály Doma <domag02@gmail.com> Approved by: Robert Mustacchi 
> <rm@joyent.com>
> p
> pick cadd68ea00 10078 smatch fixes for UCB Reviewed by: Andy Fiddaman 
> <omnios@citrus-it.net> Reviewed by: Toomas Soome <tsoome@me.com> 
> Reviewed by: Peter Tribble <peter.tribble@gmail.com> Approved by: Robert 
> Mustacchi <rm@joyent.com>
> 
> 
> Source: https://github.com/illumos/illumos-gate.git
> 
> See the second item which only has "p".
> 
> This is with LC_ALL=en_US.UTF-8 (same with cs_CZ.UTF-8), with LC_ALL=C 
> the text is fine.
> 
> I checked various editors (vim, nano, cat), they are all the same.
> 
> `git log` (PAGER is set to `/usr/bin/less -ins`) shows the particular 
> commit correctly.
> 
> I tested following git version: 2.16.5, 2.19.2, 2.20.1, git.next branch.
> 
> Here's the configure output: 
> https://paste.ec/paste/oDdydNxZ#r3avan8BL+8lldFMo928cw3eXSServTsSkGPW4jRBOd
> 
> Michal
> 

