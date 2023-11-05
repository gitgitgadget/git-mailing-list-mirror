Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB385392
	for <git@vger.kernel.org>; Sun,  5 Nov 2023 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS77b3Lm"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E911CD6E
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 17:08:42 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32db188e254so2000349f8f.0
        for <git@vger.kernel.org>; Sat, 04 Nov 2023 17:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699142921; x=1699747721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGKSQFzPepLUi2rVAxBmF9LedmT2S5KIcvZZndPeWdQ=;
        b=VS77b3LmQqHd3zSoMZS/flALOtQJqY/KaUGd9tYJpyOQmlvcyAMtxyEZRz28J9rwpB
         UBGdLDORh2D1sIh4kb1Lp1cmxPa/l9cQAVTYg62rAS+sR8DnR12FJEptX8F/jUWSG9GA
         SRKSjcgCW1xI+7iPaBh5QO4yWruAUl0X1VY7U3omKRLmW+UV/WZLEPypuN2rYL36rrBE
         3FosipmWsuqgJApDmGM5x6Qe0lFq+nXt6U9AT3FDu6gZpLU6ieDlt1UcvaH6WBjznE8D
         7Fo2mmAVzCvSeKV9xI0SDXqVt3soLsUfN514GzROfew+AxyCfnXiUifIC0RS+RPL4+Vm
         3jiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699142921; x=1699747721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGKSQFzPepLUi2rVAxBmF9LedmT2S5KIcvZZndPeWdQ=;
        b=OCxaR68HN83xty4fkEcr6gtI28RarUxfqc7hMYY40TrVqfT7rZQSPK/6z4Ab621fyN
         NgH8o89ct4itIC0lL6gRVqSjz/tLvkOBupNj5dbnMaZ8QqEb6mbix/O2rXke0zmOstZO
         muCUsawTOpXNwypuxt2YST5UMGkAqb6Dri4Gpg20ys15xWLHO7hHKq+luFiQkCxtjUAC
         d41N4o5KLbdj63UcpTAMZgfbZl7zbxdYtNT8kqMMwnIOSLUpQDxKR5/ArR8Abd9zenlN
         HWZc/AOsaqczdwscXu4kx3vhKti0+SpGi5i4Yf6QzinxPsZ38rJMo1KZkVUk7I5LjEOd
         T/bw==
X-Gm-Message-State: AOJu0Yyz1QbDG+PfXDbQsEOMTgbWX3g0Wt2/Xvx1in8SBoKd3gymG3q5
	u6sxAT9+sRh2ggkfb341cep8vp+VTf+0uw==
X-Google-Smtp-Source: AGHT+IFY84nQcwH66xSKCt/COr5WObHFUqwndofOVGlsUkGTuqBAgF3utRzgWyDjM8mZmpt8Hxw53A==
X-Received: by 2002:a05:6000:1f07:b0:32d:9a8f:6245 with SMTP id bv7-20020a0560001f0700b0032d9a8f6245mr23927369wrb.68.1699142921135;
        Sat, 04 Nov 2023 17:08:41 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d438e000000b00327de0173f6sm5453111wrq.115.2023.11.04.17.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 17:08:40 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	newren@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 2/2] docs: rewrite rebase --(no-)autosquash description
Date: Sun,  5 Nov 2023 00:08:08 +0000
Message-ID: <20231105000808.10171-2-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc0
In-Reply-To: <20231105000808.10171-1-andy.koppe@gmail.com>
References: <20231104220330.14577-1-andy.koppe@gmail.com>
 <20231105000808.10171-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite the description of the rebase --(no-)autosquash options to try
to make it a bit clearer. Don't use "the '...'" to refer to part of a
commit message, mention how --interactive can be used to review the
todo list, and add a bit more detail on commit --squash/amend.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/git-rebase.txt | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 102ff91493..594158fcbc 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -589,21 +589,25 @@ See also INCOMPATIBLE OPTIONS below.
 
 --autosquash::
 --no-autosquash::
-	When the commit log message begins with "squash! ..." or "fixup! ..."
-	or "amend! ...", and there is already a commit in the todo list that
-	matches the same `...`, automatically modify the todo list of
-	`rebase`, so that the commit marked for squashing comes right after
-	the commit to be modified, and change the action of the moved commit
-	from `pick` to `squash` or `fixup` or `fixup -C` respectively. A commit
-	matches the `...` if the commit subject matches, or if the `...` refers
-	to the commit's hash. As a fall-back, partial matches of the commit
-	subject work, too. The recommended way to create fixup/amend/squash
-	commits is by using the `--fixup`, `--fixup=amend:` or `--fixup=reword:`
-	and `--squash` options respectively of linkgit:git-commit[1].
+	Automatically squash commits with specially formatted messages into
+	previous commits.  If a commit message starts with "squash! ",
+	"fixup! " or "amend! ", the remainder of the subject line is taken
+	as a commit specifier, which matches a previous commit if it matches
+	the start of the subject line or the hash of that commit.
 +
-If the `--autosquash` option is enabled by default using the
-configuration variable `rebase.autoSquash`, this option can be
-used to override and disable this setting.
+In the rebase todo list, commits marked for squashing are moved right after
+the commits they modify, and their action is changed from `pick` to `squash`,
+`fixup` or `fixup -C`, depending on the squash marker.  The `--interactive`
+option can be used to review and edit the todo list before proceeding.
++
+The recommended way to create commits with squash markers is by using the
+`--squash`, `--fixup`, `--fixup=amend:` or `--fixup=reword:` options of
+linkgit:git-commit[1], which take the target commit as an argument and
+automatically fill in the subject line of the new commit from that.
++
+The configuration variable `rebase.autoSquash` can be used to enable
+`--autosquash` by default.  See the CONFIGURATION section below for details.
+The `--no-autosquash` option overrides that setting.
 +
 See also INCOMPATIBLE OPTIONS below.
 
-- 
2.43.0-rc0

