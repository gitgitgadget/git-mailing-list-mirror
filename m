Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F51D554
	for <git@vger.kernel.org>; Sat, 23 Dec 2023 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWzTBRIm"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336755f1688so2558419f8f.0
        for <git@vger.kernel.org>; Sat, 23 Dec 2023 09:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703351713; x=1703956513; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWLJcNfIQIUp4tzQE7++unCeOFOjKzm/JkqM5nU7tSY=;
        b=AWzTBRImzvHoyk6BIdSUsoD8Xgvy+orJqrELGgRycli0BNlTrLjBaJjPqNaZzlVpR0
         UNhbJVe+osqIxOQQECiUX6K6H9/UyKkTJXJ8muKaFbY/DQV4Bpy/D79e3LYFn7oIPvvl
         dCrtVuNBSIDI9YBFEB6lMko1vqmCzOzGjJdRkFMj2O671Xpz483tIUYxoJD5COiWRULP
         7bvvnOz2LIKN69f1XbtmNDi7paiCSitg0dCnnOfdsqQKxKfwQTr4Ql8yWTsVr7YTToOt
         Z/9AN+bUvbjjTblqWDVk21eNv0vE4e8PdlD818lmketzRrtO8CG+RNVt+jvCIL5VPnJM
         Ow8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351713; x=1703956513;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWLJcNfIQIUp4tzQE7++unCeOFOjKzm/JkqM5nU7tSY=;
        b=nM+RBZU3BSRXQ/TjnkcNJt4JQeFYHy3G2vIBNkqrN3vHc+RvVN6g+dj5qjzpUToRBv
         0mcfKvKVolGiwh/97LQ+ZHg1bZKn0L4M2O91F9XIuysXa3fbYKx9f2UKrtY36rRF09lg
         AgsDcypJ5/OKia5g7Uc5JWzoyXUoSn4BKTDVNdfrSEMWIqaaPpigw98OUzLql8fezy/H
         oe7FnR/Co9cETqXOzmsIgXTjrVQiK4UHSWpyQugxNNpqOa8d61VEOvOcebzoZUioRjkg
         KAUwyx1H/ZRjbjdz6bVye3RZCjlA4scNdy934LlrrRW9wjRUFGdB+bxGlhq2wQTazLu7
         oQ7w==
X-Gm-Message-State: AOJu0YzUSo3QCEdgLGqg2+nbZZqHSUoq+s8XBlWgzvSyQ2/LxAwTlpK8
	9QYYvmAh/CxaKU6TFZgO9aKmjGdhZe4=
X-Google-Smtp-Source: AGHT+IEszGsBSOXc+G6wcACeZpwiw2KJ+WNF55ONY9dWlVdh1kWzOu3dFRPboOIhy1CkYnD4J4EFTQ==
X-Received: by 2002:adf:f342:0:b0:336:76a5:5774 with SMTP id e2-20020adff342000000b0033676a55774mr1767953wrp.68.1703351713492;
        Sat, 23 Dec 2023 09:15:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5-20020adff4c5000000b0033668b27f8fsm5452641wrp.4.2023.12.23.09.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:15:12 -0800 (PST)
Message-ID: <0639ba03d50fed48b98c3d74824f741ba85e6380.1703351701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
	<pull.1617.v2.git.1703351700.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Dec 2023 17:14:59 +0000
Subject: [PATCH v2 11/12] treewide: add direct includes currently only pulled
 in transitively
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The next commit will remove a bunch of unnecessary includes, but to do
so, we need some of the lower level direct includes that files rely on
to be explicitly specified.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/commit-graph.c      | 1 +
 builtin/for-each-ref.c      | 1 +
 builtin/fsmonitor--daemon.c | 1 +
 commit-graph.c              | 1 +
 4 files changed, 4 insertions(+)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index c5684342ecf..81a28c6fcdd 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -11,6 +11,7 @@
 #include "object-store-ll.h"
 #include "progress.h"
 #include "replace-object.h"
+#include "strbuf.h"
 #include "tag.h"
 #include "trace2.h"
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 6235d72f9d3..b5bc700d13c 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "commit.h"
 #include "config.h"
 #include "gettext.h"
 #include "object.h"
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 7260604534f..9f80b9eaff5 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -12,6 +12,7 @@
 #include "compat/fsmonitor/fsm-health.h"
 #include "compat/fsmonitor/fsm-listen.h"
 #include "fsmonitor--daemon.h"
+#include "repository.h"
 #include "simple-ipc.h"
 #include "khash.h"
 #include "pkt-line.h"
diff --git a/commit-graph.c b/commit-graph.c
index 5bfee53e87b..e7212400da3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
+#include "csum-file.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
-- 
gitgitgadget

