Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63448550C
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261070; cv=none; b=R6FeG/2UWlpU6MEd/nTFLOtvKYnKZ5L4Xpcx33IloSU0JN9KZhQODh4bN5KShlohsUhoMSpxsIqAw310MKue9+vh/dLjwX7kdJ5+W7NZ7PUSRX7TWm0nCZVuztRclvPxRqViCDerZPtaYd2ZWWuMnFOZsPe9kRAsVNbJ3pe+6uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261070; c=relaxed/simple;
	bh=C6JX9wsLLRNOqiqJP/NAqPm+0X0+uzt4nKcGu+4WlNs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RpG/6XIDTmazdXOctUMkuxQ0Oy0dgWpL/pOQX0SU5lHpHB7WWfnYi4sJm6sTteL9OIy/XRIJe7DX3kc5Fz6jUUBE1okNvbpLOtF9/rxYDGZXc1zrNbDep71WlmaNOyMGC/CVunnWhfphgzDnNwY3KT5dH4fTPIpf8roXgb0DCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyXbc3T5; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyXbc3T5"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85f0fc1fd8eso1074166b3a.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790261068; x=1790865868; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=atLJWz8cXQbgEe1TNShMXj7VmM7iFZBbO+F6RiNZk0c=;
        b=dyXbc3T5yQEmbVbmV8iXRC3B1FYNMBAthoUJPW3Ze8Wzlr1BOeUtasTmOrRJHQHAEb
         +P7BEtPQlDxkXeYBN0i+1ANkr0uIyq8abAj8qrYkIu/Z7hMvE7Cl7ctlXOd1bHQRmPRE
         VO4f2lIFDVcbCcYqfVvsVEIX2CRreIrbVRuCyKibIbNYRVR7VwA+JqsCnRqNH+lHW8fW
         MTkKF+QD8rMDbFLe7Me98HfK3sqezakBrg2b6vaUBFKlADvGzHXdJSH9jaOE5Ar/WTCf
         dDv+qtL9LjlB2rMRfQ30RP9Y0dcTe3NHw918Zij8F247MuoNoEHz7bWv1mJ6plMHqmxg
         uVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261068; x=1790865868;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=atLJWz8cXQbgEe1TNShMXj7VmM7iFZBbO+F6RiNZk0c=;
        b=TmEGaMrvWesjRIFQd19poTohUDBJ/P/a8/W7GwqhMCADiF5l5yIoJ6FpGjBdrhl4Eh
         PM+k48uhIzVU2jwrzZLlqJ1YZXSBb+OdTz/qHrFNsnINalWgZA4wBsO3FTyhI1eajyVD
         nzc6Hsk182cKa0gLeie+DUagoW7KXIA0bb6Tu1Q5MVLpeCKcBkajnd4NeWjoQNgs0ZH/
         UV33u34Y7JoHcfH+9mDcLW/uL2lIY6vafhQY1K4FPIh9ssE6CAN79o9z4fRu6t61u0Vr
         Zx9tRxbdy0pdC+9E0mokh19jd1H/3koZuUwuK9UrrJOvqzdSyumFcierfJutM1qOXis/
         24OQ==
X-Gm-Message-State: AFuF++mmx933ZoqzUdUOhm9weq9JgwkqrU4j1n3zrHtVeQ1pz9eYMdd+
	Z9sZW9QvRXP3fCM06lKk9roOk6a/DTYoJYZ1oE/vr1Bir8Qe87YRl8MMpTec3n5J
X-Gm-Gg: AYBFou0m4IeI9AqcCRDxqQeDhLAc+F/brvXxIzBKbCI4bW6gqgucZG246aphASO4Cy2
	CBY/KOTn6qLYcsAQ/kb42xPvyxo652FGHKGXXyZobSHu8DGgn3Gf76Fh+BdwXbHi52lTlLoQAXB
	BD1S8onb4WAzfFGIUsvlG4Qgm6UWScYgSIq+UQG/QvVOXEwbD15dTFpT18bqHoP8WxttRIkeJsI
	xPiebkbgXy8pcprnJOe3SK1w1YNxHPHSTGveclEdxsrTQhkSVIpQ3DK6eNsGaJkivsUHjsSpggo
	s/5p6ZhW1Ccs6hZg3vB8xhNE+I1+aUYOPIIcgFKpe/5ILxiwJiU0uRW6+mzhENadAx26P/8jUu8
	hp4M5fIz/6KwZ/hJSgRLcLInGKPzV8B0IgLXxWCg83vZjUVJrg/0ZNhTEVEsiwgLRJFbaMicfe8
	D+T93VyB2U+j4bAOOW8f5LWE5C7X9cSiGJ6O1aunAVXRQXh0Ktw3v7jAhgVF2CqqQn6PaTvACTM
	MA=
X-Received: by 2002:a05:6a00:4f88:b0:868:7a65:d92d with SMTP id d2e1a72fcca58-87e9966adbfmr2453897b3a.26.1790261067676;
        Thu, 24 Sep 2026 07:44:27 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e5fb67fsm3277800b3a.58.2026.09.24.07.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:44:27 -0700 (PDT)
Message-Id: <128d69e482687d05aa854e51843a42c14a315d5b.1790261062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 14:44:18 +0000
Subject: [PATCH 3/7] [doc] git-rebase: link to new merge conflicts guide
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
Cc: ps@pks.im,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove some of the detail about how to handle a merge conflict, since
it's explained in detail in the new guide, and there probably isn't
enough detail anyway.

Leave the steps since rebase is special and has a `--skip` option which
the other commands which cause merge conflicts don't have.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..da70aff498 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -46,10 +46,7 @@ If there is a merge conflict during this process, `git rebase` will stop at the
 first problematic commit and leave conflict markers. If this happens, you can do
 one of these things:
 
-1. Resolve the conflict. You can use `git diff` to find the markers (<<<<<<)
-   and make edits to resolve the conflict. For each file you edit, you need to
-   tell Git that the conflict has been resolved. You can mark the conflict as
-   resolved with  `git add <filename>`. After resolving all of the conflicts,
+1. Resolve the conflict. After resolving all of the conflicts,
    you can continue the rebasing process with
 
    git rebase --continue
@@ -62,6 +59,9 @@ one of these things:
 
    git rebase --skip
 
+See linkgit:gitmergeconflicts[7] (or `git help mergeconflicts`)
+for a full guide to handling merge conflicts.
+
 If you don't specify an `<upstream>` to rebase onto, the upstream configured in
 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
@@ -1284,6 +1284,11 @@ include::includes/cmd-config-section-all.adoc[]
 include::config/rebase.adoc[]
 include::config/sequencer.adoc[]
 
+SEE ALSO
+--------
+
+linkgit:gitmergeconflicts[7]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget

