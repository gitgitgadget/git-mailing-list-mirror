From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 4/4] Don't link with libsocket in MINGW port
Date: Wed, 30 May 2007 14:01:26 +0200
Organization: eudaptics software gmbh
Message-ID: <465D6796.27B65043@eudaptics.com>
References: <11804928354163-git-send-email-pclouds@gmail.com>
	 <11804928381837-git-send-email-pclouds@gmail.com>
	 <1180492840102-git-send-email-pclouds@gmail.com>
	 <11804928463543-git-send-email-pclouds@gmail.com> <1180492848275-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 14:00:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtMr3-0005Cy-Dr
	for gcvg-git@gmane.org; Wed, 30 May 2007 14:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbXE3MAc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 30 May 2007 08:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbXE3MAc
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 08:00:32 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:29113 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbXE3MAb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2007 08:00:31 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.44)
	id 1HtMqq-0003k1-JO; Wed, 30 May 2007 14:00:29 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 381054E9; Wed, 30 May 2007 14:00:28 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.043
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48753>

"Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy" wrote:
>=20
> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>=20
> There is a check in configure.ac to determine if libc has function
> socket(). It is used to link with libsocket on SunOS.
>=20
> On Windows, libc does not have socket() as well but it is provided
> by winsock, not libsocket. So don't link with libsocket if you are
> on Windows.

>  ifdef NEEDS_SOCKET
> +ifndef MINGW
>         EXTLIBS +=3D -lsocket
>  endif
> +endif

This looks wrong. NEEDS_SOCKET is set in the architecture sections of
Makefile where necessary, but the MinGW section doesn't want it and
doesn't set it. If ./configure sets it, then you should fix
configure.ac, not work around in Makefile.

-- Hannes

PS: Appologies for the mangled name - this MUA is from the stone age.
