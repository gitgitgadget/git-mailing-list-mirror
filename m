From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 10/22] config.c: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:47 +0000
Message-ID: <1455194339-859-11-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:40:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXQ-0008N9-Pe
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbcBKMja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:30 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35620 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbcBKMj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:26 -0500
Received: by mail-wm0-f65.google.com with SMTP id g62so10464224wme.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vFvRjN7hCJOJRLpA8n7k745t0K4tiLg5VatjuT/G7rg=;
        b=FMJ1XSKfaV87scb6ZB9z6RMGW/zaPYQps8A1hqKgzJKnHw8H2nyTUjq9FyBK4qkp1b
         8HZcJcyvDDQu+pXVFqqGekoCbVjY6m+PgX0qpp9guiyUSnE8AszRJe72fUnPj+B3qfXz
         sfHy9Ya0Ighm4IvLFpUhFZLqaHyGdKmZcQ78mxMnufgOwpVPJm4buzljSAO7syl9xyfZ
         Yj9zuwECPzjTxWa0id6FCNgzmDsu2e0GXtXWSdIwtCb1a293CwN9N0yqQBJFBQy8arqf
         33Q72wkLTZcIMa4NxJnj852d6ME84oNQXFk0MfFaqsxbHV+2GQmafVrMz7pKpucu/FBr
         h/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vFvRjN7hCJOJRLpA8n7k745t0K4tiLg5VatjuT/G7rg=;
        b=SB0wfXehUvfgJxvdOp2+LRXmR33wA1X6M/mESz2/ndBJXHIKd+Az4bOMvfZztc4bf5
         so9PjBmqWqBT/bdemNE2RIroZDpxeXETETY/+xA+Mvh01b0vwI5NSOrHEHhQIRRDBcwm
         W1sVTRhFcIQA+Hxjrp7ulV9qmD9ZAgDY8u8mX9ZTFEDmE/ONbaEVjapm5oFsy7jeRKOw
         acEEHqH46N1vYDqtkYhEpgkftfVcg13o+t7sbevjRZREDqwcbCswBlU5XtLGFoASH62n
         s94aU06NNoQfShNqXIs7hm31aPFvbVtBkIQAXhrfaeJhyDQAbQ1Y0pg4umrMq/i9U1kX
         qcsA==
X-Gm-Message-State: AG10YOT8vSw7tGCVn3n8XiXcYzJjiH4yLhuEb6e5czIv4TOqlaCa3SwXjuaxX863UbaBKA==
X-Received: by 10.28.229.201 with SMTP id c192mr17788993wmh.103.1455194365497;
        Thu, 11 Feb 2016 04:39:25 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:25 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285971>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 86a5eb2..671bfd3 100644
--- a/config.c
+++ b/config.c
@@ -1604,7 +1604,7 @@ void git_die_config_linenr(const char *key, const char *filename, int linenr)
 		    key, filename, linenr);
 }
 
-NORETURN __attribute__((format(printf, 2, 3)))
+NORETURN FORMATPRINTF(2,3)
 void git_die_config(const char *key, const char *err, ...)
 {
 	const struct string_list *values;
-- 
2.5.0
