Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C44613C836
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567838; cv=none; b=I678m94fJg83uBDY97MZNFuebrrjD2wXsr5yaVCi46HCXhp6kBzI7pdJ2lRSO5XLrPvQDRjEvDncoDF5U5Y8b9u7bvDzeV/bmKY2UCe9+BVvP2v3bNetxRp1KC7m8u2xAHrePOA07op/TQezcd8svrEL2BmdENFHfVpGY2Rxlf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567838; c=relaxed/simple;
	bh=FI9gAsuFwyiOgML8mmjZetQoQt5cRhoMZF6F39SPv6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGF4IklJjBgzRB6fuqeTkKmwHc4sCbGBRzx3OvABlSkvrm2P/WUXlgBKQl/6WW7F4yQaH7xdV0JVj+XSFxE09E9/wrqkx9zwA9xHosAOFlU07KXdb2YjcZgnsGrwIxZwOBr2GnAlfM4aj8Ry2Mp7k6TsdK11pZaOyFOxTLAY6Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cV1XFG9V; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cV1XFG9V"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39f54ab8e69so20915265ab.1
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726567836; x=1727172636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUwg/Uja3CFGlBlLwnQsGExVpBOQ4u83P3tQi3BSfjg=;
        b=cV1XFG9VK9pGptjMaYCdsq8zpKQpcrW+CbjOXal+TIw/GI10lSv2uVHgzk2hCPuLXO
         cPnC6UkYkxvn5rUtlxqgw7wsW/whoo8btqE2msDqsCrgfSfJu/RjxJ5hiHbgkzDMvO2A
         52sUv8xSdKJEMeJsi1/binAUJ4APqtzxbR+uHrDLJI9xCEEMeNtKufmCkR/SczuEBR3B
         T7nGrmotSG5RfwSHtgJelMKR7nz8FkuMJV5kbFwr0bCxyXUAN3O7Oqw3j25o9xlaWoC/
         E8rF+uENCNXpQ88kqYcVQCIF0wTqgksvoTW25tr3UFUD0h7hAjMMS8br/78ZJrRq3hOt
         0JCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726567836; x=1727172636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUwg/Uja3CFGlBlLwnQsGExVpBOQ4u83P3tQi3BSfjg=;
        b=UV1vdc7f11Zt5NpNdyoaJpZPFJ4CBNSiYXaqc1NiKdTgtUHRP4aUrLTmrzXrI+ExbS
         aWMkvnnaH4ZoANb/7U/XV6WePvBmRdwqWcc2MSlL1IraSZPyZy1rM6KNSPbMk4ZMNKxL
         HrcdpMUaH+ttzvdCTfd0PEBIBF9NMfFiayIbxCL90uLkEDm34ZK6ujFT+djk6pyjuqzs
         3jFJCNeM+upRJwCgE9+yYka+5cDtfDPw7Spl/47MZcyi8P6XqDqAQa+sGzA/DTQzbfor
         VvmAVTW6WcuhJXIEIAAn1w1a1zkUiAWWLCHjLVKHm/JyKYOoy/Z/iLJ8aQez7xMkfP21
         5+8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwnY+SDMhUkbQMmgPLl/6uTH95JQcYaVI5C3x6hwaCueRhq3QIckh/anfBGudfuRTHTXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi4fkaTFbE602uFuFBtM1/wumMyyj+hgK+wEAV1VB3SjleLKAT
	6qj8xXqGNzm7Yxvey+XrPj99/YRIqas7lspzAz0ZI8p3qtqOFYF8rVW+ZyfP3eE=
X-Google-Smtp-Source: AGHT+IENrBaxI+k4puzDfLMJdZaYAwBDxY5TJO2ILMfLCNBR3+OfY6bgD56PPP0ZorNigR8qiLF5wQ==
X-Received: by 2002:a05:6e02:1d13:b0:39d:4dab:a533 with SMTP id e9e14a558f8ab-3a074bf1abbmr154761585ab.0.1726567836371;
        Tue, 17 Sep 2024 03:10:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ec3d011sm1899233173.82.2024.09.17.03.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 03:10:36 -0700 (PDT)
Date: Tue, 17 Sep 2024 06:10:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Eric Wong <e@80x24.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 02/10] packfile: allow content-limit for cat-file
Message-ID: <ZulVmP3pBEEajjr5@nand.local>
References: <20240823224630.1180772-1-e@80x24.org>
 <20240823224630.1180772-3-e@80x24.org>
 <xmqqcylvky69.fsf@gitster.g>
 <20240827202359.M464972@dcvr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827202359.M464972@dcvr>

On Tue, Aug 27, 2024 at 08:23:59PM +0000, Eric Wong wrote:
> > > diff --git a/object-file.c b/object-file.c
> > > index 065103be3e..1cc29c3c58 100644
> > > --- a/object-file.c
> > > +++ b/object-file.c
> > > @@ -1492,6 +1492,12 @@ static int loose_object_info(struct repository *r,
> > >
> > >  		if (!oi->contentp)
> > >  			break;
> > > +		if (oi->content_limit && *oi->sizep > oi->content_limit) {
> >
> > I cannot convince myself enough to say "content limit" is a great
> > name.  It invites "limited by what?  text files are allowed but
> > images are not?".
>
> Hmm... naming is a most difficult problem :<
>
> ->slurp_max?  It could be ->content_slurp_max, but I think
> that's too long...
>
> Would welcome other suggestions...

I don't have a huge problem with "content_limit" as a name, but perhaps
"content_size_limit", "streaming_limit", or "streaming_threshold" (with
a vague preference towards the latter) might be more descriptive? I
dunno.

Thanks,
Taylor
