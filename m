From: Bruno Vieira <mail@bmpvieira.com>
Subject: [PATCH] builtin/merge.c: add the merge.verifysignatures config option
Date: Wed, 22 Apr 2015 01:13:54 +0100
Message-ID: <1429661634-45033-1-git-send-email-mail@bmpvieira.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 02:15:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkiJb-00051s-Pl
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 02:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965303AbbDVAOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 20:14:46 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:34130 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964887AbbDVAOp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 20:14:45 -0400
Received: by wgso17 with SMTP id o17so230277022wgs.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 17:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id;
        bh=Pi9t/Hzd6BTIoI+6me6z374RhdEfIHdCSPgDO7Nqrkc=;
        b=trqMTtOt/DhgE/kH4Ilme/S5cV21U8wxbIZ3Z890lnsEkd6RKDI4hlV9EsAjazlVp2
         uB1eCZFdCX3qeUzRfTLgiSF+nc7N+03jzBnc8AuXQfqFp3y/UoGc+hQ0LyITeyg/kHqz
         vrMqXLVr5LdKAl+bVZdTXnjCSYm0G5DdVdOFzgVcNa8hLJf1xbFTEREoOfKJ58xkPYDS
         XPKOfThoVsAtEkgWvRmCh/2bc3S9JyviWZWq1coyRhugd4lR0+9g8E0KmG3yAqdgO0cE
         oJfJrBV0va02Z6hlu4PZ5VAeJ66s3ICkREyI1DnGcF7+xw6izWkA5HRIF5MOkq9LloMo
         XDAQ==
X-Received: by 10.180.84.201 with SMTP id b9mr896684wiz.49.1429661684187;
        Tue, 21 Apr 2015 17:14:44 -0700 (PDT)
Received: from localhost.localdomain ([109.175.188.0])
        by mx.google.com with ESMTPSA id gj7sm21857918wib.4.2015.04.21.17.14.42
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Apr 2015 17:14:43 -0700 (PDT)
X-Mailer: git-send-email 2.3.2 (Apple Git-55)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267575>

Signed-off-by: Bruno Vieira <mail@bmpvieira.com>
---
This seemed to be missing. Sorry if otherwise or if I'm doing something wrong (first time contributing).

 builtin/merge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 3b0f8f9..5dbc10f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -598,6 +598,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	} else if (!strcmp(k, "merge.defaulttoupstream")) {
 		default_to_upstream = git_config_bool(k, v);
 		return 0;
+	} else if (!strcmp(k, "merge.verifysignatures")) {
+		verify_signatures = git_config_bool(k, v);
+		return 0;
 	} else if (!strcmp(k, "commit.gpgsign")) {
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
-- 
2.3.2 (Apple Git-55)
