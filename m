Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F640374E6
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4xrgiaA"
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35039258D
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 13:54:57 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40837ebba42so876215e9.0
        for <git@vger.kernel.org>; Wed, 08 Nov 2023 13:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699480495; x=1700085295; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=buQbKCwz842m7z8MB0Ld5qStXxihZbRPlaTUPZFTIG8=;
        b=f4xrgiaAGyGnO6F61tUGhzDh09qSknHrQXp7VlK3hKpwBrc6oDb+Y6TKivO6dKqtpO
         mcYyYLEcrUyi0/N5YUyIQ1pxM+GU7yPwX3TO+zIwB8MEA9HKYp+O1KVksSutWH81UKUs
         vgaoM+9indVDYFbf0kGdsqT+BHKH7M754204UOkCb0WABjNyN9s1a+zdUNGNnIbprIrj
         AkjmKHtG390QE0fT97vQHGbquWM0iqshnxu/svBfvhmwXF/Wgv2OqWpgkhSuEuY5dCmZ
         WlvEfXHxDirpo/C1AMJ0O984+Zags80xcasjQm78q/n0KUnSG0hW7XrUF0Y9VGjNohWK
         y5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699480495; x=1700085295;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buQbKCwz842m7z8MB0Ld5qStXxihZbRPlaTUPZFTIG8=;
        b=FVK3hR8BIC1rBbUqJVP12v9FPxj5rFbgokZLHbtIN4xW7scqdOYIm6LVFq37eYbs8e
         huwH3E/m0RcpKKJXluvDWwu9gRSOoHcSo63v4rSbHxYE2EoGdc6UkVIBKtW5WdH5PREX
         FOKvauGe8Epvcl4OzRUpy/KxtVE0jR0Q/HVV1AoArwdS7updf4oKppEgBH+0MHf+KXTU
         M872pwJj/4mWme+fBJ6LzBa8R/fh//Aaxjpv5p2gTPeotl9D6QxHpDxim7y6XC7PpRxW
         VDc0r2Mj6M2CopZtuZgQOgSWUCVNAzlHCtUdRs/OjAqxFcfnh0y7B0tQ9+1NVjGF4EtI
         aVNQ==
X-Gm-Message-State: AOJu0YwAFZMVUxrWW2oRRyU0wbT9mO+MKcVb+6tEjHMAQVVqub0yZXni
	Me8DvlJAcO9pUc/fKA0zrz2cjW6S26I=
X-Google-Smtp-Source: AGHT+IFtcfHnmM9LN6RL/EOoEZ0Yx8PmoLNYEGte2PjaQVZdGdrjbXu/IZDUBA8T/WdjCVaWZ0uAag==
X-Received: by 2002:a05:600c:4fc9:b0:408:434c:dae7 with SMTP id o9-20020a05600c4fc900b00408434cdae7mr3225741wmq.2.1699480495252;
        Wed, 08 Nov 2023 13:54:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e1-20020a05600c4e4100b004063977eccesm34814wmq.42.2023.11.08.13.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 13:54:54 -0800 (PST)
Message-ID: <pull.1606.git.git.1699480494355.gitgitgadget@gmail.com>
From: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Nov 2023 21:54:54 +0000
Subject: [PATCH] merge-file: add --diff-algorithm option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Antonin Delpeuch <antonin@delpeuch.eu>,
    Antonin Delpeuch <antonin@delpeuch.eu>

From: Antonin Delpeuch <antonin@delpeuch.eu>

This makes it possible to use other diff algorithms than the 'myers'
default algorithm, when using the 'git merge-file' command.

Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
---
    merge-file: add --diff-algorithm option

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1606%2Fwetneb%2Fmerge_file_configurable_diff_algorithm-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1606/wetneb/merge_file_configurable_diff_algorithm-v1
Pull-Request: https://github.com/git/git/pull/1606

 Documentation/git-merge-file.txt |  5 +++++
 builtin/merge-file.c             | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 6a081eacb72..917535217c1 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -92,6 +92,11 @@ object store and the object ID of its blob is written to standard output.
 	Instead of leaving conflicts in the file, resolve conflicts
 	favouring our (or their or both) side of the lines.
 
+--diff-algorithm <algorithm>::
+	Use a different diff algorithm while merging, which can help
+	avoid mismerges that occur due to unimportant matching lines
+	(such as braces from distinct functions).  See also
+	linkgit:git-diff[1] `--diff-algorithm`.
 
 EXAMPLES
 --------
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 832c93d8d54..1f987334a31 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "abspath.h"
+#include "diff.h"
 #include "hex.h"
 #include "object-name.h"
 #include "object-store.h"
@@ -28,6 +29,30 @@ static int label_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int set_diff_algorithm(xpparam_t *xpp,
+			      const char *alg)
+{
+	long diff_algorithm = parse_algorithm_value(alg);
+	if (diff_algorithm < 0)
+		return -1;
+	xpp->flags = (xpp->flags & ~XDF_DIFF_ALGORITHM_MASK) | diff_algorithm;
+	return 0;
+}
+
+static int diff_algorithm_cb(const struct option *opt,
+				const char *arg, int unset)
+{
+	xpparam_t *xpp = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (set_diff_algorithm(xpp, arg))
+		return error(_("option diff-algorithm accepts \"myers\", "
+			       "\"minimal\", \"patience\" and \"histogram\""));
+
+	return 0;
+}
+
 int cmd_merge_file(int argc, const char **argv, const char *prefix)
 {
 	const char *names[3] = { 0 };
@@ -48,6 +73,9 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			    XDL_MERGE_FAVOR_THEIRS),
 		OPT_SET_INT(0, "union", &xmp.favor, N_("for conflicts, use a union version"),
 			    XDL_MERGE_FAVOR_UNION),
+		OPT_CALLBACK_F(0, "diff-algorithm", &xmp.xpp, N_("<algorithm>"),
+			     N_("choose a diff algorithm"),
+			     PARSE_OPT_NONEG, diff_algorithm_cb),
 		OPT_INTEGER(0, "marker-size", &xmp.marker_size,
 			    N_("for conflicts, use this marker size")),
 		OPT__QUIET(&quiet, N_("do not warn about conflicts")),

base-commit: 98009afd24e2304bf923a64750340423473809ff
-- 
gitgitgadget
