Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA0137923
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785056448; cv=none; b=n/CacDjlCfStpVcVLs4BIOwF+K84ukU4Ok5/igr+wdWCsYVhNEGsXLIYBPd3UDH7R2hvnsgIa8kWinvlo55Wun8TGDIUOEI25W1Dmklx3ReEGqfmCCYghzKqnvhx7i2VnfK/YiKTF1x/5OXn2If1XD2ecM4AW+a55qii5orR30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785056448; c=relaxed/simple;
	bh=N4mNStHpP+sOto6MiCbE1P7PdsE/s+6ExGjEjBIYRaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xggdjsi06zALTHKDWOD5rXwLCMhmysRPBCHtPX0S7ER1eNML8scPAMmOUXiy9j+WFqGXzO6HZEQ+lqWaUXfpH35HZBvb6tKn1hL/1dVG6qglcfh6As8YekQN8+QAOz/OG3VVNcVrCCpIXFn//ir4ipzqhWAnPWFRBPb9ZL+HS6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnvoJTfO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnvoJTfO"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c8dbf4ef0so14398631fa.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 02:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785056445; x=1785661245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vDslqWfECLw8SIFUKHohwIpp0sZnZcBWBWicjQRSmMs=;
        b=bnvoJTfORa8ob/HBLa2Nb/7q9mHQEjNkw3E+2CnFa3b3tmS1UDfQtWnkCLppin4v7U
         hacWhab9vD1tXJsopSJdTOGcZr00tcv4Y/xC9/H8T01VOmBaCWv47a9d4TI3mSPgCgQg
         JNJKWn6YjjEFAwV04+yrW1ZJgJt5r0FedEdC49uVgnoDvw5t2CqLUYGOrbUj6OLwd0qM
         gGU8k1eypDDI9d0/gWc90hUA+3O8ul6UTbQrAj/2rctsXturbbZeCV7n1RgGwctgaYk8
         wEFykTfOsq2/5GmxGv4BpHd3Odp/HIPd5hTZEDPvc3FLGeXLRSs3QZE1NurgCabRzt1O
         rvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785056445; x=1785661245;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vDslqWfECLw8SIFUKHohwIpp0sZnZcBWBWicjQRSmMs=;
        b=ZckjQT9ihwH1Zrb9YAwIfwLQVMIPyhf6+xYSuwlBYo07v9bRDIGwYPZlN4jkC2t5pH
         0G0u8v93KwVeP2XxdIuJVDoE++CZ+2xOUG/xMdBD1nue3a69POUGWK6168J5NZ5i4H26
         StNADpPSo8zx51Gs+cmC0TEOB9Ms9QM3VuSSKPWTYqnmP345rkkzg66rFuF3clUlHe2u
         c/O3KwpzfRyTqiYKKrOaQhch19NG5jC2bUSVZCSekPssq/IuGvYuQ/TLeMOSJ+vu1atJ
         S81z8+DNCsryNLBpt6EuIAsX5hlrAWYh5mKy3ukvtBS4ImdIjobEYGBVlnbr7+ca4HCb
         x3ag==
X-Forwarded-Encrypted: i=1; AHgh+RrN7QbvrTgT83aQEVWOWHVY+7XKmUe+tl6mHXnQ82l+Xd3riyzebw47JxocT2lx5ec2aT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeRgVUnAOxr/DeWZ8r2lKVSNc0cVG65m2Dj/xtbswx05jm4A5P
	EimqUQeZzRbNDjHv5B3YcoQ4BBQYeflCKXcUoyHg5duyzR8dl3mKZUWGqPT5P75d
X-Gm-Gg: AR+sD10QlStADqA4jexhY1cQnbFPM2pAy1Yvbt8rrbrUhRPCZq80FJOowye9cD72y5I
	dkhhjf69LdSbs6qfUr1mGhQR27rOTaB2Ln2CmdPUsmapelo+yNCSPtzBbmgDFRmKzLgNTtQzWyn
	ZfTf2RyNeWtNzNd6Fd2csMeAYmA5TawibVnwlCYDbNBcqq/ortkYsTjmeKWlpa0OiqKfmhgVRQy
	Z5Yv1cDWb3683gZ/gpltGCLr1bgwxM/Sf0glwG1ga1jG3oAgNl/VHMuN40k9src4cOVpw9JccgS
	gGbAadEc/Lg207q7LTORZj2Q6CQSKaowC82L64Fg5GG4Pj1jTPEleK86m4JAoWaW6oqSbOq15uI
	gf2yMfJybghDPBNmHzOxR+D3584taLOIDwRWPkoEPNG4cjatdZIFuwdpTFfc0mDtplDhouggpfr
	wbHAwI8J0zRPuRHBUz2TylB6v4O3FJxD8xBLrwCdVImYSXbVoXIcjiHRfLyUBIpsvAbj6Ksa8H4
	quoQocxnIsBa0uRg1jsDQ==
X-Received: by 2002:a05:6512:398b:b0:5b0:20b0:9589 with SMTP id 2adb3069b0e04-5b2c1b34cbcmr988548e87.38.1785056444746;
        Sun, 26 Jul 2026 02:00:44 -0700 (PDT)
Received: from localhost ([2001:2043:be0a:d700:bd32:e7e3:cfbd:5b51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2be0777e2sm833876e87.4.2026.07.26.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 02:00:44 -0700 (PDT)
Date: Sun, 26 Jul 2026 11:00:42 +0200
From: erik88 <erik88@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, 
	Emin =?utf-8?B?w5Z6YXRh?= via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Greg Hewgill <greg@hewgill.com>, 
	Micheil Smith <micheil@brandedcode.com>, Michael Haggerty <mhagger@alum.mit.edu>, 
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>, Emin =?utf-8?B?w5Z6YXRh?= <eminozata@proton.me>
Subject: Re: [PATCH] stash: add 'rename' subcommand
Message-ID: <amXJcVadL8btF_gh@vader>
References: <pull.2180.git.1784190706028.gitgitgadget@gmail.com>
 <alitkCsplW_DIaRw@pks.im>
 <xmqqh5lyhlp6.fsf@gitster.g>
 <allISNh-b6Sc6y5-@fruit.crustytoothpaste.net>
 <xmqqpl0mbetb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpl0mbetb.fsf@gitster.g>

On 26/07/16 06:11PM, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > I have a large number of stashes in my git.git repository (211 at
> > present) and it may be that I, in a mad rush to solve some problem or
> > another, went with the default message.  I do this kind of thing with
> > repositories at work all the time.  But it's inconvenient to have to
> > search through `git stash list -p` to see which change it was and which
> > stash I need to pop to resume my work, so I can see the utility of this
> > approach.

Same. I always accumulate 100+ stashes. I never bother with a message
when I stash. 90-95% of the stashes are useless cruft but there's always
an experiment, a script file of some sort, which turns out to be useful.

> Hmph, are you saying that you are going to wade through 211
> stash entries one by one and reword them?

Not me but my AI agent ;-)
