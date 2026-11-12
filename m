Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794463060;
	b=xtVfmJ367Yis3YWD/nus1a2lubajXAec5TMD2p/qFfKb5onxoWgnoISWHTMjsUBEsKrn
	 LwyvLo9SaNNKcqQJy6ihjV0wcUsQnJzOrIokymPTk4FuaQAnT2xsxhwKuo5jiliE+QHQh
	 c761EOc3efH2bEP3JXeJ8/7/o2v7lAm27ficNjnPzs9KmJqLm3OFRpgqHUiRd3PMh7LT5
	 LoKaZlsl/110xzzxTLQWoSFAkkqSQAuvqRy/4PP3c+URXLmbGAfcq03rIvmF+f/UP/10m
	 EZNtJCr3sP+NfLZDKqdR3fsVQ0iO46nXPhef5M0AhaCT9Q4xhUu8p5en9MM02rGhk9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794463060;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7S1LKfzuZZLFlJkIBHmFDackzkOkv5Y+ABD/BXruYuw=;
	b=SFeiOvVenw7Tg1zUFd0u20ruoyIEyVgIJTrbaqW3PK0IuCy1BykXIxgQJ01rXoAKmvHx
	 NxdfIrkhD9W4liA+cX9A/GWjoatIIkvOg52ijPP1BcZLyV9MpLLgodWiFfNTZOb00Iz8f
	 CaV0Fa+cyYRZCfDDoYkANOMjBa+yxjw1nYEfZ2dOROdJ1yg1DiFqx306TO+Tuwd8koM+O
	 PG9P2YOtp4lH666Pj0NBTY2QrZIs5dswBl0rcwmnHkMSEGkKN1tIaPOMghdZNlMyaCWhe
	 twCqdU3DzM+BXNZ/Kk713vm7orLHGHO0FUnh3TS5te4o+FsRnjNx3yIBF06bkg+bAzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbyRQS2Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6BE606A323
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbyRQS2Q
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794463060;
	b=W0btr3k+8cydNyBgUc8a0p2C51+81to2LkaVDfwyDbP9Mpu9bhBWd6cFp2kYJexh9JI0
	 RqrWTRn420xYRtzkHgadNaO1WCRPeX5IHKPr5IdGuDHZozuoxY6Gz7Ejd//JzziTXN+oD
	 AnvhsbUfpsV5GVw0eJHpkjbltUEu6AvF+fipMeW62QfFMUoBTqqKb0zRi4vK2sAyQyZS+
	 MUhdvzILXuhQg9ehd5hDFuvzobOZbX5MpHID5vULgL82gcnqFt0bTKgV4jJxpvsTf1A4w
	 FKr18qsYK1xvMNHsRG2P37FI10HmjXLBloHsEreIEi4QP2de2D9vmzzKQr+c3NPBWvA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794463060;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7S1LKfzuZZLFlJkIBHmFDackzkOkv5Y+ABD/BXruYuw=;
	b=YdClviRZZ+UZ38D+AWZxAf8Kh3uu5xTokXlcp1pPphRffYo1WqF/0DlKa7kHNS/wOZdF
	 2PsFI4eatBZorguxfBCfAnd6iggJHpG7g+1pS/FHl5T6I7KSRBr3ulj/u0pcPu+DiBKyG
	 rbgU+Fbll3fo7gHlefQ3EMlFh+7YhxF+78AySXGYKfX29nW0D8RhU2FYBo8o4ulr/km5Y
	 kwQBxnXv+3VepDv3SSenU7/nv4KQYGdCQOzz5F5LYEnVtLx1yhf8qo9dw2aXZw7QZiWmf
	 c1FpRnUSbydgTRXzRnQ+u0amyvf5LluYStfZ+aowiaQVkJZz46a2ZmTRpTunzUprKhw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C17841F00A06;
	Thu, 12 Nov 2026 05:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794463060;
	bh=7S1LKfzuZZLFlJkIBHmFDackzkOkv5Y+ABD/BXruYuw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=kbyRQS2QKLWk0WBJI+kcswgp9s91MjHeE7dfn/52xlOnVqqGg8/ToPoiv3W7Om9ni
	 kbgJKRrhb+6qUEPvWYnaD31WHCKZWeeL5HnsL/bktwOuJ79HRxuyMVRk+n8bFBL3fO
	 N/CiTbGD3mbL8qgxXWVYchbaSplxmW+wgAEuFCDCbF9zUXKWFuSeoSkT0VVNGsVugg
	 mwrvV8XdXM42U/MlwJ9WzjgJX01BFsFZ458s75/X/n/ualSPUlPx79zkyHHmcGMQW1
	 rcCiBW6fZGE5cqxnhnPh8v/GE5w5HNOKWMVdYkjKoLXofizsE+TF8TIcBW2qB3IyMj
	 MJrPbwFqCydHg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 52327492D4;
	Thu, 12 Nov 2026 05:57:39 +0000 (UTC)
From: Yusuke Hayashi via B4 Relay <devnull+yusuke8h.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 05:57:35 +0000
Subject: [PATCH] refs: drop unused `peel_iterated_oid()` declaration
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
Message-Id: <20261112-refs-drop-peel-iterated-oid-v1-1-7df1c313e293@gmail.com>
X-B4-Tracking: v=1; b=H4sIAE5V9WoC/yXMQQrCMBBG4auUWTvQCSjoVcRFzPzVEWlCJopQe
 ndjXX7weAs5qsHpNCxU8Ta3PHfIbqB0j/MNbNpNYQwHEQlcMTlrzYUL8GRrqLFBOZsyFOE4CiT
 tI/VD6bF9tvv58re/rg+k9lvSun4But0yAX8AAAA=
X-Change-ID: 20261112-refs-drop-peel-iterated-oid-ede2901e1c5a
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, 
 Yusuke Hayashi <yusuke8h@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794463058; l=1405;
 i=yusuke8h@gmail.com; s=20261112; h=from:subject:message-id;
 bh=dC5up5AgSmgB4z4cviymA6G535FcTBxD4cy7cR+IDW8=;
 b=81zYynGe+1TZePPrjZgJnfxyxZNNTPrub1dBBsheufc1+o9GUrdwT1rsE22qHNqqZ3rP+FBzs
 AJweKuLgQ9ED36U7bW8GPMeC40XMAiH5ACqQB0/ADj5wbqHPGhxOU2j
X-Developer-Key: i=yusuke8h@gmail.com; a=ed25519;
 pk=7SzYbbTWl4u1a0gmKeMxAqo7g7F1K7tnWWGWQ+LnNNs=
X-Endpoint-Received: by B4 Relay for yusuke8h@gmail.com/20261112 with
 auth_id=1495
X-Original-From: Yusuke Hayashi <yusuke8h@gmail.com>
Reply-To: yusuke8h@gmail.com
Content-Transfer-Encoding: 7bit

From: Yusuke Hayashi <yusuke8h@gmail.com>

Commit 5a5c7359f7 (refs: drop `current_ref_iter` hack, 2025-10-23)
removed `peel_iterated_oid()` from "refs.c" after converting all of its
callers to `reference_get_peeled_oid()`, leaving behind the declaration
in "refs.h".

Remove the unused declaration and its comment.

Signed-off-by: Yusuke Hayashi <yusuke8h@gmail.com>
---
 refs.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/refs.h b/refs.h
index ee3b8a62ef..73076cba2f 100644
--- a/refs.h
+++ b/refs.h
@@ -178,19 +178,6 @@ void ref_store_release(struct ref_store *ref_store);
  */
 int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err);
 
-/*
- * Return the peeled value of the oid currently being iterated via
- * for_each_ref(), etc. This is equivalent to calling:
- *
- *   peel_object(r, oid, &peeled);
- *
- * with the "oid" value given to the refs_for_each_cb callback, except
- * that some ref storage may be able to answer the query without
- * actually loading the object in memory.
- */
-int peel_iterated_oid(struct repository *r,
-		      const struct object_id *base, struct object_id *peeled);
-
 /**
  * Resolve refname in the nested "gitlink" repository in the specified
  * submodule (which must be non-NULL). If the resolution is

---
base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
change-id: 20261112-refs-drop-peel-iterated-oid-ede2901e1c5a


