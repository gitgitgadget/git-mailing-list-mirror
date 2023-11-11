Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F1014AAB
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArQISfZG"
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A06B3A85
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:27:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32fe1a29010so1667701f8f.0
        for <git@vger.kernel.org>; Sat, 11 Nov 2023 05:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699709273; x=1700314073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsUPRMur1W5Yn2Cz+y3+i6t5zvKfeJub6wedoCJN2pI=;
        b=ArQISfZGXKO2b50GbbazUiTJfYvpyzhLColtpMJ+Z6MYbPC6dQWQ0Yqaqy/O7uIHux
         fTtKWQcst933x4TiOzqvfxHaxHdPv3QTVBKZnCU1RtPjA7zsqN6tfbN33jWpLPfs5uTF
         70M/TIfkumDZzG2pUsWXnzDgfY5ja7NAWjqZe7YaY76RdubFbWWYaKUmXZ5F+zZ3iKMe
         l3Hym6wbFlM05xHIA3hRIHIAI5YorqeqM172TYM+EvkDkBp5mlHPII7Jpvo5NH0ek5j5
         /DslznSglHFmHdZeW6BJiYpq+UpVZJlfWbAvgJ7VyP1oPdCbtp3mS50O/WVf+NjXNjk/
         IY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699709273; x=1700314073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsUPRMur1W5Yn2Cz+y3+i6t5zvKfeJub6wedoCJN2pI=;
        b=ugxG1Y3QVnFhZ5E2Utfj4iA0ht6KQXz4jRfq4SRyyuc6wmPwVoR6t2WxSBUxF4/zYw
         8Mu63z61y8vD+Qn+qS5jvokCkblnSNZR4NcE4H2uv9xSFeD4WjzBXMwQlftxzmp+YsY+
         VHKYlsQxQcb3WiAQO6T34xyXgj60eP1e+gYJmsmlY6+omAGBBqDBHtGk3LI9fygpGSPL
         M955qpDYFtjcx1RPLGjjhTQy+AJyiOLS8CHIVYSyfSO071H5irW1lpDdgiLK9+cEWgO0
         uB0duv37+AjZ+8OedFuKT2/G64AtrPYGdw4xZNkt2II4yyEPawuntMCaHKSLN0KV8BrP
         iKlw==
X-Gm-Message-State: AOJu0Yy0e1yEApBeAjCeJIzTCioq5F5ZZJGnhxA5+VDLm8DhM50q8DN1
	5EZnBYct3fdV8ZXfZmjOK0cF7ThOlauGdw==
X-Google-Smtp-Source: AGHT+IFYF+PtMTmglFHlreu4dGYxjPEdALWAlGOXaDYaxuckd714tgf8W8pQSB6wgnuWFM5dajMIOA==
X-Received: by 2002:adf:f28e:0:b0:32d:d2ef:b0c1 with SMTP id k14-20020adff28e000000b0032dd2efb0c1mr1239341wro.33.1699709272772;
        Sat, 11 Nov 2023 05:27:52 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id h4-20020adff4c4000000b0031ad5fb5a0fsm1467102wrp.58.2023.11.11.05.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 05:27:52 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	newren@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v4 4/4] docs: rewrite rebase --(no-)autosquash description
Date: Sat, 11 Nov 2023 13:27:18 +0000
Message-ID: <20231111132720.78877-5-andy.koppe@gmail.com>
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

