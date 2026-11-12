Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794513556;
	b=zllPM2OVtZhqFGoWZtdH7+ivfJrUr6/hcz7wes+WmvIY77Xg1FG/NM5OO4AM6Mep1MuU
	 oevrajgU2Rn4myNcC81/I2t4YJ1pQnBBGjtbENtKfdgD3Ruq0/Od+DBVU7lj2mNExHAzS
	 zXPdiVpr1HcuIx4usajN8UuyytB0Qj/aLON6UtoNnz2Nn1Y3UhiyV712C665NkwBiQfHN
	 uNuHIpLmWFF8759Z3i28tneU1KtorEI9Mv1wFAZ6wqLfdc6+a5PQylZsZpd6wmGpDjkZD
	 e9B0HiSsUNyFdqou6v6Dse9OgITOkKBsOTCCUCOVGVAetWBjqSiMUAYgmjI3MEXTblw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513556;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bA/oXkBYhLdJ3LTLi1lqXhFGKtzSg+pJIVyCqhcALlA=;
	b=vhhiMYkqAu2NmS+o88YSo0lVLJOqqRKpTO3IMKOjQO640OE1GZu9SazydZ6x0t8DZfkI
	 NgzHccFh2PqyqBNCpQlK7MBA7h5hjw5YXDQsh83vsqdYebg/vFR/spQxeW4SB+PzSOCXD
	 /LpsbrJu3z5NfnUJVmLKce8dTYhkKdSyml7eGSJ2Jlp7YJjXwzyy5lvXiQElqJ4GkF188
	 IFoE+D0i2eeYu1oCnYjpXhPP/aQkTzNd2uDRH0sZYji97o5+DAhLtvK0NRCs5IqI3N/NN
	 YycSdBSG2n0R9yKPzXI2OlHwRNWbulsRQw/QXbFMqRoO3sTLYxbzSF5Kw5pgOYwKbew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=W07new2l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.108
Received: from sender5-pp-e108.zoho.com (sender5-pp-e108.zoho.com [165.173.182.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD2606A334
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EDD2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=W07new2l
ARC-Seal: i=1; a=rsa-sha256; t=1794513533; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NlDfIQCanMqU40lXN85paurZhfFl5aueIARv4rqzq/r2PlA4bwgU3O7VWBUqpVUa7R5zkDVZcvoBKFCUySle743GiR072sDqdAc6hhsfMwI168eQBp/jrTnVriEsM7FCMt2TYnSzci24qcAqJdWNeZSlRle2vaHndKASIovzuLg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794513533; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bA/oXkBYhLdJ3LTLi1lqXhFGKtzSg+pJIVyCqhcALlA=; 
	b=Qd4BL5N9Su7X0cNJRBovCCBx+W7e1YJxgDUs6R2IIJUPMWtw64rv9o7N0YcU6YMWnsbSYdq1j3NRCmTVvVhvEGKEpqVKsSuabTnkn1jTZyW3kB9C9htlGW+11wUqfPgXn+VX/w1dWRvSA+OrIlLcEofkgPWU9J+W3NzGOkk5UYo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=W07new2ligXVR3h8Iis/iyrIbZvGdWZJc1CDcy2NCLFxIzgk2lCqa5RlUB2WttS8yBTIIwm3aVSFTLQT0RcOKrSNZUKQxJOkwHkF6ECkrFFsiiGEhg0LlM2NMmSU6LUzRByg0J0nDm1NjyMF69MWF2/prGzfNFp0hnHmPzBhy4o=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=bA/oXkBYhLdJ3LTLi1lqXhFGKtzSg+pJIVyCqhcALlA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794513532355104.62268063101828;
	Thu, 12 Nov 2026 11:58:52 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Emily Shaffer <emilyshaffer@google.com>,
	Josh Steadmon <steadmon@google.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 1/3] setup: reject compatObjectFormat == objectFormat
Date: Thu, 12 Nov 2026 21:57:38 +0200
Message-ID: <20261112195740.2834341-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
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
index 186815c780..52a9462edd 100644
--- a/setup.c
+++ b/setup.c
@@ -918,6 +918,13 @@ int verify_repository_format(const struct repository_format *format,
 		return -1;
 	}
 
+	if (format->compat_hash_algo == format->hash_algo) {
+		strbuf_addf(err, _("'%s' is '%s', the same as the object format"),
+			    "extensions.compatobjectformat",
+			    hash_algos[format->hash_algo].name);
+		return -1;
+	}
+
 	return 0;
 }
 
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 69723b88ff..858aea62a5 100755
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
+		git -C same config core.repositoryformatversion 1 &&
+		git -C same config extensions.compatObjectFormat $hash &&
+		test_must_fail git -C same rev-parse --git-dir 2>err &&
+		test_grep \"'extensions.compatobjectformat' is '$hash', the same as the object format\" err &&
+		git config --file=same/.git/config --unset extensions.compatObjectFormat &&
+		git -C same rev-parse --git-dir
+	"
+done
+
 test_expect_success 'precious-objects allowed' '
 	git config core.repositoryFormatVersion 1 &&
 	git config extensions.preciousObjects 1 &&
-- 
2.56.1

