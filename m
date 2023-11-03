Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6EC2375C
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG2loii4"
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62340D55
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 14:30:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40859dee28cso18550965e9.0
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699047051; x=1699651851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGKSQFzPepLUi2rVAxBmF9LedmT2S5KIcvZZndPeWdQ=;
        b=dG2loii4fcF6r9GRBJtHN7RACA3TSTHwgplfPS22GpGDpOpWyKbvp8J+uLAnBrFcx2
         HPYbpJroEelsEXdFOnz4U9G1csL9djOVQGAI/yhuFxSX3CdvNqUTIYZmN0U7MFdws3Ps
         tucvaw+n0wkdmklTpvl+aiksWv+kRUK91Ki9eQyjyxaaRw0krS46G+3jJMD+vL6q/uw+
         siAx5AyugFDjFog8kO0lwqgc2FNKPsJqcLvK1lAYQG5eNjdXiXweU3izmuMmbpo2SNiY
         n+siliN/3Eu7gOKxNmAMLMS15kaFUyjlw28uO7mnGT1Q5n4dY5mILIeXmZYzktIKo3B+
         T7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699047051; x=1699651851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGKSQFzPepLUi2rVAxBmF9LedmT2S5KIcvZZndPeWdQ=;
        b=HVWqbL67MAXtJjrEd49Lv3AG9bV0yrfrTT4kqs+WdR/zpD/KpvY3Scze2ecEWhZs+g
         ZbYidk6o/pxxAkQa4Iull7J9DgMwbQx9aa+a4jRHW1CseKSR+TWLJZ2MLrjSlQrAATFi
         +CigEtL9bK7AT7rTSx4yYNjdJwSeJSlKX5cFOsjjuQg4t2dFYJTxHmfokf3Qo4Ed11lz
         Bczw4bRDciCsJDP7KP4wWBvhyk3DAMqCzwv0YnBvANV6W/aV3qYyfohqoeF/PjP3wVUD
         sfiRFIjpKf57J/h49A+qlhRSEMfcASN78QgZGj09j7sNvq27azb6Pl3Omt6M99hBKzIF
         h7TQ==
X-Gm-Message-State: AOJu0YyVtENm1bfaYJFamqW9hLefzrvXpzMaBw/6zeCTT93DcJSOrbWo
	oYbng3U5nHzUID6Zk2WSD+iQQPcLg9ORQwkv
X-Google-Smtp-Source: AGHT+IFLaiFXMMAf5rr6HTjRz8/vB2wQPmVqvDBhbR1XeIqPtIiCTzYiMP3D8mLy1Jqsd64DHxWqKg==
X-Received: by 2002:a05:600c:4e91:b0:405:82c0:d9f3 with SMTP id f17-20020a05600c4e9100b0040582c0d9f3mr19601869wmq.30.1699047050507;
        Fri, 03 Nov 2023 14:30:50 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b003fc16ee2864sm3673255wmo.48.2023.11.03.14.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 14:30:50 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: newren@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH 2/2] docs: rewrite rebase --(no-)autosquash description
Date: Fri,  3 Nov 2023 21:29:58 +0000
Message-ID: <20231103212958.18472-2-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc0
In-Reply-To: <20231103212958.18472-1-andy.koppe@gmail.com>
References: <20231103212958.18472-1-andy.koppe@gmail.com>
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

