Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDEA2DEA6F
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203818; cv=none; b=EHWd7VvGKLq2iK4gprFmhX25P885gC404TGhu5U+UcD0h/QTSOeCyv7IFkxyuEgpcOFseLnm9sLKTlyljFoAEvhix5ilQ/6tvAJMtRixzv+YL3+Mvc1n9UDtXDTxPLsUCSMWR/odbBljT/sLwH7+N/6v5vWaPhO52UlILHXNMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203818; c=relaxed/simple;
	bh=lEwEob2ZD9Ds+GLk8DScmZRX+a2pR8A6BbkAOOCixXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MDDFkp5t54G9lm4sX6E5ufmx7qTKr0jb8EdRlyiM/ka9RrHzo5GjrF7Wk55boSVVjVVIUpI8v5gbGHBJtv2HNuGR4yKneObgyy5SoTghpL8UIUAcLnMuxvtrGAFXAAeN1iWN0EtRenVk3g+kKA3H39hCieaEXRtVJBhVG9LRSmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LPPVRQNk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R450tvy7; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LPPVRQNk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R450tvy7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 80390EC0129;
	Thu, 23 Oct 2025 03:16:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 23 Oct 2025 03:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203815;
	 x=1761290215; bh=gfCVeePkVwhqG/DAkWyLqXVM0YtaGK0qcDPRV/dvIyM=; b=
	LPPVRQNk5fORvM27i5R+9TH6v8t2TVRXqGn14VYl9mzVu2dz2GR/bI0aKUyZ65NI
	NdCQrusVu4actAnMfEBoKUxa0pg21jTJqlsBeeu7zFaAkxMHe6qxSvxhJoUXjmlw
	LZcwfTJ7eiP7d+xEg/bASAOelQxmT788Z1vvsurURTLYDS8Ss7jBuLCiaFmDnjSU
	6ekHLaJYV7OrSNxSXWlQ9ip5+74fQMOiu1VE4aom2jXVQtiyiaQOAW06vAqOXcmL
	WUpQ05iDPFoaT0UO/wWJRzcbY3qj4tNGdZbTC08fwOktXsxRELlgtfIuNMh3v+RG
	lPFgkhLuFSKwnEaJgUSioQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203815; x=
	1761290215; bh=gfCVeePkVwhqG/DAkWyLqXVM0YtaGK0qcDPRV/dvIyM=; b=R
	450tvy7cyup47KbGH5doDCpCfvGeHlZtrIFvgyed9+LOnmg5gheMsCjY9wbrmy42
	kGuU7R9gFTLZiW+xyeDSJEnQznldmwqvSkIaWlsRMRFQdeSM/Fk5246aHLNUu65b
	Wucibvu1vJoCk1ut/VUYjm09HjJSVywpwcVrG3bWMqPCBvl52HrzuMAJF7rOEqEn
	69PgtCg5wTWCtDZKiaTQK56GPAuvWKkm5crorfYlcMagTuKMlL+j1NDOlvSX+rBf
	qBwL//UCzhhvexIkkWXT2EfwmW+8RaQRhlBjJsnYBht9AeuXxKuWBp1JF/2MVQjh
	Vzvg60tHh3I+5khH/wTHw==
X-ME-Sender: <xms:Z9b5aO3TsmxBnY9XDnlDI-d3Jc7zjBBpybr5qo2yu0d90zUEN8s0HA>
    <xme:Z9b5aJiEyh_NGxA0eRR2m-4787XEH0pDfKSh2y1k99hA-8oQWn8HZBIIih-UGT_hy
    UYbfbVerxW4hh9Ltazd0--V0n9_v8VLRE3FE0Ck9doAijV--qP0X4U>
X-ME-Received: <xmr:Z9b5aHV0aGxmNNDowZZdw7lHuZSyk7ryRUccXhYHwYeAV1jfOkd-i0FJXC861hLBbbbcYrxyjg_2sVEv-8K7fAdQdn2iQ15LobJIrSPEAuqmDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeljeekveekkeeljeegleduheekkeetfeefudfgkeffhfelueduteeileejgfen
    ucffohhmrghinhepvhgrlhdvrdhtrghrghgvthenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:Z9b5aAWDbDmqjsoXnPjBm76f3NBmRPlqe9UJapyvR8qF2f5GnKCo8g>
    <xmx:Z9b5aPhltp4ScW6r_Y0vXSq85P7mRLbd3B8hBWth2vW7j3xWjZJQLQ>
    <xmx:Z9b5aDax7pGOjou8Vp7MxANllr7G_zTvxN6q912LYhvdSMu7G07Fmw>
    <xmx:Z9b5aEr8bca1YTNrjtR8typ2RWP0ZgjArgmSPel0asrtdKjyahOWsA>
    <xmx:Z9b5aKZIHq-YTIzvjA3wb6O-83z1YMtpXgQmdOdosrhkKX79o_bCUrFV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 46affc60 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:16:21 +0200
Subject: [PATCH v4 12/14] refs: don't store peeled object IDs for invalid
 tags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-12-2be68ce82c9a@pks.im>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Both the "files" and "reftable" backend store peeled object IDs for
references that point to tags:

  - The "files" backend stores the value when packing refs, where each
    peeled object ID is prefixed with "^".

  - The "reftable" backend stores the value whenever writing a new
    reference that points to a tag via a special ref record type.

Both of these backends use `peel_object()` to find the peeled object ID.
But as explained in the preceding commit, that function does not detect
the case where the tag's tagged object and its claimed type mismatch.

The consequence of storing these bogus peeled object IDs is that we're
less likely to detect such corruption in other parts of Git.
git-for-each-ref(1) for example does not notice anymore that the tag is
broken when using "--format=%(*objectname)" to dereference tags.

One could claim that this is good, because it still allows us to mostly
use the tag as intended. But the biggest problem here is that we now
have different behaviour for such a broken tag depending on whether or
not we have its peeled value in the refdb.

Fix the issue by verifying the object type when peeling the object. If
that verification fails we simply skip storing the peeled value in
either of the reference formats.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/packed-backend.c      |  2 +-
 refs/reftable-backend.c    |  3 ++-
 t/pack-refs-tests.sh       | 32 ++++++++++++++++++++++++++++++++
 t/t0610-reftable-basics.sh | 28 ++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4752d3f3981..1ab0c503930 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1528,7 +1528,7 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 		} else {
 			struct object_id peeled;
 			int peel_error = peel_object(refs->base.repo, &update->new_oid,
-						     &peeled, 0);
+						     &peeled, PEEL_OBJECT_VERIFY_OBJECT_TYPE);
 
 			if (write_packed_entry(out, update->refname,
 					       &update->new_oid,
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 9febb2322c3..6bbfd5618da 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1632,7 +1632,8 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			ref.refname = (char *)u->refname;
 			ref.update_index = ts;
 
-			peel_error = peel_object(arg->refs->base.repo, &u->new_oid, &peeled, 0);
+			peel_error = peel_object(arg->refs->base.repo, &u->new_oid, &peeled,
+						 PEEL_OBJECT_VERIFY_OBJECT_TYPE);
 			if (!peel_error) {
 				ref.value_type = REFTABLE_REF_VAL2;
 				memcpy(ref.value.val2.target_value, peeled.hash, GIT_MAX_RAWSZ);
diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 3dbcc01718e..095823d915f 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -428,4 +428,36 @@ do
 	'
 done
 
+test_expect_success 'pack-refs does not store invalid peeled tag value' '
+	test_when_finished rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty --message initial &&
+
+		echo garbage >blob-content &&
+		blob_id=$(git hash-object -w -t blob blob-content) &&
+
+		# Write an invalid tag into the object database. The tag itself
+		# is well-formed, but the tagged object is a blob while we
+		# claim that it is a commit.
+		cat >tag-content <<-EOF &&
+		object $blob_id
+		type commit
+		tag bad-tag
+		tagger C O Mitter <committer@example.com> 1112354055 +0200
+
+		annotated
+		EOF
+		tag_id=$(git hash-object -w -t tag tag-content) &&
+		git update-ref refs/tags/bad-tag "$tag_id" &&
+
+		# The packed-refs file should not contain the peeled object ID.
+		# If it did this would cause commands that use the peeled value
+		# to not notice this corrupted tag.
+		git pack-refs --all &&
+		test_grep ! "^\^" .git/packed-refs
+	)
+'
+
 test_done
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 3ea5d51532a..6575528f212 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -1135,4 +1135,32 @@ test_expect_success 'fetch: accessing FETCH_HEAD special ref works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'writes do not persist peeled value for invalid tags' '
+	test_when_finished rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty --message initial &&
+
+		# We cannot easily verify that the peeled value is not stored
+		# in the tables. Instead, we test this indirectly: we create
+		# two tags that both point to the same object, but they claim
+		# different object types. If we parse both tags we notice that
+		# the parsed tagged object has a mismatch between the two tags
+		# and bail out.
+		#
+		# If we instead use the persisted peeled value we would not
+		# even parse the tags. As such, we would not notice the
+		# discrepancy either and thus listing these tags would succeed.
+		git tag tag-1 -m "tag 1" &&
+		git cat-file tag tag-1 >raw-tag &&
+		sed "s/^type commit$/type blob/" <raw-tag >broken-tag &&
+		broken_tag_id=$(git hash-object -w -t tag broken-tag) &&
+		git update-ref refs/tags/tag-2 $broken_tag_id &&
+
+		test_must_fail git for-each-ref --format="%(*objectname)" refs/tags/ 2>err &&
+		test_grep "bad tag pointer" err
+	)
+'
+
 test_done

-- 
2.51.1.930.gacf6e81ea2.dirty

