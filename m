Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500B3156E5
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gtJmSRgr"
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459C513A
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 08:44:17 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-49d6bd360f8so2389869e0c.2
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 08:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698248656; x=1698853456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ9kFrGIW1bwEDEyqb4NjpecByHUh8cKYQRehwD/neQ=;
        b=gtJmSRgr/Ll2JrPMMvnJHlO57E6rs2jqsqll/OYs09eGZxFldxE4V8azI3cfqqcn/g
         N/xmIN4G5V41iAgDNaCtfgbTrIi9d1qd5J5Frz6/ZDDC7e9Ce63r311sShSgsKVxCGaS
         UxcZgF859KvXRRHA+d+F/zOxQiEK+80BrtHo0XkK34hHJwjQzU71OUK5Q334hC6lfy0N
         2XU0fshxlpJFX4SP2lcq+xYuOqP9yEzkcXarCkVH1ymP1xdbkVGdDVxbHK4nqeN3swmT
         K+kEYQVbpqQznyPYthAiLJN8eS9BTyTmJord4WfUrAqDd4cZtIE283zfbotssuhm+0ot
         npxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698248656; x=1698853456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZ9kFrGIW1bwEDEyqb4NjpecByHUh8cKYQRehwD/neQ=;
        b=t1yimAC+WrLT4/dJ790gMWF/pDgTGRwWUmggxrDSaaLeO7v0L0j7LdSLQY20o5H9dD
         yYHde4NeI/IBxNaX4IOyRjRFq/vDeq1Sm5/4is1w/vhCLR5GfVr+URHKXQpRh4rExx+I
         hngf81OVTdobN4rpdZIbNHIWot5iT4U78Wz8df1p0Hx6iKshcDCJNnxyv86zZ30mVIqD
         1ZOOs/QnZBddYXZ+7wdAvbi91RKL8SVBMHqgzBY9df4yiw7wJ/+VWr3t8vN1HLqsGt/X
         NNaFygp2gNlskfidPpj2dz465xeG6cHqxliGSttDjpfzQPqtt9w/IgWGuCvInFrvFy3l
         CKrA==
X-Gm-Message-State: AOJu0Yzj+6uBNcY3nnP73j11e3izGPKSOtg2d63eDd9sAXUuLFCAtskb
	KKS+UFq+0D9h7Vix5nLWRYnf7Q==
X-Google-Smtp-Source: AGHT+IF3lXs1t90h8G8ch3qndbdTNQIcHBwlorszQFdKsHGDf6tvbNZTy9gKe6b/UsZgU87b8f2Qtg==
X-Received: by 2002:a05:6122:2020:b0:4a1:a334:57f6 with SMTP id l32-20020a056122202000b004a1a33457f6mr15127138vkd.1.1698248656196;
        Wed, 25 Oct 2023 08:44:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a18-20020ac87212000000b00419b5274381sm4297957qtp.94.2023.10.25.08.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 08:44:15 -0700 (PDT)
Date: Wed, 25 Oct 2023 11:44:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/5] bulk-checkin: introduce
 `index_blob_bulk_checkin_incore()`
Message-ID: <ZTk3zoncT6nvV3aQ@nand.local>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <d8cf8e4395375f88fe4e1ade2b79a3be6ce5fb12.1698101088.git.me@ttaylorr.com>
 <ZTjKjkRMkmCuxDU1@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTjKjkRMkmCuxDU1@tanuki>

On Wed, Oct 25, 2023 at 09:58:06AM +0200, Patrick Steinhardt wrote:
> On Mon, Oct 23, 2023 at 06:45:01PM -0400, Taylor Blau wrote:
> > Introduce `index_blob_bulk_checkin_incore()` which allows streaming
> > arbitrary blob contents from memory into the bulk-checkin pack.
> >
> > In order to support streaming from a location in memory, we must
> > implement a new kind of bulk_checkin_source that does just that. These
> > implementation in spread out across:
>
> Nit: the commit message is a bit off here. Probably not worth a reroll
> though.

Your eyes are definitely mine, because I'm not seeing where the commit
message is off! But hopefully since you already don't think it's worth a
reroll, and I'm not even sure what the issue is that we can just leave
it ;-).

> > +static off_t bulk_checkin_source_seek_incore(struct bulk_checkin_source *source,
> > +					     off_t offset)
> > +{
> > +	if (!(0 <= offset && offset < source->size))
> > +		return (off_t)-1;
>
> At the risk of showing my own ignorance, but why is the cast here
> necessary?

It's not necessary, see this godbolt example that shows two functions
doing the same thing (one with the explicit cast, one without):

  https://godbolt.org/z/f737EcGfG

But there are a couple of other spots within the bulk-checkin code
(specifically within the deflate_blob_to_pack() routine) that explicitly
cast -1 to an off_t, so I was more trying to imitate the local style.

Thanks,
Taylor
