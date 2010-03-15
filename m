From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH RFC] cherry: support --abbrev option
Date: Tue, 16 Mar 2010 00:16:59 +0100
Message-ID: <4B9EBFEB.5070108@lsrfire.ath.cx>
References: <1268668999-4188-1-git-send-email-kusmabite@gmail.com>	 <4B9E69A4.2080304@lsrfire.ath.cx> <40aa078e1003151530y19f10bf1l852a0e5230b11cb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 16 00:17:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrJX9-0002Lg-7M
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 00:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937127Ab0COXRI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 19:17:08 -0400
Received: from india601.server4you.de ([85.25.151.105]:55118 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410Ab0COXRG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 19:17:06 -0400
Received: from [10.0.1.100] (p57B7CEE7.dip.t-dialin.net [87.183.206.231])
	by india601.server4you.de (Postfix) with ESMTPSA id 611D32F804E;
	Tue, 16 Mar 2010 00:17:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <40aa078e1003151530y19f10bf1l852a0e5230b11cb6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142272>

Am 15.03.2010 23:30, schrieb Erik Faye-Lund:
> On Mon, Mar 15, 2010 at 6:08 PM, Ren=E9 Scharfe
>> If I use --no-abbrev, do I get 0 or 40 hash chars?  I didn't actuall=
y
>> test it, but I suspect an "if (!abbrev) abbrev =3D 40;" is needed so=
mewhere.
>=20
> "abbrev" is initialized to 40 when declared, so you get the same
> behavior as before by default.

Yes, but --no-abbrev sets it to zero.  Which is OK, though, as I found
out after actually testing your patch this time.  A closer look at
find_unique_abbrev() in sha1_name.c reveals that the function returns
the full hash if len is either 40 or 0.

So you could initialize abbrev to zero and avoid the magic constant 40
there altogether.  (Is this still nitpicking or already bikeshedding? ;=
)

Ren=E9
