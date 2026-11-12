Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794513553;
	b=t+nScNW3l69scCXskXLubjN77lT6ffe/dWt5e3zELSprI14rfajlMbeyJO2h6n7IG/p5
	 E+ajN3M2xbpNBxD3D80mysOqurlDP5123WuCrb0I45jjPGzaRbD3lWVnbV9JXQ+3QvcHg
	 50TUHF0PdrPkY4XT+wNCL+LQq1QMMUmYjtsCD6YieMD/HJ5kCkSY8xTXg+cF393kj+evb
	 9aV/qJfusXD59ey5vvJ7itaiL7JOOO2WGlb3HSlEidNzsFiMq7ueRbAZ6Av1P5IsPRQtr
	 j1X5oysKqBDBm1swdQvDy4tNEm6g0C9PuYUgnRmYHOxDD8Nrx1eXXwKTeMdbkw92qOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513553;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EV8h0IkP16XLT54tTHQCJDUQXTRD2AHJY/qAXH5iq8s=;
	b=Nt06MDLBBsDFT9pAsgiMsWKv2nmNB5qZZ95XBDjv9IwmSUHs5fN72sBTdU3n5odUmJor
	 su35V4Gn11HSpQ8zV25svy2ObyhI87GG6Bwz4KrCl0ehW3gnaY5lfLv7rJ1iRcOCFxk1w
	 d+9mFQ9ojMxSojZe5SeV9dL4Im5I5tHZuHuqfwL4vSqh4/rM+Bh807EqtJ04l0wpY5bZx
	 E8pKzbYbKbWPd7XL1MJ819f6DxEo9pfCs7N+4Vhzct6nb7XHD6MMFte4d3Q/g7MMrf4em
	 VkuC9WDhEotLivI5UKKD4wyysic1U33U7s2pN8Ew7RHNzGzkYsM92xKgWdukB6sL4uA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=NrZiYRi7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2AD606A32A
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF2AD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=NrZiYRi7
ARC-Seal: i=1; a=rsa-sha256; t=1794513539; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Whl9XQknz+CuCdNH1gsE0zhfFSgENkSoOBjyipjvrVfPgJsTY4EhyoCrxXFhMIo6+tydyumAvmYBUpiTE/iuGq1ael+51h9nKPbwTCX2q/H48TY29bTb1Y7+K1ip9KgoWQtjDR4WrXrYu7oOdVcx7B4/epSl4R+pUZ/KSSAGP20=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794513539; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EV8h0IkP16XLT54tTHQCJDUQXTRD2AHJY/qAXH5iq8s=; 
	b=ULku7VOY5uBCLAo/G2J9obD0AK7fa8aH6uFZNnY4G9d+ooD07dnEulIr6iM8Ys6vvDH2/aLTvbs5cy+CkYgpd8qz7EGxp7nFB167rNipIEof7TskL34nPKc0LSjdY1nk4ti6BuIyotBw6h/91AY5XMS6dN5jdTtngsSLJ++m4t8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=NrZiYRi7s+iknM3paSYMLBDgdOPKjqlg/ZTwVOCbW3EhH9PGM1LD0biL9sDB053NxBXQv003VJkQM0unwIb63BZ2iJTag8pr4IULULEp2f1/M9SsKfE9KyCP/AmbdHgV9+mV2wCLtwB9edtXZWKORXS+H4wkvT2RiDWdn/ifJEk=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=EV8h0IkP16XLT54tTHQCJDUQXTRD2AHJY/qAXH5iq8s=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179451353494997.46665169260586;
	Thu, 12 Nov 2026 11:58:54 -0800 (PST)
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
Subject: [PATCH 2/3] rev-parse: die when --output-object-format cannot map an object
Date: Thu, 12 Nov 2026 21:57:39 +0200
Message-ID: <20261112195740.2834341-3-adrian.ratiu@collabora.com>
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

"git rev-parse --output-object-format=<compat-format>" should print
an object compat id when extensions.compatObjectFormat is enabled.

Git however doesn't record a compat id for every object, e.g. for
objects received by a fetch that goes through index-pack.
For such objects, rev-parse silently prints the wrong id: it prints
the storage id where the compat id is expected and exits with 0.

This happens because rev-parse ignores the repo_oid_to_algop() return
value. When no mapping is found, that function fails and leaves the
id unchanged, so the storage id is what gets printed.

Fix it to die with the same message as pack-objects. The other callers
of repo_oid_to_algop() already check its result.

This only covers a single revision argument, the one case where
rev-parse converts its output. Other forms, such as "A..B" or "A^@",
print storage ids whatever --output-object-format says. That is left
for a separate change.

The test copies a loose object into the repository by hand, so it
doesn't depend on whether fetch writes compat mappings.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/rev-parse.c  |  8 +++++---
 t/t1500-rev-parse.sh | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index d2154eac8d..ab2898ba52 100644
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
+					      output_algo, &oid))
+				die(_("cannot map object %s to %s"),
+				    oid_to_hex(&oid), output_algo->name);
 			if (verify)
 				revs_count++;
 			else
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 30bf8a4d0a..c15d9953a8 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -241,6 +241,24 @@ test_expect_success RUST 'rev-parse --show-object-format in repo with compat mod
 	)
 '
 
+test_expect_success RUST 'rev-parse --output-object-format with unmapped object' '
+	test_when_finished "rm -rf plain compat" &&
+	git init --object-format=sha256 plain &&
+	git init --object-format=sha256 compat &&
+	git -C compat config extensions.compatobjectformat sha1 &&
+	oid=$(echo unmapped | git -C plain hash-object -w --stdin) &&
+	# copy the object by hand, so that no compat mapping is written for it
+	path=$(test_oid_to_path $oid) &&
+	mkdir compat/.git/objects/${path%/*} &&
+	cp plain/.git/objects/$path compat/.git/objects/$path &&
+	echo $oid >expect &&
+	git -C compat rev-parse --output-object-format=sha256 $oid >actual &&
+	test_cmp expect actual &&
+	test_must_fail git -C compat rev-parse --output-object-format=sha1 $oid >actual 2>err &&
+	test_must_be_empty actual &&
+	test_grep "cannot map object $oid to sha1" err
+'
+
 test_expect_success 'rev-parse --show-ref-storage-format' '
 	test_detect_ref_format >expect &&
 	git rev-parse --show-ref-storage-format >actual &&
-- 
2.56.1

