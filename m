From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH v4 5/6] completion: calculate argument position properly
Date: Tue, 8 May 2012 14:50:30 +0200
Message-ID: <CAMP44s187xd-78SUBVnc5qrgqi+n5ft1cASM4qAgMguApF+0Wg@mail.gmail.com>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
	<1336353800-17323-6-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s3Bscm0T_=-g-wRc9kkZYZjGHGaP6hPi8598=Oh=skjxw@mail.gmail.com>
	<7v7gwn6cmv.fsf@alter.siamese.dyndns.org>
	<CAMP44s3rC6bT3rjrBFdnywwsp5NrXt54L5L-7oKZ=bNFKccq+w@mail.gmail.com>
	<7v8vh34q1w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Scott Bronson <bronson@rinspin.com>,
	Nathan Broadbent <nathan.f77@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 14:50:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRjsE-00065G-6B
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 14:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814Ab2EHMuc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 08:50:32 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60770 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab2EHMub convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 08:50:31 -0400
Received: by eeit10 with SMTP id t10so299721eei.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=T4cuf0DLQdi+dRE5CprgFj/pXq3ab/UO4DI2yLRBBZU=;
        b=w6Zem9nF+oefwKh3uHCXyCCkSsbf3ZO7RlXWS1Ovt/3FNkmBx80Fyvm3/mZ6Rq12hu
         0/7ymw+xYqDiXZnk+CQz1kyUYTyy6c74WwAopokS3Bhc5iRN/7HberOXkrzhCiCLInZG
         6oqGKJNBCZkIaswLb5ESSGMJtPjQb9yau/vF5rRPGDlF9T7EF5Hq7vtE/8hr0lNwVBZE
         jfOhd1vUjjbttT4gijwnpMpRX+jNiwAx7PB/DtxAxv7Cx9ro/BySC9RNRSyaMgG6vl/2
         khpsr/FCs3Gj2jT0tq7PmSYTtjOR6balyqsK9IvVU36ZhxoVBvQdxApwQSpeP/obj8SC
         fxrw==
Received: by 10.14.53.77 with SMTP id f53mr605949eec.107.1336481430466; Tue,
 08 May 2012 05:50:30 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Tue, 8 May 2012 05:50:30 -0700 (PDT)
In-Reply-To: <7v8vh34q1w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197357>

On Mon, May 7, 2012 at 11:52 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> Together with 4/6, I am guessing that you are using $cmd and $cmd_p=
os
>>> as a global variable to pass state to/from helper functions. Are th=
ey
>>> properly documented in code (if not, please do so)?
>>
>> Like cur, prev, words, and cwords? Wait a second... they are not
>> documented anywhere. I'm also not going to work on this... not my
>> itch.
>
> The usual thing to do is to clean up after other people's mess while =
you
> are mucking with the vicinity of them anyway, especially if you are m=
aking
> things worse by adding another.

People have different ideas of what is a mess. You think it's a mess,
I don't. Why should I clean it up?

Of course, you as a maintainer have all the right to reject my patches
because they introduce more "mess", and if I want the patch in, I am
forced to do what you say, but it just so happens that I don't care if
this goes in or not, so I have the right to don't do anything; it's my
own free time.

> And I am fully aware that it may not be your itch---otherwise I would=
n't
> have asked. =C2=A0I would have said "This needs to be fixed (or else)=
".
>
> Why is it that everybody on the list, who is working together well in=
 the
> community, seems to have trouble only when interacting with you? =C2=A0=
Please
> remember that it is not my itch to live with an unnecessarily abrasiv=
e
> behaviour from you, either.

Why am I being abrasive here? The only reason I sent these patches
was, as I said, to simplify the discussion about what would make
'alias gf' work, I did not, and I do not intent to propose these
patches for inclusion (as I know the pain (for me) that would entail).

If you would rather have me send no patches at all rather than to show
what I have (in fact I cleaned them quite a lot) and stop there, I can
do that; less work for me.

To be honest, I don't see what's the problem in sending partial stuff;
in a collaborative effort somebody else that actually has this itch
would pick these and finish the job; nothing wrong with that. Why
should it be me who finish the job? And why am I problematic if I
don't want to?

As I said, I only care about the first patch.

Cheers.

--=20
=46elipe Contreras
