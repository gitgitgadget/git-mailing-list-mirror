Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6566A269D17
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945543; cv=none; b=dF8E7yt/gYHZaOwBQENMdsvw5aS4sncbhEAqc1yUxAeE/bgbKt/ENfbSjryg37sL/y+YawIHw3PvUCsprh+SQmYXhg5UoyHryaP+l1JETxVYULuScn2Xy5ZYZgUnDcz27/KQltuesFtddk/EwFaYMWR8HapFhC7R1GbVi1gvuNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945543; c=relaxed/simple;
	bh=Rx+IWFiOi9U+zBq+NO8Yynl5AN1JAJZERx/mjKSB+Dw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a6fJXsvClvBuMWFaADcKprz1bII0r79w8omRZr/xDRSnxxzSC8QMMPugCc2Ex73WDLVc205XuEQxr/fqD4CuhVG1OFvirjDr5zf4Oj+pQzD9i1d0X6CCLFENmUcsQIwntKrpnwYbxsDkmc09WHi+etVypW/1SD0XCwKVLQ4yh40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsPKPlIy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsPKPlIy"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so1941135e9.1
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742945539; x=1743550339; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NX862AUOw2XXDICLlVHZCE9L8Px+F8OVvarM9gB1oFU=;
        b=DsPKPlIyzLxAr5N2r8jvXA2M1y81pJV2Oar6wzmDD7RLsPN3kbNs6PJgDkbHrMWKpr
         7CUK+RazPADxWUY08sou595anpPhL+RdOg3291A14sqFyCMUFi8GNX+n5PYqdp0WVIpV
         aBxAtMswyhLMod0gm85U7E9HFnc0XHpjV/aXDPoDAJ9Kn6rqz26WaMPp3GgKT+MumQ+/
         Oh7oq/Z+Yo3gEoFpzcqlgFGPtDpx4aINvenAXSHAwsYoQUUHrDgOnyv9mQ3H3h4Ws1/O
         Wj1U44FSK0y2EWebuV7RcfETKW//CPdCDVf+Z617KEcoFnQkYL7sZc4ZuPPSznTLfYwo
         bNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742945539; x=1743550339;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NX862AUOw2XXDICLlVHZCE9L8Px+F8OVvarM9gB1oFU=;
        b=dOA2kYUO1GcA5Mia6RM+F+7jRGp3DgGPU1NMjBz5jkCAlj4+TEHMToGaND8UZX+UhX
         P9JBqeVvv2vqH8KJDhml3DZpf4HBI/y6yJC9NQRICozI42+PAgyd+qtyaJAqzpQDgaXL
         hDnDxZr6A1KcYBXcjQB9SCmsJZbGcIjfqXUtAaAM91NJII6BIGSb/P1DiyCkY331j9yS
         GeKUY68505qmCJoYPOH4QrWKpaG/yHCvZDSvT2Cez5zyLjw6W+AWTkFVbA0zRrNBKB6N
         bRBP/gd0vHAZqSJLw4XEGjb8VD/vwL3bNskO3mTWZnBQ9sy9gpKp0hBAHF1Vzyxm2kAY
         DPVQ==
X-Gm-Message-State: AOJu0YwNjTZm5bdXVgtuZkYUOS7UpIp2j6FjipiBT0pZn3gnEo0SkR2K
	h0+fb56VUfURYTYDLmwNhqBgDydbgNR3QBE0lTSlLUKoTC2TYSiY82/aaQ==
X-Gm-Gg: ASbGncuviRdB3wZzIFekdMlLUzeoQ+Oc251JOJAJS+L4Z9bzIZgzppMH9yD8vZ1I6ho
	8CyZSkCraqUdiKRRYRN8aix823Eysr2f7qeAXvG9sSJ1zmK8c4Xg+O+XfBiKusjEgA/dzW3zYyK
	mnWoKSDQ+vbM/QUs8NOixI5f1pe1GLD8AJ1TC1GS5oEsB/EoXMy3RF8Q5inEUiH2tAXFrbqfGrR
	WdpznASdAfgigds4j3pVZ/BDdxOEzH4MC0sVIt7a130TMBCECZNgfgDDQOBrQ2nPw8Gr9XsDe9L
	A5bPEc5Ee3J99UjABxapGHWL+4IYPSHPMUr8qGNpbQYTJw==
X-Google-Smtp-Source: AGHT+IGbTXf4mEUZ/F3loGpZr5RlXQPiGLDawEbaU4BtULlqpjPN+uWwNmBF2VtQrjAtamHRud1xPA==
X-Received: by 2002:a05:600c:b91:b0:439:9434:4f3b with SMTP id 5b1f17b1804b1-43d775fac8bmr17019145e9.8.1742945539033;
        Tue, 25 Mar 2025 16:32:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a5b66sm14817620f8f.40.2025.03.25.16.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:32:18 -0700 (PDT)
Message-Id: <f601f4e74a5e8146f2926a725f3d1522b928eb51.1742945534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
	<pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 23:32:07 +0000
Subject: [PATCH v2 03/10] kwset: avoid using the comma operator unnecessarily
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator is a somewhat obscure C feature that is often used by
mistake and can even cause unintentional code flow. Better use a
semicolon instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 kwset.c | 54 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/kwset.c b/kwset.c
index 1714eada608..064329434e5 100644
--- a/kwset.c
+++ b/kwset.c
@@ -197,10 +197,13 @@ kwsincr (kwset_t kws, char const *text, size_t len)
       while (link && label != link->label)
 	{
 	  links[depth] = link;
-	  if (label < link->label)
-	    dirs[depth++] = L, link = link->llink;
-	  else
-	    dirs[depth++] = R, link = link->rlink;
+	  if (label < link->label) {
+	    dirs[depth++] = L;
+	    link = link->llink;
+	  } else {
+	    dirs[depth++] = R;
+	    link = link->rlink;
+	  }
 	}
 
       /* The current character doesn't have an outgoing link at
@@ -257,14 +260,14 @@ kwsincr (kwset_t kws, char const *text, size_t len)
 		  switch (dirs[depth + 1])
 		    {
 		    case L:
-		      r = links[depth], t = r->llink, rl = t->rlink;
-		      t->rlink = r, r->llink = rl;
+		      r = links[depth]; t = r->llink; rl = t->rlink;
+		      t->rlink = r; r->llink = rl;
 		      t->balance = r->balance = 0;
 		      break;
 		    case R:
-		      r = links[depth], l = r->llink, t = l->rlink;
-		      rl = t->rlink, lr = t->llink;
-		      t->llink = l, l->rlink = lr, t->rlink = r, r->llink = rl;
+		      r = links[depth]; l = r->llink; t = l->rlink;
+		      rl = t->rlink; lr = t->llink;
+		      t->llink = l; l->rlink = lr; t->rlink = r; r->llink = rl;
 		      l->balance = t->balance != 1 ? 0 : -1;
 		      r->balance = t->balance != (char) -1 ? 0 : 1;
 		      t->balance = 0;
@@ -277,14 +280,14 @@ kwsincr (kwset_t kws, char const *text, size_t len)
 		  switch (dirs[depth + 1])
 		    {
 		    case R:
-		      l = links[depth], t = l->rlink, lr = t->llink;
-		      t->llink = l, l->rlink = lr;
+		      l = links[depth]; t = l->rlink; lr = t->llink;
+		      t->llink = l; l->rlink = lr;
 		      t->balance = l->balance = 0;
 		      break;
 		    case L:
-		      l = links[depth], r = l->rlink, t = r->llink;
-		      lr = t->llink, rl = t->rlink;
-		      t->llink = l, l->rlink = lr, t->rlink = r, r->llink = rl;
+		      l = links[depth]; r = l->rlink; t = r->llink;
+		      lr = t->llink; rl = t->rlink;
+		      t->llink = l; l->rlink = lr; t->rlink = r; r->llink = rl;
 		      l->balance = t->balance != 1 ? 0 : -1;
 		      r->balance = t->balance != (char) -1 ? 0 : 1;
 		      t->balance = 0;
@@ -567,22 +570,22 @@ bmexec (kwset_t kws, char const *text, size_t size)
       {
 	while (tp <= ep)
 	  {
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
 	    if (d == 0)
 	      goto found;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
 	    if (d == 0)
 	      goto found;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
 	    if (d == 0)
 	      goto found;
-	    d = d1[U(tp[-1])], tp += d;
-	    d = d1[U(tp[-1])], tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
+	    d = d1[U(tp[-1])]; tp += d;
 	  }
 	break;
       found:
@@ -649,7 +652,8 @@ cwexec (kwset_t kws, char const *text, size_t len, struct kwsmatch *kwsmatch)
     mch = NULL;
   else
     {
-      mch = text, accept = kwset->trie;
+      mch = text;
+      accept = kwset->trie;
       goto match;
     }
 
-- 
gitgitgadget

