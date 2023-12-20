Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8D04878D
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqeV0Kjs"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso788385e9.2
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 11:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703102068; x=1703706868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4vBRaxFltk55qZMecDnU2U+SAJEiKaGs66ByRrDb8s=;
        b=MqeV0KjssaHeaiFIrvPZZBZvVlAMQ2uZhaSYZsejUChuS1azIF3Rhj8hYbnzgy/Bjs
         7GxupGbmosXqEIFSVQ/Bl2Ty5WRJgkn3/+nuFus3QC+WVxdxIxm41iPVypR3ymlfP2L2
         edu9dg0skMJt5FpsGi/tewYS2chvRDUEToO7NYLebkJIWX0YnojBsRDPcrrPUoBUmR5z
         2iuRoD4sS2XFyredZKIcG/FBjhEEWYRlzteqnQJ3MnwZLHgN6auKK4W3p3qOoF/XIlof
         7DRrK2WsAe6V5SNeSY0+Q2u2cGkgJz7gJEgBqBR5o9+C2rbkZG3ItvqpfyM1ir32ABDw
         I4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703102068; x=1703706868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4vBRaxFltk55qZMecDnU2U+SAJEiKaGs66ByRrDb8s=;
        b=nMxN6NR8WdUzAP7vXiWh5ygiXdBv9EidCHHBg4GDLLu0wFDFjf6jFGRo+0gmm7iaJ1
         L/vHdR2og9pjSFQ4VC3fzWlM9eNVTUK3feMqCQe0MONq3wsAEC52ju0aoJcc80/u3oUr
         QfZ2OKRqHe1pp5bRqw+kNArcbggeL99l7aENeq/SfZmOEMpZ0p611iDXJmk9fsMUAGCh
         +VepWK6dVMhVF4G1AvQbmdZLyjD772YPpIhfCHoVu92Ph/yxdsL5LcwunvmcFJNWjNoF
         JWey6yvulPVXhV/wfShJUuCaOFt2DOJZHe7EZGvJlCAYWk81dxjZSk85MSFzg8i+iwK+
         IYuA==
X-Gm-Message-State: AOJu0YzvZdOCLw6zWBdQj9alYypbZuHQWVXgP+TxOntHCNeiZN7zMF9C
	FApoO1sf3e6y9b5dDg3dKEn2sWlPZjphJQ==
X-Google-Smtp-Source: AGHT+IFmFEFGBEnjawOtR/AilkFelk3Z7KDyzPpLeZgXX2DDDMS5AXUCXJuSwHjihgpGU9nVKzrqPA==
X-Received: by 2002:a05:600c:21da:b0:40c:370d:71e1 with SMTP id x26-20020a05600c21da00b0040c370d71e1mr92451wmj.22.1703102067883;
        Wed, 20 Dec 2023 11:54:27 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd7-e0bf-0-e5b0-3039-5d18-ec57.ipv6dyn.netcologne.de. [2001:4dd7:e0bf:0:e5b0:3039:5d18:ec57])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c1d0a00b0040b2c195523sm8710001wms.31.2023.12.20.11.54.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Dec 2023 11:54:27 -0800 (PST)
From: Michael Lohmann <mial.lohmann@gmail.com>
X-Google-Original-From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: l.s.r@web.de,
	Elijah Newren <newren@gmail.com>,
	gitster@pobox.com
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH 1/2] Documentation/git-merge.txt: fix reference to synopsis
Date: Wed, 20 Dec 2023 20:53:41 +0100
Message-Id: <20231220195342.17590-2-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <c6814a39-b4f9-4b1e-b81b-45ffe4aa7466@web.de>
References: <c6814a39-b4f9-4b1e-b81b-45ffe4aa7466@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

437591a9d738 combined the synopsis of "The second syntax" (meaning `git
merge --abort`) and "The third syntax" (for `git merge --continue`) into
this single line:

       git merge (--continue | --abort | --quit)

but it was still referred to when describing the preconditions that have
to be fulfilled to run the respective actions. In other words:
References by number are no longer valid after a merge of some of the
synopses.

Also the previous version did not acknowledge that `--no-merge` would
result in the precondition being fulfilled (thanks to Elijah Newren and
Junio C Hamano for pointing that out).

This change also groups `--abort` and `--continue` together when
explaining the prerequisites in order to avoid duplication.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
---
 Documentation/git-merge.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e8ab340319..33ec5c6b19 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -46,21 +46,21 @@ a log message from the user describing the changes. Before the operation,
     D---E---F---G---H master
 ------------
 
-The second syntax ("`git merge --abort`") can only be run after the
-merge has resulted in conflicts. 'git merge --abort' will abort the
-merge process and try to reconstruct the pre-merge state. However,
-if there were uncommitted changes when the merge started (and
-especially if those changes were further modified after the merge
-was started), 'git merge --abort' will in some cases be unable to
-reconstruct the original (pre-merge) changes. Therefore:
+A merge stops if there's a conflict that cannot be resolved
+automatically or if `--no-commit` was provided when initiating the
+merge. At that point you can run `git merge --abort` or `git merge
+--continue`.
+
+`git merge --abort` will abort the merge process and try to reconstruct
+the pre-merge state. However, if there were uncommitted changes when the
+merge started (and especially if those changes were further modified
+after the merge was started), `git merge --abort` will in some cases be
+unable to reconstruct the original (pre-merge) changes. Therefore:
 
 *Warning*: Running 'git merge' with non-trivial uncommitted changes is
 discouraged: while possible, it may leave you in a state that is hard to
 back out of in the case of a conflict.
 
-The third syntax ("`git merge --continue`") can only be run after the
-merge has resulted in conflicts.
-
 OPTIONS
 -------
 :git-merge: 1
-- 
2.39.3 (Apple Git-145)

