From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 7/9] patch-id: change default to stable
Date: Thu, 24 Apr 2014 12:31:10 +0300
Message-ID: <1398331809-11309-7-git-send-email-mst@redhat.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 12:20:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdGlN-0007FX-UF
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 12:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453AbaDXKUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 06:20:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9025 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755191AbaDXKTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 06:19:09 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3OAIg2L001985
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 24 Apr 2014 06:18:44 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s3O9UOXQ030451;
	Thu, 24 Apr 2014 05:30:24 -0400
Content-Disposition: inline
In-Reply-To: <1398331809-11309-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246959>

--stable has been the default in 'next' for a few weeks with no ill
effects.
Change the default to that so that users don't have to remember to
enable it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 builtin/patch-id.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 037cf2f..0b267af 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -198,9 +198,9 @@ int cmd_patch_id(int argc, const char **argv, const char *prefix)
 
 	git_config(git_patch_id_config, &stable);
 
-	/* If nothing is set, default to unstable. */
+	/* If nothing is set, default to stable. */
 	if (stable < 0)
-		stable = 0;
+		stable = 1;
 
 	if (argc == 2 && !strcmp(argv[1], "--stable"))
 		stable = 1;
-- 
MST
