Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5222087
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732239971; cv=none; b=C55F13QxGYzitNyZxHOHVfGNSjIPrMhLMAGLF+G/+SdV5NP7/iWjDzL9L/Isj73wVo1Ggw6cVs16ZK7I4JQdZBJTJrcbQK3DkpIK1sVPaY+BlH3Jj8P8eCrlvyerDu/qV5T09BM6iSEJMZIYXW4BTcPLaB5oq2iKzGTrL54uTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732239971; c=relaxed/simple;
	bh=NdJY7r0WUJt0pbkvTBNH1zI+TG+F/AqvvqoCvOg3gwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b0YczaweYnbIF4WxXNvb7fSIfcqBDJMWJhH8WmpZbIWzOx5ra7mFHF5sdHP2jEBkrPfhluJk1HqssKCpDKbESvoS9T/UtA3abqevJOy2qzgJ9Ru3//PW7ZTOT9PHh2G5N1YShmO9PJTPj0mWeYPNrHeA8+Dq9CMaIfShbKI7Fes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4Cjh83fS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4Cjh83fS"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4CB7114013D;
	Thu, 21 Nov 2024 20:46:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 21 Nov 2024 20:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732239968; x=1732326368; bh=ShFl67tBHFIpo0RTUKEOSgnnfZsXFChetXB
	1orKiryg=; b=4Cjh83fSZzlViL1oYvoNBTW2vHGzI7mMCAJ24UAWF8THKyhMdkK
	tpA/BMRZd1fTsDlRSpAV6m0QDz6SXw9Rs0vYTFjld300AwkeT3e2JX3PT5ShR0+Z
	Vkc71Ca8M8iJf10JqqC8MF5K6pZH3DoUMobQVK0i6KSUipve0LjBtmNUIar07YYZ
	OmozHpRA2HlV/g9ktcDYKDntkbICR0Xz1Z9ijAT2CXC7zXpX1GGt670YCcJxKyHw
	tEr09+XBBksawGj4SufycvwkmyMb1MHZSdxSoPsR6lMruzKGOg16a15xsiHT3LzK
	jbu7IwW8s3lDkpuNIOReejBOFfGPZIP3hFg==
X-ME-Sender: <xms:YOI_Z2_ZW2mN3owH6R1P9DVPond12rp1m2dT6gR8uvn67XSUIi0Qrw>
    <xme:YOI_Z2tqv115aZG_NloDkvlQoomDQ96gk9o3Ub2eLR_jMQTLLAYDC_MJ_U_7UtGKM
    8ofoHwcnCej3udFew>
X-ME-Received: <xmr:YOI_Z8DJIMDcHAPDRU4jszVpE4EPWt47F7wW1MA53Tl4MChFPJC4x7uWecfGIgTu2JRZQ0azjW7hYDm6PShVLdfvKrs7T4nU-YnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YOI_Z-fSGwWseDpfcyA22g4qSkp2WiB1l1MOFvtlzO81Kspal9_Wbg>
    <xmx:YOI_Z7MajCdYE7linBJD4Vhrk20whbX3IgA6-RuR8pEC25SLKOLu7A>
    <xmx:YOI_Z4nMjg40C0pJf6FvqVtGFzGL2uc9a7Tqvx_IqQ5nv9U-TPZ0Rw>
    <xmx:YOI_Z9u9eU2lK-2pby1Y09g_Myk0oRLWFzR-eGfnXQmK8UFonPZ4vg>
    <xmx:YOI_Z0ra5h1bOFA_E1ltaCp9i08Xdd047MDLQUlD42c59zOVknabowKA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 20:46:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] fetch-pack: introduce `fetch_pack_options`
In-Reply-To: <20241121204119.1440773-4-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 21 Nov 2024 14:41:17 -0600")
References: <20241121204119.1440773-1-jltobler@gmail.com>
	<20241121204119.1440773-4-jltobler@gmail.com>
Date: Fri, 22 Nov 2024 10:46:07 +0900
Message-ID: <xmqqjzcwca74.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> When `fetch_pack_config()` is invoked, fetch-pack configuration is
> parsed from the config. As part of this operation, fsck message severity
> configuration is assigned to the `fsck_msg_types` global variable. This
> is optionally used to configure the downstream git-index-pack(1) when
> the `--strict` option is specified.
>
> In a subsequent commit, the same fetch-pack fsck message configuration
> needs to be reused. To facilitate this, introduce `fetch_pack_options`
> which gets written to during the `fetch_pack_config_cb()` instead of
> directly modifying the `fsck_msg_types` global.

It is unclear how it facilitates to replace one global with another
global that has the data that was previously global as one of its
members.  With the above I was somehow expecting that the option
struct instance is allocated on the stack of a function common to
both callers of the configuration reader (i.e. fetch_pack_config())
as well as the configuration user (i.e. get_pack()).  If we were to
allow the latter to keep accessing the global (which is perfectly
fine), wouldn't it be sufficient for the purpose of this series
(which I am imagining wants to call fetch_pack_config() from the
sideways and grab what came from the configuration) to just pass the
fsck_msg_types strbuf through the call chain of the reaading side?

That is,

 - fetch_pack_config()'s current callers pass the address of
   fsck_msg_types to a new parameter.

 - fetch_pack_config() passes that new parameter when calling
   git_config();

 - fetch_pack_config_cb() uses the cb parameter and stuff its
   findings there;

 - a third-party caller calls fetch_pack_config() with its own
   fsck_msg_types instance (presumably in this series, it would be
   the opts.fsck_msg_types member introduced earlier in the bundle
   code).

or something like that?

So, the reason for existence of the shell around the fsck_msg_types
needs to be explained.  It is perfectly fine to say "we'll add THIS
THING in a later step", if that were the case, but a reviewer tends
to start reading from the front, so the presentation order matters.

Leaving many questions unsolved tangling may be a good way to keep
readers engaged when writing a mystery novel, but not a patch
series.  Having to keep too many things in head, especially when
many of them are not explained well (hence raises "why should I keep
these in my head?" question), is another distraction and discourages
the reviewers from reading further on.

Assuming that the shell structure is necessary around it, the code
changes in this patch looks sensible to me.

Thanks.
