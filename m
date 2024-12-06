Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE71DA0ED
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483435; cv=none; b=E/VLWG5Ly6Q7/bWlh24LR3/npx8LedS344DVw2FVq02gqfS9AMrc5A/WHLSVTzwPpDp1R80I3PqFMzHGkb4YyDJCgNjZZuGKSS1avqM1FNXKtiSCYZVdjJJHn5vUp2d9ZBSJJC3kWEVFS0TD4mB1UwYsCngJwo7RGGkBYQhU/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483435; c=relaxed/simple;
	bh=/fPSMBQRI4/hyM+oil+aXJ5+p6+tRsmR7CCvatq0MVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a6MrRDzk98l/qYcOkb5iVEtHhRwk42ysb/mUGSmbcPt/0U9EjUKPe9x9ShxIDm4/ZRNVLYXnhHWvxofjwgtkeMFEDWyWuMcsuKlUOpzvYZKFnS/o2JziMTtBwBxuAZZHtUspWobkGyFYBy5e1BnA2XUgYwBzOJBKMeq161m2/3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=reVBpsNo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NC4Y8eM7; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="reVBpsNo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NC4Y8eM7"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5AF6725401E6
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 06:10:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 06 Dec 2024 06:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733483433;
	 x=1733569833; bh=+/EFK/EHv0Sv4d0xiYwgFcjRqRH31A5hY8d21r+hMts=; b=
	reVBpsNor0061kIzqyHOn2p9bYOEWdNMFuebg2GUMR0bZhxXlMgM1tQUPbxtK/s4
	Gb0KtIrLcCancLZE9/rQYm9l2RrMInWQKM1sot5VkDquowkBej2H/2f0p3wuuHwN
	ca5SrhIxwuWm54/cNFHVhOg8MWnZuD3JOmu/uhfvmPYJZIy0+9Kpmx22f4aeNQUp
	Y/nuu3VGn1w3hCCTB9OOyS9Rfqv2HWxT+jr9BmiTjMkXAPW76WnneU2/XiThUBml
	gP4FAYj61CfaKx3JjtlD/WKODO1Mf2q/byfKnq3onfZoeeAWCaSNC9YZNLvGCqXV
	O0Yg8bHlBW3y1OU5B4OZYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733483433; x=
	1733569833; bh=+/EFK/EHv0Sv4d0xiYwgFcjRqRH31A5hY8d21r+hMts=; b=N
	C4Y8eM73eWsKm5QHenR/xXbwKYB7ibSC1IKjmnnOzUmFgrErTac9Xb+u0q3F38X6
	T8QD9EkRLGLMWLGNuGxN3WuIO7GHrxQix3Q0y0Gg0Bn0YmHuEbhVJsRJ2f4UoKxA
	Qqzm/FlGLLJ/zLkBnSVw/3D91v02f1NKQSteuK6Yx4hHf3HWR4AH0c2CjyiAWShT
	qqrLFH/ZBmGTmGPK2f+gPF3uAavQC3iErBjeVaVeeyTscLfq6L77/8Gv0fU3gdy0
	Qzg3YLpfZshFXLPx+vLSex/y7lK9t9J5WHKaBlOwpputgr9eBlUl1CkuZR6B8+1m
	+zsDdhcKxkNjvJpn8OxRg==
X-ME-Sender: <xms:qdtSZ7Po6Yr5cMocyq4L6txIEBr4kSX26DVRZ_HJUKk0kxBBM0GABQ>
    <xme:qdtSZ18Co1Nv7ZPjDAtexijUjhklH1c1ZL-EyORZhUvB4u67YniZf2dqMynY4LFQy
    MOnIYtSFyFoFNFmpg>
X-ME-Received: <xmr:qdtSZ6S0fZk3nMMGN3K3luN7LbFcYG-gzqMmhtCS8AD6_DQCXKMgF6Fa0Q_vUlEpRp98CWec3orF7W2EOte5UjeRjblF4HSgATEnxXyH4IF4rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qdtSZ_ut5E6gY5-ZYdpw3S92UK1AtJR0-0j7eSwF4WloZrBtM3Ipng>
    <xmx:qdtSZzdaVVVXzjXwrigNPV_na6h6yDQj0DeQtLShUbz2TKfQuybvEg>
    <xmx:qdtSZ71v_2GruY2OMBqJXY5Pyl3L67Jd3dnhwl1BjKHPQGzMJU1zZQ>
    <xmx:qdtSZ__y_5LL87L-NVYxvKVd_7TwKKBQPsoBGYDkA0c0O0wSARHLpA>
    <xmx:qdtSZ7FdJ1ndW9ONgLqC9K08Nq8ZzPY_OnRn9k0k3WBM99QJqGM5prfA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 6 Dec 2024 06:10:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb4d49d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 6 Dec 2024 11:09:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 12:10:14 +0100
Subject: [PATCH 2/4] ci/lib: remove duplicate trap to end "CI setup" group
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-ci-section-fixes-v1-2-7ab1b69e3648@pks.im>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
In-Reply-To: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We exlicitly trap on EXIT in order to end the "CI setup" group. This
isn't necessary though given that `begin_group ()` already sets up the
trap for us.

Remove the duplicate trap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 930f98d7228166c37c236beb062b14675fb68ef3..a54601be923bf475ba1a9cafd98bb1cb71a10255 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -56,7 +56,6 @@ group () {
 }
 
 begin_group "CI setup"
-trap "end_group 'CI setup'" EXIT
 
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.

-- 
2.47.0.366.g5daf58cba8.dirty

