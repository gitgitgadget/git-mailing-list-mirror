Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890935;
	b=KkvrNOI8h3v84+jjWaWZogK+OF8/EUN3ovrJIJRZCVgwwRheUP/lzzpW4WtnX3x3sxKp
	 J/Y0kMwWrwBMgyV2GzaHVNeaEteJRr5PPsvTfBzTBgl6wcQ484d0ed1daP9LwW1CD+iSf
	 siv5G7rSNX3v+GCc1Fcc0HcExrqrbnYi/8XNPP00gpFN/Pk9C+9xg6EpVwU8mxx7UotH9
	 gG4v4bNkOPhyiOHil7efUsRlsfN3XyRkisRX4tBamUGDH72UZ9ma0kqcLhfnAWziGb2wZ
	 tVBLjZeTrjxRtCDVPWQdc4PKoiY4WUOliFtYIpPoJEWl3+A8hPBDkTHXWwF0hGxWGfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890935;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=yidmGmOQKH5NUc8ZNl41Ma3NIC9lzq/3PzYHWgu2jrs=;
	b=nCC/hoAV5+lqzp4kl3vKqRU369YmKFl1lfXXJzrujQTBslMaq7zNtsQUSyw3KLABe7As
	 ZDkxpOjFCQe5zizkRb1jnHjg1Fll1DoyQn5c9wN0z1v0/N2KfQhXxG0xk1RCh/Mj77NML
	 Sm+Hrz+frNofIMRy5p7sBay+2cTfP8kBSmZk8ecq9tbglcZNKe1bU9L4aybNKz6yVP0QW
	 CUa6EkTtqkze+/3AiyGua5qJG3w5o9Y+gUppNYJazX9IyXMUrNnIvUJDhjKLAoSe/WLyA
	 kdLUbUZMoMnI5p2AuNEfqIXLb9jj+FYXxUMf/cf3QhSWqu5Jzy7mIb5euxnRBLxcerQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Lq5dSwDs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SBS5u4nO;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC7D606A333
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FC7D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Lq5dSwDs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SBS5u4nO
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9700D140005C
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 10:02:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 05 Nov 2026 10:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793890934;
	 x=1793977334; bh=yidmGmOQKH5NUc8ZNl41Ma3NIC9lzq/3PzYHWgu2jrs=; b=
	Lq5dSwDsykXnO8EhcIsgzr8TWmZjfa9SzGoze9hXcwqLeIb1t8BYlZcXtSd0pFsl
	VjhZod33OZv1DjhR3bvJHNpDKTeWPhbddRkKS3NwhGzhcVfrlvvzPWEIdkwJF045
	FOlPCBEc8yfpYoTSZOCDjG469TO7pLdVdkXRPmB/wQ0HqTFeOFnQKhV4DnJEJE56
	AYy+gA3RFiH3Siyzyp8vlLZhKbmu/rHvn1cymWQnkBeENdaeA8sj1TdJKhWIWenl
	o8Ph4FwMJVhP6qsJGs7CEOitG6BkM4z/1yc0CK7WBfqRwxJVHr6bqsIZGp401kma
	nQFuV98L0EwY0UduNaUQwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793890934; x=
	1793977334; bh=yidmGmOQKH5NUc8ZNl41Ma3NIC9lzq/3PzYHWgu2jrs=; b=S
	BS5u4nOSHho5tOlCuNs+Og+RTlQdAtUOUO5CWfS5UzvxXWrsp9wDNw9PYtDplgio
	YL3KIWow0UpGvmVAeAQiNS2PbRSsR2UmtwHYlcaTUQ/N25U0+k4EQadicMjRiKU5
	Hk3mOXt1B7x3zUmP1AZSfO+VLsFBOn5Oc/TEyDhk1gqzzFSfXl85ofbdRKaAOf5g
	zPie9tuhb3hMfXdagt3DiqnfHvzHhtxJVn37MILkdl/8/FSXKUGYmh/wuF0b0x0u
	mp0ekO2LzoS7IXG0UYyoHeP4S9Q0ltltfvrZlz28XwkTKKpoNjxpld2UiKtwHbXa
	lEKdCmzvwviZ7aMl+1jLw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793890934; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:n8bKmjbK0Ql+NXlFEXFj0zekSA1IFiahHDhzk88P4ZTgFzw
	AkJZDRsqPdL8lexPU8dPPVlLPD4wY3WgPcQ/OvUdTjKCx1GWybAgsT/23UJK2bKn
	ZMxe69sAiyMLK31O3zoH2RMh803WnjcQFBjGK9FU4Vqk+VTViNQIOOnmi6BJhRzQ
	RCWXfN98i1YIvVj46D1hgAo9Gr8vhq2Ui1iEKZoy19ux9xGl4tgy8rsNkjhPWnnt
	H4pD+1MP56/CpWc59GUtYLXkv3Q+8p4PByMPLm1h12BI4xTLeSQZfv9LjuAyyd9y
	cL6+822DAKSx7GOM8nBYcps4HmSPWp7x3m3dEsA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:EfjJcHCqwKo75U2scoR2PJs8AEKjoFnBS9/8jNrNwzc=:C3a3EBJI7hxmxzF2HFqCFT+8HuLUQlDPbaQSbkhBIag=;
X-ME-Sender: <xms:dprsakuW_a_jNHDEZQUtbKS--xHip2EuK9SQCSvbhQftO6wlJRNphw>
    <xme:dprsaoZ0xAHOx_RzgPqvPnUI2JfUyKp9fV5qR74qtlAV_zWKXfvvV485nL9rzNSCU
    R90U6ikuo8Yi7DOrtj97UuGWnp9PDrmWhWaYExPb8_Px6Wl0PU6U2g>
X-ME-Received: <xmr:dprsalZsAF3dSRkglDqBPwh2M8-cwwf1IxldMoTq4ZRj2QXMtvGfNw>
X-ME-Proxy-Cause: dmFkZTFHI4XweoskwCEEW1D3N4CSgnoK5bztaio834MUp9205cx6MyejNziaVJ/rhu/Wbx
    w7cXzCWZ9a9Vbjs5YwxvG8zhtI59wulQnrgfIAM5tQzsQsNpQOSxdNhp/F6qbGELt7QADu
    wWw82/4M4tcIAAYreCBPeo4JsRhx1jFXIcfcnD8eDekTg29fT9Goo0FKL/V0x/88dDKYS4
    idFZaca7DNW30j4QpNUQRXO/1cUHFhcpPyiXWtKb7M0vZoT34aE6PYSvtYZ5DYs6BdQhvK
    gqWmVzuSVrRPvDiyRhDWZWEcVZM8Jzh33RA6GlTwCE6j+L/dA+ZqLjlSxjBtE2IsuMGYRy
    o4NjUOpDfoCimODi7PvuyIgJf8FcOlvJhV/lIYwNLaVM+/lcmxPm0ikS36MN4GUYhY+EtQ
    OAPXIwi98H6NIzLru6n2LiBMaxYWp9OLuvS1a4VIymlQEzlmy+1sThB2FOdHC0abA89kCS
    Q8iFU03UoZ+qb2T/Vi14EUB80JplgYlDwnhMP/AwQoaVm1nPxSg3R+RIMDPPtSAiMa1vaB
    y8xXkcjPKB7C1awHqdUccVcKjo5bLQ7QPNLZhU7iIsukvAjuzWN1AOCWLYFmist+kjlGVy
    a152emVtyP3IB1A5hwgy/Zx5ZfXVIPOQS0TjXu3rYHy8yuAkOPcTROhtXVQA
X-ME-Proxy: <xmx:dprsasXlQNa3ykau0Ba38BBz4mxH9gQ01NP-rXDqLvotijW956e86A>
    <xmx:dprsak3I0dCvM-C2Pn6oMcUzEJpHNtrUNqWjr-giRmy79TZ785pQfg>
    <xmx:dprsarZj7pEIRzYIofNJX5N2H1V6pIQWLe_qtPhRrvH2wWztkLM94g>
    <xmx:dprsavoB3R63QSdzUH7f66ClNhsdm9-Z0oTrMYmMazPpfE6SZsn56g>
    <xmx:dprsancwfkeDknQBA1ek5uhEII28pcgu4L2Ps4v51fghwNKIh4UCmmE0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 5 Nov 2026 10:02:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e519f61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 5 Nov 2026 15:02:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Nov 2026 16:02:04 +0100
Subject: [PATCH 3/5] setup: allow speciyfing payloads with default storage
 formats
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
Message-Id: <20261105-pks-storage-format-improvements-v1-3-870bb4212518@pks.im>
References: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
In-Reply-To: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

While the "git init --ref-storage-format=" switch allows the user to
specify a payload that gets passed to the backend, this isn't possible
when specifying a default via "init.defaultRefStorageFormat" or via
`GIT_DEFAULT_REF_STORAGE_FORMAT`. The same restriction also applies to
the object storage format, which needlessly restricts the flexibility
and usefulness of these mechanism.

Extend the logic to allow specifying a payload.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c         | 24 +++++++++++++++++++-----
 t/t0001-init.sh | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/setup.c b/setup.c
index 186815c7801..cedc031c54f 100644
--- a/setup.c
+++ b/setup.c
@@ -2797,7 +2797,9 @@ static void separate_git_dir(struct repository *repo,
 struct default_format_config {
 	int hash;
 	enum ref_storage_format ref_storage_format;
+	char *ref_storage_payload;
 	enum object_storage_format object_storage_format;
+	char *object_storage_payload;
 };
 
 static int read_default_format_config(const char *key, const char *value,
@@ -2823,9 +2825,12 @@ static int read_default_format_config(const char *key, const char *value,
 		ret = git_config_string(&str, key, value);
 		if (ret)
 			goto out;
-		cfg->ref_storage_format = ref_storage_format_by_name(str);
+
+		FREE_AND_NULL(cfg->ref_storage_payload);
+		cfg->ref_storage_format = ref_storage_format_by_uri(str, &cfg->ref_storage_payload);
 		if (cfg->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			warning(_("unknown ref storage format '%s'"), str);
+
 		goto out;
 	}
 
@@ -2833,9 +2838,12 @@ static int read_default_format_config(const char *key, const char *value,
 		ret = git_config_string(&str, key, value);
 		if (ret)
 			goto out;
-		cfg->object_storage_format = object_storage_format_by_name(str);
+
+		FREE_AND_NULL(cfg->object_storage_payload);
+		cfg->object_storage_format = object_storage_format_by_uri(str, &cfg->object_storage_payload);
 		if (cfg->object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
 			warning(_("unknown object storage format '%s'"), str);
+
 		goto out;
 	}
 
@@ -2947,17 +2955,19 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		ref_storage_format = repo_fmt->ref_storage_format;
 		ref_storage_payload = xstrdup_or_null(repo_fmt->ref_storage_payload);
 	} else if ((env = getenv("GIT_DEFAULT_REF_STORAGE_FORMAT"))) {
-		ref_storage_format = ref_storage_format_by_name(env);
+		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format specified via %s: '%s'"),
 			    "GIT_DEFAULT_REF_STORAGE_FORMAT", env);
 	} else if ((env = getenv("GIT_DEFAULT_REF_FORMAT"))) {
-		ref_storage_format = ref_storage_format_by_name(env);
+		ref_storage_format = ref_storage_format_by_uri(env, &ref_storage_payload);
 		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format specified via %s: '%s'"),
 			    "GIT_DEFAULT_REF_FORMAT", env);
 	} else if (cfg.ref_storage_format != REF_STORAGE_FORMAT_UNKNOWN) {
 		ref_storage_format = cfg.ref_storage_format;
+		ref_storage_payload = cfg.ref_storage_payload;
+		cfg.ref_storage_payload = NULL;
 	} else {
 		ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
 	}
@@ -2995,12 +3005,14 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		object_storage_format = repo_fmt->object_storage_format;
 		object_storage_payload = xstrdup_or_null(repo_fmt->object_storage_payload);
 	} else if ((env = getenv("GIT_DEFAULT_OBJECT_STORAGE_FORMAT"))) {
-		object_storage_format = object_storage_format_by_name(env);
+		object_storage_format = object_storage_format_by_uri(env, &object_storage_payload);
 		if (object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown object storage format specified via %s: '%s'"),
 			    "GIT_DEFAULT_OBJECT_STORAGE_FORMAT", env);
 	} else if (cfg.object_storage_format != OBJECT_STORAGE_FORMAT_UNKNOWN) {
 		object_storage_format = cfg.object_storage_format;
+		object_storage_payload = cfg.object_storage_payload;
+		cfg.object_storage_payload = NULL;
 	} else {
 		object_storage_format = OBJECT_STORAGE_FORMAT_FILES;
 	}
@@ -3024,10 +3036,12 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 			die(_("attempt to reinitialize repository with different object storage payload"));
 	}
 
+	free(cfg.ref_storage_payload);
 	free(repo_fmt->ref_storage_payload);
 	repo_fmt->ref_storage_format = ref_storage_format;
 	repo_fmt->ref_storage_payload = ref_storage_payload;
 
+	free(cfg.object_storage_payload);
 	free(repo_fmt->object_storage_payload);
 	repo_fmt->object_storage_format = object_storage_format;
 	repo_fmt->object_storage_payload = object_storage_payload;
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 735ab9d8475..09b7258bf10 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -745,6 +745,33 @@ do
 	'
 done
 
+test_expect_success 'initializing repository with init.defaultRefStorageFormat and payload' '
+	test_when_finished "rm -rf repo refdir" &&
+
+	BACKEND="files://$(pwd)/refdir" &&
+	test_config_global init.defaultRefStorageFormat "$BACKEND" &&
+	(
+		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
+		git init repo
+	) &&
+	test_path_is_file refdir/HEAD &&
+	test_path_is_dir refdir/refs &&
+	git -C repo config get extensions.refstorage >actual &&
+	echo "$BACKEND" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'initializing repository with GIT_DEFAULT_REF_STORAGE_FORMAT and payload' '
+	test_when_finished "rm -rf repo refdir" &&
+	BACKEND="files://$(pwd)/refdir" &&
+	GIT_DEFAULT_REF_STORAGE_FORMAT="$BACKEND" git init repo &&
+	test_path_is_file refdir/HEAD &&
+	test_path_is_dir refdir/refs &&
+	git -C repo config get extensions.refstorage >actual &&
+	echo "$BACKEND" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success "--ref-storage-format= overrides GIT_DEFAULT_REF_STORAGE_FOMAT" '
 	test_when_finished "rm -rf refformat" &&
 	GIT_DEFAULT_REF_STORAGE_FORMAT=files git init --ref-storage-format=reftable refformat &&
@@ -1064,6 +1091,30 @@ test_expect_success 'init with init.defaultObjectStorageFormat' '
 	test_cmp expect actual
 '
 
+test_expect_success 'init with init.defaultObjectStorageFormat and payload' '
+	test_when_finished "rm -rf repo objdir" &&
+	BACKEND="files://$(pwd)/objdir" &&
+	test_config_global init.defaultObjectStorageFormat "$BACKEND" &&
+	(
+		sane_unset GIT_DEFAULT_OBJECT_STORAGE_FORMAT &&
+		git init repo
+	) &&
+	test_path_is_dir objdir/pack &&
+	git -C repo config get extensions.objectstorage >actual &&
+	echo "$BACKEND" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'init with GIT_DEFAULT_OBJECT_STORAGE_FORMAT and payload' '
+	test_when_finished "rm -rf repo objdir" &&
+	BACKEND="files://$(pwd)/objdir" &&
+	GIT_DEFAULT_OBJECT_STORAGE_FORMAT="$BACKEND" git init repo &&
+	test_path_is_dir objdir/pack &&
+	git -C repo config get extensions.objectstorage >actual &&
+	echo "$BACKEND" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success MINGW 'core.hidedotfiles = false' '
 	git config --global core.hidedotfiles false &&
 	rm -rf newdir &&

-- 
2.56.0.500.g5d06dc02cd.dirty

