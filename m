From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] Print trace in rev-list machinery
Date: Thu, 10 Nov 2011 14:12:30 +0700
Message-ID: <1320909155-4575-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:12:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROOno-0003gW-5Z
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756284Ab1KJHLz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 02:11:55 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52849 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab1KJHLz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:11:55 -0500
Received: by ggnb2 with SMTP id b2so2626980ggn.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 23:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=2183WNcwkKDs8qyx5K0CxjdH2j5/MdEIrQ4PMAsTQ7Q=;
        b=qHvFCL8HO85WqEpIbiEjBg+5dj4CUDSgIEQ6mFx+gXppbyMJLBtMdndkdJ+7vbqO4V
         CoFocDHSqj62aLcvJE18hSH2+oqn41avw6tCcPYyPGtWETrrqx/wh6jPgtoyF2dq3YYE
         Rwf/jJK39x7YlDkFaGGeBdUCeoHm4RsVqXY1w=
Received: by 10.68.39.98 with SMTP id o2mr12207553pbk.119.1320909113297;
        Wed, 09 Nov 2011 23:11:53 -0800 (PST)
Received: from tre ([115.73.226.96])
        by mx.google.com with ESMTPS id wn14sm19299115pbb.5.2011.11.09.23.11.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 23:11:52 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 10 Nov 2011 14:12:36 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185190>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 revision.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 8764dde..0aa3638 100644
--- a/revision.c
+++ b/revision.c
@@ -1690,6 +1690,11 @@ int setup_revisions(int argc, const char **argv,=
 struct rev_info *revs, struct s
 	if (opt)
 		submodule =3D opt->submodule;
=20
+	if (argc)
+		trace_argv_printf(argv + 1, "trace: rev-list");
+	else
+		trace_printf("trace: rev-list\n");
+
 	/* First, search for "--" */
 	seen_dashdash =3D 0;
 	for (i =3D 1; i < argc; i++) {
--=20
1.7.4.74.g639db
