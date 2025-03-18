Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9100213256
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338229; cv=none; b=mBrNLdzkYyynW5oRLUb83d0j5Cq19tYuxVtlAOZxfaiTd73F7O9hM/Y85RvtnT9d2ZARF3aZLh09OzNk+Ogw3Mt8Qzf1RjRA91GjsnaT5vVHYJtNM1oWwUrD95fYH3g6D/O4GxAjGknHNd/F+2cZFaH6fVzuN4vrErdnwJxlNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338229; c=relaxed/simple;
	bh=u/FDWV1ATaGJbinMX5oZE8F6K3dtLCjFyK89BoRATrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u95+/oy1VPeawLVn9UuI4sM0/EYrNmI9u0p6UqCnSiGo/Ojof1kxvXCPWrSz/ApVUAalMfRjoVSNDF5OiNogWb+DmHnU8vdHXm07oq+ljtQZFRNAJ09TYz2t6J9Kqb8wfr6Ih6NVxXGvSBYvjyxU9ZM5fsVFPsTSA8aswTY2+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tBB926r6; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tBB926r6"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4769aef457bso68665261cf.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742338226; x=1742943026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RFTHJhzilEZAsOZPOf70z3Emb1Q3HN4MyzCABuGUC28=;
        b=tBB926r6gkT2jQwdoafayq+Zqm1YOKkwPXHCVBiviS6WpnrhltAxvcUnFmt6bcCF0p
         8fNkqc5x2VVLnPI0i0SbyChJACvjk6+kRVwtZR3Au/VEfrAgkCJ8kMkRkblLQk8k7/8f
         i0JHRRrxvXemYb/S1N4rsSwkLU74YdjpD6gyyIpAn1RZDYbx9WqA4dODWg+tFLkg58Dc
         y9V/Gh4vYHXEdexkqRdsbxDTTzuYyvovM+IwpSXOJBoOveoa1qcFjIHFP7gr7UiWXeCK
         Mj5Wn5yoYKH3LC2Kx+n+1hVm18TpmvpBfBynq9AVTe0e/LQKJ4+P18u/LuAPFoduQgWk
         gybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338226; x=1742943026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFTHJhzilEZAsOZPOf70z3Emb1Q3HN4MyzCABuGUC28=;
        b=hdR/+x2rwFDsIu+1a6g5WHeHSN42Z5hG2Nve8jlBryiNyDqIrtErO1pQujf00aQ9jR
         5Oy5Lc8dS4petW8Ikrjp3M70UFleka8vxtkjrXdEI5iySJQKD8A1+uX3DniWJmyjrN3Y
         gwFXodTmEiEvzJpT0yacimCFlxen0UTk1UwbOmFUweQZRTk2GzZarlW3NvNxIWRGT+3j
         L4TYlGXnAbLqf8tjhoaahBgv1byZ+5UEY5hwydQx+G/D2GyO03pSxx0u3NJfbGBIwKRo
         D0lDOE6rtIAnzmV68pTlShmgNXM5otNYXj1HtJ6RarLs7D5tGhaW3AYxJDNgyN57iqoQ
         1TJw==
X-Gm-Message-State: AOJu0YzfTiqgn5YutP/BPFx3NwZaRbyQirew3fOymK5qJiTujWcJB7Tm
	3chGNyc/RrTP/t/lUIXhBq8dB0ynB5kwlANpoMJMUNywYaPTXg9AV5Ya1IvN5jiwchDYdeURtYu
	koD8=
X-Gm-Gg: ASbGncuTiQOIrYeKPyF0uq/zvlj5kq2CDDJldh/aELEHNruCCVONqB1aIeYYyYY6o5e
	w+q+XxA3i9fiAYA2PPRTktYsSB/SSjzA+YLv7Tcu+tib8Jx3k0DpjCYafqg3VP3HJvxHyr86qeU
	0n/yDbuVDayM53UA+jSly1dSLuQHI21F4hYxGwMFW2WsToTneZrKEtb3A9PF+D1F5xrc0g54kt0
	Xme/F40lEK50oHeZi9kcHrR8t00opri4gkBjq7UmhFro92hOokMB2SAhcb+kI36CxsqNw4/2wtV
	EHSGEnENe5CLGgUhENEBTo6a52BP3B3/wb5vU0mmhBAxbw0MCuKhqzF1uOp/leFwHyxfCZ5ji0c
	UzNpskryAZ/ogjQzU
X-Google-Smtp-Source: AGHT+IHpoctWCUmw4JkPN8Qp4Qeu8RPRyNxtwxSxdw5/N5PghHlzWy2Icp+n3bl4NXl+2xyj1Hsrvw==
X-Received: by 2002:a05:622a:a08:b0:476:b591:1f19 with SMTP id d75a77b69052e-477082923b8mr9823011cf.7.1742338226228;
        Tue, 18 Mar 2025 15:50:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb7f21d9sm73996991cf.49.2025.03.18.15.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:50:26 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:50:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v2 3/4] refspec: remove refspec_item_init_or_die()
Message-ID: <88f6a91c468f38669d958c58b2e2eefa9f448010.1742338207.git.me@ttaylorr.com>
References: <xmqq5xkdrrhs.fsf@gitster.g>
 <cover.1742338207.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742338207.git.me@ttaylorr.com>

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
2.49.0.3.gbb7a4a684c.dirty

