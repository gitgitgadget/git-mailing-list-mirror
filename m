Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0ED4B0482
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786302058; cv=none; b=B761IXeWOqJGs0AX4cNoSt7blDsdrJH4wEB3SjFeoRa66iOFX1/G5Kt3fmfyP6iUT8gckh+cHbj9TTh5gDk1SuPF9KlLigSPBbH/4e6ISOMkHsh7EY5noDJOgqD28StX0LywmgWkOCS9ndNV9+T/+7Gr2aobT8kslA1vN1ENcS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786302058; c=relaxed/simple;
	bh=qXnVh7CShrXAgJb036JlCNyC6/0khE+U54cef/ed+Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGeB4vR6ruEbMmJD81Fzj4U5KOL+z4Xqqn9FrRmdaheTv070FRN0X8vpXf10k6UdhCOjB0M8I0uB7xrLvqwDKk7og0nZ6wVg6smbVT+iRAZ5KLmrOtV9+i1JGoh/4fX7gw+vJZbx4cB9asG9mtGZxgFRI8S4yng5WrUJSKtRRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8YXXTnS; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8YXXTnS"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-459281bc13bso639620fac.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2026 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786302056; x=1786906856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kfUbTqrOP6MHNuDCV9DQPxepfSrAeDvkxd1/OdxRIXM=;
        b=R8YXXTnSd2JMwZpC0UBipfgbnKeOKsV9PTKU1lAraaSulckyRlOT+y/dGinHu3oNbb
         stlc2tWUojhfq/caGTbqqreeVmqNz3b8JYui7QEV7KAJ3JPb3QWKz4iyedn+bZIICXv/
         fAathUN8XU2JKOK6DjelH3/97GwkP7sFp5DvMgFd1F/080CVT7FpT61dLPItFhK7zr1K
         4pTZDbLcTZrcYaveQgzgKrU+JttlOu9YuJa68FlYlBg14f2DyBqBPEhOHhYXBvDMvdkO
         t7vos5SPVuzv8VMk6eux9YjjNpqkKQQAsIfzNZqbfkIzrcleohlaayWJLjitAycLjG3L
         fS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786302056; x=1786906856;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kfUbTqrOP6MHNuDCV9DQPxepfSrAeDvkxd1/OdxRIXM=;
        b=UzJrDIS37mRsdSuRDuBQJU8FemkusgXXfbo4houLfmHt9ksX3ujix5L/z1UmWmgNFJ
         V6XjT0R12A83EeQIozMqu7WqfMtYt4xrbImCvCv9PUNlUZN4duvcUe+I/BxWdWIi6phx
         V4Zx1GRygHsUF3bUwE/HdWIt5MszBVHt6kv1bZWgUdL4xzzxelGhkRhYx2hGW71syqwD
         vSvYVjyeWZ3ltYeJiGHXbagRMqmcNf5LUTbr/6cyNRxPs+pinJUEE/gBzG8K5nRsGVdF
         c1Tj6FvEASHL5Y4+8xihtF0buc5MpxNQd4LhNccyLfMk1m7eA1hVnvaacTCilsTufiHI
         Rjvg==
X-Gm-Message-State: AOJu0YwZf4gMKnlO0vCPEAXxIIaS8s5WeCGuUdckAL5UsGy2/HKGlSjr
	uujJ2LI26SUvDV0OWYrW/u8qEabNSZrTFvGa2d9ZPatTEmtS4/YEy106Eb44/w==
X-Gm-Gg: AR+sD12YN64HdfZoNSKN0/zAjtBUCU+V8Q0VLVKpM6ohE6iTlOrq5b/f82rOH+fWpVX
	mPIpXUjstErcpBQY9ShNuiWAp4HvXoVRn3A5njJQ2un0OP+SpRoBcI55fq6Ne2IW3MBu2RjNguP
	qMZmthAlXxvX11lY1Zw5fnrAbks17FQC9npDUN8Qt+eEE+KTpFMgN2LUsXUAs7Umi6iYt2RbUn3
	Y/vfjuRej5oaLX5i04Ed06SqoNsI3mBn8TiD79pN1+GiE901eEpHR52c5BvRBu+XBC0dsSoJSBI
	7FQNxZH7jEibsgwrIxB8pBUvZh0dSaVJnjrwdOGw9m3Ytxo/h2aHjdfJ8vvVTmdfdr01Y+o4Mxy
	th4K1ggKdtmSb0TJXwBEVFpWbiCE+mHJAwIeVp9IjqwAXPWz4glg4cwEf3onbORmjTrieWBSByD
	tIRIgnoYxxrIHpj4DncZGEiAxKWX2j5kwzrSa1XZlSEhBVaMFFq0mfyg==
X-Received: by 2002:a05:6871:29e:b0:448:9d5b:6393 with SMTP id 586e51a60fabf-459e30f650cmr13444003fac.14.1786302056001;
        Sun, 09 Aug 2026 12:00:56 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1e2d668sm6783086fac.14.2026.08.09.12.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 12:00:55 -0700 (PDT)
Date: Sun, 9 Aug 2026 14:00:52 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] builtin/receive-pack: report unpack errors via strbuf
Message-ID: <ani4GoefzYFWjTMl@denethor>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260806213859.816157-5-jltobler@gmail.com>
 <anWDTwCwMn5wEdIQ@pks.im>
 <anX6w0tFV6pCu1ux@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anX6w0tFV6pCu1ux@denethor>

On 26/08/07 10:36AM, Justin Tobler wrote:
> On 26/08/07 09:03AM, Patrick Steinhardt wrote:
> > > @@ -2711,8 +2719,8 @@ int cmd_receive_pack(int argc,
> > >  			   PACKET_READ_DIE_ON_ERR_PACKET);
> > >  
> > >  	if ((commands = read_head_info(&reader, &shallow))) {
> > > -		const char *unpack_status = NULL;
> > >  		struct string_list push_options = STRING_LIST_INIT_DUP;
> > > +		struct strbuf unpack_status = STRBUF_INIT;
> > 
> > Can't we reuse this buffer and reset it on every run to save some memory
> > allocations?

Looking at this more closely, there isn't actually any loop we are
running this in so I don't think there is any need to change how
`unpack_status` is set up here.

-Justin
