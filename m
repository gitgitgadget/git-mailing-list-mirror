Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC531203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 14:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbcG0OPZ (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 10:15:25 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35792 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbcG0OPY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 10:15:24 -0400
Received: by mail-wm0-f43.google.com with SMTP id f65so215056861wmi.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 07:15:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kPJ0ZVH+zHKl8qavTgScWvkSZrykLS9e0pQKwu9Bczs=;
        b=HxT162cngA0lxZ7DhbtaHIVZa1a2h6KJLwg6ukg7kszJRTtrWEMSUXALtBWWzQMeYu
         LXFDlfvrx/Q6Y4dQ3owZa0wnh6bhc10gzo3XCdt3cIh0qZ5g2blTZt+G85gYT3oigNgN
         h/eGsW8mI+GUoiDAzB5ShxCgj+5R0/risLKJXylsGqGAXa9ZZmtVAaXyLFzhSMAeYuTl
         3my81ENBlbr9/Dr/vjJzhAIhrnxxIDsLyVFMbp3v6/PMEt0KB4FvudjGt4+12xvE04o6
         NryzNeI6XE0pMxJwHLqmPEkbdxLJLGuQxBAtE+7La6LV0GC+lxMhVmrfTwNwj8Xco3NA
         m9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kPJ0ZVH+zHKl8qavTgScWvkSZrykLS9e0pQKwu9Bczs=;
        b=UeNt+jgUHk6VEb7PzTORa9eR5TuZor048mREe84fh7TE8vdkOyNV9ipE1cry98olhb
         8kmiLW7iqJzYRj7UMkW18nz0hpehOGlGuAo8goxXjW9m/jIRMLU94hKsVXyJOgs+8e34
         0IIvMp7UIetFXzHbQfEfpBElC1cIe70dLHSZBbqUpVl8rDbmcadkp1ApGmPj13ojNQlT
         nwn6PmOlyUnbM8EKGB9WaZb+KYcqnVi0uH5Gbim0gHx0UinnyUWdwJUrY/sEXIm5rE5S
         VgVEdsnP2cUCEbZlbIQ63VZERGMfl5ke8HPn1zXiQ88onQ7jGcSY6+gVvQ7uNTmN98qB
         c1oQ==
X-Gm-Message-State: ALyK8tI/XkO/MVNMOBaAjEbBLySzCCNzqvHEodN0jwzz9G0fhhhVeelH78V8UZdnMLzdhjJGRzIp3B4xnk8SEA==
X-Received: by 10.28.163.199 with SMTP id m190mr54724096wme.5.1469628922507;
 Wed, 27 Jul 2016 07:15:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.154.134 with HTTP; Wed, 27 Jul 2016 07:15:21 -0700 (PDT)
In-Reply-To: <CAH8BJxH0_RhmDaHWBkFg6QP7WWucUtPSQfsAemdVWkTzN42MPw@mail.gmail.com>
References: <CAH8BJxGZW8eNQogksZ416sVaBkpQ78uYkV7FtN6wxGafzNwjAg@mail.gmail.com>
 <CAGZ79kaop1HB4tQAKxOcq8ZNEc+6VMPB1suwA9jra2BoXc27cw@mail.gmail.com>
 <20160726203041.GA4675@sigill.intra.peff.net> <CAH8BJxH0_RhmDaHWBkFg6QP7WWucUtPSQfsAemdVWkTzN42MPw@mail.gmail.com>
From:	Stephen Morton <stephen.c.morton@gmail.com>
Date:	Wed, 27 Jul 2016 10:15:21 -0400
Message-ID: <CAH8BJxFvyEDuj-mm=N=ca3kxysopaBpro-HsuL-HZehqE_nxDA@mail.gmail.com>
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
To:	Jeff King <peff@peff.net>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Here is my patch then. (Personally, I would add some capitalization
and punctuation, but I didn't see much of that in the existing code.)
I'm not a regular pull-requester, do I do that, or can somebody else
handle that for me?


diff --git a/sequencer.c b/sequencer.c
index cdfac82..ce06876 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -176,7 +176,8 @@ static void print_advice(int show_hint, struct
replay_opts *opts)
                else
                        advise(_("after resolving the conflicts, mark
the corrected paths\n"
                                 "with 'git add <paths>' or 'git rm <paths>'\n"
-                                "and commit the result with 'git commit'"));
+                                "then continue the %s with 'git %s
--continue'\n"
+                                "or cancel the %s operation with 'git
%s --abort'" ),  action_name(opts), action_name(opts),
action_name(opts), action_name(opts));
        }
 }


Stephen



On Tue, Jul 26, 2016 at 4:44 PM, Stephen Morton
<stephen.c.morton@gmail.com> wrote:
> On Tue, Jul 26, 2016 at 4:30 PM, Jeff King <peff@peff.net> wrote:
>> On Tue, Jul 26, 2016 at 01:18:55PM -0700, Stefan Beller wrote:
>>
>>> > Would it be possible to expand the hint message to tell users to run
>>> > 'git cherry-pick --continue'
>>>
>>> Instead of expanding I'd go for replacing?
>>>
>>> I'd say the user is tempted for 2 choices,
>>> a) aborting (for various reasons)
>>> b) fix and continue.
>>
>> Yeah, I'd agree with this.
>>
>> I think that advice comes from a time when you could only cherry-pick a
>> single commit. These days you can do several in a single run, and that's
>> why "git cherry-pick --continue" was invented.
>>
>> So I think we would need to make sure that the "cherry-pick --continue"
>> advice applies in both cases (and that we do not need to give different
>> advice depending on whether we are in a single or multiple cherry-pick).
>>
>> I did some basic tests and it _seems_ to work to use --continue in
>> either case. Probably due to 093a309 (revert: allow cherry-pick
>> --continue to commit before resuming, 2011-12-10), but I didn't dig.
>>
>> -Peff
>
> The 'git status' text for a rebase/am/cherry-pick is
>
>     fix conflicts and then run "git <op> --continue"
>     use "git <op> --skip" to skip this patch"
>     use "git <op> --abort" to cancel the <op> operation
>
> (The --cancel text varies a bit actually, but that's the gist of it.)
>
> The rebase/cherry-pick conflict case should really indicate how to
> mark the conflict as resolved as that's the specific situation the
> user is in. I don't know if there are guidelines to hint line length,
> or how many actions should be on one line but if the above text was
> changed to have this as the "fix" text, possibly over two lines, I
> think that would do it.
>
>     fix conflicts with 'git add <paths>' or 'git rm <paths>'" and then
> run "git <op> --continue"
>
> Stephen
