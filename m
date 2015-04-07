From: KES <kes-kes@yandex.ua>
Subject: git diff bug? what problem may be here
Date: Tue, 07 Apr 2015 20:27:40 +0300
Message-ID: <723381428427660@web5j.yandex.ru>
References: <2396461428386674@web25m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 19:34:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfXOB-00054W-7A
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 19:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbbDGReI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2015 13:34:08 -0400
Received: from forward17j.cmail.yandex.net ([5.255.227.236]:40648 "EHLO
	forward17j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753233AbbDGReG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2015 13:34:06 -0400
Received: from web5j.yandex.ru (web5j.yandex.ru [5.45.198.46])
	by forward17j.cmail.yandex.net (Yandex) with ESMTP id 6CF4B22FF7
	for <git@vger.kernel.org>; Tue,  7 Apr 2015 20:27:41 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web5j.yandex.ru (Yandex) with ESMTP id 1D2A02680ACA;
	Tue,  7 Apr 2015 20:27:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1428427661; bh=mfGtOCdcJ7JYsTHSNb9/o3UgZbtum8DifPAJkTNrCXY=;
	h=From:To:In-Reply-To:Subject:Date;
	b=sj6GjZ0WBJK36GeccTPpxhpDshwkP43NKDOb1/Fza5VtJdM0cHwcGGKI48hiKF6eo
	 0EnnB4k8s1W75buRleSzqgSXe3GiGs4OToS7Qm3yjNCeek2iufwYeHYZnThkci7Z/d
	 VWUO7JLwsr7zvHywUpVv9nWVlTzI6awZSiYwotok=
Received: by web5j.yandex.ru with HTTP;
	Tue, 07 Apr 2015 20:27:40 +0300
In-Reply-To: <2396461428386674@web25m.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266929>

When after editing I get this:
=9Amdi.Application=3D this;

=9Amdi.Class.TApplication.baseConstructor.apply( this, arguments );

git diff shows:

=9A=9Amdi.Application=3D this;
- mdi.Class.TApplication.baseConstructor.apply( this, arguments );

- //We must not create/show application node because of this is the 'do=
cument.bo
- //It exists always so apply application properties to 'document.body'=
 only
- this.updateDomNode();
+ mdi.Class.TApplication.baseConstructor.apply( this, arguments );
=9A},{

Notice same lines:
- mdi.Class.TApplication.baseConstructor.apply( this, arguments );
+ mdi.Class.TApplication.baseConstructor.apply( this, arguments );

But when I edit like this (notice no new line between mdi.Application a=
nd mdi.Class):

=9Amdi.Application=3D this;
=9Amdi.Class.TApplication.baseConstructor.apply( this, arguments );

Git diff shows:
=9A=9Amdi.Application=3D this;
=9A=9Amdi.Class.TApplication.baseConstructor.apply( this, arguments );
-
- //We must not create/show application node because of this is the 'do=
cument.body'.
- //It exists always so apply application properties to 'document.body'=
 only
- this.updateDomNode();
=9A},{

Why new line cause same line in patch added and removed?
