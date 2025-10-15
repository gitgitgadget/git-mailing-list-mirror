Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B72ED16C
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563296; cv=none; b=vCMGBlbSUP++oa5HwZeYuUO6UyE2cxCuUCCnJr7/ZU+Ss/WuGB2gqaQueRo54EM1ppE1ZFQf8sfBM3WmqUxWrqfy0zg1XpvHFYjzUrdzj1m4vhexvmUGqWhZwGjOrKDGSLzhQgp5NjPRFJxTQ0u7kGyBx9qdrYzyduSrkrwwduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563296; c=relaxed/simple;
	bh=/gvzkZY31DYET4dGV6F392o3TcCezNKOKyPmnG6WmVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZatadaoftxgyJ3+dMYfVcIEZLWjArACNgblcPNI7Jtu6XOUqrG1vCEihwYrwLv7I1pjUgvkiQDbgdFD4cdSj9V27NoTZ6LgYLmNErGd83dAYN+A9gbuWSkAz/dxPSV3m97on/doqgP87ewaTE+oNcrGvII3t1zI6IpwahpymXRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ETiy5IQt; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ETiy5IQt"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-92c4adc8bfeso3590939f.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760563294; x=1761168094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plcMhv+USMbwqniUtaXXDvddRMJNsjfi+yobrMXnjl4=;
        b=ETiy5IQtuKUh/wBehW7ReTwuVY642oOuIn779pBI9Wj+pcsYC3rQYO1LIrnrPlcjfw
         HQOCgi8un3dw3boAvHvRnwuK7io7rfE2ikb4Z38lOtA1qACKIRZPmSuD8qweeOBEL8UF
         xU1I+BYIdlO/j0ErEkm3MNzbfIGqFxagTTzGE00XBsbtm/LHJsEiluwcj8CICOTR0M7A
         mwB8+l7l5uEh+rlaN9mgGrAJzhBMu/7ZheGaNiIxraljqO+4Z1wrfDUoFa7Byzz8Dr5M
         W3rnpAE6UK4OACh+fYJFD6PUm77Erf+FBSWF7ZY687KOaarz9NQyMpDdCWIMy5c6wQUI
         sKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563294; x=1761168094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plcMhv+USMbwqniUtaXXDvddRMJNsjfi+yobrMXnjl4=;
        b=uStImesIdy6tg/OkGbJutq8mLiQzQVokUav7ooEv56hhRgSMQAjva6n2TCUM5T6jaO
         DsZVu1pWYtqpZiL4GtYI+PCfkp4/LjEEpIGyQgQ6HJ4YtGyUbr+C1kyVl+L2oxrs8Fm7
         MNcXVw5O/u0eUMGtMz49E+wjPx1V1eU5E9WW9eUsWwNGCVSj97saDVTAi06ORr/PCRSd
         4GMKvLa0AhqagTD4SI3ODlZvo2beMdBTJllES/ATUL06Y6/pjMRY5ueJoPuNBc7Z454G
         MkGUMBqZAYB++chR30gLelLg3pqYYHglT3LI2HHSp7X5NkbOj9JmtvDCbLC4Sj5HWY6M
         rV/A==
X-Gm-Message-State: AOJu0YxCZ99oGR01OaRyeRNqDCJ4PayzyF1109RJIMx7K0sTLheHuN/W
	Md4KnecBqoWVrNNIw3FyJkRipbR7mkdcPRzp6vw1iTNOdrcMb6//KEDV56gE8CakO0xU1Mpjy6u
	2ogd3cjARkQ==
X-Gm-Gg: ASbGnctDqw0D8DjaCcwMS4yBi5XzZbwrFvFiqU5LCYLKtk1O7OAKS9PE5qfIG5Dy7cX
	pl/8BZhkzSXPqqVqAt+EnsBACBAqaH7p1xKt65hkxaSkEurXe/25DQypv8LFMI+QLs4gumZL+ne
	1H4ni1LlciQD9ES++SLFbjr7YDphGkp0Nkoeu5aS+ZXhl8khmNw9HFPW6naE+vuXUQ+uhtT/VmP
	fb2Uvis/bQJi78857KXvzLy60byXbqHt8GER79yAlvJ068mRy4Y3+84crwYiaOM6Y22Ua3IPhfj
	/hQIjR/eSKWXzckdJSVgXsWROJXZlL+EnssCD4zXgfOTt+iEtCoIsy6gsrF/9vVOKzKwXjDTmpH
	fKd5KTEHj85LYfu8+cWnBYydQZDZn8nJXoWUMB661jQbf+rI8cGYBZxG+dv0UGUkPUed02aDePv
	AvBxXWzbv+KHxBAZ7MqmbScXd/OiVW3o2F7i8HNoK0CSZcZaPGaXi6bOuqoR4Sym0KVHAZzrXxn
	Fh7bqo/Re/x4YTkW6Sy3eT1Vq95
X-Google-Smtp-Source: AGHT+IGDUnUpTLmiCY+1bpJgHZ7umTLQU4I1u/6ale779nu1E0wX7T+dqcjXYGswUw2b7rFoFQHJHQ==
X-Received: by 2002:a05:6602:60cc:b0:93b:b7e9:95c2 with SMTP id ca18e2360f4ac-93bd182ef7bmr3862607539f.2.1760563293711;
        Wed, 15 Oct 2025 14:21:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-93e25a659e1sm660734639f.19.2025.10.15.14.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:21:33 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:21:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 43/49] repack: extract `write_pack_opts_is_local()`
Message-ID: <aPAQWwfw+GjdZ4Yq@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <1fbe3d0d7f37840b2d9faf6f62e94abd6a664ded.1759097191.git.me@ttaylorr.com>
 <aOj8CUgapqZEhnlK@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOj8CUgapqZEhnlK@pks.im>

On Fri, Oct 10, 2025 at 02:28:57PM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 28, 2025 at 06:10:08PM -0400, Taylor Blau wrote:
> > diff --git a/repack.c b/repack.c
> > index c4326a532d..7af297ae48 100644
> > --- a/repack.c
> > +++ b/repack.c
> > @@ -77,6 +77,12 @@ const char *write_pack_opts_pack_prefix(struct write_pack_opts *opts)
> >  	return pack_prefix;
> >  }
> >
> > +int write_pack_opts_is_local(struct write_pack_opts *opts)
> > +{
> > +	const char *scratch;
> > +	return skip_prefix(opts->destination, opts->packdir, &scratch);
> > +}
> > +
> >  #define DELETE_PACK 1
> >  #define RETAIN_PACK 2
> >
>
> Now that we accept booleans in our codebase, should this function return
> a `bool` instead?

Yeah, I agree that it should eventually return "bool", but I don't want
to make the change in this patch, at least within the context of this
series where I'm trying to keep the changes-per-patch as minimal as
possible.

> > diff --git a/repack.h b/repack.h
> > index 46d2312fa9..16f2de2ea9 100644
> > --- a/repack.h
> > +++ b/repack.h
> > @@ -40,6 +40,7 @@ struct write_pack_opts {
> >  };
> >
> >  const char *write_pack_opts_pack_prefix(struct write_pack_opts *opts);
> > +int write_pack_opts_is_local(struct write_pack_opts *opts);
>
> It would be good if all of these these new library functions could come
> with some documentation what they actually do.

Fully agreed. I think there is enough here that I'd rather pursue this
as a separate step, but at least this series moves us in a good
direction to document things by putting the functions in a clean header
that is more amenable to documentation than the builtin is.

Thanks,
Taylor
