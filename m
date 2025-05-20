Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F22586E0
	for <git@vger.kernel.org>; Tue, 20 May 2025 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747764459; cv=none; b=E/53oBSmxU9gY4yJ4tUCymM4XKxFPxDnaKa92PiIDLWSt+TOgYKPtgCbFo2bnydavftjEgOjYuArW3+v6nyoV9Gnt4lQsOIZQ/aeZ2c4ypwM4tMd3i3AVeDzuvov8eXGF52/R16opEkZ/M96bWeSqhwvkxYk8PHoOz9GO1aVERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747764459; c=relaxed/simple;
	bh=baCsWWyY9OXL74hHsbJOGJpZnqImO0f/Q/bcTdQu/go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpapnhVuGn8aQEqcRvgGP1xkoChq2o0pKThT6dHBcXfsruNyJNnsGmz+6RC7Ku6KsNAEvwVVSoFJgfMevHdEN1seQmbLgkf0QjQ3JLKd1T3JTGueU+bFzQXd1vL9SoUZp/dtL2wNBoBCdDORNrFSJfWvwe3xB9QoA0k33F6ZXJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=x1xQf6AB; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="x1xQf6AB"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c542ffec37so669045885a.2
        for <git@vger.kernel.org>; Tue, 20 May 2025 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1747764457; x=1748369257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K+ht49giKO+vhoWvGqkYmOUKuDvUEsW0d8yv5Rjbj4E=;
        b=x1xQf6AB4sumn2fGTie48S2Wz0LBSDpu+bdZYDRZwZp1uCnpxxjimxZrUW+EVc1rcf
         UNh/dhbbaDO1HMPHuyFoUsmx6TH1eUbqjnz0dZnVZqGczGSymNcpMlOuV4AHb6OZNCdT
         rMJKw4LhM489v1xl+1VT59ZTuIwMe5n5ZA+5qC21j325Gkd9178QKtCyicyHoo1B/UOv
         KLgOTLE0RwJzOfr3wizBEi1J/zf75C27c/xiSpk/YfYt7ThkWdKSvlhZ1zpj5+qOcPHF
         AS0hp27KvUhsRcmz8yhcAddslpiq3mZXU4dM5G9kVKCD6nLD7cgLpQpQZFNh11p9RTFP
         yyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747764457; x=1748369257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+ht49giKO+vhoWvGqkYmOUKuDvUEsW0d8yv5Rjbj4E=;
        b=E8fzFyP90h3lrQ0jfKzK5y1AdXs3eFg/ZJjWzkpdcFEHQYu+0+pY3KlB5a+wmQ+NKf
         ztq0T/XINWJZjWkValQzkOqt3PPmmFeAFwHPVkJRd4BBmMOibL9gU+ZUFQgFjfGTl+fo
         EekRYPKYdP8b50cHLJbhUrHvSSVOGeHoPLKr1whEJJlUHrOf3FYcIkLHjst+gsnMgR4c
         yhjxpYijEK8sMgZk+gkbZm+SQdx3sHc/rmtDDm9Kr8HZA3wAgxTLx8M3Mr1LgBi3Al0p
         LdEqiFa1efGUbzjfl9t3IAxFHVbqb7c3alY2eSjUaBYe8si4rgGjpNTEzxeW6nZuOOUl
         XVXg==
X-Gm-Message-State: AOJu0Yz4UkEKnFoiXt4BHo5KjB6aKZifnB9GHqTx1LcCjHrf2mCMhIhb
	oxMwMLUGbGxN542psnniSWXbts9+ca8qajstkhdMz9X15z/UQNWANa9s5Rf+K+773zM=
X-Gm-Gg: ASbGncuvajFznt02JhSv+lWE75YPfG4ug0o7g34J8l7nKvowqrYYSa/0QKLRAH8hIw4
	ARDGJknkZbIHSleyi7azMnTkRcld73BnvxeUWPMdAwWmqpD5DOPuBVAffxyo0PzoqEB38et8EIB
	YfUU+A3XGhcEuteC0BTmTxuAunx4eF/rXcGz4e4E6MD085IFOAmv/EaM71hXpe64XmXK0njsN7G
	HrAC8uZjfzN32w0xXQr2b3sTshp1wB0gbBwXxeumc+x6m+3AvTfBy7fGKFPUcMqpT9RCrkwQKr/
	VApBBt6iK6Eala7rHa4kY/sDBLHDHoZ3SKs83JH94E7wZMfouzMNUE3nTAJ4F5XO4rxkZlCWAzO
	2xOnfA2xsQudK7RM+QNSunpdxere4jXygNg==
X-Google-Smtp-Source: AGHT+IH5YPmJCVy1jX9gGavtSvkaexJn+Z5NscdR9iw7bE7uhfcnMZ+YxfTMtB4KG8oIr98DTSw3Cw==
X-Received: by 2002:a05:620a:290f:b0:7cd:1ebe:9ad8 with SMTP id af79cd13be357-7cd46708088mr2596677685a.10.1747764456752;
        Tue, 20 May 2025 11:07:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd467c08e1sm771561785a.17.2025.05.20.11.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 11:07:36 -0700 (PDT)
Date: Tue, 20 May 2025 14:07:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 4/4] midx docs: clarify tie breaking
Message-ID: <aCzE58GaA0uviPSs@nand.local>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
 <29769df1c601c77031a27f3b3e5b571d5d7d043e.1747753388.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29769df1c601c77031a27f3b3e5b571d5d7d043e.1747753388.git.phillip.wood@dunelm.org.uk>

On Tue, May 20, 2025 at 04:04:27PM +0100, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Clarify what happens when an object exists in more than one pack, but
> not in the preferred pack. If the user does not pass a preferred pack
> then the pack with the lowest mtime is chosen as the preferred pack. For
> objects that are not in the preferred pack the pack with the highest
> mtime is used. "git multi-pack-index repack" relies on this behavior. If
> ties were resolved in favor of the oldest pack as the current
> documentation suggests the multi-pack index would not reference any of
> the objects in the pack created by "git multi-pack-index repack".

This commit message could likely be shortened since it is repeating some
information from the patch content itself, but I don't have a strong
opinion here.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-multi-pack-index.adoc | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
> index 631d5c7d15c..1f016b2f682 100644
> --- a/Documentation/git-multi-pack-index.adoc
> +++ b/Documentation/git-multi-pack-index.adoc
> @@ -40,8 +40,10 @@ write::
>  	--preferred-pack=<pack>::
>  		Optionally specify the tie-breaking pack used when
>  		multiple packs contain the same object. `<pack>` must
> -		contain at least one object. If not given, ties are
> -		broken in favor of the pack with the lowest mtime.
> +		contain at least one object. If not given the pack with
> +		the lowest mtime is used as the preferred pack. Ties
> +		for objects that are not contained in the preferred
> +		are resolved in favor of the pack with the newest mtime.

I think the clarification here is good, but the structure makes it a
little difficult to follow. The above reads to me like:

    1. What does --preferred-pack do?
    2. What restrictions are there on the pack?
    3. What happens if --preferred-pack is not given?
    4. What happens if the preferred pack does not contain the object?

But I think it might be clearer to structure this like:

    1. What does --preferred-pack do for objects in the preferred pack?
    2. What happens if the preferred pack does not contain the object?
    3. What happens if --preferred-pack is not given?
    4. What restrictions are there on the pack?

I tried to write something like this below:

    When specified, break ties in favor of this pack when there are
    additional copies of its objects in other packs. Ties for objects
    not found in the preferred pack are resolved in favor of the copy in
    the pack with the highest mtime. If unspecified, the pack with the
    lowest mtime is used by default. The preferred pack must have at
    least one object.

I think that the result here is a little easier to follow than what's
proposed above, but I am obviously biased ;-). If you think the two are
equivalent or mine is less clear than yours, feel free to ignore this.

Thanks,
Taylor
