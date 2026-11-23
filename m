Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428612;
	b=V5F0qMjmsJ3yoZoie1XTdL8xhxdpxzrfAZJHPOvC80ksHi6cDX1GdXudwoyz7n9GM4MC
	 HI7BfsJrKW+ik98Y9/DCJuMkuPBZNvKes298mmofwbbWyfp85a2mq6UfThTIzfyoIJqWP
	 suR5KHJmf3CBeSqNKKE6haJZsSWb42vmyj79QLIZyRTW5XJp3W31iDiN2gM8Lsagbiy63
	 aMecFqsXSP36S/nTwrMa0arjzsExHibD/EM8vTqC1dslJLLyb4uSQ2zanJ70Nhu9CWhvt
	 pXqn5JlhtJ8OiCEtOGo0hcmFyxVzAhmnTFDcaiIzfJISeEBzmyJJveWGh8R4xNBEZVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Fcc:To:
	 Cc;
	bh=WdH/DK+uxOQfdZp0un3Oy6UBAoa+HneuUm/CAV3l5pk=;
	b=1Li/R2lH9k6tGeBv8mEVfHOb8/djJ4IuxHsgOWga/IwvCKDDFlloIaQoG6mzE1qgz2E0
	 qDUrfUHnSYTM1xqCxdxla4e+xAoFxDNfVO7hhY3ztnqx7e0BiMZj37cq8a/GRW7KF3Zrd
	 Q6Vch2lU+HLWkJxnDBc7mbftUcJPGLaMCVuNVEN24d5RVdY9hc5R5xMbv9Rj1RMCaWaO2
	 l8wtH2xiBk+dH3Df1hj0+JdTOoD1AVPjd2u+8qkoCTbCZOyBl8D2nUlg30uf7+gWVxc/o
	 6LXEffnCKiMt4lvkjairrb1/qMyYdVGmDQT/8T8y9Z2752oEQF7JZV6uwnO2D71DMrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sfaqsXur;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22854606A31F
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 10:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22854606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sfaqsXur
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9211bbce3abso26180496d6.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 02:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795428611; x=1796033411; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WdH/DK+uxOQfdZp0un3Oy6UBAoa+HneuUm/CAV3l5pk=;
        b=sfaqsXurKrrK5E2c7j4MojjKqM7v19DHmttKonAc5ALE7b7l4f9AKf5R/Ec9s8Bxvn
         MP2K3O/lPjhfmS64OihVMw9cTajPB6Ag1QCXjwRiZaOkmOOGTYsEyPhZGk8ZW5VSuAZt
         kYtzI3QRBfqNV4GrpZCKPvb5Q7b8PsEoNLdqaGD3rCc14ivXJXmjnapoV/BIj7MeoGgF
         ObTYIBoJRJZ0MPliAjz1n6sNZyVPH3hItoB4HDwawOJNlAH/+cKEo60Vg9KedBPPWQck
         xUIjS0QpzTnVVDRIlIfgJSEa//5DJEqqZh5jraHwRtbGc4bcDnlp1V7d0lITiPOsQqHz
         WtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795428611; x=1796033411;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WdH/DK+uxOQfdZp0un3Oy6UBAoa+HneuUm/CAV3l5pk=;
        b=Du6GHUo2rfBXi3JNXhzXyBei/TGKEayfF+dxXrD6dbKrOncqEhwaf6XWCXiU+OMcTu
         DlCy0YiswMIZWmZeZInWogNGlAdC+yw4S2gOID6QVM8tcvTddO6SvWF9lVudRe657Gmn
         N3WBDIcGKmYqF8B6cTJSOUbAZ/Wuiv2NOBLsH29OywNwOi9GxAE1JsHmScfxW3CN34TM
         4O5lyOpOloljvwXpB990JM9T//Xwlj7vdNvveexI+BcpSPN57VYWWOzk3JkXqS28CTGc
         EDSPnIgdyvr9sOM0ydhNwVikKl7aZzLfxowbzuooDxZZyvZvxF8EbNtxhDMxnO6fPyyj
         D/4Q==
X-Gm-Message-State: APuU4Z/6FT0sjQN27Xfmt6PVqsS/EuQhRoj8YIMixchfvn4dL4cD/4kf
	ZMqqhpeTAb8yW6VzUvHk76E9NBHJdRUDOBVN3SLnSKQ3FJe58wIE+vNcZHW1yg==
X-Gm-Gg: AZFdTZdCmNwAYXCUv6swItbHUxJeGCEONpa+WIXLZ0L6a28Us9w7d7TgjeGmFsrZIpj
	56jdKZNrHiXdQYRepVnV3JqZ1U5JXr3qohDAtYZxBEY+ibSaloPE0t3iyyeDmESRRkW4NkrCRDb
	sxzIPCbN5ZLJiUNm8AydvVj2i5JVAWp+TAztNQXMFbKNxVR6CQ88Or9GVQCuJr/5U7jznCrHeVh
	ZGVGoc4tJOyXQqsY5sIeSptlDgDnhB++LpcMAXKM51yZjg5K+ccSsfcAPDiYzW4KH1aZNEjYL+J
	udw2UhnyAPyNPqNO7KAFCBgjQlTcFSvYxSyQH5DKiGxmZKCcuIWF9keeBwmOWQWx0zc95eIgTGE
	ymwAUyOJ+KMk8blGVSem+lJyVsAU9jon5yW9auAU/ICY+vHG+649QXk6oVsHT9XYEmOJEzybwrw
	lfVltEcbXQQN6KClFuAryemOiaqSUXF9tEOdLjcKMDUueHCLTg7lQVusX9pShy/12O8mkF3lLyr
	8z/kpNgBZ/zygZBvjBkQJcbeYPuDG8MM5m5IEdvNfX53jG92jG54/82D/DJztXsXlwBoahXHN8h
	HOpG1ykrWIfo1gDAlv9weQXZdhvdcg3k
X-Received: by 2002:a05:6214:268f:b0:921:427f:5a56 with SMTP id 6a1803df08f44-921427f5b5emr134276096d6.39.1795428610942;
        Mon, 23 Nov 2026 02:10:10 -0800 (PST)
Received: from [127.0.0.1] ([20.55.126.152])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b253csm102695296d6.15.2026.11.23.02.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:10:10 -0800 (PST)
Message-Id: <pull.2325.git.1795428610006.gitgitgadget@gmail.com>
From: "Kasper Lind =?UTF-8?Q?S=C3=B8rensen?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Nov 2026 10:10:09 +0000
Subject: [PATCH] doc: fix typo in git-clone --no-tags description
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>,
    Junio C Hamano <gitster@pobox.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Kasper Lind =?UTF-8?Q?S=C3=B8rensen?= <kasper@portchain.com>,
    =?UTF-8?q?Kasper=20Lind=20S=C3=B8rensen?= <kasper@portchain.com>

From: =?UTF-8?q?Kasper=20Lind=20S=C3=B8rensen?= <kasper@portchain.com>

The description of --no-tags says "the option will be become
permanent". Drop the stray "be".

Signed-off-by: Kasper Lind Sørensen <kasper@portchain.com>
---
    doc: fix typo in git-clone --no-tags description

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2325%2Fgoibon%2Fdocs-fix-type-in-git-clone-man-page-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2325/goibon/docs-fix-type-in-git-clone-man-page-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2325

 Documentation/git-clone.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
index dd3b44817a..0a68872576 100644
--- a/Documentation/git-clone.adoc
+++ b/Documentation/git-clone.adoc
@@ -301,7 +301,7 @@ corresponding `--mirror` and `--no-tags` options instead.
 `--tags`::
 `--no-tags`::
 	Control whether or not tags will be cloned. When `--no-tags` is
-	given, the option will be become permanent by setting the
+	given, the option will become permanent by setting the
 	`remote.<remote>.tagOpt=--no-tags` configuration. This ensures that
 	future `git pull` and `git fetch` won't follow any tags. Subsequent
 	explicit tag fetches will still work (see linkgit:git-fetch[1]).

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
