From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH RESEND] spec: add missing build dependency
Date: Fri,  6 Apr 2012 15:22:30 +0300
Message-ID: <1333714950-22212-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>,
	"Pavel Roskin" <proski@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 06 14:22:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG8Bp-0006MN-GO
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 14:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756356Ab2DFMWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 08:22:48 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33737 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754839Ab2DFMWr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 08:22:47 -0400
Received: by lahj13 with SMTP id j13so2116301lah.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 05:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=IwQ1PjXepuxVtVROlBDiJxVdtBj+JcLvJjBXquDUmYo=;
        b=k1QgN2iV6KtbsjVv9XU8UM3y5T8O5fyo9cYGt8MhqVq2xFZ1wkjPh07IyFmXFqLKfp
         b217sDew/BLjBReP8dtiQRyI69Sv/O66DauT8vnEUdoypYouRRuzKZ1Cg7fQAWLzn2rY
         1bexwALZJkEfv+J+Je9gikCE/dbpRNsPCpK1U1Cf9TovQUThOZj+QrfYGOGNCZ6waDGD
         zAV5dup/mFrZePsqHF29MlVudWK7vo66unw3xGIXiCDBfwrBZGSdPm1pJQienrTMZF8n
         PVq8I6okrlL5XaVTbR1TOKJQ8zJ1UP6amSLP/upC2Uzo6jY45WM7KgDhDoOVOWVAw9lS
         a3tg==
Received: by 10.152.110.193 with SMTP id ic1mr8530555lab.4.1333714966191;
        Fri, 06 Apr 2012 05:22:46 -0700 (PDT)
Received: from localhost (80-186-93-53.elisa-mobile.fi. [80.186.93.53])
        by mx.google.com with ESMTPS id ph8sm6219464lab.15.2012.04.06.05.22.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Apr 2012 05:22:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194869>

Otherwise:

/usr/bin/perl Makefile.PL PREFIX='/opt/git' INSTALL_BASE=''
Can't locate ExtUtils/MakeMaker.pm in @INC (@INC contains: /usr/local/lib/perl5 /usr/local/share/perl5 /usr/lib/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib/perl5 /usr/share/perl5 .) at Makefile.PL line 1.
BEGIN failed--compilation aborted at Makefile.PL line 1.
make[1]: *** [perl.mak] Error 2
make: *** [perl/perl.mak] Error 2

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git.spec.in |    1 +
 1 file changed, 1 insertion(+)

diff --git a/git.spec.in b/git.spec.in
index b93df10..d61d537 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -101,6 +101,7 @@ Group:          Development/Libraries
 Requires:       git = %{version}-%{release}
 Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; echo $version))
 BuildRequires:  perl(Error)
+BuildRequires:  perl(ExtUtils::MakeMaker)
 
 %description -n perl-Git
 Perl interface to Git
-- 
1.7.9.6
