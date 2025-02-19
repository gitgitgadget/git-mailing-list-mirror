Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32331EFF81
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971435; cv=none; b=eMWVdLce2bbxLbacG0996soKXVWrDGVEa2EtfVvUQVMyRuaPVoaBWhuhbzMeqiPTN28S9385rBzcglSO+yi0CJaEfIP16s6TkZ0ldYNxJbEMbDrrZyN0Ru76nxufV/eC++K+7526dRV2c/ANpU/49RTpIgfLhPUv4trRlVN4NlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971435; c=relaxed/simple;
	bh=b8fJyCnS8dACcCnDWRVw5FrC+6SvVd0r+XRr2cny8m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pkMVKmY7MnWVBNYodnmHmcTVSQDO0IpVNBvKPCmQgtDcGSXQCTJsTYrGvsqrypY+0tyYbNNNSEynYKh8FJqZ/5qcKxHQDUtMYQTSJgU7JwrV12q5EMFTOaCNG5raVtv30aCUogLBMGslw9ikS3X1Dw9Ney0zFsxs8QbNi9uIxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JRBp6kZj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eI5W0rYg; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JRBp6kZj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eI5W0rYg"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B917B25401E8;
	Wed, 19 Feb 2025 08:23:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 19 Feb 2025 08:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971431;
	 x=1740057831; bh=bAnEC5LEQv2KIeZSxMmvqhioX0uNPnWP4RR5gdObBNk=; b=
	JRBp6kZj7klbyal3gVY0UIue6ActCsJHoALQEIXtI+7T1Y/xlkf8KGJULazB5rxC
	B2A9aWOqzAevjp6BTOWqu5HMLgTC5XmnZNB2lcFbFNAe2zVA5whwGqOw9JBIB98c
	MWKLbxGxbCVUWTgpg507RmmP0Rc6f3D/aGO9zbsb7biKxkyoJL5sJZI9ifOo6jgk
	HFRUTttK5QzfR9cr7iWkidS7ikbcT+F3hg08pZrcI1NtgOnDnUOX/hNOeQSMTFAh
	zk5OopVzTfFyJ1s/L4OUKoiaBSMp4JF6pMnSbDBkCvugXR0Ddxv7Svn1SMeHkRG2
	YYy15WbTzFMVTke2cc985g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971431; x=
	1740057831; bh=bAnEC5LEQv2KIeZSxMmvqhioX0uNPnWP4RR5gdObBNk=; b=e
	I5W0rYg4yt9t4fsbjqb1V+MZMnrbPUx/yd4YfVJCDtzzgYeuXAyU8GGDv2i5/LiV
	PfIudflPnVtX/LmLQs0FcgO+Hjcx8vihHXqjHuDjliBdK0TAVW3c6pZQVJRMnPp0
	Hvk//PJQvFrNprqE9ryHOcIDCZ8lDzimFQ6Mb6ueEbbG6DLnDHtMwKFEEk8LnX0/
	ChhPqxlXpGuaDi7m0oPfdEqhoyvCO5EwBFbchWbCjcPL0oo88T/6R5h9nkEveyNR
	vxiHr1sACAU6U3tOrtLGAc3ZAt+Xy9TbQWhD4PbWODMXmX4j2GuUod+J9rkbsIty
	s6DzbTFJae64kmS8lzaBg==
X-ME-Sender: <xms:Z9u1Z4M4120a1KbqyGe9e7KXUMuITepzz0dikBe1kR7PO-PuEwDzAg>
    <xme:Z9u1Z-_dIhxVKrGSzLJ8XQfXnMuvL6hh7_Sf3GDfHBkUP55q95Myl_Cq-EGhrHky4
    H4AIbcuXWsAQ6tfXA>
X-ME-Received: <xmr:Z9u1Z_SQ8R_Ly2xq4OV-7LVbUPbiSOyJeorm94cSGQNFUVj5f9wU2LYvb5p4JQ9TwfaY55Ek3GTm7Hp2lIZYLyvD5AMOb74GlLBQL9qt3W9RlPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:Z9u1Zwtc6R-0jxZr0lX0-VYqZVDgM7gknQ9e13XoVB5lQFO1wWovQQ>
    <xmx:Z9u1ZwfXdd8TOek4EivZcimGbFVBc8zlTuNYf6E8X_2gRO1D2oQ3HA>
    <xmx:Z9u1Z010t9F6ecgM57XVy596y0WRwlYci42ll0N5gUeQnFzANt0nBg>
    <xmx:Z9u1Z09EM40kblPYY25UnIg6HCRSHgEwDyWzFrCzyQunNIDbna9o8g>
    <xmx:Z9u1Z-vBS40_gJi-1lab53emXA-CWoYAiJ3wFFRYffXrdWKdWJ-Wt6fy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c2782e00 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:42 +0100
Subject: [PATCH v2 15/16] refs/iterator: implement seeking for "files"
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-pks-update-ref-optimization-v2-15-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking for "files" iterators. As we simply use a ref-cache
iterator under the hood the implementation is straight-forward. Note
that we do not implement seeking on reflog iterators, same as with the
"reftable" backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 859f1c11941..4e1c50fead3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -918,6 +918,14 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
+static int files_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				   const char *prefix)
+{
+	struct files_ref_iterator *iter =
+		(struct files_ref_iterator *)ref_iterator;
+	return ref_iterator_seek(iter->iter0, prefix);
+}
+
 static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -936,6 +944,7 @@ static void files_ref_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable files_ref_iterator_vtable = {
 	.advance = files_ref_iterator_advance,
+	.seek = files_ref_iterator_seek,
 	.peel = files_ref_iterator_peel,
 	.release = files_ref_iterator_release,
 };
@@ -2294,6 +2303,12 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 	return ok;
 }
 
+static int files_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
+				      const char *prefix UNUSED)
+{
+	BUG("ref_iterator_seek() called for reflog_iterator");
+}
+
 static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
 				      struct object_id *peeled UNUSED)
 {
@@ -2309,6 +2324,7 @@ static void files_reflog_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	.advance = files_reflog_iterator_advance,
+	.seek = files_reflog_iterator_seek,
 	.peel = files_reflog_iterator_peel,
 	.release = files_reflog_iterator_release,
 };

-- 
2.48.1.683.gf705b3209c.dirty

