Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B903F660E
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531716; cv=none; b=jH5HGojlfJgPMHY6hRCuXCeYPyztaUeXHjK117g2kU1GAbiZbIHQb99JCxOg03AI3Ng6sRA0CKzHK0KKW6vSEhWKpYr5d9PBp1f53vQ+7DTDy/AwXTj8Tg23Iy8PqFFZWjpyNOwb8ta814rMVIMKPkYXueu/rQwpwd0CNMrEmvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531716; c=relaxed/simple;
	bh=EwppuSXvj9wDbBZWH/qzqS4l0iERsPq6hKwyV7pXEck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vCmFP8s9vYP4qMojr5nBr9wp9mvjdFw1suWRcpjRpnR9W1JLJbd3OgNtaDwfQXatEI2WHYYpY0N4KLNtt2RcDEKwzd7CutjJK9qyJfSvgfxVDRYjtfzHFAYxNIN7+3oY0yUEphuTF2kP3uuuKZffnHEldPUXRiqYqJg4o/UhgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HiaMdFKY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KyPIvnMB; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HiaMdFKY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KyPIvnMB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BE8FFEC0263;
	Mon, 15 Jun 2026 09:55:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Jun 2026 09:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531714;
	 x=1781618114; bh=UYd35nuNB6Ivx9bXH6OlfxUYgh7ezW/gzlJ5AaSU44U=; b=
	HiaMdFKYY7OQRGXlt+FigZmlULrE2zzmAoO2AlsgRuegAsamYTdo/+tfR8iESpah
	pU2itR6KVHu5pQwUETFDz2/MT+1BZ8xXpMafFuqV62DyZnIDU3SfIgJps3wgaHky
	+JvJpwOmrGX8W7xzVZ4yxjzwjLJwkKOI4KMh1biKwzpWXr4TOmAoqXDlCVe5F8fN
	coTpTEP+cb1uN8ue/Esjp01C0tHdxCCRuSGxEpm/vnBpodNKL97enQprzDd+IFbI
	4v4aPVuJVLHDbOt4qcFFfPmA+jii6EHZDeEHZL+vZfNGrO5pkriYuS4jvvc+bSdb
	KlAYsTKocmcy1IE5g17bpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531714; x=
	1781618114; bh=UYd35nuNB6Ivx9bXH6OlfxUYgh7ezW/gzlJ5AaSU44U=; b=K
	yPIvnMB2+1s2M4vYFpdttFeTO6ZJJWeVvXnYwO9mFz9cDsYKKq5Gg+lkbPA7fPQd
	Ws/PjrWjL58ve9ocwobmMtU+cyruzARtP5tTPWCJ4HuQXSo2YqmCXjxGfkRj7TtH
	TmI3OtYGHE4koHW1P/Gql2OXkuH4btZVOYOp0J/sulLVO/Dl02CLNYacalkbM+xh
	SrNzoVQ3gQOEpspbpgVMXR8yowuIIPypCLTaJp9l3kJiM5zMr5Semg2EGHOmV/f2
	2OSnQ44hmCz6SKvO/ZgVCnWXkJIS3xdXR0uZK4fczkJQIXBgrUF37JIs8luXY0Ox
	9E3K0atiCEeS+DQvjKp/g==
X-ME-Sender: <xms:QgQwatTBiWRn06LHvt6R2vM4k-ZjFwt47zyhM1pm5m_e3A9Fcub8TA>
    <xme:QgQwaoQp3Z9nFo1-4t6QrOnmfdA2tGk8CbtmlxSlCEPRI9b65Vuwl_d0ypPyyNU3c
    7ge4xGyLojL5RERnOLhfIiMLCX1BXQEpIOEnNnBpbp5Mq_qDc7wQQ>
X-ME-Received: <xmr:QgQwai4CPbeewuKQvn4L9yMAlwdWZFZuQfdk_shvV56Aw0qlHK2At2P88RLcP6HiQKLACdyB-YiO28iFm87RYPUhycKjYxnebPrnrc75Bw>
X-ME-Proxy-Cause: dmFkZTE4BmMp7rYmDnwTf2XcWeoBf+E4JRNt1DSW/p/9VjngQGpU4YoU6hciCKKeMuY06K
    e1SfmzD2R3DjsHIVPldl166OfNNrxXJpzoEEh2bVMa84J5Zi5jl1EluHCYy6HbD8rbcVpP
    ZSEvSVd20XmKBpa6k8S3q1Cf7d2bnlVSFU9MGOj6nNFqWuchW9WtMo+Ctznz7F8NBqFJw1
    lxrJa2KrOntbmg1TIph9LQSw8J+pmXIy5ynbqxhgL0LEuadTOIOUyUWoIlv0Cv5q1M1kKE
    ocHQ8TUYd+eenL/R2a45OCu4CdR7Maz0C3EAKSMSqhMDDhkhgbrIhmz/E1FmJnzYP2xoPA
    nWWNBOzIGQH0quzTXdMumNleDa47zxVFjaH46nW0TNtVes9x2QMVEYujyyT5ODwNf8wc5R
    Cg1Qley2kl+bkjXqqydD9QPjRMNC2ggCAfhUS/HLB/DmtPAdEItxApIwQxaGteMnSZ/mt4
    8plRdcIcuN/E8QVO1ilBKzn3+vlvLvOK7ptJTz4JB2iqN6FiNDhuYWyr34JXiQScbJAL4U
    waa3OoI+sU3+rFsgdj5s1oBOSXZWJa4qS5WsscBA5YBac3CoHMya6yBUUpRCF25bp66Qh6
    i7a/2W2N0DI56d6KdCtMtVCBazrYDJAWkG5RDdm1gypIJDdX/ieSyA3WKMbg
X-ME-Proxy: <xmx:QgQwak2bU7_cRCfGBlqQTjPcIGHINOjLWzJyUqOyHmrrbBEV973K6g>
    <xmx:QgQwatCVVduFybnbA2rOCUvnhxmWDKYAi-lcnm6U5erW6krXQaOwqQ>
    <xmx:QgQwavPqOrvKZ8jhdhZyRB7lm7mu5nnwr4ey_M8UcPxzwEF_FwO2Ig>
    <xmx:QgQwaia280G7Yd1m_q3-lWWY_hsQ-SIe2OsrB8B85sBzMipRup0CPg>
    <xmx:QgQwasG1q5jteiFX2-xDLGscgdLkexyT4pxghh2zGJSZPqP1OqSlVVuK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:55:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ceea56f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:55:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:54:57 +0200
Subject: [PATCH v6 07/10] reset: allow the caller to specify the current
 HEAD object
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-history-drop-v6-7-2e329e536d78@pks.im>
References: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
In-Reply-To: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

When calling `reset_working_tree()` we automatically derive the commit
that the callers wants to move from by reading the HEAD commit. Some
callers may already have resolved it, or they may want to move from a
different commit that doesn't match HEAD.

Introduce a new `oid_from` option that lets the caller specify the
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 5 ++++-
 reset.h | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/reset.c b/reset.c
index 4bde5d8dc6..06f375f296 100644
--- a/reset.c
+++ b/reset.c
@@ -122,7 +122,10 @@ int reset_working_tree(struct repository *r,
 		goto leave_reset_head;
 	}
 
-	if (!repo_get_oid(r, "HEAD", &head_oid)) {
+	if (opts->oid_from) {
+		oidcpy(&head_oid, opts->oid_from);
+		head = &head_oid;
+	} else if (!repo_get_oid(r, "HEAD", &head_oid)) {
 		head = &head_oid;
 	} else if (!oid || !reset_hard) {
 		ret = error(_("could not determine HEAD revision"));
diff --git a/reset.h b/reset.h
index 38b2891b53..4c992ba671 100644
--- a/reset.h
+++ b/reset.h
@@ -37,6 +37,11 @@ struct reset_working_tree_options {
 	 * The commit to checkout/reset to. Defaults to HEAD.
 	 */
 	const struct object_id *oid;
+	/*
+	 * The commit to checkout/reset from when doing a two-way merge. This
+	 * is used as one of the sides to merge.
+	 */
+	const struct object_id *oid_from;
 	/*
 	 * Optional value to set ORIG_HEAD. Defaults to HEAD.
 	 */

-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty

