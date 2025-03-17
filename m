Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E0204F65
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250284; cv=none; b=mUEMOoJfPqX9gl0ro1p19p86ZaVTTxeno5WVuXTVCJKkCWFp/DEOWLO20xzGYsTd0f8XX4XVLPsrwPIVxBKxZxHeIPpXSggG+Ip3z1scS7IsLZdmiP5EhfMFyFqk978SUW8a8SXjphMoJdGQhBG7iMj0Uybyp7gbv39tenRdJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250284; c=relaxed/simple;
	bh=eDuVZC9+G7aIVoJpt9ruUYVMduarnCT1i19dkda+G7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDOARPTxEry21ZSlOXZ2lg826fW44oaISXo+2Os8YGE5sz6/Jpn1YwqQBsntdcJdYJxZ6ISaZjGtOsqmwqM7M7Vda1/OZ/3gQYVNXyE+1NN3IjWINgDnigpEe4nbFC26qLhd5NMBrfA3N/2YxjzHQb2n/ppRHnjhX6nHnB/5Cdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wMf/Mesa; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wMf/Mesa"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7be8f28172dso333417685a.3
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742250282; x=1742855082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0P8RX6A0uUfnXMo4Dm2UBaTMzEF8mdOYU7JRc8s6fLA=;
        b=wMf/MesawnbxNYNppKB5OcjgH7ZOjvCk1iY09rfyP9g4XX54AYiLg7SAl4ORFgmyuk
         wXKxF+4xrOy2RVvydydBp79xz3VpQzjvzAO1T+A4KWjEih7qQYFb84Nr7cqEIMC9HjXK
         lhvzn/W933owq7GJW9VxmyQ2erCvcfB4YpVUnxvemyyrFzKHdgVRuS1Bqn9maiQiP1Tn
         sUPCbVnmPmTw/MWt3LENyObcDcEbSKi+dlOG+e5ymnC8Ze+N1/Z2Nu+EDQR/FO+jMl/F
         px5lMaluxxy5DGFOlht2Q9rpycix09Ftbd5yuVMAzIgYGz1sGbGn3YwTsGu/Zz4fBzIP
         lMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250282; x=1742855082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0P8RX6A0uUfnXMo4Dm2UBaTMzEF8mdOYU7JRc8s6fLA=;
        b=vmgM3pnp6qc+9amM8yYeTUp0DVu0NDVD13MXMy1DCcDc9mVAQBXpB8fvLxBSk06CZQ
         bv11JAxYirUfwNGs1gII0HW6pwTspEBodpq2WyauGAyRICLJ1IufCWh3PM0JOVuTsN/A
         1RoMpzCoNIYsGxoYoubTSjmwuGn7qPCsrSBeonV2xEgwvkJPtIPlWePpA0Ls7xbJpWcK
         SIJcidHJcsItZqGeBA47opixBg4bzOuhvdDNhvMi/Ywgvowxz92QzecPM0bLru1CdiFa
         +57ey/RqaJdFnPmCqFpuLavmOdXYF1uLeE+FUFeIZHUY2aC/g/2VSBbGVwZxdwVjPUcg
         px9Q==
X-Gm-Message-State: AOJu0YxNE5rsy7A6C2nChwlGA1tKHqFKyVISiV0xfiZhByJODWAdX3hf
	T4/sO1J+NpskdB4MNpF+Uw3iwXBCrloJm0e0rLkN4OuSXmTE21sHyNhJdrF9+ylsgbOzVzcNTNl
	5lqw=
X-Gm-Gg: ASbGncteFicN8tnjMZNMOtDCaJS/DWVRoIbN7s6MZJgU4BNm/mJ0CgHX4Hw26NkhVew
	LWIFpQHuHEH3KY96EutNuOo4efqMoYUKtXCKJvNRCRhiPHvyHduq8W76x06kge4NPUbWrYyAwzJ
	NPX8RH6hHvUXxchby7zbDPBNOXqzo5UyplNCX1Gorbm+6pKYUThmcZr1qebte0HthkaGpU/qT81
	oLmhERUIOoQVgQM0sxJBEeEcBeR1RqOqgf8DkDr/V1yKist2M5waU1Qe6sCYVzBWqF5kBmP3iSS
	FEDg5xcl/IQL3AwGCaXONpNP24qcfwbNGlXoKCt8MTplEDeQb4JaUd2z82UXj46AqBVJHlOgoyU
	6rokhbTfN8T2pMiaK
X-Google-Smtp-Source: AGHT+IH/Uhz005IGhKe/gxOnP+ohs6lnc8RLP0g5lwPCjmZNejEwfey5Fqc6hfhhQtLV9lHJRYbgzA==
X-Received: by 2002:a05:620a:45a8:b0:7c5:4463:29aa with SMTP id af79cd13be357-7c57c8acb35mr2249421685a.40.1742250281824;
        Mon, 17 Mar 2025 15:24:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c4e60esm641862985a.6.2025.03.17.15.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:24:41 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:24:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 3/4] refspec: remove refspec_item_init_or_die()
Message-ID: <49b470de61ed73095d04a9f26a7c0e5aa76bf0c4.1742250259.git.me@ttaylorr.com>
References: <xmqq5xkdrrhs.fsf@gitster.g>
 <cover.1742250259.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742250259.git.me@ttaylorr.com>

There are two callers of this function, which ensures that a dispatched
call to refspec_item_init() does not fail.

In the following commit, we're going to add fetch/push-specific variants
of refspec_item_init(), which will turn one function into two. To avoid
introducing yet another pair of new functions (such as
refspec_item_init_push_or_die() and refspec_item_init_fetch_or_die()),
let's remove the thin wrapper entirely.

This duplicates a single line of code among two callers, but thins the
refspec.h API by one function, and prevents introducing two more in the
following commit.

Note that we still have a trailing Boolean argument in the function
`refspec_item_init()`. The following commit will address this.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pull.c |  3 ++-
 refspec.c      | 10 ++--------
 refspec.h      |  2 --
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 8bbfcce729..a68a9955de 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -738,7 +738,8 @@ static const char *get_tracking_branch(const char *remote, const char *refspec)
 	const char *spec_src;
 	const char *merge_branch;
 
-	refspec_item_init_or_die(&spec, refspec, 1);
+	if (!refspec_item_init(&spec, refspec, 1))
+		die(_("invalid refspec '%s'"), refspec);
 	spec_src = spec.src;
 	if (!*spec_src || !strcmp(spec_src, "HEAD"))
 		spec_src = "HEAD";
diff --git a/refspec.c b/refspec.c
index f6be0c54d7..3aeb697505 100644
--- a/refspec.c
+++ b/refspec.c
@@ -160,13 +160,6 @@ int refspec_item_init(struct refspec_item *item, const char *refspec, int fetch)
 	return parse_refspec(item, refspec, fetch);
 }
 
-void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
-			      int fetch)
-{
-	if (!refspec_item_init(item, refspec, fetch))
-		die(_("invalid refspec '%s'"), refspec);
-}
-
 void refspec_item_clear(struct refspec_item *item)
 {
 	FREE_AND_NULL(item->src);
@@ -194,7 +187,8 @@ void refspec_append(struct refspec *rs, const char *refspec)
 {
 	struct refspec_item item;
 
-	refspec_item_init_or_die(&item, refspec, rs->fetch);
+	if (!refspec_item_init(&item, refspec, rs->fetch))
+		die(_("invalid refspec '%s'"), refspec);
 
 	ALLOC_GROW(rs->items, rs->nr + 1, rs->alloc);
 	rs->items[rs->nr] = item;
diff --git a/refspec.h b/refspec.h
index 7db68e56c8..614f34554e 100644
--- a/refspec.h
+++ b/refspec.h
@@ -49,8 +49,6 @@ struct refspec {
 
 int refspec_item_init(struct refspec_item *item, const char *refspec,
 		      int fetch);
-void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
-			      int fetch);
 void refspec_item_clear(struct refspec_item *item);
 void refspec_init_fetch(struct refspec *rs);
 void refspec_init_push(struct refspec *rs);
-- 
2.49.0.rc2.13.g95783265fd

