Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94313303A38
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813046; cv=none; b=ehxJlME4u9lvhLnX+zsDwsgz6pblLRzuk+eka7sRJlbKYr25w86H3w8j82KmNoGZdd0feMjSJRLTZQCXOmXt/6BT1eo5tDVBN59PIB28nwd2oGhepeHpCYfKSo3p5kegAGnE6vC5Vs3s5LsGmMHd5iBMDOtRwGvJUq1wwNJdFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813046; c=relaxed/simple;
	bh=6BxJNHVmapUhE8CmFSJC+0D5/VYP9DXlmMVkCIyl5Zo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BYmJpijsqGCjThoRyNdR1lxXUJW5F8vC6YBZSluukXzEF5GVkXnGD+s5UItGvRvk3JS6bY5/lmaOmC/K2Rg0zIlwo0I9KekF5WDDRoxaiTxPyDZ5n2Wyb6R1vpzUxWT8TXhBM1qV+fzyd1HbpRq0xr2HtQmrgxdyjHW9dm/zQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpyeFldm; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpyeFldm"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42486ed0706so5182185ab.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 08:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758813043; x=1759417843; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+H6qc8mvTPGjG0BAc9G2r7GIn56OElBrGsejPWmWR0Y=;
        b=EpyeFldmtRpcOLdNDfazjFooTNgzgcJfK5s8r6EZVJ3Tu2M1k7h1+OOwQleO/YMI9O
         BGZvRVQ0bYPI7oyZ9ynNV/LGNiZ2cYQz6NhP4Od1b6fpihZIMx2ODlDh++MVxmgmto8L
         2WxA5rVV9zAWrbjnzvvQarBJlTpXQzT1UbJU5syGb99gdLsbGOK2ycR2wTKBxsA5pbXl
         bM8rC9gwdMkJtK2eFwWXzB3yB+hEYs2bH1GNXJoniM6ZIlcmho4p45mYWC1uS2sSnV70
         x23u4tInlFd5+b3665SP5Gy7253v3y/p2F+z5F+MBSr20yvG5O8vwVct4COxFn1djYdc
         EJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758813043; x=1759417843;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+H6qc8mvTPGjG0BAc9G2r7GIn56OElBrGsejPWmWR0Y=;
        b=jDvvIWLPLcaBLob35xUJSGTm1BfvusjvUGMg8faEYUL56CdxY6X3NgBbujwHUrsoiH
         8UGyVsfOjUs/P5YyHVam2hJFcYmSmUtxbyUQkMi2gaVBvtXrmwkIxyhIgNqZkipfC2AU
         OrYdRKxg/cyFDIHWot/UtBs7zrGdX3Y8moOVkVfi6x6otSAnpfMB8rJJbJaPQ28Fbm/9
         k76cnyKiZtkkbESD4FEuizR2hPkAWHMgSvMnU8grwWjx+WmjXrdi/2Yo6ZImn7SKNkE/
         1sYqWj2VveFQq+f8XOX0lJtrOW2eCFb9I6H8CRNISzUDOWb5c2+CQpV1d8e2LXD4v+hw
         uixw==
X-Gm-Message-State: AOJu0YyOs7MnaYc7R5t+mObLTlctNGxbmW/OXNjD8UEe+XrYB7d9DdmQ
	Rp/5KUrj3ZoivaPqJ6WqfEZz4hdnjlQ7swoYfYXtVpUqkxBG8Wx/dq7LP8hq4Vk5
X-Gm-Gg: ASbGnctNzmFzOLc9GG+mjJifuqp0vT6ggiO/uozdu3oFuOEYDxDkxyScGpCfxd5YW2z
	MfyJoNU0AIKMfKFM1Pjd9CyxsgVCJDljN/z7TpYy6AAxknmZSvFTMWtqq6UdklHdxAuvEnYFTdj
	Um4ILRfI9BAZNmYvr/+kr6LceuszHNZfJtlqCSe/Q8fyzyZk7agmChKZAfSQenP319n0suSC3uX
	a6tYFox0cUPC2gYmd9eq+AR0jrTmtuent4LJrzr8YV6Ec8Iu5FQWE29CI8DNB/oN66VrqtMX9ma
	H/WZwRfJndi1bUysVk4nDWSfHZ+Cmf0mtEMdrUQWeZmokCveIJCQG+01elmOjOj2KHA5k3oI2dl
	0aBqu5xhh2gyCF6PGdaeeLdlaMA==
X-Google-Smtp-Source: AGHT+IHStSHcpQjNdBP504yd3LS5/Lc5o/d1oTioDnovBiYHuFqmJZtG5/zHKFyqxkBRKzjr1M4apw==
X-Received: by 2002:a92:c982:0:b0:3f2:a771:9fb3 with SMTP id e9e14a558f8ab-4259566ca81mr44008155ab.27.1758813043017;
        Thu, 25 Sep 2025 08:10:43 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.124.180])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a647da50fsm903635173.15.2025.09.25.08.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:10:42 -0700 (PDT)
Message-Id: <390686dbb3665b86d4651dfbc9dae0c3067e8745.1758813038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1863.v3.git.1758813038.gitgitgadget@gmail.com>
References: <pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
	<pull.1863.v3.git.1758813038.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 25 Sep 2025 15:10:38 +0000
Subject: [PATCH v3 2/2] add-patch: update hunk splitability after editing
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If, when the user edits a hunk, they change deletion lines into
context lines or vice versa, then the number of hunks that the edited
hunk can be split into may differ from the unedited hunk. This means
that so we should recalculate `hunk->splittable_into` after the hunk
has been edited. In practice users are unlikely to hit this bug as it
is doubtful that a user who has edited a hunk will split it afterwards.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 add-patch.c                | 12 +++++++++++-
 t/t3701-add-interactive.sh | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index 61f42de9ea..bcc2d7666f 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1185,19 +1185,29 @@ static ssize_t recount_edited_hunk(struct add_p_state *s, struct hunk *hunk,
 {
 	struct hunk_header *header = &hunk->header;
 	size_t i;
+	char ch, marker = ' ';
 
+	hunk->splittable_into = 0;
 	header->old_count = header->new_count = 0;
 	for (i = hunk->start; i < hunk->end; ) {
-		switch(normalize_marker(&s->plain.buf[i])) {
+		ch = normalize_marker(&s->plain.buf[i]);
+		switch (ch) {
 		case '-':
 			header->old_count++;
+			if (marker == ' ')
+				hunk->splittable_into++;
+			marker = ch;
 			break;
 		case '+':
 			header->new_count++;
+			if (marker == ' ')
+				hunk->splittable_into++;
+			marker = ch;
 			break;
 		case ' ':
 			header->old_count++;
 			header->new_count++;
+			marker = ch;
 			break;
 		}
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index a6829fd085..13739a4582 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1311,4 +1311,25 @@ test_expect_success 'splitting previous hunk marks split hunks as undecided' '
 	test_cmp expect actual
 '
 
+test_expect_success 'splitting edited hunk' '
+	# Before the first hunk is edited it can be split into two
+	# hunks, after editing it can be split into three hunks.
+
+	write_script fake-editor.sh <<-\EOF &&
+	sed "s/^ c/-c/" "$1" >"$1.tmp" &&
+	mv "$1.tmp" "$1"
+	EOF
+
+	test_write_lines a b c d e f g h i j k l m n >file &&
+	git add file &&
+	test_write_lines A b c d E f g h i j k l M n >file &&
+	(
+		test_set_editor "$(pwd)/fake-editor.sh" &&
+		test_write_lines e K s j y n y q | git add -p file
+	) &&
+	git cat-file blob :file >actual &&
+	test_write_lines a b d e f g h i j k l M n >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
