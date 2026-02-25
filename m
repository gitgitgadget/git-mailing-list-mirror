Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749D31197C
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046222; cv=none; b=o/Tvya0esq4WX6bt7sFobGsPwQVhnytxOxYeppQtvUWHO6jo+GGjr8KjRwxUpLj+0HWLQysT9v7370LuIDBZ4GezxuUoTVoUHqpSz5liODTteGd63ydIoxCwvDohnQ7u+juauo/B209Bcd6QNfCBZpTgqoxMqaXs6DxUCLk1Q2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046222; c=relaxed/simple;
	bh=LqzCuGDZy5KYFZjhTgjBzAYM1OYk3NIxzmkfTaT6b/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eRqxdyyqeLFTpyZ2ZOPX/eZcmvsomlz4VCFn1/hCrRpoHT5L91ZIkYiiZYu8c4fiZyXnGGrG6ErCxq/3IhEWR0I9V2pUhlaMCfGUL9aqzGMulVWZx0txtpSh1TkoXgvcVPD1GdJOyaCDlyvziXaww9eFzIMZfCciVbHuYt/lE0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSKn4hIr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSKn4hIr"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-823210d1d8eso49253b3a.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 11:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772046220; x=1772651020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/1up2EzajAZhZetwYPArw1mSz4vjXsyzFnT30DwVT/s=;
        b=eSKn4hIrq8XawxU+UW/4u5cJL5Cj+c3w05lKePcMgIvSKgT9n8Ye+8IMkFUKa5iDPK
         BndOZIIDxhrFDuLOriJ34+MFK+vmGRyUTfVprEB7sDU/gG3XXmmQyU8LIsSDTGVLF6PW
         NL4gY2Y0K4nM3ubmUSW42+tPtwdV3CuZZ/vaU5sQPDkEJBq68JscqJJUb7Qdny/ppYUA
         tMX1Kz5GRMbndaHaOP5lymttvCrwjLZFiVMnZwaz260xiK0uzQGwrKB6zea5VuxUwG7G
         7E0W7g2BN/4kcv9/NW1/3RYh/nngjx/8/0F72BjBmYHVC38mi31fLu3jCTGTF8BibT6Z
         Z+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772046220; x=1772651020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1up2EzajAZhZetwYPArw1mSz4vjXsyzFnT30DwVT/s=;
        b=XOh+2fo0CrObtC7SeFh9+nHGLeQQwe0mQ24T8zjHRYmUnytEbRGeNpZO/H9JKGuatF
         hOz5ZV/7ziqjPReREdmHFxp2DaLF6c3tNAvGToIW/qqdYc9aplXmZ96SypqyA4vSopTu
         9hDusduw2eupPjNmoHro8pfJ9rWbxO3UxdtdXVpcIVlAIv/rNnebN36DDbJ5hbq5x772
         V+W9RwTsQ3Hq12V5pRidhlPwedMJGJDzxW1U5c7ISTqBxr8TN5jq/HcWfWNGK0I6U9Fy
         xZrdtzhBnbbIdkaxR+YVNfaUS+uI6QenXR1EUbeOoDGw9kdZoxI8HVcJuEGAmhVvFYWX
         692w==
X-Gm-Message-State: AOJu0Yys2zdz8i68rJQtKvo0NOq4oSc3F+gSYwMJ0gNbg53q0AAVuwut
	SCFg6QyuJSngOA2P5wbQhxJjLjUtSAv7plcRI1WVOLHAxlvBm+0lUIiP3OGTwg==
X-Gm-Gg: ATEYQzyxMjROonttn7hxgI+WGTrkVG8qAcRhh8F/KqK5cTL4rvYzsRcyVkcneLWA4fL
	VP2VpcXJ8dbbPDZWs/O3mVX6SkjsPhQp/BZFD4uueTXiowLmxH698bdRxKfJR5X8bCqcl2muydB
	kSDV4nscKSsttb0Kq/VU44+98OZ1YTXFDjPkxPBKBgfgRgAvz85tYb0O6NN7YIEjf7ZmIbaIGck
	Qf2ZdCL84zImc6CL7b38CZk6hdNJkJQ+jEYrYom9dVhKxFSFi0gIQyvoCozFxHB0FUQLbnhZMN4
	o1Al8DBFJv7+CmxTFoCS7rfkwTJey2Q7vYPsmTi9kXDujPImUSNDlb/2vDjc6XzxmYRM+JfrU2C
	tyv0TETKjpnSeUvKnvydeWmr+6lPINLOdhvIOasILzRfnzOTOowL1WUk4IFZ36fIurim2v2yxwR
	4yOF/W2W17QVMGSA4ppgb5EQTNTmt59WVJDqt6RYuQ0ynr383/OEU3SH73iEpGrcHLoKmuJBllg
	KkaIdmd5ydojX5dMn7Up9vabm+kOGqVn7US0wHbFZXdpalouevpazlCp4BH6c9LzFmHoXqWOp5v
	ZdCSW+o=
X-Received: by 2002:a17:903:19eb:b0:2ad:ba3a:3827 with SMTP id d9443c01a7336-2ade9aa6ec2mr13490965ad.54.1772046219671;
        Wed, 25 Feb 2026 11:03:39 -0800 (PST)
Received: from localhost.localdomain ([2409:40e2:1f:68ce:51ab:ae14:d451:e822])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adaa3d0f6bsm56101345ad.12.2026.02.25.11.03.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 11:03:39 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: git@vger.kernel.org
Cc: SoutrikDas <valusoutrik@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSOC RFC PATCH] builtin/repo: add path.in-worktree field
Date: Thu, 26 Feb 2026 00:33:04 +0530
Message-ID: <20260225190306.39358-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi everyone,

In this patch I am trying to provide the equivalent functionality of
'git rev-parse --is-inside-work-tree'
I found that I could either use the 'is_inside_work_tree' inside setup.h
which does not take anything , or use the 'is_inside_dir' from dir.h
and use the worktree directory in the repo variable that the function
is getting. 

I went with the latter because the former was using 'the_repository'
inside. 

My reason behind adding this is because : [1]

> Add path-related values currently obtained through git rev-parse 
> (see “Options for Files” in git-rev-parse documentation): 
> git-dir, common-dir, toplevel, superproject-working-tree

Since its intended for repo to have more path related values, then 
'--is-inside-work-tree' would also make sense. 


Although I am not sure if 'path.in-worktree' is the best name for it.
Also, I did run t1900-repo.sh and it was failing one test case,
which also ran with an ok when I added the new field to REPO_INFO_KEYS.

[1] : https://git.github.io/SoC-2026-Ideas/

Add a 'path.in-worktree' field to 'git repo info' that indicates
whether the current directory is inside the worktree or not.
Equivalent to 'git rev-parse --is-inside-work-tree'.

Signed-off-by: SoutrikDas <valusoutrik@gmail.com>
---
 builtin/repo.c  | 8 ++++++++
 t/t1900-repo.sh | 1 +
 2 files changed, 9 insertions(+)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..3eb7115208 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "dir.h"
 #include "environment.h"
 #include "hex.h"
 #include "odb.h"
@@ -61,11 +62,18 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_path_in_worktree(struct repository *repo, struct strbuf *buf)
+{
+	strbuf_addstr(buf, is_inside_dir(repo->worktree) ? "true" : "false");
+	return 0;
+}
+
 /* repo_info_fields keys must be in lexicographical order */
 static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "path.in-worktree", get_path_in_worktree },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 51d55f11a5..d793d1b8e2 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -10,6 +10,7 @@ REPO_INFO_KEYS='
 	layout.bare
 	layout.shallow
 	object.format
+	path.in-worktree
 	references.format
 '
 
-- 
2.52.0

