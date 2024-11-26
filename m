Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D64BA27
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732583513; cv=none; b=Qcw7iKRHOKBBC6l8UXVGdlLOmu3A9qAAMOPteKAJj2zl6h0e7rdEYtqURLEZylXq0MD8yWYN3VNfcMk/iaXoOk/PjwdLuYbY+/aHCZDIQDSszZvo6s5SH1S0ztzkSJZ1CkA8lrzOiEH7NBErtCkI+m+c3FI8aZvldNXkUN/wwI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732583513; c=relaxed/simple;
	bh=iV0pyb/IyvsleHMVt1lgNnpvYOamig0YmkjdBgBSObI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t/cX8+nwLEacuNGmAAGEw4ds9dxgiaGz8GY7xSCCycMeGF8Fh0GuW2kbqFv1G/2U/ZZOtl3d7DR9vHNe+znmVWkeCLMLExsb/LcDBQFQM4paRfvxVqT8fbZpmpK3SNAky8FKH2vfJ6VNa3HPHZ3YjNAH20SCijqTHU0n3NwW67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ET6+jBPq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ET6+jBPq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 59FB51140138;
	Mon, 25 Nov 2024 20:11:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 25 Nov 2024 20:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732583510; x=
	1732669910; bh=MHx1LTi95jbIq/7gCp2pjWZe05OVk4y1eL5WnVpNIkE=; b=E
	T6+jBPqqiyq/lGIt2na45qRQrZTAhyE46FGctbFAO3Z6Hb51+Qdyh0GAnaMsm2WF
	Gtn/VlvVUjVRbonhlWpGh5Prbat8qSRKsr5I12oW3rIWe35Bm8Mc8H4KJQURqwed
	gwSJIj/Nq6Ps9fcEbXdFHvRm7gc8l0dHpjTMtfOAd8OOG+n0ERX/wFm3SGFWVT/Y
	YzRJJFdy0rMWDuFAX/BB8UEtk/6qvGgPuqwb8scb4MsVnba64OJZUCO3ARkdsb5z
	SUlhE5myjcvOBOnve4hoNp2Xo+Sv2uVUG6obDEYruqdNEwdTp2xw1FbW0nMvQXyq
	kHFTcXYINmDuhTlW3np1Q==
X-ME-Sender: <xms:ViBFZzH1nc5N7WZFXxXum97AnG21di3oybWncZGT5lOtm8ZrguluFg>
    <xme:ViBFZwWIrbJRa8s_M8Vq7reOthFngb7ouHjgntvAKYexWL9eVBSzpM18Tz5f7LmsE
    iPdIRnSxzs-f09mMA>
X-ME-Received: <xmr:ViBFZ1LAE675VKjTtpxvuVuWHCavLr3xmhKMdeR2G_jq5jg7DH-tgUsIMFXM4TrQWZYrsS-4ip6QfPdnCh-_cPpfbsKJxru0V_NA13Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtff
    dvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddv
    feesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ViBFZxH7rYnBdN4gZtjrLV1K89w2mRjndwv-2zkCTGOAnDqoKFSL3g>
    <xmx:ViBFZ5XwlFxfANoz24X1VM5QTGTA48AoqX_5XPeER5r1rhi_C8rurg>
    <xmx:ViBFZ8Pp0rucmzAwRgrSGlbTAnjfRsSY-VPr0BI7gJHsvRl_JC1KyA>
    <xmx:ViBFZ41LNIPj4FyypAhmHxxF7wuM50ojS9v8w3cjxnVKyHNCTCI-BQ>
    <xmx:ViBFZ4EdzS1w4P7oSQ6TxAKX7oHDXFlYXb58x_U5FC2K_2_ihSyG3hKM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 20:11:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org,
  stolee@gmail.com,  phillip.wood123@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v4 0/3] sequencer: comment out properly in todo list
In-Reply-To: <cover.1732565412.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 25 Nov 2024
	21:13:10 +0100")
References: <cover.1732481200.git.code@khaugsbakk.name>
	<cover.1732565412.git.code@khaugsbakk.name>
Date: Tue, 26 Nov 2024 10:11:48 +0900
Message-ID: <xmqqy1163ijv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Fix three places where the comment char/string is hardcoded (#) in the
> todo list.
>
> § Changes in v4
>
> • Use `test_grep`
> • Fix commit message (`)
> • Don’t need to cat(1)
>   • Also use `-n4` in case `-4` is not widely supported

All changes make sense.  Will queue.


