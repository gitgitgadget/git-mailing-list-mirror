From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 16/16] remote: deprecate read_{branches,remotes}_file
Date: Fri, 21 Jun 2013 16:42:40 +0530
Message-ID: <1371813160-4200-17-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzKY-0003kx-I9
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415Ab3FULQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:34 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:50984 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030412Ab3FULQc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:32 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so7582664pbc.26
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=R0olAOxlrCvhoPTOUJknJ78pDRsi4XZz4/Cw0JcM1RM=;
        b=tp5C9db+MYR1smzpL/eEXP6nC+ss8kZ/tpp/x6aKpi791teCIcoZOT8o5hotX53apj
         Ivvh+NDdbWdAvQGcsnjRGY7MM2396sSnF6s2GPy7UqUOANVUllpvhuH88WPgbVHToLGZ
         IIx7aQ1M2L0qY7xw3ymmqkjS5eRuq9XTi2jnVXlbFuJBCPaZ3IDP/3VRFbuiRV1/jXAa
         3foSIEoIk/6HvdcXxl2i21zNH4zSbL8Ucb+f9LNCPH1qvqmu3KDNbZHW/cptZ4fjSxWt
         mU/8wUzdbXbnn7xtcl/ZPtyupN18G7PSbToEMVqXCTJb0HpXa6C6FkNmoEbkfXpdlgLf
         Wxrg==
X-Received: by 10.68.163.165 with SMTP id yj5mr11923655pbb.141.1371813391803;
        Fri, 21 Jun 2013 04:16:31 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.16.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228606>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 remote.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/remote.c b/remote.c
index 128b210..b487865 100644
--- a/remote.c
+++ b/remote.c
@@ -227,6 +227,10 @@ static void add_instead_of(struct rewrite *rewrite, const char *instead_of)
 	rewrite->instead_of_nr++;
 }
 
+/*
+ * Deprecated; provided for backward compatibility with ancient
+ * repositories.  Modern Git does not encourage their use.
+ */
 static void read_remotes_file(struct remote *remote)
 {
 	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
@@ -274,6 +278,10 @@ static void read_remotes_file(struct remote *remote)
 	fclose(f);
 }
 
+/*
+ * Deprecated; provided for backward compatibility with ancient
+ * repositories.  Modern Git does not encourage their use.
+ */
 static void read_branches_file(struct remote *remote)
 {
 	char *frag;
-- 
1.8.3.1.499.g7ad3486.dirty
