Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1CE394783
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664865; cv=none; b=hyGRJk2/lcNKozmJcaKKrK7dl0bGYHbifVgJqnf+rzi2ce1VYYhgxtGdjaxW7ukdCzFV6DAioIuRfP9YStb141LF32nbq5+D1UjSqp+WsB83QL2//p+Gu9P7YCJHGb4ulwM/P3RDVU+QTe1jX0PKfM/c36DKWYlQIY/qWNx0r04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664865; c=relaxed/simple;
	bh=lmrVIQc1JN1X6YqEmBY+VyKP/TT4ddkuTmN90OPOHpA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZA+A5dMwimrbx0Y+7Zkgs+O2Z5XaDi6lERRKrjghFyZ3CjpX5gd71uEFn7HoJdUJfglox+Ab882X9HYaKxbXx632wMlNKJqDFfEbZbdE+yvNwKHy/P+Ozn/UOq9P/asTH8g4GfbZrzDQlUQDAycqxMRMe/b5ropM4RrPlNZKmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJT/nky4; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJT/nky4"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4560d6f82edso4251103fac.3
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784664862; x=1785269662; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X17ZpV3aGC64jgZBZQtfRHlV/TEsBgO93FVkD73UJ64=;
        b=iJT/nky4+4GV2sSviGCO3szZYr+We2geSceUR+XUh8EZeCSFri6mBfjLF6le2zVH/b
         hVnkZAPbiEre0O53i7I+RmRfV+sOE1TCF3KGxM+SlDrZAPQKc4Sv71dngrhczXGwkLpm
         Evbk8hKKwRIrInmB+N/mGrm5+C+cGWR60axiB9e74bj+MpMz5EBmNg8KmHBgIBHyvsuv
         SZm4+hG/gte6pOBpx2uN0v6qXze9/QVOz+iM+VUbW4yclb05tw5Q+KClZfAyBDh1gaRb
         VTkATEwKXppePQ1wzQ7eFTX+sw7ig4PK6+p1OIxlTRKoAZENpO6efOjrgAqTUdGcaXwy
         hYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784664862; x=1785269662;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X17ZpV3aGC64jgZBZQtfRHlV/TEsBgO93FVkD73UJ64=;
        b=RuSNYlK/I9w97lmE9BGKYiByMhd42iWZ9AtSt2/ZrMncbDh6rlRBORhHSFxsUQqUOv
         VheyL3ooRjXKjLGAZQBIzH3azbL2h723OtF4ImQsjxhYF9tXlPAIDIMxY0p22DnLHFmQ
         BBQD+inNwVZANCixb/tz8LaCsYjOs5w40yY+DJNrPWfcr/cbaEgOrZZkmG6ZvFW6+VwT
         PdeT2ehDq/lzMUjXVHGgIq21scUwPgvjjBl6BfqYR/aspUYr/aelxmYZislO2eskrXoL
         CrfhqsIJDCcYFLowF7APn/0kGEmJOwDkDa6j0ZmOSxQwhGShI6k6Qc/MaMsCPNqxVLLE
         Pm/g==
X-Gm-Message-State: AOJu0YyjxVoaxyBRd6mVQpPL8wvd8zY1wGXFk4i9GesihFsKWhskEJVV
	XmvI9WAaLgXIt4eRgqve3FlyWU6/aKnnq9avPb9UHC+wg/Mz3iImtpq18wO+R3nb
X-Gm-Gg: AfdE7ckNrMMoOb+1v36F8s4RB5hUqjAGeZRx+S3rtXxu5vWCqd8PUTzp2goKFRkyYYi
	xA3wCsF9N0Z09yUJlWG5Gj4PcHFqIpHXKZK9VXOfy1J3TjPEugW+oXDl+kUOAw9l6tqXzrK1NbI
	TBj00bmW9XNCG+hYSw1+UpdJNW7BDs9Q45oPyoKw0nXOUSWz2W60o5qhq8fYhOlgqTCgHjqmIUi
	PLnD2nzqrp5GloFh0nlQ0Ufh0XfIGRk8ePGnT2cy77RFWJdbIXPXOduLPzydOEfM5Qap+HRiIQ6
	1me6jS9SQg9c3IiRyA/NhQDq8R8NvFbDhtN9CU/euAKWWscD++et2XrzxWGIJgI+q/58+VG1/aJ
	HuwS5ZgbV8+SSTozWvJQRjhltq84P/GI0VaKn1p7CFCoq/46arTy9jlanf5yqVNrVb5dIwn+0kv
	2Fa5XiI/dNlok2iOJx
X-Received: by 2002:a05:687c:2296:20b0:456:baee:4819 with SMTP id 586e51a60fabf-456baee9d73mr5817426fac.11.1784664862388;
        Tue, 21 Jul 2026 13:14:22 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.123.151])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45766e7c9d7sm401604fac.2.2026.07.21.13.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:14:21 -0700 (PDT)
Message-Id: <b1ac49de87c2a8b88aa2aed60b18847734fa906e.1784664859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2358.v3.git.git.1784664859.gitgitgadget@gmail.com>
References: <pull.2358.v2.git.git.1784624306.gitgitgadget@gmail.com>
	<pull.2358.v3.git.git.1784664859.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Jul 2026 20:14:18 +0000
Subject: [PATCH v3 1/2] remote: pass repository to push tracking helper
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The next commit needs tracking_for_push_dest() to inspect the
repository's configured remotes. Pass the repository through the
existing callers and mark the new parameter as unused.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index b17648d6ef..0dc36956c3 100644
--- a/remote.c
+++ b/remote.c
@@ -1887,7 +1887,8 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 	return branch->merge[0]->dst;
 }
 
-static char *tracking_for_push_dest(struct remote *remote,
+static char *tracking_for_push_dest(struct repository *repo UNUSED,
+				    struct remote *remote,
 				    const char *refname,
 				    struct strbuf *err)
 {
@@ -1925,13 +1926,13 @@ static char *branch_get_push_1(struct repository *repo,
 					 _("push refspecs for '%s' do not include '%s'"),
 					 remote->name, branch->name);
 
-		ret = tracking_for_push_dest(remote, dst, err);
+		ret = tracking_for_push_dest(repo, remote, dst, err);
 		free(dst);
 		return ret;
 	}
 
 	if (remote->mirror)
-		return tracking_for_push_dest(remote, branch->refname, err);
+		return tracking_for_push_dest(repo, remote, branch->refname, err);
 
 	switch (push_default) {
 	case PUSH_DEFAULT_NOTHING:
@@ -1939,7 +1940,7 @@ static char *branch_get_push_1(struct repository *repo,
 
 	case PUSH_DEFAULT_MATCHING:
 	case PUSH_DEFAULT_CURRENT:
-		return tracking_for_push_dest(remote, branch->refname, err);
+		return tracking_for_push_dest(repo, remote, branch->refname, err);
 
 	case PUSH_DEFAULT_UPSTREAM:
 		return xstrdup_or_null(branch_get_upstream(branch, err));
@@ -1953,7 +1954,7 @@ static char *branch_get_push_1(struct repository *repo,
 			up = branch_get_upstream(branch, err);
 			if (!up)
 				return NULL;
-			cur = tracking_for_push_dest(remote, branch->refname, err);
+			cur = tracking_for_push_dest(repo, remote, branch->refname, err);
 			if (!cur)
 				return NULL;
 			if (strcmp(cur, up)) {
-- 
gitgitgadget

