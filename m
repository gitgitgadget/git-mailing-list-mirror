Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116185;
	b=Jp9cDbm9ewqigi2JIUKcpgFnNRQgeXANmJ2UupG9HF4xAxveBrN+BLBhZxrEEwvOP45h
	 sxxHvVePbqOdWxqcIhOU5zSGeAsL2/wGBxDXMFw3ztLRqHIfRgFfDZ8tsV1cGQG2tV8B0
	 ayoRLtvTsWvHLiZfS2pwHzfKcQ7M5nqeB/0oQ7zFe/MmjC0lOyOmmoL68O78brkMaYadF
	 v2ckXccQ0q2dftEXGoHL5/Fa6I37SFClx0/Qy5pFL7/iWqozFtRMdWtqt4ZWyN0IOk/MB
	 DXjy5czkJ7SoTLQPF6gWg6gEiF8ZOH5F0Y/yw9cGYvMz1PNh+Stmmu7TIoqA9ECHnxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=iTfr4+i5OneiGGLMo+O7xfdZ15OGfSVPrHzTzCcOMVs=;
	b=s6aROtVdjCCTys83fdgdnZSt2cJCFCqbNgQINwCjLGFOhLr2MDMq24lPMR1D1EzWJtO3
	 BU4hCJHCfCJdbCD88kmPHHCiaKx3j2o6kiznpT4XaOF72xshrGAJ3xu4ZGr62FgbqOiQX
	 U3mZJRMsdNnsYDBhnWahLSrrRLlOSVLX/GeO90wp+SeoKVa86ECyMvHF3ecMcGVPSFz+I
	 TQ4pSoge7+HhNhaZNoVubbwqbnqQ7ECF33kbcCS7wkfj1uSzd48pIKt4o4+UkODIOgcgz
	 y3oAN1sGIpayZEDM/4g+kxcYTwfosAEITPMAhIOpolpFq2fb6XuqEmgDtYJJ+mGDuiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R3B66Exl;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B8B606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 19:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95B8B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=R3B66Exl
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4b9fde3044dso341245e9.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116184; x=1795720984; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iTfr4+i5OneiGGLMo+O7xfdZ15OGfSVPrHzTzCcOMVs=;
        b=R3B66Exl0LI7tf56Nk2M7rdZ6QYjEBsV/k41YnLE4llCzI6Ilx927T0KcV2rmfdP2N
         wZwnQcNgV0/DlJo7XcesVveCiTzQDG83BOK1C2jyNMhP5GgxRA0qCSKSl+W868JiOGMD
         CfhBXG4h6TDaAzXP1wmPR0RTZ85iVzA3Uo9nBpwv1/t8+Lw7PZUuxoYIrlDNFD71jdBL
         UvH0x7jmKdeaRPpFT46hTZpv+wZt9XRHhZKU5dvj9d55kEbWBn+jG99Yo5yar3w6ekIt
         2KdFtSvmo6AiAJZ21Vz8xJK3i/ikr30XYU/HwIUgVOjZgzM++v5MLeEBqXYG6idBMNfB
         KJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116184; x=1795720984;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iTfr4+i5OneiGGLMo+O7xfdZ15OGfSVPrHzTzCcOMVs=;
        b=Gl9UEFkJ7XGMpEXikTRDmivFKTvIt4TPJrXjIKc2ZsIhxhxaG3NrdTf/b6vLYQp3D0
         I0mO9EHcJrMsjjybU4HbOXCdllcLsRcdLX9IN+9PcW8fCnGdHfdtmCmWMU9+p6lCkIUm
         HDIxd2L4jEqCq6tHdnU9MKxWSidUdOvpzbF4R0WCshmlzl9Tu/6kXYovjBjeF7f+YUuu
         cDbtb3WsqnOc72T7eQH313sJKAjDnCgUzcLEr+LWKRDnl+tzX2Nao/UpT8S8dM5bzP5R
         thX1wlOmwyEYdYG70F9BHyesH7Sud0JyxG3hx2CmggpsKYocm2sVk/Tx8ZLwox8QYzFV
         VmHQ==
X-Gm-Message-State: APuU4Z/peYrcynfoHnzeiZVObIeA9M2JctgMO5zjq8+WLxfJK9ZW5cm7
	brEaa3SbIfl13WRC16tgcu79lbtSk8Oin0UHzGODvc0KX63dNfdnx3sE8pYydOEM5WhB5AUydIT
	eKrqJOI0NaK7nonbwIJSYW0VR/cIRheVfZ0IM4Tv1jxVwJV41flcCiVAOGv3Kdx/SWfUOo4YeqA
	vAXyhFEbamWOPRo89pH7nzGA==
X-Received: from wrmz5.prod.google.com ([2002:adf:e545:0:b0:49a:19b9:9a09])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f4e:b0:4bb:6c71:b268
 with SMTP id 5b1f17b1804b1-4bb8882672fmr13225445e9.6.1795116183739; Thu, 19
 Nov 2026 11:23:03 -0800 (PST)
Date: Thu, 19 Nov 2026 20:23:02 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119192302.2681052-1-dmnk@google.com>
Subject: [PATCH] attr: do not traverse leading directory symlinks
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
	Elijah Newren <newren@gmail.com>, dmnk+artist@google.com, Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 2ef579e261 (attr: do not respect symlinks for in-tree
.gitattributes, 2021-02-16) taught read_attr_from_file() to open in-tree
.gitattributes files with open_nofollow() so worktree lookups match
index lookups and do not follow symlinks outside the repository.

open_nofollow() only checks O_NOFOLLOW on the final ".gitattributes"
component. When an explicit path such as "symdir/file" is passed to
"git check-attr" and "symdir" is a directory symlink,
prepare_attr_stack() still traverses "symdir" to read
"symdir/.gitattributes", and builtin_object_mode_attr() calls
lstat("symdir/file") across the link.

Check has_symlink_leading_path() before opening READ_ATTR_NOFOLLOW
files in read_attr_from_file() and before stating paths in
builtin_object_mode_attr().

Signed-off-by: Dominik Maier <dmnk@google.com>
---
 attr.c                | 10 ++++++++--
 t/t0003-attributes.sh | 10 ++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 0e63f1b6de..50e25a3ee6 100644
--- a/attr.c
+++ b/attr.c
@@ -24,6 +24,7 @@
 #include "revision.h"
 #include "odb.h"
 #include "setup.h"
+#include "symlinks.h"
 #include "thread-utils.h"
 #include "tree-walk.h"
 #include "object-name.h"
@@ -699,10 +700,13 @@ static struct attr_stack *read_attr_from_file(const char *path, unsigned flags)
 	int lineno = 0;
 	struct stat st;
 
-	if (flags & READ_ATTR_NOFOLLOW)
+	if (flags & READ_ATTR_NOFOLLOW) {
+		if (has_symlink_leading_path(path, strlen(path)))
+			return NULL;
 		fd = open_nofollow(path, O_RDONLY);
-	else
+	} else {
 		fd = open(path, O_RDONLY);
+	}
 
 	if (fd < 0) {
 		warn_on_fopen_errors(path);
@@ -1274,6 +1278,8 @@ static const char *builtin_object_mode_attr(struct index_state *istate, const ch
 	if (direction == GIT_ATTR_CHECKIN) {
 		struct object_id oid;
 		struct stat st;
+		if (has_symlink_leading_path(path, strlen(path)))
+			return ATTR__UNSET;
 		if (lstat(path, &st))
 			die_errno(_("unable to stat '%s'"), path);
 		mode = canon_mode(st.st_mode);
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 582e207aa1..c252e7ed55 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -533,6 +533,16 @@ test_expect_success SYMLINKS 'symlinks not respected in-tree' '
 	test_grep "unable to access.*gitattributes" err
 '
 
+test_expect_success SYMLINKS 'leading directory symlinks not traversed in-tree' '
+	test_when_finished "rm -rf ext_dir symdir" &&
+	mkdir ext_dir &&
+	echo "* test" >ext_dir/.gitattributes &&
+	>ext_dir/file &&
+	ln -s ext_dir symdir &&
+	attr_check_basic symdir/file unspecified &&
+	attr_check_object_mode symdir/file unspecified
+'
+
 test_expect_success 'large attributes line ignored in tree' '
 	test_when_finished "rm .gitattributes" &&
 	printf "path %02043d" 1 >.gitattributes &&
-- 
2.56.1.750.gf70dc682cf-goog

