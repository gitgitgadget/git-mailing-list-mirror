From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 0/2 v2] ls-tree: exit with non-zero status on error
Date: Sun, 24 Jul 2011 11:07:48 +1000
Message-ID: <1311469670-15392-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 03:08:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QknB6-0000ki-5G
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 03:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069Ab1GXBIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 21:08:05 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:57057 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab1GXBIE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 21:08:04 -0400
Received: by pzk37 with SMTP id 37so5971353pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 18:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=XhVsAbTVz1NZULeGIgAxeU+/7cQRv8It/DjcZgUlG/A=;
        b=xR6IFP9Ji4x8VcG2f3lIpHc3P7+3F8xdI3U7rj6vjEjj0fok7TDl/zye3lT5O3aZmF
         FpiDDjf3SdDL6KqPYPlaHM6BhA21XvTB63PLkwm3OYaZSn1bGvO2yoGffZTAncilK4YY
         9ASMi5p210+S+1xtlFhRu4ZZJjm2r9gOEy48c=
Received: by 10.68.6.33 with SMTP id x1mr4786826pbx.268.1311469682827;
        Sat, 23 Jul 2011 18:08:02 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id d1sm3160283pbj.72.2011.07.23.18.08.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 18:08:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g96e0b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177707>

While working with a damaged repository, I noticed that git ls-tree was reporting an error 
even though it set a zero exit code. 

This patch uses the return code from read_tree_recursive instead.

| v2: Amended test per Jens Lehmann's suggestion.

Jon Seymour (2):
  Add a test to check that git ls-tree sets non-zero exit code on
    error.
  Ensure git ls-tree exits with a non-zero exit code if
    read_tree_recursive fails.

 builtin/ls-tree.c               |    6 +++---
 t/t3103-ls-tree-missing-tree.sh |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)
 create mode 100755 t/t3103-ls-tree-missing-tree.sh

-- 
1.7.6.347.g6a5a9c
