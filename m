From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH RESEND] Fix a bunch of pointer declarations (codestyle)
Date: Sat, 7 Mar 2009 12:41:14 +0200
Message-ID: <94a0d4530903070241l3ff8b13eqd05e2d149b19f218@mail.gmail.com>
References: <1235512745-26814-1-git-send-email-felipe.contreras@gmail.com>
	 <7veixnaqrn.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902250202rb12a4e7leb9856258dafc488@mail.gmail.com>
	 <7vprh64ych.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 11:44:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfu1D-00053m-SL
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 11:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbZCGKlT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 05:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbZCGKlS
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 05:41:18 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:60174 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbZCGKlR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2009 05:41:17 -0500
Received: by fxm24 with SMTP id 24so668119fxm.37
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 02:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=14RI6j3hAs0FrVMrgCWpaGlgwqBvb+V1pA2KT38x/EY=;
        b=O47oVSgNKha0YC1rqjwXJY1eeL9N/c2xafDzyr/2cb/a1yPtvrK+YV1TCcItR+0Gv8
         aDGqjBYYN2atkAknUxBbXdPqXbuybAhusOy+X+ji2ZKwVkSi9mrl2SK2oaNIpRth8rJZ
         rHFCtgF4MzAB4m7Of2skOqV/APhE6yU+UnE0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QVPt6rLIP7eWAlETcDvrCCx4V5qnk1rJ+9Joa7bwqY8SQ57ypDUbHNqp2O6AsMquU4
         KhfvyC0/+75xCLbQ5mMZMY1OWMUxatp+rvsgqHsdcm5MNEl/2LEnGK4HZClXrGrbX91i
         fIezVdzaX75WY/c6SuhslpXGOB5ND2+49pa5o=
Received: by 10.86.53.11 with SMTP id b11mr2566857fga.23.1236422474183; Sat, 
	07 Mar 2009 02:41:14 -0800 (PST)
In-Reply-To: <7vprh64ych.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112522>

On Wed, Feb 25, 2009 at 12:14 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, Feb 25, 2009 at 10:02 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>> ...
>>> Sorry, but I cannot take this as is.
>>>
>>> These trivial clean-ups are welcome either as part of a preparatory
>>> clean-up before starting to work in the area of code you are touchi=
ng, or
>>> as a standalone patch to files that nobody is currently working on.
>>>
>>> There is a huge overlap between "git diff --name-only master..pu" a=
nd the
>>> above list, so it is impossible for me to take the patch and I cann=
ot
>>> afford the time to sift through gems out of stones.
>>
>> =C2=A0It's understandable. Would there be a better time to send this=
 patch?
>> After 1.6.2, or in a different form?
>
> I've taken your smaller patches that touched only parts that nobody i=
s
> touching between 'master' and 'pu'. =C2=A0Please take that as a hint =
;-)

Sorry, where is the result of that? I can't find it.

> As a first order approximation, come up with the subset of your patch=
 that
> applies cleanly to 'master', and make sure that the same patch applie=
s
> cleanly to 'pu'. =C2=A0Remove patches to paths that have any hunk tha=
t does not
> apply and go back to 'master' to repeat the exercise.
>
> That will cover a lot of existing breakages in files that nobody else=
 is
> working on.
>
> For example, Jay has been hyperactive around anything "remote" for th=
e
> past several days. =C2=A0If you have clean-ups in the paths he touche=
s in his
> series (still in flight), you may want to coordinate with him so that=
 he
> can include your patches in the early part of his series. =C2=A0Or yo=
u wait
> until his series starts to settle down (meaning, merged to 'next'). =C2=
=A0This
> applies to anybody else's topic.

I tried to rebase the patch on top master, generated a patch and it
applies cleanly on top of both 'master' and 'pu' I didn't need to
change anything.

What am I missing?

--=20
=46elipe Contreras
