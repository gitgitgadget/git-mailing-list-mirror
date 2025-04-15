Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320052561D5
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757212; cv=none; b=QOflME0/+ch9kkL9VmQ7qbhpppgOemQPRfqm00ihxUcvIRCIQWWeKrErapDkHTtwb+K+nxhq/Sad666W2HyAR2b5cRpNNzzKsky+C+HRk+qVmHGXt/RG0oI9vZW9PxlnOxQUqJTC4U//hcHUrbjZyZ0hMHuW0BshUmxhhPDG4Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757212; c=relaxed/simple;
	bh=M85u4OSmuxEBuPFakd/5/Py8DKdU3V61xgtqaRPHa/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfbL2WIEkBH5bRznqfDK3Jdc4YEfwarFEJ9Avs2mEAZtDx4gULjVlydz04VZYvR32gVqy8tEICqMvOuc4Mkw1PZmCM3xZFdD5lLP/tAwbPGDufxeeGTMmq8txV0P1qwWCqYDeEEr4zdnh+gNpYGIaBL8jYxkSw5qo0l0ioJrdwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=D0kHt5ZR; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="D0kHt5ZR"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5a88b34a6so576868585a.3
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744757210; x=1745362010; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TnitAFRHf0ebOOdV/u/iJ2z0b1BIP3zVys35hBCjWXA=;
        b=D0kHt5ZR8ATjzLmDWE0QEsVnV3fdWQwVyFymx9TgJS/sF0P0ZdAhwq2gM53Px1IXq6
         gLd0mOWj8/G8XgYt7gvSRP0MrmsdwqwCE2IBFeLS/FQhIWyRF++Dy2TCDs8dHZsh/3zX
         nrfAbxpxUP4QkljAXSvur/1WeuYdUajQ5+7XSCkacAQj0tsR7iKq+5h6pb/6zZ2MaIcu
         QtenCnGgnLk1E2/ka68RAzCc6ZNNZfKIWIqu82llwNNSGkZw3CzZinnedkXesDqZWb1H
         JYHa6lLw7kkhsZP3KWzX4lQA/XtViVG2qpbfqZPzuwy+kGQBa+4IVeEw7Xf7FgyIfgiG
         XfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757210; x=1745362010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnitAFRHf0ebOOdV/u/iJ2z0b1BIP3zVys35hBCjWXA=;
        b=RJCYJHp07HbtBB7VliDhVaK/TDtJCtrk7YDpHsx9L2WHz1iC8qXtlfWroVZ08kxz/j
         ztFdJI/qJgpiZ4x1Q/qGKZMteUlSORT0fm2zBshjZzC5r9bZorxGvlo2u6GsAa89yenr
         VI2skY3tVfC1U6fB/8GQgEGtwdxLiiRR5BifaVErzQJlspyJjY6Ci41uY3HSkPnGdYZI
         V5MuAuuEtmSRDRL63YcfLD/AkbIE4SFu4BBjj+kOJf2sA8RZ+vJyLZg8UVP3++j0+rfL
         GVD1HeQDA9rTlhEBE83XdH1qBCXskptsd5W2rWPNVAGMyCdSP62GB1oLOndnSb0LU63b
         IX8Q==
X-Gm-Message-State: AOJu0YxiQWEsjei1BXXHdLiC6eB/tvIQsKbFQ1+4I1z5pTD36FJZwMoY
	7tGWPguw0sQXQNgla3P7Ptwo/NbqREGwP7kLM6lXFJBkfT+/eWkh1Tr/ghsiKy2OohOPMsCup1p
	j3Zw=
X-Gm-Gg: ASbGncskY5EUrI0k9qfIWxLqOszyVskRf4TUNV2tIEIgt1WbSM8LfPF0wxvPJ6Vjq4S
	j3jpfjkgoiPb3qyLg9cwVdmdan9BmMhH2v7/h+0PHK7vbsdWfIqYY2u0Zfn4zhsGSTxUpQelj3B
	NcwfrLYZfOGTMFk3WqqxEr1QKztFncGRmmFeF3AdJrRmNTsvX3fwQY9iO1NM55Mg/OFgc/yqkJU
	aXYYw32iwUeUErOdRj3IUk5I4ZaDHW2M3odHeGLV7WVG9q05qbLa3lElpnkxrivjK1WFO09p6WL
	Akr+K74cKrD747jkdIS9XKl/JUOxgktSleyM3sue5hOX+nRp2mrQs9pItpXCFABlyvIIY+PadMP
	/Zxh0ph6pogTk
X-Google-Smtp-Source: AGHT+IHh8KYzlcxgeh+SbsLm7Md1/K/ztCBc6WsivOsy2M7JCljlbUR8w5JTxCTd6CRRgFdmFDxn3w==
X-Received: by 2002:a05:620a:6884:b0:7c5:99e9:4495 with SMTP id af79cd13be357-7c91419dd42mr204923985a.2.1744757209844;
        Tue, 15 Apr 2025 15:46:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7b80a7c72sm647095185a.76.2025.04.15.15.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:46:49 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:46:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/9] pack-objects: use standard option incompatibility
 functions
Message-ID: <f8b31c6a8d788fa53f7b39fb9ae4b61ebfc882b9.1744757204.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744757204.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744757204.git.me@ttaylorr.com>

pack-objects has a handful of explicit checks for pairs of command-line
options which are mutually incompatible. Many of these pre-date
a699367bb8 (i18n: factorize more 'incompatible options' messages,
2022-01-31).

Convert the explicit checks into die_for_incompatible_opt2() calls,
which simplifies the implementation and standardizes pack-objects'
output when given incompatible options (e.g., --stdin-packs with
--filter gives different output than --keep-unreachable with
--unpack-unreachable).

There is one minor piece of test fallout in t5331 that expects the old
format, which has been corrected.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c        | 20 +++++++++++---------
 t/t5331-pack-objects-stdin.sh |  2 +-
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6b06d159d2..20dd870bbf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4651,9 +4651,10 @@ int cmd_pack_objects(int argc,
 		strvec_push(&rp, "--unpacked");
 	}
 
-	if (exclude_promisor_objects && exclude_promisor_objects_best_effort)
-		die(_("options '%s' and '%s' cannot be used together"),
-		    "--exclude-promisor-objects", "--exclude-promisor-objects-best-effort");
+	die_for_incompatible_opt2(exclude_promisor_objects,
+				  "--exclude-promisor-objects",
+				  exclude_promisor_objects_best_effort,
+				  "--exclude-promisor-objects-best-effort");
 	if (exclude_promisor_objects) {
 		use_internal_rev_list = 1;
 		fetch_if_missing = 0;
@@ -4691,13 +4692,14 @@ int cmd_pack_objects(int argc,
 	if (!pack_to_stdout && thin)
 		die(_("--thin cannot be used to build an indexable pack"));
 
-	if (keep_unreachable && unpack_unreachable)
-		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "--unpack-unreachable");
+	die_for_incompatible_opt2(keep_unreachable, "--keep-unreachable",
+				  unpack_unreachable, "--unpack-unreachable");
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (stdin_packs && filter_options.choice)
-		die(_("cannot use --filter with --stdin-packs"));
+	die_for_incompatible_opt2(stdin_packs, "--stdin-packs",
+				  filter_options.choice, "--filter");
+
 
 	if (stdin_packs && use_internal_rev_list)
 		die(_("cannot use internal rev list with --stdin-packs"));
@@ -4705,8 +4707,8 @@ int cmd_pack_objects(int argc,
 	if (cruft) {
 		if (use_internal_rev_list)
 			die(_("cannot use internal rev list with --cruft"));
-		if (stdin_packs)
-			die(_("cannot use --stdin-packs with --cruft"));
+		die_for_incompatible_opt2(stdin_packs, "--stdin-packs",
+					  cruft, "--cruft");
 	}
 
 	/*
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index b48c0cbe8f..8fd07deb8d 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -64,7 +64,7 @@ test_expect_success '--stdin-packs is incompatible with --filter' '
 		cd stdin-packs &&
 		test_must_fail git pack-objects --stdin-packs --stdout \
 			--filter=blob:none </dev/null 2>err &&
-		test_grep "cannot use --filter with --stdin-packs" err
+		test_grep "options .--stdin-packs. and .--filter. cannot be used together" err
 	)
 '
 
-- 
2.49.0.230.ga662d77f78

