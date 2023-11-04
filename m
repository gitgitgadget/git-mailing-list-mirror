Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A1925110
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jwq39ajt"
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83051D69
	for <git@vger.kernel.org>; Sat,  4 Nov 2023 15:04:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32f9268bf8cso1890123f8f.0
        for <git@vger.kernel.org>; Sat, 04 Nov 2023 15:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699135447; x=1699740247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGKSQFzPepLUi2rVAxBmF9LedmT2S5KIcvZZndPeWdQ=;
        b=Jwq39ajtYHJQhHCHkzlNWFVDDjFlkuI0pqqcWZkQn5M/FvYO5yomz02O9XD8AvhfO3
         AT72woMjWriGvWgvkQIKPUU/0T4XeYpwkhq/Ej+TvubBpbda+v2cqe1ZyOWF2Hij9rHJ
         OW++o7Qe2+Vf1qwou4ibUK7cj7NmzHI+nC5BA7mRf6TVHv85hBzkygLAjBqmXEWqGl/p
         A4DeYvSTQrU6QZNv/1RdFQl0Nvh+v73TVvEE4YC0IKmdcFrfzOJBdajKWOvOhXCNRI3L
         ui76T7rKiJXqywgKQRaQGmeRh2S3awIGT61X2qKxTkuY+xTKHH6TYFsVj6Arn8d5vSVa
         CP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699135447; x=1699740247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGKSQFzPepLUi2rVAxBmF9LedmT2S5KIcvZZndPeWdQ=;
        b=KniZvsCg0CeDOXtV9Uf+i9TN+iXCmdAR6gGIVF+eq1k9SY4IU/9bwxH64T5xmKcrFr
         XCHu2siJ/ls88VLC6HDu3347fH/tBEifjplm0iIZBDp0ablAHgl7/xDQGKaUDf8PHmFU
         Zg0L6SHMlFMgvmLInjpwhGJDNV4Qpi7HMK3pkojrBbqZafXOMoxPsrKHf0ySH+vG9w3X
         lLzuo5Tqv8Gjye9SFUd75chK/q9M3LBDbN8rLmHFYwgc2qoRZaH6um/ZmgOVIAYk36E3
         rtepfJCqHcWD0rr5xj31G8qu3Fs8A/43vO5qz2HODc2Q1F0Il1AhvRpyH0O8D+9hVvQn
         vjFA==
X-Gm-Message-State: AOJu0Yy2rfzxuDUDlK2AfyK132HmZWovsvGZyOHB3DkkzAj1tU2gOU3D
	uloxSa7sLgYJR2HgdTvXnXo2X1FwmokZvw==
X-Google-Smtp-Source: AGHT+IFD4Lmv8Ajl7vp/olcmRL8XbxLsyS8H3kyyGwAsI2d/TIA8GRUJHGBjRcYrCDF1VlbJ+TdoDg==
X-Received: by 2002:a5d:6d8e:0:b0:32f:83e4:50e5 with SMTP id l14-20020a5d6d8e000000b0032f83e450e5mr18584089wrs.6.1699135446938;
        Sat, 04 Nov 2023 15:04:06 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id l4-20020adfa384000000b0032d2489a399sm5387221wrb.49.2023.11.04.15.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 15:04:06 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	newren@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v2 2/2] docs: rewrite rebase --(no-)autosquash description
Date: Sat,  4 Nov 2023 22:03:30 +0000
Message-ID: <20231104220330.14577-2-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.43.0-rc0
In-Reply-To: <20231104220330.14577-1-andy.koppe@gmail.com>
References: <20231103212958.18472-1-andy.koppe@gmail.com>
 <20231104220330.14577-1-andy.koppe@gmail.com>
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

