From: "=?utf-8?q?Jean-No=C3=ABl?= AVILA" <avila.jn@gmail.com>
Subject: Re: [PATCH] attr: fix off-by-one directory component length calculation
Date: Tue, 15 Jan 2013 20:53:58 +0100
Message-ID: <201301152053.58561.avila.jn@gmail.com>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com> <201301152014.28433.avila.jn@gmail.com> <7vwqve2qk3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 20:55:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvCbZ-0004Rv-54
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 20:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab3AOTzG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 14:55:06 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:50722 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab3AOTzE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 14:55:04 -0500
X-Greylist: delayed 2399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2013 14:54:37 EST
Received: from cayenne.localnet (unknown [82.239.31.145])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 6ABDD4B0093;
	Tue, 15 Jan 2013 20:54:01 +0100 (CET)
User-Agent: KMail/1.13.7 (Linux/3.8.0-rc3jna; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vwqve2qk3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213668>

Le mardi 15 janvier 2013 20:29:16, Junio C Hamano a =C3=A9crit :
> "Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> writes:
> > Thank you for the explanation.
> >=20
> > I did not monitor the system calls when writing that patch.
> > Where is the perf framework?
> >=20
> > As the mistake is located in the "find_basename" function, I would
> > propose a fix directly into it so that the output fits what the oth=
er
> > functions expect.
>=20
> Isn't that a crazy semantics for the function, though?  I would
> expect find_basename("/a/path/to/file") to return "file", not
> "/file".
>=20

Yes, it is. I was wrong on the meaning of basename.=20

Btw, the test 10 to t9902 is failing on my Debian testing. Is it a know=
n=20
issue?
