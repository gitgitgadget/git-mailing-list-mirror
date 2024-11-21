Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F66148FE8
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221223; cv=none; b=lV2ZlCeah2UYMjOuxRqnPpkv4Zit9Lh54yK0IH3wMA2OoIyz6sE+uu64gw6n6g2zga3oOJuqpePWmIiLXnVPzl/nVjvUWmmhatkVANaX8fnYQaYN5+eDJ9Ww2LBD0hX3t0p2knNK3/Q00fcWMJhWmycFd2NS3JyazdcN/x94964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221223; c=relaxed/simple;
	bh=AFKxS/idWo8WGkjiaIIDzqrEqd61mwFweHVFjO8hXLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4VQ8BXSLX3Tjf0BrfCLkOim73VgUZHaPX9yWWurgG+ryy1nDxLC69O3T6YMleehafuYmscZMeeInok2qRt8ewz5YfRtZSWjsevfbkfhN+z3brlMjUti7mVEhdyjSRVPUZydW8raxPJfewWtcdosX7cqSel+/iMVEJuhCLonrnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DvII7vml; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DvII7vml"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e388186edbfso1270907276.3
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732221221; x=1732826021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GqStvS746HUrkOnCi9ROTvbv5MiR70hLOjqxOx2f42M=;
        b=DvII7vmlTn+tc8G0S9Y/1TWGrKxBI2lY83Z6hIAil6Fn8mm2D0kHwVU3TfxQTnjhEr
         k+Wr3RM4xOk12fhW0eWBln/bjLjn+w/ORIKw2hF7dY1zXNuahQaxDCYilofu4vWyJDIL
         grWO6bMMYV86/cYR6/M1vOFYfah4S2eq2BN3vskg8nvMVrjBJPFftASMkAZrexfsodGc
         yOAYQMt0XGua8EzZi2OR8GZug5jVJpetqK+hM/DPRzwuSVupxI0qbLozIHLz3wtRlUA5
         u+FtZbNvO+OdcA4w+qoQQRE2HGm8SMrCVWfwt0ALoA9MjbIrO2rzN4vJmmi1cTxVB46C
         EhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221221; x=1732826021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqStvS746HUrkOnCi9ROTvbv5MiR70hLOjqxOx2f42M=;
        b=OsDVJWpkvL/bJjPujCRYrJ4GQI9rMPT3WWwjRcngwOPFXucq+3nOnBRLpZfNclgmKN
         OqWO8WGKnJ7SapsZZJ6DUZTgJ6C6D0uCIceOc3R5Drx0dU92dmRDJMkHT1lp/h7mVPMR
         NOHlzjqIxviKPfbLN5T4deL5imzte0Spa5+Rs3JW2mGHyh/0tXQPr+1NscKMHkRvVaIA
         XOiwU+JQKDmgjovPG64MZ7neaClmsI5s1PPsHSEMLPGdBt8ApLo+ouzJ/3HTDLr/eJth
         GTMwLQ5c+54ciE6tIDfS4YFW1KbacAI8qvttp5+tF2aN7yzjtJrq10GtzRP6/oJZKtGf
         +TqQ==
X-Gm-Message-State: AOJu0Yx02/V/Me+hdL+z6yQeDIBx7Mk/bgKmFm5Q3Ck/GmQpk366wmi5
	WkXaguBJjVIpWIb1e9N0RdZIk0vjQFxL9GdVqbv3deO6ACpq/JYAP7ucfXZ7UJ8=
X-Gm-Gg: ASbGncsRXxcsANI3YMiRd4BhutJ37mXF+gJJOFMHX1DiqiD2esybbSh9pliKrvaXjA1
	lSyRfxE6Rf53oj2V0Fyf8H8HPi8tAqGCrGucqLMz/3lB24sxsTsXmDmtZakX51qGwXpa4jn4sSZ
	9p+qT+KtYuc386NRrpWpfl8BJ2mmhmOVQ0VtH2w5zSVuaCLmIeM3cG63/QpDY+Yag+4MmzdOkJU
	dzEaA4XRgWymT98Wxnqe9leekEW/51zA9CeBAHF9TvdLnbvlLILy7PT5GF6rSlCzcBQwycGLasU
	7WJMWJK6dRrXbeOdRbIb6Q==
X-Google-Smtp-Source: AGHT+IGjrA5asKtsH2tPc0Ma4P9T3RSB0FW559pvB/oaRl8EMLubnC8omoYyiT4+yBouFcqfW1nNcw==
X-Received: by 2002:a05:6902:18c6:b0:e29:769b:453a with SMTP id 3f1490d57ef6-e38f8bd8fb0mr288504276.35.1732221221291;
        Thu, 21 Nov 2024 12:33:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f601b750sm139646276.8.2024.11.21.12.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:33:40 -0800 (PST)
Date: Thu, 21 Nov 2024 15:33:39 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 6/7] pack-objects: disable --full-name-hash when shallow
Message-ID: <Zz+ZI7IcfhV3Rw79@nand.local>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <b8a055cb196dd971ac21611c1957be319557b4d3.1730775908.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8a055cb196dd971ac21611c1957be319557b4d3.1730775908.git.gitgitgadget@gmail.com>

On Tue, Nov 05, 2024 at 03:05:06AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> As demonstrated in the previous change, the --full-name-hash option of
> 'git pack-objects' is less effective in a trunctated history. Thus, even
> when the option is selected via a command-line option or config, disable
> this option when the '--shallow' option is specified. This will help
> performance in servers that choose to enable the --full-name-hash option
> by default for a repository while not regressing their ability to serve
> shallow clones.
>
> This will not present a compatibility issue in the future when the full
> name hash values are stored in the reachability bitmaps, since shallow
> clones disable bitmaps.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  builtin/pack-objects.c       | 6 ++++++
>  t/perf/p5313-pack-objects.sh | 1 +
>  2 files changed, 7 insertions(+)

I appreciate demonstrating the value of declaring --shallow and
--full-name-hash incompatible by showing the performance numbers in the
previous patch.

But TBH I think that it would be equally fine or slightly better to say
up front "when combined with --shallow, this option produces larger
packs during testing, so the two are incompatible for now". You could
include some performance numbers there to illustrate that difference in
the commit log too if you wanted.

But I don't think it's worth introducing the pair as compatible only to
mark them incompatible later on in the same series.

Thanks,
Taylor
