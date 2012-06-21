From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git on 64bit windows - state of the art?
Date: Thu, 21 Jun 2012 12:22:13 +1000
Message-ID: <CAH3AnrqRSKNgcZyYuyXSVjhaa9jzjQOEhbu_nVYt85g8FuJ9Jg@mail.gmail.com>
References: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com>
	<4FE0D02B.2040703@obry.net>
	<CAH3AnrqwUQkTAYHASgNMCTuCGFqsZUux44uhdMXGDGdJ9hV7oQ@mail.gmail.com>
	<4FE17465.4040501@obry.net>
	<CAMSUDdYxveE=FUSvSOLowVPWh7F24UtVFJr8zyc0ANhm0La6zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pascal@obry.net, Git Mailing List <git@vger.kernel.org>
To: Paul Harris <harris.pc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 04:22:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShX2L-0002EL-Mx
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 04:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757600Ab2FUCWP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jun 2012 22:22:15 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48745 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548Ab2FUCWP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2012 22:22:15 -0400
Received: by bkcji2 with SMTP id ji2so89969bkc.19
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 19:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=iKjTVKt9Wo6WCKD6ZUdMJE4BmUBn1RSio6FqutY7Sk0=;
        b=E32iJluyct6qnnN/0OiBVaehSFR3r5TII5tldCcVC/3cIDuID/Inb1dAq/0Eq13J2/
         c8+avd5ZWTmkiqjhPyaTIt6p2P9g/Cv2IMbcbw7hWxmVnvg19Dal6L+11ZMoNECrPZ3J
         X5ocM4reI4ky4XSuFC9EoYcoMXPcgXf94DQHuxM1LixHO+4fgCt0W5TJGUY7FJ7D3Uwe
         PfxRyolRDmPcUqVJFrZsC5sjuXCofHMeDaL7rxlRYsbpS4mTv29SAHqZlyOQboxmZMha
         NLtnWqh06YlN0/VrAlFecueYpHXvYk6xHqeLUxpEq6SAw1CM/gqfDtUBnBLkOUkpBDYR
         O+pw==
Received: by 10.204.152.70 with SMTP id f6mr10515703bkw.7.1340245333675; Wed,
 20 Jun 2012 19:22:13 -0700 (PDT)
Received: by 10.204.61.5 with HTTP; Wed, 20 Jun 2012 19:22:13 -0700 (PDT)
In-Reply-To: <CAMSUDdYxveE=FUSvSOLowVPWh7F24UtVFJr8zyc0ANhm0La6zA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200378>

On Thu, Jun 21, 2012 at 11:40 AM, Paul Harris <harris.pc@gmail.com> wro=
te:
>
>
> On 20 June 2012 14:57, Pascal Obry <pascal@obry.net> wrote:
>>
>> Jon,
>>
>> > Thank you. I think we have tried the -b option without much luck, =
but
>> > I don't think we have tried the -o option.
>> >
>> > I will arrange to do some testing and will post to the list in a f=
ew
>> > weeks if this looks to be a definitive solution to the problem (or
>> > otherwise)
>>
>> Ok, the most important part is running peflagsall, this was the way =
to
>> fix that properly on Win7 IIRC.
>>
>> Pascal.
>>
>
> Hello,
>
> I use git + cygwin on Win7-64 (almost) without problems. =C2=A0I have=
 used
> git-svn too (once) with success.

We do use git svn fairly heavily as part of our normal workflow and it
is git-svn that is most heavily affected by the issue. If you only use
git-svn occasionally, it is possible that you have avoided the
particular issue we are facing. For us, git-svn does tend to work
immediately after the rebase or after a fresh boot when not much is
loaded, but the reliability will be tend to degrade over time,
presumably as the 32bit address space becomes more "polluted" by the
other demands placed upon it.

>
> Perhaps Jon's is not working because rebaseall is not rebasing the
> particular binaries he is using? =C2=A0Perhaps his git svn is running=
 some
> binaries/dlls that are installed in non-standard locations? =C2=A0Can=
 that
> happen?

I don't think this is the case. All the users affected have a pretty
standard scripted cygwin install - there are no variations between
users and no special considerations for the SVN installation. We tried
some of the suggestions we found here about explicitly enumerating all
the .so and .dll files

      http://stackoverflow.com/questions/4988091/unable-to-start-solr-s=
erver-ruby-on-rails/6601464#6601464

but this didn't change the behaviour.

I suspect the flavour of anti-virus solution one has installed may be
a factor. We are using Norton Antivirus.

Another factor might be the other tools we are running (Java IDEs and
application servers) although I haven't seen any good evidence one way
or the other about whether the JVMs are actually a factor. As
mentioned above, It does seem true that time since reboot is a factor,
which is presumably related to how the 32bit address space is
"fragmented" over time by the various demands placed on it.

Thus far, Pascal's solution seems to be working, but it is a bit early
to call it a success yet - we will need several more days testing to
be sure.

jon.
