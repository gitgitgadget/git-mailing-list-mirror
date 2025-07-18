Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C71D14A8B
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 00:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797325; cv=none; b=ur5aUEZiiLmTTxqRvfr+CjBOvjNwjGuutQ1h1xDpsRitjPyRLARt9smLLC7utLGT/UNHGDCWlmVvjXnQlw250WgOm1WxaqH6maaSH8X/g59iGV3BP4ShEuyjYzJqJP0lpMLJaPPHaWsLQXyHy2NIaSWO7b7tlrTtZqD8Jc06ZtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797325; c=relaxed/simple;
	bh=Ne94uUOBM/bdnO7EvlQ/wBgZiF242AlwkiDd3k4AO8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQcroiPTyPlrmhK4gh9uyPmQ3eY0zcZMiwp2wpIrqbl43eLHWDXbL4A2tMsZDpbM45g6P/L1bAOYLmd9grtx8boqcbntMwGynMz9ftt8eeZilpQFOYJJDNx4D9r1m/82j2S7e389EA5bUugI7FRVYyD1f1YKHmOTRkGpfVsWmy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=e4PLWvMU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="e4PLWvMU"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e767ce72eso15734067b3.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 17:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752797322; x=1753402122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aEL3wqRL5dDrH9ijdS0TEAAdiSSj0oII0r3XAFtqcfs=;
        b=e4PLWvMU++LvGCfKrVT+Gh0k75W5HOp541MiCBklFuCW/+g9ItqUL6kVZMiJbzxR1z
         N3G6F3rSUH5lhAZHfsfgyk/YSFgpxWOWcdq/aMMQfcmuyIw8mVulFwsK+GGKBwKVYapK
         5hr3vfIJdkYEpgnJhtSAqGhIqsb0pNtVfVRdwEpDhyg2/k4Y0D7P9ahuklEOEkQS4Bql
         /cqa0uCYk6v6HJ5/AFyMl614RDlWI3TCtP5qrprIF4SvGa0X9GHqwCqRlzyeIHJxMd1E
         r0U8DvQdvG6FpO9Fldpns9yY46ZxDeM9GE0fNoY93UR5jFFB3TBK6CzSsm8QCMN6OxKr
         CJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752797322; x=1753402122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEL3wqRL5dDrH9ijdS0TEAAdiSSj0oII0r3XAFtqcfs=;
        b=LtggufvpUpA6uTeAldAXVdDMO2sDrbvG6qjnkU9DNKHqUatTvtstmnFhrMmyv2/0MH
         Wg6PpcZ3PvbK3uOotQe9ugCOKi7QDTdEAhVVDvlmJpoG1lxUNyfLHztFrrvptYrQiwPn
         LxwUa1iRrcT/oIWnRw0vrB6fMtHPWnYmoB5Kr6acUjd9AndQdwVUBwn6rbTeUhe6g6yC
         AxqS/f99ucaYpBhvoHKUO6fF7R4qvYtwFHDkMs96AMm6/7qglzEoAk5R+vAhso5iCn08
         tXag3WqPUk6o4GVlcyLB1Sv1EISfw3kCuilCMNTL1GPJHclovkJPE9UZyX3yCqOPu/+t
         jtlg==
X-Gm-Message-State: AOJu0Yz+/LyeiU7YSdNmF3e0R+navLYfgLsgtDzT7MH9Kns1e1MTBdmb
	CkIZ+X4Cfn0b49h7ecNl4KsYrB+2Me+HztWaDzjszubnSjYkAn5K1ORIUKrbtLgyUio=
X-Gm-Gg: ASbGncu6E++A50Z5Z8u4w6Tq/QY+u/km/PGJmn5iGrF6C7mGyMUQFRgNqZ4K+pBVqUj
	aOgtr6hjA95KBNlWB2lTJ6ii9OIvjeKaONggNI4tNViaFrzl19vPojgElXeW3teXeyaL9tkKEts
	RFb8+sRyA4M9MdCoUVJwFOGnCdvEYwK097iJvBRY3NXE/NlkLTnZnDafM+j+CPvmy9ojjeet0il
	ODmHD6I1oAKEg54libA/Bv9315JQhUosKPOg7WuC03qhu1Nd2b/MiIWA9zuLTfO27yxIjXbZ9X8
	R+x19AZbxaIEnrKA2Qnj0zCUuCxkaMvr9pJvYA4Ly3mZ2WHNqpbuRSVBj/9V1pM6fASlhNbmIvd
	nXF72Z+yhFw1OOaz5Kn5Y6TSv2+7Md3BC5gbgQSv3UGRbrl22AtuvoetsXAfakZtzDh0y+w==
X-Google-Smtp-Source: AGHT+IHiSCDMLiQuSzQgm71FL+1kmr9IsxJiZb6ZNddOXAPOSoPjpE14iQ7FfpQFVUcZUNfQYMZB3Q==
X-Received: by 2002:a05:690c:74c2:b0:712:c55c:4e49 with SMTP id 00721157ae682-718374e0c4fmr123481857b3.34.1752797321946;
        Thu, 17 Jul 2025 17:08:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-719533070bdsm723847b3.90.2025.07.17.17.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 17:08:41 -0700 (PDT)
Date: Thu, 17 Jul 2025 20:08:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/6] t/perf: add last-modified perf script
Message-ID: <aHmQiJxfmlbDI+Hq@nand.local>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133518.1788126-2-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716133518.1788126-2-toon@iotcl.com>

On Wed, Jul 16, 2025 at 03:35:14PM +0200, Toon Claes wrote:
> diff --git a/t/perf/p8020-last-modified.sh b/t/perf/p8020-last-modified.sh
> new file mode 100755
> index 0000000000..a02ec907d4
> --- /dev/null
> +++ b/t/perf/p8020-last-modified.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +
> +test_description='last-modified perf tests'
> +. ./perf-lib.sh
> +
> +test_perf_default_repo
> +
> +test_perf 'top-level last-modified' '
> +	git last-modified HEAD
> +'
> +
> +test_perf 'top-level recursive last-modified' '
> +	git last-modified -r HEAD
> +'

The only notable difference from GitHub's version here is that we do not
have a recursive option, so our test is just "git blame-tree
--max-depth=0", which is obviously not applicable here.

What you wrote (testing "last-modified" both with and without the "-r"
option) makes sense to me.

> +test_perf 'subdir last-modified' '
> +	path=$(git ls-tree HEAD | grep ^040000 | head -n 1 | cut -f2)

Hmm. This line comes directly from the patches that I originally shared,
but seeing "git" on the left-hand side of a pipe makes me a little
uneasy.

We could also use the "-d" flag here, which will only show us trees,
thus eliminating the need for the "grep ^040000" portion above.

I'd probably write this as:

    git ls-tree -d HEAD >subtrees &&
    path="$(head -n 1 subtrees | cut -f2)" &&
    git last-modified -- "$path"

Thanks,
Taylor
