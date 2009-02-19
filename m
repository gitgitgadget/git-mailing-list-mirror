From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] rev-list: estimate number of bisection step left
Date: Thu, 19 Feb 2009 06:32:49 +0100
Message-ID: <200902190632.50156.chriscool@tuxfamily.org>
References: <20090217060944.488184b0.chriscool@tuxfamily.org> <7vljs58qul.fsf@gitster.siamese.dyndns.org> <200902190616.18747.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Tapsell <johnflux@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 06:35:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La1Yr-0000Yv-UB
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 06:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbZBSFde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2009 00:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbZBSFde
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 00:33:34 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:59823 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbZBSFdd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 00:33:33 -0500
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 35323D48062;
	Thu, 19 Feb 2009 06:33:23 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 5084AD480CB;
	Thu, 19 Feb 2009 06:33:21 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200902190616.18747.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110629>

Le jeudi 19 f=E9vrier 2009, Christian Couder a =E9crit :
>
> But on Linux, log2 and exp2 are defined in "math.h" and available wit=
h:
>
> _XOPEN_SOURCE >=3D 600 || _ISOC99_SOURCE; or cc -std=3Dc99
>
> and we must link with -lm, but I don't know about the other platforms=
=2E
>
> So I don't know what to do about them. Please advise.

What I mean is that log2 is just something like:

int log2 =3D 0;

for (; n > 1; n >>=3D 1)
	log2++;

and exp2 is just "1 << n", so I wonder if it's really necessary to add =
a lot=20
of stuff in the Makefile for these 2 really short functions.

Regards,
Christian.
