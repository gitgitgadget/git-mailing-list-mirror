Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5D3ABDA8
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791279998; cv=none; b=dQm2r21aU8BFiXdrlb5EqkDROxxs5tMAjYG8c9QkjvC+040LyVtHEfIHuG4/Hlbn50dUThnl2CGgQZPCi0bgVyHz8snvnF8P9Xk2PQZv83LSqLN5H00rL/Jv4DAhONvL+Ba1kozUAikjWGkMPEdLASv0e3J8rFE4IUQGs3+0iMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791279998; c=relaxed/simple;
	bh=daPuBZxej5Tbwwfw+uX+pdJy2zKISZLcmSbLGDOXpxM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qe3Bdz6NH1CFoHXbkhmQYdJIZ3Lgh7pflPt0nbVrsM4DMPMrJnlYfNP6ACoOnOxv3Ptsn6dTBhNFnbn+S8rkxoeIdwn2CqgbcrsoNFxKPVUwNwgQ4fQQ4OKsau/ZG8mZRFR48mGVx0es+yvOlrFMXJRSZ0+qC60dPzfi0tOOOn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfR/Gl2X; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfR/Gl2X"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-141395927feso312275c88.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791279996; x=1791884796; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mt61OoTv8AC0hKQRW1/JUbxzcBWeExNkI2Fl80rCR4w=;
        b=MfR/Gl2XJmM6sxLykv4QwUdbe/7ht/Kl2sHERQyszEBCdL+BN4nRcUmluUV5ISG2oy
         RNWy8ZaWHIxo9WoNVJcZc/lF6xWKyaTffmX3DZmRCoQZLvxKF0XxmH0XPwlqqZusZa3n
         IlwSBcn+PPK+PBwlYrwA9EofEJ5QrB7cq58trLtPED1lPpwA0uSP8zTfBsALWvYoIAEj
         jIXxOgVt1iXPUZ3KyXGnnpDclY6vs4x9nm1Pu1qQrN61JuMauvZUN3+6vT/VjrdOQ380
         KIH9dC5tPJ/Zl7Im8kG0Ub9y4Rqt1h/LxdDxFtPzGZBHqBgglcdLrJtPF5Q2YZqiSlZ0
         57NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791279996; x=1791884796;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mt61OoTv8AC0hKQRW1/JUbxzcBWeExNkI2Fl80rCR4w=;
        b=axzN1Uk3PFQvUWRPxQtvvss9VpOUkkiPXYEv/+vO6ICK37ALHwz6OTXfDp8K2JY3ju
         OdbI7murpHpJJOQ1gquwFeoEM0VCFcDtGX5zXUbvNHajeX4GKWZ82rPeiESQ+JV766ou
         2RGJD6WxM5+6Y6nqSMeHVl4z9ALgwehjIHQTEUSoZTV2z3v6yeXq6Y9qKAXUHwbFRhyb
         v7oVTn8kiGe02mu6CTcoNyI6kdyXQz8fikY2P3iYPxefwixUJvl0Imi36y9aqmoVb3Xf
         PfrjrwYU14JAB002wkm+2lKhAp0uw3+RweRw/8JnXLpYiqZkXgizVEcLpd5plJN860H7
         BW0w==
X-Gm-Message-State: AFuF++mX5GcbaeCb6ciSkvyIuAVIxkglMWfOGC73CgxBPARNBjimW02z
	FRds2fM0Qbs0fGqbs4joUiq+8X/YVcp66L9BEJyX9ql1uG4s9CFRtrQpctqSGzu2
X-Gm-Gg: AYBFou3CCXq8yetS5aZmyRGMNPOqXuWDt2piqpk8dKhiOwuKAFpE0o7ZiyJo0CqvBNd
	B7WziWXz52Hrirt6ba0hfVtqdbbuIhY+/mdRt/QCk57WjnODTcBWDWtEJgeiR0aY+ca68bGDJXz
	PupS82XDHiMMWbZ2l8Xgf6DyjpIKUKHKhFqC7/0Ss/nhEPhDyMkuwgaGYp1PAzz2Bbj5OudHGmg
	vyZcPVV38K6o/yYDxNt5BI5+E+hzqsBfUwN+w3/n9uR7WP0rxXB5XX5miE4KSRKyIswRPk7dL26
	m4NCbttHL2J7mdnbbOEBRPHC7iXJac1KBeME9CvmYGg5SSPdnrXfPvzOilDRys408XRVwURxww0
	a8C8Bnztelrnvr5BZExBCecpSfoXLDyJvhWlRzwY80gqorN/6abA3fIrOVzLp8zdoJkYNQ088BF
	rYAokVnuq6gjxCf+dSqfKt7Cwu7JizgJvQtIGkEAARh/seuuKXe6djKpnwQ/ktsM6/Wyw85V/7C
	A==
X-Received: by 2002:a05:701b:2302:b0:14a:51c8:ea06 with SMTP id a92af1059eb24-15ec7fcf577mr1300157c88.29.1791279995713;
        Tue, 06 Oct 2026 02:46:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.108.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d819cbed6sm11697426c88.4.2026.10.06.02.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:46:35 -0700 (PDT)
Message-Id: <36cc3ff3b329375d9d87d7ffbaf33b019f91b4b0.1791279992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2239.v2.git.1791279992.gitgitgadget@gmail.com>
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
	<pull.2239.v2.git.1791279992.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 09:46:31 +0000
Subject: [PATCH v2 1/2] test-tool read-graph: add commit-info subcommand
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

The test infrastructure has no way to check whether a specific commit
is present in the commit-graph, making it hard to verify graph state
after operations like fetch.

Add a "commit-info" subcommand to test-tool read-graph that queries
whether specific commits are present in the commit-graph and prints
their generation numbers.  Returns 1 if any commit is not found.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/helper/test-read-graph.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 9f07b9c25a..0ab9cf8f2b 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -2,6 +2,9 @@
 
 #include "test-tool.h"
 #include "commit-graph.h"
+#include "commit.h"
+#include "hex.h"
+#include "object-name.h"
 #include "repository.h"
 #include "odb.h"
 #include "bloom.h"
@@ -91,7 +94,25 @@ int cmd__read_graph(int argc, const char **argv)
 		dump_graph_info(graph);
 	else if (!strcmp(argv[1], "bloom-filters"))
 		dump_graph_bloom_filters(graph);
-	else {
+	else if (!strcmp(argv[1], "commit-info")) {
+		int i;
+		for (i = 2; i < argc; i++) {
+			struct object_id oid;
+			struct commit *c;
+
+			if (repo_get_oid(the_repository, argv[i], &oid))
+				die("not a valid object name: '%s'", argv[i]);
+			c = lookup_commit_in_graph(the_repository, &oid);
+			if (!c) {
+				fprintf(stderr, "%s: not in graph\n", argv[i]);
+				ret = 1;
+				continue;
+			}
+			printf("%s generation %"PRIuMAX"\n",
+			       oid_to_hex(&oid),
+			       (uintmax_t)commit_graph_generation(c));
+		}
+	} else {
 		fprintf(stderr, "unknown sub-command: '%s'\n", argv[1]);
 		ret = 1;
 	}
-- 
gitgitgadget

