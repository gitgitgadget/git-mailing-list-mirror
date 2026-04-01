Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCC93FADFE
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042678; cv=none; b=s455R+McKhVwvPMLW1AENAPYm9cRx1XtFA2ntAU6bwDBGHogWO6ElU6V+WhY/MSRXShcaXeH7P5Av8qNVp7jUcpk8gepJOK0KM/GV4bJdrbw+rxp/orY0TE3IBI57Sms7T8/5ttDKgLKoR7wmzrq2n+ELsLhMrK1bq9zPK71i6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042678; c=relaxed/simple;
	bh=wiFmVUHaJXd+aX94NRvbxZDpbc7Cxv60B35GMxiwVk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJOiYurQg+iiEi2uIfewI9H/TMKoU2yHui2Jhf72c+61OtmplEBy3eZt8147m9XICwq+8YWU6hSIbavoqGpJm49kZzr3TxwU8w11ZeebROl8BmP4zwVN7sYkho4cYyFzmTeax/M/97Gu+QPLKEMspiQay/vQfOdsIEumHYXGXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UwskNdGj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kKw3ys8T; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UwskNdGj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kKw3ys8T"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 85E447A032D;
	Wed,  1 Apr 2026 07:24:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 01 Apr 2026 07:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775042676; x=1775129076; bh=7br+KP/oYg
	GwyUvf/8y7zrrEyk3MGidNdfWTVgM53CA=; b=UwskNdGj8Kki3/jRRgkJmxTseP
	66VtDsi8J5DSReCu7wciU6/k8V4VnG90pdqnYy/QlB8DdSC9j7kg0ILLS79niyEs
	fbnktgjQ5qducLIPflpKZwz228i5ZvkZJ777Vk0TAD+mlHNi8UaTcNMl+0L7514C
	vjgUSIrPjmg9Fs1qF1CtvKyR8jamLUqgceK4ssTNstNS6nbJ6axRN1EowZJ1tqyr
	ALFNimNF4UAiuXC2m/luewOIO0ISI4DSlRlO+MyXgry4IupKP3c6vt110X8xuU71
	xLFGEPwQ7r40IwaLWjMYI0I2TuFOLwRzIUfJCjTOz+62FN9PQn5kRivcmCOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775042676; x=1775129076; bh=7br+KP/oYgGwyUvf/8y7zrrEyk3MGidNdfW
	TVgM53CA=; b=kKw3ys8TQTxI8BKAeqw4c6839k3xGSAQFrkhuhhD0O+XFBe0nuv
	HGDGENFNv32uX/YpV6aAu40l4fRfJccwSx1GO3sUTTOMfJE8Huujtr/plvNHN02k
	IbBpZReICbvy7mSmeLI1bfMgcz2Ibalr9bphVuFAgz97UQFTcKz7II6h+lI++zXk
	P+jcYg/V6NDQfTMLyyELStTO6LLy5mmfrKLBhAgy0w5yEMX0vGUaCbvz3Bd8Wj0z
	5dkiYHM/sMcMbR8wO4ROM26QiKwYDBOfCQZiiHn4ZzkdzxdW7OaOKTknAk+jHMsr
	hAgIFOAOc6ywfzKLyUs5T6NPywvn8iuAyIw==
X-ME-Sender: <xms:dADNaSiCVvRpZdq5GuM9qhMsLIK3f95n-QGJfjDaU90Z9H_u5bGRXw>
    <xme:dADNaadSdyBa47avEYS6hQVBp2WoyCXMncHNZ2t-49pSkzi79XIgJRwXfcA2I53HA
    7vt5D6I4p1xnxf6ZMOKMXu9l7Py4nkEKML16IiWSNlzrY5JXyldVjc>
X-ME-Received: <xmr:dADNaXdDgj8bleaQ9s0Ljczthi7dkXINn1ROGPZ963BC81Dl4nD2Riq8gwH_3Q4ry25iodexEhK_-H3H3CXEHIscJuTcInPK-MrWtga03Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dADNaU8nkl_fjg0DNkQaKIb9BWVKCx1H-i06zBBmXRjGyWOVxP7gMQ>
    <xmx:dADNaTkywSmqs6goA9LxpmY24Yzf3S1VHXX6QWIHaLTgtRWNPqZNzg>
    <xmx:dADNaW8Zfx8YQFz1TOzesmqjFS2jTN1I_YJq09W27C0c0WuKEZlx3Q>
    <xmx:dADNaRmYHrzXNqwb5f7rbIuR051TuDMOG5CDMrKtzCYdNMg4x9le9g>
    <xmx:dADNaaczAYkfDwzop-Y1esZ_gbvxfsIVC2o8jXlG3ytBnkNZ9qdAeshf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 07:24:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a366b2fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Apr 2026 11:24:34 +0000 (UTC)
Date: Wed, 1 Apr 2026 13:24:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/7] odb: add write operation to ODB transaction
 interface
Message-ID: <ac0AcARmeRamQ4Cy@pks.im>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260401030316.1847362-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401030316.1847362-1-jltobler@gmail.com>

On Tue, Mar 31, 2026 at 10:03:08PM -0500, Justin Tobler wrote:
> Greetings,
> 
> This series lays the groundwork for introducing write operations to the
> ODB transaction interface. The eventual goal is for all object writes
> performed within a transaction to go through this interface explicitly,
> rather than implicitly relying on the transaction to reconfigure ODB
> sources so that writes are redirected to a temporary location.
> 
> For now, only `odb_transaction_write_object_stream()` is implemented and
> wires up the existing logic for streaming "large" blobs directly into a
> packfile as part of the transaction.
> 
> Most of the patches are structural refactorings to enable this, but
> patch 4 introduces a behavioral change in how packfiles that would
> exceed "pack.packSizeLimit" are handled.
> 
> Changes since V1:
> - Fixed some typos
> - Improved error handling
> - Removed unnecessary guard statement
> - Documented in comments why inflated object size is used to approximate
>   if object write will exceed "pack.packSizeLimit".
> - Updated `struct odb_write_stream` read() callback to support returning
>   errors and using caller provided buffer
> - Updated the `hash_blob_stream()` function signature to operate on a
>   `struct odb_write_stream` instead of an fd directly
> - Renamed some variables/functions for better clarity

Thanks. I've had some smaller nits, but overall I'm happy with this
state.

Patrick
