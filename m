From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 00/12] use the $( ... ) construct for command substitution
Date: Tue, 12 Jan 2016 11:49:26 +0000
Message-ID: <1452599378-47882-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 12:49:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIxSO-0007fR-By
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 12:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759832AbcALLto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 06:49:44 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36172 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbcALLtn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 06:49:43 -0500
Received: by mail-wm0-f68.google.com with SMTP id l65so30886622wmf.3
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 03:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ziEGIbv3mYXsIZcV7+8aPuM4ixIFS73ML6v08hPmjY0=;
        b=Yc1U09LSpSR5lAGsAOkIAqjZLmD90p0ZqB68NsfBVpS4/HktJSmYGLaM7V63KtjjrP
         uQ5Wb6HgRUMMDdnd0FuX9jg9WbuMPTZbyMbhfwnvYymUzt6joor5JVbQEOtglcPhH4KQ
         CUbtYl1/WayrmT8ZuiGyb2rzb4l30GzkbP1wlHai4GRL6f8UjB2vz1ZXLAEzOUtugbGG
         QYzP2Jqep7iZRWs2br3Je4F7RMUkg1x0owpdMHulEnOp6OU0iG4VzfkG4wbM4SeFyg4b
         hrlScRXyu5G8KDvELUqLnOwdc0s1dx2nJ36WRdJAk+bWx3hntkTRNP6pn45QKHCf0WwX
         mkNQ==
X-Received: by 10.28.189.11 with SMTP id n11mr20113383wmf.3.1452599382037;
        Tue, 12 Jan 2016 03:49:42 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id k130sm3506702wmg.6.2016.01.12.03.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jan 2016 03:49:41 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.20.g4b9ab0e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283803>

This patch series continues the changes introduced with the merge
6753d8a85d543253d95184ec2faad6dc197f248:

    Merge branch 'ep/shell-command-substitution'

    Adjust shell scripts to use $(cmd) instead of `cmd`.


This is the is the ninth and final series.


*** BLURB HERE ***

Elia Pinto (12):
  t9119-git-svn-info.sh: use the $( ... ) construct for command
    substitution
  t9129-git-svn-i18n-commitencoding.sh: use the $( ... ) construct for
    command substitution
  t9130-git-svn-authors-file.sh: use the $( ... ) construct for command
    substitution
  t9132-git-svn-broken-symlink.sh: use the $( ... ) construct for
    command substitution
  t9137-git-svn-dcommit-clobber-series.sh: use the $( ... ) construct
    for command substitution
  t9138-git-svn-authors-prog.sh: use the $( ... ) construct for command
    substitution
  t9145-git-svn-master-branch.sh: use the $( ... ) construct for command
    substitution
  t9150-svk-mergetickets.sh: use the $( ... ) construct for command
    substitution
  t9300-fast-import.sh: use the $( ... ) construct for command
    substitution
  t9350-fast-export.sh: use the $( ... ) construct for command
    substitution
  t9501-gitweb-standalone-http-status.sh: use the $( ... ) construct for
    command substitution
  t9901-git-web--browse.sh: use the $( ... ) construct for command
    substitution

 t/t9119-git-svn-info.sh                   |  2 +-
 t/t9129-git-svn-i18n-commitencoding.sh    |  4 +-
 t/t9130-git-svn-authors-file.sh           | 12 +++---
 t/t9132-git-svn-broken-symlink.sh         |  4 +-
 t/t9137-git-svn-dcommit-clobber-series.sh | 24 +++++------
 t/t9138-git-svn-authors-prog.sh           |  2 +-
 t/t9145-git-svn-master-branch.sh          |  4 +-
 t/t9150-svk-mergetickets.sh               |  2 +-
 t/t9300-fast-import.sh                    | 68 +++++++++++++++----------------
 t/t9350-fast-export.sh                    |  6 +--
 t/t9501-gitweb-standalone-http-status.sh  |  6 +--
 t/t9901-git-web--browse.sh                |  2 +-
 12 files changed, 68 insertions(+), 68 deletions(-)

-- 
2.5.0
