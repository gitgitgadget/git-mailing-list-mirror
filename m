From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v3 1/5] completion: simplify __gitcomp_1
Date: Sun, 15 Apr 2012 12:09:03 +0200
Message-ID: <20120415100903.GC2900@goldbirke>
References: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
	<1334439784-6460-2-git-send-email-felipe.contreras@gmail.com>
	<87obqueyas.fsf@thomas.inf.ethz.ch>
	<CAMP44s3qXnONLh_=gO4_9DK2=bx0tLBTTAb4WenYh5k2QPQL-g@mail.gmail.com>
	<CAMP44s05KsZFAW=i7TvN0jDNPyFZ4OHkOTwVp2+04CR-jsz-nA@mail.gmail.com>
	<m2ehrpcs9u.fsf@linux-m68k.org> <20120415093334.GB2900@goldbirke>
	<m23985cokd.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 12:09:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJMOU-0004Ws-GD
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 12:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449Ab2DOKJK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Apr 2012 06:09:10 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:50277 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab2DOKJI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 06:09:08 -0400
Received: from localhost6.localdomain6 (p5B13091B.dip0.t-ipconnect.de [91.19.9.27])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0Lx0lJ-1SCyda3cMb-016igu; Sun, 15 Apr 2012 12:09:04 +0200
Content-Disposition: inline
In-Reply-To: <m23985cokd.fsf@linux-m68k.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:jaHlHilhfyVXRj1b3voPcBCDe52lYiKlb+Ds3fOOLui
 ayr5wObnt5IbLjm2fGH8jmtf8XxXPv39pY6SWGs3uqMQCUwSUy
 u7z/IQTKHI3PXRYVYp55L/1CHIaEtfz62KOAvR708apkaeQ9as
 zOJxzXknpdYzePxBuQ7SdOysMvwoRnTaErFw/EG1ZMhWL+cRn3
 gl08HqQiY3hCGtpmU+DhBRdNl6o6aHOBBGDnYR3w3+uNW1mfRD
 bVhmE/ErjsoNTYosgC5cJ8coHzLOQsMVATW/8tlt7EgsPFLnzZ
 omEbrlWQsJHe6WyBkKrdZutSkdsPKTe5O+hl8IojPctqoRTggO
 NIL5K6BO1K7aqNVN/Q/s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195554>

On Sun, Apr 15, 2012 at 11:49:22AM +0200, Andreas Schwab wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > We can even get rid of the %s with
> >
> >   printf -- "$c\n"
>=20
> Only if $c can never contain special characters.

That's a good point, branch and tag names can contain '%', so the %s
shall stay.
