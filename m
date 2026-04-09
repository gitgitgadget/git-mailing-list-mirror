Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA88278161
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741274; cv=none; b=SyVns3bKTfxcsHzLDSyoH1UVpqe3Dtv7xtEFXnRBGJJJAeSHQorWmECwd0UF7luBBeUAtj9BrE7qK2Cn9/c13y7SIJGJsD5qmTwJm7bVaFgV0YvCCoNWEEQ0jxlc6S7i8VxmGLGL1PDNrPKSGXfeC2icihOEIYmhl5VvcQALCAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741274; c=relaxed/simple;
	bh=aerVltdC9CL0GTUN+goGZKeYyjOQdtGrqjYAIwKWgUM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ihPkw5k9EVjB0DLt3DGPkjBz3CVlsvCuGSRllo7DHmwNFKsSBIv5Egtx8aX0H5riW5GpsewS3RxIBihSg8bFIBZqSuhMUpkRv8iT6Su3TgIWr9XjUdmI5D/DmoPgTZZIB16i4xcqrzJYc+FEXXNAPuzv65uhBcv9XsK+Lxbwa70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6EjF9Ae; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6EjF9Ae"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506362ac5f7so6852391cf.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 06:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775741271; x=1776346071; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9yzHLL0eDNEtURdXCitrp7JMf+msL9yqpE3QQ0aCxM=;
        b=S6EjF9AegsyeXqHVGK+fMg+j4Yz+Eu1wETMOV8p9tq2OeK9itnjYeyNLEuUWPqpn9M
         KOts9UpXrl6MRK7Os8RBWKX1StJYNRS4V7OLRuXKDvcBiydFdwNjujHXwQRL97Bhm96K
         7jb6K+e+wmQl0lW/36xaJHJMOGrWfBYNdJd0qeQbg4czZN8lpjdfL4UJ8NaczWz/sYTj
         EnZOfk8n1R9ybCpSPlxxrCAYRHVwcolo66RKl7jTi6Yfs032Mf9RFm/JtC5QLL8KyJ33
         OmruX+C/NTLh3pl8YsUyT4TXEAxl6g+7OrtU09xIG9TDZDl9GU1D3MvARwTFqAB5JXOl
         /SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741271; x=1776346071;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9yzHLL0eDNEtURdXCitrp7JMf+msL9yqpE3QQ0aCxM=;
        b=jMmzZ35wTw17p+cJXgsp7bscTSMqBWly6GXCcxIW3enL2gpGoUwCHhgPUn2pIqETh+
         EC4hYozunAZh3tVtd7tUiRgELtFaL8K7F60yuQBVdcnih4ohq2nf8l2Exqnz1BGyO2p0
         RztJw81+a0YWEIWP2MAW4LQf5rMBm1XSoUDlAf5+MLSS5I+k1cWQN01ACmSiQ0zjrYfg
         9r0E2nGuISBzSNJRV7n5qEXsbNjHFa2HffiRXbqqaaSfTsXu6orZm0KUSJpT35JchEr1
         SqZM9Q0CE0A1vPSQ42gTSCGKy0+MAsP/bl2kb1DFhOpF3xUl6iw3EHs2uyc623RthH6R
         z8Ig==
X-Gm-Message-State: AOJu0YyolBkzA9AMMculSz0kUhKM36eXT1n48/FlChgID4NR1nP1dPLJ
	Ckbxa65kTGW31WR1PJc6jy7nqTZNRbK6U1091Re+LhWou+YDW39hnny0rxv/fA==
X-Gm-Gg: AeBDievJeFiICd6J4y5OCyCuYs2z+wQYGPjgZjBdaD/qzIpbdoBnXc27UdJDzVoRUVf
	ubwWhl3FCEhgVC/npBUlrret6/GV4i1X3rAXYFzGDGU5i0AvN6eGvnYdK2XRmf5P9PBt6eGRRhr
	mwrE53zczozsRiNOZKGf150zwC42DaVRXxnGvnzQv/0Wpj2qsKNwd8j6gzUtC6NwPyWQRswE4na
	ofCjwyJpOmiS8Ud9b/AVG61zO62XxXYoDORfs3N+5hKEDtGqJsYwlfA4JFnQhzNP2dR02xIXLj1
	CgACbBwWXLB5Nxc+H7MRDZ+1IxNb2L/DaHWGgbc2AUhv0Mwbxrkyxrr4zNoBbnK7cV62I0jDSyD
	YqUG73jSMN2mjI2LJCKw3645R5J8TkzhZH2CoFN01nrd5vi0zxloTMroj6QIXzle+83rGhBaiKS
	Kvm0pgAAMPegrw047ekvTuZHuiE7ETF3ONN6zPMA==
X-Received: by 2002:ac8:7d89:0:b0:50d:6b06:a44e with SMTP id d75a77b69052e-50dc2115b10mr51877321cf.17.1775741271038;
        Thu, 09 Apr 2026 06:27:51 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.200.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d8e11b927sm128126811cf.23.2026.04.09.06.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:27:50 -0700 (PDT)
Message-Id: <64261e3cb6ea6e63bf78f5354e18aa94cf9b9c27.1775741265.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
References: <pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
	<pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 13:27:43 +0000
Subject: [PATCH v7 2/4] sequencer: allow create_autostash to run silently
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a silent parameter to create_autostash_internal and introduce
create_autostash_ref_silent so that callers can create an autostash
without printing the "Created autostash" message.  Use stderr for
the message when not silent.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 sequencer.c | 15 +++++++++++----
 sequencer.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f..e500a94a59 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4657,7 +4657,8 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 
 static void create_autostash_internal(struct repository *r,
 				      const char *path,
-				      const char *refname)
+				      const char *refname,
+				      int silent)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
@@ -4702,7 +4703,8 @@ static void create_autostash_internal(struct repository *r,
 					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
 		}
 
-		printf(_("Created autostash: %s\n"), buf.buf);
+		if (!silent)
+			fprintf(stderr, _("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
 		discard_index(r->index);
@@ -4714,12 +4716,17 @@ static void create_autostash_internal(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path)
 {
-	create_autostash_internal(r, path, NULL);
+	create_autostash_internal(r, path, NULL, 0);
 }
 
 void create_autostash_ref(struct repository *r, const char *refname)
 {
-	create_autostash_internal(r, NULL, refname);
+	create_autostash_internal(r, NULL, refname, 0);
+}
+
+void create_autostash_ref_silent(struct repository *r, const char *refname)
+{
+	create_autostash_internal(r, NULL, refname, 1);
 }
 
 static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
diff --git a/sequencer.h b/sequencer.h
index a6fa670c7c..570f804457 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -230,6 +230,7 @@ void commit_post_rewrite(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path);
 void create_autostash_ref(struct repository *r, const char *refname);
+void create_autostash_ref_silent(struct repository *r, const char *refname);
 int save_autostash(const char *path);
 int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
-- 
gitgitgadget

