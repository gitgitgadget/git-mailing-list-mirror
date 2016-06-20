Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6CC1FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 19:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbcFTTFv (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 15:05:51 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36213 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbcFTTFg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 15:05:36 -0400
Received: by mail-it0-f45.google.com with SMTP id a5so55059651ita.1
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 12:05:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NuyYVhbOXEh6ogGiLec6yv6DRgfcNiAviveEHLRD/qI=;
        b=NQnYJpx2UW+IQICQNA1I2Dzsqm30qRNyrWcKE/YHt/MJrygxUXKn151kwMCi4mcKY2
         mKJNjMyNtvM/adeTR6lpuxHBlDpD+4xgzZq1KY/7QxE0uS3CvDm4t+bd1QxAiOdD/v8H
         Gb747N9vwHT4r3J5INayLbEJ7jfq6ZqgSFdoyA2MyMHsIYjlbjCB68iYchbVedg/Wyi+
         8yYRlbaBvJ++K2jDCPv/0ZoaP4O6ZdLZqlVyTEfyRBEJ6I5EGb50RWl1jkH1cFLOu47Z
         HQTMH7gcPbNxfmtqxpn1l5lXxXAkhiZ58zv0Ap+9kZwi43vpCI15Y34w7acebJyZ3rqI
         Xong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NuyYVhbOXEh6ogGiLec6yv6DRgfcNiAviveEHLRD/qI=;
        b=U+2kpcTKpgeVAeLvMhhZVreMBNNFCqAOgp6lVrAuQnJr/9iwwCH759rakRT50a9A0F
         kgf3j+eRj0fbdObeH9NAgv35AHviY4oOsRm8MMcke9wfBKNDg9sLhmO1xe40Hc8nljSv
         nmBz26Uu9G8IK5WoJ3xFyXUKBPLWavLuzgBy210f1HDb2ESJCrD8W6Br5Zqqnu1/a7QT
         7RKnBLne3v1XPu0mWyc92ld6YqpUmMFrkAS2qBnyiw12Zsiw0zTMY2lbtul4jSHdu6v/
         bHARm8Fx41XtIUq8EZp1c/oLQ58VC5s1qrDGEvuYGbXwr4iGt4MJZRmOOE7MEDpSako1
         dRzg==
X-Gm-Message-State: ALyK8tJO3C9gRdo3QYvwn6BE07QKBsQoFaEt03uJ4pqoSE401/gJlddkyaTXBkDJaE8Zo5AyEuev51v+NL3R5A==
X-Received: by 10.36.55.15 with SMTP id r15mr1370914itr.73.1466449508229; Mon,
 20 Jun 2016 12:05:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.175.104 with HTTP; Mon, 20 Jun 2016 12:05:07 -0700 (PDT)
In-Reply-To: <CAGZ79kZL-ZY_0hZx9uA-ObPvMiD+EWvJYQa+OfCeQe2RLOPECA@mail.gmail.com>
References: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com>
 <CAGZ79kZL-ZY_0hZx9uA-ObPvMiD+EWvJYQa+OfCeQe2RLOPECA@mail.gmail.com>
From:	Norbert Kiesel <nkiesel@gmail.com>
Date:	Mon, 20 Jun 2016 12:05:07 -0700
Message-ID: <CAM+g_NtNAWpLkbErL5-BUyH_3X4rYGfZwO0o-Hfu8zyam8pw7Q@mail.gmail.com>
Subject: Re: unable to pull from remote if commit date is in the future
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hmm.  On closer inspection that commit 23c07cc that github shows with
date 2152-06-19 is already in my local branch.  I got confused because
locally it is shown with a different date: `git log -1 --format='%ci'
23c07cc` shows "2106-02-07 06:28:56 -40643156" which is invalid.

My system is running Debian unstable 64bit.  Is git using the time
rendering methods from the C library (glibc 2.22-12)?

On Mon, Jun 20, 2016 at 11:46 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Jun 20, 2016 at 11:41 AM, Norbert Kiesel <nkiesel@gmail.com> wrote:
>> Hi,
>>
>> I'm following an upstream repo on github.  Today morning I saw a new
>> commit there, but a `git pull` in my clone did not fetch it and
>> instead said "Already up-to-date.".  On closer inspection, github
>> reports commit time as 2152-06-19. The same project has some other
>> commits with commit time in the future that were fetched.  My guess is
>> that happened when those commits got a child with commit date in the
>> past.
>
> git-pull doesn't care about the commit/author date/time at all.
>
> All it takes into consideration
> is the graph structure of the commits on the local and the remote branch,
> i.e. Are there any commits on the remote branch that are not part of the local
> branch history?
>
>
>>
>> Is there any way to force git pulling that request?  (Perhaps I should
>> try to tell git that it's really 2152?)
>
> You need to see if that commit is part of the history of the
> remote branch you pulled.
>
>>
>> For the record: the faulty commit is
>> https://github.com/seandepagnier/weather_routing_pi/commit/23c07cc5d2be7ce68349f4b3719b6fa6fe90e0bf
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
