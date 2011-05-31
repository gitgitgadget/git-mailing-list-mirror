From: Tim Guirgies <lt.infiltrator@gmail.com>
Subject: gitosis asking for password
Date: Wed, 1 Jun 2011 01:49:55 +1000
Message-ID: <20110531154954.GB4483@Imperial-SSD-Overlord>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 17:50:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRRCq-0003uT-Oh
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 17:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072Ab1EaPuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 11:50:01 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41380 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab1EaPuA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 11:50:00 -0400
Received: by pwi15 with SMTP id 15so2110443pwi.19
        for <git@vger.kernel.org>; Tue, 31 May 2011 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=5ZP3wdTURk9luoVaAwKDyV/twV2SMp7WZakw/uNqUF4=;
        b=Hj9fJvHdqR7DJNAguWTfnHM+6gllt6A/0jpzHSkaAb3XLNC41ior4dteA4htvYXoIC
         a/IwQJrX0NnK7oww8piadV0nFQgjkKy3JvLliWbbYN4btZWvXcjQBY0w5c8H1+QyTmYM
         HEn4yD8CCBXFIDWz+SZJVLDeEwX75YIXulq08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=wTJUMKRDhysfxt+0K3UlQIrgO3BaPZUEecL2HH9qRaif5gkCwCgigtpGLEzi5h4hSH
         j1xuL92OKrpXSf9j/ehSenpsG2+aQvOKLZQ0a/AlhGtG8l2EAnXO7lV6pieDcoWDAS5r
         ctiDvKMosaER6xwSTG+T9RujHJ8ecuBDFx3ho=
Received: by 10.68.31.169 with SMTP id b9mr2556787pbi.207.1306857000106;
        Tue, 31 May 2011 08:50:00 -0700 (PDT)
Received: from overlord.imperial.fleet (27-32-25-138.static.tpgi.com.au [27.32.25.138])
        by mx.google.com with ESMTPS id p5sm127579pbd.76.2011.05.31.08.49.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 May 2011 08:49:59 -0700 (PDT)
Received: from tim by overlord.imperial.fleet with local (Exim 4.76)
	(envelope-from <tim@imperial-ssd-overlord>)
	id 1QRRCd-0004LU-Kx
	for git@vger.kernel.org; Wed, 01 Jun 2011 01:49:55 +1000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174808>


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi List,

I've been at this for a few days now, to no avail.  It all began when
gitosis stopped liking me, and whenever I tried to fetch from or push to
my gitosis server, it gave me a 'fatal: x does not appear to be a git
repo' error.

So, I decided to remove gitosis and start again afresh.  Following this
[1] guide, I did/got the following:


$ sudo adduser --system --shell /bin/sh --gecos 'git version control'
--group --disabled-password --home /home/gitosis gitosis
Adding system user `gitosis' (UID 119) ...
Adding new group `gitosis' (GID 128) ...
Adding new user `gitosis' (UID 119) with group `gitosis' ...
Creating home directory `/home/gitosis' ...

$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/tim/.ssh/id_rsa):=20
Created directory '/home/tim/.ssh'.
Enter passphrase (empty for no passphrase):=20
Enter same passphrase again:=20
Your identification has been saved in /home/tim/.ssh/id_rsa.
Your public key has been saved in /home/tim/.ssh/id_rsa.pub.
=2E..

$ sudo -H -u gitosis gitosis-init < /home/tim/.ssh/id_rsa.pub=20
Initialized empty Git repository in
/home/gitosis/repositories/gitosis-admin.git/
Reinitialized existing Git repository in
/home/gitosis/repositories/gitosis-admin.git/

$ git clone gitosis@overlord.imperial.fleet:gitosis-admin
Cloning into gitosis-admin...
gitosis@overlord.imperial.fleet's password:=20
Permission denied, please try again.


Of course, it's not meant to ask me for a password, and no matter what I
type, it won't work anyway, as it's disabled.

So, did I miss something?  Does anybody know some gitosis magic?


Tim


[1] http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-sec=
ure-way

--=20
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org   - against proprietary attachments

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJN5Q4iAAoJEGNoa2q+dzQW4EIP/RKQcTq2XhscgfWCZ+a6TZOE
tNjccH9PhrwsjCeP+nbtpSxxAA2Rfmx8Sx6ZJVdzsqaT1dNE/GsiqJKrYd7NhxAZ
goAawqkUJ3gs8tcXHgjVkaZNg2NzkV5keHiJqWVW9LUmAPY0/7/V7GSibR5V7A3k
KxBzmGuNffEAiGt/VLbZgBxNTIfwRBAtGadMCtqtdZ62UJpOBgZw/4OgF6QRjiXv
BcmF/hjCyNDrKeXokfXOA6bndt14GQ/9pR3nVJH3pKoir0RpN0frxjXqp3M38RM1
XHq4bVy5KYCm1zmhoNAq5tMDGeMhILCcDRsURUI+GsO6wm6eQf+lBMdm7ASuBpLy
zgv8pHaeh6q9VJKK3uSuj+Jt4EM0FKCxyKJdBuhe15dmH6stWfg9fWtFpHGhOUVn
XaBPWMzFjknd+4R8n8roaQECIgXbod+uhwwPYgyUjOMjg8hR2JxwOGOd4MxjA/05
St3lehS9fZB/AfKmoMHe/a2kR26EKWHq+B1oNNUwPvYViR3/g573WaQDhmhyDyO0
kLisgT3JEUb7uUlNhIwB6rh3i4WTYmUBL3XlCoqrK5q5dr+nL9VY5nhLSR1KtaUz
4fFh9Leql/1VmasKUdvy8ITiO1msGZB/o3Q47xN4uVdmZRwvOBItNoiUq3xeNoRv
frJbuWdVDHieZQpp0GH1
=Xopo
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
