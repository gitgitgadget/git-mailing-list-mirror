From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH 2/3] sha1: clean pointer arithmetic
Date: Wed, 12 Sep 2012 22:50:30 +0200
Organization: OPTEYA
Message-ID: <1347483030.1961.13.camel@test.quest-ce.net>
References: <cover.1347442430.git.ydroneaud@opteya.com>
	 <20dce012a57900b61e51c0e0d8dfb5573693010e.1347442430.git.ydroneaud@opteya.com>
	 <7vd31rcck4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 22:50:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBttP-00023P-Pu
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 22:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab2ILUuc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Sep 2012 16:50:32 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:55782 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab2ILUub convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Sep 2012 16:50:31 -0400
Received: from [127.0.0.1] (helo=localhost)
	by mx-out.ocsa-data.net with esmtp (Exim - FreeBSD Rulez)
	id 1TBttG-0003ZE-9X; Wed, 12 Sep 2012 22:50:31 +0200
Received: from mx-out.ocsa-data.net ([127.0.0.1])
	by localhost (node2-2.ouvaton.local [127.0.0.1]) (amavisd-new, port 10028)
	with ESMTP id iy6hUWP48qjj; Wed, 12 Sep 2012 22:50:30 +0200 (CEST)
Received: from [82.233.246.172] (helo=[192.168.0.25])
	by mx-out.ocsa-data.net with esmtpsa (Exim - FreeBSD Rulez)
	id 1TBttG-0003ZA-8K; Wed, 12 Sep 2012 22:50:30 +0200
In-Reply-To: <7vd31rcck4.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.4.4 (3.4.4-1.fc17) 
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-20 required=2
	tests=[ALL_TRUSTED=-1.44]
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205335>

Le mercredi 12 septembre 2012 =C3=A0 11:37 -0700, Junio C Hamano a =C3=A9=
crit :
> Yann Droneaud <ydroneaud@opteya.com> writes:
>=20
> > One memcpy() argument is computed from a pointer added to an intege=
r:
> > eg. int + pointer. It's unusal.
> > Let's write it in the correct order: pointer + offset.
>=20
> Meh.
>=20
> Both are correct.  Aren't ctx->w[lenW] and lenW[ctx-w] both correct,
> even?
>=20

"correct" in my commit log message should be read as "the way it's used
by most C developer".

It's again a cosmetic fix.

--=20
Yann Droneaud
