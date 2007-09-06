From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/3] archive: specfile syntax change: "$Format:%PLCHLDR$"
 instead of just "%PLCHLDR"
Date: Thu, 06 Sep 2007 22:53:15 +0200
Message-ID: <46E068BB.5080202@lsrfire.ath.cx>
References: <46DC4D45.4030208@lsrfire.ath.cx> <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org> <46DCF0EF.9020604@op5.se> <Pine.LNX.4.64.0709041139140.28586@racer.site> <46DDE69C.1080908@lsrfire.ath.cx> <7vzm02klip.fsf@gitster.siamese.dyndns.org> <46E028B9.2090908@lsrfire.ath.cx> <Pine.LNX.4.64.0709061803590.28586@racer.site> <46E0647A.10000@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 22:53:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITOLx-0001go-Jf
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 22:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758054AbXIFUxX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 16:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757629AbXIFUxX
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 16:53:23 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:40753
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757426AbXIFUxW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 16:53:22 -0400
Received: from [10.0.1.201] (p508EC468.dip.t-dialin.net [80.142.196.104])
	by neapel230.server4you.de (Postfix) with ESMTP id B36A6873B5;
	Thu,  6 Sep 2007 22:53:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46E0647A.10000@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57929>

Ren=C3=A9 Scharfe schrieb:
> Johannes Schindelin schrieb:
>>> +
>>> +		b =3D memchr(a, '$', len);
>>> +		if (!b || a + len < b + 9 || memcmp(b + 1, "Format:", 7))
>>> +			break;
>> Wouldn't memmem(buffer, len, "$Format:", 8) be better here?
>=20
> Oh, that's a nice GNU extension, didn't know it before.  We might imp=
ort
> it to compat etc., but I think that's better left for a follow-up pat=
ch.

Just noticed: if the memcmp() above finds a difference, the code should
*not* break out of the loop.  Ahem.  Perhaps I should first add memmem(=
)
after all...

Ren=C3=A9
