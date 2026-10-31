Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793433848;
	b=UnmoqnsNh4mFCN+Mrxt58umAPmq1PamIu1+eVaP5Th1N9LHHQ1vDUIBjUp+/cMasGnzB
	 uCcTmxumdTGkSWWb2Vh8P6lRiGMcpDr6mslS3dc4H65kAGIi6j7QF33wL/pNtH6bvOeo8
	 sPpS16uhgmgrKFSQCw+RrqfF9LZTP9tBg/CBDLxjoT8gkW2f28BEM5DbZ45BaoitEs5EQ
	 XfvmQYqX3QQ7s2pPwVz2tXhKpBT9Kwya/vHmED6o/HPEqaHJLwDadC6i/Ky6YEhHmpnkO
	 xz9EMDw0WKEBzgsPRE+dCBHB5SRJy58mH1DAcm9e+O2lZSmYCKa8q+T0T30OYHTfMtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=SElNwdS4FgrF6o0psPB1xjbOG7Wc+yurPkV33PXLdDA=;
	b=X0udNE3m+MCpdDfVogxJ/O/0W5LjHpy8tufKlZJwqnPixscwzfEH8MhGBd7SMVyGnmvW
	 NTOziffToRiQ4lcknp764BajN7CQX3DZZKiJE9kWenl0mcLQGl+89wdrkl0Jb/6C9o/Ap
	 SM3f6/QAOsPMlA8o8YINw9BhtevXBJpwT/WEEukIy9j/WVr5LF/BquCOiH51tRDDNw3NT
	 xmgSXheB5ICFWQJHslfCFIYtXL90yBcJJwn1csp0H2TmV7DpEuShKBXF9KNATyYkUgt7K
	 toSjEtXVaqU2+m3BBfBnK53o8r620C1QwVftrnimU6A2LrqwqSCpUW1sCWHcoyfIuOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QlizUzE3;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B82606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 08:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B82606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QlizUzE3
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53cd0c8614eso11106041cf.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 01:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793433847; x=1794038647; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SElNwdS4FgrF6o0psPB1xjbOG7Wc+yurPkV33PXLdDA=;
        b=QlizUzE3Feg+n8fO6KhX8EHTJzgJ2xcGT2a2/Z8pnUp1FFcmOCV67vSe2/TZkQrnAS
         2LCX7obR7xDbRKED9FNiOZTfyfbb2G68H/MtCRIzsI9xr/JNdmWIgou1rFHOvVjX3czv
         TWsRXhy2yqeE3J3TgkxmdTspwgxnImnrvyz5dAdb3xk/QatSKDv+jy1SyGRVvlPp1j9R
         QpJDI39GWqR1pPfCWEQjGrKSqjPcc+fBf0OS0QwMQW4RzurG5T4SdHkZix1f0CmAcKKi
         uM9ivgACliHVehE2eMG78jA5C0fyNfOS05mcAONpZLYnBZsjmMvbmUpUGeHml20wUbEV
         s1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793433847; x=1794038647;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SElNwdS4FgrF6o0psPB1xjbOG7Wc+yurPkV33PXLdDA=;
        b=rAFMJGhI4+F8U+t7x8fxQ1PcTxoHD5jgzHu0Ooyn+GH9JuTe3nhFmInovvE+cT41xE
         ut98wDEDOeOPJtiKvVqRz6wA6vfhtyzIG5gybLSUTA0sd5oID7ljlwsircI9W/G6rtkz
         LirC5wI07DwY2pCYmG8ozuNR4KrDKKKDlRD5GbF9jXT/ROGu02IV6SatvM8IwDzbB4NY
         9gzT+WTIJnCPGb6aLAJjgw1qMJerpvddUtP3FF/HByIuXDpNFALHDtT3NTmbNGtQpOoy
         ZJCBfFv+vmFOWhvo1Q4bPeVYzswa9U/FlKzclrGAmCa91jA1+tExXF1zEjucQwbeJf0O
         Q8Mw==
X-Gm-Message-State: AFq9FYJlUX/wrm2sIBMIxwb255bCqp2c1m6qT9nQ7R2vMuCigqXCFzV4
	TyY4mOzrwj6IVm7+iPAqfJVOEyVqV4xOPqnaC3JNpQziR3qgW7Sfn1feuaGSUSqTD64=
X-Gm-Gg: AYBFou3pxhENajkXlrGiUVl5AVfuda1QA8Wo9QhWYBmTYRZkR2VmKmVOPx6YSoFrTty
	ikvyDJCvBr/CdfsIr91XgJHExTTerFFIqMOLpKtQnFm3YS5MOCYaJWqP0R26ecKBhJk2CdlbEUe
	nZqBKBZxT5TcqZky6Owcg2m9I+GWWeV2EjnZfcVw2AkYrO8vivIHGsweZWKKeKC61E1Sh7gpm/l
	EJ3wE+AAIKJeQlkJzNkzLoNi8HDvnk0kaA+pZd3evgheAm5BS8qDXac6k0Nw8FWSZNc0dOnhuGg
	0cDilgngqQMcLtISrVjEhzcbBuYRxhQpA76w0D02M9+MksuV/qr1d18sRAr6xKqXEi8Sri13QoR
	M28zw0ONrRYdJ9AcsTrby0XROxUfXw+8rz3JXHoghKS2LcyiJVI2gn8r6sV6bT0Y01XT6rbezvz
	7DPjSzL8sHLSp0iH9HGG9L5Q3u7AL/MaibYJ5bp9+mmuWoTF2PtZHwKTRJukFl8x1YYpRDMiCvz
	kt0f81MVLNqZLgolLNNBvQYYRSqCUMi0KyHk9RZ6jLrQbvDeojTqQ37gBdeWt3okgiov8XOQD2+
	wMpufGR72TbuP6K8wBigKLup+CDTyNGZzA==
X-Received: by 2002:a05:622a:2b4b:b0:535:c88:8f1 with SMTP id d75a77b69052e-542b6d5eb3amr73047271cf.41.1793433846485;
        Sat, 31 Oct 2026 01:04:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.239.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f4767asm36715736d6.21.2026.10.31.01.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 01:04:05 -0700 (PDT)
Message-Id: <151fef69b9ec221b39fdbab1d46f0b123f9079e4.1793433841.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2466.v2.git.git.1793433841.gitgitgadget@gmail.com>
References: <pull.2466.git.git.1793105039624.gitgitgadget@gmail.com>
	<pull.2466.v2.git.git.1793433841.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 08:04:00 +0000
Subject: [PATCH v2 1/2] remote: move "simple" @{push} resolution into a helper
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The "simple" arm is the longest in the switch of branch_get_push_1()
and needs an extra block to declare its variables. Give it its own
function so that it reads at one level of indentation and the next
commit can teach it about pushing to another remote without nesting
it further.

No functional change.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/remote.c b/remote.c
index 49ee2ea318..d15d34aad7 100644
--- a/remote.c
+++ b/remote.c
@@ -1967,6 +1967,28 @@ static char *tracking_for_push_dest(struct repository *repo,
 	return ret;
 }
 
+static char *branch_get_push_simple(struct repository *repo,
+				    struct remote *remote,
+				    struct branch *branch,
+				    struct strbuf *err)
+{
+	const char *up;
+	char *cur;
+
+	up = branch_get_upstream(branch, err);
+	if (!up)
+		return NULL;
+	cur = tracking_for_push_dest(repo, remote, branch->refname, err);
+	if (!cur)
+		return NULL;
+	if (strcmp(cur, up)) {
+		free(cur);
+		return error_buf(err,
+				 _("cannot resolve 'simple' push to a single destination"));
+	}
+	return cur;
+}
+
 static char *branch_get_push_1(struct repository *repo,
 			       struct branch *branch, struct strbuf *err)
 {
@@ -2012,23 +2034,7 @@ static char *branch_get_push_1(struct repository *repo,
 
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
-		{
-			const char *up;
-			char *cur;
-
-			up = branch_get_upstream(branch, err);
-			if (!up)
-				return NULL;
-			cur = tracking_for_push_dest(repo, remote, branch->refname, err);
-			if (!cur)
-				return NULL;
-			if (strcmp(cur, up)) {
-				free(cur);
-				return error_buf(err,
-						 _("cannot resolve 'simple' push to a single destination"));
-			}
-			return cur;
-		}
+		return branch_get_push_simple(repo, remote, branch, err);
 	}
 
 	BUG("unhandled push situation");
-- 
gitgitgadget

