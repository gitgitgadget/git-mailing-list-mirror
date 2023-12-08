Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="OUPuDyWs"
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060DD123
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 14:48:30 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b844e3e817so1723861b6e.0
        for <git@vger.kernel.org>; Fri, 08 Dec 2023 14:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702075709; x=1702680509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a4A2aGEfMFDK84g2ujJzKyXnc+2ltCWFA8Z3k/2j8VY=;
        b=OUPuDyWsZMcJSqmFfom5fxTuWHbsbvNfFML/p1DRA47pNaH8E56rFQR8B3J1jRixMV
         aan2B3v02ck5H6zsxeZgIk+gzORfYrihlooU7c5kjuyVcUOWZIUb4ELAKegth2HGfB4j
         13Wj5SrbQ4qoPbNmn1tAX8F4k67b02XMFykazb/AFdpul2oeYq/b13uPpyz4QblErwUt
         1Qj3UvF3OvWfvzXmRG8w0qXEJRXNGzl/XZ1YnwV8m0/w8XdZxOnywgItXChGzAWAQxJ3
         ZgRK84kAffraJp3tkaQmcai6PTdi3HDGhPvIxHsY9vFQoMwy7VHuUtPVg8Y+Otq41VMK
         P4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702075709; x=1702680509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4A2aGEfMFDK84g2ujJzKyXnc+2ltCWFA8Z3k/2j8VY=;
        b=Lxx0BGbu7BF27XuaCPiYGXWSemPwezIPsNZs/nhfHOwolTetIzBM7HL9Xt2pw2zxEG
         Q34BNAW63yZQSFTB5gey685JY85uiJFtYq8bSUQyHVEPK0ZCQJhlzuSuICb/SKrTSH86
         3x7XG/4VQ4WYb3q6AqSTIEFXe8E6f23lQL3r9lbLrvAxg+Fo+WPwCscj76d1tnUBRMuc
         WNtYW3GU02f6VqIU5W353ao0TkDInTFJncGY/BZRbEcLCLkRMieSmzUovet4pZIAuPSr
         8lKbz/qERmeq3bBO3crxl8srOggRrfPqZWMWV5IoDaHLabJGsYVssxYBbUJIh4sUI/hm
         L/3g==
X-Gm-Message-State: AOJu0YwtypQKT7I1SBGptzWnDgoAD4osxQy3YCDkB+R33uCuhrq4vW2A
	vhZ13+DMxHsuR0gqsyeApIQuRw==
X-Google-Smtp-Source: AGHT+IGC1I5Bc+VFXR3NDNzez2QeoDDg0XdF6SgZL0eLhThavqvqlwhOs1cC2xcRUrhDLVh9ZoEPdQ==
X-Received: by 2002:a05:6808:201e:b0:3b9:ec87:849 with SMTP id q30-20020a056808201e00b003b9ec870849mr1080699oiw.74.1702075709314;
        Fri, 08 Dec 2023 14:48:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id br16-20020a05620a461000b007659935ce64sm1002263qkb.71.2023.12.08.14.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:48:29 -0800 (PST)
Date: Fri, 8 Dec 2023 17:48:28 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/24] repack: implement `--extend-disjoint` mode
Message-ID: <ZXOdPLotcS5daNke@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <b75869befba26899d88d6c6d413cc756aeadbd80.1701198172.git.me@ttaylorr.com>
 <ZXHE5Lce_6CAWKFT@tanuki>
 <ZXIq4mjDUoqlGvgW@nand.local>
 <ZXLRjeu66qE6J1K1@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXLRjeu66qE6J1K1@tanuki>

On Fri, Dec 08, 2023 at 09:19:25AM +0100, Patrick Steinhardt wrote:
> > Writing this out, I think that you could make an argument that
> > `--exclude-disjoint` is a better name for the last option. So I'm
> > definitely open to suggestions here, but I don't want to get too bogged
> > down on command-line option naming (so long as we're all reasonably
> > happy with the result).
>
> Yeah, as said, I don't mind it too much. It's a complex area and the
> flags all do different things, so it's expected that you may have to do
> some research on what exactly they do. That being said, I do like your
> proposed `--exclude-disjoint` a lot more than `--ignore-disjoint`.

I think that's fair, I renamed the option to be "--exclude-disjoint"
instead of "--ignore-disjoint" for any subsequent round(s) of this
series.

> > > One thing I wondered: do we need to consider the `-l` flag? When using
> > > an alternate object directory it is totally feasible that the alternate
> > > may be creating new disjoint packages without us knowing, and thus we
> > > may not be able to guarantee the disjoint property anymore.
> >
> > I don't think so. We'd only care about one direction of this (that
> > alternates do not create disjoint packs which overlap with ours, instead
> > of the other way around), but since we don't put non-local packs in the
> > MIDX, I think we're OK.
> >
> > I suppose that you might run into trouble if you use the chained MIDX
> > thing (via its `->next` pointer). I haven't used that feature myself, so
> > I'd have to play around with it.
>
> We do use this feature at GitLab for forks, where forks connect to a
> common alternate object directory to deduplicate objects. As both the
> fork repository and the alternate object directory use an MIDX I think
> they would be set up exactly like that.

Yep, that's right. I wasn't sure whether or not this feature had been
used extensively in production or not (we don't use it at GitHub, since
objects only live in their fork repositories for a short while before
moving to the fork network repository).

> I guess the only really viable solution here is to ignore disjoint packs
> in the main repo that connects to the alternate in the case where the
> alternate has any disjoint packs itself.

I think the behavior you'd get here is that we'd only look for disjoint
packs in the first MIDX in the chain (which is always the local one),
and we'd only recognizes packs from that MIDX as being potentially
disjoint.

If you have the bulk of your repositories in the alternate, then I think
you might want to consider how we combine the two. My sense is that
you'd want to be disjoint with respect to anything downstream of you.

Whether or not this is a feature that you/others need, I definitely
think we should leave it out of this series, since I am (a) fairly
certain that this is possible to do, and (b) already feel like this
series on its own is complicated enough.

Thanks,
Taylor
