Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023A6634
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754344744; cv=none; b=q1SNtOlsVOFgRH0l6+Od5Fk7Ns3Jn6MAWavTTpSN5R0crZEuI5c2IkJdjg0PayLoDK327EBIJpcmuhPx+6K2dyfwM1rG+Kj40fxLaoh+rBjE9xIm1qvBp4nVoDLahqhcTJ3xIZDkB1BfTfE3gXhYib9KI2mTC1wKkagqz2Sk8Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754344744; c=relaxed/simple;
	bh=MCt9cHGaVmDiu+b5BNzpaFrsR14J7OUUlBVxoHsNwJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDnx5jbSAfZsDFGk0Aju+dSPIzlBGQoVUhD33+JDgqMqjuozTxnHgc59YmhWXrBiv3jYv64qmpY+Cd0x2Ps2X9WlxtTH0gLlLatbLcAIzaeAa20tkjuN2q0xsKYPcoxPkUEYkiCk35FtSfhVlYYv8xaC8y2TbsbbXERSBSbgdtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=V850M21A; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="V850M21A"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4af123c6fc4so26151321cf.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 14:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754344742; x=1754949542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ceJTJOPUFXhe1iP2hhLSTDSoevfbpk6Byov91qNfW9Q=;
        b=V850M21AzEwqF8CB8iOWzkrSeK797DVZBDMpEsymL2fvj58tZEJCLeU2b/Z+sMrI7g
         VxycqvfUdMpSEHa8Kt+mm6hvigmpsqBMAS/sVoFtgqdtvw3r9PDSh2wy//OjyK7T1ijC
         wLapkMbIMcoZWqNsAibmDmXjsPOTajWkupgNhnvvqzqIZOif1RsGvFXlnfLxX0EdvWbz
         5cecJLDEmU5dDkEEDH4vws0vCRVMuFpJgHoSwgDuh4o1MxHJ9tXXH2CdEKfp28lrpman
         YuJqIER4rhqSyEPkt6Rbix88fcZONDHnO193XiaxupnpOuqxNwl1Yp1hacwiHL+CuSjM
         FeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754344742; x=1754949542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceJTJOPUFXhe1iP2hhLSTDSoevfbpk6Byov91qNfW9Q=;
        b=TqOgEEu6SO9PdU8ejN9T+lmUNQYa70yjfdAzAJguUElIPiKVg4e7+XYMuC1+4NSDG8
         02ffEQOkD3SW9GTzDsK3WJ2hBzzTzeSDzr3I3jD9b0Xca17JEx1MmowxsYhHXwboaHha
         J7RNHY9E6BzhXDJksZHhO/THaRHID2aqi90aOx6RUPc/yI1AgtFLtxK1BURo8BGC4RXh
         xZlfoOW9Elt829lQlUCBcC3oljJSX5V39EFa9ZsF6awCw8Yyq7O7t699JhSBVFvXen55
         mZ/CTUrp8B0/VX7ismHNdHXMVyeFAI+Hmh5ZldpsnOIeJ2zwqgKP9SYR0trhKq8t9b1X
         ljJw==
X-Gm-Message-State: AOJu0YyJ8zxuWswChEKUiNaOB9AN/7aySrcz5I8/RskHq97I+qtHFmtH
	VF7Zif5uc8WYLaaP0O4Yf40HSQ2PRqFS3aLx/DNtTgSOLDQIR4VaArAKjQBun+nD5AsrslYPQs8
	3rmnd
X-Gm-Gg: ASbGncsey5N6UrJLmmY2aE3zorjhjU9Mh0NB77iqoRD5LZrRfJUZpkV4/pTclxysFxc
	O9iE0weUJvcRPh9EgqMvsAgq5FDwu831DXhULGco+8xSi7FzkHZbyM7JMeOs1XhOA+2faN0b6LU
	iiP3toXQAx7cpWmsZZ4lprL7rhscXNynua1PWKmkgVWHfwSWbLEVBk02VQBLQ/BFwtIsGDo5mQN
	nda0Z+DqKICbWxKURaKDpfGGefjTxIIY5PdM4sRoecGJMgzxLKOI6Mn+PCGICE6ihdbtn5OWUW3
	+rXMeVMZ1vcMIKKat9lkAHjUPM5SGdwb+NvfpdaiEWT7l7FLORfwzfVoU7SrsyEPRi2CR7L1vH6
	y/ccbi64oU+WbbXNZuyhJkjIKILeMlesJhaJ4JsS5BccALoEjSGBcc1cwTjU3nB2by4qezA==
X-Google-Smtp-Source: AGHT+IEWmgW6stGQ2L/SzbBAcjUEvm1F/U+gJsKGDaPPKA5IL74q8Cmhw+LbmQcM9bh7oZ2kizUYrw==
X-Received: by 2002:a05:6602:15c4:b0:861:d8ca:3587 with SMTP id ca18e2360f4ac-8816832a8d9mr2305041339f.4.1754344365792;
        Mon, 04 Aug 2025 14:52:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-50ab413fdcfsm179895173.75.2025.08.04.14.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 14:52:43 -0700 (PDT)
Date: Mon, 4 Aug 2025 17:52:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/9] commit-graph: fix type for some write options
Message-ID: <aJErqjDHudSeyNHr@nand.local>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-3-850d626eb2e8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-3-850d626eb2e8@pks.im>

On Mon, Aug 04, 2025 at 10:17:19AM +0200, Patrick Steinhardt wrote:
> The options "max-commits" and "size-multiple" are both supposed to be
> positive integers and are documented as such, but we use a signed
> integer field to store them. This causes sign comparison warnings in
> `split_graph_merge_strategy()` because we end up comparing the option
> values with the observed number of commits.
>
> Fix the issue by converting the fields to be unsigned and convert the
> options to use `OPT_UNSIGNED()` accordingly. This macro has only been
> introduced recently, which might explain why the option values were
> signed in the first place.

I have the same general feeling about this patch as the previous one:
the -Wsign-compare warnings here are a bit of a red herring.

That said, I do think that we need stricter validation for these
options. Following the --size-multiple example, for instance, we get
this rather unfriendly error message if we pass a bogus value:

    $ git.compile commit-graph write --split --size-multiple=-1 --reachable
    fatal: size_t overflow: 18446744073709551615 * 34

This happens as a result of in
commit-graph.c::split_graph_merge_strategy() doing the following:

    while (g && (g->num_commits <= st_mult(size_mult, num_commits) ||
                 (max_commits && num_commits > max_commits))) {

, where size_mult is changed from a size_t to an int implicitly when
assigning it to the stack-local "size_mult" variable.

Indeed, this patch does improve that warning, but I am not convinced
that changing the type is the right way to go about improving the error
message in and of itself.

Thanks,
Taylor
