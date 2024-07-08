Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4D757F2
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430619; cv=none; b=QDijZIFS9nriACMtl3JxTaBZR1PqK2cnCpNhWG6ZS+Wo0aloUde3pdeCe90fuvt2ob8TSr75cf/VTaO5qY9lh2nPSBwXrXGoFqQULleKejK+jL+dyEqAUtPhlP/hGvc4RxfanoGQjoOrSJ6C6ooMbQqkLJMmrdEqAut+obzDe8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430619; c=relaxed/simple;
	bh=VeJxIRsjISRNbv5JYbmQu0zbRXh6VF4TW1TD6qQ2IJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEGPWzS780ZR1zdWvv3tS5IUWETaiYahrpvIu6ys2/AkbX/ePEzuMUbFH/dzjESuLoH4VAg/uUzKvQdM9Ztg/DfimiDvBiVdCkACYoalDoTWurvwVIJPQBbHurH7SVapItiaMxsTal1fuo3mFqRYYUECcxdwfrW16/+q4SQdWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENRC0RYz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENRC0RYz"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ea0f18500so3589965e87.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720430616; x=1721035416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJYAAQipJrEMzwO6yMCgrGXChfZGqcqlxIj3SuJWz/o=;
        b=ENRC0RYzzeZSH9Hw3Od80Ukw3+44DZbCY8mCvBnLZKiucqtyrM9vlBSJkaWkB3gBEJ
         oHGvOytKwaXrBkkmD+KiWngyTUlrSlVoipSuLYL65QD+z50mnzRrAKcvAaKvyxgo7sh0
         aomd458vAXfNPUC0u7KqORlmUn0iuYrQlhTEh/a/T2n+JUxfp2JI+oniNr0dxCA1eRFa
         ulVWBNsrnbfR149YjRprqHXUEBrSXPJCL9g6ihmRhJaUFbfpXA6InodBAf7//NEMsACC
         58Y8rU9Rim5lANpUR6VuAf/KHNVOAmNfGVy52slBFxuaTO/LTChMzKPxTBFFdCixlrky
         2BSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720430616; x=1721035416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJYAAQipJrEMzwO6yMCgrGXChfZGqcqlxIj3SuJWz/o=;
        b=c/ymYGD05+9tUw1HzTUaZyLf+XxQa43WMUR/qionFWyCL6hYQXk0jyOsuEZQ0DGr3X
         IIubtywJu5tcz5c6c7kgX381MbXTi6DPPkgQalU9fzaK31jRSqA8c27cO85NWbX3lOfM
         4ljKPePL67EstNcdzmkFBuHg2Iv8BEpU/Ybxd25nzwqJbF5iyhPIixD+Y932PjaXqrOg
         QaDXpPsco53Pz2KSul5TYIslRU068irMBV72896nCI0JgTG4Ytdt2uMsehMK27ro63J3
         YqvMX2XRhnKVfbHOImcyqbgOTCAJNYhFkMA4fPf9FYmTZvY2j7yJnUGEb+aPY/gG7RSz
         6ePA==
X-Gm-Message-State: AOJu0YxCksYVpbtj7pxeHCwjwY49BP1lN01nK2nMHbgblNpVUqKC21de
	AImyMcUvpcDda/wWGMXo+E7JRjRo9sXazyGmJ6zMqxBXEJ20d8q/
X-Google-Smtp-Source: AGHT+IFSUWTjPZoBLqyg2tPZ8E4FPxnxhzJhfD2qs+IlM8HE/z6SGHh6kT9upgfpCmQ4Q2vBD7BhUQ==
X-Received: by 2002:a19:a412:0:b0:52c:dbc2:ea1 with SMTP id 2adb3069b0e04-52ea061f5b7mr6717372e87.6.1720430616418;
        Mon, 08 Jul 2024 02:23:36 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1d0d:3d35:3ae6:ef05])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm158259935e9.10.2024.07.08.02.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:23:35 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH 8/8] check-whitespace: detect if no base_commit is provided
Date: Mon,  8 Jul 2024 11:23:16 +0200
Message-ID: <20240708092317.267915-9-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240708092317.267915-1-karthik.188@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'check-whitespace' CI script exists gracefully if no base commit is
provided or if an invalid revision is provided. This is not good because
if a particular CI provides an incorrect base_commit, it would fail
successfully.

This is exactly the case with the GitLab CI. The CI is using the
"$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" variable to get the base commit
SHA, but variable is only defined for _merged_ pipelines. So it is empty
for regular pipelines [1]. This should've failed the check-whitespace
job.

Let's fix the variable used in the GitLab CI. Let's also add a check for
incorrect base_commit in the 'check-whitespace.sh' script. While here,
fix a small typo too.

[1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .gitlab-ci.yml         |  2 +-
 ci/check-whitespace.sh | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 65fd261e5e..36199893d8 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -119,7 +119,7 @@ check-whitespace:
   before_script:
     - ./ci/install-dependencies.sh
   script:
-    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
+    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
   rules:
     - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
 
diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
index db399097a5..ab023f9519 100755
--- a/ci/check-whitespace.sh
+++ b/ci/check-whitespace.sh
@@ -9,12 +9,19 @@ baseCommit=$1
 outputFile=$2
 url=$3
 
-if test "$#" -ne 1 && test "$#" -ne 3
+if { test "$#" -ne 1 && test "$#" -ne 3; } || test -z "$1"
 then
 	echo "USAGE: $0 <BASE_COMMIT> [<OUTPUT_FILE> <URL>]"
 	exit 1
 fi
 
+gitLogOutput=$(git log --check --pretty=format:"---% h% s" "${baseCommit}"..)
+if test $? -ne 0
+then
+	echo -n $gitLogOutput
+	exit 1
+fi
+
 problems=()
 commit=
 commitText=
@@ -58,7 +65,7 @@ do
 		echo "${dash} ${sha} ${etc}"
 		;;
 	esac
-done <<< "$(git log --check --pretty=format:"---% h% s" "${baseCommit}"..)"
+done <<< "$gitLogOutput"
 
 if test ${#problems[*]} -gt 0
 then
@@ -67,7 +74,7 @@ then
 		goodParent=${baseCommit: 0:7}
 	fi
 
-	echo "A whitespace issue was found in onen of more of the commits."
+	echo "A whitespace issue was found in one of more of the commits."
 	echo "Run the following command to resolve whitespace issues:"
 	echo "git rebase --whitespace=fix ${goodParent}"
 
-- 
2.45.1

