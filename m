Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.119
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795097932;
	b=Q9ImL9FiA9qA/ylvl5vfFKdLzEvvuR6zyt7IFidlz6/bmEp+mf0xuwPHtPQLApzK/p0Q
	 wdSmV17S4peazydXKEcVX2ydRkJ/t1v6Caojmo6kqpkd0gxUnilGgIwvZeKVIFo5gBjFt
	 z1QHrUNeZ6XMW4Gz+oLLx9fETr4DE8oTZUFMxu7LR244sDxWilrrmqsTUz3YGYjW8B9R6
	 Piuk6gFYDoR3Sym+SdCnYZtqc00w3V15ycLE0i15pVCyXYInnvtLnfU+amWYMDx+T9JUR
	 a/bVl9xzQNBvMyT8rKOBXSPkvvcyMEgqYqHBKDyGaIUW8EXZ35GY5nyC+MmdS4ZjqDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097932;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SdQ9O9qyqddhk3SmZcXvBi5j2mvvO1KqAFyyyn3CBMQ=;
	b=lurup8WiPwH0ghQVHXZz2uV8OzY/ACOGa9gwOHjv+RbU8TiW4TOTD94Fq0kH4btq4KWQ
	 YnN+MXMIRl9VOczGCluW3fJc1Rfuo/aKDAXuIEp9f3+/4B1n8MMSeGIaIH1HKwNrEY7MV
	 c3AGVXFOxJvpNpXoBwV2UgA2RP8mtilKHxYYCiQj07ygGNNx6whUEWFHbrWh/rur++aQf
	 uhH0dRdMcUJxHqfCzHAW+td8KRPqgcJJyahbeaVtomITK++EGgq9myxTPfxLY/NzH0eVP
	 TL7aEzxxueuG5mw+5lWFGjaQIZa4HmlGV2/rURnO6U2ijaBmvmJxA/iiSgRgP2aWW/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=IuQvM5Lv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.119
Received: from sender6-pp-f119.zoho.com (sender6-pp-f119.zoho.com [165.173.180.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D22606A33A
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 14:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48D22606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=IuQvM5Lv
ARC-Seal: i=1; a=rsa-sha256; t=1795097919; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DmqoZtj1eZph8ih1e4Kae4XSnQlh1Xj1M2Nu8MCTUGoMwqo82hbamuv97q9vBCj5EB5gV8O5W4j8771dByMZqrw9DSYbYYtS0r/EAQsiRI773wFlKKMXpjrfjDTBE5c0Dn2+tnewVYXQOr0KX31yhb7ziHiKr4CcXEHs3nc7PDc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795097919; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SdQ9O9qyqddhk3SmZcXvBi5j2mvvO1KqAFyyyn3CBMQ=; 
	b=KN6dpOWZF8kb+LCaW7HKtbYiS/TyNTaQw3uGy8KvOmc+cYTBCkB/OMH+LumKvTO1Nx7gtE+MZwQg6r16aLSW+lvcx1z/SIN/M/XdUEIGv8Kogsvu5zr6ZP3V7Y6PaqI+z0mT04TrrZuzSKg3TXekZb8flrmvRwq1Yfb9HNZ0rRs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=IuQvM5LvPTlaJ6HNKswr1k95HxeoguCD0+XO8Zh4OIFO2qeag8UVxUkASsFBkErrFHV1XEuGaBOQNzA4fp+FIsBM9Q99R2C8hrTx+iufUNX03PMtaJAPK1pPnkMTtaPANL+oZWt0jHUxkiHMZyNxDKs1xQSMojIw525NFkITWEo=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=SdQ9O9qyqddhk3SmZcXvBi5j2mvvO1KqAFyyyn3CBMQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795097917901816.5968168335663;
	Thu, 19 Nov 2026 06:18:37 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 2/3] rev-parse: die when --output-object-format cannot map an object
Date: Thu, 19 Nov 2026 16:18:21 +0200
Message-ID: <5b9137274818319747b3eeafaf800ec6874df1d4.1794932695.git.adrian.ratiu@collabora.com>
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

"git rev-parse --output-object-format=<compat-format>" should print
the compat ID of an object when extensions.compatObjectFormat is
enabled.

Git however doesn't record a compat ID for every object, e.g. for
objects received by a fetch that goes through index-pack.
For such objects, rev-parse silently prints the wrong ID: it prints
the storage ID where the compat ID is expected and exits with 0.

This happens because rev-parse ignores the repo_oid_to_algop() return
value. When no mapping is found, that function fails and leaves the
ID unchanged, so the storage ID is what gets printed.

Fix it to die with the same message as pack-objects. The other callers
of repo_oid_to_algop() already check its result.

Note that this only covers the case where the user asks for a single
revision, as it is the only case where rev-parse passes the desired
output hash explicitly. All the other cases, like for example when the
user passes a range, do not use the desired output hash at all. Fixing
that would be a bigger change though, so it is left for a future patch
series.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/rev-parse.c  |  8 +++++---
 t/t1500-rev-parse.sh | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index d2154eac8d..f4b5a31aff 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1171,9 +1171,11 @@ int cmd_rev_parse(int argc,
 		}
 		if (!repo_get_oid_with_flags(the_repository, name, &oid,
 					     flags)) {
-			if (output_algo)
-				repo_oid_to_algop(the_repository, &oid,
-						  output_algo, &oid);
+			if (output_algo &&
+			    repo_oid_to_algop(the_repository, &oid,
+					      output_algo, &oid) < 0)
+				die(_("cannot map object %s to %s"),
+				    oid_to_hex(&oid), output_algo->name);
 			if (verify)
 				revs_count++;
 			else
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 30bf8a4d0a..a945f421da 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -241,6 +241,20 @@ test_expect_success RUST 'rev-parse --show-object-format in repo with compat mod
 	)
 '
 
+test_expect_success RUST 'rev-parse --output-object-format with unmapped object' '
+	test_when_finished "rm -rf unmapped" &&
+	git init --object-format=sha256 unmapped &&
+	# write the object before enabling compat, so it gets no compat mapping
+	oid=$(echo unmapped | git -C unmapped hash-object -w --stdin) &&
+	git -C unmapped config set extensions.compatObjectFormat sha1 &&
+	echo $oid >expect &&
+	git -C unmapped rev-parse --output-object-format=sha256 $oid >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C unmapped rev-parse --output-object-format=sha1 $oid >actual 2>err &&
+	test_must_be_empty actual &&
+	test_grep "cannot map object $oid to sha1" err
+'
+
 test_expect_success 'rev-parse --show-ref-storage-format' '
 	test_detect_ref_format >expect &&
 	git rev-parse --show-ref-storage-format >actual &&
-- 
2.56.1

