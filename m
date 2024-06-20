Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358042E859
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 20:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914955; cv=none; b=YxMh7MNUab4xWGEM0vs6xfxIzhmFLBT8jaoN6s6yrdHs4Jv3JLywL2wM8f77fW5CnJEuRgnK1OCCaZ/SjmLCoLwF+H3ccw+g5S76VNFlBmAQaROZysb6+hmEhodbSPVlX+EW52LCy/rSl0cW1h1TZ8p7GLcxZWB4786u9cCF594=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914955; c=relaxed/simple;
	bh=OeNRrNnS5k/qqvTdIgh0ulQWv76mISRIGFfnV0ARI10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxPEBTaxikon4oHIsfE0CDm80LAE+zuLu4gvDlsJIkGZsW3Ba2ikJ3g11yhy8MdeVXcoyZdbRGRLxSooE0mSnQQ8w9bjxR5LSCYywOcSPIU2QC+CrVXsmFXR/7mUwANdV13+mcJ6AlqfAVrLGBTFkb+AQHD2XeSxbOrpInoT/b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGxsYS0j; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGxsYS0j"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c84a21b8cso1157736e87.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 13:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718914952; x=1719519752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmJmoRx+5VfgIOp/0qe8OFHJ6m1hzzwTMebe5ulTIMA=;
        b=CGxsYS0jzI48lbrhXnSnGa1Nw7j/diNPLhxP7NDmyxp6yAguD/Oh570tPJ3zG5l7Q4
         cQUWg59C1S7NtZHu1I5QIz3T2fsqWxE5qafF5/vjVTkSGJFg9qvvT4A6ujhuMC9KYfrA
         tS9XdLhhJMBgE6pPZUyrXbeVQ5NgX3YUAHvS3sWOrq5P0RxTWKe7TxJvYvXhOqdv8Vw7
         QrMN8vUT3n7Ytd0lM22DsisSiJSfw3DM7z5CrvnI3jx+GVykzG052ujunsxBPkkf9CKT
         tdf1hL0nToCprWe4N+lLWLJ9exgmRZrz4G9QDP3ASeAjIfceyBABcDY6NgGIP4vEEBFU
         pHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718914952; x=1719519752;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmJmoRx+5VfgIOp/0qe8OFHJ6m1hzzwTMebe5ulTIMA=;
        b=Ot8/628GPaR4gCl+qdWPlQ0JXfW9eeBDtO3mej9AZ0iKVi0b9T7vbJk/Z2FWrCf0Vf
         ZJP6NGFew/l/+zxxQ6KSLW7RINrMnhsoFRdujsMXRxmmidzz3sVaWAwW775m6nK80esW
         yXjg/6xSdfjqdnQXIX0UmL988ubJd1wjjpAX25KwI8vVAVWmKrJPLlqP5PkHILvzIALc
         3mbCcfp9thNlmVkS33Omkhhamt/dt52OsjOJTSPldu/dmHsZ11KJGoVTEZDxTsxxf4Hf
         fD2KnPIkP7W92HzauYsapBiWM0FIlv/zqyGf+PgKJNkO47aKM71tvQN/wGTvKMPUHqGB
         zA5Q==
X-Gm-Message-State: AOJu0YzxdEp5KBBwGXcPhwgzQJNEzU5PeO5IhaDPU8PTCmKw8sHa5DtP
	rtK/awXAnQ+IVrwsgjXHo4uk4vmwiv3uTSOT5PdVgP1x5ctXiZV5/HPVug==
X-Google-Smtp-Source: AGHT+IG/tR1IfgygltDfxB7g+I/GyieELqm59gPXxfxuyQeHH9SoXB2cMLMtxhH1obJPiTettSZ8Kw==
X-Received: by 2002:a05:6512:689:b0:52b:c023:6e53 with SMTP id 2adb3069b0e04-52cca1bf700mr2208473e87.11.1718914952089;
        Thu, 20 Jun 2024 13:22:32 -0700 (PDT)
Received: from gmail.com (133.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.133])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2825665sm2178314e87.13.2024.06.20.13.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 13:22:31 -0700 (PDT)
Message-ID: <73b9a923-c3d6-46e8-b050-e8a93b9757a2@gmail.com>
Date: Thu, 20 Jun 2024 22:22:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pager: die when paging to non-existing command
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
 Johannes Sixt <j6t@kdbg.org>
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
 <xmqqsex7tp0c.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqsex7tp0c.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Jun 20, 2024 at 12:04:03PM -0700, Junio C Hamano wrote:

> > +		die("unable to start the pager: '%s'", pager);
> 
> If this error string is not used elsewhere, it probably is a good
> idea to "revert" to the original error message lost by ea27a18c,
> which was:
> 
> 		die("unable to execute pager '%s'", pager);

Makes sense.  Let me know if you need me to reroll.

> Just in case there is a reason why we should instead silently return
> on MinGW, I'll Cc the author of bfdd9ffd, though.

Yup.  I did notice the MINGW conditions in t7006 but, to be honest, I
hadn't thought about this.  Thank you for considering it and seeking
confirmation.
