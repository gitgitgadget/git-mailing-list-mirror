Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946851A724
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jXy0vOjd"
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA269B7
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:46:24 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66cee0d62fbso26504476d6.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698086784; x=1698691584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXH6YjGsttyu6wmjlVg8aLq/4jVQZoD5WR5U2o1xmJ8=;
        b=jXy0vOjdoua+XEQ2ToW/75G4TBFGcoqQ/bNTW+kqQXEgiezcky7nVrvB5y7FnIpLdY
         zvpFJC07FCz4m8Aw2eHE87BpFTW6cuXeLniW+11mn8zKrYTq/kCiDNTeYlcQoZk1g7LE
         GopzhLfLFpVgft3NIoVST/yuPiEfKZAFg2C8XMJL2+McAmdqk5/9mawi3238nLYrjFgP
         ykV9cUR6QiTz9UT5dUPU5KevEoX6hDpeksOBHwBu+qDhJvDGqQbyrLlwd+fbNY5/uCBR
         njnPELsaIsUaeju9mS4MMYKO11RoPNSNSuroWgUBLVFIQx4r8bRKO2jhzTEGo8B9cHx4
         RMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698086784; x=1698691584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXH6YjGsttyu6wmjlVg8aLq/4jVQZoD5WR5U2o1xmJ8=;
        b=bfn3KayZEj3a4N2Fz7tzHeuPVOt/aMSQI01e9/rnC4ew062qLDF1RNb63Ad6kUkBzm
         8b8JP9c8OUYQwdCjtSExpB+pJZWp6Q4KGVVHXn8H8BWS+b+6AAzRRlYTqYxZR9XPVKLR
         +npRvhONCYzgu6wBAr6lSBcnQ611oPMJhRbqvGV1FNkUmYek9pR/82JZAwYf2vTYGDYj
         sh3yviAuvN8UPBi4M66vj0biTiNWGVxxeCmiRB6qKWIlbGz8YF/uhYMYpn1EUHINKdMK
         LdujalDqnmyYdm3N1CzaWDDtirCNn76WawhzDiCF1rBuIgBYopreld4Ao3QNM/lWEfxf
         /k/w==
X-Gm-Message-State: AOJu0Ywplm323Id59/5PoBxe3CTrA7TjfO3z49g3g+xhBdthonxMtPzn
	MRjQ/3BI7IzyrhobPkIHq50ZWQ==
X-Google-Smtp-Source: AGHT+IGolTCCbO46l0He+sQWeJkeNbx01l8+6UjiCyjKvtxf7PHetff3iGNi7zHFzQrFtO4ZFfApKA==
X-Received: by 2002:a05:6214:e82:b0:66d:25cb:43ba with SMTP id hf2-20020a0562140e8200b0066d25cb43bamr14950816qvb.20.1698086783578;
        Mon, 23 Oct 2023 11:46:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ki22-20020a05622a771600b00417fa0cd77esm2885591qtb.80.2023.10.23.11.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:46:23 -0700 (PDT)
Date: Mon, 23 Oct 2023 14:46:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, glencbz@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3 1/5] config: split out config_parse_options
Message-ID: <ZTa/fvfuPN+JJx89@nand.local>
References: <fa55b7836f112cb7c7ab9b80e745b9969421c768.1695330852.git.steadmon@google.com>
 <20231023175217.984090-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023175217.984090-1-jonathantanmy@google.com>

On Mon, Oct 23, 2023 at 10:52:17AM -0700, Jonathan Tan wrote:
> Josh Steadmon <steadmon@google.com> writes:
> > From: Glen Choo <chooglen@google.com>
> >
> > "struct config_options" is a disjoint set of options used by the config
> > parser (e.g. event listeners) and options used by config_with_options()
> > (e.g. to handle includes, choose which config files to parse).
>
> Can this sentence be reworded? In particular, "disjoint" is a word
> normally applied to two or more sets (meaning that they have no elements
> in common), but here it is used for only one.

The pedant in me agrees with you. I do think that the sentence reads a
little awkwardly. Perhaps instead:

    "struct config_options" has members which serve two distinct
    purposes. There are a set of members used by the configuration parse
    (e.g. event listeners). There is also a set used by
    config_with_options() (e.g to handle includes, choose which config
    files to parse).

> Everything else looks good, and the reasoning (some functions only use
> a subset of the fields, and this subset is easily explained conceptually
> as those related to parsing) makes sense.

Yup.

Thanks,
Taylor
