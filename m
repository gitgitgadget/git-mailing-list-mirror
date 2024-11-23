Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17DF4A0A
	for <git@vger.kernel.org>; Sat, 23 Nov 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732350250; cv=none; b=JV/+iScpQvA0gqKRfntwGn6W/kH1mtRGQEArEYDXRHuQGkRirytu/HX2Kv1rSrRwnavNo2OUB9SDXk+qMLE31W/rEZ6TzHcZwW7Plt0w67wFTplUb5yU5viVZ81udn4b1T2qI32dwITUs0lE5eqQfUWULXc8lFl6wErlxJ4Fx2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732350250; c=relaxed/simple;
	bh=B5Qci0lNLNJKIHxqCnYyBT9bKtpc8YNZ6SFJ+ZHqgp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2+RTYHwlGqoINz8vgNS2GScIpwtebN11x8+kKVz3bJhsWuAqS3T/mC59L/4dJkKZhBdQWX9mPpdpETU31Zvd4cXda5afIEGcZ9LAgImgzRMosjrW5OvAiqLaoPOgg9r3Xg2lyn4P7lnVBIrUsKLqV2uESQENZNMWCtDdUkQlxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9LzBn1b; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9LzBn1b"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720d5ada03cso2712361b3a.1
        for <git@vger.kernel.org>; Sat, 23 Nov 2024 00:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732350248; x=1732955048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ct7YxxRZPxjuQmzikpNnJjtBWxOBsWFO1gcHeIvi528=;
        b=R9LzBn1bah/yPFi64tZd02D/EfUXHy/Foik62tAtAH9PzNULm6Yo6eeNe8V3oXNzaA
         SyoxXuhQ6rUideZ+HCgfwSkwE2hm6wI/AzirEDy+Q1p63xAO3I+uRBqElP9z36q1SE+w
         7nWPD7omViLO0kywOYKfAFTzSyPGRseTsIJN7JN4lDEvbOSunPD53yYPbCADBH0WL34X
         acvog8inqRGOF7eH3t1ah/Mbsj03JZ3RqBZNs2kc0A3bjPXIQX8bt8xgr3zbCml7IPAE
         92XiyRF1TqAxy2HQtYXEJaTjAoXEM4yifAKm2ceRdd1GLD4+5Q5ZYILSVgKmzxNgWOeP
         VVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732350248; x=1732955048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ct7YxxRZPxjuQmzikpNnJjtBWxOBsWFO1gcHeIvi528=;
        b=Q2oQTgYvRjI3mwAYW8BfZhh3UhfvPbEaNTbr0IL4xSKGMFz51mV9alGlEr4vYZz7L/
         NklfEmdCrjvcvwg2HG9jRxIFy5IBKBCOCjZPINnbejY+CM7bRGUtr5b4ornkmQthxTNV
         R4L//S6ZRWgUf8lPP+EFBLyq4omFXKyUnwZPJwnPyUX8NJWN1N3nPGcMNTrVKbHTbHDC
         HA1cDIiuM0PYmcM1SrP7MYTTxIGwTecBOnrri+/IJ3oiX67cX0gzt3pWn0HiH+LtZaLO
         al1RbOvu7k2Gx7OtCMdU6FpvC++uAcSMlFgI4AJajaO6Fks1SXmTgL0dtCsBlIgEUoge
         ZwMQ==
X-Gm-Message-State: AOJu0YxLIbb2gWZR6LOdDfDJMX/rOVFxiiuafMQPLuCrWd7J1rhgMdBn
	wsQYE1X+mmMwEbN0Bjd+1gquS88uax2o7JY4TaXnyGJUq3rYgxcKJXSRxg==
X-Gm-Gg: ASbGnctLYGl4ubXS1RXi8MkQ9TEUwkUoTu4ghWkISFB9OCovhJ4X3hRPQToCNzkiXmR
	JS8iBdCxb458t5JRLkBYCxPobxS8TJs//GpbLQjqEEzIviLHsvCtBSlWM7VWLLu0U/8Q9W0NM7Y
	4JQ7EFHDroNJjXZEx2eBtmxMX3isn7XasvwonrCg4pgXoCD5lG3+l6zrTwBpaghajX3cKCCHc7+
	t1qgiV9Qv23YNZK6/ePHF07F1o9II/3xa//XzaE3ZJu1Q==
X-Google-Smtp-Source: AGHT+IGe7ZB5rGw5+f85ii+Iw6DCCM6atQloIT5I2H+chRwkdZY4X8q/jhHJz33/r+K7UlVUFRgx6g==
X-Received: by 2002:a05:6a00:9297:b0:71e:82b4:6e6e with SMTP id d2e1a72fcca58-724df3c27d8mr7111573b3a.4.1732350248151;
        Sat, 23 Nov 2024 00:24:08 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454be0sm2841601b3a.12.2024.11.23.00.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 00:24:07 -0800 (PST)
Date: Sat, 23 Nov 2024 16:24:20 +0800
From: shejialuo <shejialuo@gmail.com>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	=?iso-8859-1?Q?Jean-No=EBl?= Avila <avila.jn@gmail.com>,
	Linus Arver <linusarver@gmail.com>, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 1/3] refs: keep track of unresolved reference value in
 iterators
Message-ID: <Z0GRNGQEeoOQHKz3@ArchLinux>
References: <pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
 <pull.1712.v4.git.git.1723217871.gitgitgadget@gmail.com>
 <c4f5f5b7dd8dad4f17201611faee14dd1b882bff.1723217871.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f5f5b7dd8dad4f17201611faee14dd1b882bff.1723217871.git.gitgitgadget@gmail.com>

On Fri, Aug 09, 2024 at 03:37:49PM +0000, John Cai via GitGitGadget wrote:

[snip]

> @@ -66,6 +69,7 @@ static void free_ref_entry(struct ref_entry *entry)
>  		 */
>  		clear_ref_dir(&entry->u.subdir);
>  	}
> +	free(entry->u.value.referent);
>  	free(entry);
>  }
>  

Today, I am learning the source code of the "ref-cache.[ch]". I feel
rather confused here. And I think this usage is wrong.

"free_ref_entry" will do the following things:

1. If "entry" is a directory, it will call "clear_ref_dir" which will
call "free_ref_entry" for every loose ref.
2. If "entry" is a loose ref, it will call `free(entry->u.value.referent)`
and `free(entry)`.

The problem is if "entry" is a directory, we will also execute the
following statement:

    free(entry->u.value.referent);

This does not make sense. We should never access the "entry->u.value" if
"entry" is a directory. So, I think the correct usage should be:

    if (entry->flag & REF_DIR) {
        ...
        clear_ref_dir(...);
    } else {
        free(entry->u.value.referent);
    }

Thanks,
Jialuo
