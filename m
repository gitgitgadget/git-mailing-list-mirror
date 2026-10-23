Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756171;
	b=H3TUl59JOjBjCZELlVOqDHZA3IVyAqGLBqcBvVNHktOwjmFyU9My0EXibGBlIFaXEHpv
	 27v6clpqy1N3SZtdFRPlIp2p5Q0UU0ncddl8Njz4xJCU+6wCMyFqKGtpdhMdXlCIz0ObD
	 wszk9BKDMjw2T0ligpRF4vi2ZuEEKi9hXtw50nsNUhqkYcfDO13LucogJFf0VBiDJeo5S
	 j5FJRyJ7yL7Ip9/XuNM4BZ4aeao3nnMbo/x+CsT+RV/XM92j8pRwR/p1ApiXEBwfOoYyR
	 /HK7jeFKwwLodeMj1Ptu23uQnkTiIm1XCV1aBXUptHR/92sNjcvN3x3pfJp88IML0BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756171;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=sXAGyylrGDzYXy1aJC93hZSs22dGUL2g4N+jcDqe14Q=;
	b=gf858kP3njB1OXSVVbhulFPFKUvt2bgRxum3fwGlxglf8Uc09G/yNoMPh9yoU4M5VKR1
	 cIVBiU7srCfoV9eLLNJ2xwU5PsMIi2Deo9IXqHAC0FnTj/qhyN6EJCdvy1oH2dd8o3KJ+
	 Zc+sjMH7itR1uCeyfeDDuiGz5Lyi61eWRuvAQUhcfQOOCISYScY+BmoJdAmUNXvNkeYOo
	 OIxsyXGtZkoXPgDo6s0xJY5Cbs8MC3IjOr6ELv7TsPh7tUiIpru/AnQ4QjT+TKs2hxYyF
	 GMTWWQ5z5/I8kN7lkGMUgrL6jd88IcT0rQu052tuUMRSpR0kIcbW49ofhdDVkTOnHmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="KK/BKbGt";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="NdRBE/vF";
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF240606A327
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF240606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=KK/BKbGt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NdRBE/vF
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 29A6B14000F0
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:49:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 23 Oct 2026 07:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792756170;
	 x=1792842570; bh=sXAGyylrGDzYXy1aJC93hZSs22dGUL2g4N+jcDqe14Q=; b=
	KK/BKbGtnqXUv0+k3cbtX5BRzufhx5H8asUEHWLAhIPz7R/sPegMTnCV1fO4HYhP
	TDhVjVTeXsS/OlTk128ai1tohmyZDB14yS6dHRtZZBs3uZSVXurA4rx+5gWfFCia
	af38711ibZ/ORZ4UIeMaR+5sMKGLfgVTcIo3BU2LXm1NpcdlvakKxcOHBBdo/i81
	ngS/9xYPuSJV2YDNFwZbFs3wGRcUReN6zuKR+1go979SuFxo+arGUneZxhCYJngB
	C2omd9yS/XdcWWY/eO4bl5rMHX0T9SxgvR+w7HAOZGUW7AtLaycE1CYLB37Yeauv
	S3sBa2TJqHt6sabSX6amAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792756170; x=
	1792842570; bh=sXAGyylrGDzYXy1aJC93hZSs22dGUL2g4N+jcDqe14Q=; b=N
	dRBE/vFNz5eyD8pVTXBF9+Q3tZf2WXPldjvGHwdGPot4/SbJNDavA3LIu//9KkY0
	tzkadgGe11lVVlMHLhV7bzEoQx8lyYuGy5dW6Iqv2cLTt1d6k+wnHIONaNA29GCY
	6o/qZSX8OMptEWgTrfH3/4P8Wuh7FsDtk4ZxKjToS31cfFdxmFw6XPBF0oqQQZbO
	ArMLEF3VBZNDB7HAEM4Rb1Ssnqn/2ha7GHsiTnqxDHoG75NMBsVcfNkZownSqzZH
	e3a+JxknRoGl3ls4teqrqxAYOvtM8mzIxsafxklZG92BaI5QLsOQko2ygvuy6+ck
	BztNbEYDN1Ueist4GPzew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792756170; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:B0IXSp3CCyJwOHoui3FDSguLFXR0/j14rG6AXhvat3IPV1p
	7s/EYeuHoUxIkRY4TVlXlH1wgqSNzq1aED8OqbguttwXp66LhGalF3jY1WSMrU9d
	VvCrxgniqGYCfZnQ4HI++9De/OlCzbSinVuaVCQcaMy8b+y0ExiA/sC8kiLydi0U
	ECSnLaWQQlAlCCSuTM8zo/X6U1ntQBIAEi7j3DiOHS50X9tpb21V2SI2wFb17oUS
	mXPi0byl9jJ+VdHX2ru88xXhT0Qa5qch2eeo8gyHrP4PUNSTmly/A+VEZEDGMUFq
	0sPNqTadO4pNSFfQ8rFFtozUDe1i7Q0PqWgbj9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:chZ0isE4O/2XKtIwXPKH9qv9NF15u9OGWNRZcdo9k1k=:cnULn0e0p8+xNtYciEXbtyVrOFdVAPO8OCUtKSAD/v8=;
X-ME-Sender: <xms:yknbaqC_GbhELSfFOCgIk6VrJe8qx8135ARzKopoQ2kr10pFmGKl1g>
    <xme:yknbaqj2M8Xyyc5ybtqiR4DtU05_Ltle_lEbDJ_iEhep1c07twdm1S0FZKmL3klF7
    WKGSr8ArgOETXLFEaKw_qaKsBHfN0YgvICzZbdCiJ1okW4mgYriOQ>
X-ME-Received: <xmr:yknbarPr4-2XVhbyPL4351awbaj5bblzp5nIwHwe-w2Fid7YhOsp3bgVffZNmCDZz7c7Qw>
X-ME-Proxy-Cause: dmFkZTG0+hTO+i6gMx2nVhgf75DkCE1cTt5MaS7zW1lcYP+Rtj9tZnDxzJFmwNUv7xIeFf
    pq00VhSt35RIBrEctxEBpEoN1WAdHAyzZxJpjxxR5jr7PtrISGHynyftfiUGGvyMi5UU81
    VDfcqG7TD1ZL1HjC9e+v1QSHzDDF0WmiZLwGJmjNDj1Um6RpRoLNDl31SYJ1C3FmFei4fA
    Wf+h2HH22/lslJXbXX6Kw17T5UYX/uKBinBzam/dkd89JikzU4X5/r3f/Hcw1+14lRRCb5
    IwvHBJkMXVWCT9c35EPAdsKZhlNTZNJrjBEowMV0M9iEHP91FDkgj83CRwzVxUUBq4/kPa
    eBewmRXe2gJri65AI3QVotWS5Oj02PJvwt2Y+7/TYjNz1OsRkG2/zEf+m9aaGxnVWyl+uo
    eFXoG0tSqnoCbsKjZk7GvJ4vvRFXyc3Mm1BxOMlWNA8ZVuND2RymcFR77OAcR/2SrwVK16
    lhoo0WPajR5Gv4xL8h6rX533j1IxfHC2xY0QsEWAcfXZFE5oVZHLeQCxqmIrOXS5z4yl5w
    9tD4XmoSQLJvZa6QD9D/rVH7i13yDj8C50F3MLVLJ8S+U9OxsK5VuWtWA1eRNH7K1TW0p2
    paYbYMS5Ei5srveiXC4HwpqfJjaeO9Z4SjXUsiIzSA8Euh3jiBPMIbTUJOow
X-ME-Proxy: <xmx:yknbaj52rLqXu0OPopWJ54vOm8IscjZnDyFnQiYzFbmN0bt9quP8mg>
    <xmx:yknbah2KmByXgbF-5v2cA6A0nWD_TAQwNYtD7dzFDuZIfQoBIpze6A>
    <xmx:yknbasbHXE8hcYB6RW7pjKGgTbqkkV68sy6i_sGrqWYdNkDhWvD6DA>
    <xmx:yknbahCmGeCGC18Qf6BlpeSBSX7i7RnOiV0uja29C8mSWT6pX10nuQ>
    <xmx:yknbapy0q-vGifNb0tU9WnlfoGCTMZ5gm7CekzWeOcLiAN12GH78Fo_f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 07:49:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c2f36ac1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 11:49:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 13:49:12 +0200
Subject: [PATCH v3 3/7] setup: allow overriding object storage format via
 environment
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-b4-pks-odb-extension-v3-3-b1bb30a006db@pks.im>
References: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
In-Reply-To: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The ref storage format configured via "extensions.refStorage" can be
overridden with the GIT_REF_STORAGE_FORMAT environment variable.
Introduce the GIT_OBJECT_STORAGE_FORMAT environment variable that
overrides "extensions.objectStorage" in the same way.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git.adoc |  5 +++++
 environment.h          |  1 +
 setup.c                | 16 ++++++++++++++++
 t/t0001-init.sh        | 26 ++++++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 3abb4701c3..34812131bb 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -609,6 +609,11 @@ double-quotes and respecting backslash escapes. E.g., the value
 `GIT_REFERENCE_BACKEND`::
 	Deprecated alias of `GIT_REF_STORAGE_FORMAT`.
 
+`GIT_OBJECT_STORAGE_FORMAT`::
+	Specify which object storage format to use along with its URI.
+	See `extensions.objectStorage` option in linkgit:git-config[1] for more
+	details. Overrides the config variable when used.
+
 Git Commits
 ~~~~~~~~~~~
 `GIT_AUTHOR_NAME`::
diff --git a/environment.h b/environment.h
index b336459e90..c26ef92b52 100644
--- a/environment.h
+++ b/environment.h
@@ -45,6 +45,7 @@
 #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
 #define GIT_REFERENCE_BACKEND_ENVIRONMENT "GIT_REFERENCE_BACKEND"
 #define GIT_REF_STORAGE_FORMAT_ENVIRONMENT "GIT_REF_STORAGE_FORMAT"
+#define GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT "GIT_OBJECT_STORAGE_FORMAT"
 
 /*
  * Environment variable used to propagate the --no-advice global option to the
diff --git a/setup.c b/setup.c
index 249bd67876..70aa90a9cb 100644
--- a/setup.c
+++ b/setup.c
@@ -2079,6 +2079,7 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
+			const char *object_storage_uri;
 			const char *ref_backend_uri;
 
 			/*
@@ -2097,6 +2098,21 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 					die(_("unknown ref storage format: '%s'"), ref_backend_uri);
 			}
 
+			/*
+			 * Likewise, the GIT_OBJECT_STORAGE_FORMAT environment
+			 * variable should override the repository config for
+			 * 'extensions.objectStorage'.
+			 */
+			object_storage_uri = getenv(GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT);
+			if (object_storage_uri) {
+				FREE_AND_NULL(discovery.format.object_storage_payload);
+				discovery.format.object_storage_format =
+					object_storage_format_by_uri(object_storage_uri,
+								     &discovery.format.object_storage_payload);
+				if (discovery.format.object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
+					die(_("unknown object storage format: '%s'"), object_storage_uri);
+			}
+
 			if (apply_repository_format(repo, &discovery.format,
 						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 				die("%s", err.buf);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index c7c464d3a2..5e7c25e42c 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -869,6 +869,32 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with unknown b
 	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage://payload${SQ}" err
 '
 
+test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FORMAT overrides extensions.objectStorage' '
+	test_when_finished "rm -rf objstorage" &&
+	git init objstorage &&
+	(
+		cd objstorage &&
+		git config set core.repositoryformatversion 1 &&
+		git config set extensions.objectStorage files://objs &&
+		mkdir .git/objs .git/other &&
+
+		echo content >file &&
+		oid=$(git hash-object -w file) &&
+		test_path_is_file .git/objs/$(test_oid_to_path "$oid") &&
+		git cat-file -e "$oid" &&
+
+		test_must_fail env GIT_OBJECT_STORAGE_FORMAT=files://other git cat-file -e "$oid" &&
+		GIT_OBJECT_STORAGE_FORMAT=files://other git hash-object -w file &&
+		test_path_is_file .git/other/$(test_oid_to_path "$oid") &&
+
+		cat >expect <<-EOF &&
+		fatal: unknown object storage format: ${SQ}garbage${SQ}
+		EOF
+		test_must_fail env GIT_OBJECT_STORAGE_FORMAT=garbage git rev-parse 2>err &&
+		test_cmp expect err
+	)
+'
+
 test_expect_success MINGW 'core.hidedotfiles = false' '
 	git config --global core.hidedotfiles false &&
 	rm -rf newdir &&

-- 
2.56.0.307.g5fe7bd680c.dirty

