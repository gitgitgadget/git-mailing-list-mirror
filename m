Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158BA22E3FA
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375812; cv=none; b=Tk8i+IwSczUPlxMx3FtipC7MTkIzB43mdOa18Q8jTZEkW4F2XU2neVQooxjR5OwjxO3BvQ6MDzQjEWL0OYmm/uZDqi1ZZyY38A4LhNTTBb7r4QEURWqpXrLnLQZpUJ5UeVpeqaQxWPgWUFAj6ahzqGk4ocPFApKxkkqPAXWDxPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375812; c=relaxed/simple;
	bh=F/xoK+9xg+g2DFWFzUqRSuLkfpXOMlaHJnymCgfuUY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpnnz52fuSgcZ2hSFwkjKElqyP2SMSxjGq+8dkyKBWgDdt8r1z5ouD5sDh2AZiB8GfEMYd9WSVgr17DsfjodU85aL9CjeJxicrZDYUjWyOmgy1y5iHGi8CoUwbYD7GJ/N/ftkl/kHxvaTb+1euPq47oEgQC7lV7fobNVKyYW0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=cvcY6i/a; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="cvcY6i/a"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e740a09eae0so1343094276.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 16:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750375810; x=1750980610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lRIoNKefLi1Z1EKrVfH8BZWgP6YmtQVD6UrDW2dNdTI=;
        b=cvcY6i/a0LqsfGymKiQ6V5P7rOOD+czB5yZTcY7wT+xC7rNLwEymgP3F1G/oP7DkE/
         uXqB1YbpqGy6RxaDEeJhKIaajvfPwpZSnJsgylgVozBa79q7BQhBcji5jTUZBfaYuECV
         dMEzwbzCPTSaijRvP5ut0Rf/hpDskUkJ4piYiCU/9vPvygsuoO+R1dJmV/Cl+2KQqGao
         kfXIasbCUVw5mYSLL6XvbbD25S2wE6qq4r4kHx5bCA5rmfeyWvAM58AEjJe94Nf9gt+H
         ztBBnanDUN9nolTGMnYjldhDBdnkXh5PPa1WF8QMMKN4kWHOGFMX6TWKReyv2+O80da9
         Gg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750375810; x=1750980610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRIoNKefLi1Z1EKrVfH8BZWgP6YmtQVD6UrDW2dNdTI=;
        b=OVhDAf2Jhi+gZzfB+up+RB1HmsG38m1VPrXzvNQYdZVNcKJ+5I6Em311Z0393Aa0xa
         3X8+ciD8fbnYH3G+DkrZ3f6fux1whe7CGn3REnfIUDbt0o78z0UIKA7l0FZcm0P0cehj
         NurF9e/e9g/kR/g0QFIo+zkIi2AFyaCfH59FP++Us89Oa63VmaCY/0Ireg0pYEn9U/a8
         HePtLqUwHIlqdX3J6VkdSs5n2MDPBiV4KApnn0hkVyjRD890yKzwKwcR+5Q6rIvidWHZ
         wHPutDOhR2Wc7///vAsQDqFRMuaizpBidxm5klvRkn6toVSxqOA/009llLttyd8Qib+3
         dgfA==
X-Gm-Message-State: AOJu0Yy8Jx2DySNvpCSssrJIzF5HFCG/s6oIbW/EriHrJYXindXRmEjw
	H2bPfWtMvFJCS0WwnKRTYj/igPTTUh61p0wuIo7dDhXKBoi30hWf5NfRgWk/mk9uXABtKomHRO1
	IN/jP
X-Gm-Gg: ASbGnctV4DOyOdwIhbJoDSxdbC9R9e8VpyUXY3UEFuRWMkbOAJklvf4kku0psQ99LGT
	jf/Lpm0b/WV4eCNyFMyNcJsyi7frTNMMao/v0Wj29rWvsY4MumsUdfnKeEspjbSzHFPBfbdvy0S
	dKY2vqTJ4fCuudkbhfzxle2HXAu8dLUAk94oeFrOQnh48dcURDZgMvI0HZcQu634mvsTBhGDEG1
	G97RuRIzdiFn9fs/TZx2UcHEaIsurfp1kOaEa5650gXMJsAVXFo7OCcN+QDAl+nyniO4VTUy+9z
	OG7GK3h4aee0sdFGa5ldsIlZIVqqsD6Lv0pM1wF7BtDDNnGjA5LuoAGN8OjKpZj0oELW7qm5NEj
	zkdiKquNkLI+SPHVfhn9FlWxutMRJq+PX+A==
X-Google-Smtp-Source: AGHT+IHW7SXfaGaGrw8mD/4Jl1HarX8sWT1TNkolcL23J6v6JepiQi0T03dEVAwiaFzAvMOh4mcspw==
X-Received: by 2002:a05:6902:1893:b0:e82:5dca:92fc with SMTP id 3f1490d57ef6-e842bcae1dbmr1497675276.21.1750375809889;
        Thu, 19 Jun 2025 16:30:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e842ac5bd22sm285422276.31.2025.06.19.16.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 16:30:09 -0700 (PDT)
Date: Thu, 19 Jun 2025 19:30:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 1/9] pack-objects: use standard option incompatibility
 functions
Message-ID: <ebaf47262a6d18b019d1b23a9b2b2c37a1e60964.1750375803.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750375803.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1750375803.git.me@ttaylorr.com>

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
index 67941c8a60..e7274e0e00 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5010,9 +5010,10 @@ int cmd_pack_objects(int argc,
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
@@ -5050,13 +5051,14 @@ int cmd_pack_objects(int argc,
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
@@ -5064,8 +5066,8 @@ int cmd_pack_objects(int argc,
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
2.50.0.61.gf819b10624.dirty

