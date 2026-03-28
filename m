Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA5194AE6
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774734012; cv=none; b=bKjGZLQx0O/LYbwwoT4gPJ6sSh+/wTcmSAo3hMoiGPvSWZPfLW/siklkhHzticQRispYIZYciUoA4nwwNedYiRAm5Ln+3jnyGdWEs6TqlKhlJ4rXWj6m3Bi8/peKCZ6Yy77IAWIFsGdes6kyAvKmva1AIwnaxe7ba+J1ZDQ/bMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774734012; c=relaxed/simple;
	bh=T6WD+I3v9EMPUxUIgif0n6CmLwvZ6imuic7DSw//Uts=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CWZxYbeJwMyDrPrfLdO6IoSh7UAO1sXB3s7i+0lzxCun6WkXBjjdykhFJNyKqwuFIMVtmH8Sjmi/Up50bEl7XpwS0cf6mG2NEbh1UQn0Ord10zu7jTmGUeAcyjJh5TWieppiB+UhzC2ItOnp08LCb22ZzKEBjU3gf3A++3g6pzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=py1r3LTh; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="py1r3LTh"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c1092cc08cso3502771eec.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774734009; x=1775338809; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5tXhwNfdq6BdKs/5d+O3WRrWqvdy2R77z5kQHlRzrE=;
        b=py1r3LThe3wBOypP7yF2a8HszdfmUg9vQRtmB4kCtJWPJVlhBkD94obNgsV5uNTrIX
         x+HRol75Zoc9Ik5eH0khPNIohyPxUd824ClXKNaXyKESLH+xxfQ+9N2YOwjksP34BJRI
         ifredP9NRg72KnLsfW+2NLCsIe4MT4V9mlEapJHzM+PRwp3t8VIYmZiR5bM6ZkIGE/64
         L2XBe0KN3ivba5C8caDaZiPOkK8sUGz1Q2j7DeRdo3TEyz91dIQ+HURTYUYqTuW27Plj
         nSXukpOOe9ZdTkOeI3bntQJCo8Ixq2PD6C9+6IhVYcLq9D7LdwOSLGb6g7apBg6MBkeC
         hphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774734009; x=1775338809;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L5tXhwNfdq6BdKs/5d+O3WRrWqvdy2R77z5kQHlRzrE=;
        b=Ke7YRSBgPh4rZjEAHI+zZlDRts9Exx3pRwKhH9hOyPTEIQ0vVjb1oDximkHfpv24iS
         Tw5s1vm9IcDBjcpbMSv9E+1OSsHPez3AAeydkz4/6Hco3veHAQLGhDqG4+kXk6uePPZh
         M/3/4B9nYJn3TPjwXHv6dVzVL5Ts2P7RnoEBIjoxqC6lz255Mur3tXNryGXG1krZDOtn
         XrskYljQ3rdK+87rl+hej4pQ3C4unqY6YmuWXWir7Lox67no3vwklEj/S9hJIOL7YHPU
         0nbV07YpPKQT9AUshM0pKjCr0fp9ZofGmieGCSKVbFqaVYds8Nbrxx9/c9O8sM6TcrsO
         7rfg==
X-Gm-Message-State: AOJu0YxuM22qHkYmXDEElXJWWD89fQ60E1qf4pWFuVhpru9FKs05/mNK
	fFHWdhfWvm2Esb8zoR4qfFNOItC4ODLbT+LoOe0Xosr2yLpkt2kClpq1uK2c1A==
X-Gm-Gg: ATEYQzwiDdyedYP+cnjxk9BQkMnaQpC5aMnzdt+QtHSemjUHsZPSkj80BAHiRCQTcc2
	u0HTIGfSEePAYoSPvY1CK3BOQyUaLTw5KanyfKhGk7OV7PkeqmyLjQE0PY/KnOcpssTgo0Daf3O
	gSyhuGOD3/Vu/IXkau1DdqoQnV09n9O/44ivwKJiGSYln9C0reCDPhlFPnTx+vhQ5hfaGQe3dDF
	VvGk6kAPBPhP+Kjo3MoUSVCs51DHkN8yxu+BCTpaRf8zNDZ75cKFYE7X096xKkxhT5Z2xhiefJQ
	4pAq9j1okX+sbxHUryfyWAD9EQy4hgNDx/7tRKl/BYwvmZ63La7+eMVY7ZTwixH5ypTBRUxvpmU
	8ckl4eOpUdPzQ5iuJP3DReAMGG0Fzj/EWdvUQ9IkUhNjdeQ8+G4y8MXX8nVQvIcXeZrM8JrprmP
	0tialta0Uk6Bk9p6Z+5VDr0CtSCiVF
X-Received: by 2002:a05:693c:2b13:b0:2c1:778:d897 with SMTP id 5a478bee46e88-2c185dfe901mr4070474eec.21.1774734009443;
        Sat, 28 Mar 2026 14:40:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.209])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda147sm2967504eec.5.2026.03.28.14.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 14:40:08 -0700 (PDT)
Message-Id: <d684d938fb794fd858d49665e2b5b03aa0319f06.1774734004.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2251.git.git.1774734004.gitgitgadget@gmail.com>
References: <pull.2251.git.git.1774734004.gitgitgadget@gmail.com>
From: "Dhruv Arora via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Mar 2026 21:40:04 +0000
Subject: [PATCH 2/2] fix(userdiff): sorted pattern and tests
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
Cc: Dhruv Arora <a_dhruv@outlook.com>,
    Dhruv Arora <a_dhruv@outlook.com>

From: Dhruv Arora <a_dhruv@outlook.com>

- Typescript pattern was not in alphabetical order, causing failing tests.
- Added 3 new typescript tests.
- Fixed pattern bug - incorrectly identifying const|let|var instead of
function or class.

Signed-off-by: Dhruv Arora <a_dhruv@outlook.com>
---
 t/t4018/typescript-class-method         |  7 +++++++
 t/t4018/typescript-export-default-class |  7 +++++++
 t/t4018/typescript-export-function      |  7 +++++++
 userdiff.c                              | 28 +++++++++++++------------
 4 files changed, 36 insertions(+), 13 deletions(-)
 create mode 100644 t/t4018/typescript-class-method
 create mode 100644 t/t4018/typescript-export-default-class
 create mode 100644 t/t4018/typescript-export-function

diff --git a/t/t4018/typescript-class-method b/t/t4018/typescript-class-method
new file mode 100644
index 0000000000..6de6eff2e7
--- /dev/null
+++ b/t/t4018/typescript-class-method
@@ -0,0 +1,7 @@
+export class RIGHT {
+    unique = 0
+    constructor () {
+        this.doNothing()
+    }
+    function ChangeMe() { }
+}
diff --git a/t/t4018/typescript-export-default-class b/t/t4018/typescript-export-default-class
new file mode 100644
index 0000000000..aaede0dce3
--- /dev/null
+++ b/t/t4018/typescript-export-default-class
@@ -0,0 +1,7 @@
+export default class RIGHT {
+	private x = 0;
+	private y = 0;
+	private z = 0;
+	// ChangeMe
+	render() {}
+}
diff --git a/t/t4018/typescript-export-function b/t/t4018/typescript-export-function
new file mode 100644
index 0000000000..ba5bf71e80
--- /dev/null
+++ b/t/t4018/typescript-export-function
@@ -0,0 +1,7 @@
+export async function RIGHT(url: string): Promise<string> {
+	const a = 1;
+	const b = 2;
+	const c = 3;
+	ChangeMe
+	return url;
+}
diff --git a/userdiff.c b/userdiff.c
index 086e3fa002..7f5cadb30b 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -337,19 +337,6 @@ PATTERNS("ruby",
 	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
 	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
-PATTERNS("typescript",
-	/* Starting with optional whitespace */
-	"^[ \t]*"
-	/* Followed by an optional export and/or async keyword */
-	"((export[ \t]+)?(async[ \t]+)?"
-	/* Followed by either a function or class declaration */
-	"((function|class)[ \t]+[a-zA-Z_][a-zA-Z0-9_]*[^{]*)"
-	/* or */
-	"|"
-	/* a variable declaration with const, let, or var */
-	"([ \t]*(const|let|var)[ \t]+[a-zA-Z_][a-zA-Z0-9_]*[ \t]*=))",
-	/* -- */
-	"[a-zA-Z_][a-zA-Z0-9_]*"),
 PATTERNS("rust",
 	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl|macro_rules!)[< \t]+[^;]*)$",
 	 /* -- */
@@ -367,6 +354,21 @@ PATTERNS("scheme",
 	 "|([^][)(}{[ \t])+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
+PATTERNS("typescript",
+	/* Starting with optional whitespace */
+	"^[ \t]*"
+	"("
+	/* Followed by an optional export and/or async and/or default keyword */
+	"(export[ \t]+)?(default[ \t]+)?(async[ \t]+)?"
+	/* Followed by either a function or class declaration */
+	"((function|class)[ \t]+[a-zA-Z_][a-zA-Z0-9_]*[^{]*)"
+	/* or */
+	"|"
+	/* a variable declaration with const, let, or var */
+	"^(const|let|var)[ \\t]+[a-zA-Z_][a-zA-Z0-9_]*[ \\t]*="
+	")",
+	/* -- */
+	"[a-zA-Z_][a-zA-Z0-9_]*"),
 { .name = "default", .binary = -1 },
 };
 #undef PATTERNS
-- 
gitgitgadget
