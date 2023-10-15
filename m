Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E08185F
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="PkjZD9tO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SEEHvrt4"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CC1D8
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 01:00:44 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id F30165C029F;
	Sun, 15 Oct 2023 04:00:41 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sun, 15 Oct 2023 04:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697356841; x=
	1697443241; bh=1GI3TGT/jVbrZsb2J3geTbyDbHMYnOUBSn5SAuJIY+c=; b=P
	kjZD9tOxhQo5QZe9v+zz9dhE+OP3lBeCs65Xm2/0o0WEDmM2NeJs8N1TqOreZavj
	+5Bih49PjBetQcU8CSJzp7JDRxGC0A68PuE7ymjddOAJOHwJaPl6E0P+mO7GapaG
	zF560oq3sqOjuqDcabCP+6MxnGU5WoH44eRHCQD3NSR9w1AGgKle3CEnxFp4Mfkp
	O+O5ZN+yjKfhV8wMfSJb34v3+x7zpkQXrezM+tNY+w5gbI7uOiPLfsfin/dxm9qe
	gb83P/5EeXXZTXOi6pdDuQY5HDfbscLPOc3hqSloI4wn57+E/M5k4xXuYesu3XR0
	wk0CeTa7xVr9PVwF/Kg8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697356841; x=1697443241; bh=1GI3TGT/jVbrZ
	sb2J3geTbyDbHMYnOUBSn5SAuJIY+c=; b=SEEHvrt4KwRcOhkzeno9VhVOcrtVS
	tK9Od7vKTxO34Z2g8CbXVZ/qm6E4toQUR0nClwM0EWMNCM9xkdTKmZIb0Vb9yHj+
	besm5RNGt9SxbvKBas+tPTb3jQfy6gGj1c40aXIDfEPMKkmcNApyenoxxvFnZBGn
	R/jVHo73sSa4cbIAuIKYrQuFFI/4F/SCO+zd1WGv60+tZl9GxN1DrtDKV1zCwsV7
	vefuAlPgErqAA+CUmEnw95/JB5IYy8PAMQV3BLrKNrdNR6RZOgrJssRHLD5OLFia
	d7j4Dde86LS+S9yTpf63bBOSE0+2Z12Z8iNuhR78rtifOhIYhSeMsreYA==
X-ME-Sender: <xms:KZwrZWPmTZda8DnLpBE6_CYuc7sq7bPxeoudeP7M_dwxGicXvUpQ7q0>
    <xme:KZwrZU8mYu5TvfwRqKGyWrXsDJTWKkSPok5hGjRJ1NR8n905ey-JLwvxTHZHAA7In
    JWBhPfe2pwUuDKWoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dtkedtjeeiffelteffheeiheeufffgheelueeftdejkeeufffgiefhgeekffffueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:KZwrZdShaXgMdGU00RvP2YtCTjZrj-FfDpnBCEkFzohnTFQnAeRlcA>
    <xmx:KZwrZWvLsXiWxIHNx5IzlVm7IZmitB0dgyw_ldQ2GV9ZCsdaQLHlYQ>
    <xmx:KZwrZeeCXa3fan0alPXpd6yHbqRz74XIr-gcz6Tq12y9E01zkAyuKQ>
    <xmx:KZwrZWmlEVlDlha3q3WjY8pgaE47fKtVAhgNtObo6GXnJroIqNC92A>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AB96915A0091; Sun, 15 Oct 2023 04:00:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b953efce-da38-4dbc-9032-985481f3d721@app.fastmail.com>
In-Reply-To: <20231015032636.GC554702@coredump.intra.peff.net>
References: <6bb48aac-460c-4d7f-9057-40c3df0c807d@app.fastmail.com>
 <087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
 <20231015032636.GC554702@coredump.intra.peff.net>
Date: Sun, 15 Oct 2023 10:00:20 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org, "ks1322 ks1322" <ks1322@gmail.com>
Subject: Re: [PATCH] grep: die gracefully when outside repository
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 15, 2023, at 05:26, Jeff King wrote:
> Is it even reasonable for "grep --no-index" to care about leaving the
> tree in the first place? That is, is there a reason we should not allow:
>
>   git grep --no-index foo ../bar
>
> ?

On second thought yeah, it doesn't make sense. We are outside of any
repository already so what does it matter where the file is relative to
the current working directory?

It seems that `pathspec.c:init_pathspec_item` should let you through in
this case.

-- 
Kristoffer Haugsbakk

