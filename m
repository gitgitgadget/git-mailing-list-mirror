Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59BD51FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 04:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbdBIEgX (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 23:36:23 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:35699 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdBIEgU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 23:36:20 -0500
Received: by mail-ot0-f169.google.com with SMTP id 65so4626368otq.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 20:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enterprisedb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JB/xG44D6SVdjQRy55S4xZwSBjHSYra0WZdEB5KbMX0=;
        b=WPljeyP2GTdC6SZ6xH8F2aqXF9684FL+dAQUDscUMqEuCtoXmgmZLn+MFilud0Jszs
         KxcY72GAk28/LudOg35GvNFp+dFULEqc1WKbKR2uZY/YWNFHGqDpFZPcJqoPOxGM9aag
         CCj2A1U8OHWU3gZiQRTovaO2QZ3fbTJwRIO6McxhEpNYJLYLdA6ujATbB4X/TSUx0HgW
         ZBZeerhF4L5JQZegmRE+Cl80zstvzuIuJRhTXXT/btzQlJ5aJ4BgZvxxLILizW9IPoki
         7qZjfV9SbYzLQazHg6LHLBBAq8yPg+NuUX1M94AbGSIinBlBLV+uZ2olGi+KmHHooKko
         +5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JB/xG44D6SVdjQRy55S4xZwSBjHSYra0WZdEB5KbMX0=;
        b=kNI3IO5iHP/+eVzB00Kry8qpZvmzkHQe8n3qy86hZHfSX5OR+2umgjcMn4qp/aZ8kO
         6qDFt4p4I8cDKERGuT+005BfqCCSsYgWCZyoWJuCs8EXQF9Gik87FfM0SUg7ZldH8GBK
         41E4PZgrfGR7w+9m55639AAAqNy/kiUoDJgufZ9K6FA4yVBbwnyHRaHp9Oi7ujxxjhpg
         UEIEbWnW6Y5wmPxi2jblQCCxCkEGNs3a9fowSo8eNaPL73m/+kvOCfrFl9N3/RcOcaPo
         CZGRkU/khQcj6FCuADtSlxkQ4ZDwCxIWDGiA579tmE0DWOSGsNr+pI3Nlhg4JRiIq1hh
         zZyQ==
X-Gm-Message-State: AMke39nGiNRXRGtHIFMUotmy5rydEpvschPdbXZMsYQIvHckKG2Fy+FBgnlHQ5DkhrreeCgPpCkYPNYuMDuMGHTR
X-Received: by 10.157.9.214 with SMTP id 22mr571864otz.128.1486613179968; Wed,
 08 Feb 2017 20:06:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.226.168 with HTTP; Wed, 8 Feb 2017 20:06:19 -0800 (PST)
In-Reply-To: <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com>
References: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com>
 <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com>
From:   Ashutosh Bapat <ashutosh.bapat@enterprisedb.com>
Date:   Thu, 9 Feb 2017 09:36:19 +0530
Message-ID: <CAFjFpReXnchHGFiTKU1UjjPhpCNVA1jVPbTD9s_JPB_R9xVt1Q@mail.gmail.com>
Subject: Re: Bug with fixup and autosquash
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 4:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ashutosh Bapat <ashutosh.bapat@enterprisedb.com> writes:
>
>> I have been using git rebase heavily these days and seem to have found a bug.
>>
>> If there are two commit messages which have same prefix e.g.
>> yyyyyy This is prefix
>> xxxxxx This is prefix and message
>>
>> xxxxxx comitted before yyyyyy
>>
>> Now I commit a fixup to yyyyyy using git commit --fixup yyyyyy
>> zzzzzz fixup! This is prefix
>>
>> When I run git rebase -i --autosquash, the script it shows me looks like
>> pick xxxxxx This is prefix and message
>> fixup zzzzzz fixup! This is prefix
>> pick yyyyyy This is prefix
>>
>> I think the correct order is
>> pick xxxxxx This is prefix and message
>> pick yyyyyy This is prefix
>> fixup zzzzzz fixup! This is prefix
>>
>> Is that right?
>
> Because "commit" pretends as if it took the exact commit object name
> to be fixed up (after all, it accepts "yyyyyy" that is a name of the
> commit object), it would be nice if the fixup is applied to that
> exact commit, even if you had many commits that share exactly the
> same title (i.e. not just shared prefix).
>
> Unfortunately, "rebase -i --autosquash" reorders the entries by
> identifying the commit by its title, and it goes with prefix match
> so that fix-up commits created without using --fixup option but
> manually records the title's prefix substring can also work.
>
> We could argue that the logic should notice that there is one exact
> match and another non-exact prefix match and favor the former, and
> certainly such a change would make your made-up example (you didn't
> actually have a commit whose title is literally "This is prefix")
> above work better.

This is a "real life situation" I ended up with yesterday. I can't
share exact commit message here so redacted it, keeping its essence. I
executed git rebase -i --autosquash and got into a conflict merge
since the fixup was applied after wrong commit. I had to execute git
rebase --abort and git rebase -i --autosquash. That's when I noticed
what's gone wrong.

>
> But I am not sure if adding such heuristics would really help in
> general.  It would not help those whose commits are mostly titled
> ultra-vaguely, like "fix", "bugfix", "docfix", etc.
>
> Another possibility is to teach "commit --fixup" to cast exact
> commit object name in stone.  That certainly would solve your
> immediate problem, but it has a grave negative impact when the user
> rebases the same topic many times (which happens often).
>
> For example, I may have a series of commits A and B, notice that A
> could be done a bit better and have "fixup A" on top, build a new
> commit C on it, and then realize that the next step (i.e. D) would
> need support from a newer codebase than where I started (i.e. A^).
>
> At that point, I would have a 4-commit series (A, B, "fixup A", and
> C), and I would rebase them on top of something newer.  I am
> undecided if that "fixup A" is really an improvement or unnecessary,
> when I do this, but I do know that I want to build the series on top
> of a different commit.  So I do rebase without --autosquash (I would
> probably rebase without --interactive for this one).
>
> Then I keep working and add a new commit D on top.  After all that,
> I would have a more-or-less completed series and would be ready to
> re-assess the whole series.  I perhaps decide that "fixup A" is
> really an improvement.  And then I would "rebase -i" to squash the
> fix-up into A.
>
> But notice that at this point, what we are calling A has different
> object name than the original A the fixup was written for, because
> we rebased once on top of a newer codebase.  That commit can still
> be identified by its title, but not with its original commit object
> name.
>
> I think that is why "commit --fixup <commit>" turns the commit
> object name (your "yyyyyy") into a string (your "This is prefix")
> and that is a reasonable design decision [*1*].
>
> So from that point of view, if we were to address your issue, it
> should happen in "rebase -i --autosquash" side, not "commit --fixup"
> side.

I agree with this analysis.

-- 
Best Wishes,
Ashutosh Bapat
EnterpriseDB Corporation
The Postgres Database Company
