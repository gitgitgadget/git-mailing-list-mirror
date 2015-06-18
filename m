From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] mergetools: add config option to disable auto-merge
Date: Wed, 17 Jun 2015 22:27:58 -0400
Message-ID: <CANoM8SWN2ZzgMP_MoDRRFA8ZjzRh724iaJ7GwrD2WddrjqwuqQ@mail.gmail.com>
References: <1434490514-36204-1-git-send-email-rappazzo@gmail.com>
 <1434490514-36204-2-git-send-email-rappazzo@gmail.com> <xmqqd20u6s2b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>, ssaasen@atlassian.com,
	john@keeping.me.uk, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 04:28:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5PZ2-0008L1-DF
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 04:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbbFRC2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 22:28:21 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36577 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbbFRC2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 22:28:19 -0400
Received: by oigb199 with SMTP id b199so6329288oig.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 19:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jhMHJM30cEOJC2EYso3sAHqWxxvLHilEWYL9t/fzaOs=;
        b=MCNvra4LCgimslJHiF5kRBXhdDHeLpJnKKdEe+ScUCUejm9+2G5tNFxkcT8gI1e+UR
         be97Sz17zoHc3AnBlUkRng49wjycagP3UUtbQBNep5W29X+k3Er4blKwIMjN/2G58wj7
         qPmMxY5s/KE7+GYjJCvlU806eeEOcoX9T/hhKxm8WZ7gEUSA6oCvFbazLVQTo68uIBMh
         jLtcE4OjB8cQ2N+Wh+M4iRi5r7Y1Tw5RyHwHhj37XKV8XncIhQW7OQTpEz7J3eCe7K28
         p7s3pZqCyxIqm6O7WHsC3BXX57pSoP7JILH9FgD0XmpLPrWsBOOfVXlhFhB4LkeIUEi2
         maaA==
X-Received: by 10.202.227.15 with SMTP id a15mr6815274oih.59.1434594498541;
 Wed, 17 Jun 2015 19:28:18 -0700 (PDT)
Received: by 10.202.174.131 with HTTP; Wed, 17 Jun 2015 19:27:58 -0700 (PDT)
In-Reply-To: <xmqqd20u6s2b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271934>

On Wed, Jun 17, 2015 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Rappazzo <rappazzo@gmail.com> writes:
>
>> For some mergetools, the current invocation of git mergetool will
>> include an auto-merge flag.  By default the flag is included, however if
>> the git config option 'merge.automerge' is set to 'false', then that
>> flag will now be omitted.
>
> ... and why is the "automerge" a bad thing that user would want to
> avoid triggering under which condition?  That description may not
> have to be in the proposed log message, but it would help users when
> they decide if they want to use the configuration to describe it in
> the mergetool.automerge configuration.
>
> And depending on the answer to the above question, a configuration
> variable may turn out be a bad mechanism to customize this (namely,
> set-and-forget configuration variable is a bad match for a knob that
> is more "per invocation" than "user taste").
>
> Is this not about "automerge" but more about "always-show-UI because
> I like GUI?"  Then that may be a "user taste" thing that is a good
> match for a configuration variable.  I simply cannot tell from what
> was in the message I am responding to.

I feel that the auto-merge takes away the context of the changes.

I use araxis merge as my mergetool of choice.  I almost always immediately
undo the auto-merge.  After taking a moment to look at each file, I will
then (usually) use the keyboard shortcut for auto-merge.

It sure would be nice to "set-and-forget" a config variable to remove the
annoyance of having to undo the auto-merge.  I think that this config
option is reasonable.  Perhaps my documentation leaves something to be
desired.  I can take another stab at it.


>
>> -TEMPORARY FILES
>> ----------------
>> -`git mergetool` creates `*.orig` backup files while resolving merges.
>> -These are safe to remove once a file has been merged and its
>> -`git mergetool` session has completed.
>> -
>> +CONFIGURATION OPTIONS
>> +---------------------
>> +mergetool.keepBackup::
>> +     `git mergetool` creates `*.orig` backup files while resolving merges.
>> +     These are safe to remove once a file has been merged and its
>> +     `git mergetool` session has completed.
>> ++
>
> This is an unrelated change; I think it is a good change, though.
>
> I however suspect that we would not want to repeat the configuration
> description in this file and instead mention these in "see also"
> section referring the readers to git-config(1).
>

I felt that adding a separate header for a different config option was more
appropriate, so I went with this.  Pointing to the config.txt doc is
probably better.
