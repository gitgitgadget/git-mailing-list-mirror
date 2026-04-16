Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2319334B43F
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345875; cv=none; b=p+QjbKW4WGfkSKUoNGwLqxgtAArxKNj2ZWiDkkV9fizfM7f8Lk1PHjNxYbjjvrBJOWVci//HjN4d7AsvK6wB1ozzosCeCushNnlJlNQpSAhEdAtKbDYXaxvX5YWvi58RvKhk+lXZcPOj+c9scZbjEH4DHA0d/L/T735E8nEhfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345875; c=relaxed/simple;
	bh=/EIZrFUO9JG4sG3lXwkT1+p5w1Kyj4fEuwJGoxv6J1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFhwcw1vCCHy3sLOoPGYL+JvA8Pnhb14WpxSeuA3QnjuUl/rND9YMXQa3yLtYJ/Zy9ojHamw4Do/2+vpekAs7f1uMvASUBqjhLoU/rRFWmbtzUgbKMMOdgQRKVXJa2pr2X6GaHk6dSupKA8MHNLGxEge1JLtPjEL7MSFBhWekLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF+CbHbP; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF+CbHbP"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a032383008so88007456d6.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776345873; x=1776950673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ciN6aTlHUOM83OJ0jJzDo/MB5TSFA2uGC4Q2RgfNPg=;
        b=aF+CbHbPCeChqq7rzC6ITAycO1nFH7PngMMkSl/6x/gldX4LYWBXn+rHMleKenoXHW
         xSnsK9zrN7iL/ABEB4WNYf70Nf9IWGaUkcI5rt8e6rq4r1qTrUyer9E02kACU8gBj8z1
         07VM7uZAXUleTDzMne35F5AJSTnmP7UsMorNaDdx4hvwmKqrQhH5r1CZ9+xL45Px/vra
         Vu8VqYSpjo/cA/WcVLwWmcv/jBjeSbn/4NNtDeoSNPj/P3ohXxhkSs5xj8x8xbV6dVnM
         gLPmQy9bXqG5qHc5ojQeQM+wSvJhTYHH3HXAPd1Ztk/6Kr1yPhOInIbUOL27pTfKmN3X
         ObdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345873; x=1776950673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ciN6aTlHUOM83OJ0jJzDo/MB5TSFA2uGC4Q2RgfNPg=;
        b=NG4Q/H+MtVyHgoI2uVo2Fost6xlyTlZoGNecopGcWs49Vu2iTH9mKGsGzeRlq7M/QT
         iXcyO4RrgAODNdV9eJ/ebneNBOquLZve7+IZTrShTiLklYOUoFQ5eGvP+b8Hd/HaBpo7
         O1k1672f0tlgcNPCs4cRFCUJ3C+U78/CXD6biAPv2ptcEGT/Mxwrv56u+ssx1NqKRpw9
         sh8P+cTM2u3P49KhC04irBaK4WDA7nM5PAh7eKa30exwh9IXxz9XYjsrDNlZyuz/J9CZ
         Zbl8ZaZL9eeFLIUJ+5a1dgcXMAyopsYp2EGWEttBn1mXpWYfw8MruIKkg7y0GvELscUF
         1kpg==
X-Forwarded-Encrypted: i=1; AFNElJ+/hQU4Zlt8zKsbB+CVFuzDkFfqqfHxGp2UDSgEiyKt087TdSfTJsAXvvuJxXuvjZl/qKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgik4GNRrGEc3Sd1NwKx+s2ORvABBXVfTLZm5CwRrGCCl1jedi
	TEPAsAvEnj0ZdY+6SrcIw3N2jYt2ZgDuppUalBA5vA26ikpTYLKreD58
X-Gm-Gg: AeBDiesCZLLC00UwD0vZpMznnSA5yt9m6ck2GF4PAXHzB59k0iy5ePsBl2szjR4hr2q
	js7HktnAxohyOv4ZDj6gpmBBGhgj7KyRnHDN4tlATTqb4DtNu/kYbwNjAzYc8Znl3gT1ltUefJf
	v6yc3B72ikv1DrIjRgHvs5F39qGzTWB7zC4E1D0t9RK4TJxASrSyimy8PZ2QRhg5G+SIQY6xoqI
	8bAstlmSm6GRJJDaUMwTZffGdeC4c2zp3pflDXWlniqkWWT0C4BCLXUV4L6YloiKA5g6eGKVGuW
	KxkLZOljkEuK8QqD49EwhJPXxntjAgIpeZf1HbJVI6THKTFDjkiTjWo+HirOQ+0n1XR/guEPTf6
	IryYyCyXNlpcKl6C2ufltpj2TVe4kiLZ6QF1ufMnvgQFAkr2gm9fqZD4HldSlYSQeDeaMcfyDsN
	u8ZK455V8KGYoxFdxkVLGUk4tiaqPRJabmZ+Bz6kpX2FatJA5v23tyUjnmkbb1BfWksPUp3w==
X-Received: by 2002:a05:6214:5d0a:b0:8a7:16f8:442a with SMTP id 6a1803df08f44-8ac862ab6d1mr423032536d6.39.1776345872939;
        Thu, 16 Apr 2026 06:24:32 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6ceca221sm35011726d6.49.2026.04.16.06.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 06:24:32 -0700 (PDT)
Message-ID: <621c9da9-2ec0-462d-ae51-0be5e0ca6ab2@gmail.com>
Date: Thu, 16 Apr 2026 09:24:31 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de> <xmqq5x5s540j.fsf@gitster.g>
 <20260416051732.GA48541@coredump.intra.peff.net>
 <20260416053435.GA646718@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260416053435.GA646718@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/2026 1:34 AM, Jeff King wrote:
> On Thu, Apr 16, 2026 at 01:17:33AM -0400, Jeff King wrote:
> 
>> I think removing the .midx file (and optionally regenerating with the
>> old version) would be the appropriate workaround, but I wonder how hard
>> it would be to go back to generating v1 midx files by default. I know v2
>> is a building block for more advanced features, but for those who are
>> not using those features yet it is a strict regression.
> 
> I think doing so is just this one-liner:
...
> and then here we need to use v2 for the new compaction feature:
...
> So that would make things work as usual for anybody mixing and matching
> multiple versions of Git, but does make life slightly worse for anybody
> who wants to use the new feature (they have to set the config). We might
> need a doc update, or possibly even to automatically default to v2 when
> using the compact command. But that could come post-2.54.
> 
> At this point I'll stop poking and speculating and see what direction
> Taylor suggests. ;)

I think this is a good change to make. This fits with the standard
approach of not making breaking file changes by default, but letting
users opt-in to new versions (at least for a few major releases).

The part that is striking about Johannes' report is that this happens
on a fetch, so it is being written automatically by normal maintenance
activities in that case. Without downgrading the default version back
to a compatible version, deleting the multi-pack-index(es) will not
keep the repo in a good state.

As for the multi-pack-index being optional, I agree that we _could_
have a more graceful fallback to the pack-indexes when we don't
recognize the file format version. This should still be a very visible
warning as it can be an important performance feature, so users should
be notified when it isn't working as they expect. (This can be done
separately from this late-in-rc change for the default version.)

Thanks,
-Stolee

