Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B681C17F385
	for <git@vger.kernel.org>; Thu,  2 May 2024 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714678895; cv=none; b=Hc1u06S1nb7DPpeDlHTDWAG7bDbc/C6IroSnQM4Fdfx6zs97xPy+z7e8OOvu545R71q55CMjRhQvFHwHOmIromGcaJbgLXKiovtMObsusTv+IsLC+l3B1W8CXqqpuObJI3iFcfKMbRWOOlZZEkhTze2A8Gy/aYGKYNbZWdKSHiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714678895; c=relaxed/simple;
	bh=Z+ksQhOqx3PSKKo3lEcsT5NS9FkiNIWRIJafU/5siGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJym1rWX7IRRggzFBUKILJMmxohGZyo5VUBxzz9NiAA5gkcUCLsVVxibTNVFE3vQ7ibTmPVS8HGiZiSXblAoEQHZqHIX47O3tcJd8iuCrlgoW/8enJuW67oaYG18+omN5HPLPVH4F/wYeFsRHaAWn1EoG3SSv3Q1bJakQ6xpNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6NTq+Wn; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6NTq+Wn"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23d3d092a1bso1362361fac.1
        for <git@vger.kernel.org>; Thu, 02 May 2024 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714678892; x=1715283692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIDBiS84UewzXCNV+EwH1tE5bsdwEGGpaYyWMk3/N0c=;
        b=W6NTq+WnAM3wPTBOAfnWt8R82jzDWj6RRH0xSS0jEPbD25+AcWf60b2KESquYsDf+A
         aVYQ39lxKdHFo2Ll9lvtBJjGj8azNKFZHqQr53B+Q5eopCsLAP7Xs+x/EhZbEQwCl2k+
         8dA4KJ6GNPl54JKb8tExWzX4Cu15v/XBrgOU9Y4fJdanSrYwpzaPNTpCQAt2rT4nUe8Y
         yqeEp4XNnxQMbqNDFCoNo3ncHNEy3pv5Qbsovsorhkobnl09asZUCkWuqFEBP1d9WhwQ
         KiwPOVNOAi1fQsiq1qFwaDcLPOrPIw7UdekBpFVf4zB/otr+/x5X+x8DCvWyCKiWbDsV
         Hxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714678892; x=1715283692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIDBiS84UewzXCNV+EwH1tE5bsdwEGGpaYyWMk3/N0c=;
        b=TxqiLHhesJGO9hEXZHTWqEID0NLJFmyueIyHwwwI1g+3pcuz6lHI41NwqyO5OUva8c
         H+BznPGSun4ZVAAUlFKJs6Z1CleAh6GxWxF0hJY7GovO3mF+8DMXlfH98IVkidk3McNz
         EuwR+WAYUbuHVVwTri5xbR+jhST9URT9r+IahagRSNaOGDI/s/ZyhYD+jnBBErcgT/4c
         Ox4zAsdIsOSSGq+y28sg+ARZLr8sMTGgGglht6AvA11wNmhkHc59rXR8qsmjqM+7hU+U
         oo3woKO6MxQssdhhjemyAykmJFSEMp4eqjkl4hl7SXAgbMGHjI7IsWO8t+JjdOfF8Ftl
         ZWRw==
X-Gm-Message-State: AOJu0Yy79/Au0a3tTaYMGMPny1UJnfSCIjzv6SxxHBYIQbidg8tdMIY0
	bPM9Y8Oys9vWxnDqhyj587THFcnObPryUzmEm1o8otg2H+csLo7IlkZMIg==
X-Google-Smtp-Source: AGHT+IGP7JG010CBz9PfWKGHTPAtvwsznNQn0T38tk4MPvzEHsm6yomspEIBn4zcSQUXKumpsu1XvQ==
X-Received: by 2002:a05:6870:a112:b0:233:f233:c3ee with SMTP id m18-20020a056870a11200b00233f233c3eemr962676oae.50.1714678892571;
        Thu, 02 May 2024 12:41:32 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id uj12-20020a0568714e4c00b002390714e903sm297443oab.3.2024.05.02.12.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 12:41:32 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 5/5] gitlab-ci: add whitespace error check
Date: Thu,  2 May 2024 14:38:39 -0500
Message-ID: <20240502193840.105355-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240502193840.105355-1-jltobler@gmail.com>
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240502193840.105355-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GitLab CI does not have a job to check for whitespace errors introduced
by a set of changes. Reuse the existing generic `whitespace-check.sh` to
create the job for GitLab pipelines.

Note that the `$CI_MERGE_REQUEST_TARGET_BRANCH_SHA` variable is only
available in GitLab merge request pipelines and therefore the CI job is
configured to only run as part of those pipelines.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 .gitlab-ci.yml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c0fa2fe90b..6d046ce409 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -102,3 +102,12 @@ static-analysis:
   script:
     - ./ci/run-static-analysis.sh
     - ./ci/check-directional-formatting.bash
+
+check-whitespace:
+  image: ubuntu:latest
+  before_script:
+    - ./ci/install-docker-dependencies.sh
+  script:
+    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
+  rules:
+    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
-- 
2.45.0

