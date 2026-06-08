Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF41E5B63
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914217; cv=none; b=eOKW9hiRCejFJt+bZ32J63q/FZVWItGdEpzrMwJQVsHCbSN7lVJheJovl1bzS+AOBEdQ9t9g1RA5u6dAYlrUwa6SD64o/Y+IdI8uFPiPnfjNHdO3Bj54CTLizRSkk32gpES3a0m/pQTdfH57Nuxennon5C0aOwJJyDTnKtInjQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914217; c=relaxed/simple;
	bh=YMygs6rfSXyaV81lc8SIJpPQYJn2XRvIK+WIXcvSU/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PVQ2mqC/OcSqgZHeuFvTwSwQS2bW9w22ZT/oJLtgkIxVdxl4iWN+rdHYjTt5QQuKR1XKhqRQD7+vkroKoAuSMB1VSj3BUFVNw4jHb8AEZP3cviRivrxiyMr6tW4DfXn9MVjakZ6QTsYjTtWr+Q8HcNMwIo/OfcXeHPiPR1I9s2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YF5US0/J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SiM8rwcs; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YF5US0/J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SiM8rwcs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A3B767A0118;
	Mon,  8 Jun 2026 06:23:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 06:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780914215;
	 x=1781000615; bh=cwdGN4YwXSF9sepNj3eUnXtwa+Calpi9Xg/4hQ79ROU=; b=
	YF5US0/Jd9PnEOBmmW9q69rghuktEvj/Jy0wzYK0aN+vkSoZE31Nl5Wn8fLkcqwu
	Hnvrwpfsb6nO4zBCnlNTu21K2LVm+g75iAaMCbPPAY13JfgKg3dhZrOFpO5O0LaE
	sA2h3btVNVAjxfvJ311dkCo6UcErWXjJ68Pci4nGkdiVmGRW4DO7hs/ISYa+Tv2h
	wtQ+6TrnLK6ZLyDYNoLb5JQKUlqvFkLCIbNpMXlV0tJcnm+8mNX9fyd/UxiCgdLZ
	d7M7FUrZX3jI9TFlLxbSqk3yJicRgRgxBSxLn1XPBCpF2VShXZ9ft5qANUoZWa7a
	eYDX3CSWRNkqEaNOTpgHDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780914215; x=
	1781000615; bh=cwdGN4YwXSF9sepNj3eUnXtwa+Calpi9Xg/4hQ79ROU=; b=S
	iM8rwcsRnuZWOWdKCEZ7JJtVtJ8OmKsb9flzjw+aGsQ956bst5i630HaklUCUEkn
	SjYYR1GOm6uNWaKZs7iZbUaDhZm7Ijk8ej5gMztR/ptv7Yv7P7bbJkD4+s0Yi9Sl
	ftweks1PEHzk86id51qbl/9/rLzZlXqXv5ULaVZxrQufrzslpb6cPUzqADylCsMt
	c8oXUHB4GE4V18Rxk9OU5UuFEZYNudC0YuZM60nZuokHy6pTUENlDiTJl1jNqRSa
	L20D+GgdeAqj99bnctLYZKar+gx8J+DmOOh3uesIUQoPtpQ0fXzxQMHfhrs9v2o9
	/Z+c9QBHPdi7mYeiJ5CIQ==
X-ME-Sender: <xms:J5gmaut1KiXzamLaC6QrdLPHXNfadqXdA_pcjLK0N89fZAB_7ZNMkQ>
    <xme:J5gmak-BSv35C4xRsEOWVv0Aw9La5-zFTWGo81eUUwQ5Q6oMoOL7G6vNhyD6OcU1Z
    HxckyZkjlAcr1fQ-n1KIU2bP6HIzgYGFRaPCAy-PV7MrjxHcehx>
X-ME-Received: <xmr:J5gmap3Fz7Q2GWwREUH8ZfCXsnUI_-hZMDuhK6d5R5I58-glNy6VtkX4fQ5yTYjqQNVl7LVGUdHlYriCspCV1bJ9Ne9_407hpjSI194Z9A>
X-ME-Proxy-Cause: dmFkZTEU6CGo3vgRKOUy0NKAJj0qncnb+S3chfDNaeW9f7h5ictXCkTMmbzsA1bg+OqO5t
    VoN4gZ8DE2bMSNg0gKHlrcoGOrBSILyou8tacVmnF15zr8wO47F34BCKbOUToGnhrJDCke
    BuycNX2jBRY83y6KuU872VYl4KFCFPuj4/RU5I0flJJm7GMsjxxfUH7pW5x8WevI6FajEy
    HqZr4ietzymr2hvqu2TTKDUNt+8cx4slMtibdFncynERefQ9+isUR9VbS9B73SaPMRa3pu
    z4dSFOzBZjFAGJnsuuWgnRAVgiZUR1gYZTCdZoQ3btYVnBCPL1PuUzpm1MvOIGiJMY3uLJ
    MyOokQpbUyYYFuq+C/HvzlJYkXbbnL0DuFMhI2iIEW12MIAOAslqQdg6uybPUWbJIWXdlS
    kKKAt8WUdEgB6sQy+44viy7h+ImI1/WLn/J5y3Pm9w33VJxgDf4Ar7iM+wFaiGjHnu2476
    tGcQeuaSQjsxAFr4G0kSnNqMYGgoaHvv88N7stHYdyarZot2Nuw43NHjTXnuG81ZQZ9XUg
    Ha5/wVIkSzv6mqVgw6nXI5mWoysAILi54EEHpNQra+7fD4z/w01Cvaai3mvCrdMKn4gjtk
    E33nxeYd4xlMY0aX9pX5Kf+I4hkkqvaXTQbFDQTzavdPJdWZ4tYKQx8ybKEg
X-ME-Proxy: <xmx:J5gmapCLuv7UCAOsN8ySt_be7Hk8kTRZIbfpn7cWC5c0My5KYrqBVg>
    <xmx:J5gmalcUyu17rspIbIi0KW9tnGTBhVrBzwpYPTIQ3L9BQLuh-1bQDA>
    <xmx:J5gmam4U9vaYvvFCQA-Kq72D3SC4ZMBCKYZ126WjMO4RcnWqrJz92A>
    <xmx:J5gmaoXhTL-TLqRrrco1Swh81lg9VKlJeUDcOm7afXHnkvx4ZgeuTg>
    <xmx:J5gmarTnXu-xouE3KiDOpjTZnskosKL3WNo6aS9nwGdiXoJT3QyT0SAd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 06:23:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8262fe54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 10:23:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Jun 2026 12:23:25 +0200
Subject: [PATCH v3 1/9] read-cache: split out function to drop unmerged
 entries to stage 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-b4-pks-history-drop-v3-1-84ca8e43e937@pks.im>
References: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
In-Reply-To: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In `repo_read_index_unmerged()` we read the index and then drop any
unmerged entries to stage 0. In a subsequent commit we'll want to
perform this operation on arbitrary indexes, not only the one of the
given repository.

Prepare for this by splitting out the functionality into a new function
that can act on an arbitrary index.

While at it, fix a signedness mismatch when iterating through the index
cache entries.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 read-cache-ll.h |  1 +
 read-cache.c    | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/read-cache-ll.h b/read-cache-ll.h
index 2c8b4b21b1..71b87615eb 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -309,6 +309,7 @@ int write_locked_index(struct index_state *, struct lock_file *lock, unsigned fl
 void discard_index(struct index_state *);
 void move_index_extensions(struct index_state *dst, struct index_state *src);
 int unmerged_index(const struct index_state *);
+int index_state_unmerged_to_stage0(struct index_state *istate);
 
 /**
  * Returns 1 if istate differs from tree, 0 otherwise.  If tree is NULL,
diff --git a/read-cache.c b/read-cache.c
index 21829102ae..799a5bc719 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3403,13 +3403,15 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
  */
 int repo_read_index_unmerged(struct repository *repo)
 {
-	struct index_state *istate;
-	int i;
+	repo_read_index(repo);
+	return index_state_unmerged_to_stage0(repo->index);
+}
+
+int index_state_unmerged_to_stage0(struct index_state *istate)
+{
 	int unmerged = 0;
 
-	repo_read_index(repo);
-	istate = repo->index;
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (unsigned int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct cache_entry *new_ce;
 		int len;

-- 
2.54.0.1136.gdb2ca164c4.dirty

