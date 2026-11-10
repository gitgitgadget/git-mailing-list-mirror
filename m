Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321631;
	b=CqEIIFWXgeOpyoQpFxSGZN9OGP7ZQD2wE+G1liVzIF8P4dJMTlF6MTK2jYkWjXICTEd3
	 DwScJs4UGWWPpt3B+GVJU3g9aaoK6F/RZl57x3LIqc/LoecxZ4w/mBDS7wqUnph+PTSKJ
	 /gLY4N+2r5SIMA5EzDU2sjwt0EWTmnsgXrqpBvFn6vJVPLvfCrdAMRg1ope3TI/Ds18P3
	 vs8lV5ldiyX3xSWvdfmsA3fiexukUVIyzETD53Dz4VbkQ0MEt4Mk5iz+P8qxW2aHwGjdp
	 n9Jjov89X3qH6UaO2VzzA6EZCzbCy1AubOo5/0GprTo4/qlx680HgTcGZfhDoI2UUlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1TX+7ST1jF1EHIVSuMiGOipTBv0zHK3+rMwd+XgEvl0=;
	b=UYtzqoP6Ra+ljV5zwrXvUSO+piKuaQgIZzIzsHO7jMpLVK4WWiXxjGyM8ARU+nmugj6B
	 oXDfE4JXsaw9aSe8Zjg9T7oC/r+fbuCfIesyxEBr86pPngMmQlJmWL0ZJxZk4Hy7HlVem
	 fxL+NEixlgfTYeFm2PL/XA8lQfFRNX2j2FeqgnL4bnW3S3fAYslzMnWpeuObq1a80MYQi
	 BWy+D8QVJ7MIW51ALXvvNBXe7ls02BqGnPm/ZF1A7osfEqImxXmkjSkQh9Mle8r2qGEOi
	 uYTe+b/NrNIxeZ6pOlDAeGmKZyr0rHHtW/7NwxhFyOrWdBKr7fExkKbK2sDgcp7ma6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dwB1zHq5;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7460A261D
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 14:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30E7460A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dwB1zHq5
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c43373ae89aso138213966b.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 06:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794321629; x=1794926429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1TX+7ST1jF1EHIVSuMiGOipTBv0zHK3+rMwd+XgEvl0=;
        b=dwB1zHq5RWphPG3Grf1ytm11530WBQnhZjm437UT8kC+bqy44C1triIAgmCel6nyN0
         mqvDjoQ988yc1P9pZ4bCPLExbu4O3OSQTysUyswHWdvzbfbm/rX0TJRboAUK94dHt1CP
         7FyDlWP27IVJ3t2gTxFKJ8oEHl9Z7zS0xPht1s4Lm2xAGL2Nghc26uxfynNHjtZaL/bh
         HVBAgU6abIx35F3efMkWiqkNBuLbQzezsrbe1NMVSoia21wZCUyC3mbW4eS1Dio/VwWd
         U3wuR6VZcMcKBBFk08+Rwg9k4RYjxuNyrEzr66xRqLPnK358qkt+pp5H1qR7oIQ9PSHK
         rfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794321629; x=1794926429;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1TX+7ST1jF1EHIVSuMiGOipTBv0zHK3+rMwd+XgEvl0=;
        b=RzMUb7hCIBaZOHGN6JgvpHHaT5WLIQRK6dx6eO9Rai+T92VznIs1gqO5MESOTjxyLO
         qcp4TqtpkE+TngM1eq6aMc2beak0k920WNgPunt0QVncUVVRVb7bgxErgjOlcAuONGe1
         +66LSRVa7kfE1MWTMkrMOLcbMAxNvL3hyUXXKpPaSPVCkUWvnUsxPPNDvSn0JEJpJv0T
         3TzYT2o4/4E7FWVYFydAHGzIKgVQnIeltC8syX+m0u4ozu5dtYGvMv6xpOgruSDgemCu
         SK6tP/d2DgOiytqe3dg/pNrfzmkZ282e7FCLsWlouJWrtipf/uDScJORBFv3r64A76IP
         JfqQ==
X-Gm-Message-State: APuU4Z+4iLOUmNS35ZBfSxE9FqaJwP9TDkCKYyuDwB5pXnzJiOtuPpJP
	bt/LTUyWyBAVRfFzscO/64GIBKad2ius5VpYLZmJqK0B5WwPj9TKwvAA
X-Gm-Gg: AYBFou23WRaaSVlC3onW7cnD5FQgsRcEoBsXP+ODKGvBnfeYMFiWrrNNhXAoe9mGVUx
	hpW/NIsNn6MlLdSzsKMmIrPbisvJfqqp2MZpOfDt88j1cegyPkWVQwvRV7fvVUdLkff4Wv6ajry
	HtWrNUeR+hpNGc+w9giiveMxMttNerDgsfK3H47cN/vcysyC3M8JuiY8Dg5qOSzYk1mJpkZEMBG
	t0bH4twh9ifdHLf05yuP3NwDOwjD/sBRE7wb8n10iuLtmxOeWAW9gMpUeKlu4c5K7cqaTs/Xw1E
	0KsWWbD13I3p0iuWL7TVvetoBHfVdHPQSFum9EC49m19CmzMivDCjWu8H8gfM3ppqD3XKAii57K
	IZ8/6qaOsZSakFrli9B3TyAgrMGUGlrUanxqEvBFttA9n8AL5SgvYrmD5mXwK4u/pxGsWPpqRkx
	jsD8q7NjMAKScSXsg26+w31jo/j+PhF2Ez+uFW7dkIFklsBpkef4aylB4Nl3vJUISIPpmVHEIhU
	CjctwHNFgkEN0Y9sEw8KJ7hiOPvRMDG7K5i7wkVLJ/uQYj2IkwjesByoGkVYn1M1O1kOdQ/yjWp
	7eaAHE2UBnzyn2MvAOaefzzsLHOM7BBzQD6csmP+uKkPSyncjr8qF9vvdqG1s0bPOVUPte2pt5Y
	3X4HpnO4=
X-Received: by 2002:a17:907:9694:b0:c46:88ef:2e46 with SMTP id a640c23a62f3a-c504922b5c9mr252731066b.1.1794321629280;
        Tue, 10 Nov 2026 06:40:29 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a61f5b6sm113402366b.54.2026.11.10.06.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 06:40:26 -0800 (PST)
Message-ID: <f7489c12-8529-4d0b-b820-225c9ee4d297@gmail.com>
Date: Tue, 10 Nov 2026 14:40:22 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC Patch v8 0/7] repo: add path keys to repo info
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,
 phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com,
 Junio C Hamano <gitster@pobox.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261107160100.122243-1-jayatheerthkulkarni2005@gmail.com>
 <9582c0da-7aff-466c-a510-ce5a10054df4@gmail.com>
 <CA+rGoLef6b35hjJAcO5Nm57NiyDGK-iDbWO2MUMeoKVCkbRf5A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+rGoLef6b35hjJAcO5Nm57NiyDGK-iDbWO2MUMeoKVCkbRf5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/11/2026 16:52, K Jayatheerth wrote:
> On Sun, Nov 8, 2026 at 1:27 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>
>>> The path keys added in this series are:
>>>     - `path.toplevel.absolute` / `path.toplevel.relative`: The root directory
>>>       of the working tree (or an empty string in bare repositories).
>>
>> In our documentation and glossary, we call this directory the "working
>> tree" so I think "path.working-tree.*" would be a better name, rather
>> than copying the name from the equivalent rev-parse option.
>>
>>>     - `path.superproject-root.absolute` / `path.superproject-root.relative`:
>>>       The root of the superproject when inside a submodule.
>>
>> Personally, I'd prefer "path.superproject-working-tree.*" here, though I
>> see Justin thought that was a bit of a mouthful. As this command is for
>> use in scripts I'd rather have a descriptive name.
>>
> 
> I don't have an opinion on the name itself, but, that said:
> I think superproject-working-tree is a more suiting name.
> It is becuase you may have a working tree in a different place and it
> might not be the root itself.
> I think the same logic applies for toplevel too.
> 
> Any more thoughts from Justin, Lucas, Junio or any other reviewer
> would be better I reckon.

Yes, that would be helpful

>>>     - `path.hooks.absolute` / `path.hooks.relative`: The repository's hooks
>>>       directory (respecting `core.hooksPath`, including `/dev/null`).
>>
>> Given we have config based hooks now, do we really want to add this?
>> Scripts that want to run hooks should be using "git hook run" and
>> scripts that want to install hooks should be using the config based
>> hooks so that they co-exist with the user's existing hooks.
>>
> 
> I believe that is a fair point for new tooling, though wouldn't many
> existing scripts
> and third-party tools still learn about hooks directly via `git
> rev-parse --git-path hooks`?
> 
> Since the main goal of `git repo info` is to provide an alternative
> to `rev-parse`'s various path flags, `path.hooks` still seems useful for scripts
> migrating over, unless the consensus is to deprecate querying the hooks
> directory altogether.

Isn't the goal to provide a better interface than rev-parse, rather than 
just porting the various path related options across unchanged? My worry 
is that by adding "path.hooks.*" we're encouraging people to use an 
outdated interface that ignores the existence of config based hooks. 
Anyone who wants to keep using "git rev-parse --git-path hooks" can do 
so, but I'd rather we didn't encourage that pattern by supporting it in 
new commands.
>>>     - `path.cdup`: The relative path from the current directory up to the
>>>       worktree root.
>>
>> How does this differ from path.working-tree.relative? I've never really
>> understood "git rev-parse --cdup" - if you're in the repository root
>> directory, 'cd "$(git rev-parse --cdup)"' dumps you in your home
>> directory which has always seemed a bit surprising to me.
>>
> 
> Well looking at the code itself
> What I can say is I find couple of edge cases,
> 
> The cdup command relies on a slash counting loop on the prefix string
> to output directory-up
> sequences like '../', returns an empty string at the root and falls
> back to the worktree path when outside.
> 
> On the contrary, relative formatting uses Git's path utility library
> to compute true relative
> filesystem paths, outputting '.' at the root instead of leaving it blank.

Right - but what practical benefit does "path.cdup" offer over 
"path.working-tree.relative"? "git rev-parse --cdup" was added in 
5f94c730f3 (rev-parse: --show-cdup, 2005-12-22), four years before 
"--show-toplevel" in 7cceca5ccc (Add 'git rev-parse --show-toplevel' 
option., 2010-01-12) and 15 years before support for relative paths in 
fac60b8925 (rev-parse: add option for absolute or relative path 
formatting, 2020-12-13). So when it was added "--cdup" was the only way 
to find the root of the repository working tree, which is not the case now.

Thanks

Phillip

