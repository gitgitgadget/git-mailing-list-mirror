Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7957F1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 21:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfAPVgK (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 16:36:10 -0500
Received: from mx-out2.startmail.com ([145.131.90.155]:59571 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbfAPVgK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 16:36:10 -0500
Subject: Re: Broken interactive rebase text after some UTF-8 characters
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1547674566;
        bh=3RUB8BwXgUXDx3wZzyfTHzcwhWgCLpmruYqKn9ZRf34=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=DqXLhXGg8rgZHImT3KQoKtk6GZTuIzjwK3Ey1ysONqmS9ds1BeyihvRXFCsDilCDk
         +xmLoQLSJV/ebesu46cSRDNQHYcug0RmajQnKt6o2ucrpcMY7qrcrq39kFALRy0UUw
         nwzky0T0uv5jWBXcVoIyiJmbNQBSsVF29/N2yOo/v72lFNQtKGP96ZcrcOMeMJSAeU
         WdZp45uF4c0vuO0l+fJzlwnWAlyZ7mIhXi+59Ngw0kBtEliiMdr0Rb/JTnHUeqje9x
         qBAWmwhIQbrYKbu46r1gE08d0TX67D7DLL6REkSWY8gDhfqDjnyfC0xiP9K+ktlX/b
         Rac6S7SG220xg==
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <a50734d9-4d30-5847-b5df-67a8458a36cb@startmail.com>
 <339d4dbd-b1bd-cf88-12b0-2af42f35ded7@talktalk.net>
From:   Michal Nowak <mnowak@startmail.com>
Message-ID: <23c60f2f-43ff-94ec-6100-861c655ec80b@startmail.com>
Date:   Wed, 16 Jan 2019 22:36:04 +0100
Mime-Version: 1.0
In-Reply-To: <339d4dbd-b1bd-cf88-12b0-2af42f35ded7@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Phillip, thanks for reaching out.

This is what I see with your suggested command:


$ GIT_SEQUENCE_EDITOR=cat git rebase -i 
08487eea68a2fa501b5042131c6db068089f82e1
hint: Waiting for your editor to close the file... pick 1ea94c756c 10202 
loader: use screen-#rows to find bottom left co-ordinates Reviewed by: 
Toomas Soome <tsoome@me.com> Reviewed by: Gergő Mihály Doma 
<domag02@gmail.com> Approved by: Robert Mustacchi <rm@joyent.com>
p
pick cadd68ea00 10078 smatch fixes for UCB Reviewed by: Andy Fiddaman 
<omnios@citrus-it.net> Reviewed by: Toomas Soome <tsoome@me.com> 
Reviewed by: Peter Tribble <peter.tribble@gmail.com> Approved by: Robert 
Mustacchi <rm@joyent.com>
pick 05ede3db5e 10079 smatch Makefile changes for usr/src/lib Reviewed 
by: Andy Fiddaman <andy@omniosce.org> Approved by: Robert Mustacchi 
<rm@joyent.com>
pick 5661bb7641 10080 smatch Makefile changes for usr/src/cmd Reviewed 
by: Andy Fiddaman <andy@omniosce.org> Approved by: Robert Mustacchi 
<rm@joyent.com>
pick 15c07adc1c 10081 smatch indenting fixes for usr/src/uts Reviewed 
by: Toomas Soome <tsoome@me.com> Reviewed by: Peter Tribble 
<peter.tribble@gmail.com> Reviewed by: Andy Fiddaman <andy@omniosce.org> 
Approved by: Robert Mustacchi <rm@joyent.com>
pick c653bb4713 10197 build smatch in parallel Reviewed by: Andy 
Fiddaman <andy@omniosce.org> Approved by: Robert Mustacchi <rm@joyent.com>

# Rebase 08487eea68..c653bb4713 onto 08487eea68 (6 commands)
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
error: missing arguments for pick
error: invalid line 2: p
You can fix this with 'git rebase --edit-todo' and then run 'git rebase 
--continue'.
Or you can abort the rebase with 'git rebase --abort'.


Let me know, if there's anything I can try myself to gather more 
information. Should you want to reproduce this on OpenIndiana on your 
own, Vagrant is the more straightforward way to deploy OpenIndiana.

Thanks,
Michal

On 01/16/19 11:33 AM, Phillip Wood wrote:
> Dear Michal
> 
> Thanks for the bug report, unfortunately I'm unable to reproduce it here 
> using git 2.20.1 (see below). Knowing a little about how the todo list 
> is created I cannot think how multibyte characters would break it. What 
> command line were you using to start the rebase?
> 
> Best Wishes
> 
> Phillip
> 
> $ git clone --shallow-since='11-1-2019' 
> https://github.com/illumos/illumos-gate.git
> Cloning into 'illumos-gate'...
> remote: Enumerating objects: 54348, done.
> remote: Counting objects: 100% (54348/54348), done.
> remote: Compressing objects: 100% (39008/39008), done.
> remote: Total 54348 (delta 19671), reused 31187 (delta 11884), 
> pack-reused 0
> Receiving objects: 100% (54348/54348), 148.91 MiB | 1.18 MiB/s, done.
> Resolving deltas: 100% (19671/19671), done.
> Checking out files: 100% (47352/47352), done.
> 
> $ cd ~/src/illumos-gate
> $ git log --oneline -1
> f482e26c (HEAD -> master, origin/master, origin/HEAD) 10233 dboot: 
> process_module() is missing newline at the end of the string Reviewed 
> by: Sebastian Wiedenroth <wiedi@frubar.net> Reviewed by: Jason King 
> <jbk@joyent.com> Reviewed by: Andy Stormont 
> <astormont@racktopsystems.com> Approved by: Robert Mustacchi 
> <rm@joyent.com>
> 
> $ GIT_SEQUENCE_EDITOR=cat git rebase -i 
> 08487eea68a2fa501b5042131c6db068089f82e1
> 
> hint: Waiting for your editor to close the file...
> pick 1ea94c75 10202 loader: use screen-#rows to find bottom left 
> co-ordinates Reviewed by: Toomas Soome <tsoome@me.com> Reviewed by: 
> Gergő Mihály Doma <domag02@gmail.com> Approved by: Robert Mustacchi 
> <rm@joyent.com>
> pick cadd68ea 10078 smatch fixes for UCB Reviewed by: Andy Fiddaman 
> <omnios@citrus-it.net> Reviewed by: Toomas Soome <tsoome@me.com> 
> Reviewed by: Peter Tribble <peter.tribble@gmail.com> Approved by: Robert 
> Mustacchi <rm@joyent.com>
> pick 05ede3db 10079 smatch Makefile changes for usr/src/lib Reviewed by: 
> Andy Fiddaman <andy@omniosce.org> Approved by: Robert Mustacchi 
> <rm@joyent.com>
> pick 5661bb76 10080 smatch Makefile changes for usr/src/cmd Reviewed by: 
> Andy Fiddaman <andy@omniosce.org> Approved by: Robert Mustacchi 
> <rm@joyent.com>
> pick 15c07adc 10081 smatch indenting fixes for usr/src/uts Reviewed by: 
> Toomas Soome <tsoome@me.com> Reviewed by: Peter Tribble 
> <peter.tribble@gmail.com> Reviewed by: Andy Fiddaman <andy@omniosce.org> 
> Approved by: Robert Mustacchi <rm@joyent.com>
> pick c653bb47 10197 build smatch in parallel Reviewed by: Andy Fiddaman 
> <andy@omniosce.org> Approved by: Robert Mustacchi <rm@joyent.com>
> pick 161294fe 10217 mdb: r9w isn't r8w 10218 CONV_CAP_VAL_HW2_BUFSIZE 
> wasn't updated 10219 AV_386_2_AVX512VPOPCDQ elfcap name should be 
> consistent Reviewed by: Dan McDonald <danmcd@joyent.com> Reviewed by: 
> Rob Johnston <rob.johnston@joyent.com> Reviewed by: Patrick Mooney 
> <patrick.mooney@joyent.com> Reviewed by: Andy Fiddaman 
> <andy@omniosce.org> Approved by: Dan McDonald <danmcd@joyent.com>
> pick f482e26c 10233 dboot: process_module() is missing newline at the 
> end of the string Reviewed by: Sebastian Wiedenroth <wiedi@frubar.net> 
> Reviewed by: Jason King <jbk@joyent.com> Reviewed by: Andy Stormont 
> <astormont@racktopsystems.com> Approved by: Robert Mustacchi 
> <rm@joyent.com>
> 
> # Rebase 08487eea..f482e26c onto 08487eea (8 commands)
> #
> # Commands:
> # p, pick <commit> = use commit
> # r, reword <commit> = use commit, but edit the commit message
> # e, edit <commit> = use commit, but stop for amending
> # s, squash <commit> = use commit, but meld into previous commit
> # f, fixup <commit> = like "squash", but discard this commit's log message
> # x, exec <command> = run command (the rest of the line) using shell
> # b, break = stop here (continue rebase later with 'git rebase --continue')
> # d, drop <commit> = remove commit
> # l, label <label> = label current HEAD with a name
> # t, reset <label> = reset HEAD to a label
> # m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
> # .       create a merge commit using the original merge commit's
> # .       message (or the oneline, if no original merge commit was
> # .       specified). Use -c <commit> to reword the commit message.
> #
> # These lines can be re-ordered; they are executed from top to bottom.
> #
> # If you remove a line here THAT COMMIT WILL BE LOST.
> #
> # However, if you remove everything, the rebase will be aborted.
> #
> # Note that empty commits are commented out
> Successfully rebased and updated refs/heads/master.
> 
> 
> On 15/01/2019 19:29, Michal Nowak wrote:
>> Hello,
>>
>> on OpenIndiana 2018.10 (illumos kernel) line of the interactive rebase 
>> text after a particular name (Gergő Mihály Doma) is broken:
>>
>> pick 1ea94c756c 10202 loader: use screen-#rows to find bottom left 
>> co-ordinates Reviewed by: Toomas Soome <tsoome@me.com> Reviewed by: 
>> Gergő Mihály Doma <domag02@gmail.com> Approved by: Robert Mustacchi 
>> <rm@joyent.com>
>> p
>> pick cadd68ea00 10078 smatch fixes for UCB Reviewed by: Andy Fiddaman 
>> <omnios@citrus-it.net> Reviewed by: Toomas Soome <tsoome@me.com> 
>> Reviewed by: Peter Tribble <peter.tribble@gmail.com> Approved by: 
>> Robert Mustacchi <rm@joyent.com>
>>
>>
>> Source: https://github.com/illumos/illumos-gate.git
>>
>> See the second item which only has "p".
>>
>> This is with LC_ALL=en_US.UTF-8 (same with cs_CZ.UTF-8), with LC_ALL=C 
>> the text is fine.
>>
>> I checked various editors (vim, nano, cat), they are all the same.
>>
>> `git log` (PAGER is set to `/usr/bin/less -ins`) shows the particular 
>> commit correctly.
>>
>> I tested following git version: 2.16.5, 2.19.2, 2.20.1, git.next branch.
>>
>> Here's the configure output: 
>> https://paste.ec/paste/oDdydNxZ#r3avan8BL+8lldFMo928cw3eXSServTsSkGPW4jRBOd 
>>
>>
>> Michal
>>
> 
