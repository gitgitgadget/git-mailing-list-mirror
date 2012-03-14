From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Wed, 14 Mar 2012 15:47:34 +0300
Message-ID: <CAHkcotgsU6XZCTB+YKKeVMsUC2Yr5pVoc7eJpxdyH-GcxzeTVw@mail.gmail.com>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<1331288715.21444.38.camel@beez.lab.cmartin.tk>
	<4F5A4C45.7070406@xiplink.com>
	<4F5AF1A8.4050604@alum.mit.edu>
	<4F5E12A5.6030701@xiplink.com>
	<vpqzkblixmb.fsf@bauges.imag.fr>
	<20120312183725.GA2187@sigill.intra.peff.net>
	<vpqy5r44zg7.fsf@bauges.imag.fr>
	<CAHkcotg1FKxfMR4Fe9Xfo_i4nuxzXdfVWe80HZu0wQEkiXhhmA@mail.gmail.com>
	<7vbonzssap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 13:47:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7ncD-0000dz-FZ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 13:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760999Ab2CNMrg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 08:47:36 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45395 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759182Ab2CNMrf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2012 08:47:35 -0400
Received: by gghe5 with SMTP id e5so1749617ggh.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nB35Rl9AI95h7I3K8vHTxCqDf+cBCMA2+166EprEbj0=;
        b=FosXmkYXHYjBdJkiZPESz7nHTJ6zD/un3j30mZw3DGHorXKNVUN8MNZWszUL6ixW9i
         NZ6WEEpF8YyMF1lRJrKZX7yEAAvhfIETlwjeMn7o4FmFx30rphlqpRc63Pc7rtz1Hf6r
         KP8eVVJUJ36Yt7KiHMYV+l7h1XdmypyL6EgBDCV+OIDpDeoVP2DwxsqIncQtqh7mrQaQ
         UX9w4/S/ygsY5VEWc22llUDmwGV565VhbTr2EH5LnSDo2KY7OQqWrb6cqfrip6XRuQb2
         2nZbkYKrF5X92MLEpH2dwLrVfblmzAN30nftyuRxwaZza/jlq3pYHIVs+T2+soRFEry5
         zNVw==
Received: by 10.224.102.8 with SMTP id e8mr2821496qao.50.1331729255277; Wed,
 14 Mar 2012 05:47:35 -0700 (PDT)
Received: by 10.229.135.130 with HTTP; Wed, 14 Mar 2012 05:47:34 -0700 (PDT)
In-Reply-To: <7vbonzssap.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193101>

On Wed, Mar 14, 2012 at 8:46 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Dmitry Potapov <dpotapov@gmail.com> writes:
>
>>> One can easily get in this situation even in a kernel-style workflo=
w:
>>> work from your desktop, push, work from your laptop, try to push an=
d it
>>> fails.
>>
>> IMHO, when you often switch between your desktop and laptop, 'matchi=
ng'
>> makes much more sense. If 'push' fails then usually I want to force =
non-
>> fast-forward push, because the new series contain reworked patches t=
hat
>> already were on the other computer.
>
> You are free to live dangerously, but please do not teach that to oth=
er
> people.

Is it more dangerous than using "git reset --hard somewhere" ?
I believe both cases I should be able to recover the lost using reflog.
Anyway, so far I have never had any problem, because I do "git push"
first and then look at failures and decide whether I want to discard
the old series on the remote end.

> Switching between two machines A and B is done a lot more safely if y=
ou
> arrange them to cross pull from each other, i.e. on machine A, remote=
s/B/*
> is where you keep copies of branches of B to with either of these
>
> =A0 =A0 =A0 =A0machineA$ git fetch B refs/heads/*:refs/remotes/B/*
> =A0 =A0 =A0 =A0machineB$ git push A refs/heads/*:refs/remotes/B/*
>
> (the latter is to emulate the former "fetch" you wish to run on A to =
get
> data from B in the reverse direction), and similarly on machine B, yo=
u use
> remotes/A/* to keep copies of branches of A.

I am aware about that, but the thing that stops me from using this is
there is no way to delete automatically all references from the remote
end that were deleted locally. (There is --mirror option, which can do
this, but it is incompatible with refspecs)

If I use only "git fetch B ...", I can run "git remote prune B" from ti=
me
to time to remove branches that no longer exists on B. However, if I do
"git push A ..." as you suggested then A will accumulate old garabage
from B very quickly.


Dmitry
