From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] builtin-rerere: fix conflict markers parsing
Date: Mon, 07 Jul 2008 15:55:04 +0200
Message-ID: <48722038.1010203@free.fr>
References: <1215434568-30456-1-git-send-email-dkr+ml.git@free.fr> <alpine.DEB.1.00.0807071400180.18205@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 15:55:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFrC3-0001yV-Iy
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 15:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbYGGNyy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jul 2008 09:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbYGGNyy
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 09:54:54 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:40313 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbYGGNyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 09:54:54 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 003D312B6D1;
	Mon,  7 Jul 2008 15:54:53 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 5CB6712B6C7;
	Mon,  7 Jul 2008 15:54:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.DEB.1.00.0807071400180.18205@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87608>

Johannes Schindelin a =E9crit :
>=20
> So what about
>=20
> 	<<<<<<< This hunk contains =3D=3D=3D=3D=3D
> 	anythin
> 	=3D=3D=3D=3D=3D=3D=3D
>=20
> 	Hello
> 	=3D=3D=3D=3D=3D=3D=3D
> 	somethin else
> 	>>>>>>> problem!
>=20
>=20
> If you fix it, I think you should do it properly, and analyze the ind=
ex.

If I read the code correctly, this case is not a problem at all because=
 what
is important is the content between <<< and >>> : even if you match the=
 wrong
=3D=3D=3D marker, you will match the first one only, then parsing will =
success and
preimage file will be OK. Also because we always match in the same orde=
r the
sha1 will be the same.

Anyway, I do not know how to match the right =3D=3D=3D marker.

Olivier.
