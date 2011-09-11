From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: "git archive" seems to be broken wrt zip files
Date: Sun, 11 Sep 2011 17:38:59 +0200
Message-ID: <4E6CD613.9020303@lsrfire.ath.cx>
References: <CA+55aFx43OxExGNrJs+AyKNtdr+KCZZoE=iaQTz8uHoUSrQv0w@mail.gmail.com> <20110911062206.GA29620@sigill.intra.peff.net> <20110911062740.GA8018@sigill.intra.peff.net> <m239g3i5kz.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 17:39:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2m7n-0003yJ-Pm
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 17:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab1IKPjJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Sep 2011 11:39:09 -0400
Received: from india601.server4you.de ([85.25.151.105]:53362 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab1IKPjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 11:39:08 -0400
Received: from [192.168.2.104] (p4FFD8F06.dip.t-dialin.net [79.253.143.6])
	by india601.server4you.de (Postfix) with ESMTPSA id 99A902F8034;
	Sun, 11 Sep 2011 17:39:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <m239g3i5kz.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181174>

Am 11.09.2011 15:14, schrieb Andreas Schwab:
> Jeff King <peff@peff.net> writes:
>=20
>> IOW, the zip file looks right. I wonder if this is actually a bug in
>> "unzip".
>=20
> It is.  This only happens if you have more then 16k entries and when =
one
> of the 16k entry infos is reused it happend to be previously used for=
 a
> symlink entry.
>=20
> Here's a patch for unzip60 for reference:

Oh, thanks, now I can stop scratching my head while trying to find my
way around unzip's source and its amazing OS compatibility code.

On Windows (the main target for ZIP file support in git archive), 7-Zip=
,
the unzip from msysgit and the native ZIP support extract the archive
without any issues (except for 13 files whose names only differ
upper/lower case of some chars to 13 other files), by the way.  Since
they lack symlink support, the target path of
arch/microblaze/boot/dts/system.dts is simply written to a regular file=
,
though.

Ren=E9
