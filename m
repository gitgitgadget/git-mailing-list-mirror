Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD423D3488
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384192; cv=none; b=f2Ny/5z/Zq65KaT4nYCmJ1C08pBJOE5+rKqkC0MFOcZuGW6Zrsefb2zyGzF3tRJ2XMa1+iN6jvDpbezh3sA8uMdXqT+uwNijqKJI/tUioJscgfndG4R/sptyo7H7AAgSwK5oDwsjNli1ukbWhvEy1Kth2o64A/mQySKgRvBCDZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384192; c=relaxed/simple;
	bh=n5cZQv4vESSp8Z24XGtI+f23BrlmQu9KhROkT2ak1d0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r772DnhDCgIUCE1lh1JEs3fUxZj+EZUErSqpVLlrH+7T3sCjdSlEaT5FjCBuYkdnl3OTvkDZ5KaVE5VR6/yAKxnr9j3dt1uqkzGtXZwNbmuAbYWtW8vhkLNiw5KIzReTmG1Lw8ae4tmCooqfjnO9opEawbWJ4E6WUy3byEuNJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmIZSpcv; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmIZSpcv"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b729f4c154so3102950eec.0
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 05:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770384190; x=1770988990; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5Nchr/MDWG9P5KTh97wbb7TxduUNY4xEvcjIQPWE/U=;
        b=WmIZSpcvw+EBPZF+Dllyf1Q29veCLZW0vaHMLWle+Ph7cWmov2V2ppYezjYLRbYeXZ
         SqzM4ddMNQUJXbGTfShwT7fi134hIV1qU8YM4Wo/gnDSsEfuUtZdW2w30wEY+trJQu/f
         tpm7VSYIoQ1DPd7QoUFdUTytuF+TqumYSchulmqwx3D/+spP32FICSORCUeUCzMW4Umw
         NIG8nCNljbA3oPzIX5/jRYYu2n+yv7j8F8Le24saydM7hoNhR+fW9iIVXmCt15wzZ3Rg
         UTKNpPAk9CSw+xezo/0Y5IKxWU3kaeBEFpixgd+hVfHd5H0tZ2gKythulta2OrRU8yXk
         4GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770384190; x=1770988990;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q5Nchr/MDWG9P5KTh97wbb7TxduUNY4xEvcjIQPWE/U=;
        b=j4w8B3TQDpq7nlLUjMv6U+6g72aEoqVnSkr0y6AJqFPW0J5NBvWGMpQdFUjdSbqZsm
         rA0t2PO4E0jLCW3p8VL8EECjzWUnWGgkP1KYlMfGqSUeKXWeyQitKje2WwFSnJv6OezO
         2glZQf21pgYJGWQQcOSpK/ElcLtp8T3htR2ZhOlHzVsklCmFqm/14xlhZ8paSGNhTjVF
         PMNUAJNLOomPfdJieNgSQT40MNCd0ZudwScDE8PPvahLFf6Wl2EBpEUrXYqf1Qrpn2HV
         1t+UL8Fmvyhs+u3eYxICQ3EPnus7YcykXWf+FrahzXKo7AGB36+XJzDXGk/ZBO38DckI
         RWgw==
X-Gm-Message-State: AOJu0YyjoMf4ETwqB7vqWvbVYE/LFoCAuyk6UPSMB59r71Xg7n6bWQt3
	g8dkemAMjgoiInhwfXw71B6kM3Ge9GDhL6OjyKLiEtAWQ7qngt5GR5IwCJUbDAjBxOE=
X-Gm-Gg: AZuq6aLykFdgLOfe5c1ydIyzY1iG/+wpzNgKerl9MOlZELpe+tgzTKYu5qqlWNKAu9s
	nbB+2NhGiR6R1JBscWOZGNe+MFgXMp46FSJuBQinbHZ1yvOH9dMbkxKx1SHlLsHcDFGFukQeQkK
	Crgpw9umBFmVDPU67ZAd5JcQaGEizNftaLNvQSWbclAl3VV77RcEAYTEDWIEI/JOrEfBMdM0KSc
	jTKiwq0ld8KVQrCSrL1kluy6MNJub+9hxZCEqVWKh5WQKy0Zik4FCdAFo93zgm9N/rJHiCpEQsf
	AOMRHotpYH08Pl+7kClwtuwZn3qnXoCuKBo04ytKYpKO22Q3b9aX7W/0bJiQMROWXVBBXX+Frlz
	XtE5rhoD8lyqMbjfzipiqvCPozaGrYVnrss873JQKY4lCIv4OjFaMJ7tD7yIqcn6nFr2IIwpGPQ
	aOu6IcaDpxKIud6mi0HYR8m5c=
X-Received: by 2002:a05:7300:e7a4:b0:2ab:ca55:b762 with SMTP id 5a478bee46e88-2b856a45fdbmr1223502eec.41.1770384190177;
        Fri, 06 Feb 2026 05:23:10 -0800 (PST)
Received: from [127.0.0.1] ([57.151.137.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c3c7cbsm1662622eec.17.2026.02.06.05.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:23:09 -0800 (PST)
Message-Id: <8bfaa14d44e224c5f8a3cfe1a0c55e9ca9415a98.1770384180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v4.git.1770384180.gitgitgadget@gmail.com>
References: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
	<pull.1987.v4.git.1770384180.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 13:23:00 +0000
Subject: [PATCH v4 5/5] Documentation: update add --force option + ignore=all
 config
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bwilliams.eng@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

- git-add.adoc: Update the --force documentation for submodule behaviour
  to be added even the given configuration ignore=all.
- gitmodules.adoc and config/submodule.adoc: The submodule config
  ignore=all now need --force in order to update the index.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 Documentation/config/submodule.adoc | 13 +++++++------
 Documentation/git-add.adoc          |  5 ++++-
 Documentation/gitmodules.adoc       |  5 ++++-
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
index 0672d99117..b3db1dc2c8 100644
--- a/Documentation/config/submodule.adoc
+++ b/Documentation/config/submodule.adoc
@@ -32,15 +32,16 @@ submodule.<name>.fetchRecurseSubmodules::
 
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
-	a submodule as modified. When set to "all", it will never be considered
-	modified (but it will nonetheless show up in the output of status and
-	commit when it has been staged), "dirty" will ignore all changes
-	to the submodule's work tree and
+	a submodule as modified.
+	When set to "all" will never consider the submodule modified. It can
+	nevertheless be staged using the option --force and it will then show up
+	in the output of status.
+	When set to "dirty" will ignore all changes to the submodule's work tree and
 	takes only differences between the HEAD of the submodule and the commit
 	recorded in the superproject into account. "untracked" will additionally
 	let submodules with modified tracked files in their work tree show up.
-	Using "none" (the default when this option is not set) also shows
-	submodules that have untracked files in their work tree as changed.
+	When set to "none"(default) It also show submodules as changed if they have
+	untracked files in their work tree.
 	This setting overrides any setting made in .gitmodules for this submodule,
 	both settings can be overridden on the command line by using the
 	"--ignore-submodules" option. The 'git submodule' commands are not
diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 6192daeb03..941135dc63 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -75,7 +75,10 @@ in linkgit:gitglossary[7].
 
 `-f`::
 `--force`::
-	Allow adding otherwise ignored files.
+	Allow adding otherwise ignored files. The option is also used when
+	`submodule.<name>.ignore=all` is set, but you want to stage an
+	update of the submodule. The `path` to the submodule must be explicitly
+	specified.
 
 `--sparse`::
 	Allow updating index entries outside of the sparse-checkout cone.
diff --git a/Documentation/gitmodules.adoc b/Documentation/gitmodules.adoc
index d9bec8b187..3792da96aa 100644
--- a/Documentation/gitmodules.adoc
+++ b/Documentation/gitmodules.adoc
@@ -70,7 +70,10 @@ submodule.<name>.ignore::
 --
 	all;; The submodule will never be considered modified (but will
 	    nonetheless show up in the output of status and commit when it has
-	    been staged).
+	    been staged). Add `(new commits)` can be overruled using the
+	    `git add --force <submodule.path>`.
+		The setting affects `status`, `update-index`, `diff` and `log`(due
+		to underlaying `diff`).
 
 	dirty;; All changes to the submodule's work tree will be ignored, only
 	    committed differences between the `HEAD` of the submodule and its
-- 
gitgitgadget
