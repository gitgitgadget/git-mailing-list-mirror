Received: from mout1.freenet.de (mout1.freenet.de [195.4.92.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F4446BF
	for <git@vger.kernel.org>; Sun, 26 Jan 2025 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737896533; cv=none; b=f60+AMJwizLRFWIGDpl82As4pTyl86OrR9aaZ1A5oY71IvC2rvaUBpSJQjyMHZVGkVuMgRQNc7TxRK19RpxBrYMG+BCxVDA/aPu9chzk8FxlyXVxZukBKhSWM6F3i/0xHoS0ECDv0F71PJvBEPQWwzJMmudqpt1tfT3CK7wQLUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737896533; c=relaxed/simple;
	bh=cvqZL22NseIL9HKJQpm/jUeUF8Ohyj5wMVDC4kfbVuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jJ2miwJc5ZMRzv5darudpwBERVGN3z1CHaP1jUSE2iN4+0cAAqSQ1wBKRwjYXujAo6dUd0cNrBG7SnbatPhYTVd3PPLESetmOUC1ObvO03OtLxPm6DjgzsDi3Jc6bM5nnFZIIvVn1LKjPreUjLEi0KUtV4+PYeBf9qI9BP/DGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=BwOodLvL; arc=none smtp.client-ip=195.4.92.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="BwOodLvL"
Received: from [194.97.194.51] (helo=sub1.mail.fnrz.de)
	by mout1.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tc2CB-00E0gL-8M; Sun, 26 Jan 2025 13:56:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=77NWFjCv9EfVaWoSET40rZC+VmFoiqcfKb4hBhZTDIE=; b=BwOodLvLupq5bfMPUjUNPj80P0
	v+RI3tbrIJ+0TW/iLnVyxjyzd0MOK6ggqaaBjjM0yf7vPJSXyS/7SpXwN0Yy7/lSzOOH/wFv0m0eO
	epZo20XxIbAz8D+vUlGOwZ4M6f93XdUvk/URg8AGR7/DQiH2LwtWHMY2vWUjoZQovCwNvWAnIHCeM
	EWx1f6Z6I2UUX+6xm/7nmthO2RVVbKT8w2URVE5ROhvz+XLdRPrgyxFmTstTNQSU/3j49Ug5aUHnl
	rMWCOJNBU+0NKTIBjyx+Ckv0h0HeymVxEPHAsLmeUOwnLDvCtbANw6eYaPk+y3DI8CdrJYpcc7sHs
	XDPcGcTA==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:50262 helo=localhost.localdomain)
	by sub1.mail.fnrz.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.96 #2)
	id 1tc2CA-0095sc-2o;
	Sun, 26 Jan 2025 13:56:59 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH v3 0/4] Fix type conversion Warings from msvc
Date: Sun, 26 Jan 2025 13:56:34 +0100
Message-Id: <20250126125638.3089-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.5
Reply-To: CAPig+cQ49Hdc_8=mRhhJDTny_Kqo6Wg6Nr98rsBN_YXmBrQ6kA@mail.gmail.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 173789621822427D6DA904O
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!50262
X-Scan-TS: Sun, 26 Jan 2025 13:56:58 +0100

Hi everyone,
sorry for my late reply and thanks for your suggestions.
I am trying to improve this patch series.

Sören Krecker (4):
  add-patch: Fix type conversion warnings from msvc
  date.c: Fix type conversation warnings from msvc
  apply.c : Fix type conversation warnings from msvc
  commit.c: Fix type conversation warnings from msvc

 add-patch.c       | 53 +++++++++++++++++++++++++++--------------------
 apply.c           | 37 +++++++++++++++++----------------
 apply.h           |  6 +++---
 commit.c          | 12 +++++------
 date.c            |  8 +++----
 gettext.h         |  2 +-
 git-compat-util.h |  7 +++++++
 7 files changed, 71 insertions(+), 54 deletions(-)


base-commit: 5f8f7081f7761acdf83d0a4c6819fe3d724f01d7
-- 
2.39.5

