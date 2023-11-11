Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E618E2C
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcYRa2S+"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DEE3860
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:27:59 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso21204515e9.0
        for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699709278; x=1700314078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsUPRMur1W5Yn2Cz+y3+i6t5zvKfeJub6wedoCJN2pI=;
        b=gcYRa2S+WavZQEtvTHrlVTw0IpsSU3LaqQbSMinw6OzeWRDBRLYsChjD605++KgTGO
         ttmJSuxxktzbikEwTON0aeO5PFXGxnokvcMAkAMCFek2/EtAuf33+TW3iafnQcjs3xrH
         BiAyc88mjhZLw0KiF+1V2Hj74JuEIPZ8FE/mb1x4YIbKZD1U4zaqfk0y5q3fk/mnXP+F
         qdzn60agtXMzS614PhQYbT22HF6qrEttwoiVyAZWu9Mc9MWOEEUi9MG0te5HRyls2DWg
         Vv+AJ4cxwa7H1/05USVy0kkwEjt49Z8rJce7+C0nKQe9tBzGYwbP08rUvfyOThoRmz44
         bYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699709278; x=1700314078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsUPRMur1W5Yn2Cz+y3+i6t5zvKfeJub6wedoCJN2pI=;
        b=USiZiUn9aJH48aEZMrfv6Zq2tWO7kfk51KKRxgnN3U4KEeYbc6GWeHucMOwt9fVdhb
         hSfgRfqMUOgtqrWbP4Q8fzKhhj6YG74lYs7lmhfku60Ti5vexQAHbRcohAhUia7qLQ/O
         W77m+LHzWrsO20fP6eCILOCI1Cv0BLtYaKHjlWuqeyd4gsirgE9EyaCCs52wd7Aoyeav
         YHewrTq48uprZtAo62ohRZCEwdRxFIG3IHyE76+GTDyvFh97kxJPLncN7tXKFvoHNHe1
         VRek442cO5RSR4JRkNzPsxJ2qR38cIuptQH1ubYJo22eUDpllJjB+vtdRIAq11x0ZI3j
         uH/g==
X-Gm-Message-State: AOJu0YwmdH9a84+pUqeiggu0+OJXJvG1uixDfbOOG3yoCVUG/SsnG6XQ
	hgz4+O7KLVBHftIc9q+Dz5BEltsI30SdHg==
X-Google-Smtp-Source: AGHT+IG1g1no4NzHIpbtkT56W2ybD5Xhm4YwbVADp3DtcHerk2zLIoYfGP28TUPC/TjP6BPD+0JfJw==
X-Received: by 2002:a5d:64c8:0:b0:32d:8220:8991 with SMTP id f8-20020a5d64c8000000b0032d82208991mr1426168wri.8.1699709273521;
        Sat, 11 Nov 2023 05:27:53 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id h4-20020adff4c4000000b0031ad5fb5a0fsm1467102wrp.58.2023.11.11.05.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 05:27:53 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	newren@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 4/4] rebase: rewrite --(no-)autosquash documentation
Date: Sat, 11 Nov 2023 13:27:19 +0000
Message-ID: <20231111132720.78877-6-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc1
In-Reply-To: <20231111132720.78877-1-andy.koppe@gmail.com>
References: <20231105000808.10171-1-andy.koppe@gmail.com>
 <20231111132720.78877-1-andy.koppe@gmail.com>
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
 Documentation/git-rebase.txt | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 10548e715c..1dd6555f66 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -589,21 +589,27 @@ See also INCOMPATIBLE OPTIONS below.
 
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
+	previous commits being rebased.  If a commit message starts with
+	"squash! ", "fixup! " or "amend! ", the remainder of the subject line
+	is taken as a commit specifier, which matches a previous commit if it
+	matches the subject line or the hash of that commit.  If no commit
+	matches fully, matches of the specifier with the start of commit
+	subjects are considered.
 +
-If the `--autosquash` option is enabled by default using the
-configuration variable `rebase.autoSquash`, this option can be
-used to override and disable this setting.
+In the rebase todo list, the actions of squash, fixup and amend commits are
+changed from `pick` to `squash`, `fixup` or `fixup -C`, respectively, and they
+are moved right after the commit they modify.  The `--interactive` option can
+be used to review and edit the todo list before proceeding.
++
+The recommended way to create commits with squash markers is by using the
+`--squash`, `--fixup`, `--fixup=amend:` or `--fixup=reword:` options of
+linkgit:git-commit[1], which take the target commit as an argument and
+automatically fill in the subject line of the new commit from that.
++
+Settting configuration variable `rebase.autoSquash` to true enables
+auto-squashing by default for interactive rebase.  The `--no-autosquash`
+option can be used to override that setting.
 +
 See also INCOMPATIBLE OPTIONS below.
 
-- 
2.43.0-rc1

