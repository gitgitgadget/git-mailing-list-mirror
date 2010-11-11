From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 11/11] git instaweb: enable remote_heads
Date: Thu, 11 Nov 2010 13:26:18 +0100
Message-ID: <1289478378-15604-12-git-send-email-giuseppe.bilotta@gmail.com>
References: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 13:28:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWG1-0000sF-Vk
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603Ab0KKM1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 07:27:08 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57901 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575Ab0KKM1C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 07:27:02 -0500
Received: by mail-ww0-f44.google.com with SMTP id 29so64691wwb.1
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Uvh3m/sDG+WgMP72IAQZGhukr0uODDCvT3SbFgpIuYc=;
        b=Ncw8i7ATgh2qRvpWEBIQ5J+bwz24YDRasQx8p+FaBO6OOpSQcuwlng1MQf0rJPJsxu
         sCpkIgWV2MVmf1pPZnJrG+jPqo9UI60GxIOwZI//Tu1SYYN6nqQlicTNboRzWTuKiD6Y
         dRuoBj5IvBz4YWAb+GZ8+tFPQWkFEHFw+7UGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bkJ1Fmv5umdFl2+SuSALVmhIdlxRyFK1mxuQbUd6SGiwDCrYl6ym2cIrd2Vo8+xWbz
         B7p2nYkDvhWAziHNxJidV/cRPYR8YyXvp2QJglhjRg2udLLphh4j+KNxq+zOghmDM4S8
         xYKA943u1bBx5v/PY0GdR/tamt6BS7cjPjox0=
Received: by 10.216.50.134 with SMTP id z6mr774465web.15.1289478421633;
        Thu, 11 Nov 2010 04:27:01 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id l51sm1244851wer.2.2010.11.11.04.26.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 04:27:00 -0800 (PST)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161241>

When using git instaweb to browse a local repository, performance is
much less of an issue, and providing as much information as possible has
a higher priority, so it makes sense to enable remote_heads.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-instaweb.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index e6f6ecd..10fcebb 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -580,6 +580,8 @@ gitweb_conf() {
 our \$projectroot = "$(dirname "$fqgitdir")";
 our \$git_temp = "$fqgitdir/gitweb/tmp";
 our \$projects_list = \$projectroot;
+
+\$feature{'remote_heads'}{'default'} = [1];
 EOF
 }
 
-- 
1.7.3.68.g6ec8
