Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E53F1C27
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958159; cv=none; b=h5kCfWKyRCHbfQV0RuUOF2ZuO9eB+ynXyqZAzBVHcnGCBHsdB6uXoedrNPdmmfNaL1/Thvr7GnDeKmbeoqE2dEGofNGb6UZTm+aZg3puQDbR3lMtSB6caAuWX8GY7CmM4+N7Pc2UOSJllTC1vJHxRSY+kaWMj4RBgkO8ehdsfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958159; c=relaxed/simple;
	bh=Sbre/SgmpyQaK7nFaGFroycMHFdWeTtk+RuqV9FHacY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjQntg6guunh5kKVZyE1aBKCxCjMf8JPEj+MWoqCVYfrvPkGBhiYf9G/i2zX6VLWHzIXTNHid4xvyr4RtQz7kp805jVRq6aBXt3aCs6ahCsWfBl6JYiAPAubEMX4MVsbl5AhJtJ5vKHaGfyT/Osfb1utMBdmbfkf/YT+f4PzAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=jR35Taq5; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="jR35Taq5"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-92cebee95a8so10976639f.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759958156; x=1760562956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=16t1imDmtcEXQj74KZbroYQDkxvTtWauF4AGf5Kx2VY=;
        b=jR35Taq5N7ZwPnhez94In1QqVCH6kYJvfjrvf6Orchym0Tf1hGz4+zAGnLRMiieAes
         quc/VznFeG7g84zFY1g2+tENCj33ttNCdLvydaUZwZU4k0v4nlDJTDXaGleWtpy8YC8c
         ewd8GGz5Onnu+NHlx7DEoc6InXZS5G3oZKSWBhcyi4enBfeayN/siqn68oIAHLgz2Df+
         BwAHwgr61qmk+Duhn+Bd/eUyJUfC02lhW8TykbIS4pw86vtRJsRtJ4HzQr27YfQSwK6I
         36MHO6/+pOHSPwIhRsJDSHXRtjGZqBUROSqFxlMiPUyjM6S86soVqzY5u4qejl5uf7xu
         WQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759958156; x=1760562956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16t1imDmtcEXQj74KZbroYQDkxvTtWauF4AGf5Kx2VY=;
        b=ob19pJK59rILfasof4/al8fbwQYd/6PP73J3KX0C9RV/3p/LVMaT06ZfN49PcaI2Gf
         IAZP5cXHwqxRrVEQyln7JTX+lWTO/PW+3RyBfQcC54onQ2jTC0VEhSvQOPNIDurIREwa
         OroWJj0WTYT0eIkPr5EuLu9GxPduE/29O3Knluhubj0HzKkhlZ4r5VAqStZ2GrVYV8Ym
         lGfGH4Pdh/k2PdvPdAWjrvT4qP1Q8BsliG1ANGU3aAZQGq7MXsd3Z2IyaDhi/Tjn2h09
         3jYH+9trn0zRhSPxJklRJF3oZbKDtL8bg43YH9YxXZDFwz2L5TdJ5OVqGqbmUm5mgmKR
         L8JA==
X-Gm-Message-State: AOJu0Yw3sNHXGFdlFYD3sH4eykSr+UDymbW5aLMa5BSYsVeeF0/SdNKv
	riJZgzlAMwX6mF/zmT+wnFHgQtefpIfj74m3jJdHenAKziAjoFBebs0ev7zGwEmivCQ=
X-Gm-Gg: ASbGncup2pUWYseTzRuD/XOaEyYkvNa0fwVa7/RNQFMqRliUu+NAiRmUzBnGxKguiHT
	/N+t/2h7UBDPfptKilL47yZO+xjiwZ9pzYQCds207peydVIU6seIerENtHu1nU7Jr5R+UpiPnq4
	lG8MI/TkumW6HAQo9MQgxYPAp66mHeYfVyUGG6zrDDeYbNGpbIkB2ONYXGEjSLBTQD9VtltTi/S
	lkiwD9fd/d4GIY/S44Ix7gqOEVRL94HhXdn/v7HUJ6gAepbkTf8naJa9UjFAM6Ap6xocuwrmytL
	mVPWKzK0TDnE7EWwEgX5Pnws/yFQibmlI/qrqgTalSzBwOIZRJ1Eu5EXbphyBjxp07AML9zYYTW
	+Sc+JOuq0whDgFGSX7KN8qYne/sGSezI9aXrnveMUUA5w8UOGgOdPlE8HSWH4nlOqCO8TBRqoMl
	1MdNkJcibzaSlSgnBgRfCagE1P57eIajRg+PHvgINzeMQMBEuNwMv//xnb4G7n
X-Google-Smtp-Source: AGHT+IH14iwRo++eTzZYd2vrlwG+F2w3Y3yebt72PZHMHEbu6ncH3NJ6laHC6PKZY4/x/r99guLRVw==
X-Received: by 2002:a05:6e02:4410:20b0:42f:8d23:58da with SMTP id e9e14a558f8ab-42f8d235c3dmr25312165ab.14.1759958156389;
        Wed, 08 Oct 2025 14:15:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-42f9036e8a3sm3118205ab.31.2025.10.08.14.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:15:55 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:15:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] packfile: introduce macro to iterate through packs
Message-ID: <aObUivWiMdtprQSu@nand.local>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
 <20251007-pks-packfiles-convert-get-all-v1-5-428227657a89@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007-pks-packfiles-convert-get-all-v1-5-428227657a89@pks.im>

On Tue, Oct 07, 2025 at 02:41:11PM +0200, Patrick Steinhardt wrote:
> We have a bunch of different sites that want to iterate through all
> packs of a given `struct packfile_store`. This pattern is somewhat
> verbose and repetitive, which makes it somewhat cumbersome.
>
> Introduce a new macro `packfile_store_for_each_pack()` that removes some
> of the boilerplate.

Makes sense.

Since we're talking about adding a convenience macro, I wonder if it
might make sense to name/treat this one slightly differently. I would
imagine something like:

    repo_for_each_pack(the_repository, p) { ... }

I understand that packfile_store_for_each_pack() is trying to operate on
a single packfile_source. In practice, would someone ever want to
iterate over the packfiles in some source but not another one? It's hard
to know the answer to that question right now without any other
implementations.

Perhaps in the meantime you could imagine doing something similar to
your macro, but instead of reading from the store directly, it could
read from the repository's store _and_ BUG() if there is more than one
store to choose from.

I get that that may be counterproductive to your goal here of getting
the tree prepared to handle multiple object sources. Another approach
might be to keep the proposed semantics, but call it "for_each_pack()"
instead of "packfile_store_for_each_pack()".

I know that the latter is our preferred convention, but I am not sure
that the rule makes total sense in this case. It is obvious from
"for_each_pack()" alone that we are iterating over packs, and the only
way to obtain a collection of packs is from the a packfile_store. So
here I think that the "packfile_store_" prefix is doing more harm than
good by making the code overly verbose.

> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 8ee95e0d67..5462c442dc 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -869,18 +869,19 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
>  {
>  	struct packfile_store *packs = r->objects->packfiles;
>  	struct progress *progress = NULL;
> +	struct packed_git *p;

I wondered if this needed to be in scope for the whole function, and
looking just at the first portion of this hunk it seems like it does
not. But continuing to read further down shows other spots where it is
beneficial to have "p" defined at the scope of the whole function.

>  	uint32_t pack_count = 0;
>  	int res = 0;
>
>  	if (show_progress) {
> -		for (struct packed_git *p = packfile_store_get_all_packs(packs); p; p = p->next)
> +		packfile_store_for_each_pack(packs, p)
>  			pack_count++;

This conversion looks obviously correct. Though I wonder, as an aside,
do you think it makes sense to have a packfile_store_num_packs()
function or similar that does this for us?

Thanks,
Taylor
