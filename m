Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E42FC08
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 21:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015240; cv=none; b=G0wLQyuBv/GOjp3SzOqISk37F7vAMzYplGH94zvQ1Ky5jRZZ8m4upy1dvg1mF+eMxgI5XHjqGqmbCpV7erRK4uqIkzyN6rlAW+BjzdGO6v8C4SCEoFZrDyJ1+2uOmps2XG48rMpledyo1gUzvk79cVAZQiMcV4TtJeq97DUu1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015240; c=relaxed/simple;
	bh=WktgvkI2S3brG1wKnEJQ2IEQsPWxpjSiQ2GPB8H3oGA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGzSIOC/Yfnx0NAIbpodd5pnBM3MUNwuPiZIbr2bUhRsQ9T7WapQKVkpZiJjtLqg8liBvPbZUFLYZtQFS7bA2sSiYE86mRfYsTG2FHo9SZRWHi0nX9VxPhQfiZNrxYKx1oCtOJrWT1iLtxvMjRR2MIDV52p8Vs4SXim9dfQ78JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=RKsKmz8t; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="RKsKmz8t"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e29218d34f8so1161949276.1
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 13:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1731015238; x=1731620038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OK8WesViW8mFnNtUqx7kdrEkSLNFRFfDKLbwCwr+75c=;
        b=RKsKmz8tQyLV+3MMrIuGGMCkSwoOtBxplhym1bW5XyaBK2kKEOEEGYKupsRbG68bH1
         KbcH4FlOtsAo5g9prueOdVNWI9I2JYIU20sa22iw9dh4OHQFiSYN7DO4xfo1zNfTzCMp
         j5wSBYZSxxs9ANwmLdbmHdNcdqG2X1Jb/JzAkIx+jtVwpoxzGmudgG5rNu1guHFol0QH
         +MBqxUCD58P/4gOC8UclNWGHGVsKn0Wz7MH6lh9Z3zd13uqC4I7QcQGNgkhoddCUOOcv
         wYZYhsOiYsRXwPnuT6FK2o9njprjo1RUFSQc50J/8MVAiB8bHJRQ22RqnaSViODQepTg
         uGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731015238; x=1731620038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OK8WesViW8mFnNtUqx7kdrEkSLNFRFfDKLbwCwr+75c=;
        b=xM0fMlOT1ZFCp7SNxWRz7nOFE4rjYr54I581V9p9eId0iPloDPzlScppIphK0zlH4I
         ypgRGu5zCjDMNmHEzwUReFs+MB2PcVnwqq9Ro6S0iHgibrHdYMxs6F7wr7hte3cZZhq+
         B4uST1X43zgVJGzO7cH+x8sZSlDJsEgeapvB4pyak//YTqBGvlv/pS2fkisWRkaH6Ozj
         7FBhlpqZ5C3X40kmnK/7ml0PH4wh1CNp896v+IDwqq4VLJt0KZe0zBttuEj9FYCSBmq+
         kZUk3q0CehytobQ099K9Q/jC+pTSf26Tj2CdJwgmhgXFN9UYch/vsq5JgTfgQ/b5Is9+
         Ajiw==
X-Forwarded-Encrypted: i=1; AJvYcCW0qXka2ew49veHzpMmwiW8bbD2D3civpBnrj3NkO7s/SXK200/FbpKQhHBGMtT9kgXjhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWjtkWISy2cLrfqEDgfyKb4r9Y3RUshLo1JgtWYiZCE1eFi9JS
	hz6ctkK9B1HwTtM+ymCVdOJVbDe+aOE8lINMeMe2DbHMSdEWcMn1/K1YDq3A4yvVRPxGK2fdxii
	4eI0=
X-Google-Smtp-Source: AGHT+IHGx/6YokNx0oXu/Jhj/VIoL7y1e4m1KmTRWbnU5m3dE8szPtjV1Wj1/HS2fFGPCCXNd442Cw==
X-Received: by 2002:a05:6902:1245:b0:e30:bbcd:4150 with SMTP id 3f1490d57ef6-e337fca929cmr499708276.0.1731015238097;
        Thu, 07 Nov 2024 13:33:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1ed626sm436047276.58.2024.11.07.13.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 13:33:57 -0800 (PST)
Date: Thu, 7 Nov 2024 16:33:56 -0500
From: Taylor Blau <me@ttaylorr.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] t/helper/test-tool: implement 'sha1-unsafe' helper
Message-ID: <Zy0yRLt5dM554yq1@nand.local>
References: <cover.1730833506.git.me@ttaylorr.com>
 <20241107014737.GB961214@coredump.intra.peff.net>
 <ZywgZt419SfPUVkQ@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZywgZt419SfPUVkQ@tapette.crustytoothpaste.net>

On Thu, Nov 07, 2024 at 02:05:26AM +0000, brian m. carlson wrote:
> On 2024-11-07 at 01:47:37, Jeff King wrote:
> > I think this is a useful thing to have, and I didn't see anything wrong
> > in the implementation. I did notice some oddities that existed before
> > your series:
> >
> >   1. Why do we have "test-tool sha256" at all? Nobody in the test suite
> >      calls it. It feels like the whole test-sha1/sha256/hash split is
> >      overly complicated. A single "test-tool hash" seems like it would
> >      be simpler, and it could take an "--algo" parameter (and an
> >      "--unsafe" one). I guess in the end we end up with the same options
> >      ,but the proliferation of top-level test-tool commands seems ugly
> >      to me (likewise "sha1_is_sha1dc").
>
> I think we do in `pack_trailer` in `t/lib-pack.sh`, but not in a
> greppable way:
>
>   # Compute and append pack trailer to "$1"
>   pack_trailer () {
>   	test-tool $(test_oid algo) -b <"$1" >trailer.tmp &&
>   	cat trailer.tmp >>"$1" &&
>   	rm -f trailer.tmp
>   }

Nice find. I think that it may be worth writing this as:

    case "$(test_oid algo)" in
    sha1)
        test-tool sha1 -b <"$1" >trailer.tmp
        ;;
    sha256)
        test-tool sha256 -b <"$1" >trailer.tmp
        ;;
    *)
        echo >&2 "unknown algorithm: $(test_oid algo)"
        exit 1
        ;;
    esac

To make it more greppable. Obviously the existing implementation is not
wrong, but I do find it remarkably hard to search for ;-).

> I think a single helper with `--algo` and `--unsafe` parameters would
> also be fine and would probably be a little more tidy, as you mention.

That would be nice too.

Thanks,
Taylor
