From: bill lam <cbill.lam@gmail.com>
Subject: rebase and unmerged files
Date: Thu, 4 Jun 2009 09:54:47 +0800
Message-ID: <20090604015447.GB3873@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 03:55:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC2Al-0002Mt-SD
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 03:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbZFDBzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2009 21:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbZFDBzE
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 21:55:04 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:38645 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbZFDBzC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 21:55:02 -0400
Received: by wf-out-1314.google.com with SMTP id 26so211720wfd.4
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 18:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=nR+LUrPv5Inr4FG3xP6XwGi72G44vGetii4pYix20hk=;
        b=NJarV3Ml+/jelip2dsw/yHKNEzrlmjrgKk1F84P6S2Y0cQrvfIGkMUugWBWLU/9gFz
         69Ta1LmbM7wVQZbYE+FiN2PYI8bkfoqMYAlTerphUQSpnYLjUrkdEbO77nmZ7wyDz5sw
         0Wwe81jLvLCmyPZhm5bMmUJX6+5frNOXRqtFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=EKWA4o60Lo5dcI8e3QZNTH4F6cK6Nu5Mf6wNAVBUcE2eGq7sKsdwi1yYXgoAEPoXV7
         ny7j3V/aK/NTVtR3L2oUZZzHv1uMg+pANMzw8dHa3M1l9mGDzHphHnnCVuPNjOxd9RnL
         pzJ64aP+mChwrL2PBryDHE+YzJsO0zMPx3yq4=
Received: by 10.142.246.20 with SMTP id t20mr625373wfh.232.1244080503165;
        Wed, 03 Jun 2009 18:55:03 -0700 (PDT)
Received: from localhost (pcd436058.netvigator.com [203.218.226.58])
        by mx.google.com with ESMTPS id 22sm1513521wfi.12.2009.06.03.18.54.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 18:55:02 -0700 (PDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-05-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120670>

I tried to cleanup commit mistake and use rebase -i. It stopped and
sha1 and generated a list of unmerge files.  My intention was to use
the version in sha1 but with some editing.  Since all those unmerge
files contained unresolved conflict delineated by

<<<<<<
HEAD
=3D=3D=3D=3D=3D=3D=3D
sha1
>>>>>>>

I have to manually type commands such as
git checkout sha1 -- file1
to get the version I wanted for further editing.  Is there any easier
method that can automating checkout all those sha1 version of the
unmerged files.

Also, for git-commit during rebase, should I use=20
git commit --amend
or just
git commit

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9170 =E5=B4=94=E9=A1=A5  =E9=BB=83=E9=B6=B4=E6=A8=93
    =E6=98=94=E4=BA=BA=E5=B7=B2=E4=B9=98=E9=BB=83=E9=B6=B4=E5=8E=BB  =E6=
=AD=A4=E5=9C=B0=E7=A9=BA=E9=A4=98=E9=BB=83=E9=B6=B4=E6=A8=93  =E9=BB=83=
=E9=B6=B4=E4=B8=80=E5=8E=BB=E4=B8=8D=E5=BE=A9=E8=BF=94  =E7=99=BD=E9=9B=
=B2=E5=8D=83=E8=BC=89=E7=A9=BA=E6=82=A0=E6=82=A0
    =E6=99=B4=E5=B7=9D=E6=AD=B7=E6=AD=B7=E6=BC=A2=E9=99=BD=E6=A8=B9  =E8=
=8A=B3=E8=8D=89=E8=90=8B=E8=90=8B=E9=B8=9A=E9=B5=A1=E6=B4=B2  =E6=97=A5=
=E6=9A=AE=E9=84=89=E9=97=9C=E4=BD=95=E8=99=95=E6=98=AF  =E7=85=99=E6=B3=
=A2=E6=B1=9F=E4=B8=8A=E4=BD=BF=E4=BA=BA=E6=84=81
