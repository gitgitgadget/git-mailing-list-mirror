Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890930;
	b=vVmb5i0uLJdJ3iOAluk7lTMVnjhDRBuoT4wzL1KPwf99FISx7KOD8A7j1pYuMQsv70nE
	 wGaiiUdX9DiQK02M7OzsLTesT/cGYIGqzy574rl8X13gwx+jfbNCcly8CcUyu71vXw+uZ
	 p9yBIhcLDXenT8elamkNlvfPIIZUScsvavdgWxrCqg/y5DkBY+YNxlo3H4CXqMoGpvEON
	 sR5u6/kMBHZed9JeEDClUHLCwuZYnYhQa9W2hFl33Vqqf4zu/ECdYFH+Ec1TCQ4AlVOBq
	 GQ7eQ5ALvVmp3nGnSVcAPnHexN+ZI5d20MRpSNmf+jh++FOh6rNdA6LFhzw/kcrv49w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890930;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=M0l3OSRYVhGqjkjVLRZcNmC0gBVoIkzIJG+P45auecU=;
	b=zHcFvIU2V1nw6JDxzdCAVTQicjMOsnqu7UrENpKKZ6sMQUzWsZEE7KVtzGz9h94m3mbP
	 YtyffGVYrwg37fvUuuNIEWUYWQ5tDJn1mPQ5LdAtEJ/zbSHEXt/29jtmTTEMs+T2V9qH/
	 DbZARIeFamR2DcVvP7j1gRNhBV5OJHWud4PV2XMxtz7pHaq6JoPe5U/4fk0CLC4PWOjCU
	 binZxVTqML3fPKqAURlm18nGuvxXlMXB/dd5i0W1heilggbr+6I5tPQxJPc7NkdrGUueH
	 EhZFvA8+HFYWI83bOW+3pLYhdJ+kjmEkY8ZTyUSomDpdMYZMrtHkzvCU+XHAOZBJMZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Fa4veSzy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=c8SZAEV1;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E3C606A334
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1E3C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Fa4veSzy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=c8SZAEV1
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0DAE1EC019B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 10:02:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 05 Nov 2026 10:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793890929;
	 x=1793977329; bh=M0l3OSRYVhGqjkjVLRZcNmC0gBVoIkzIJG+P45auecU=; b=
	Fa4veSzyWrkQF7Tyl/FHwCOVUEFtffS2bT64RvYGGl0EtM3MnWm3SHKSGkGDz3Gc
	ZLTCR4rve8HS7dFQ+wxsF4aZjR2u+3lMbsGPMNgZg9Gb7hiCEQY70J2ogRCwBR7U
	YggnU9YK51mUxFUQX0EjJRvzNtCHF7E5GWQ5tW+sFJMr+znwiqW9iJYuw9ZSOeCK
	1uslEmKGJ0l211Sf0qvmJgxYVD9TWeFljNZ3mzWUMah2dPQNrYGkD+KihnlmBtDu
	Ey5OgejVH6oO+I7EJcomY0zCW2j6SzPjyFkQPn58l2j9YHM+MHFT9Rn+T2X7Rujf
	eCDKUKoCBpQZ8dSduBXZbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793890929; x=
	1793977329; bh=M0l3OSRYVhGqjkjVLRZcNmC0gBVoIkzIJG+P45auecU=; b=c
	8SZAEV11rsD7Ig1DrWd+gZ9zDXONVfBmrzmgmmTUldKgd0WrJaXMIGP+evjfNaal
	geeDPmyHrNMb/xqOyNT5i2x16dtlQZ7p3rIm1j7FEsJb/gXD+kSHLsK61QjQTOCW
	CQY/o4hzYcJ4Aex+VocrsZ6KE8ZM6Rf3NGoGmX+arc5iOoGNAqDilp9vuan/Lwfl
	EY/Ug0aLFZIUF0QDaoDq8BeqQgcDVQ+njVObuRmUsaNBoLIAB9MoC8yUaTStgfkF
	TPnr8QAKsj/kO8jZkzvU6DpNfwT4BL01U+XfFyIorl9pCXPcJ7gqRmsA8MMLMCf9
	ao+yCJyX5a55bxcmNKiDg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793890929; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:hJhyG+DES5LF++xvIh5tHy7du75me2u2FmTKv5Z2tp9ziUz
	l3jsD9DNnqWMdhpeSWxli3Jdn3fSPmrjEQNjUNRYVKr2307el+RvIPdcvCtLKI25
	4uuwE2l1FM0/LyG+moVli7EDfj117/kbgmAnB6673yc5aNvamaun54Erqqe9U+Sg
	L8Ta49cBfriWTpSb8KODYCx5tPvYzgtZZySDWwGGtUBgIs9Izl65HOmcEMONbg/i
	+hgYk2uMwVK9qmFzyM49D7JBN4APD5xQqAOfjPd9+RKZojE+QHOnQMUsO/Pec7OU
	XV+6mrFAtn9J7nLPWRDWz5VoPfj7FrueCVkDhdA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iIZL2ZXlePnM+HDyx723mCEP4ORD9NJ0q6kfmwq8g5A=:zx59PrGSZXKLvCiB2A0sEVRFYlD9x4XK2Oe9pFmJnyA=;
X-ME-Sender: <xms:cZrsak9oZoglY6-xMUoXcpQQNLUpQz8mAkx5FtRDKpZ31zpjjRk-Cg>
    <xme:cZrsajp4xWbWFhu97eXbmSksU5_A1l7pW9aYywpU027-t1FzZz16Tj_rh_iD0WuEL
    cHDSaPsslwtrkT4gIAeOUXmHHdSbd2GBqoNMh8s2NTo9MMPvTqC1aE>
X-ME-Received: <xmr:cZrsavq3ssk_MKqOKRJkoU8mXVAUD9jWyYBcq-YKoER1tfih98F61g>
X-ME-Proxy-Cause: dmFkZTGqtABMV/Ng5DPpJnKcqa/f6eamioVcKyE6/bDZ5WBL3jEqqBxrtFxVMCtiLJAgJY
    mBLrBuN2AF2kwsfF0Qes9TVosqOyScdmOuCblWuAw42/c5XS8xOFxs34vvPTvyZ44mOf02
    a9XyoJsfBm2gsCrkzTIX4eTJQpYiHwEs8z2RmoA4aAcOW5fgoZLqp6cBheKxcJQht4FqxK
    wvOec/TsgLHDkrqXlPa6AZSM/YfhwXRwdeAHlIdggR0o4ciOiW4HcZLBWP93BkQuUwZFKS
    2onmbQDox5lGtDDWmVDbnN32lykStH9d8vqcpCi/poZ2EuQ251IJ1ZZ2QOkgoISKIvIQY3
    neL6XDJueay/xrFGD1qxmNFcgAtRf5/ykWVIK1tTXgBI0atj4udrvex3DUDFHdNgysTrBX
    jteYfDFf6dNzC7FKMQZzKuM95E/R+XjFwU0Dw7zgjSMK9aqWfQgshZQE6R1IiTsAgzBfmy
    seVm+2wemjthBvF3+fPPgEYvVd5WJMigJI5M6Ln78jIu+ddYGyo1Cd5pqSN5UahuVBjZhq
    ZigKP2gfn0R6Tni2+CPPuh+h3vSMjY5ky6AUnqRE2+onoLl96FwVXGAN1cxZCZU+qKA6KM
    rdsc3VPCZsSw4yfgAvSCkj59jgHhXTCB/Xgz7uBHM5OCInlzDmS+zW/baF7Q
X-ME-Proxy: <xmx:cZrsaplyUEEJQb9P8KP-SmOzVLreXbzsX5ph-tb-q9utq3vABF98uQ>
    <xmx:cZrsapE2ZwpS4YpWg-JYFzufNaUlpt0ZdVKCJxZ2Lbsrnzh4jFKBzg>
    <xmx:cZrsaqpuT_bDW9K5lIVuYUaYWBC5VYbI3uXQTgDA0bnfDQ4efUHRfQ>
    <xmx:cZrsat7j9bxfIOGt7sbcjRZ3VcsciTSWCQgJwZLt3zku829GAlb4kg>
    <xmx:cZrsakuamuWlU72jaLU5Q31Pg0WXSniEQx3HmK8I1NzOryyrIhAIdWUu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 5 Nov 2026 10:02:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f1f8871 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 5 Nov 2026 15:02:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Nov 2026 16:02:02 +0100
Subject: [PATCH 1/5] refs: create leading directories
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
Message-Id: <20261105-pks-storage-format-improvements-v1-1-870bb4212518@pks.im>
References: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
In-Reply-To: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Both the "files" and "reftable" backends accept a payload that allows
the user to use a non-default location for their files. So e.g. if the
user specifies "files://refdir" as the ref storage format, then we would
put files into ".git/refdir/refs" instead of ".git/refs".

Using this is somewhat unwieldy though, as the directory must exist
before we create the ref storage as we'd otherwise die. This isn't that
bad in the case where the user specifies an absolute path that is
outside of the repository. But it becomes quite weird when asked to
create the directory relative to commondir, as the user would first have
to "mkdir -p repo/.git/refdir".

Adapt the reference backends to create leading directories. Note that we
use the `noshare()` variant for this because it's very much possible
that it will exist outside of the repository, and if so we shouldn't
adapt permissions on such leading directories.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c    |  1 +
 refs/reftable-backend.c |  1 +
 t/t1423-ref-backend.sh  | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 87d04557a53..1bdb16c0e7b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3699,6 +3699,7 @@ static int files_ref_store_create_on_disk(struct ref_store *ref_store,
 	 *   they do not understand the reference format extension.
 	 */
 	strbuf_addf(&sb, "%s/refs", ref_store->gitdir);
+	safe_create_leading_directories_no_share(sb.buf);
 	safe_create_dir(refs->base.repo, sb.buf, 1);
 	adjust_shared_perm(refs->base.repo, sb.buf);
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d0de0663552..3ba6a9ac0db 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -504,6 +504,7 @@ static int reftable_be_create_on_disk(struct ref_store *ref_store,
 	struct strbuf sb = STRBUF_INIT;
 
 	strbuf_addf(&sb, "%s/reftable", refs->base.gitdir);
+	safe_create_leading_directories_no_share(sb.buf);
 	safe_create_dir(ref_store->repo, sb.buf, 1);
 	strbuf_reset(&sb);
 
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
index ee2bb66b99c..85d1e876b82 100755
--- a/t/t1423-ref-backend.sh
+++ b/t/t1423-ref-backend.sh
@@ -284,6 +284,30 @@ test_expect_success 'initializing repository with --ref-storage-format and paylo
 	test_cmp expect actual
 '
 
+for format in files reftable
+do
+	test_expect_success "default ref storage format with $format backend and payload" '
+		test_when_finished "rm -rf repo refdir" &&
+		BACKEND="$format://$(pwd)/refdir" &&
+		echo "$BACKEND" >expect &&
+		git init --ref-storage-format="$BACKEND" repo &&
+		test_path_is_dir refdir &&
+		case "$format" in
+		files)
+			test_path_is_file refdir/HEAD &&
+			test_path_is_dir refdir/refs
+			;;
+		reftable)
+			test_path_is_dir refdir/reftable &&
+			test_path_is_file refdir/reftable/tables.list
+			;;
+		*)
+			BUG "unknown ref storage format: $format"
+			;;
+		esac
+	'
+done
+
 test_expect_success 'cloning repository with alt ref directory' '
 	test_when_finished "rm -rf source repo refdir" &&
 	mkdir refdir &&

-- 
2.56.0.500.g5d06dc02cd.dirty

