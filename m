Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3418036
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="D+L/6v3J"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-20451bc39b1so6158876fac.1
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 10:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704221244; x=1704826044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2mkbeS4rTj4H8nsVGoJ+CI2a1uShh0G4m8zW08Z9Sg=;
        b=D+L/6v3Jx1eY5yF5Ida9GibDqq/wIRsS0OfzL1Nguh2aMpgJxKXAgG1Bm/i5t9+vzY
         sR1ebeA9ZN4eNHpzIxoFwTJEKd/FCOXoCUNXQ/Jr8aMZWfT2Ky3BfNtMfjD7qP9kDeDw
         83gMiaQsgRuwf7pxOCnf5MmX2CWPi6OqjgHwsSF6COg3qvJHMhKfLN5gv809lufmGxNM
         4D6/PZACg/AoSKFq4oxQW5xi0HD9Rs3Egs/yLr9Tar3b2NeK3jnQFo5ZxhAgEauYOq9g
         3qq0ufeP4jJVqoIGx0YNJCW+Qdy8qAF+Ztl77c5R09q3UWG7kd/Dd/ZVYhFNcN/bcvIz
         J68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221244; x=1704826044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2mkbeS4rTj4H8nsVGoJ+CI2a1uShh0G4m8zW08Z9Sg=;
        b=oZtwninD5GCLsagGyxyT2WRkl/bUCxfJdLPic8x/X8A1pP5nf1CrQXaemLSQCCS7uz
         P4I0xmaYOsBIK0M6UptOnfm+hEIuI7F+LBDi8+ez+M1T/hl2gplL1lP1YNSQasOKtPd8
         SE8n6Vsc+0WcQiffsMOV509hr1vmce2EO/llLJSYLv+qCrmtVz/Zz3gqrOQe2yQ0+BfB
         eaJG0b4Onh7oxj4PoN3u78zN32C4AjhXYUQZCuHfSqbx71++s0uNL15IX8rP3QUGDOrI
         m3u4pey0bONb7YVhHYpGv78tf9DdpGHz/ocBm2vAsdrCfC8mN9c45dm3hss80LSR/grz
         xy5w==
X-Gm-Message-State: AOJu0YxbITZM2iBwRe7Lfc65yVuqcoc1ySQMuVOYwk6vrRk60WSxuJop
	uunk5RuZ4MqRc/MjDapzRujf1YO71BR2zg==
X-Google-Smtp-Source: AGHT+IEsuAncg2QhAtIoNlG+F9mbbnRByfOr0RIgsiyDWtz6D8JmzQcJhcaFvRfxeSEu1XNppanGBg==
X-Received: by 2002:a05:6870:a110:b0:1fb:75a:6d4a with SMTP id m16-20020a056870a11000b001fb075a6d4amr21792208oae.113.1704221243802;
        Tue, 02 Jan 2024 10:47:23 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id wy11-20020a0568707e8b00b001fb238f7e08sm5718593oab.38.2024.01.02.10.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:47:23 -0800 (PST)
Date: Tue, 2 Jan 2024 13:47:22 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, ps@pks.im,
	christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
Message-ID: <ZZRaOhK869S1Sg1h@nand.local>
References: <20231221170715.110565-1-karthik.188@gmail.com>
 <20231221170715.110565-3-karthik.188@gmail.com>
 <xmqqzfy3l270.fsf@gitster.g>
 <CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
 <xmqqsf3oj3u8.fsf@gitster.g>
 <CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>

On Tue, Jan 02, 2024 at 07:18:48AM -0800, Karthik Nayak wrote:
> > As "git for-each-ref" takes pattern that is prefix match, e.g.,
> >
> >     $ git for-each-ref refs/remotes/
> >
> > shows everything like refs/remotes/origin/main that begins with
> > refs/remotes/, I wonder if
> >
> >     $ git for-each-ref ""
> >
> > should mean what you are asking for.  After all, "git for-each-ref"
> > does *not* take "--branches" and others like "git log" family to
> > limit its operation to subhierarchy of "refs/" to begin with.
>
> But I don't think using an empty pattern is the best way to go forward.
> This would break the pattern matching feature. For instance, what if the
> user wanted to print all refs, but pattern match "*_HEAD"?
>
> Would that be
>
>       $ git for-each-ref "" "*_HEAD"
>
> I think this would be confusing, since the first pattern is now acting
> as an option, since its not really filtering rather its changing the
> search space.
>
> Maybe "--all-refs" or "--all-ref-types" instead?

I tend to agree that the special empty pattern would be a good shorthand
for listing all references underneath refs/, including any top-level
psuedo-refs.

But I don't think that I quite follow what Karthik is saying here.
for-each-ref returns the union of references that match the given
pattern(s), not their intersection. So if you wanted to list just the
psudo-refs ending in '_HEAD', you'd do:

  $ git for-each-ref "*_HEAD"

I think if you wanted to list all pseudo-refs, calling the option
`--pseudo-refs` seems reasonable. But if you want to list some subset of
psueod-refs matching a given pattern, you should specify that pattern
directly.

Thanks,
Taylor
