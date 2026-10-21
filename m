Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561169;
	b=yIlvfL1I4PU1m5rghwkeO8BTgLeOYgQ2xX0T77on7/+4u3LZi3ko0XRvXHb5EeuI4Ns9
	 /r/dDqkfPR8IrkeBxezJKj+aAraaFLan+eNuJ8WibhXbUv6sHa01fVDaMWi7tpkRCx7r0
	 +Z8Fd86DdqA1QqeUnciSeF1wvJxTNhG+lp33pcF2nZAcD1j4EJlqngRhkLWjgFp3kfqS0
	 QqrMV+zUcdjKBLGQJDyAox4K+a7li05LsFI2kRZqD4litjy02k4XlilHnlGLhZMWBuLcO
	 uMJYsmdZslhifj3DCUSss8GCPESSKLRoA0232Omz7CpcG3zrKeFxbmDM8osNVTE6rJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561169;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Spj5oUm9yPwY72v7YMKL5iHPaksGDfe3NnCnqDWMsME=;
	b=XxU/FTOIDmwAWFFA+GNLk2rNZP076hJzPiYEugOfPwJCS6qot08Y4OZrsxuIKDceUWMp
	 PqJM9X/Wn9/Aza8G2oUfEuw06g/logt/5jAeagAgQajUrRqK+s3JwR0JVK2d3SgX/fg3P
	 wVCQYHxLcFRi2VWkDTW516T0w3UDoj+VSOkZKEE17+uA9AruKTn+FOMold6CumpHeP75/
	 xmrUxnBUSL5GDflc7E9mGUqZaPcdoCYWM4/YAKD+tYqlKsVfkXoCgrZfqrt+7UMT2KH3K
	 SSbkETAGGG753fxp7RAHbM0e+ibYVBtym9am3GknDnYI/JdPwh+pCNC/lXDQMBMr6Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=KCSfuvrL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=g6YSYWWr;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5A606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39E5A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=KCSfuvrL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=g6YSYWWr
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id BE9171D00036
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 01:39:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 21 Oct 2026 01:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792561168;
	 x=1792647568; bh=Spj5oUm9yPwY72v7YMKL5iHPaksGDfe3NnCnqDWMsME=; b=
	KCSfuvrLhxCpGCn7v1SLaIX3UAd1te9T2xaUmqw/QsKRc6Kd9ETq6rLqe8RBtWjN
	yRnbJ3gO88e2nMVPqj9I1D+1oxPMtl92wkx9ZRZxO3V18UIa2DNFp2MRtHrefakS
	WGtOsb3DP0mhAl7QStHCpPh4mXxD1nhR/5rx8bzgUap/d5ZS30iF+Gkvhj3f7LcC
	Y7VBQPLL6EDYJDhIEWtwIO4jqwJQDTt0NRHUs3rOhAdDj9kfDsMCTWM6IoOI54TU
	knxazBGC4k3RdipjZEq03KP2qA0154WCKbHeyqna7upav/it1MGeGh+JeM4rahDz
	pFIeeSUR2Q5NFQmrGoOSAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792561168; x=
	1792647568; bh=Spj5oUm9yPwY72v7YMKL5iHPaksGDfe3NnCnqDWMsME=; b=g
	6YSYWWr4pBcB18wg2dV7oerFOnwGhmCst3WstKl5zPWCXKHVFY8RyZrQ+ip8dktt
	h2/dD0CIC43n7jX0vAB2kNQ7NHLdEAFRUwpXhRBMVDAcJ2qkaIMNHAfyRmP7qkfI
	SqyunJotaAXv6+51A92NDpz2oHB+ryRPrTUkrLI1McFxddYyZ+nBRud0551hGvS3
	W0Lt4IVA9slOXTRoyZYDWGPzTBVlfjPK7jpiE7Sg9/p55iD3Fr971llzLyupsstK
	RSJPmRKB/uIN9AVyJ/F8uxpV4enX59Aqkl3opTIIn4EvhCBZmxRu0Www9MKGmlW3
	xilZqnlk7cty7kjYVnMJg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792561168; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jNOyHaFCTZ4l5M/mKvB2wl4w/WnMcZbAkn7+HDRQvxIcyZQ
	WVw2xvw7edR37LqwuF80cd+5wnBr9dmpTZwPXBQFmvgB/4s0FikjLpSUDqH/5Oic
	MaXp86y3AE4k6TAY50Au+EQ7pXC0U6aXT4/fYK5SDQZATPyMi6yubTlDc3gZaJnb
	njaY6OOT8pAG05b/ATADR7Ou2ikZSqqAbK7VZ6WP+mjoKRYPJZp5dxIwj5lVs7le
	O6OG1Vy1YKxm9ozLdOyUIK6quG7PfUcv2rNR+6pEqVd7Ua7tf5QITmq7R6OhS2ze
	wP/Q9Os1DOSpzNp3MT+lbCLw+1c/6O3UMDmx70Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tCExxxGEG16CKghC44xqgaCp+Bs8lz2++ARHJjd/NZM=:DXLSC2M5a/znTxQAp2lKr0krXNCWgPUNATy5GDnd6kc=;
X-ME-Sender: <xms:EFDYaquX78WsyHrxJ4JSUIyxVCvCShp7jZyPYZwaAsgO0cKNjmNoqQ>
    <xme:EFDYalfVfn1lMGTBLqKp2S3Vuow3pkmyEuTLxdSLCbSCEpJeb153mFupz_XBgQBIK
    Z6xHVpdBNBmcNPBCLuYHWI3e7HBNnhoEGJRGq3yxzioyFmJXIw-kwQ>
X-ME-Received: <xmr:EFDYajb2KbXsw6Cp_MsfJdQBUj1ZD8LzRVk6d0MJn5k8dWSY1g-mig>
X-ME-Proxy-Cause: dmFkZTFjdiHAftcLcxym7iyS6GGrr/hwgFjz6lyXgvbwNBTSpUGjBHjsxHa7aWLwD6r8/y
    i2fuv7S9i1ADuywbn12Qket1cjLDXkJ8huziohbALlYFFv5IeSPdo64QwnwB3rK4fKY8wr
    6vG2mCCE9emAm7rwWxvUG3vs+lrefardrkhp+6NcddLYfYabalVLmpcdWs+HVZZxn+9RGQ
    GoZCIDcFFBIkpfsCmvOapl7dvlB/aeoZBxOJxhKRitBNLvf253VGsHLOlhed8EgJLNxlKS
    L5ApeOskZ0InMS3wHs4ISt+Rs2ia27LW4DilV75gqOCUTkCtNCrOfSgpi23lq1zKjF5STX
    yJtKfyJ6ExnUtHB22i+4bJ4QeXoUltuYhbn/O8MbD3nLx+0zbR+dcWKZDH+39D+x3SfwkL
    c24RjTPAliSXlS7BJYkZ2nfHdFa0tkjfJHKHfjctGa2bz93aCXAEGaobmXGkZR1w+NR63e
    5uQgdkhUvxvwfMD2dNhXlyHodDwRGxbVPgW0ZGpiQDAWl0XyNkQwXLSHqgWcDgugHjWELT
    TSRw9umtL39umiRbF6sa8ScKSa+XN/PrIjpbrRgBb8bBtimGmj6R2upq1UYPo2noKn6TKm
    REj3sHeYNfhqLzqOf4YG2+4YYfl+qyNpSia/EkJk4XvS9OR/983UAKdAFgOg
X-ME-Proxy: <xmx:EFDYagWitMsoudd_-yGaMf6x1F0eQU7QIQ7HHOG6HdJZH1_om87UkA>
    <xmx:EFDYatj326HWO0S8EgXuZ8epTxLL_1v9eWQ51J0a_oCNi6nZKApfrQ>
    <xmx:EFDYamWCDPTe875_iGclDAA2lZP5V0p5axvKV-0rTQDyjyDneSiVVA>
    <xmx:EFDYasP1Ks3e2rLT9dMtJrvZMdyvUOOzJthUI1lyvGC1I2DARpWaYA>
    <xmx:EFDYalfV-l6z61OIrIRrNVE8LaVwZDMe_wc2EyS06Oa7h5y6i7Qtgu9n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 01:39:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe37d6ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 05:39:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Oct 2026 07:39:16 +0200
Subject: [PATCH v2 3/7] setup: allow overriding object storage format via
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
Message-Id: <20261021-b4-pks-odb-extension-v2-3-8cf11b65eda8@pks.im>
References: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
In-Reply-To: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
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
 setup.c                | 14 ++++++++++++++
 t/t0001-init.sh        | 26 ++++++++++++++++++++++++++
 4 files changed, 46 insertions(+)

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
index 499b5bbe3c..98140a7641 100644
--- a/setup.c
+++ b/setup.c
@@ -2073,6 +2073,7 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
+			const char *object_storage_uri;
 			const char *ref_backend_uri;
 
 			/*
@@ -2091,6 +2092,19 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 					die(_("unknown ref storage format: '%s'"), ref_backend_uri);
 			}
 
+			/*
+			 * Likewise, the GIT_OBJECT_STORAGE_FORMAT environment
+			 * variable should override the repository config for
+			 * 'extensions.objectStorage'.
+			 */
+			object_storage_uri = getenv(GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT);
+			if (object_storage_uri) {
+				if (odb_source_type_by_uri(object_storage_uri, NULL) == ODB_SOURCE_UNKNOWN)
+					die(_("unknown object storage format: '%s'"), object_storage_uri);
+				free(discovery.format.object_storage);
+				discovery.format.object_storage = xstrdup(object_storage_uri);
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

