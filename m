Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0103DD517
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891673; cv=none; b=DznWtEw3KvIqNzVJD+Q33TECFgp2HHR/bIuSQ9GDHKVq9a3z5ELfZeAdSneisPBE68/9O65pQogDb2bog9ljzRltFVJVvl+IBcO70ZMgT72UCb5YUxkC2AlU7uHe8oZTxHuW0Mt6aHPtkmIWAlwMz1qtc/rArpQOU4V6x2F3IXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891673; c=relaxed/simple;
	bh=wawFqB7G0Ar9g7OBPG1atT2FN69lVZxRmeAuhmuw/8Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sn2mm8t9jZOfbHUlJ4ECVrtZP4vtxZTyLACdpGOLzgR0GQg0gXKFpTaGeBifi8axh7wPaKzQP/d1Jq6UrjrUetszKD/VJ1F3R+xLtk45bX3e1Yza6sBCg4bcRGIcs7c9apdGlxOHSSObPdqQRTVASn3rrs0JP9s5GfLV2McFZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RupjvHxd; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RupjvHxd"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c66eafc1easo1925322eec.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774891671; x=1775496471; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUE9y+t+YlUZRNErlcV0R22MPdxA+qmQwV2DvypWci0=;
        b=RupjvHxd03Bjg6Lpmp5NWW4Ya/WmliVNKPobPpd5+aNtIAB9vM0SB+V7prb+KWSvNG
         2oeieOKNM5ATQ8l+7OeSr/ndD6pFOs/dMhOONme2loMFRztMeAzlL8aJdbyBcWVxIAn5
         9U8DOr7n2tKo7EBj2HSRVJi/PjDHIwdnU5lwRKS6ucxCty6jy6n49HFg1o2qV0YLegHV
         NSAUlHnh3iUjo1x6gcrlJeVcco44flV8y49h2aIEXZ4hAaRTY3FbRJr2zDy6iXIk20NL
         XVCgHcMB0M6yPzN+Zk4PLr1L7+oXCIEw5A2WB8MUjzP291sW9L0dM2Swe+K7lrlk720Y
         x+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774891671; x=1775496471;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WUE9y+t+YlUZRNErlcV0R22MPdxA+qmQwV2DvypWci0=;
        b=aO4RMFKzlFWRcXR+DTMTjnkmBQ+aYufVzIQkcqRPj0sgWaxHq8s7vmoQDJIvcP3uKc
         BE4mDC2+8eyAKA//gSCAXRTYj7e0OrtyMVv3fwSubKXPdixJ5tgx0ypr0HvrC9qSDg0m
         fWvaBEH8ZpTOdFpjjKHcDSPlp8GAWBnyu+tosoztNBhwCCejYQBTIZw+r9hGXAlo1Di3
         lqpAHwtXMDoI5XJTffBN5XvVNejuS+KU7XGBDKd53grYZyYTFpMsNZvNaLg3MIWolaIJ
         D23QoylfUWaUVLz1AS0UnXqXB4HrhHR8wEdfe1sBOIgdC70h+lriMnX9umz1ZOrjIoz4
         nBRQ==
X-Gm-Message-State: AOJu0YyKxGs40+zj/NaxlMlLqqGUWGRoKLqJaWrtWHeHyeUxp0lVxkm4
	i3IqO1PqnW7pyJyXggGzEpfHyD5OIJ26rhXEPVtQ2HQ+f8ZqXIy8piZuBW9GQA==
X-Gm-Gg: ATEYQzzXoF900dToTJGS6/JxfhS7+KSOjyxJTLLGSWaZnZB1Xix0PNpHEKknu7Yoo0y
	yDKTOznsmDfFjpCB89LDkb6cU+93tTlnLpcyb9nlHM8roy1K5hSZ1+fghwhg0rSJxFfBUot6nO0
	oLcPhzq800QhCyZb2xBukpWukc8YiQCp9xSFBG6wdBS42bnVqsy6IzVXUBZH3cZZsczLCFvSt8l
	tUL4/ytn1YZFV7TZGySCjMHzo9Ue0mgLN51ficzLBrbmpDg00LcJqpkRIdaHsWCFqsfb30g2iuj
	emwaUOPUp4xYUigDQFlQWcPuy8SjxGc7zXeo3/dfD8nFwfdNZR0XLlhq3DysC8usct0p8465+s7
	qLZ0uNBiGCeYy05WCdmPxf5ciwNLb4o0FW40skm3wGCjZgGSBpq9ceJA7m1uuBhm6JB6T12mT8N
	KBumCFB7inXf0FT6ASQ4OFUiZiRg==
X-Received: by 2002:a05:7300:a485:b0:2c1:7afc:df00 with SMTP id 5a478bee46e88-2c185e69320mr6972819eec.30.1774891670815;
        Mon, 30 Mar 2026 10:27:50 -0700 (PDT)
Received: from [127.0.0.1] ([52.225.73.164])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b272esm7376309eec.15.2026.03.30.10.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:27:50 -0700 (PDT)
Message-Id: <5a8165b05dad6143c910105be832bdc6ea5bf598.1774891667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.v3.git.git.1774891667.gitgitgadget@gmail.com>
References: <pull.2253.v2.git.git.1774682046750.gitgitgadget@gmail.com>
	<pull.2253.v3.git.git.1774891667.gitgitgadget@gmail.com>
From: "jayesh0104 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 17:27:46 +0000
Subject: [PATCH v3 1/2] repo: add paths.git_dir repo info key
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
Cc: Jayesh Daga <jayeshdaga99@gmail.com>,
    jayesh0104 <jayeshdaga99@gmail.com>

From: jayesh0104 <jayeshdaga99@gmail.com>

Introduce a new repo info key `paths.git_dir` to expose the
repository's gitdir path, equivalent to `git rev-parse --git-dir`.

This improves consistency and allows tools to retrieve the gitdir
path without invoking external commands.

The implementation adds support in repo.c and integrates it into
the repo info reporting mechanism. Documentation is updated to
describe the new key, and tests are added to verify that the value
matches the output of `git rev-parse --git-dir`.

Signed-off-by: jayesh0104 <jayeshdaga99@gmail.com>
---
 Documentation/git-repo.adoc |  5 +++++
 builtin/repo.c              |  7 +++++++
 t/t1900-repo-info.sh        | 10 ++++++++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 42262c1983..d17d911ec6 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -95,6 +95,11 @@ In order to obtain a set of values from `git repo info`, you should provide
 the keys that identify them. Here's a list of the available keys and the
 values that they return:
 
+`paths.git_dir`::
+	The path to the Git directory for the repository (equivalent to
+	`git rev-parse --git-dir`).
+
+
 `layout.bare`::
 	`true` if this is a bare repository, otherwise `false`.
 
diff --git a/builtin/repo.c b/builtin/repo.c
index 55f9b9095c..3067107cad 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -66,11 +66,18 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_paths_git_dir(struct repository *repo, struct strbuf *buf)
+{
+	strbuf_addstr(buf, repo_get_git_dir(repo));
+	return 0;
+}
+
 /* repo_info_field keys must be in lexicographical order */
 static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "paths.git_dir", get_paths_git_dir },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index a9eb07abe8..63be0849c4 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -149,4 +149,14 @@ test_expect_success 'git repo info --keys uses lines as its default output forma
 	test_cmp expect actual
 '
 
+test_expect_success 'paths.git_dir matches rev-parse --git-dir' '
+	git init repo &&
+	(
+		cd repo &&
+		git repo info paths.git_dir >actual &&
+		echo "paths.git_dir=$(git rev-parse --git-dir)" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget

