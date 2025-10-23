Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F4CA6B
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177840; cv=none; b=qStqwnYk6exbE8uCnwLHypevGbFM6HxlGfhv0IHg+mIkdqGHHzKei3LV79nkxSQyTMxx2KRC3uaXDvf75TCh0FJMkmyPNwOCJUA3HBOx+iMeBRibfTtrpov8VCmzPFmGrulHTaKe+SOdK0DxfkXoBKfSHaZoclS8nn9tdncB1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177840; c=relaxed/simple;
	bh=jpVwJE9VNNMYoVinZwIhItS32HpO5j5usVrsHD6M2Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElHa60FyFTu3wbf5906wHivvfO6X+DwJnxHnCQwEsIJL+6luYcEPTof6uTxJxMysGgjobEIQQ5ohkMRzVAlUM8f3IRJDaAj4XTdmsiIC/QP0Xapg9yZhrabaCpARpZyF48aeY7IoLrWWVXpJw1j6bT+rgbYfh0H0WUYKZu53AOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxZFCeqo; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxZFCeqo"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-43f88d33872so56778b6e.0
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 17:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761177838; x=1761782638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEcU6cfPE/c2CODjiRg+/XwV4bfOwaO+azhGu/0A4aM=;
        b=WxZFCeqorK3ZOAKOvSzgoMFOfPGvJJOaPxzdaAmUh9hM+FP1giWJ9tTdEtfs4V9f/6
         zF1Gn/Kw18r0C6l4dVZWOK8kOr0Ak8MnL9PrKfafVB1zAvPSDM0Yk6iujG+aoxw5PZw9
         v+6OxdQR/g80V2CyGgY2sEF/VDAVj2Edhvvuah9GMHoXWnhN+xtEoYjkRva4nO2T+w3P
         fuoZFZ/tte+c1nM7WHLRY/zagwzkCYUG6xvxKIjYawBt1KBqtJ8hEBnTPyckm36iaxyn
         olzSCQEnoq1rQLbUNMA7Eu2CEQ/KjVurH/AiUxrirU4/yGoF7qGbNX1iVsZqGHpPjiiE
         mz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761177838; x=1761782638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEcU6cfPE/c2CODjiRg+/XwV4bfOwaO+azhGu/0A4aM=;
        b=lulINhctLcY6e19t82nuzvisE5nG0WSh0xV7mXB5xqQcnTrDO9Z694AeXi+y5HETb5
         bTfgt3YOyNnM6uQ57/zMyOsGXwfySpOpOjY5W6/95Ue1C/bI1DgKlDNrvEMCD6s0XyUP
         SpakBfbeZ8i4xbRhZjhLEvLKxZdloco5/NFZyzJI58MNuSmN0w3bBW9XByCyx2e7LrDC
         T6/IF/zmMsvBLlASvQFVan9lBSVks2p18vfdMfByEosu1SzSyC/DQbUDUpIsQnt27rXw
         M12Fbx6YhhQ8fkvKrsq2sIRn8RG7t/Tc1lK02/g4VRM3jtjU241drwkmeA9Itb+hjLdX
         yFCQ==
X-Gm-Message-State: AOJu0YyGYlhZHjmcfLVrHMdedlj6PNEDpn9s9XbUxVUH5mhmbV1Tny2q
	U/EOD5T8xjbyg1saEl6SX7nxvpSETmEVAPIoG/E9fZp03MdLgscxq99y8BjUmw==
X-Gm-Gg: ASbGncsFOCWZcCAEvo3u59fKLgd+fdWChHYw4bC09s7vd68ODQJo0hmcXkTbRvpQxhm
	AFFeEzp7RIMSHTgpPHXvbPU7zguEYoj7c3DPsVUnVy3fhGZFJm9h0FvKtm39HZV50CJ0Bz57FaS
	5c64UafBSn6nERoPDCykOa/V5Rj4Dq+i8V2xVtD1IdwK+5HJNtTWkHxSDcbqKdWClGKk1xQT6MV
	Gt4FX2OfCAdQHQrRywonHCCBqRxShaDOYtWT49vhi9JQqAsmhiP1zIkYuTpM1FX+SKnPJ3YTwCP
	dGguiLj9bEWSc1506aQEDBn0cVUHxwa0pQslASiOR2EJ2asi0VFzEJBzMjlcao1pK34SbE8Mf/L
	E1F6dTUzS3HsMtcZ7mvzaUicWmQlKVo0GaDZ41hbJJkNgJW/PSllM+nKGbG83T9uq6YE//KpRp6
	+w3cAjorgxppEhj8E=
X-Google-Smtp-Source: AGHT+IFieR1SnXS/8KyUrJJ6PSUEVwUUUveinJmXTj3r2AeekpmV8tuvvbmC4CCIcD2iQ7nTXyDQsA==
X-Received: by 2002:a05:6808:50a1:b0:43f:b6de:815e with SMTP id 5614622812f47-443a3144315mr9775134b6e.48.1761177838163;
        Wed, 22 Oct 2025 17:03:58 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-44bd43242ddsm136471b6e.8.2025.10.22.17.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 17:03:56 -0700 (PDT)
Date: Wed, 22 Oct 2025 19:03:53 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	sunshine@sunshineco.com, gitster@pobox.com
Subject: Re: [PATCH v6 6/7] builtin/repo: add keyvalue and nul format for
 structure stats
Message-ID: <f3lthzionr4wktkgddb4lwu7njucrny2jmjhtbtiifbwsceuaf@oqx7q7y6alze>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
 <20251021182601.2687284-7-jltobler@gmail.com>
 <A076B823-F619-435F-9A7D-40C6D60254D1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A076B823-F619-435F-9A7D-40C6D60254D1@gmail.com>

On 25/10/22 05:34PM, Lucas Seiki Oshiro wrote:
> 
> > All repository structure stats are outputted in a human-friendly table
> > form. This format is not suitable for machine parsing. Add a --format
> > option that supports three output modes: `table`, `keyvalue`, and `nul`.
> > The `table` mode is the default format and prints the same table output
> > as before.
> 
> Now I'm thinking... What about making --format a flag for git-repo,
> working for both git-repo-info and git-repo-structure? It doesn't seem
> to be hard to make git-repo-info compatible with your table format and
> it looks to me that it would make git-repo more consistent.

Since currently these different subcommands don't support all the same
formats anyways, I don't think it matters too much that they both define
their own `--format` option. If git-repo-info were to add support for a
table format in the future though, I do think we could probably lift
this option up at that time if we wanted.

> I'm also wondering if git-repo-info use this table format by default.
> git-repo-info and git-repo-structure are completely different under
> the hood, but their interface are very similar and it seems to be that
> they could be more closer to each other.

I think that could be nice, but is should probably be done in a separate
series. I do like the idea of aligning the interfaces of these
subcommands though. :)

> > "git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
> > - "git repo structure",
> > + "git repo structure [--format=(table|keyvalue|nul)]",
> 
> Do you intend to add a key parameter like in git-repo-info? This way,
> we could run:
> 
>   git repo structure references.branches.count references.tags.count
> 
> and it would return only the branch and tag count.

Currently I do not intend to add key parameters similar to
git-repo-info. For git-repo-structure, I don't think it would add much
value to filter out certain values unless it would simplify overall
computation. In the case of `references.branches.count` and
`references.tags.count`, figuring these values out requires iterating
across all the references anyways. Even if we only wanted object count
data we would still have to iterate across all the references too.

If we just wanted reference data, we could have an option to skip the
path walking, but that would really limit the data we display and
probably not be that useful overall.

-Justin
