Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C451B960
	for <git@vger.kernel.org>; Sun,  8 Dec 2024 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733645536; cv=none; b=aE/cKs7NC5NKYCL/pc3rFQ9zLe0Z7YJbaqOswycjXJ/+pFL+fAzUcYvOoZWDILHOdfbQ/ueTIDAO1oE51fwQSckdMAf/ZbDB+8uDMKQgkoBJZMalWnVHg3XQpwVwsU01uLs2z5ma2dpBG7K29O5i8TPO0EP9fgMGhLti5T+M2tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733645536; c=relaxed/simple;
	bh=NJ7wkJFYVS3Ls6rd1+LS46gNU9fLNLY/mvL0/eBdAxo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=auFC+T8HVgodnr3yi4Fn2UJ5O1n5FSYZjkbrLXpQODzmXBvjhbTQ885ZF1A5O3iIW78c2dzBk1vHiL7MZrJVHN3pfJrmpfVVD3DyWqIOT4P27JEJgLNTGP7kslwZcj8QPlHsTQznNYQRSGS1KlCtrHrwmhd65zz8wYyE5g54+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2ArHZwe; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2ArHZwe"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385de9f789cso2511429f8f.2
        for <git@vger.kernel.org>; Sun, 08 Dec 2024 00:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733645533; x=1734250333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0nAuqLUqhDrPzvkYhZ73OdiGfXHbN1ADi9LquAIauY=;
        b=G2ArHZweApFvaOIBfrHjiDTOA/X0TrYK7wrgnvTIGeaD9KU3jKz2ucT9IFD4sAdvgm
         UqsrT1rM/C0s0GPoDIWrdVtRwbFf5y5GNYVjkJJreUWdSvvF4QBB0QazQRuaR1iLOUZa
         DuezoHFFUrTA6E08dRZ0fbxM+Z8zDeqUoSQqDNhnhZcTrnh+btAzMlAVEECKZFJnf8DS
         SacyvVyWcrAtHMSISU34fWPSA4qcHbaeLkyVkXR93ZcgT+dAMmG9uzBOoGGlkE0Uz6D5
         zZA0zw9Nl0RX9MviI2eiB/WGHojX0PPvZwrRRAC5aHh/fLsUE7zrIg/SxlW0RA8whbOp
         fUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733645533; x=1734250333;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0nAuqLUqhDrPzvkYhZ73OdiGfXHbN1ADi9LquAIauY=;
        b=hM9dg0VHRBgITtRwV+jjBJY4OB4CsAcNINTn7WGTNU5r9VYHJJrSFR2XlvqjkCPHEf
         07MXDcDXf71KQYJbSXi66apurjV7pmy+9rUs6tmRJeqx+q6QyO7gvXGr3bordYWy9cUa
         MGiTjqyb/QQiBwo8jOzuxlnuBTQltSSHs7uT0GHe3bGHhmmFEMQ5V3DeqJ1QSSBNu28X
         e+rncbOufOKAgUhRBt7ZVVYSGUEDiVWBs+qBiMNaRKTa30fqBa3heQj4304tXwLTKqZ5
         p/WJWGRbw5rDcLoFainx6pSR0kXhwXeW7uqcuw/E3ELrypY74RIZwTIWsGOTznXozzh0
         GLfg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+nv+5UXXn5x/0zPfgFDBYOjgeNjv1yw8ZmOqw1DRE2Uz6fvOeG7Cpxg19YS2Wv9NsX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYl9pRYogz0rjs3VaDftbtEAlEV8rA9f78b14Bk72K1Kw9658
	LXOYYC1DpvEYTQt18b1m3YzYNYPPreVjo7Ac+dxDe3lu/O2F6Ilg
X-Gm-Gg: ASbGncvsY5LzhUvJO73cTPZsvmZUU+KySLceutbEZbyqmNtGkFZupp3O8aQh/BsZQc9
	Gxql2DyF5ephqV1mTW22Ygwvb3B5jD5QLUVy1gxA5tNNNb0dJusPtX05KermvcHXUtnNLsHqM8X
	zIj95VdEkb/zhIHOkg/rSqyADWnJzaU3fU4ZbRndxQby4Dy6cH7Js4REN/7cQexZZfrBqX3OdiT
	OXqko3VKP1Q3csjrkzU212vpGW5mEskUgpyaC5e
X-Google-Smtp-Source: AGHT+IE7BdxaJux2djv+taFqAK2hswpThX9JKi1U6AaZo5aR9c8eCKFOGbiIvqGmKMfA0Te/ASEpVg==
X-Received: by 2002:a05:6000:1846:b0:385:f44a:a53 with SMTP id ffacd0b85a97d-3862b3337c2mr6292189f8f.4.1733645532918;
        Sun, 08 Dec 2024 00:12:12 -0800 (PST)
Received: from gmail.com ([88.14.46.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621909739sm9282454f8f.66.2024.12.08.00.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 00:12:12 -0800 (PST)
Message-ID: <47cf2e55-364c-49d2-a364-4f1276196071@gmail.com>
Date: Sun, 8 Dec 2024 09:12:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] advice: enhance `detach_advice()` to
 `detach_advice_if_enabled()`
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
References: <Z1FkrsQ5tkz1pFUz@pks.im>
 <20241205122225.1184215-1-bence@ferdinandy.com>
 <0e139151-7162-42b3-afae-248c28bf4c4b@gmail.com>
Content-Language: en-US
In-Reply-To: <0e139151-7162-42b3-afae-248c28bf4c4b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We have the `detachedHead` advice since 13be3e31f1 ("Reword 'detached
HEAD' notification", 2010-01-29).

This advice is shown to the user in the `detach_advice()` function, and
its only two clients verify beforehand if the advice is desired, in
order to call the function accordingly.

The `advise_if_enabled()` API encapsulates some functionality that we
can take advantage of:

 - Checks if the advice is desired, using `advice_enabled()`.

 - Automatically adds help, when needed, on how to disable the
   advice: "Turn off this advice by ...".

 - Displays the message consistently with other advise messages,
   prefixing each line with 'hint:'.

Let's simplify the logic for the clients of `detach_advice()` by
eliminating their need to decide whether to show the advice, bringing
that decision into `detach_advice()`.  Also, let's make the it use
`advice_if_enabled()` to ensure consistency with other advice messages.

To better reflect the changes in the function let's rename it to
`detach_advice_if_enabled()`.

Finally, note that we have two tests in t7201 related to this advice:
"checkout to detach HEAD (with advice declined)" and "checkout a detach
HEAD".  They are unaffected by the change we're doing here, so it is
not necessary to adjust them in this step.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 advice.c           | 8 +++-----
 advice.h           | 2 +-
 builtin/checkout.c | 5 ++---
 builtin/clone.c    | 3 +--
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/advice.c b/advice.c
index 6b879d805c..399ae58437 100644
--- a/advice.c
+++ b/advice.c
@@ -272,7 +272,7 @@ void advise_on_updating_sparse_paths(struct string_list *pathspec_list)
 			    "* Disable or modify the sparsity rules."));
 }
 
-void detach_advice(const char *new_name)
+void detach_advice_if_enabled(const char *new_name)
 {
 	const char *fmt =
 	_("Note: switching to '%s'.\n"
@@ -288,11 +288,9 @@ void detach_advice(const char *new_name)
 	"\n"
 	"Or undo this operation with:\n"
 	"\n"
-	"  git switch -\n"
-	"\n"
-	"Turn off this advice by setting config variable advice.detachedHead to false\n\n");
+	"  git switch -\n");
 
-	fprintf(stderr, fmt, new_name);
+	advise_if_enabled(ADVICE_DETACHED_HEAD, fmt, new_name);
 }
 
 void advise_on_moving_dirty_path(struct string_list *pathspec_list)
diff --git a/advice.h b/advice.h
index d7466bc0ef..739c5e4987 100644
--- a/advice.h
+++ b/advice.h
@@ -79,7 +79,7 @@ void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
 void NORETURN die_ff_impossible(void);
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
-void detach_advice(const char *new_name);
+void detach_advice_if_enabled(const char *new_name);
 void advise_on_moving_dirty_path(struct string_list *pathspec_list);
 
 #endif /* ADVICE_H */
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c449558e66..e1366556d7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1009,9 +1009,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				NULL,
 				REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
-			if (old_branch_info->path &&
-			    advice_enabled(ADVICE_DETACHED_HEAD) && !opts->force_detach)
-				detach_advice(new_branch_info->name);
+			if (old_branch_info->path && !opts->force_detach)
+				detach_advice_if_enabled(new_branch_info->name);
 			describe_detached_head(_("HEAD is now at"), new_branch_info->commit);
 		}
 	} else if (new_branch_info->path) {	/* Switch branches. */
diff --git a/builtin/clone.c b/builtin/clone.c
index 21721db28a..d0c5e89a2a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -752,8 +752,7 @@ static int checkout(int submodule_progress, int filter_submodules,
 		return 0;
 	}
 	if (!strcmp(head, "HEAD")) {
-		if (advice_enabled(ADVICE_DETACHED_HEAD))
-			detach_advice(oid_to_hex(&oid));
+		detach_advice_if_enabled(oid_to_hex(&oid));
 		FREE_AND_NULL(head);
 	} else {
 		if (!starts_with(head, "refs/heads/"))
-- 
2.47.1.407.gf6b6eee3e5
