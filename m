Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793574280;
	b=Al5mEoWu90esYxE+SpnRwnzegSkvwrdnOm0aM37uhYA12tk/ZHpM1ej7VQbDf/HiDUVE
	 2UPwGVZQbo/ti7Uo9mcTlVe9Lf634lSjgbpUpjK8+3tUQtECH9MhwypiqqyP8RpOfJBgP
	 6uGr+7oXCbcMGgGMAn7uZ3VR/yj4b/UF8vBhoTbo1cq7SdErdr8VZGxzIjPNDfpwdcQzX
	 4rFY7NoUQaXtKohP39iWsd/AnrdZI5KcmmIDJ0jhwIxH1Yfp+Pu7glURJIBfQro6itrou
	 IASbVll14wnhvNA6A/ANOO/yCwML+LInjdYCd853j2Vwq0wtgS9co+wHryKJuVFxPcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i7l4idxl14LcOmNx+JKISilP7kiuK4tFz6E8oxTPaGg=;
	b=rRodNR3O1dg+UMh6H6D/TOSVdEssKLMJzvFA4uiYxBRDAU5x47PAmSgaNoJI7kKlPXAf
	 82k3p727wxx042g5dnNTjjLsTnq/yTvDs4w/FsWi23hv99fZUm8mFnafT4ZkYR3M2Zxb0
	 FkAXf3M98dOhYmFtwoo4DIndFSYjQ2j/wVmyZO0X2+jgJE/533UsdYHVCQJ9qr007e90g
	 hqtW/0/wLwdE6oi6GB4ctS9SM8P1nmBhR6XYPkdVL0bIMwXGX7nB4qdwahsIuDxGDt+gr
	 aYHz1cLwPIHokEpuDxj6lNDQpQc8oP6hgYRGGvCFOKdr2ncfcHkRUW7Vu516C85NzUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Gw/mWvaw";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96806606A332
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96806606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gw/mWvaw
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso10270485e9.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793574277; x=1794179077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i7l4idxl14LcOmNx+JKISilP7kiuK4tFz6E8oxTPaGg=;
        b=Gw/mWvawDOtzxQ10Ou87P+IUlcewg1GWDRVVZhaPlyE0MsDZBTge3hXuiNp0RyFYHT
         4bVqhh8rjRC3LOwBflesH7sJZokFcKQTSKUJglgduYpHTiC7laQWTSkCS/hWnl//zR/y
         9lb/hXu/A2LgiL8/qMnZeN0WjfPH9huR5lgeC0tZiwZQaQD1vPDoo4yAG3SG88eB34Uy
         uQHjsUXds8cgdRowUGfr0lwa5kRcrMWUMYdaz8nBnoADGtiaXxdqMA0HbIPcK/2ADA72
         pWr64QTjF98cjjbShFJvEUfdy4EiD/IWXG2WaNbh3fR6EjsEgRPZL1KNwC0fAmL1cx6r
         w6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793574277; x=1794179077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i7l4idxl14LcOmNx+JKISilP7kiuK4tFz6E8oxTPaGg=;
        b=UDjpMLRpse04duu6rRF6eJRP2PNaxxhGvcsZKBojTns9GIchNICohz67yKC1+JTOAA
         u0IpuOVc3nvn0mudQTNItAuzD23gH8JT81bsMjw4jrmwqiegoEhF5M+4BqBCjp9rc99d
         JE05vFVWIZaLI0yPiZZ5uaCaJgyGGmO5mebNQYpZ08yutSqPupx7pMl0YfuuJEnW9zOp
         ncdjGmQD7Yn+RdGIP49t9DoFJ9vaIMx1okeVng05etIwnN4vc2iJnW1noqYUrebK5iXo
         Wkw+yjbIVsZnj01whtx5u3M9Qe59hEFau7pv7YfyFSnpSkHdPGnkQt4l4s34F6RmP3oF
         Pc2w==
X-Gm-Message-State: AFq9FYImp0X2OuDDKiV6U0A9tUihtZGBJcXpnfR7G3XP5coeFP8zsVcj
	PGxC5h1WL8eB1N6T4c2C5WIHtwiHrWlqkbpumhpXi4phKHc7oRj+Gmt8wRfQ/gbt
X-Gm-Gg: AYBFou0i+yrizDBR4uGFuWMQT1/jk8yvX1Ik95pGb9ebsOyUe+hxAINSrB1sJEtwoSt
	3S8sYv0wRNOy9T2R/BXSNOuBMrAv6aAEeqLwnNNNVayrHzOQwR+QoIagn9serVfeyhIfBGBDFDn
	dey9qO/3oendSVnwX7+upg3meS7bXeGlWtRW7/cofytjEGWizi7x94h/vAHZkLXZ6ARzNgXjpF1
	dotjPG1G8ojwcItHrIJ2mKZgAez3SnD/NmKA4nIysxOdYHcfCZZzKI5gRtsG8qgCo2HRn34Ji7G
	Ky7UxUW/VGi/IbxSPE7qOgoUGqdMH8gOi9r7+HEidWoyJdtI3YCrywRSc++6ko9Oi6xPyNmlSC+
	N2aoSOr49hvoNX1W0iH/KfjB8Es1sCxdc26Z/FJQP0suzW/pKRs1L/qqpjyTs3q23v+heyMqw5d
	xBSBxgBi4DjWedgwhkmxLUutmXr3XSjVRuOvmNNSibB2ijNlKZKxryVIt8+J7FI0WU34YRHlmVV
	pJ5/D6kSVXScndOusTHoa1LhWqkt1Nl+LyYwtjVmA9qT8Y0dvg8mvd5gMpaA4TLZMm4MfjizOSO
	JL2aKbML3+ksfTMbAiNkFU0W0cXpCTuYHhkwg5ERMkBf1Npr0Q+weH+b/6eO5PF6epkd6q5rMas
	vt1DSrYhM6gMAtJmNvA3vaA==
X-Received: by 2002:a05:600c:83c3:b0:4a9:18f4:925e with SMTP id 5b1f17b1804b1-4ac174711afmr187425235e9.18.1793574277470;
        Sun, 01 Nov 2026 15:04:37 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0b4df257sm135151125e9.4.2026.11.01.15.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 15:04:36 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v2 2/5] doc: glossary: update per-worktree refs
Date: Sun,  1 Nov 2026 23:03:20 +0000
Message-ID: <20261101230326.3675597-3-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022212903.177261-1-andy.koppe@gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "per-worktree ref" entry says that these are only HEAD and refs
under "refs/bisect/", but that has been out of date since a9be29c981
(sequencer: make refs generated by the `label` command worktree-local,
2018-04-25). All root refs are per-worktree, as are refs under
"refs/worktree/" and "refs/rewritten/". Pseudorefs are specific to each
worktree too.

Bring the list up to date, and refer to git-worktree(1) for how to
access per-worktree refs of other worktrees. In the "worktree" entry,
describe HEAD as a per-worktree ref and MERGE_HEAD as a pseudoref,
rather than listing them separately from per-worktree refs.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/glossary-content.adoc | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/glossary-content.adoc b/Documentation/glossary-content.adoc
index f905b4467b..67fe49b26d 100644
--- a/Documentation/glossary-content.adoc
+++ b/Documentation/glossary-content.adoc
@@ -494,10 +494,23 @@ exclude;;
 	interface than the <<def_plumbing,plumbing>>.
 
 [[def_per_worktree_ref]]per-worktree ref::
-	Refs that are per-<<def_worktree,worktree>>, rather than
-	global.  This is presently only <<def_HEAD,HEAD>> and any refs
-	that start with `refs/bisect/`, but might later include other
-	unusual refs.
+	A <<def_ref,ref>> that is specific to a <<def_worktree,worktree>>,
+	rather than shared between all worktrees. All <<def_root_ref,root refs>>,
+	for example <<def_HEAD,HEAD>> and `ORIG_HEAD`, are per-worktree, as are
+	refs with the following prefixes:
++
+--
+ - `refs/bisect/`
+
+ - `refs/rewritten/`
+
+ - `refs/worktree/`
+--
++
+<<def_pseudoref,Pseudorefs>> are also specific to each worktree.
++
+See "REFS" in linkgit:git-worktree[1] for how to access the
+per-worktree refs of other worktrees.
 
 [[def_pseudoref]]pseudoref::
 	A name that can be used like a <<def_ref,ref>> to refer to an
@@ -791,5 +804,5 @@ and pseudorefs.
 	"working tree" and repository metadata, most of which are
 	shared among other worktrees of a single repository, and
 	some of which are maintained separately per worktree
-	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
-	per-worktree refs and per-worktree configuration file).
+	(e.g. the index, <<def_per_worktree_ref,per-worktree refs>>, and the
+	per-worktree configuration file).
-- 
2.56.0

