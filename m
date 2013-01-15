From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [RFC/PATCH] ignore memcmp() overreading in bsearch() callback
Date: Tue, 15 Jan 2013 21:27:36 +0100
Message-ID: <m2libunqdj.fsf@igel.home>
References: <7v38y38hhm.fsf@alter.siamese.dyndns.org>
	<50F57BDF.1050400@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:28:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvD78-0001iH-HR
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 21:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137Ab3AOU1q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 15:27:46 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:46286 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab3AOU1p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 15:27:45 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Ym35702gQz3hhwP;
	Tue, 15 Jan 2013 21:27:38 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3Ym3566Mlgzbbcj;
	Tue, 15 Jan 2013 21:27:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 1mGgjyCX91hS; Tue, 15 Jan 2013 21:27:23 +0100 (CET)
X-Auth-Info: kFZ3TUgqz8NW7rM0oRrJBRu3G8TYR02Qdc5kMW2icQI=
Received: from igel.home (ppp-88-217-114-68.dynamic.mnet-online.de [88.217.114.68])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue, 15 Jan 2013 21:27:38 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id CEDDACA026; Tue, 15 Jan 2013 21:27:37 +0100 (CET)
X-Yow: If elected, Zippy pledges to each and every American
 a 55-year-old houseboy...
In-Reply-To: <50F57BDF.1050400@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of
	"Tue, 15 Jan 2013 16:55:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213671>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> +	return '\0' - ent->name[key->len];

You need to cast to unsigned char first to make it consistent with
memcmp and strcmp.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
