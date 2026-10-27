Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084385;
	b=QNLSJAOEv0XuRbhTePWD8yOaRMzK+hW1jmzTIVkTvf4D1kzXoIPh3+TF+SySlRO/cuQ5
	 TJp3uQe+KjUvWBR4JKi9OHcek49cuWtPGlDNNFaSiP38UGEWda69v4iBob79v8/CMnZjN
	 hhjGvgqPba09gp3Zvs83uk1GSmXW7kt5eadW9wjGTlvA6KY5hxIv6jP+I+Hk71ZA6ypD2
	 sBCnIQLgXOiLDOoEJFiXW8+ZRDFVSDxCuC+fZzW8laku+xMqQ74dje0oKMrbTHGkK2vbH
	 H4nY9aAqfwhxo29CQb9EXySuYAEGCVTOe0V8ZHAlD4zkxRd9uXpKeUt+xaoaLEKfRng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084385;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=OzFuvfX09t5leQOEYtLIBstB+2lAF+umOHC5hkDxGVo=;
	b=wXdJohQCqEiw/nf5mCv8sOT92ZYR4Ep+OJMFm0+Lt2uuVyVxaEgSf/y2I7Hu9g7LxcOV
	 SCELOMV1mxV9Pt6tbhjjeIXH0ccX+/iUPWDvcR8G2ahHJdV/iq8R/fiMyhP4UB3h3VSL1
	 vek3dge9QdTspZgCDh3g8EHMm2lV8y+525DWTbzCpwxrk8SjkSvjexZE3x8u14fSdbcER
	 fQibZl5Ub04xMrWinNzq3kTu+Vi1FQY4wrhGKgsAlJtfM6MAgVA+ZzDoALWcNIDwqs69u
	 HcWZX93He/YcA4M5TLu/oC/YvPleVurfx5Xr+Ng50q847m14NtjsCb7r1kz2ZYKcmCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=c2tpqpj1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QncyKXly;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C3606A326
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 996C3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=c2tpqpj1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QncyKXly
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 015B01D00114
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 02:59:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 27 Oct 2026 02:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793084383;
	 x=1793170783; bh=OzFuvfX09t5leQOEYtLIBstB+2lAF+umOHC5hkDxGVo=; b=
	c2tpqpj1Tp0aeLLy4H/yGvYK+8KxuYfKxyrr1GrHILiMmrzzAqHdpmvjSBAFg1dk
	60EpQhJaPVKscvcxGdONUowfLSKBF1oJ3U5gUdR++Vmgw1eZMKJ5sKh3f9pd1mBe
	2AXWqpITKAEOhNzzakeqYKeNSYPKlUXQ2PqlD0t/i2oX2MhgsSgEHIFxPxMVZriz
	a/WWMQbh/CuhL0e+Ksq7rawTkfCNKBaoP1H2NVmcG7iDczUAvfimdvDCMF1uWr/O
	lAmmuMxOa07TPqkHIMeSWYdPBt5VfJKCz8sKVeMJIeJQ7wACMrm1PQhoANU2kBAz
	Ea5LHoPKdsijJhSUSK9ptg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793084383; x=
	1793170783; bh=OzFuvfX09t5leQOEYtLIBstB+2lAF+umOHC5hkDxGVo=; b=Q
	ncyKXly6nibc+4LhKBPXZjSIVPQTOuA61u3g5OFamoacHL5l+CP9IdciXlqkNvYh
	4RyH+Nm6I/8o5tFziVooWD8aRbfLqnIAYHU5+ktOFEka2NKKIRa+l+7qtWqQY9OB
	aPQ6djDzrq2mQqDCvuZnjun3Hn9RUbi9T9FREHgUIK32Sq+ADUrl+20dOQopXXDK
	9DIOGlSo2OAW120CUF5+GcfIq/XAV+EFm+nIvSeIXaZ1vJBH8k8+Hk/ADmeB0fGs
	F1qLN6smba/HmERu2Rb6dTB933wvPZoW5CUX3YHci0eFMZadKuEWeU1RyTVjGZjA
	KKSx+PdeLXec+0R6JDbxg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793084383; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VBjSuKQ1fOc4prfFlppGbOK92ZuD2OGYltJh9SgK5WjFeRp
	f/HCk45+0z6vaZH/Hrlo8zFV4L2cPhO1nIoVaF1W1yWLAzzX+AYgZN/Sx1r7fd75
	FHhmlwr7jf0bwb4EC/RSKiqyD2LuOT0KVXdhmTNDxBlLEmneUqb8Bn1mJ2Uo7+do
	FLwauxTorTyT6bE34Uy6XKIhOrR7fuvx8vOmfYkx9em+HZcu5czqH6I65mFmJL7I
	bGv+M5Z2iUOcrMa52hIIFVYq1b3yJplDQbJPWehiJRQrOSsVYwEOQdaRJXoDzgFN
	OKvZBhq7h8lsiADJNaLbKRd0XbDysmik+Bz6JFg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iZzCeAOsFmkyAzWiXaNj5jV65rd6vUynv5IOeSSFbb0=:7fhotmXLJEYW8Jk9XH2zZ5fK10D3UgMpv11DVobalW8=;
X-ME-Sender: <xms:30vgak9a1jdU8HiN41-C7SnhtK9eQyqc2ZvtkcYW6NekMuXyB-dU9w>
    <xme:30vgakJlDdDE_6hSsbyn8cp8c_AYXGWNfIkVPdTuAPA7yWGUpVhgtqREVdumAXHz4
    dr5HmXCxn0Rlq2A885UEQjUBkebFQ3bFtLfYIoWbvl0WpcNOUinq-wz>
X-ME-Received: <xmr:30vganZxA2gIbN1xrvyh31EgbnGuvYhI8Otj8F4JoTbiMMC95Q90TA>
X-ME-Proxy-Cause: dmFkZTFdAx1Kb/Rt5xZ5JGvxKgxHT+05wvq5MYh/dlyjwhPl/J5goSmirBj+lxUlhK5dmz
    N3Fp5zomvm5ydlBgqs8+RmQ7bJWR17EABYD5P0VTOWWecHt/AsCVdMtMSVtAOFDd0GnHsR
    5U2cYLzwDEVBbfMj2xC5zK7WuoQ8CMOlvqRZyD+ZwnahQvbfQaWaUXnhJwsBuOTG4HM2/w
    rwF1jsZzo5/5bjsc//rEiiQCHjRjFA76GREzIAhlar+B4rbTTSAOxNTqwFceBwgg4w2Xp4
    TFr0+6ggbUkDOQzl7nAhA/vP7b52VLFPGTj2sXTyoo4sITc8QH+xu9KpiD8q+tW+/bWEOB
    nIxKGDbwdEGPAstQryod502a2n655s6K3w0OD6IngGY0hX011x3pB4CFVxdT3mmWVmAyYi
    NAx5J8XOzCg/010zyH6/7OYC7cg/Rp5tBd7Yg02fJ2tA0WXVkVXPqONHmzSNQvaOYV8UXW
    onq3E4lqzwRuRgrCaVp41Hl3PF9Sw0PrwGwpPgJPLNeXWHKGmVrMG92cdOVdvH9v9kKhkC
    DnpByWmtK/iUWSLnH8ABPl2yUlW0+HyPpfhhI/jGGo8NMa8fq4gtiaIonYe9udfIe/4qGA
    DhBOh07x2/qG6wCUaAVkkDjL+i8GTMkb/1/J3cr9WttFJ3c/CpxTG6MvsqLg
X-ME-Proxy: <xmx:30vgauLW-TaAPL2pO-kW7fywDaJG6gOMEgO4PWhkboM7mUd-Fo260w>
    <xmx:30vgatAFKV4wai-CRPmavJrfY5hhsSGFbMrcZ05Bikm1-p8535DoIg>
    <xmx:30vgarraAbl3W4t9ESXI7L73Cbs6vSyXLP82-6h8IQafOPmxqbrFcg>
    <xmx:30vgaghHmM0sw79uX1G69lKGOUCPKWy00Cfjh1CiJRLLDKANYhmA5Q>
    <xmx:30vgaqlB0h1H5FQ-MfT25EhMStIhyNWX0NYHjICLpeDQACgmQEU8prW2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 02:59:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed947fcd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 06:59:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 07:59:27 +0100
Subject: [PATCH v4 3/7] setup: allow overriding object storage format via
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
Message-Id: <20261027-b4-pks-odb-extension-v4-3-5d28ca0ea1dc@pks.im>
References: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
In-Reply-To: <20261027-b4-pks-odb-extension-v4-0-5d28ca0ea1dc@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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
index 3abb4701c30..34812131bb0 100644
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
index b336459e901..c26ef92b529 100644
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
index 99ead7d90c1..5580aaa10e1 100644
--- a/setup.c
+++ b/setup.c
@@ -2078,6 +2078,7 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
+			const char *object_storage_uri;
 			const char *ref_backend_uri;
 
 			/*
@@ -2096,6 +2097,21 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 					die(_("unknown ref storage format: '%s'"), ref_backend_uri);
 			}
 
+			/*
+			 * The GIT_OBJECT_STORAGE_FORMAT env variable
+			 * should override the repository config for
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
index c7c464d3a26..5e7c25e42cc 100755
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
2.56.0.341.g393f52fd96.dirty

