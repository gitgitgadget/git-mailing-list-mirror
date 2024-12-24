Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1741D79A6
	for <git@vger.kernel.org>; Tue, 24 Dec 2024 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735055044; cv=none; b=gIOaXUFhfaaAKnZd0JAq3Hv2Q3ExWQl9+43XfP6oflTl+mqaVsHXAXe+mFaI0WBfZsN5/d/xNw1xqN1YLMc71CQpQLpnvPKdIReWH0dQ8qvrjct0BiLKZYAoPFVsJJxh5d9SNz4DEgCusc6p6q37GRMZE3vzsKxBmokOjSME99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735055044; c=relaxed/simple;
	bh=jz7LLcsReaCHhp9+9PzuauSQEWvqanoHbOK8P5JMrqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKKRiLiF1sOoD2z5/rfunDrbZuTKpl/kxW8dzceRP3/jjpv7J+ApA3AddvLTuc1yZ4NOUyC0uQdGtqgZeu/U9PXhD85+XRzGJ7evDg86rnvebkQJRKUUIoW8vArQ1S0BWIpQ5jHk5jrUdE+l2IxxW7JVGRmSp3dPDfEp6wx/X4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=UiEzL/U/; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UiEzL/U/"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f1dbf0d060so2537074eaf.1
        for <git@vger.kernel.org>; Tue, 24 Dec 2024 07:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1735055041; x=1735659841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jz7LLcsReaCHhp9+9PzuauSQEWvqanoHbOK8P5JMrqc=;
        b=UiEzL/U/s4p4IKWM2/Gsz/ovDqmjuU7KU300wdlSuOoFhrR4jCm7HP202hhVLyIfg7
         0xGoDngmB5xmHyrD1Lu8KqcgG05KKPzgF1spixMbBzFJKesZjwTnfjwZN/5AJWPz5Hem
         qCFrTkLh5ahHJYueFGSKbXtgVhvMtgcYoa5TjkK7csnrWkAwNj6Wxdb+VmIgp2PGeKyN
         /LBZVWc+2XI9yU40xCkOOzfZqJUTvgQMTRgUL7MVNafqVoakMGSp3H7zWbordCsty7as
         qViMonvCCk6gGFUikpTnhKehiiDQ6uBtt6m9NMBOIvE0AFZ3zJrOBvk+1SrIuGYwXCH4
         50ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735055041; x=1735659841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jz7LLcsReaCHhp9+9PzuauSQEWvqanoHbOK8P5JMrqc=;
        b=NLjrpf+UJMqtvBMaaCRbMHmudzV1Tyj7tK+Lf1l8HHZgQmKPvWuRsfjEZ/lMs/5an2
         WuxT1hq1QDdFhG/0pYWcUl2olMnJzHpSo1iVOzdxAzM2Ddia8phUmob5Qqiw5juMGuNl
         5V8SfnJJ/fztczjYRvq2N6MBsP2l1vmeJTPObQQJ4z78QK9EW5d4f4YZEanjkdDX3n8c
         8W4MCwACRUQGQ3JfVPB7bponQqVybkVGpEWVTaF/6Za3ip4sa9Qgo3y+A47/Zdt5alyx
         CuoTcJw46GPsK98Edhoqo+mzReHyVNKpYhwRppoCXTN68Com7r8SrCdRtoUosYnAm4YY
         DpVw==
X-Gm-Message-State: AOJu0Yx0D09506LTPTTWXCLvL03Zk6cte1Anr8hEaztsyrSSOBWH7a97
	79RpGuENH4qkTt6wXZdDnNHVp/1d0WX9YuUpc2YpsA9u2HaqJbKXQGrInJgcehPpk+FZX7duLDX
	7MjqWV4FBGHCa9rCE8e5oGgK8P0sY4ql6c2DqfxPaYcLIBy3xBpZqFQ==
X-Gm-Gg: ASbGnctCWVZJbHn0hNFrILrkKtKaJbtOMOEq0eRP13Ugzhf0vSSg6aAH7FmpCAqPzfA
	o/u42UeEO1qZfsnFEA9EyWLN6F0v6MEPv4yo=
X-Google-Smtp-Source: AGHT+IEvLv2VUZRt2Jdu9ocfaOcW4VCUDXIklqk5+tUgw6gXyqVyID7iI9AtR/V8COVqTb1ohLDvvuZ0WOsA3jdCCZQ=
X-Received: by 2002:a05:6871:6306:b0:29f:de75:d178 with SMTP id
 586e51a60fabf-2a7fb140d1bmr9763333fac.19.1735055041499; Tue, 24 Dec 2024
 07:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLTT8Q0cH3Q=yPnTYKAwn8bC+iDW7onibsLF=bzVr8tGw5J0Q@mail.gmail.com>
In-Reply-To: <CAOLTT8Q0cH3Q=yPnTYKAwn8bC+iDW7onibsLF=bzVr8tGw5J0Q@mail.gmail.com>
From: Taylor Blau <me@ttaylorr.com>
Date: Tue, 24 Dec 2024 08:43:50 -0700
Message-ID: <CABvF+3Z5kWAAbLz_P=oL1o90-u5Mo=DCyi5sEv-a_bJABB=pKw@mail.gmail.com>
Subject: Re: [Possible Bug] --cruft option not work with git gc --prune=now
To: ZheNing Hu <adlternative@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 24, 2024 at 08:07:16PM +0800, ZheNing Hu wrote:
> I am trying to use the --cruft feature of git gc, and everything works
> well, but when I combine it with --prune=now, I notice that no cruft
> package is generated, which is very strange. So I turned on trace and
> checked: instead of executing `git repack --cruft`, it executed `git
> repack -d -l -a`. Is this normal? If `git gc --cruft --prune=now`
> doesn't work as expected, it won't be safe to further execute `git gc
> --cruft --expire-to=<dir> --prune=now`(in my another patch).
>
> I checked the code, and it appears that add_repack_all_option() first
> processes `--prune=now` before handling `--cruft` option.

That's right, since --prune=now will cause your repository to purge any
unreachable objects immediately, regardless of their mtimes.

So after a 'git gc --prune=now', your repository will only consist of
reachable objects, meaning that there will be nothing to put into a
cruft pack.

Note that 'git gc' does not support the '--expire-to' option, but you
can use it via 'git repack'.

Thanks,
Taylor
