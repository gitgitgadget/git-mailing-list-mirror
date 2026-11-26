Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659461;
	b=YCT7DMdQP7rwgtPOpT7B8XvCQjSZv7PAK3zupWiVH61A0YFkFP6FamRTn31B+ZrjVTwY
	 wHVcIwhi2uP/tNSQWLxu5bw1c2nUFzqQC6URGzDGDImYso/NQt2QflEMu3mdAZBqIyqxw
	 F/xWTfrkZEcweVqhL3NiPgWcjoo8QPW9JKYODB6860SD/C7cZ26EpJlp7417XZEFACSTg
	 SHUvaEa8PSOCk8aBTcp0eJVtILsXwrZzALvEpxFaWIHb+YxTAX69w9dBivYSSumfvsm70
	 dLUI3iX/9H/0kmjl/oXaVA3aOYyHHQUqmQwojR2bkG4HK5zalEru4r54bYPvCZh8REw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659461;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=/QYaDlagZzVOksdQy+JCblr96XE/9PV4ZPoad1SHgCM=;
	b=KLDayU+YiS1CocOtX7nUoOH+DOA6hVt8SG96Hz5NaJlX/7y30zB/1xUyiC9UQA4FCNOx
	 +5RXdMeFf6jPlz4OXwHzuEW1DPLy75P5k8SClcge2IWC0mSc8zBaLPR8hLPzePEf75G6d
	 UmKUlJPUNmQVlnLGPn740nKOc5J3FAJCpuzeVT9IUkNtozVfmeug68eNcZivSjPhvCz+j
	 p3XJ+cw6ICPYuinKLY3dC9quNbOav3doY9U2B267ERgXFOWJNvVtbiwO7TOyEt6ag1nOS
	 SDZxUajvsBy5vinCkIZjJ9rxo6rz26VV2C8USzUSbKwAa+cX61rrYXvJLqniDAJjeYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="Cuaf/HHQ";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LaiIcF+d;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06380606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 02:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06380606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Cuaf/HHQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LaiIcF+d
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 514B01D0042D
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 21:17:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 25 Nov 2026 21:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795659460; x=1795745860; bh=/QYaDlagZz
	VOksdQy+JCblr96XE/9PV4ZPoad1SHgCM=; b=Cuaf/HHQDNe5mC9aAkCohY8yXF
	lyHMVlZQKjKXoKKZdqkEQagVNhck9lzSXW0u62RrxTgsc+dTLnbKYAfhGX0XaAZj
	wW+XyeSsv6tUH93qYmIDM7EWro0OxlGv61GlvQdf3xqe4FalyvQqKDN9dZksdnFB
	/isziOQG0pphJwACjlC0tMCSnN7yA3U4Pn3jE4iL8UCHbHEltlLyd7clg6EsNBAi
	0Z81slni7xly/o1PiVlMUUpSWC8zsQQFqseWfVuiu6fWQUsSQsgXt66/UexEi/8g
	w7iXp/Ze6F20G7bYHG5zFeNxnVEDXm/ohfJMNDPpimckLcUkHjIlYASnLfow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795659460; x=1795745860; bh=/QYaDlagZzVOksdQy+JCblr96XE/9PV4ZPo
	ad1SHgCM=; b=LaiIcF+dw9Rs1wH2Xg/3lduOSDlGyPKPHYo55+l+lVQKjC20xQj
	fYpHy1riUSe446X22h4kULNhZmmcTF1/M77iKW3jARHHZycb3UcU7aFPZHXL0olN
	25xsEwxm/MnzkWLz9fQABLPPEPrlBQY2Setd9S13WP63dZfElq+PWirbv6KpnsRG
	fGQJ7VEIN+7dwSPr0UVR8ma892OykBQeWe+/6guEKOoITI6brHL3fU7ZSQO6bCcr
	1hNNE/cD3NwpulnHkGQT8T21ojMYLFCT/B/99ZBZlBbFUPB9PEU8wGeDTpvpndru
	xiSpb+1kfmaBREuvU8kaL11++jq+dfBDZCw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795659460; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nOH4B52C+KLmwZcopJT0diMWxL2XHNpp5Vbw0BgUNL8qyM+
	Dx1gpjbSkbBtqnJ8iE5PxSHVmNcddSvC0zHnmSirl3lZwWgCbo9GWrjt+NuaKhm0
	JER/xl/KC93AzUC1QyhnFPZMJcFoTmsGr6HB5TgylsO+Wgk0PUo9VBLEgl8lkynJ
	r6cxzYlbbtsAM7KvnvqcycxTKdL00v/kJ7AVRxAbqHUq0M/4X/helhAwScU8ensl
	Ty+OgxQ+SHygYWHb/8+BDPyVJO/jZoZsD46/GO1EM0qJOJQQiK2LMYRYEJz5+uKW
	5TKNf38320wy8rHB3mypPQMoft/a9H2u/xXRvdg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Br1z3bAQJPXAa29gKPfxe3jYrbBJibYe2A3foHCWaT0=:R17yfg2VqI/RkPwnK3O6y5La2+jZwHnOR9BK2NAGBXA=;
X-ME-Sender: <xms:w5YHa4NamJjmTvKIXA4l5dKeNt5eRggt4yopWKUfJf9A0AwjXQJnSQ>
    <xme:w5YHa-A2XXP3jWBpFyK3u2g3lxbixOU7dS753Unh8_ikGAhrAK28ZVTydOvGxFy6N
    y2NGoOrRQVWYJjcQO7tC44tTvWD02fRTjZasPSgYTyv4-lUoFmKI3U>
X-ME-Received: <xmr:w5YHa1dbCkh5RFhJy6AjD1yli5VF-oBNIETQZ0Frw24j-sDrBUd-qxgFebLTxtTbDPjCRCB3rb13mKqH5ZmPU4geJIcqu8YySGkaCUw>
X-ME-Proxy-Cause: dmFkZTFlyYaMUqdCZRMH3Lsc/YG28IngjmPegVwn7GpziZdRSNAZ2ZNOVSaZNrPvcUaIe7
    C9gEbYEXgqDb3Rhd+F4TDllDlBnqrnpnO/1+NoWeH35rrzokb3+xibh8+WBJ/nGLGeZJWY
    yPnh2bwFFXChO6Q1mgwcb0P5O60rFUhgKEk25f360fu0mMEPl81ltQZUHoJVeXP5hbrkmT
    PRtYZHVJWHZ8Knkbk91DoWlcxnquCUcabtLxZsfvXVv0E5S8/hl71xCOMqk4mBYSt+umjg
    yZtz2xq+gmQNn3cnrmrhFJTczooZS6qYFOwMof961hqAtD2QQEJizr5hJrFE3qDg+oSLcD
    p5Zo7Lx7pSDHoL8zJs+fjkcSOE9NF3GP/0I/0t2IpwM0oul/uz//Nb710jI7WWV4AYYYJr
    hA5KoZXsSd/Zc9toW5uCpHz3PwwQBvEV8D4/8c+i5/oqCeEzZEVqa5fPhabic5Tusxod0f
    3/idn26u5FJNY9GEC5EwdPlnECNzi+jC3+vsF1w1Vh+rRjDyXzvvKxebJrpEPoggCwDeM9
    z/ntPbiK+ksHJFDw7jz6dfW/UYhpkta+sGNebf3DzGxBXvPrTWC3Fc2XM0ODsEN85lGZZw
    wDNV1k8TXj3xwUCwkR1cKGljbMwR5OLS7Fy3Z00JRrvjNESatP2q1XYZ4Oqw
X-ME-Proxy: <xmx:w5YHa9MrlhWrmlykGeqUtGBKGs-QYTjaNC2SVb8JxaM619ldfYDzSA>
    <xmx:w5YHa1LJEqXlsOJXvMgsg4203z4PRhu9mycn0QB7d4852ET3m6w9Ag>
    <xmx:w5YHa9JhL74kMiEMAo3BqHjhuwIM04D--AN6Wa2Ldjc4TiZ_XFxEhA>
    <xmx:w5YHa_6ialirlOHhtJ3Yc8pPHIEhPSElwGzZ1VCiQgB7rOEonNK_3w>
    <xmx:xJYHa64KdGIGtjTT0D_fu_ixouY4Gp4-vu2NzMhhjFMxsICuj8SEbLEn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 21:17:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Matt Hunter <m@lfurio.us>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v16 3/7] fetch: add remote.<name>.fetchRefmap
In-Reply-To: <f94dd7244335206114930d33b2bbaa577fece4f0.1795633584.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 25 Nov 2026
	19:06:20 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
	<f94dd7244335206114930d33b2bbaa577fece4f0.1795633584.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 18:17:38 -0800
Message-ID: <xmqqpkvss5dp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (effective_refmap)
> +		filter_prefetch_refspec(effective_refmap);

Doesn't it break "--refmap=" and "remote.<name>.fetchRefmap =" used with
"--prefetch" if you call filter_prefetch_refspec() on effective_refmap
here?  In filter_prefetch_refspec(), any item without a destination is
removed.

> +		if (refmap.nr)
>  			drop_destinations(ref_map);
> -			map_refs_without_dst(ref_map, &refmap, &oref_tail);
> -			if (orefs)
> -				*autotags = 1;
> -		}
> +		if (effective_refmap)
> +			map_refs_without_dst(ref_map, effective_refmap,
> +					     &oref_tail);

This does not check effective_refmap->nr, so when no refmap is
configured it still copies and frees every unmapped ref in
map_refs_without_dst().

> +		if (orefs)
> +			*autotags = 1;

This probably has the same issue as [2/7]?
