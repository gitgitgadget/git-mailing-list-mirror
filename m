Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684023BF83
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771784944; cv=none; b=KEeZPQN0GoANlWKgpqGaV+GHLlrqybeB6EN8otUsnDj7rBMbSq3nxiw5I4Lon815fGweU8REWy6qxawmvqgqedaaFgrDi8EadP5X2MuPwQ2QvVSuzeE1yTcUWD461DN0blApMIsRVFKL2RtFRvNSW6WEQWCwc3azT7TGkTO32ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771784944; c=relaxed/simple;
	bh=ZeZ2B+ok8fA8NWfsz9U/9uAZrd6U11EpQ3O0CQEQ5eo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mlbEruv8FySiqDWohikJe+AGXwLjKhVam3+OB5x2O+qx9nbIZ+86xL5kDJ9ZzDW38FvZErh0SRlT9j+LbNBa1S0XPrqg8unXoAA55CG7M4UsE3fllrT8YodlCdjY/XQEQ/NVMfO+ljOPXOdfoiCvJj46AXZsFdtbakANSgigA1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctgrkn8+; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctgrkn8+"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so69573eec.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 10:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771784942; x=1772389742; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U38E8zyIwOskc3HiMuqHtJGCDlZxA8aOO1bXldlWQYc=;
        b=ctgrkn8+OeyPRbIIX2iDyMgDp/5IY98jB3wWaZ3rpL3dq2YriQ/FokzwQJIPs16fE5
         9/XFO/gVkCzVjQc3J3To2lNp08gG9/VTfW1J17Fo3K+JX6XGEVfIel/XcuXNPB/j/nhb
         ppO/zFMAEJpE2kzJseHh7+XDgF+gde/7QMRJ6cCaSuoBt3RZhZKXgD/Fj/e84IOUZQHi
         UVL1UF7wsc5bLpL+eR5A6WsWE79Ti+Tsvj+KU09A+F+AqzF5hJWN2BDcxkTUcZlmFjB7
         IEksbWYzrR0UBLTBmEXXvU5JnHGLB2HjF0VvmDjxj6ZxgEZPaBbarRWfVHmScujlQzOC
         PRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771784942; x=1772389742;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U38E8zyIwOskc3HiMuqHtJGCDlZxA8aOO1bXldlWQYc=;
        b=SGFBZ5HTgo5aqy6G9rLEq1tyfOanrvgWZ0zJfYeA1qAg2VYizp9u6l9eLqgBBXwd4d
         88SJ8pEarsCohRNyx3hHSERKuRldhBg0zd/Sebl4u5VNJ0rmDrAaUWDAmdGSU8fyzGhb
         5zRfyBgNMIuC2PUmqZqpXWchgXVSYBnE/AX0YKUYqurTrRs+v/jPQP8gdoWKKu2SxJDj
         tJjkuirxfiTa8uOtTlMhX6puAnHsd/hQKrmCFsQR0aVZTPsZ7AzO98VPLsAaLRnyYFie
         8DlSXIA7b5kuTT4G8UrF3qd7cB7NQ60JV4ydqew7A5O3117nlH+4KzG0e2ym8kFxJfYX
         vlXw==
X-Gm-Message-State: AOJu0YwY+EzR0I5xTcGU8+MzuN2q+yqU09izAhG4u5ajX7lozFxCPswN
	k25OGLKVfRUDVyIgouCUb72wHEyEiNDxWPi6R8sbq1ZPjwvAzrsMD6WNzq1vCdB4
X-Gm-Gg: AZuq6aJgOlYGrGdG2Ae15NwShQh+XKsKlQ3cXQTGKpXh1qjDpe6NNWoRUGTfuNV2Otd
	MEkB1+ZV7YnRL5W3DNdVbaa46X8QuuESu4VAwq9roYtYh4okxbManQ6oYldZVLJRQMZNoi0rckW
	zF3fgdAM99VjMyHOhTRKE+QLrzim/XNzcME8HhBIq0tdbO375zlwG4kBgcqTTqiLnYYfvotIc3K
	avgNoHTmLAVDRdOy4NH0/DomCSTUCaeUffP34alvnd8k54FKSJ9+cPjY2GzjAZ88DdC5JN8g++j
	UwuWlA5W970XP7FhXoQTkk0p2Y7PDhAyTo4JxaFVSJQ7JIjjF8gxvz2f1NuQKRM1zY9MJ/nIWrX
	XcqBw0PmFhkCrgVbddRpaeLgxpGZXQ8YzeJQygvTtAHY0cegZLv9RZ3fLlrvNNUnsOlcOC25sbk
	CEKwYnciwHIi+utlejqqs/UXZX
X-Received: by 2002:a05:7300:80c7:b0:2ae:5bde:a5c5 with SMTP id 5a478bee46e88-2bd7bd3578emr3135396eec.30.1771784941628;
        Sun, 22 Feb 2026 10:29:01 -0800 (PST)
Received: from [127.0.0.1] ([20.171.51.209])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc1618fsm3564873eec.23.2026.02.22.10.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 10:29:00 -0800 (PST)
Message-Id: <cb85ee3b48371048397a22564c3b5c112d7df57a.1771784936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
From: "Eslam reda ragheb via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Feb 2026 18:28:55 +0000
Subject: [PATCH 2/3] t1900,t1901: make repo tests hash-agnostic and
 wc-portable
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>,
    Eslam reda ragheb <eslam.reda.div@gmail.com>

From: Eslam reda ragheb <eslam.reda.div@gmail.com>

Signed-off-by: Eslam reda ragheb <eslam.reda.div@gmail.com>
---
 t/t1900-repo.sh           |  4 ++--
 t/t1901-repo-structure.sh | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 4bfd48b85c..dcacf84cc3 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -131,8 +131,8 @@ test_expect_success 'category key returns all matching keys' '
 '
 
 test_expect_success 'mixed key/category requests preserve request order' '
-	cat >expect <<-\EOF &&
-	object.format=sha1
+	cat >expect <<-EOF &&
+	object.format=$(test_oid algo)
 	layout.bare=false
 	layout.shallow=false
 	EOF
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 2d493fbbc4..d9e2842307 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -150,10 +150,10 @@ tree_max_entry_count() {
 		--filter=object:type=tree --filter-provided-objects | cut -d" " -f1)
 	do
 		entries=$(git cat-file -p "$oid" | wc -l) || return 1
-		test "$entries" -gt "$max" && max=$entries
+		test $entries -gt $max && max=$entries
 	done
 
-	echo "$max"
+	echo $max
 }
 
 blob_max_path_length() {
@@ -228,20 +228,20 @@ test_expect_success SHA1 'keyvalue and nul format' '
 
 		cat >expect <<-EOF &&
 		references.count=$(reference_count_total)
-		references.branches.count=1
-		references.tags.count=1
-		references.remotes.count=0
+		references.branches.count=$(git for-each-ref --format="%(refname)" refs/heads | sed -n "\$=")
+		references.tags.count=$(git for-each-ref --format="%(refname)" refs/tags | sed -n "\$=")
+		references.remotes.count=$(git for-each-ref --format="%(refname)" refs/remotes | sed -n "\$=")
 		references.others.count=0
 		objects.count=$(object_count_total)
-		objects.commits.count=42
-		objects.trees.count=42
-		objects.blobs.count=42
-		objects.tags.count=1
+		objects.commits.count=$(object_type_count commit)
+		objects.trees.count=$(object_type_count tree)
+		objects.blobs.count=$(object_type_count blob)
+		objects.tags.count=$(object_type_count tag)
 		objects.inflated_size=$(object_total_inflated_size)
-		objects.commits.inflated_size=9225
-		objects.trees.inflated_size=28554
-		objects.blobs.inflated_size=453
-		objects.tags.inflated_size=132
+		objects.commits.inflated_size=$(object_type_total_inflated_size commit)
+		objects.trees.inflated_size=$(object_type_total_inflated_size tree)
+		objects.blobs.inflated_size=$(object_type_total_inflated_size blob)
+		objects.tags.inflated_size=$(object_type_total_inflated_size tag)
 		objects.max_inflated_size=$(object_max_inflated_size)
 		objects.commits.max_inflated_size=$(object_type_max_inflated_size commit)
 		objects.trees.max_inflated_size=$(object_type_max_inflated_size tree)
-- 
gitgitgadget

