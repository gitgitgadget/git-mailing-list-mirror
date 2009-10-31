From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 23:42:47 -0200
Message-ID: <55bacdd30910301842m77cf5d7fi8389e305fd439a72@mail.gmail.com>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com> 
	<7vljisk1m7.fsf@alter.siamese.dyndns.org> <7viqdwilx2.fsf@alter.siamese.dyndns.org> 
	<55bacdd30910301520h2678d0c2hd8478716d8ce4a17@mail.gmail.com> 
	<7v4opgh5qr.fsf@alter.siamese.dyndns.org> <55bacdd30910301612xabe2071i1319d920191f080f@mail.gmail.com> 
	<7vocnoe83m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 02:43:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N42zt-0000M2-KT
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 02:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757610AbZJaBnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 21:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757607AbZJaBnD
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 21:43:03 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:39201 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757605AbZJaBnC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 21:43:02 -0400
Received: by yxe17 with SMTP id 17so3228431yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 18:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lnqAejpAkqigq2EfllqTIyOJp1iDW1HifOjCQoExtRI=;
        b=XCOFaRRgCv5bCSimkaSxnQCLZ/2nfuBWpUJcYdEuHFbDuKyl0sxLKszPKL7M8++Gwu
         6Js+oJ5TVAfvb6fLdhSwTTDC0g9xhEtglqjsWkLxirud4UmWwnDRxHwRwiem4NgzE0Qa
         galFloeMlUuje1QY2i9VhxUF9+r0aUYtx7v8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Fvc6ARkAMMZOeE4H3MWO5gmcgY34Xtdarg9AJDixA8svVaA/jawmV+VxAuRk/GDG9K
         wH1iy5DUw27IpJwlS/+GSD8BH/jcBeTVM8D9GMvh0/QjPSfaHfo2yv5zjJOmhLsFSB+I
         2wm/NqW5dnguuZv34t6MTDGKZs7zllBFPWi+c=
Received: by 10.151.2.5 with SMTP id e5mr4254847ybi.114.1256953387125; Fri, 30 
	Oct 2009 18:43:07 -0700 (PDT)
In-Reply-To: <7vocnoe83m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131822>

You are completely right.

All your concern is relevant and the whole problem must be re-engineere=
d.

The good news is that I have almost finished it and I will be starting
a new thread with the new solution in a few minutes.

Regards

2009/10/30 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>> I don't see a use for comparing the author and committer because I c=
an
>> use as template my own commits or others'.
>
> You _can_ use whichever irrelevant commit as a template, but "you _ca=
n_"
> is different from what it means, and what is and what is not _sensibl=
e_.
>
> You may be rewriting somebody else's patch (e.g. fixing up a typo in =
the
> message, or changing the implementation, or both). =C2=A0If you are g=
oing to
> keep the authorship, you are saying that "it is still _his_ code, not
> mine". =C2=A0In such a case, it never makes sense to change the times=
tamp, if
> that author is somebody other than you. =C2=A0After all that other gu=
y may not
> even be aware of what you are doing when you make this commit; he may=
 be
> in bed sound asleep in a different timezone.
>
> In another scenario, if your fix-up is very significant, even if you
> started from somebody else's patch, you may want to say "now this is =
my
> patch, the original author may have given me some inspiration, but th=
e
> changes in this commit, including all the bugs, are mine". =C2=A0The =
same
> applies if you looked at the problem description of somebody' patch, =
and
> did your own solution without using anything from his commit.
>
> At that point, you would want the resulting commit to say it was writ=
ten
> by you at this moment. =C2=A0You do not want to see -c/-C/--amend to =
retain any
> part of the authorship (not just timestamp) from the original commit.
>
> =C2=A0 =C2=A0Side note. You may be fixing your own patch, in which ca=
se you may or
> =C2=A0 =C2=A0may not consider your change significant, but at the tim=
e of either
> =C2=A0 =C2=A0old timestamp or current time, you were working on this =
change, so
> =C2=A0 =C2=A0using the current timestamp instead of using the old one=
 is not a big
> =C2=A0 =C2=A0deal, and that is why I think committer=3D=3Dauthor may =
be a good
> =C2=A0 =C2=A0heuristic when deciding to touch or not touch the timest=
amp.
>
> =C2=A0 =C2=A0But in general I do not like such dwim that depends on w=
ho you are (it
> =C2=A0 =C2=A0makes it harder to explain, even if the end result may b=
e useful in
> =C2=A0 =C2=A0practice), so I'd rather not to see such a code for this=
 topic if we
> =C2=A0 =C2=A0can avoid it.
>
> In short, I do not think it makes sense to change only the timestamp =
while
> keeping the author. =C2=A0The issue is not "timestamp behaviour" with=
 "use new
> timestamp" option, but rather is an ability to declare "Now this is a
> commit made _by me_ and _now_; iow, I take authorship for this change=
",
> even when you reuse the commit log message from somewhere else.
>
> So what is needed is an option to tell -c/-C/--amend to reuse _only_ =
the
> message but no authorship information from the original commit, I thi=
nk.
>
