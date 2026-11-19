Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795097931;
	b=p2A55409NGrX85FvGmcK4sLCvCGRLWUv/qSD4vfWqUv2kaZot7AlGPagIdr0xp/TSKqW
	 wB8QVbX0pVrbbjH6jkYVHazsz6tELfFxvjwavwdnl9v985sLgEi3C14QrIVfTEOyP1P/N
	 GtBC1bIQyeYWgdNBKeTz8FAQvIBl3N3nuuLzB1SS9eTjvrSkumIvV2oJDkiDdoWoZh1Z/
	 IocPtuP++zfQ6zDY/fE2zKBi8GD1DkEbwMNg+SRIoxhTkV6EI65UQUtLh8b73eivnL22n
	 sFkqmDmwJ5ST9agZVcKlMN41f4QZ04nmJD+rO3+izS9xSwsUDGa52bjtk/5+gg7qvhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097931;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MEq408TRS3qHhcE9J4TreiAvTkOcDjE6FKyZ8F2Nu7I=;
	b=vXpgtsU452aet7C/yyW5jjAJgVbsLnSKZ0cu44wQW4y8oWW50vZwNcfVDapV5RPLXbfU
	 zj6+PQ5ulQW42HBEJcdRvxP+BOvH6BPf9sIRdZBSJJo/ZG3H3DWlXdhnHCJWfBti9+DHp
	 wwLjHgw7/QeKzP5PacKln/HsTmfedPHir5EmODLTwLHXjSvX6/ATgECdcZrdJez05k5Jf
	 qX0rfDIRv2QAqr/DexptsdNkTXHn6zroEFr8//8nOtuZDNh0la+um4y3iW8WxFIA3PMpd
	 VIhnkuKZwZrlogeWw1bEMzF+OUNh9R2Hqyr7h3+ZWavD2hTLOhhKheoMz5vZ9DtVN/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Geyx4S9r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.109
Received: from sender5-pp-e109.zoho.com (sender5-pp-e109.zoho.com [165.173.182.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29B7606A324
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 14:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B29B7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Geyx4S9r
ARC-Seal: i=1; a=rsa-sha256; t=1795097917; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mmfmoVecsWTSLWeUPI5kRBtJ6CamHV/ShIx7NSJZWDq/ZdfEVA6E2uSRCTkkad1TcC8fCM5hwE6cgoLwqzPcL7TI0gST4oHTwhkOMMES4NFGC6I5yJR0UAlH+Xduo6lpzaHIvzvl30SUnNgP0yuu8WcZUe3qfzk7CfD3DeMCRkI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795097917; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MEq408TRS3qHhcE9J4TreiAvTkOcDjE6FKyZ8F2Nu7I=; 
	b=kG16+mJT41EEdsDQ4WGziFU5rjzVG+JMScrkC7Nf9Clz3eVqV71R4jamXwXJNOeL3AiYqm5ypcJfT/2oEFc++GoAy6Qm+amPS+aVsXHcQL2F5hgtjMNLnrH4q+na189LjvhKR66CpGclQcT4tJ2u1z4IXWKCkYULE+BEI086GGo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Geyx4S9rFZTYQT2BmdyN30Vrgsm0edrPPM41i+0WsRz2LbD3OBDGL5pkpot1QRClxxPUAdn1fu3E2f2xGYcviiWAU1k87MRzot2906M3qOlFv2NAHoR9n0hVCcnbx8+OTnDshIwFajEQMrc+l9higiY+p/NRGiw2hX9D9fIoMUI=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=MEq408TRS3qHhcE9J4TreiAvTkOcDjE6FKyZ8F2Nu7I=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795097915619501.5468739001549;
	Thu, 19 Nov 2026 06:18:35 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 1/3] setup: reject compatObjectFormat == objectFormat
Date: Thu, 19 Nov 2026 16:18:20 +0200
Message-ID: <f74a0fd67af600f45bdb7560253c747aab073c65.1794932695.git.adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1794932695.git.adrian.ratiu@collabora.com>
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com> <cover.1794932695.git.adrian.ratiu@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When extensions.compatObjectFormat sets the same hash as the repo
object format, every command in a build with Rust aborts with:

  BUG: repository.c:204: hash_algo and compat_hash_algo match

This includes "git config", so the bad value can't be removed with
Git. It also happens with no extensions.objectFormat at all, when
compatObjectFormat is set to the default object format.

Check for this in verify_repository_format(), next to the other
repo format checks, and return an error instead.

The check runs before any of the Rust-only code. Builds without
Rust, which so far died because compatObjectFormat requires Rust,
now get the same error, so the test needs no RUST prereq.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 setup.c                 |  7 +++++++
 t/t1302-repo-version.sh | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/setup.c b/setup.c
index 186815c780..a97280cafe 100644
--- a/setup.c
+++ b/setup.c
@@ -918,6 +918,13 @@ int verify_repository_format(const struct repository_format *format,
 		return -1;
 	}
 
+	if (format->compat_hash_algo == format->hash_algo) {
+		strbuf_addf(err, _("'%s' is '%s', the same as the object format"),
+			    "extensions.compatObjectFormat",
+			    hash_algos[format->hash_algo].name);
+		return -1;
+	}
+
 	return 0;
 }
 
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 69723b88ff..718dafc95c 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -98,6 +98,20 @@ abort 0 noop-v1
 allow 1 noop-v1
 EOF
 
+for hash in sha1 sha256
+do
+	test_expect_success "compatObjectFormat equal to objectFormat $hash" "
+		test_when_finished 'rm -rf same' &&
+		git init --object-format=$hash same &&
+		git -C same config set core.repositoryformatversion 1 &&
+		git -C same config set extensions.compatObjectFormat $hash &&
+		test_must_fail git -C same rev-parse --git-dir 2>err &&
+		test_grep \"'extensions.compatObjectFormat' is '$hash', the same as the object format\" err &&
+		git config unset --file=same/.git/config extensions.compatObjectFormat &&
+		git -C same rev-parse --git-dir
+	"
+done
+
 test_expect_success 'precious-objects allowed' '
 	git config core.repositoryFormatVersion 1 &&
 	git config extensions.preciousObjects 1 &&
-- 
2.56.1

