Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60124A079
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795551; cv=none; b=qj3PjJSU/4QmyycCdgAWxt1hLkw1hzUAZSWvO5kMLxUmTpBxSmaE/qZRUqk2zIPultvmnHWpguTX9nH/1E+g2zzqOMISDBeojZEvtR4aS3l8Z78sYetvjHJQfOjzezRoCpQkfElutdGesj+iKjIeHa3XFpM2blvBky/kpLm0NNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795551; c=relaxed/simple;
	bh=uhuCIK02MljtwqS0xktIgekQiUaXsBuZdCLF1+XVs7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF6M0kCDZ/XI6MqVu8kJthQxp+4/pG+tM1Elii1599+0cDoIMsV3iOWCfzlSU1K5SXFSwNw1mVIXJqgRcVHPu4n6pwd0K38JoftGcXHHfqb7IHp8wAcQbdxFbPtOura9N0HTG0lrcHVQKY9+OhEggiPiim4J+1BhkwniauK6vtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Fr/mxVzQ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Fr/mxVzQ"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71841a48502so12546927b3.2
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 16:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752795548; x=1753400348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tr1H0ZOXrFnVe0u6rOyYsFZxT0kbq+BtUf+fLOR0KC0=;
        b=Fr/mxVzQwd3ueQm2bElC/0u6iWen0uAnmvG31EoJOPtT58XKiNxANco5m0rGwM/dQs
         ckr2ZttviKMBEc4vDPKlQjYWH2FO9LP/3WhbEg+E+2gFeO8rqAGt5aPLx8XIMgeXRDY1
         qbJpTYt/w62L9oRJEvOlfPVphz+jsegd5SuvXixb+YGrPKzuRJMWvJfu17oiLkM++1Wp
         W8nixsArKLw8qFl4FfIs/Dpmn/NFGMvWK46Y0GmRbT9WfaSUpLxPzQVUtJfa1KIF6yVA
         nLCqULNstQNFVRIeMHOg7oHgwAypHTaN4UBoi9DMzyR/zYATVDjLx9NC9mgdoMhLar4g
         JejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752795548; x=1753400348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr1H0ZOXrFnVe0u6rOyYsFZxT0kbq+BtUf+fLOR0KC0=;
        b=ss7eYOMrwkIq8apyuF0Jkev7dP1a88Z+D4Zfw1w2T1A9L92PkUgZY3JukZAmebDkT/
         FDfjEO5WT6r39+Wzah/3+9I7opBHAh2doquQ5BZrHjCtqw5jkU7gqx+8Y0nVDsVW3OE7
         T3Jt7vOv56AYi3AJ+8onSi7fmtXyZ5RExiWgQcQAxvWoZFUJPTFMHdexgWB6+5GPRVbp
         eCeTuO+7AFuxliEM2jDG4CIzMc59rY4oPyKVuFgcTfljY09tsFyuREDWKT+pZKFXjW1C
         PI0myKZRBBFihpWM9Ww7MLZcVbUwd62QrrClxV32qBPtaef8WqLWwGsKcffx4VTqx4yQ
         WNmQ==
X-Gm-Message-State: AOJu0YwWrPKtcnPvYGll+NcQ55ePOeti8/0oqhPug0EjgAzOHRGoRToM
	0dGkrI2UlNkHEdspUMw38nFbJ2Z4ZZ8xNh/5gQ+ICuYT60WcLDzbNupEkBjQHnJffgM=
X-Gm-Gg: ASbGnctTrZeWBGag+qsCWA+LW39SSzz/jHitb0qQcYTDNmVgxMkaM2SXC9uDsv8JQPi
	XT/0HmEEe4/WQ0fahevIat52TgpU58Lm7x7XD8L3+wbLKMsb/OHPH9I82JdkRQdwGQZzvyhA6te
	ffuepXeV59HdBFRpkvdXFJPet1dlKqu0pIBcS6A+o2Texz7VwtLlKf0bmZF5ORm54doRlBwDAFs
	pApbkrDbz8yVekMCy6aK2CQ2ghLxWw7/Whw/JYKDSsCeuF97bmxWwcEiMI2pOIUCDP+4Xpngxd+
	M+DZnnNoHi0rT8xO68q6LZ+JfayDEC0mz1BsUO8NFMe2H6tYWRZB9oA6SbsMwLpxTAiTJYf0vEs
	wTESDdyofBVJOQorYx6SE9bLVlYA7nxva0Svb1IQ3PTPWC8NuNNBiESdqbSN4gTwA3gVqeA==
X-Google-Smtp-Source: AGHT+IHCn+zg/DAa7Mvp1cDhRUpzbzi/X4UA3RBkA6lpYrF1Gvy6gSaLwe2/XXvvYRmxsdIqz+/KXg==
X-Received: by 2002:a05:690c:f92:b0:70d:fe74:1800 with SMTP id 00721157ae682-718370b28a7mr120759007b3.15.1752795548435;
        Thu, 17 Jul 2025 16:39:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-719533044dasm645987b3.75.2025.07.17.16.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 16:39:08 -0700 (PDT)
Date: Thu, 17 Jul 2025 19:39:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/6] Introduce git-last-modified(1) command
Message-ID: <aHmJmwvYmAyi3Nlh@nand.local>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133206.1787549-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716133206.1787549-1-toon@iotcl.com>

On Wed, Jul 16, 2025 at 03:32:00PM +0200, Toon Claes wrote:
> This series adds the git-last-modified(1) to feed this view. In the past
> the subcommand was proposed[1] to be named git-blame-tree(1). This
> version is based on the patches shared by the kind people at GitHub[2].

Sorry for completely dropping this from my review queue. Let me try and
give it a read...

> What is different from the series shared by GitHub:
>
> * Renamed the subcommand from `blame-tree` to `last-modified`. There was
>   some consensus[5] this name works better, so let's give it a try and
>   see how this name feels.

Hmmph. I prefer the "blame-tree" name personally, but I am (a) biased,
and (b) used to it over "last-modified", so I don't think my preference
or bias should count for much here.

> * Patches for --max-depth are excluded. I think it's a separate topic to
>   discuss and I'm not sure it needs to be part of series anyway. The
>   main patch was submitted in the previous attempt[3] and if people
>   consider it valuable, I'm happy to discuss that in a separate patch
>   series.

Yeah, makes sense.

> * The last-modified command isn't recursive by default. If you want
>   recurse into subtrees, you need to pass `-r`.

OK.

> * The patches in 'tb/blame-tree' at Taylor's fork[4] implements a
>   caching layer. This feature reads/writes cached results in
>   `.git/blame-tree/<hash>.btc`. To keep this series to a reviewable
>   size, that feature is excluded from this series. I think it's better
>   to submit this as a separate series.

Makes sense; the caching feature was primarily implemented by Stolee and
I think for our purposes here can be considered additive and not
essential to the basic functionality of this new command. For what it's
worth, I *would* like[^1] to see those features sent to the list at some
point, but I agree that they are a significant source of additional
complexity. So punting on them for now seems like the right direction to
me.

[^1]: My ulterior motive here would be to eventually ditch GitHub's
  "blame-tree" command entirely and remove it from GitHub's diff to
  upstream. I'm happy to help however I can with that effort once this
  series lands.

> * Squashed various commits together. Like they introduced a flag
>   `--go-faster`, which later became the default and only implementation.
>   That story was wrapped up in a single commit.

Perfect, thank you. I figured that we would not want to keep temporary
measures around like the "--go-faster" flag, but I also figured that
they may be helpful in unpacking the history of this command, hence why
I sent them in the first place.

> * Dropped the patches that attempt to increase performance for tree
>   entries that have not been updated in a long time. In my testing I've
>   seen both performance improvements *and* degradation with these
>   changes:
>
>   Test                                        HEAD~             HEAD
>   ------------------------------------------------------------------------------------
>   8020.1: top-level last-modified             4.52(4.38+0.11)   2.03(1.93+0.08) -55.1%
>   8020.2: top-level recursive last-modified   5.79(5.64+0.11)   8.34(8.17+0.11) +44.0%
>   8020.3: subdir last-modified                0.15(0.09+0.06)   0.19(0.14+0.06) +26.7%
>
>   Before we include these patches, I want to make sure these changes
>   have positive impact in all/most scenarios. This can happen in a
>   separate series.

Hmm. It's been long enough that I honestly don't remember the details
here, but I agree that this is worth looking into at some point in the
future.

> I've set myself as the author and added Based-on-patch-by trailers to
> credit the original authors. Let me know if you disagree.

I can't speak for the other authors of this command, but I have no issue
being ~~blamed~~ credited with a "Based-on-patch-by" trailer ;-).

> Again thanks to Taylor and the people at GitHub for sharing these
> patches. I hope we can work together to get this upstreamed.

Ditto.

Thanks,
Taylor
