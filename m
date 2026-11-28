Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795833728;
	b=FGYOl5WxONzFxBDGdj1weU8Gl3B4PyPkO8LzE1YdjOlu8rCESFvE5RCu8JZiK3whPXoI
	 20oidQUwevO4eMeGyc7q9FpTvdbJsDlqtzoCH5siktBvf9DKQSqt6Mf9DRMneKx+T+wx7
	 h8z5KpQhskrwPuSWAaheEriEgiMu8h3pCqGYoZOrj+vxqrJY+HtT/YXOeK2kBJiGM9UoB
	 ze2dIiP4D7T7lszrM2HXVNRwtPdwQ0ZjBrk1D1/G3yMGNPxKol0Y5CEV2+c7ycpDs0xXG
	 LEvcrnRp+WaNtzg9kjaQGuXY7tiMoKUrN8TDym+a+DY0nX+EgcgVCJn3hdWPSh8ut4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795833728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=1NVfBz6DpN+ASRall9LTmV1MLoLkd0RoedjjgzRY9X4=;
	b=T2QCNJ09RPGIZ8nXx/yrnoCai/laDdmhtT9Te+8JJX/l14Tjr8XFVSfhslMjUFtAClcJ
	 rranUQycKMuYfHzS2Tzu+m/BoE6f/ms+QXauS6dldGSxyejeR4EMjABXui+30sNcJYRYO
	 fnhhcYwdcug0WzwTLZ/KfMyvdzyi1sZPIBdjJN59oaDby8PJWG2+lwbhV3czZLjx5sIbk
	 GLrJT7XWDyNYuU5FJMutbHetvoYnUXejyrVT/YlIu2yHjjXLWLZdhDIKcP9RRGDxLb7Wl
	 dO0O8E5oB7LirgfRIWAVXk/6WXqAGm/iiOmCZpYkD+ajwGXg1oho+luviFqLmQW0RAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aCHE+bhN;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7CC606A31C
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 02:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C7CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aCHE+bhN
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-55c4e670fc6so65451741cf.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 18:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795833727; x=1796438527; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1NVfBz6DpN+ASRall9LTmV1MLoLkd0RoedjjgzRY9X4=;
        b=aCHE+bhNpQsFzc/LQK76F6V50KLTIm/fnIhCRgacPCw5bqZTtRkBEFUBxs5b2bO63R
         fbDcDuIGFyGVfOpRDvSl8R2rb06knZdS9HgfwYGtiOijCBk3a/aJLOEeepTHe4rp3CuY
         i5DqiqhQawObKgSGYIexJGEsj0IlUYTN1cLKD7HZYrREjLYi3y0egeXWPPiHE2eZZxo3
         adSdzlIoPW/zd4so99v0Pgc08pkRHiTckbrxUMOXz4qdh/2coCfDVMMF3r1Hz0MId3wz
         EzAco88StsR1tULqCCnUBaMmCvhIssp0bjq+mwIrNy1eAa7CtY2yo8j4KHjr2Q1IDUjP
         1rSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795833727; x=1796438527;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1NVfBz6DpN+ASRall9LTmV1MLoLkd0RoedjjgzRY9X4=;
        b=Y3Zac5jCN+8aHbyB2xATxMeqc/KI6A64HKk9JYt7TS/EOj97NWqlxf4CZOmdQFxY+3
         sxZDYGqvY0IO1sMWQn1Fy17hj9NbyN2zZb4H/HFgaQ6tRUDZ1UxmaMcz5f4k0tr9glVk
         oD85dwdbYyW8ELMchX+jVu8+eakuZPvKWKlIuOUayBHZxtwd2/Bn24LkdfrXc8RbJQvE
         UzvEYg+dklMOP21v2HQa6cl/Vhbm4jFSt+CjJZ05/pTo/8ZYP0lQ1aLRREurQm0ialV9
         YspqVKbwSeemaWPolchfGWjj6DvtxUhDOv0MeMAVcLjjtrFFf8Xn4m+h//6LFlUwWPL2
         sikg==
X-Gm-Message-State: APuU4Z+CM6QV36i3EwGm9PwP6/yVotRbUYrr1VVVdMCaTWVU2kA2ssdm
	9/s7Wtz0JRGJM0+dVQoksBaeQm3R68FWraq1lyI1ezfS6oM4rti0R+U5ytrwlg==
X-Gm-Gg: AZFdTZejNi44ha+LR6dd4N2dQvzYngFnNt0RWb8Wg/7A4QXFYu3OH6t6UuWb39A9B03
	VZy5Z6eCRfL/uGSY7LvoRGRk+gYSwDkNLqNqHd71hHVU33ATfxRUAgWDI4nGJ9ghIrDuAMSeqoB
	/bFc5de8g6TBXDrPu2UpLWEmXUboEZo+I/ceFI4N5kPYcMTJJble+8w0vPyn4mnfLpP2tQ8CLHB
	fTFHU4jJbduG4+UDWQcrrFCKQxl5jwPwlZalmvGPrWNaNaZZBtRsYvAtrLs6JaHKjT4qQFTxMe/
	fq6kehXnLBlznzFzNZlZ0/EZHPuHOZKX7iRHIfdfyszwttdJKd+cslV4pivG3WtENjBWGSL5MHW
	oPurZdJ6bAHl5krFPK+5gCmURazKs8tNSGwuvFQwM+lWHq5NgPEUW2nFqB9IDoG6Cp7lPLSOmpg
	82lxF91qkAE/zXmYUZt+KLa/ip4fADWrcFBZQwSY85pmOzfd8NkMF+7BQPukJ7ys0PkyIWE8EeS
	5sUF8pAs0EAOl/Rk7BQuvZVxrxg8yAVrHTPrmwlmBbPQcJuaRVElZqo1CZsb4+O5vVlefgOvDMU
	dHWGJ9BpkuC0PFmTdT/FZFH8b1/gmKoO1g==
X-Received: by 2002:a05:622a:30a:b0:55b:b083:2b88 with SMTP id d75a77b69052e-55d76a1412dmr486170051cf.28.1795833727085;
        Fri, 27 Nov 2026 18:42:07 -0800 (PST)
Received: from [127.0.0.1] ([20.127.215.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7c654585sm216565011cf.5.2026.11.27.18.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 18:42:06 -0800 (PST)
Message-Id: <pull.2386.git.git.1795833726252.gitgitgadget@gmail.com>
From: "Eddie Ash via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Nov 2026 02:42:06 +0000
Subject: [PATCH] git-p4: honor client spec when unshelving
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
Cc: Eddie Ash <eddie@ashfamily.net>,
    Edward Ash <eddie@ashfamily.net>

From: Edward Ash <eddie@ashfamily.net>

When git-p4.useclientspec is enabled, P4Unshelve creates P4Sync
without loading its client-spec mapping. Unshelved files are then
placed relative to depot paths rather than client-relative paths.

Initialize the mapping before unshelving and add a regression test
covering a depot-to-client remap.

Signed-off-by: Edward Ash <eddie@ashfamily.net>
---
    git-p4: honor client spec when unshelving
    
    
    Description
    ===========
    
    When git-p4.useclientspec is enabled, git p4 unshelve creates a P4Sync
    instance without initializing its client-spec mapping. The unshelved
    files are therefore written relative to the depot path instead of their
    client-relative paths.
    
    Initialize the client-spec mapping in P4Unshelve.run() and add a
    regression test covering a depot-to-client remap.
    
    
    Testing
    =======
    
     * make -j4
     * make test T=t9832-unshelve.sh (skipped: this environment does not
       have p4/p4d)
     * make test T=t9809-git-p4-client-view.sh (skipped: this environment
       does not have p4/p4d)
     * python3 -m py_compile git-p4.py
     * sh -n t/t9832-unshelve.sh
     * git diff --check
    
    GitHub Issues are disabled for git/git, so the problem description is
    included here as the issue record.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2386%2Fcazador481%2Ffix%2Fgit-p4-unshelve-client-spec-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2386/cazador481/fix/git-p4-unshelve-client-spec-v1
Pull-Request: https://github.com/git/git/pull/2386

 git-p4.py           |  4 ++++
 t/t9832-unshelve.sh | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index c0ca7becaf..038c09e9b6 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4470,6 +4470,10 @@ class P4Unshelve(Command):
         sync = P4Sync()
         changes = args
 
+        if gitConfigBool('git-p4.useclientspec'):
+            sync.useClientSpec = True
+            sync.clientSpecDirs = getClientSpec()
+
         # only one change at a time
         change = changes[0]
 
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index f85a60a184..a8798621f4 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -185,4 +185,41 @@ test_expect_success 'unshelve specifying the origin' '
 	)
 '
 
+# Make sure unshelve uses the client spec to map depot paths into the
+# corresponding paths in the Git worktree.
+test_expect_success 'unshelve with client spec' '
+	client_view "//depot/... //client/remapped/..." &&
+	test_when_finished cleanup_git &&
+	git p4 clone --use-client-spec --dest="$git" //depot/@all &&
+	(
+		cd "$cli" &&
+		mkdir remapped &&
+		: >remapped/client_spec_file &&
+		p4 add remapped/client_spec_file &&
+		p4 shelve -i <<EOF
+Change: new
+Description:
+	Client spec unshelve
+Files:
+	//depot/client_spec_file
+EOF
+	) &&
+	(
+		cd "$git" &&
+		change=$(last_shelved_change) &&
+		git p4 unshelve $change &&
+		git ls-tree -r --name-only refs/remotes/p4-unshelved/$change >actual &&
+		cat >expected <<-EOF &&
+		remapped/client_spec_file
+		remapped/file1
+		remapped/file_to_delete
+		remapped/file_to_integrate
+		remapped/file_to_move
+		remapped/unrelated_file0
+		remapped/unrelated_file1
+		EOF
+		test_cmp expected actual
+	)
+'
+
 test_done

base-commit: dea0ea3582e6980ddbc1173cc8e3e9f9db91cde0
-- 
gitgitgadget
