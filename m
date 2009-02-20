From: bill lam <cbill.lam@gmail.com>
Subject: pre-commit hook
Date: Fri, 20 Feb 2009 17:11:27 +0800
Message-ID: <20090220091127.GA7415@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 10:13:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaRRc-0000Cx-35
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 10:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbZBTJLm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2009 04:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbZBTJLl
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 04:11:41 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:33242 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbZBTJLj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 04:11:39 -0500
Received: by ti-out-0910.google.com with SMTP id d10so577522tib.23
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 01:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Wt/FjpvQuSYJOKQHdnSu5Kyb8QbHXIk75jiPWr2Vxis=;
        b=Z+E1SCsQ9DhkYy+AleASqy9D/Kmv3Fgzkel9WRNOQMLeWiXdORXCVdfjhhRxCGZ8xW
         8E8Ylr3YAn//frnlgLRAs3v6aT1xC37CWJiqCfIKFCA+BmaHIpokBZaaVngnAEF5SvrV
         EkBq105L1ELJL3RgNQEAHY+hXaTbMS+E9A3xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=JSCpxxD64fW02nDqx3rQolvpGjhOdVBkcDa6PwZxNvva9HifbJNpaqOomC5x4z3+vB
         R6P03kuNJDM/ZKUHruSWo0N/BI+ZeKwyabZrmjVvwl+CTiaRiZRIRL2iwVSlO8tSbuKf
         5dR/BVwvEMeGBcENyzB9SSa/I4lHr8cQGseak=
Received: by 10.110.8.5 with SMTP id 5mr771109tih.44.1235121097392;
        Fri, 20 Feb 2009 01:11:37 -0800 (PST)
Received: from localhost (pcd431208.netvigator.com [203.218.221.208])
        by mx.google.com with ESMTPS id i9sm69382tid.13.2009.02.20.01.11.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 01:11:36 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110824>

The pre-commit hooks as follows.

 10 # This is slightly modified from Andrew Morton's Perfect Patch.
 11 # Lines you introduce should not have trailing whitespace.
 12 # Also check for an indentation that has SP before a TAB.
 13=20
 14 if git-rev-parse --verify HEAD 2>/dev/null
 15 then
 16   git-diff-index -p -M --cached HEAD --
 17 else
 18   # NEEDSWORK: we should produce a diff with an empty tree here
 19   # if we want to do the same verification for the initial import.
 20   :                                                                =
                                                       =20
 21 fi |
 22 perl -e '

Will it also include binary files and thus corrupt data? And
"git-rev-parse" should already deprecated.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9232 =E5=AD=9F=E6=B5=A9=E7=84=B6  =E6=98=A5=E6=9B=89
    =E6=98=A5=E7=9C=A0=E4=B8=8D=E8=A6=BA=E6=9B=89  =E8=99=95=E8=99=95=E8=
=81=9E=E5=95=BC=E9=B3=A5  =E5=A4=9C=E4=BE=86=E9=A2=A8=E9=9B=A8=E8=81=B2=
  =E8=8A=B1=E8=90=BD=E7=9F=A5=E5=A4=9A=E5=B0=91
