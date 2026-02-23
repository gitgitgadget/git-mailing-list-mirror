Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480C8315D47
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865518; cv=none; b=Gz1SgXn5iE6U50/TWjsu2H4GYh12B//6elYNgycecVZdfZ1WDfnBrIvTF+rUyiHSmrtIsUVToP3D1oK/6+qEF0bl+GVyYAE1IaQSY8AK0IGwP4wMwNhuDY/38wurwefAlE6wi6ETgO/ZhAQK4qzfeHoXScNCwfEvoXkFlNX5P74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865518; c=relaxed/simple;
	bh=bfTny5iHwV89E+0myZdHWurQNrHcZ7WPskys2tJ9Cfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwdCCk4zGYa78ne04RIKTg8E5BjnjefRgnmlm8YeQUNGqcl4lceBoulr+qCmTrCUHUiu5D85YTF7n/WahsNt4YbvCjWipwsDg8oD0ZNIZCMCLxzPHRwRjjRo7NNhGZfrebGTbnl6yx3DgwrxVpd5myzWVKVrxv9vtjjuZoNxtvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOJzPNgo; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOJzPNgo"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35621da1a7dso3131035a91.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771865515; x=1772470315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WzmlpjB8eRynXuHwH6OvyfFhGk86NWCJBWltk5/J3E=;
        b=DOJzPNgoX19RddMppHtdI4CKDMrKtjbeS1GsPI+LBCrXVeN6qhJTTGrkimEfN4KkVA
         coi+KOtSeICkw6j8V/EWqFoqF4DCvlgRTp2gg8LqYWWluy7EjpzGQCkS4cVvTbaLciJB
         JC3wXfUhy+wapOwYUL0r94ka1ITd4jR8LKXHx+vxnGmKheYeg3BRo76wdxyzWRHqUTkX
         qpvRXV3py0pqYl7JvEOK3VU5JfVp7dPC/eRB/HvRUaMuBdNscO/lmOewU2JyTmJ7rJwR
         lywaPks/RL/hyu2Im2cS9DBbVB/2yMbRpOj+SMvyrBjWrR+ep7mbaKSVsEfFVDBen45I
         P+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771865515; x=1772470315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WzmlpjB8eRynXuHwH6OvyfFhGk86NWCJBWltk5/J3E=;
        b=PBKsR0xa2+ObMW4wjS4IcIZ2Zne3AD/yLfIit/h+YIvfbBgp1XKtnPSR2xB5hC1Ykv
         tlFVdD4VocqIgWW+eRkZHlGM2Tb5Ll1rX7Qt6pCFgynADclrz7URLEw02Jiaf7FwIhdZ
         bqnb4vAi4BjRO6dPDRPOE3G/3tee8JDvmeUaY5fYvVynvuvGZMFXWbfC6pszYu//Jj8P
         8ZEVjO6GCU7L58CDnw+KNjXmYQu9PunmQtI3VqvsUna/IVf1y+HCuxRKYYIdsSstb2zM
         Qz7SygeJTfE6AhCEn/fIFGsD7a53k8pnAEZaksV+qab0zuLk6OGdXuJlDCTLB+H8O4YI
         RRDQ==
X-Gm-Message-State: AOJu0YzXM2p2Xdc2jBRlAeq5WrrYNtzLwUGK6MSxKjQb6u4nm24W7bZ4
	fm+RVS/aaRKnnmrfkg53kIVSqN/oclTGUX37Xd8yF4zA3psQVBtnRPRoD06fjQ==
X-Gm-Gg: ATEYQzzJaq3dGL1R2pIX5P8eakuvxvNEMg43gWIpdTwTm1FqtnoUX+2Fb48cpH2U7u/
	YFbHBPVIbF5+YJwkZjQKS02bLBJCGfiFRayXjMrzJWMDmr0NmJdIgyl7jR9RSAd7jgAXKGm1VPd
	NVWyn6wK7mFOO6tJ7B33F4sh646wxW1B2but65l4GekMYF17zncT9QfNHxHGuA4vV5g8aTng05E
	8Y/UehhT6SikLLdaZH/9YbuzUnatJoOUR4cktZsXo4jed3kaFdi662L8mmwXBGZEKWuW3/zk+65
	XWzWOWr12lFaxJ16zgpxkodWFSL92v1cdw5hJF84bb/TASdXzjIbBnCfPsNgnyoqUabAVgLYcpO
	UEuUJ9o7LsbLtOaRHQ4+YwvBeIt/FirsDpHnlyouFV/Suxruh4i77mdm16teLCQhM8FfD+qtKTS
	+SkH67+GX0cfSrR0DD8ygwXnouWkOgDTO58qLe6fVbuz5Aep0=
X-Received: by 2002:a17:90b:5747:b0:354:c600:1a1 with SMTP id 98e67ed59e1d1-358ae8b75d4mr7528186a91.19.1771865515462;
        Mon, 23 Feb 2026 08:51:55 -0800 (PST)
Received: from CPC-yingh-DJJP7.reddog.microsoft.com ([70.37.26.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af71f9a3sm7203971a91.6.2026.02.23.08.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:51:55 -0800 (PST)
From: Andrew Au <cshung@gmail.com>
To: git@vger.kernel.org
Cc: cshung@gmail.com
Subject: [PATCH 1/1] transport-helper, connect: add atexit handler to reap children on abnormal exit
Date: Mon, 23 Feb 2026 16:51:47 +0000
Message-ID: <20260223165147.3294516-2-cshung@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223165147.3294516-1-cshung@gmail.com>
References: <20260223165147.3294516-1-cshung@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Au <3410332+cshung@users.noreply.github.com>

When git exits via exit(128) on transport errors, child processes
(git-remote-https, ssh, proxy) are never waited on because the normal
cleanup paths (disconnect_helper, finish_connect) are bypassed. When
git is PID 1 in a container, these un-reaped children become zombies.

Register atexit handlers in both transport-helper.c and connect.c to
ensure children are reaped on any exit path. Clear the handlers on the
normal cleanup paths to avoid double-waiting.

Signed-off-by: Andrew Au <cshung@gmail.com>
---
 connect.c          | 17 +++++++++++++++++
 transport-helper.c | 11 +++++++++++
 2 files changed, 28 insertions(+)

diff --git a/connect.c b/connect.c
index eef752f14..322b1f816 100644
--- a/connect.c
+++ b/connect.c
@@ -20,6 +20,18 @@ static char *server_capabilities_v1;
 static struct strvec server_capabilities_v2 = STRVEC_INIT;
 static const char *next_server_feature_value(const char *feature, int *len, int *offset);
 
+/*
+ * Ensure the connection child (ssh, proxy, or local git) is reaped on
+ * any exit path, mirroring the transport-helper.c atexit pattern.
+ */
+static struct child_process *conn_to_reap;
+
+static void cleanup_conn_on_exit(void)
+{
+	if (conn_to_reap)
+		finish_command(conn_to_reap);
+}
+
 static int check_ref(const char *name, unsigned int flags)
 {
 	if (!flags)
@@ -991,6 +1003,8 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 	proxy->out = -1;
 	if (start_command(proxy))
 		die(_("cannot start proxy %s"), git_proxy_command);
+	conn_to_reap = proxy;
+	atexit(cleanup_conn_on_exit);
 	fd[0] = proxy->out; /* read from proxy stdout */
 	fd[1] = proxy->in;  /* write to proxy stdin */
 	return proxy;
@@ -1449,6 +1463,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 		if (start_command(conn))
 			die(_("unable to fork"));
+		conn_to_reap = conn;
+		atexit(cleanup_conn_on_exit);
 
 		fd[0] = conn->out; /* read from child's stdout */
 		fd[1] = conn->in;  /* write to child's stdin */
@@ -1466,6 +1482,7 @@ int finish_connect(struct child_process *conn)
 		return 0;
 
 	code = finish_command(conn);
+	conn_to_reap = NULL;
 	free(conn);
 	return code;
 }
diff --git a/transport-helper.c b/transport-helper.c
index e95267a4a..cdfd40dfc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -17,6 +17,14 @@
 
 static int debug;
 
+static struct child_process *helper_to_reap;
+
+static void cleanup_helper_on_exit(void)
+{
+	if (helper_to_reap)
+		finish_command(helper_to_reap);
+}
+
 struct helper_data {
 	const char *name;
 	struct child_process *helper;
@@ -147,6 +155,8 @@ static struct child_process *get_helper(struct transport *transport)
 		exit(code);
 
 	data->helper = helper;
+	helper_to_reap = helper;
+	atexit(cleanup_helper_on_exit);
 	data->no_disconnect_req = 0;
 	refspec_init(&data->rs, REFSPEC_FETCH);
 
@@ -249,6 +259,7 @@ static int disconnect_helper(struct transport *transport)
 		close(data->helper->out);
 		fclose(data->out);
 		res = finish_command(data->helper);
+		helper_to_reap = NULL;
 		FREE_AND_NULL(data->helper);
 	}
 	return res;
-- 
2.43.0

