Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40878535D4
	for <git@vger.kernel.org>; Thu, 23 May 2024 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494660; cv=none; b=Q5JAkZ2z9o8XDV/UHlc4jg7iJefTzvR9NCKVJRCAHjC2tFAhE9eCUzXlCeJtABslzzhNYFz5jDFZ6P0p/1upbPyujQuFKvXv9vWmIRySYERC3LfW287hHpIPDHqC2FuDo8mESAf9UdtDr9zzud1vYUmiXKI3woge4ZJEx2ZCj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494660; c=relaxed/simple;
	bh=upVzlPQTsTm1fQtrBO+WdDK14JrAnw/y93qyFuiKudg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Foj5wjIE4F7N5aaFDmK8K5+XpaSBc9G6o7cc/Yy6vTrFhuVuRDQLL1subwgtkhoHGq+VM22SOf6X6tyd/Vr1imLspdudHlL8TFIwWOOzJ3cSZr+jZaafsrncdBTSlYOoKd0avQl7FqzxtahaKSA1uFR8537WVD9+T53gVoqcHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DYFEGwkf; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DYFEGwkf"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24ca03ad307so87906fac.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 13:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716494658; x=1717099458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upVzlPQTsTm1fQtrBO+WdDK14JrAnw/y93qyFuiKudg=;
        b=DYFEGwkfiCTjDtYpyzBM19BOx+JkkbpXSuEQsvzl3Vh2/ufXZcBoq5WAim7gyQkroC
         RY7rVRUDw3dMKzTIY5Ge8PkQsBgG8qZRyuoYw8UwPsdUZa4T1BtkueEwdbdaPGgFqWVE
         I/gH742+tf98txlPLBnxDitYXLlFHAmsowB9PqnO+REddbKI9vG9dVAon6LTAAvuH3oj
         KCBGi2+gh6L4Th3gMDOyvbOiWo7rlFhbF7/xvOvsmhmj8G8cK7ofs6ufUVBSonzaJglZ
         CtxaFZQxBcDy9nF2nhqcKBko4BumOUZWLbNw/ksXgwEgTXk6kMm++CzUQVNqFhPoeKdF
         V8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716494658; x=1717099458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upVzlPQTsTm1fQtrBO+WdDK14JrAnw/y93qyFuiKudg=;
        b=TnsbejacvkiZNn/Lj8JT3ZkrjCEGsN5rqcO28drCxr+Vh/K7af+V6gyKF7YK8Nvfem
         ldBXK2b7r17j66dSVPX4IdgMkB2X2fGkBN3iHpDPbr/uu8M9IKCQuEBvCa/GUIgb0kGs
         Y0qJAcj/ZTU6wJzxG2Lqc6TapF6Gd6gubZxZDUrzzjg3I687E+tdpS9qjdqVTa9PkM27
         rI6pjag2c58SjGtDTJdS3nw7ExfG6ojTdxZp4vME6d9iTGikIvFYRdF0FEJ1gdVDph33
         ghPwgANzLxI0/iczlD01mYHZ6OE+hHDE+2w6ivRFFB62ODABeA9mjeBdBvM465bhECFf
         gYzg==
X-Gm-Message-State: AOJu0YzA6NaaCKgsckwMDnSJgxFiDO00Pq993P6mctsbJPzE0EKhhHbs
	cUTfxD+gO8WbJplmO+jqK1wk4JaxkCuAzpa2obSIUP4894A4bXAKBM4d/Ixx2/M=
X-Google-Smtp-Source: AGHT+IFrQzNc3hmUtNUcytrUj9qWAlzZ5WQ4KX56HYXX5kyj0aUrCxkeIFAs0bgXmVkGY2mDtHP/RQ==
X-Received: by 2002:a05:6870:2c85:b0:22e:d0e3:925f with SMTP id 586e51a60fabf-24ca117029cmr361318fac.1.1716494658274;
        Thu, 23 May 2024 13:04:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1d6bf3sm144672276d6.105.2024.05.23.13.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 13:04:17 -0700 (PDT)
Date: Thu, 23 May 2024 16:04:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/30] pack-bitmap: pseudo-merge reachability bitmaps
Message-ID: <Zk+hP++s/Pz+yym4@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <20240523110532.GA1326297@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523110532.GA1326297@coredump.intra.peff.net>

On Thu, May 23, 2024 at 07:05:32AM -0400, Jeff King wrote:
> I wonder if the start of the pseudo-merge section should have a 4-byte
> version/flags field itself? I don't think that's something we've done
> before, and maybe it's overkill. I dunno. It's just a lot easier to do
> now than later.

I think the tricky thing here would be that the extension itself is a
variable size, so every version would have to put the "extension size"
field in the same place.

Otherwise, an older Git client which doesn't understand a future version
of the pseudo-merge extension wouldn't know how large the extension is,
and wouldn't be able to adjust the index_end field appropriately to skip
over it.

Of course, we could make it a convention that says "all versions have to
place the extension size field at the same relative offset", but it
feels weird to read some of the extension while not understanding the
whole thing.

I'm definitely not saying that I think the specification ought to be set
in stone forever, but I think any changes would want to be behind a new
bitmap extension, not a version within the same extension.

Thanks,
Taylor
