Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A8471268
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116973; cv=none; b=dWbrrazWqjx2+W02lF6hWNHG6vLlyegp4X/e0u0ixLz2TCe3NN/rHaSfz453yJTPtzxS72OtJy/b/er0GsNNZC0gIyFaFqyiXLLc0WXqOyVGIbkH1/HKqBQumdGLd0ZGOHPW9MO4JBdOsgQelNd+PZFIeGhBoHoWvIhVqPv26hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116973; c=relaxed/simple;
	bh=5PLrHklGXdlYvutmm9KKb/sfnZVMQLBVAyS7Dkn8Y/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gskLsV9lyXlesXn+Wdi/LOYHEcXLRR64ghfOu4eW8jZdVBqdXrRYmY1b8thHrpB9s2QyQ7NdxsCmMb5jXLh9s4yQFe5Xu/GplO3dhN1EP1erbPgSF4P5cqw8gcs4lX306Hk799LlCeidnN8MQ53NKgIrCYGQwaZDda1YGngxNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2c1u8IY; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2c1u8IY"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b190cdc9feso880053b6e.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786116970; x=1786721770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kuSGW/wV0HlJtrW/GPFwyYqitrbN1Dsxp0e5i0hrCWQ=;
        b=n2c1u8IYtIOEVz4eB/VgHoUu2TiSgj8pGcp3DX7MC9jNrPBsFwc8m7P5YqkmIVlTVm
         cJqFPaBcw7i6dgj7m/caPJ97KNLMpA1RopKP5dH4/5DlksH/ugGRW+wxjxbM6+A7Zx50
         oKHqqExRF27ttWnxLQZU6HnbNkngALSpTJVFFD1nZZco+Zix6a1eFus7astfdQk8JkLw
         63R+kL3nQ9a5HZACdO7BKMzEhSEnDqV5qLuIG65NB6feSyLDIdfw8Lhx+ikWHy52gvWp
         unfJpcVyjhxz4NTxpIJDpyh5hJ5+6C/JhQeexT5auHGQ2/ddF9e6YWts4KkYKc+sY3Vc
         ypzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786116970; x=1786721770;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kuSGW/wV0HlJtrW/GPFwyYqitrbN1Dsxp0e5i0hrCWQ=;
        b=Doim2EP4ooE144IKzpPpmSRbr5cnSfU2IQMIpQXyyoCk1H/J5qnMX4RE84q/Lo6xOj
         hQFeqGgtaQCkRDkiAdFxOKiuxuF9tuA85VqfqUKCYcZPqJoxwggkS9EyC4ju79g0+DCX
         itrS1kZkFTZWX0aoVJxjw4oOomMJLsoYZPxnCjMZ0XGszC1hAh5KzdIH5itaMFc8joCr
         XpK/h84DbFhtdgg1WLJSMM/pLrn6oP/GHYsGa4jkD9gfdUFM5h06Vp+4XLEwovkLZpSn
         5mTP8CrrUksd8j9NRhjK8MXN2YJXOHcRcGRC/35RCx6RcraR+hevW28+fDgslEf1zMpc
         S34Q==
X-Gm-Message-State: AOJu0YzYa9cxLTV8e+kHoLRErGm03lczgyinGRAh5mOWGNXgJWOQC6dx
	BvAfmi/xucth+hM+7+7+SufeWKE0npOV6kqXmP3f3x4PGV3VG2c9DP1gtCaiJw==
X-Gm-Gg: AR+sD11AA1XXukyh8fd/HKuCBBkqQiqysFYCk2LwtA6fLzkBaS2zzHtBC/CtZioATp+
	X08gu7jUwOsjMLiezorg3Mz7znDzlrfzS6800MDYP8Ie6eUQYrGtomCzylhPr3IdWPJsM6FEuT6
	tSwJdDPhfRLlFVRZondXvD8mep6QYE0Jfg4Kpr32VW7+fLWTEuOHvpHawr7BGAFmQxha/MJWwnY
	MvG9ACOZN3jZWbwgw7JO/CzUV/6S5QZBbikjSvicQ86VqO5OaoupF1VeGJsXJh3tMPmuHTi+5bz
	NSPIwu8t/jqsm5Stmx63mB95ObxsmfZiko18C/HfKcgt8PQO59qyywzOMkNHsfHZ4me+UCaWgeJ
	Jc2zsdCl3X27cWAbpcCMKJ2eE7/kzqXRfXWxZYkzdsOZS+TVtkJTmsKGiWsijLCFee0tNSA23Gr
	j7MF2s1yDsiWU5D077j6fjIkKJ4IFidozUmGaojFlQlEtmPFfUi+QD5g==
X-Received: by 2002:a05:6808:3a0f:b0:4a3:f4b7:cbdf with SMTP id 5614622812f47-4afadf93109mr12531529b6e.15.1786116970259;
        Fri, 07 Aug 2026 08:36:10 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae4b5750sm7272566b6e.7.2026.08.07.08.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:36:09 -0700 (PDT)
Date: Fri, 7 Aug 2026 10:36:09 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] builtin/receive-pack: report unpack errors via strbuf
Message-ID: <anX6w0tFV6pCu1ux@denethor>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260806213859.816157-5-jltobler@gmail.com>
 <anWDTwCwMn5wEdIQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anWDTwCwMn5wEdIQ@pks.im>

On 26/08/07 09:03AM, Patrick Steinhardt wrote:
> On Thu, Aug 06, 2026 at 04:38:57PM -0500, Justin Tobler wrote:
> > @@ -2551,13 +2559,13 @@ static void update_shallow_info(struct command *commands,
> >  	free(ref_status);
> >  }
> >  
> > -static void report(struct command *commands, const char *unpack_status)
> > +static void report(struct command *commands, struct strbuf *unpack_status)
> 
> Should we mark this parameter as `const`?

Yes, will do in the next version.

> 
> > @@ -2575,14 +2583,14 @@ static void report(struct command *commands, const char *unpack_status)
> >  	strbuf_release(&buf);
> >  }
> >  
> > -static void report_v2(struct command *commands, const char *unpack_status)
> > +static void report_v2(struct command *commands, struct strbuf *unpack_status)
> 
> And here, as well?

Will do.

> > @@ -2711,8 +2719,8 @@ int cmd_receive_pack(int argc,
> >  			   PACKET_READ_DIE_ON_ERR_PACKET);
> >  
> >  	if ((commands = read_head_info(&reader, &shallow))) {
> > -		const char *unpack_status = NULL;
> >  		struct string_list push_options = STRING_LIST_INIT_DUP;
> > +		struct strbuf unpack_status = STRBUF_INIT;
> 
> Can't we reuse this buffer and reset it on every run to save some memory
> allocations?

Good suggestion. I'll lift this up in the next version so we can reuse
it for each iteration.

-Justin
