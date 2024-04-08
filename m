Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B30814389F
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597900; cv=none; b=epcbzavpCOpyXMHDLXxy8T8dD+TJnJQ84lSr5vZ+zqgL1xlZ859JEcqt0ZleJCjxmlaz7QOcggBwv9v0n9CITIXsAj2+OG7C019n7xjUDGI1iw42qbL+S6PDAhHcR5gZOG9EKU6d9xyhn7dwkCN2skqKbnN/13wlSn84Xh9Dp2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597900; c=relaxed/simple;
	bh=AYFOAjNP7kiQu9E60UJHthh6gMnXH3t0au1kBx9xIVY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qd2HvsQV0x/9AkKK8M51/vOKBQy3+SeGVRiGzdLM8CcaqAB1Uq253BeeZc9FfEoy3J9qxNFYBERacFiOr+4vkLIl69PPzfic18K2arG0fu6H9LzJw3ZrHn2RHEWbkgSgV0T6EjIX4RSgGFx4IIsOk9dIz7rHxWO6HmCFN4jYmAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjnaHAs7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjnaHAs7"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4155819f710so36562445e9.2
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712597897; x=1713202697; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GS3YMLTjG2glNKxi8gdoSRFcUTCgNpFtSNNNRvAuF8w=;
        b=FjnaHAs7p8+ddvr/XiCOU9ZuiyyysdGXJZ9mAOmkqgAjd0LbZ1WfSFmVqwcDszHbwH
         mh4clHg6HlkERXj3uLX76jFZFDYxH9B+yNuvG9j4ugqtEXjTCIIVuASNG6/dwtcJxxw/
         Kt6ZlPR9woYVpgrSQjPXXqUaTM7tIkd8QKiZv9cb1MJ1Ngis6pBv9feAUlDZJfzpH8pW
         IuQk9n19aw+AoLoWZ+nkBX4Hk1VfxmfqKe+hIXVgp3bC6cLcyU/zxGnu4SCqoh9UE3ON
         gAkhAb6r5tMN5vGlEifQFWhq56B8tPmyiic9v8inwDX8i4ynivodGCy1Ab7fLSTWKhkd
         bfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712597897; x=1713202697;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GS3YMLTjG2glNKxi8gdoSRFcUTCgNpFtSNNNRvAuF8w=;
        b=Rl/cmYUgjuspROJSilbkmzmfBYQB9SY6FASQQT08VEwQCwmJHP8eECPmTSjsIuau4j
         O3E0CFaTfgb73KWNt9TLMexM6Z3T1du7ajOhGBB5YxK/MQAuqtBuG3Jmzk/hO2mHdGaq
         hTDzwcCc2kfPat0WrgqUEAmjtSR5hMlT6di2tVhBSBUjebN3f+JWfYTyVpdEkKhLXrSM
         aJGP2drajIZAzkv+pKA4LjweSKNmezGdZtMd5HB57Q6lI6ijaV0+jbVDEcvLkmMLWdJa
         Nl5E9aVdYPRCd1rJlvUYnDwE/dAbFPQL2vTT4VHpKMrYDtk9nPFIr8atHJ46hhPfn31S
         DAhA==
X-Gm-Message-State: AOJu0Yy1LZxaOtJVGpvcMYvTiqqN9QYMkU4Z6T4zB+qNLCG3LDMwDglg
	XO5/vbxU4SaaegahQ22OXmJvMC21NthCcrusDa/mbXyvGU3/5wio4hMz8W5v
X-Google-Smtp-Source: AGHT+IEzlFHqYycIgjsJCeE1v5CxszBiHTrbcPJa+N/kINCSD8zItdm7VwpdTtI5p5fH+iLJaaSJHA==
X-Received: by 2002:a05:600c:a019:b0:414:726:87d9 with SMTP id jg25-20020a05600ca01900b00414072687d9mr9274947wmb.12.1712597897088;
        Mon, 08 Apr 2024 10:38:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8-20020a1c7908000000b00416838eeda7sm1261443wme.1.2024.04.08.10.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:38:16 -0700 (PDT)
Message-Id: <b60e78560e0d8e9b73090fad7b1b91eee19abf75.1712597893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
	<pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Apr 2024 17:38:12 +0000
Subject: [PATCH v2 2/3] refs: add referent to each_repo_ref_fn
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

There is no way for callers of the refs api functions that use iterators
to get a hold of a direct value of a symbolic ref before its resolved in
the callback functions, as either each_ref_fn nor each_repo_ref_fn have
an argument for this.

This did not matter since the iterators did not hold onto the direct
value of a reference anyway. But, the previous commit started to save
the value of the direct reference in the iterator.

Add an argument to each_repo_ref_fn that gets passed the direct
value of a reference.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/replace.c | 1 +
 refs.c            | 2 ++
 refs.h            | 1 +
 refs/iterator.c   | 2 +-
 replace-object.c  | 1 +
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index da59600ad22..36fa58db82c 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -48,6 +48,7 @@ struct show_data {
 };
 
 static int show_reference(struct repository *r, const char *refname,
+			  const char *referent UNUSED,
 			  const struct object_id *oid,
 			  int flag UNUSED, void *cb_data)
 {
diff --git a/refs.c b/refs.c
index b87a680249e..77ae38ea214 100644
--- a/refs.c
+++ b/refs.c
@@ -1664,6 +1664,7 @@ struct do_for_each_ref_help {
 
 static int do_for_each_ref_helper(struct repository *r UNUSED,
 				  const char *refname,
+				  const char *referent,
 				  const struct object_id *oid,
 				  int flags,
 				  void *cb_data)
@@ -2565,6 +2566,7 @@ struct do_for_each_reflog_help {
 
 static int do_for_each_reflog_helper(struct repository *r UNUSED,
 				     const char *refname,
+				     const char *referent,
 				     const struct object_id *oid UNUSED,
 				     int flags,
 				     void *cb_data)
diff --git a/refs.h b/refs.h
index 2e740c692ac..23e5aaba2e9 100644
--- a/refs.h
+++ b/refs.h
@@ -311,6 +311,7 @@ typedef int each_ref_fn(const char *refname,
  */
 typedef int each_repo_ref_fn(struct repository *r,
 			     const char *refname,
+			     const char *referent,
 			     const struct object_id *oid,
 			     int flags,
 			     void *cb_data);
diff --git a/refs/iterator.c b/refs/iterator.c
index 26ca6f645ee..7e04d8427a9 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -449,7 +449,7 @@ int do_for_each_repo_ref_iterator(struct repository *r, struct ref_iterator *ite
 
 	current_ref_iter = iter;
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
-		retval = fn(r, iter->refname, iter->oid, iter->flags, cb_data);
+		retval = fn(r, iter->refname, iter->referent, iter->oid, iter->flags, cb_data);
 		if (retval) {
 			/*
 			 * If ref_iterator_abort() returns ITER_ERROR,
diff --git a/replace-object.c b/replace-object.c
index 523215589de..32d90f35327 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -10,6 +10,7 @@
 
 static int register_replace_ref(struct repository *r,
 				const char *refname,
+				const char *referent UNUSED,
 				const struct object_id *oid,
 				int flag UNUSED,
 				void *cb_data UNUSED)
-- 
gitgitgadget

