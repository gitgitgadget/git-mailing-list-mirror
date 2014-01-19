From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH/WIP v2 02/14] read-cache: new extension to mark what file is watched
Date: Sun, 19 Jan 2014 18:06:16 +0100
Message-ID: <87fvojewaf.fsf@thomasrast.ch>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
	<1389952060-12297-1-git-send-email-pclouds@gmail.com>
	<1389952060-12297-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 18:06:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4vpI-0003z4-1e
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 18:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbaASRGV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Jan 2014 12:06:21 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:53182 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbaASRGT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jan 2014 12:06:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 092584D65A0;
	Sun, 19 Jan 2014 18:06:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gtqFRnBdEP9Y; Sun, 19 Jan 2014 18:06:18 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (unknown [213.55.184.196])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id EB9744D6572;
	Sun, 19 Jan 2014 18:06:17 +0100 (CET)
In-Reply-To: <1389952060-12297-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 17
 Jan 2014 16:47:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240696>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> If an entry is "watched", git lets an external program decide if the
> entry is modified or not. It's more like --assume-unchanged, but
> designed to be controlled by machine.
>
> We are running out of on-disk ce_flags, so instead of extending
> on-disk entry format again, "watched" flags are in-core only and
> stored as extension instead.

I wonder if this would be a good use-case for EWAH bitmaps?  Presumably
most users would end up having only a few large ranges of files that ar=
e
being watched.  Quite possibly most users would watch *all* files.

--=20
Thomas Rast
tr@thomasrast.ch
