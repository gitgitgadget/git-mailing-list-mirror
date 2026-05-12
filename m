Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB73812F1
	for <git@vger.kernel.org>; Tue, 12 May 2026 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599161; cv=none; b=eLBrrzqPMofWbe1X2y5+QgHgq1CAOPz0y/yNEkrpPzQEbhemT2o/dBh8GYmu4FF821aAig1Gfw4ygdItwIJ8pEdigHgmAk1PJuUMgQcYejTwfoytqmCHNEShdtlzDcYNeuxVTkD4lTFGx7VLnfmwpr6SVDfqxhCuaOrIdZV6Y+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599161; c=relaxed/simple;
	bh=8p6ZwtsYyQhLMpRzy0sGQy8T28QcgYm2xOTivKDvh1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABLhEIaA7CUv+z+J374D8QLlAZc6L/l0bhJ4DNs5I5iml/EnE+mA5SEHU1y3USO09W5h4jzpeQdj5Qj2iEJL606E0WQnCJ+Dp4Sf2ZvSW1uPsfbn1E4d0Saddn3LPh/VDbuhaary4ddzxXx4Kxgo9P+UHSCao5ksTAV5OaaNWx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZtjcudQ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZtjcudQ"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-439b2aad735so304504fac.0
        for <git@vger.kernel.org>; Tue, 12 May 2026 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778599157; x=1779203957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yqth+u0GIVxli6o4HJRqIqtUI2oVDcOonL4c+4p6DMw=;
        b=BZtjcudQk1+BsmkGIIsuceMpML3aw/2vXGXIdgkWtES4ftIM0dCcmJVAUmvwjEb1bB
         vflUnFRX9kalYYyITmZ0SnftpiUJoevAoYl/HWo+pquRUn7GWFRIiijiWScLckP4BSoO
         bXxtNi13nr7LLazGIIQIuOW3Xs7wNTsTpV2MD7XMxBqMV95jRAVm2hzCnHrDAZnPs4A2
         1tC3jZlt4gGE6owFkyjKWWs2TBTdyvugUZ/WlE7kT37B2ivq5pycoqrkPNm78N17LtJt
         wB+xbEKPRzGAv2Ak9tio/VdmI8C8qy/nmKbgOOQHiwHrT/ZinfmcbikEB3dDsa3qEeDY
         Wp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778599157; x=1779203957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yqth+u0GIVxli6o4HJRqIqtUI2oVDcOonL4c+4p6DMw=;
        b=BBTjVe92yeuGl2SxzZGTZtw8pCkorIDROyTG0mhTAIjVN6ne1SwjoRhriEABCGvnsk
         qXgraj+mZbgbVaSc+OOLwQHHU6xgi9d5XJ06II2yiAAZoOXd0EeEpPKvFmJc0UEloOWj
         DlXL9NBLbwKTjArfXi57t+WI5lRzfMJt3WOsC3dLTSNPIjOVdXDuCEN+7TaaJ6UYxIVQ
         ngFGM3O9eIMRKLrcJ2tFRkARzMgP8sUV16JGwr8rqu/VI542FZvxMTcTkCtzye3xvxIL
         Cr2IkTd2UJuWJfmU9n5d79leYkHzUovYbi2ftPoYiNUDhdcWTOw6qpCwpTqsKxCQZ6Iq
         i61A==
X-Gm-Message-State: AOJu0Yxaea+/Hcahpxz/YTfIllBqAoou1vPHEH+rVVF1rU8cpr55Bo/c
	5PoKe60Iq6iayUxEQhwwftSGiwwRZYfbjdcYNTVXmJ65SL6uozKfkU3p9C8qIw==
X-Gm-Gg: Acq92OFFue9D+gtVmZOS9XM+rJnbwi5tkd6r14SpDAQRb7N0ILqs2CrBzLgSpa16Ysm
	JnkYIt8ni/iHxc72rOqk15yqaI3UdvFJDJStjNGjhRrkDNlAGeRcqfgjK2/pmnTXWyZEcHP1zWz
	+OtjGOU9QNZuorYcf43UlVPynHND7vBbroGEfD3i4zsryyDComU97bJM8lq4scmSetgZQ4Ny6XB
	rm/TL/D8lk75miYhM9GxtjqWunBh33i+0NTyAqz1zTPdcflsa5kCigvV1mndFhtPK6xxhYwC8JX
	SJM04OWWfj9G2r/LTrtmFMhIfLAKe/JQh87XPJ+iztgf/+6jslq6ikTYl5x/zRlY0Rrc8Cmu411
	fIQeHHHMQC1BMgNIPhc0sLJNEK95hH43l/KV07l16A+AnmZCELLRPLZdBC4up14//obVK1z6jws
	6NGz151thbioehmmhw3mcyHO2NCBk=
X-Received: by 2002:a05:6870:142c:b0:417:359c:292e with SMTP id 586e51a60fabf-43588a362c4mr8385534fac.12.1778599157112;
        Tue, 12 May 2026 08:19:17 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435573e94edsm12967157fac.13.2026.05.12.08.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:19:16 -0700 (PDT)
Date: Tue, 12 May 2026 10:19:13 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v3 3/7] odb: update `struct odb_write_stream` read()
 callback
Message-ID: <agNEixLnzEVJRL9_@denethor>
References: <20260401030316.1847362-1-jltobler@gmail.com>
 <20260402213220.2651523-1-jltobler@gmail.com>
 <20260402213220.2651523-4-jltobler@gmail.com>
 <20260511175835.GA4811@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511175835.GA4811@coredump.intra.peff.net>

On 26/05/11 01:58PM, Jeff King wrote:
> On Thu, Apr 02, 2026 at 04:32:16PM -0500, Justin Tobler wrote:
> 
> > @@ -1098,9 +1099,16 @@ int odb_source_loose_write_stream(struct odb_source *source,
> >  		unsigned char *in0 = stream.next_in;
> >  
> >  		if (!stream.avail_in && !in_stream->is_finished) {
> > -			const void *in = in_stream->read(in_stream, &stream.avail_in);
> > -			stream.next_in = (void *)in;
> > -			in0 = (unsigned char *)in;
> > +			ssize_t read_len = odb_write_stream_read(in_stream, buf,
> > +								 sizeof(buf));
> > +			if (read_len < 0) {
> > +				err = -1;
> > +				goto cleanup;
> > +			}
> > +
> > +			stream.avail_in = read_len;
> > +			stream.next_in = buf;
> > +			in0 = buf;
> 
> If we hit this "goto cleanup", we'll leak the "fd" descriptor opened
> earlier. We either need to close(fd) here, or do so in the cleanup
> handler (but that means consistently setting fd to a sentinel value
> after we close it, which we do not currently do).
> 
> Noticed by Coverity (I guess this series just hit "jch", since it's
> "new" as of today's run).

Thanks, I will send another version to fix this leak.

-Justin
