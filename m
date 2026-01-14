Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC537998F
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376906; cv=none; b=X4Fujptc7hCbJ3eJBBgxXdpXc5H+lgs1xflLHjkvFukeZbBTavn1LkJZJKUpt5nRPvldUyPdE2IE7d6+7961B2KABcwofFIaX+9LTnrWLJrKEgPFqFtubVPnUm/h3Eax5Kob5Ur/dbhmy8D3cySVmfRuJiBofbcGCo6JdNxJr+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376906; c=relaxed/simple;
	bh=aaae1sLvkAmx6dY3U2D8aEOWewhUXOyYVSJsvsZOaWI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IgMbgJ9I4v8/2LLs86saQT6r1IWqI7xHiwQi16gx3ZnmFbtj/g2Q4hRpnP18SjS1bUq4iMhVdwe5mh2xc26oSAyelAaM8ER7I801o/BSGhsM/zqZ75j23XPOgMqaKR5xMy1rYEryL5A5PDkh9qg45mA/A03x7Ys4EvjPwq6yijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inBwei8L; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inBwei8L"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-12339e2e2c1so42177c88.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 23:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768376891; x=1768981691; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl6/dgYMC+JZMRl7vGQf/poJ8T+lyrIxkd+Ps1f48LA=;
        b=inBwei8LmcK5uMOPNN+YtfS9GF4atPHc5BzY9oehIu+lNzqenmBWr3DvkXJWVKDMqp
         hjFYp3poAse4VTtgHquIHW/AFd/wmBvPEZd6I48hpLs2Yi2wjjPKLW9HD5xmVJugFjJj
         C0GMyhuuKv87LteGrN4fan1H9PxEMObgXy7tTVAACARxriTp04m0nUgsT5gDzqb4l0oR
         q6V+/HCd8fW77iq7UquI9ULqo1ETVGps0vnwBI7Csu90bKeSxDxd8J/oE1FqbgffERFA
         Ns/a9cBfqyz49HsYpKwuysdt7Yd3mZZKGL/WKZ+ULvpIFGaReyZvDbf/k9yc7OmmH1KR
         DLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768376891; x=1768981691;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dl6/dgYMC+JZMRl7vGQf/poJ8T+lyrIxkd+Ps1f48LA=;
        b=tniP2FvCMgU36w5AN1cD8O461dXOgixQJkxaIj8aIF4GjI/SpWG/tzrPK3bYSf3JuW
         HiOhQWIqOtGVpWyN0TAS4bngt+Ka61qIIL+cHz5iUFIR1JWejgXTtAk60raAfvtgjif4
         vnc+fsbB36ofoc5gc/xvmxw8S+jlP5DkkSV6/LlJV1IwvwcgkT8F4AsFWkM77uQbl1wF
         V0K+zSMfvRGYuA0kitcLUqx41W0y6FkaOsdWYOD4BPch+6N6dT1NzPabzNqMMTz3Lj9B
         httxse9Rxcu5Tq1JpMgOsHLWSBEYzwDKUn/2AMSXDWZbRMhqkyggC7up43iFE73yfS2e
         4c9g==
X-Gm-Message-State: AOJu0YwZZlQa57889UNWGf6+fydNhztNcQJjgpc64wZzqbD8cqVG1luH
	fapaEBEl8Giw5nT9ks40Qlsn3Ah76dles2kyFJTUApZNS0093O5X5KS750zUzD8h
X-Gm-Gg: AY/fxX7VApPKAjwPP6L5tzCD8i2fIJGowO/i1tgk1bZ7R9zrOSWS2CJOCyANMDR1MJ6
	tOK9oX8dxTyiOXxO3colbyGWs6MXPKD4sMgTVvDoCIYjpojnuF9KyhkH1zTZHj2NvVvaIb9smbG
	rFP8igNqscabsqV5rWI7wkuaghCioTcfrR/ce+NEe4EZcnK8bTzS9yXjqdhSFSOmgsGv0Nbg/Ut
	Cr7PfWk73aEfFli/h1wS08j6lH5HfaT+hyx3RO5i5ILf6k/jJ/uZRbGx6MyeiuYuT/v+XDMwFwG
	bv3DDOEADcslhZMxl3SUiDHuyWtSxiyun4zUcsb88GYCHo5G0MOicjbgomLkGTgFnu2cIJx1NzG
	sf8tWTsiq7b6Vt9BhQIrE5pIYC6HrQkFVeNjFWhuEVgERgMrc32UphhnTjlLZBSZg/6xu1WBxcV
	trKx+inoR8c+E3mw==
X-Received: by 2002:a05:7022:117:b0:11a:468a:cf9b with SMTP id a92af1059eb24-1232b5a606cmr7564327c88.9.1768376890482;
        Tue, 13 Jan 2026 23:48:10 -0800 (PST)
Received: from [127.0.0.1] ([128.24.160.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243421esm30288657c88.2.2026.01.13.23.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 23:48:10 -0800 (PST)
Message-Id: <37fe7956e089394bb1d75f4c8af4a3347b204803.1768376879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
References: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
	<pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Jan 2026 07:47:59 +0000
Subject: [PATCH v3 5/5] Documentation: update add --force option + ignore=all
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
index 0672d99117..250a6133d8 100644
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
+	Set to "all" will never consider the submodule modified. It can
+	nevertheless be staged using the option --force and it will then show up
+	in the output of status.
+	Set to "dirty" will ignore all changes to the submodule's work tree and
 	takes only differences between the HEAD of the submodule and the commit
 	recorded in the superproject into account. "untracked" will additionally
 	let submodules with modified tracked files in their work tree show up.
-	Using "none" (the default when this option is not set) also shows
-	submodules that have untracked files in their work tree as changed.
+	Set to "none"(default) It is also shows submodules that have untracked
+	files in their work tree as changed.
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
