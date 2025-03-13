Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9401F5FB95
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741834009; cv=none; b=kBQVBQMCkHp6uGLoG0aYDaxYCmqnp7zAdPzAo9y4yiIV5uB3eN9C2DGviy8GfJW4FOmyK/8TeBaQxpN/X/lNv25807lEz0eXkM9HOtFatDMX5OUBb3hyYF+fjTrBMfudbwotrAWxAuJV8ANMaHz30UsL6AJl6R9RDwnsTMom1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741834009; c=relaxed/simple;
	bh=/l7IKIFHKD+XCI8QjZ/6r8ALTma3Z5f46t+dZNPiITo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=czyZkv8ZcvNDDd75NuetvJyGOkmmwCYvUFQl2Zm/TLy6rfK4GDgLdtgcnc68934YUg5E02C1mbx9NU53OGqtEPhBjS61NUMx3meyCGyWFYB1l7YCSk31eqpDFvAnGik+88K7ClrhL7JvJWKPnKTE0rkliH59mv/3HADBPm8A7As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrcMj2rQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrcMj2rQ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso107395466b.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741834005; x=1742438805; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J/vEF1OqVfBsM3dhURjp4SRf5MgIYMEoobbdf3odIM=;
        b=mrcMj2rQlndEzxuI6UFUN2+YHYZZpcBBV3RMYiQTpWhAly6tQQnFy9K6Z5IP4IRg0w
         9Dj3h9GbNOWIkt9ZR0yyjKkrsX6Yajs3IqZINOAL2eoJvNVXk/mtdfUaS/Gaidfqil+4
         f4n4Gk47nl+rkp/FXdcpMEIDNoqOZuGM9w3Q0PAwomg6rcrPIIXMRAyllsCA9Yet+Op4
         vqeU6ryX18jaD1lweiNPKlL6XzyAqYEwr2deqnMbQ8ZNjSRGYc8q0HnBY7fTkQmGkcf6
         qYQJ/aUblTkmvOw0YLiGzOVG7TSC4koCh9lvG856ru7Hnq8w8CRAhy1kgn99YAXZIIJp
         zcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741834005; x=1742438805;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J/vEF1OqVfBsM3dhURjp4SRf5MgIYMEoobbdf3odIM=;
        b=IiW5FzqNmoeHLp92hVO/VckgoaCOy66nDwfQ7/X5im6VFJ6kdG6rH1pjP1V4wtyCZn
         fDqeJYAIVYYbWFwPjapeyFKoYOz7YpTCiwOY069AmFKqL1AuEbnCeOGTNpLpNI071GOu
         ImHbYIUEkzfSy/Qfkpj0skkXEPZaPNvxvdlX5AQP1GZFbjYELg1Dep/orapZ9NW/GSkr
         j4SMGWwMLV36Mzd/yo9+r5AorUcw0ljuf2vaer7bG3K/Yx5zT5hbWUfz93dmIgA7Gxhx
         I0hzP0eT+6hoyBEQhp4suzDUp6Q7EFffvbNJDlD5Wf6NbhR/wDPob4QeLzLHDeAvcocC
         Kvpw==
X-Gm-Message-State: AOJu0YwFn6fzh05lxYaatlts4Tw5bGuEerLHsAwCNSM9j8qjHOG7NSlm
	YfcmAadaE8TVaEjcnuN8j8wO4SEC1JbslWHpGj+xjjyIfDWT9vBI8B8bmw==
X-Gm-Gg: ASbGnctw7GySnd79TI5+3FxSxxz+xl0eL8IrSIaousUhIkBFywccahcOFIroZzqG9DH
	rzrkMiJRJKKbORWtCwhyhesT60k9AcjbTEDoGvPdFvSB3IrRi9A9lYyXMelb7a8U28VclOopjF5
	b8dxAMApSbMe66D59p911JwciDekQ9yz6++rL7w3sqmoYToxCEzPuRlcSswdhc/Tg1SE1/Jsdfz
	eJhVMh/AUgwXnYeDcTbgcuBTW0ZneDCvht8UQInXTvMGXI2mgk3v04fOl6xZo9P7XmlPBtoTVxF
	m/1/UXGWLWVKNYdLkKvp0002fHgEmMlR62dk13UcfvFsgg==
X-Google-Smtp-Source: AGHT+IHdX5fpFDRMtQME6fConWjX9J1XPNrB1rSYMzVugh2vanzriBntRYcsjYzRPOeoLNFiu+hdOg==
X-Received: by 2002:a17:906:dd1:b0:ac2:6bb5:413c with SMTP id a640c23a62f3a-ac26bb54220mr2136123866b.31.1741834005258;
        Wed, 12 Mar 2025 19:46:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314aa4b67sm21193266b.172.2025.03.12.19.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 19:46:44 -0700 (PDT)
Message-Id: <a508b0a0fe21199ff8cc6a1c36fe237b35a84deb.1741834001.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
	<pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Mar 2025 02:46:38 +0000
Subject: [PATCH v2 3/6] merge-ort: support having merge verbosity be set to 0
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <me@ttaylorr.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Various callers such as am & checkout set the merge verbosity to 0 to
avoid having conflict messages printed.  While this could be achieved by
avoiding the wrappers from merge-ort-wrappers and instead passing 0 for
display_update_msgs to merge_switch_to_result(), for simplicity of
converting callers simply allow them to also achieve this with the
merge-ort-wrappers by setting verbosity to 0.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort-wrappers.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index 62834c30e9e..c54d56b3446 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -33,6 +33,7 @@ int merge_ort_nonrecursive(struct merge_options *opt,
 			   struct tree *merge_base)
 {
 	struct merge_result result;
+	int show_msgs;
 
 	if (unclean(opt, head))
 		return -1;
@@ -42,9 +43,10 @@ int merge_ort_nonrecursive(struct merge_options *opt,
 		return 1;
 	}
 
+	show_msgs = !!opt->verbosity;
 	memset(&result, 0, sizeof(result));
 	merge_incore_nonrecursive(opt, merge_base, head, merge, &result);
-	merge_switch_to_result(opt, head, &result, 1, 1);
+	merge_switch_to_result(opt, head, &result, 1, show_msgs);
 
 	return result.clean;
 }
@@ -57,13 +59,15 @@ int merge_ort_recursive(struct merge_options *opt,
 {
 	struct tree *head = repo_get_commit_tree(opt->repo, side1);
 	struct merge_result tmp;
+	int show_msgs;
 
 	if (unclean(opt, head))
 		return -1;
 
+	show_msgs = !!opt->verbosity;
 	memset(&tmp, 0, sizeof(tmp));
 	merge_incore_recursive(opt, merge_bases, side1, side2, &tmp);
-	merge_switch_to_result(opt, head, &tmp, 1, 1);
+	merge_switch_to_result(opt, head, &tmp, 1, show_msgs);
 	*result = NULL;
 
 	return tmp.clean;
-- 
gitgitgadget

