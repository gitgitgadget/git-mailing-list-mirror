Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A676330D2A
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786481058; cv=none; b=oQC4h5Ul0GfWLebuMFu3dkt3nxLc8lyk2Mz1U2j5GTfumtLGlbGcH7oPWvfHMmc6ltH7WxZJv8hwW3vXurcHSOxD2pDVec/4kwZV5b8ETjKmQssDOGGQPXJM0o4SKvPVBlzIedr01BlL0ZiUiGOaPeP5swDESMFhYT5a5uUFK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786481058; c=relaxed/simple;
	bh=8GpUMvhSCZUpEXq5yRRZJVFuNgpCK9N9BAXiryVj4DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaNNQU+RCdaBZUnIJMrrRPShfNju4zrVwRNsLoQQBxzLUFa709p4ErHK5F8vWtAgHdB41vQ8Z1uFIoadU9+bfvlT7vuar0piDB3yQFG0vJEap3JyPYcMA0yBed8Q7uxZig/fJiXczK76J7dsCNOlytEmSp8fg8OMYRA2pGWR+is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBxKDZ1m; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBxKDZ1m"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7f39cfb65cbso289379a34.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786481056; x=1787085856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9iZINTjszoA0JHA0d3cPQn3yzVQjPioU1yaFSzpAlxw=;
        b=JBxKDZ1movpH7f6fkZIOCdV+XSccJYP+qcqIPFHRoWKDH/dpdeOGjW6dukdJDgFxbN
         8RXE7CYohGAPYCHWwdggZOfOcKy1R4UkRmQHz5CvMqud/p+BEaKR+Z+ncHJ47VmZUIf/
         fVrQdiWKJM98MQNBEzUlydII2wptbPS0uRR2ubGRTQi43j16jIAQmbURpwbrNgSDwI0O
         lpfk9AkxIT37r/jrjB5BejfM8fXa6sSD9FI1e+sJD+XZ73KhOqqGDaanbB89Uv2rbpH7
         xOlo/5RlY34xFX32EqOpkBwAbSrhjOYE5clYJwV4Lv2BwQ2ZSlDuy+0Jf4fbwnYyUUGo
         qZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786481056; x=1787085856;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9iZINTjszoA0JHA0d3cPQn3yzVQjPioU1yaFSzpAlxw=;
        b=Y2667msO88AI8cLE6dQLk++tP4zxoKg33ZlMlaVdmgIhZMVFkrl/OJZI3u9v8USCqc
         QhtHMqJxC3cxfWjflPcOPdvkBsN6Hq+I2G5986pe2moUxbn/GaQCzDotKWXapQ/jBHP8
         SHseGm8ykDuieJ/wkLMuZQTiRekJnzTmaLQAy7GU7THbSATmB1SZat2r9jTwnlOExrXt
         X14TZFwhmTLuXrCXhW5hJwmBzqBrv/4vUS1PspEEvJu0B97TmwIs0oTrJX5o9/I8CC+f
         TWZFDYjjw+dSUuYjhYvl73ThNhgmCJjPhVo0THJEPVKgKynhvjfFTD1e5kIWYc6KWU27
         zGkw==
X-Gm-Message-State: AOJu0YwVxhMiwX8lqlV9PJ4/vfr6fwkCZCtQwVwh8OFMshupaBkaIkli
	g7LWxfXZEAr0ANv5z7SHR/bw6jd3GrfnkNt1WVbDmdPraljT97dsQrdtvB58OA==
X-Gm-Gg: AR+sD11ZukAhDBig4+y0M9BwRVU+Djza6LhzVo4E00MAn7bh206sifwlTs5d7TD1jkg
	WXEjNmqH7P61nzzu5eANzn9sSgzzQF8S2+xF9XomX+mdhJjUb41atLV0kmTpKFNd7N7806GGfk2
	xrY8xeud7BuxaHT5rrioRox4s0JrCQQ2iBJCTYF45erTjZ6Wdd5t1uT7Mabv1U1wsxc8wjPIjPC
	TJbvFMaTzwDZ2LkkO/PH8RkowBW+5roNyUhJu57F4HRqUaWbKsaVoGk444iPL6XmknTp1MT29UZ
	R6VkkFIc2BaKrhpxS82IVG0LHXxzngC+GeE0xOOP2qUF85a6ks64K5xBZoBqpWmqcZcz319FamC
	mrHW2/YTxvQMv/hf57FQ/kA8pQAWPxe7hML1G0eMW9D3xwAV8ciHtvN/CkIfuIWs2yXdSxSrFmM
	leniJPY0n2JnwyhV4M4L14SnLkH9nlllw6GC63KrztBPSyHwxCSv271w==
X-Received: by 2002:a05:6830:610e:b0:7e9:df18:c53a with SMTP id 46e09a7af769-7f3a842b633mr5022347a34.14.1786481055672;
        Tue, 11 Aug 2026 13:44:15 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b3209120sm918550a34.7.2026.08.11.13.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 13:44:14 -0700 (PDT)
Date: Tue, 11 Aug 2026 15:44:12 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>
Subject: Re: [PATCH] odb/files: be less aggressive with geometric repacking
Message-ID: <anuFzZluJEU21MB0@denethor>
References: <20260811-pks-geometric-maintenance-reduce-frequency-v1-1-7a54c42355ac@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811-pks-geometric-maintenance-reduce-frequency-v1-1-7a54c42355ac@pks.im>

On 26/08/11 11:04AM, Patrick Steinhardt wrote:
> When performing auto-maintenance with geometric repacking we have two
> conditions that may trigger a repack:
> 
>   - Either the geometric sequence of packfiles is invalidated.
> 
>   - Or we have too many loose objects.
> 
> The first condition shouldn't trigger all that often: it may be hit when
> we fetch a new packfile, but users tend to not do that all the time. The
> second condition is what typically triggers more regularly though, as
> every command that ends up writing new objects may cause us to cross the
> threshold of loose objects. It is thus preferable to not be too
> aggressive here, as otherwise we may end up repacking objects quite
> often.
> 
> For the geometric-repacking strategy though we have a default of 100
> objects, only. As we're approximating the count of objects by only
> reading the "objects/17/" shared, we'd only need 2 objects in there
> before we perform a repack by default, which is quite aggressive.
> git-gc(1) on the other hand has a default of 6700, so it is quite a bit
> more conservative here.

Ok IIUC, the reason two loose objects can potentially trigger repacking
is because the heuristic used to estimate the number of loose objects
only counts objects in "objects/17/" and multiples it by 256 (the
maximum number of directories that are fanned-out). That makes sense and
indeed seems like it could lead to repacking processes be spawned more
frequently than desired.

My first thought is whether the heuristic itself should be updated to
capture a more accurate estimate for the number of objects. That would
of course require looking up more objects and thus be more expensive. If
the goal here is just for a very rough estimate anyways, maybe it
wouldn't be worth it though.

Increasing the loose object threshold here to be more conservative seems
like a reasonable approach. I'm not sure exactly why 6700 was chosen
here. 6700 / 256 ~= 26.2 which means "objects/17/" would have to contain
at least 27 objects before repacking is triggered. That is certainly
much more conservative. I see that 6700 has also been chosen else where
in the codebase as the threshold too. It might be nice to explain the
reasoning a bit more in the commit message though.

> Being this aggressive is also causing problems as reported by our users.
> When running lots of concurrent writers, those writes will constantly
> end up spawning maintenance jobs that end up repacking objects. As we
> also prune objects, a concurrently running process that tries to write
> an object may see that the sharding directories get removed under their
> feet. While we try re-creating such leading directories, we only do so a
> single time, and it may happen that the directory vanishes again before
> we had the chance to create the loose object. This is not a new problem,
> but it is exacerbated by us running maintenance this aggressively.
> 
> Improve the status quo by reducing the frequency at which we pack loose
> objects to the same frequency that git-gc(1) uses.

Makes sense and the patch itself looks trivially correct.

-Justin
