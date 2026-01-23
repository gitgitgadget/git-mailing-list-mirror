Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C32E1E0DD8
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190517; cv=none; b=XhyLqwcyINxYv22/LSB8+eTqflb9gIsQufeAtDpfio8g6cWAZQUqr9269qTQeDFreDKYI6urVLaHjIG6BDZ+7gt5mvWhTVqcB6TdxQTu+2pUXNturbSVYlxeaGqD4+v6UJPCn+KD2f61pvT7Z2FtJ5k5lZKEVBLCYTHAQ6L0FQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190517; c=relaxed/simple;
	bh=q68CAPdIeMfPJjAXwWfg134ASvgnb2sw/A+TsY9gGwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEvcgpbhscpeZzX8aQSQ+kJAxLD+8UL7AblFymqDlF0kogV6IQtLvyf4neSkgQ0b7Ffd57qtsbz1eCwvlzjUrDupRp5xWzMigbQZRyVgWjKSDx/Dl7HchGZI53wuFktk6xKHZXjNMvOkdQMgfjO4ioe9BjaV/KkqW53V8aSvbTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=pcQQOH7T; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="pcQQOH7T"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7927261a3acso27841057b3.0
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 09:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769190515; x=1769795315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SzevXAlXQsFX2zdwzlfYNHelvicpP6e1Ml3bp/xjEOc=;
        b=pcQQOH7TK0v4YYRKriuIiOnUt9y4rJpXNnBYULWOoB6ide1tqChWMle61yzZM2DZQg
         nxVgBY3W8GhYmi72hlncHUPd9pa0Vwr2lpiGEXQXwfxXLJUhMJpGzlN44Vedc93nhXFy
         Z2PaKSTL1jwD7h7K5lMz9WpODgF/yMwcLxgKG9sL0xyW5gpJ2GlXlgRACHADMyvSeU6Z
         p3P5U0bgCtprgpdRaoFRuebUfYW62pf1UDizdWNpMjzKUvlJm0Ho3aCR2LR3ui/V+KPV
         wVW7DBh9mgIaXOIxCwKh/LKP8kEPUPxmS/RncfhgzSrAvPPc6wJA6Sjie69/hKw8J815
         TL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769190515; x=1769795315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzevXAlXQsFX2zdwzlfYNHelvicpP6e1Ml3bp/xjEOc=;
        b=d2/Q5zV/KY0bYygYaitHGIc2V9HUiPoVtFZeRzSd1sJyXg8CvvxEJvfsl6KqdgS/uO
         5bBIUeQFTBDNcXgZSkK+BNb5SUwOlk/OT/V4241yBHJQZKzRALjj71VfM9Vf+hkMIklS
         A4BZDdBycK3SWFr1p1ZAl7MfVGIFh83fJmoGQfFvmLRVLzV5eMPN+Pc8HA1FU9clKrik
         urzqf9HnUg/fYLKLGeFqcJqeneMg3ysFe5DEvm1/HuMI+FS3iGzWIqEaEFlfFUetzGVI
         0+idRQ9xE4dg+K2TuAVkI0iQLVaci6xjYsjKnWpgHqGkBD+t21dOSODrr4e1sJYwIkWC
         iU+g==
X-Gm-Message-State: AOJu0YzPcHnwAyYUZo1vCbgaF4shK6aKz+Da+ywgbuXenQEpJEUBHfxZ
	Wcf38Q9qQwwtg/yl0m5sC8kXSchvEQl6uv78DaxQ94DEjF6BS/MVCUgo5Z4eC5gVCW4=
X-Gm-Gg: AZuq6aLYk2Vg6jMl9/TI03ghK/EepqLlgArWD/ylZkoGSTptGq0sfWW2SFKUs4Dd8GY
	/jTxSgHC+NpgMOLjsJ2Mnvr3Ekuhkt7RZvXiC4ZEiYobd8oyGwSw9HHoFsSa/YgnYdSipQnAcBg
	x/Kg3lheXssBKJA4w+3QvC7A1+G1tHNx/jpEQdLx+0EvQyRBMvZpi6z4ZBACwPoxUzAmUa7Pwk5
	kZR8ZWIPX7n1gPgJBdDx4P3rnDFYx4YgsFaiy64f6eKQT9AZqgovdOPPAxRVMdWDYYuCtUOYPmY
	9WAiGs29f1NrWv1kNsHdb22xwEpGgY2K2jitLAuUx7L+E4PJT3JAds8YN0195yxRyuhNzYdIuZl
	GAKWRxwjfVTOCPjVShwWUTXZgSHCr/g+4sPnh7hi50ibmQhz73YF56lvIEFKb701i3z6PhfZgpV
	eV4EK0pkzV0C1rA6MvXbpEa+yLENfamyx6lwJnUy/WXNVgDIsfsLnMk9q7kwgLPwllTvYAHok5G
	yuiB8PcP8vLHTHc1g==
X-Received: by 2002:a05:690c:4483:b0:794:e8e:745b with SMTP id 00721157ae682-79439a42df9mr30783257b3.70.1769190513575;
        Fri, 23 Jan 2026 09:48:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b2bb70dsm13474097b3.45.2026.01.23.09.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:48:33 -0800 (PST)
Date: Fri, 23 Jan 2026 12:48:32 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/14] odb: introduce mtime fields for object info
 requests
Message-ID: <aXO0cNaY3DWu6aQ2@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-11-12c4dfd24227@pks.im>
 <aXLJoDdoEyKXKtBf@nand.local>
 <aXNCq8h94i2Z6uSa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXNCq8h94i2Z6uSa@pks.im>

On Fri, Jan 23, 2026 at 10:43:07AM +0100, Patrick Steinhardt wrote:
> > > diff --git a/odb.c b/odb.c
> > > index 65f0447aa5..67decd3908 100644
> > > --- a/odb.c
> > > +++ b/odb.c
> > > @@ -702,6 +702,8 @@ static int do_oid_object_info_extended(struct object_database *odb,
> > >  				oidclr(oi->delta_base_oid, odb->repo->hash_algo);
> > >  			if (oi->contentp)
> > >  				*oi->contentp = xmemdupz(co->buf, co->size);
> > > +			if (oi->mtimep)
> > > +				*oi->mtimep = 0;
> >
> > Assuming that you do not change the object_info request/response
> > semantics, I wonder if it might make sense to zero out the entirety of
> > the response section as a belt-and-suspenders mechanism in case future
> > contributors forget to assign zero to the new fields themselves.
>
> Splitting up the request/response structure as you proposed in a
> previous patch could definitely help with this. I'd prefer to rather do
> such a bigger change as a follow-up though as it would lead to a lot of
> churn.

I'm OK with pushing the larger change down the road, but I am a little
uncomfortable with the interim state being introduced here. Perhaps a
compromise here would be to have the caller supply a pointer to an
object_info struct, whose request fields we honor. The response fields
would then be written into a separate object_info struct via an
out-parameter.

I don't know. I think that ^ this suggestion is kind of ugly, but I'm
trying to come up with something that doesn't introduce the risk I
described above in the interim between this patch series and the one
you're proposing later on.

Thanks,
Taylor
