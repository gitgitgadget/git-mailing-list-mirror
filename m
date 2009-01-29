From: bill lam <cbill.lam@gmail.com>
Subject: how to clean up remote/ref
Date: Thu, 29 Jan 2009 23:42:17 +0800
Message-ID: <20090129154217.GA9435@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 16:44:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSZ3c-00087P-7r
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 16:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbZA2Pm0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jan 2009 10:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbZA2Pm0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 10:42:26 -0500
Received: from po-out-1718.google.com ([72.14.252.152]:56232 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbZA2PmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 10:42:25 -0500
Received: by po-out-1718.google.com with SMTP id c31so1893418poi.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 07:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=wWJTivxx3Xr0b+YMleyCariUyTmDUNMUk0fYoAonmLc=;
        b=JiZadEGWwaAQqxVPvgvA/VyBbfPSVkorXWl4h3z/Smhyv/rUHpEhGBNptGBtGZCxuO
         m4PsxEH3/201srFhayBNmE/9yM/g+J0hWKAk7JO0IA/DfVeFoCxWm+d7gfHqR+bllV29
         9eVtDF9CbdCl8o/hYNjxpojcPb/SO11mtU1xU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=DER8D3fePRb/vpqXYRSJYhh5H+2aRH55HZNUXn6LVl7t1b+Q9ZryAy9aEoxSzAVndt
         smUPK9wtRu8C/d2xDfVkyhY2jkfdsRWMa66CxjMyxEuh5NiFBT4qVhRpL8GTX7ezYWb5
         DdGUAUJLD7MuBBOzXOWRt0gF1mCTj0MBsV2Ac=
Received: by 10.110.50.19 with SMTP id x19mr16415tix.12.1233243743666;
        Thu, 29 Jan 2009 07:42:23 -0800 (PST)
Received: from localhost (n219077019016.netvigator.com [219.77.19.16])
        by mx.google.com with ESMTPS id u8sm3857283tia.28.2009.01.29.07.42.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Jan 2009 07:42:22 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107695>

When I migrated from svn to git, I keep updating svn repo and also
added a dummy git repo, Now the GIT_DIR/config look likes

[core]
	repositoryformatversion =3D 0
	filemode =3D true
	bare =3D false
	logallrefupdates =3D true
[svn-remote "svn"]
  url =3D http://localhost/svn/project2/
  fetch =3D :refs/remotes/trunk
[remote "origin"]
	url =3D http://bl@localhost/git-repo/project/
	fetch =3D +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote =3D origin
	merge =3D refs/heads/master

Now I feel I don't need update the svn repo (actually it was inactive
for more than 1 year after a few updates).  Also I no longer want to
use http protocol to remote git repo.  =20

It said the HEAD is different that orgin/master

$ git checkout master
Switched to branch "master"
Your branch and 'origin/master' have diverged,
and have 71 and 24 different commit(s) each, respectively.

How do it
1. remove any reference to the svn repo [svn-remote "svn"]
2. remove reference to the http [remote "origin"]
3. setup a new empty git as the new remote repos

thanks

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9277 =E6=9F=B3=E4=B8=AD=E5=BA=B8  =E5=BE=81=E4=BA=BA=E6=
=80=A8
    =E6=AD=B2=E6=AD=B2=E9=87=91=E6=B2=B3=E5=BE=A9=E7=8E=89=E9=97=9C  =E6=
=9C=9D=E6=9C=9D=E9=A6=AC=E7=AD=96=E8=88=87=E5=88=80=E7=92=B0  =E4=B8=89=
=E6=98=A5=E7=99=BD=E9=9B=AA=E6=AD=B8=E9=9D=92=E5=A1=9A  =E8=90=AC=E9=87=
=8C=E9=BB=83=E6=B2=B3=E7=B9=9E=E9=BB=91=E5=B1=B1
