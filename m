Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6AB37D13A
	for <git@vger.kernel.org>; Mon,  4 May 2026 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889022; cv=none; b=jx3dz1zliS9peYVVftAPCeUlZD3B5GLUpvXQQotxlPz7R0QBFFPQwzMSHZW0qmmsUHTwYbSxH1ORbLtkWPc1/cKKquN4ep+jT9dhjZ2W68p5UF5kQs3MWK2tFSobqDS9+Vh9qd76nt8RJ6ZJoRO4Fu6PElNoooQy9FuAMyhmYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889022; c=relaxed/simple;
	bh=a1IBRfRhUPWiLB2BuLX1Ukcvfp1SkaCuUxqqePEzUVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BV6EshZv81TBDNO3Mdg3kpkE+Mu8muTcra9NcdhOkdJUHb42dF4hxG57VDNaZAPrcKRA0r83AgSHU33L9XN2NoIIqO0p9g671VLuEwWVim/PAy6txecbGmxvdk26wZK+sMRK59UtuI0KZHyIu/LRJDYX/mzRStqhCK+TJDydpGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pXgW/0vQ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cervined.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXgW/0vQ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-392445f11c5so52100561fa.1
        for <git@vger.kernel.org>; Mon, 04 May 2026 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889019; x=1778493819; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/TM7RRxo5syPfAhjqYOu+4fKgucFKHQxaQhx6mdWbXk=;
        b=pXgW/0vQxfXI/kdBjVVIuU6MnM+qEe3k4Qts760S7dWJigqRFtURkVB0VY/BJEiKPK
         DEL1GnW9RJLJUu6VhJc8yr47I1doRVS6FcOL2z+sRqkYgnCpe4TiVo4/U9NnsCg9weXm
         5fBYSACOSbnf+mUSnSNRXCtMfb6cErI2+7IPDT/U0OFG08As0uKkWOxO7hq9dZkuvbyi
         riwBi8KsxzL/QpW4wWjPlj/cLVynqN2zxUVzbJ/Ql0vzvV14cD+te//FzeuTx6v4SZlf
         oAH8tqiADChrIA5hV5fxOMVGlZhXtL2JutsPynqT+/b2HqUq6BIRZfHef9P3Oar+RulS
         Jjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889019; x=1778493819;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TM7RRxo5syPfAhjqYOu+4fKgucFKHQxaQhx6mdWbXk=;
        b=XLyW2PQy72ijakVX9yxcoK15fLexszYjpx5J0Bgbkx0qrccalFzZGXTr2BuGaWeA2K
         HYfG6gnDr2aG0OgcWHBFwJ/gPvuja476bdHKLJ2jI3znwanhBbgXqSAkHCLprK4XKA27
         yUWAz1Dku7rryf/+y/TqFNVPmSckK8GknD1CJKGiUTOTx8TyDW2AvSIFEzka40VbleyY
         f+ti2UHLlCmtkauE6dQqIRmgNo3VyiVfgdGdCVaBEhznP4j3tpIeOj2VoC/JrmRocbFX
         pPx+1Rxpzgf1u4L6KhmWt8ew0MY2Eju51E2QzgQTJICF8dVeD06OKPSMcWckjwC/zAj2
         kcNQ==
X-Gm-Message-State: AOJu0Yz5BG4vCbD2ZejN19O3cclory5eteEuQKs24I2JdvtUO1sv1yKA
	nO0PYtdvf6LoiCe9mo3c1Ffmi5lg1evogVFn3yLh3lNg2j7ogoB0CrTi
X-Gm-Gg: AeBDieuOdLESIJAGslZwadq2/CPapwCUHiUq0C1+CNdfXdDX6jmur0bb6m3u8Reg7l3
	KK2tS/H3qC0jCdP5ItAOETGts386Cw6AJ6wZ/XOTqFkA3lEwpe9Btrmpvqnh2waZWOOSU8dNlGg
	viGNvqMWt341se3MDSsSVn++zVWr3WqbczKVShSGXx6w7DyptXZWo/5Mp3sFMNHcjOzJfnkWB06
	yecKhXMfLQuO8oEbauPL8kwmUszdgNttEUlrrtp5JcjuN52ZISn0IuibDQYksZEvSklWE75Dq4D
	pIdqRuCyEYpcU7hm4AgX+6jjjuOCvotxegOMjJ9fsoe9Tk85t6Hg4ISepSU1FA9jwyYIN5PRXKY
	b7UHUfC3nxoEA1qocv1XkRDBJHNZDowi7wE8XWNaa+4y6bMYqAFyVclJnUO3xTUzm1qyBH9UonQ
	uQN9Zk35MiSxcyemm8ScHpwvqTwGMTnnBnR00T71La5WvV356PwUsem/CzOmdGj4ChehJLB9Yfv
	tBMWR4YZ6aZAfJs+Ngy59qFezM8dsEtobPhu2knKMhr/7wlfZ/wq2R2YmukfRhGoreO6x7v5ttH
	UU3GU7qtww==
X-Received: by 2002:a05:651c:324e:b0:38e:58c7:cda with SMTP id 38308e7fff4ca-39376fed8a8mr26520401fa.1.1777889019187;
        Mon, 04 May 2026 03:03:39 -0700 (PDT)
Received: from localhost ([2001:2043:be0a:d700:5d74:cb35:863a:a32e])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39361092d3bsm27865671fa.3.2026.05.04.03.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:03:38 -0700 (PDT)
Sender: Erik <erik88@gmail.com>
Date: Mon, 4 May 2026 12:03:36 +0200
From: Erik Cervin Edin <erik@cervined.in>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] Reintegrate: send "Huh?" warnings to stderr, not stdout
Message-ID: <afht-MqIGaZLwbnY@mbp>
Mail-Followup-To: Tian Yuchen <cat@malon.dev>, git@vger.kernel.org, 
	gitster@pobox.com
References: <ae896PlyiYeqldFN@mbp>
 <5a821f71-3d6e-4942-9bdb-257617484a6b@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a821f71-3d6e-4942-9bdb-257617484a6b@malon.dev>

On 26/04/29 02:05AM, Tian Yuchen wrote:
> It would be better for me if this sentence (i.e., what was the code
> originally *intended* to do before the patch?) were placed right at the
> beginning. Something similar to:
> 
> 	In show_merge(), the warning "Huh?: $msg" is emitted to stdout because it
> uses the erroneous redirect `echo 2>&1`. The intent was clearly to use `>&2`
> to print to stderr...
> 
> Of course, it’s up to you ;)

Good point! I hoisted the intent up to the opening paragraph; took the
spirit of your wording rather than copying it verbatim, and tightened
the rest while I was at it.
