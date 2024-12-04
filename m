Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB63618E02A
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733344820; cv=none; b=EArycDNiTJ8hMBSzgkRfux4d5tSoXwtZxYRfTIFdpyZa8eg2136H4LZ7K8NNg/7gJpKFMpG5vKaa8AQ4DoBz5r2EfBwGpTjIaXVllp6QkZwpH/XKB+ge1kXQkRIxuwHQanMlDKB8Scad0Ex6YwYS9SRaLoNvJpAh5EY2YhZ87oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733344820; c=relaxed/simple;
	bh=pitZ7FXgjm4JpQRGVP4uznRl5B3NehXSUH9DyPuvlQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kVZwbAXI6/jLrudWf39b8E9PEak2nVwP+dxGem2h2rmkME6IhUfPzuilpHnR5MKgSwyl50CNN5/THH9oggblk2dnSgmyO4Zu7yJBKh4zXRTyATW6dLYjty0axr4UGxNywrFpRnvPc0HjMVHo7YKQ6eDyCO7PIZhpU+b0vHrbXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SZhWyfZL; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SZhWyfZL"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C1A101380701;
	Wed,  4 Dec 2024 15:40:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 04 Dec 2024 15:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733344817; x=
	1733431217; bh=6nXCfQrPO/zvRmIkjA27yc0kTeiDXJYs8U3FG0mLw/8=; b=S
	ZhWyfZLZp2XHtCCbLERTVHAMfKp8Myq+8lH+vpsiG7mMmug1MNGBKNbfr+ni14M8
	d2WuQANJCoOVyEv+9qglGg7WXHC46JbLOnLh5KHKmxR6PU33rw8Xz0r5GuOBRqaL
	04oHmABwTFUCmvnEW8ZFwyhPSG+iQtmDIb6Gpu25QV3pc5w0eYiht+Yh7ByxO6Ah
	wYJoNj5Lh0l6CakDFnMrcxuQnAMmL00/FQbUp36wH7rvSc93TXXjTCDuj3R9TCcq
	f2zudRHHYKPnVg1iOAFNLfDXDo0tm/BlVqHr031EZ7TH6C37xHY/xBt6xG29iOOi
	WREfx4nqrhXslebk7NUtw==
X-ME-Sender: <xms:Mb5QZ_5nqZhbjVNmvLUu6SRYVgcqUR2rUg8f3H_ZHcVAGR34Uf4hVA>
    <xme:Mb5QZ06XrZ1eJrYczpXbQSPLZWlvCx0ABYlRiqtSOTV6XZVXAoOFxjtmtd8_c-2T3
    ZTTZp8ix30rzcrA5w>
X-ME-Received: <xmr:Mb5QZ2fYITDJ1arpz198pQipD5nOV3w0M60LzIUoNoeIW9TaT8511dFMMnVga9oaIgeXOOcSyQ9mRPJ_IRMrOSMrQiq2cjgkH7woUeI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieehgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggv
    nhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtth
    hopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Mb5QZwIarfyxJ6koFY6Mc7fQckZ8rba6UJ3NKtpcCAxAJanINLs8Bg>
    <xmx:Mb5QZzKjLQ1pMnEft5onoU40Uc_YvHwW0gkvJtEb231AST4QVUv-tw>
    <xmx:Mb5QZ5wEDOwVMKbGfwvhPX319UT6jpyFYPL3O6aarTwqcBfSlQqjOw>
    <xmx:Mb5QZ_Kvr0f9xEVyGSJvQR3ddSFzm563nbqZ6JF03KfHVRIKQanAdw>
    <xmx:Mb5QZwBm6_Zc_dAY46ohiWI6HbnRPFT8G3frV3PN4BJ3wYtNbv2mbLya>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Dec 2024 15:40:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Bence Ferdinandy" <bence@ferdinandy.com>,  git@vger.kernel.org,
  "Phillip Wood" <phillip.wood@dunelm.org.uk>,  =?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>,  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
  "Karthik Nayak" <karthik.188@gmail.com>,  "Taylor Blau"
 <me@ttaylorr.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v2 3/3] remote set-head: set followRemoteHEAD to "warn"
 if "always"
In-Reply-To: <cfd54be2-af8f-429f-a4c6-41f54c33c89c@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 04 Dec 2024 12:43:45 +0100")
References: <20241203215713.135068-1-bence@ferdinandy.com>
	<20241204104003.514905-1-bence@ferdinandy.com>
	<20241204104003.514905-3-bence@ferdinandy.com>
	<cfd54be2-af8f-429f-a4c6-41f54c33c89c@app.fastmail.com>
Date: Thu, 05 Dec 2024 05:40:15 +0900
Message-ID: <xmqqh67j2ndc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Dec 4, 2024, at 11:39, Bence Ferdinandy wrote:
>> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
>> index 7411aa770d..daf70406be 100755
>> --- a/t/t5505-remote.sh
>> +++ b/t/t5505-remote.sh
>> @@ -504,6 +504,17 @@ test_expect_success 'set-head --auto has no
>> problem w/multiple HEADs' '
>>  	)
>>  '
>>
>> +test_expect_success 'set-head changes followRemoteHEAD always to warn' '
>> +	(
>> +		cd test &&
>
> I think you need to `cd` in a subshell here.  See `t/README`, “Don't
> chdir around in tests.”.

Puzzled.  Isn't this inside a (subshell) already?

>> +		git config set remote.origin.followRemoteHEAD "always" &&
>> +		git remote set-head --auto origin &&
>> +		git config get remote.origin.followRemoteHEAD >output &&
>
> Nit: maybe `actual` instead of `output`?  Just for uniformity.

t5505 is already heavily contaminated with the pattern to compare
"expect" with "output", not with "actual", but that does not make
it a good idea to make it even worse by adding more instances ;-)

