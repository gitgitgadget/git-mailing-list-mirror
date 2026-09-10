Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD9577E4B
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062201; cv=none; b=d3ng8ZdsbRvjudnr4dDMrEmLaeyxV5L+Off19ISYHGi3hxgQVhxwXOW/8k1jmkpx/oJmmBatSnU2O5sNwx4FYVJJ9ae3+PSeaEkODZqaUsQyGdxeXVNwewMHkoFFEgYa9WEnibYehucF0SaHIFQn9lwnrEQP5J62DwL5U6yhwws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062201; c=relaxed/simple;
	bh=NGDOe+d5JafNPEEmSx0ulVNLmnCHQOic20XLoOPAZDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JG4r4Uy1tyDyJ5mogy61Dymj7s++ePEBzHI3iaj4w/raxA6JWHIchhXC3fdjFDKBr1BawBMyd2Cyxo2GouHimp2kosrloW6P+qBEGS3BFUWagIBzzl4fnrgZDS9XALtdcDZHlrLn0AxbAR6xY1TfNslzF8jSPtraNK8fIgbnzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNFTwNiD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNFTwNiD"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a9ac6aa620so791705a12.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789062194; x=1789666994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PdiEd8xYU5rPygklUMqAFOWL6Yx0BlXwgx4yNPBBm+U=;
        b=FNFTwNiDHLS2sOUUZFoOpTImEBToLCLjeujp63RDRdgXTmz8G5ASNq89p68i6SJK+z
         IrrohOI+5kH6c8+1QJPIblHLtVvcq8mhIJxRCnuPzZnJ2QEkl/7Nmfm2qbM7kHs8x7tD
         fcSjp+0a91tudWp77tlUDk7F5vdAxKDPStdNNZkpkLUmbuHtsELyub/CZ7d/0J2qKYKB
         j14v0OvaBdggTPVP85USAalBw3pTb7qpAmgyLcWiFAFR9xea/surJ5p3aXpZl7ayjuI2
         QIdxaYvCmroaIzbOv9Kyy2d0fjZAX0ZKz+U9hqmL2hyRoWEuew9Rjx3afu6bSY9fgMVA
         douw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062194; x=1789666994;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdiEd8xYU5rPygklUMqAFOWL6Yx0BlXwgx4yNPBBm+U=;
        b=mGFZ1x6TLScOUJPGZ0qXlTYeMYWdl4YPR7IW2rnZMjYbW/j/mKhUzERKKGR1D+GnSs
         t+1Y1VuACVF6FvxE8oeIslRw/MW5b74QLuWpvbeBJFMFtmCrGNtP4zpHhZd2VZA2ZCix
         RQC37uoWEAIhwXdSRwdb6cXfuQqokdwbnNZf3icKkPkCpaBfzK/otjGse+Ybrpfnm0rQ
         KApUpBCYkReMZDe/NJToLSlF1eV9fyt68aQBWzzC3FnbKlCRavxcIoMH02GZBW+3BKrt
         3zKS/Hr7zdhaFFScAquZVfm3XKZx+aUGhJAXFFxWU1RXo1Hz7MxssIbUsqVkTnFLAUiy
         VH6A==
X-Gm-Message-State: AFuF++lWVP+CobWSfZt7R0fquA46jAeWlYfb5oJcGaT64Mm5B/3Hb41k
	rKDL9o0xAF/CFbqRSZQnAHC86QuLWfl1Vum+wqz03H8fpeoAOSZvSSUf
X-Gm-Gg: AYBFou0ZW1XzOR2lDKhRCt32EVfnB8FEujpCzsr/IfokrrAuaU8WHNZ7L19BdPokvH9
	6rauCRx4iGtL1CX02OmEaLm42ORu+4+88OMYHIGV0nkYDYBMnZm+gqpQMtHt3YXMeQbgO7YWRlZ
	l9izsw0HgbftjmfWshhbcGIrtFhSPUuKrwAbsXaaoaHJ75VcrqngZbzWkQk307V1wPXE338HDH2
	hOEijRgr6J0UvabKbvByBhzzvFpfZLD+kmL/AQaXz9y1bg5rD7032FEpytmDGgOi5MYRPGW2LvP
	d1McfmNs8brL1VhVCZ/l6FxMd4uP7FafKOHreucHOr3xasuflrZMdzkyHkeHlyHDA/BSDM9N21k
	C2/WEQD7gafi8LNMbvwFcIbvhmJYcKEB0qnsB8A3s+6NITvnNj0hi10A/Xwby+AbYzsvcQWi/Lm
	jXIgtthhp3hf+UoINIE5RO6s2UdDYtEllv1iPTbifHplX5ChTUu+DhrjuwZhmfdRoaWn9yn9h35
	n1VTuTqJkhyvlPYrL5orCaw65qwtj3TR8C1K/xca/Hfoq8m+kW0D2E20oU=
X-Received: by 2002:a17:907:7ba9:b0:c29:42ad:acd0 with SMTP id a640c23a62f3a-c2945f702cfmr302707766b.30.1789062194194;
        Thu, 10 Sep 2026 10:43:14 -0700 (PDT)
Received: from localhost (20014C4D24E782008D312CD8C24A9D87.dsl.pool.telekom.hu. [2001:4c4d:24e7:8200:8d31:2cd8:c24a:9d87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c293039a5e2sm292762366b.43.2026.09.10.10.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:43:13 -0700 (PDT)
Date: Thu, 10 Sep 2026 19:43:12 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Vsevolod Myalitsin <ub4nal@mail.ru>
Cc: git@vger.kernel.org, ben.knoble@gmail.org, gitster@pobox.me,
	peff@peff.net
Subject: Re: [PATCH v4 1/3] advice: pass the entire advice_setting to
 vadvise()
Message-ID: <aqLsMDcvqgRZ8MVO@szeder.dev>
References: <20270829004959.90983-1-ub4nal@mail.ru>
 <20260910085353.109373-1-ub4nal@mail.ru>
 <20260910085353.109373-2-ub4nal@mail.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910085353.109373-2-ub4nal@mail.ru>

On Thu, Sep 10, 2026 at 11:53:51AM +0300, Vsevolod Myalitsin wrote:
> @@ -98,16 +100,17 @@ static const char turn_off_instructions[] =
>  N_("\n"
>     "Disable this message with \"git config set advice.%s false\"");
>  
> -static void vadvise(const char *advice, int display_instructions,
> -		    const char *key, va_list params)
> +static void vadvise(const char *advice,
> +	const struct advice_setting *setting, va_list params)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	const char *cp, *np;
>  
>  	strbuf_vaddf(&buf, advice, params);
>  
> -	if (display_instructions)
> -		strbuf_addf(&buf, turn_off_instructions, key);
> +	if (setting && setting->level == ADVICE_LEVEL_NONE) {

There is an opening brace at the end of this line ...

> +		strbuf_addf(&buf, turn_off_instructions,
> +					setting->key);

... but there is no corresponding closing brace here, leading to
compilation errors.

Please make sure that each and every commit you submit can be built.

>  
>  	for (cp = buf.buf; *cp; cp = np) {
>  		np = strchrnul(cp, '\n');
