Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902D1C701C
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661176; cv=none; b=iB95/P9NrjjveZ7P7ciA/yo5gluUnC0a/Tuqb9/DCiCjE+kyZkHuwgr0L9hOYflUaGIWqq4HG4CuYeRxW2zVEBjSlFU4Vq7S1oz3bpovR4ErIyuhTG/5Cgk5FwgC9BMvGGY/z0bL+axSpJNZHjvWd3kb3XSqtP7WoRPk+x+CkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661176; c=relaxed/simple;
	bh=rAwGQJalZ5CwxkLrmaK6o/kKPm/lDj3nLf4I7niJn8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9sm5PNioznjpHDWD/BT/68yOyASc4fMo0p34ohD4/Z/BtcXTc0+XerssYJjbR7ejP9rRl+6OTAcF63oMGQ3tXxDedi7EUE8gUTC4PfzJ6ryL0Aqx4fYaDT83kiubY3iets66I2LUzTRS2pcwaGFQA551ZnM0FiId5QUM6L5Jeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=HnNNt9Ts; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HnNNt9Ts"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c56a3def84so419970285a.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744661173; x=1745265973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GJnu2mXXkFiYFvNMoALtNohOj1NFQW7FwdK+VC+Aiw=;
        b=HnNNt9TsLexJ8mEOBV+ToSXb5vcNWqgCtrP5IK2GKJBdcNkS6ZTMKhWIhMdcAzclPY
         tZST167h3YzZOEEcqwegHrKrj5mCxlM05WKorYmL6dc01KDK4f+FaldjMq9lrM4tqldM
         xEJUhcTgoAnNKB1UvFqnzs1O7ES++f4rFu4nbCxgppJ2nO6vLKxk+BQq/GtwlNszsKxU
         iBApT+lPW2JMYXaEJUif0ZhVETbtzYfSewVJ1f+9J8tMk4fgCRGYT5BH0jbSBSgs1MCa
         zW+DKNWpz6tSyz0VVVpjtD7iHcKmgarbl16BKOnNr657MU9uqMBFkwnssVYW3Z+vDiWd
         9k9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661173; x=1745265973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GJnu2mXXkFiYFvNMoALtNohOj1NFQW7FwdK+VC+Aiw=;
        b=wAirNV6Zb2s5CbVb3m2U2e6BJtSG3EcClWJm4ExX9O4nSU/7zeSiPA4R5srO0OXgx6
         XrWjo7nzPGy1nMxC7SKDhV1SYUFhLng+mRmHzKU1rhd8kyMiicdJnA3Q6mlaCONTgZHz
         /53F/k8787ELdy2fCL0E69kKsiw8+mF1bAkcu7eVQjGn1b7BVyzfRQO0xBsF91bqGvCY
         LNTZrI4hjrpuxbATKnysji3aglQV606YeKP/26eJm+ekOLfPS8V6lvz55mr1Rf3loQvw
         JO5omL0MsfMZ035iz2zuQ82wrg9+kRAcCbTOfOXUKZ4y8cSodbWI2ZEro0AHWMlF3TNM
         ehOQ==
X-Gm-Message-State: AOJu0YzbCnIZdHjUq3kOph4Fhm6ImBxhHBoLnqK7wbBThYbkulqswada
	6nvB/8RVD0Lrg4MHl6sa1LSrbRE8OqbUSafdNDzRbfkPv/xkMqRdisY3SzW9aq2xFS0aj6hg1fB
	JJEI=
X-Gm-Gg: ASbGncubldGO20P0qMmhrxQsN+4GBfTyh2ztQLrhuR+jWWGYdzjoH0vmAnnQZrcZ4eD
	fLXLoWUDpWJU0jmqKqll/6od20jvBjfRvdgLKRu0QlPQzoKiDXqiNkFzyuy5H98mvCCdRtSLgP1
	p6WVxinFcYClYCGrrG2uQYBKxJgd1HaPcVVE9lAGqTjitBFqss9xWNeDw4xP2ABPHdUgc5Tlr6l
	2gvK4W8ppNMRvD3Xg/s2i3HaHEkXiLg2fXZ+/iPdvm5FSU82nqIUgVhpPxO7PNQjVDm/jyMVU5E
	2O3oWQZ19B61q+41qvSq3bAlo+CLFUYS0yW0aohjW0YhxAZJx9CxBJ91anZ5ft1yZ0bfz5qUTgv
	b4P6PlppMJlZL
X-Google-Smtp-Source: AGHT+IHzzJlzTO1v9Hf6OA4MdkulIJRFDFpNFPcitTbaFAUZNPUSYji9rgvsVxSzl6k2PPLnUC31Kw==
X-Received: by 2002:a05:620a:c55:b0:7c5:96f6:c9e6 with SMTP id af79cd13be357-7c7af0cdaeamr1793438385a.15.1744661173181;
        Mon, 14 Apr 2025 13:06:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a89f9885sm781742785a.87.2025.04.14.13.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:06:12 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:06:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/8] pack-objects: use standard option incompatibility
 functions
Message-ID: <65bc7e46309712e06a2d743172ea4ec518ee928f.1744661167.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744661167.git.me@ttaylorr.com>

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
2.49.0.229.gc267761125.dirty

