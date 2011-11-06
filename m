From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 3/3] grep: get rid of useless x < 0 comparison on an enum member
Date: Sun, 06 Nov 2011 16:03:23 +0100
Message-ID: <m2pqh5nvic.fsf@igel.home>
References: <1320581184-4557-1-git-send-email-avarab@gmail.com>
	<1320581184-4557-4-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 16:03:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN4G7-0006K3-Ic
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 16:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab1KFPDc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 10:03:32 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:35024 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab1KFPDb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 10:03:31 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id F2C471C1D9E9;
	Sun,  6 Nov 2011 16:03:25 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id ED9FE1C001A0;
	Sun,  6 Nov 2011 16:03:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id Ftzgw0Y+TejK; Sun,  6 Nov 2011 16:03:25 +0100 (CET)
Received: from igel.home (ppp-93-104-146-255.dynamic.mnet-online.de [93.104.146.255])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sun,  6 Nov 2011 16:03:24 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 6E0AECA29C; Sun,  6 Nov 2011 16:03:24 +0100 (CET)
X-Yow: You were s'posed to laugh!
In-Reply-To: <1320581184-4557-4-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 6 Nov
 2011 13:06:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184915>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Remove an "p->field < 0" comparison in grep.c that'll always be
> false. In this case "p" is a "grep_pat" where "field" is defined as:
>
> 	enum grep_header_field field;
>
> And grep_header_field is in turn defined as:
>
>     enum grep_header_field {
>     	GREP_HEADER_AUTHOR =3D 0,
>     	GREP_HEADER_COMMITTER
>     };
>
> Meaning that this comparison will always be false.

The underlying integer type is implementation-defined, and can be any
signed or unsigned integer type that can represent all enumerations.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
