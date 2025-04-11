Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86C2BD595
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744413984; cv=none; b=BO509BKJUwkgl8NgVt5glDPJy4SCY3SJv+Kb3ZVmwng0YSbA6NJAkUzewzZq0cg44DDEVZqKQE2GVVmJ8TXMdYqwHXxfn/6MBialE+VQ9Jg5UnElF/U54iSgzg2JZT+yb3U+pHgh9x2L0AcRhiPM+01vJNKbIZUJi+s07tTrNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744413984; c=relaxed/simple;
	bh=D5wqJTmEj8TusnWroA8mhFWRRGsOtCK4HO6waA8KeHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYzjGW6BLZs2Aj5ayjAtavd8KuJEMuhQJ7MIiwRaXtsBaz7PqmJbfCySSngGx0XkFl93ob19P5uZ1RZix97MKHrwlZVP51p9IgqDyYQ703DQVFO6Td8CPRkadfeiHo7ysujc+An+te/vEdEgx8CYAVim10LvycxYtOG5Qd8KM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rlcp39gX; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rlcp39gX"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c5675dec99so240431485a.0
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744413982; x=1745018782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9cOiIlsxv55af/sHxUu/IEXqPKIiPF/rBNErHxeqicw=;
        b=rlcp39gXYfNS5+kEYHRcU6AvbJkxEpWgbQUhi30vsvEoUYYrw4qwU1gS6oVDnZMjT9
         MmtNmltQ7TeXw3ua9Fy22IW05yREf9XTICuPD7WYTwoKJn8hK+5o2nCQyR+zbB5WKCXc
         hNqTNavIFcRG5RYoEApMO5GTuyC75x5T69GQP1/sSJb24TkrR4+LmIvgKWSludhD4454
         pEdvOzBdFm95RFDgXS0HTCqim6oj5MVHDi+ns8m/t+JYnc4reFyJligBfxx6Ef0Hrui1
         pzo8all1I+wpfGbJQe9CCog9SgK7KPTHUcsxg+KoA8tZeYnK3WuDJfgHr6U/C4g53NVw
         Z7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744413982; x=1745018782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cOiIlsxv55af/sHxUu/IEXqPKIiPF/rBNErHxeqicw=;
        b=OrT6F2uBx9v7kUivHafPLQTnjcQE+cj5EL0TH7ZyfF24xuNloCwboj7dfTNUD6spZm
         4sfJPMzDqOz2ojX2FLC09ZKDTfhQfSGF5P/V6eirhJusFgdjZ7TjS6eQBp4Fl3C0d9hE
         hQaDIC/bNsNrgjtg5/R5i2T9hSgKuI7tzsuOzVYIbI0tKfKxLlwI6kNjfzYRz6oKgSOr
         WTO8W5VF7CAjj+rDurzLljNnx+Y9LxrYjN9MhRyRgFOuOR3SPwqlMMpFUqbRqfoRTrtq
         HvdT25oKAa9dCDJZNmBxeBnot9BlnJHVKntWjBUsEHkYyo8pdQYmKBhrmaR6DqJvPCiP
         tGSw==
X-Gm-Message-State: AOJu0YxdOsfmtMz+OALbJS07WIehMJuCwm9GjrE+AFAkTlwM8RbWKOnM
	+JOU/2X47ZlTnL2I30JcFG6jXaEnRCJaVpTxBJG24inRo/UMyXIx+CwuI3J3+LJqnbVbL383d49
	gxSw=
X-Gm-Gg: ASbGncsieSaCG7YV3bmTLV7uAqHiEQDwjS5x88bhzbQHho7TtJhUmJVOFUXAgz9cxG2
	nxf63DMF8rYI5yjKzjzMvlViczGM2cR+mtZeTuYInhbA+GZ3ys81yH3W2w76p7hKDPF7sbyJ2YV
	HYtjhEGT33AO6aBroAy5LSE1RySMNk6GfxEb3dGZSMDX9WE1n5kO4r43CBnKXDs8+56/2w6kFqo
	bkwZ8VmHGUewqcZgi+kW1U2e4TMQncCGEOOVvFogox1pSgzbRWhWVPGZM0A19/6841fpq5jXGW0
	YzApdGP+UJp46+TGQk6js8irn1iPRNwJ+BNRZiKa9Zdcj0sOSpaevJprWXEjuXuYDkb54+/yMSV
	z2S92nugeeC52
X-Google-Smtp-Source: AGHT+IHHso+WqKwyTx5n/ORPE4zaGYpPXf5b18pclJ4xpIry1VIYN00a9eo4SGifG+A9J1w7KJ/psQ==
X-Received: by 2002:a05:620a:28ca:b0:7c5:57e6:ee87 with SMTP id af79cd13be357-7c7af1caba5mr664230385a.41.1744413981620;
        Fri, 11 Apr 2025 16:26:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8969e66sm327831585a.52.2025.04.11.16.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 16:26:21 -0700 (PDT)
Date: Fri, 11 Apr 2025 19:26:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 1/8] pack-objects: use standard option incompatibility
 functions
Message-ID: <63fb4dab30a6bf1dee4318341078fe9eb4716537.1744413969.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744413969.git.me@ttaylorr.com>

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
 builtin/pack-objects.c        | 19 ++++++++++---------
 t/t5331-pack-objects-stdin.sh |  2 +-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6b06d159d2..aaea968ed2 100644
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
@@ -4691,13 +4692,13 @@ int cmd_pack_objects(int argc,
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
+	die_for_incompatible_opt2(filter_options.choice, "--filter",
+				  stdin_packs, "--stdin-packs");
 
 	if (stdin_packs && use_internal_rev_list)
 		die(_("cannot use internal rev list with --stdin-packs"));
@@ -4705,8 +4706,8 @@ int cmd_pack_objects(int argc,
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
index b48c0cbe8f..4f5e2733a2 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -64,7 +64,7 @@ test_expect_success '--stdin-packs is incompatible with --filter' '
 		cd stdin-packs &&
 		test_must_fail git pack-objects --stdin-packs --stdout \
 			--filter=blob:none </dev/null 2>err &&
-		test_grep "cannot use --filter with --stdin-packs" err
+		test_grep "options .--filter. and .--stdin-packs. cannot be used together" err
 	)
 '
 
-- 
2.49.0.229.g19b69c1246

