From: Gabor Bernat <bernat@primeranks.net>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Tue, 22 Sep 2015 17:53:05 +0200
Message-ID: <CANy2qHcy=UD8xBeGVqGuEHVAgEvCSejt4LXk=vtpfQGSRkTg7g@mail.gmail.com>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
 <1441633928-18035-1-git-send-email-bernat@primeranks.net> <CAPig+cRRMUhWwxAgVHKpMMne7XiOuYGTi_zgQMB=A+XNGUzLqQ@mail.gmail.com>
 <xmqqsi6o95r7.fsf@gitster.mtv.corp.google.com> <CAPig+cS7ObsWjqbLytCKp1PGF+224TYhC734dNa_HXYQ7p+GgQ@mail.gmail.com>
 <xmqq6133a6tf.fsf@gitster.mtv.corp.google.com> <CAPig+cRnVzRoyKOzPSJZd4JK_hB+_CBn0kjg4yYv=wWb-5vf7w@mail.gmail.com>
 <CALYJoz3xoiB2pVT+r0Nz+EYdE91WX6ypdmieMs1uubg=Vs4bog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mikael Magnusson <mikachu@gmail.com>, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, Michael Witten <mfwitten@gmail.com>
To: =?UTF-8?B?R8OhYm9yIEJlcm7DoXQ=?= <gabor.bernat@gravityrd.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 17:54:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZePtO-00088m-Re
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 17:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933512AbbIVPx5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2015 11:53:57 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38804 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933357AbbIVPx1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2015 11:53:27 -0400
Received: by wiclk2 with SMTP id lk2so30826291wic.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=fpkmqI63jiHmD9Vb1CiOMwI9gcCoZQD6GqGMZ4NXQ5U=;
        b=WWxhwQPNAYp0U9SEUyZYL2vJgWjGRl5LWVUPP7AZojsNsDBfuFu2F95+nVZKmqehsp
         CfijbEzP73YDFZG9g7uz469m8j+kGt+RHzdsFagyfwvRBf+23t0X/g6ucxJVZz8lu4GT
         UPzPsBnA1Ylkj9BRh1FAiURf+h0mj7XS/yQomQx3PmRJ/5/3KaXOFJgZhAG6Gkh8Sxb1
         LF+XsSbHDIlOqeNUjIy6LpaolfD4tNBXgKoVOC9EUr5exRS8xYG0VH8+p2V3ySYER0VP
         cw3dXSfJGS6ejMLUHrYrmLTUF+MUCZs0T50xY7Wkb4mRkPZ820DUq1DNd6IXEj3H/3SZ
         v69w==
X-Received: by 10.194.90.47 with SMTP id bt15mr7810975wjb.18.1442937204859;
 Tue, 22 Sep 2015 08:53:24 -0700 (PDT)
Received: by 10.194.72.134 with HTTP; Tue, 22 Sep 2015 08:53:05 -0700 (PDT)
In-Reply-To: <CALYJoz3xoiB2pVT+r0Nz+EYdE91WX6ypdmieMs1uubg=Vs4bog@mail.gmail.com>
X-Google-Sender-Auth: NjL8m00_EBbbAdF2DiZi-D4Zhxs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278395>

On Mon, Sep 21, 2015 at 11:24 PM, G=C3=A1bor Bern=C3=A1t
<gabor.bernat@gravityrd.com> wrote:
> On Mon, Sep 21, 2015 at 11:22 PM, Eric Sunshine <sunshine@sunshineco.=
com>
> wrote:
>>
>> On Mon, Sep 21, 2015 at 3:52 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> > Eric Sunshine <sunshine@sunshineco.com> writes:
>> >> On Tue, Sep 8, 2015 at 1:32 PM, Junio C Hamano <gitster@pobox.com=
>
>> >> wrote:
>> >>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> >>>> On Mon, Sep 7, 2015 at 9:52 AM, G=C3=A1bor Bern=C3=A1t <bernat@=
primeranks.net>
>> >>>> wrote:
>> >>>>...
>> >>>>>  # Rewrite the commits
>> >>>>> +report_progress ()
>> >>>>> +{
>> >>>>> +if test -n "$progress"
>> >>>>> +then
>> >>>>
>> >>>> Indent code within the function...
>> >>>
>> >>>>> +printf "\rRewrite $commit
>> >>>>> ($git_filter_branch__commit_count/$commits)$progress"
>> >>>>
>> >>>> The "\r" causes this status line to be overwritten each time th=
rough,
>> >>>> and since the processed commit count always increases, we know =
that
>> >>>> the original (without ETA) will never leave junk at the end of =
the
>> >>>> line. However, with estimated seconds also being displayed, doe=
s this
>> >>>> still hold?
>> >>>
>> >>> Good point.
>> >>> Perhaps like this squashed in?
>> >>>
>> >>> -printf "\rRewrite $commit
>> >>> ($git_filter_branch__commit_count/$commits)$progress"
>> >>> + printf "\rRewrite $commit
>> >>> ($git_filter_branch__commit_count/$commits)$progress "
>> >>
>> >> Yes, for an expedient "fix", this is what I had in mind, although=
 I
>> >> would also have added an equal number of backspaces (\b) followin=
g the
>> >> spaces, as a minor aesthetic improvement.
>> >
>> > This topic seems to have stalled.  I do not want to discard topics
>> > because that means all the effort we spent to review and polish th=
e
>> > patch so far gets wasted, but we cannot leave unfinished topics
>> > linger for too long.
>> >
>> > For now, I'll queue this SQUASH??? on top as a minimum fix (renami=
ng
>> > of variables and other things noticed during the review may be wor=
th
>> > doing, but they are not as grave as the issues this fixes, which a=
re
>> > show stoppers).
>>
>> Looks like a reasonable squash for moving this topic forward. Thanks=
=2E
>>
>> > I do not think our in-core progress code does that (and we do not
>> > use ESC[0K either), so I'll leave it out of the minimum fix.
>> >
>> > diff --git a/git-filter-branch.sh b/git-filter-branch.sh
>> > index 565144a..71102d5 100755
>> > --- a/git-filter-branch.sh
>> > +++ b/git-filter-branch.sh
>> > @@ -277,9 +277,8 @@ test $commits -eq 0 && die "Found nothing to
>> > rewrite"
>> >  # Rewrite the commits
>> >  report_progress ()
>> >  {
>> > -if test -n "$progress"
>> > -then
>> > -       if test $git_filter_branch__commit_count -gt $next_sample_=
at
>> > +       if test -n "$progress" &&
>> > +               test $git_filter_branch__commit_count -gt
>> > $next_sample_at
>> >         then
>> >                 now_timestamp=3D$(date +%s)
>> >                 elapsed_seconds=3D$(($now_timestamp - $start_times=
tamp))
>> > @@ -292,8 +291,7 @@ then
>> >                 fi
>> >                 progress=3D" ($elapsed_seconds seconds passed, rem=
aining
>> > $remaining_second predicted)"
>> >         fi
>> > -fi
>> > -printf "\rRewrite $commit
>> > ($git_filter_branch__commit_count/$commits)$progress"
>> > +       printf "\rRewrite $commit
>> > ($git_filter_branch__commit_count/$commits)$progress    "
>> >  }
>> >
>> >  git_filter_branch__commit_count=3D0
>> > --
>> > 2.6.0-rc2-220-gd6fe230
>
>
> Agreed, :) did not abandoned this, just got caught up with many stuff=
=2E
> Thanks for the help,
>

So do I need to do anything else with this? :)
