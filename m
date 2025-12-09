Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C3829A1
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765246487; cv=none; b=tYD/XWP2JVaZ8LkkaosQNGtdFz2QxvgfyP5fqKuSOODiDdQ7YoGyzjamWuIBACiv2xW0rOLLIYxhDTY6LSTtk4uUkObOJ1OVb0dRPuJHHg4vN+kNBxsvhNljRep/lDiqgrBRAh/9rCJNA6H+hVJucSv446iG5qe0tb9o+RCNEsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765246487; c=relaxed/simple;
	bh=6GKVGdBX4M6pRSrCZV8eArjhiFF1mVulPnUN5iFbJnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gj8IHxDpeKaqO5+sKeTh4ng4Rlu7PS3fZ37e1nP4M86sPzaoimtOfXX3DDxsznTNhOFAgyb/9ZRxXxe3UnRgs7qOClNzFYYoiVpIWO2oUUjAwNkT9L+SrcTbL/mpIMzHL0Ab19gTFmiFGF/dDsxsfIqlxZk5sADYgwJul7C5zKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=B2i3aiAE; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="B2i3aiAE"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6442e2dd8bbso3890058d50.0
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 18:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765246485; x=1765851285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ECJbCJkEIGHtjKSFH1FGX73A6n19eNWJePyau/QeaZM=;
        b=B2i3aiAEv+nhanakWsXuP/UauEc+jPRLwqPCg72638DG5yRJlQTU/md6tJpzCF030k
         NvraeZRCKLKYAdoR8Oa/PHAIL2ukfHlVOGi61P4o/ZIYeksV1Zfq5smemKAheiV5dm+W
         tGJXUjuynZky3GOfMgLyumFnrllRSjB7Ra0r/tMnZ/dTAlfctrIb67uDHwoLlRmynTsk
         qU8MzGvSAvUEDGn/+7dJncNptc12j0mCU+cz6HaEP4e1GCM+8zlvlxNsJESHWxb3cdWS
         HHJSE4dQHiFuckkUT9UiPP+4marpDw1jiU5Dsddxqw18O0IdNOhZ52Jjqc8y/StY4zTQ
         B2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765246485; x=1765851285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECJbCJkEIGHtjKSFH1FGX73A6n19eNWJePyau/QeaZM=;
        b=eki2jG0PA9gPb9Okuhn/tTl4fCuNAH14ukhuwv+U3vjTzrMH+9nRPWOBIqeEkAEiOh
         YS/OZBWyU5ha/uwYEDs5j9UK4+ExHvB2Yj5rMBYBz4FxeOe8aPERYneEZaOYX9EAHH+P
         WxH/h6iNahROMVhxNlh4OeOS3O1YGl9lRjJFKo9HiDQfBWNW8ynUkJnzLia0G+VJ+U36
         /quWf6YsFZHnT/JHmcKzG9hkBdev2iQHz64+dGFgNt4JtXdTICimoLaGhCEJlB2KvkB5
         1l5+SMdABLhuLV0yMM+ofP53nA90mxhF4YcvLbpIPoMrVW5eJeenx1qgRum2bjYFwr2s
         R1FQ==
X-Gm-Message-State: AOJu0YwTF1kK91ApKr1ZtIHR5PJ0n297p3X8Q5zUvwAo/mLP9Lh0UTFj
	b8m/9zbgx5NckNSr9bdUJKFCsTKEMTxyH94/4GvFgOg32XZalJs3+LLZUMuz+nw2cj1WoFZHSxZ
	WAe7nuiA=
X-Gm-Gg: AY/fxX4ezuHTi8PiTyuM4VANtMmGL5M196iQZ7zK9kc9UJfMkPrw2CsZiEUWIlRkSEn
	1opmaXlEO+eC64Xi5reBLCRYFIXtboae3w6k1bk+cWdMtALgWD6RyNZIEMedHe3rH213E55RSp/
	E5vWE5YdpirIEKCaxe7UTrwrvU4vOQ5BP79i7TybkvVW8H7hpzBBZdsHpNdevLRAcqwjp1YfU2Z
	kAKYkwuG8Ncp/Xc4KjwjvCP1MG7qR1NYHU7jQWf5Sp/d1ws56iVitJZ1Sh0r9ODUw0Q2dzNUqPD
	Jr/KGLgaNBLthQzccrByW/o2pPDpT0OOXRHqum4DGQRBV5chjqNhhEw3m6uDpTLy06tfVZYSKgF
	yEE0q8CoCTQNbhrBBXkYzJtW0CChMqgWb3B1oaqnpAzW2xJu33ZRw8dUSWkXwI6AakFVfOUQayA
	6lEfAxzc6iHgxMaM6mMJl/Ig7QDSyLcwRLW0Jny2Z9JuHFz1PHVApf2+qE1Cu5Y3WPYqm9Lq0mY
	0T5vfANdQ/RVuP8Ow==
X-Google-Smtp-Source: AGHT+IH6qIbQb4Y8hlLjFXYCvCWXMRTt0kxiVee6+zYPTIfvhMs4PkYBHLbjIBS8Y/Cppn8hQk76yw==
X-Received: by 2002:a05:690e:245a:b0:640:db91:33c4 with SMTP id 956f58d0204a3-6444e7678bemr7181060d50.18.1765246484690;
        Mon, 08 Dec 2025 18:14:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b77925asm54802407b3.36.2025.12.08.18.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 18:14:44 -0800 (PST)
Date: Mon, 8 Dec 2025 21:14:43 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/17] midx-write.c: enumerate `pack_int_id` values
 directly
Message-ID: <aTeGE2qplVC+kE/c@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <8288afd8cc40a56999353643f49c48d610e6b3aa.1765053054.git.me@ttaylorr.com>
 <aTcYfOZ4_GdIwM9b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTcYfOZ4_GdIwM9b@pks.im>

On Mon, Dec 08, 2025 at 07:27:08PM +0100, Patrick Steinhardt wrote:
> On Sat, Dec 06, 2025 at 03:31:37PM -0500, Taylor Blau wrote:
> > Our `midx-write.c::fill_packs_from_midx()` function currently enumerates
> > the range [0, m->num_packs), and then shifts its index variable up by
> > `m->num_packs_in_base` to produce a valid `pack_int_id`.
> >
> > Instead, directly enumerate the range:
> >
> >     [m->num_packs_in_base, m->num_packs_in_base + m->num_packs)
> >
> > , which are the original pack_int_ids themselves as opposed to the
> > indexes of those packs relative to the MIDX layer they are contained
> > within.
>
> Sensible. I was confused a bit by the previous change because I couldn't
> quite spot the shift happening. I think this makes things a bit easier
> to read.

I'm glad that the end result was more pleasing. I have gone back and
forth whether to enumerate [0, m->num_packs) and shift, or to enumerate
the pack_int_ids directly, so it's helpful to know what style others
prefer.

Thanks,
Taylor
