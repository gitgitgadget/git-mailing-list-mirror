Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jTSUnRZK"
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229B7D67
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:39:44 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67a73619fc4so7538826d6.2
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701373183; x=1701977983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ciqqzFjMiG/up5E3qpYMK9t+Vkf21R+w7dpwIWzAb/g=;
        b=jTSUnRZKZ8Kl1uzLjL8tdwktuIDicJBWhQIf5dFd4NuxbFeg0E4TUu2VBmtrtUVq0m
         AeKc1UxQ9yThhOBqiVT9EYB6ietFAiSCNb8QHv/M+h3PjS8iGfArUKoJkx3fc35ZMXb5
         3e164srKqIDOJHirIgbn23/8rI3MxO3GGS41gDkni2J0upJ5KJ46VhyVJLvdZBOYI1PE
         N5mlmY8KGrkshMnDZUp1oWMdQi6vTCJok6XegRNaVQlGGyOmefNgFe8DWZcpLmJJ+wLP
         GhIT4sVNju4hvGTsoGvjcwGfCoVMYFcxj9gE7EgPVT6+ukI9BNoAyEXxiw85S67SkSM5
         soiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373183; x=1701977983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciqqzFjMiG/up5E3qpYMK9t+Vkf21R+w7dpwIWzAb/g=;
        b=ImINt2hI0/hMjCZg+DdpuX8CTPs2m13J9rmerVSnjreAlkGY7eYCqE1B1+Trd7Xjg/
         S11GT+o4HYTdnyv3jW82Mt8mentIErtHNjLJjU9hoPggGYlDjYceWrNnUE4p/20v0eZH
         jEmQmVNb7TNKxJnGPaKS363HYkDhlBos14jCd4EcAfdgDrpTTbisKsSX0+vu69J0IGch
         0yZmBuWbBV8ClTUkLAV+dsav60O4LWfQFGDSM5oiU6w+VqJ9JEtLC/rM+rNcFH3zTwRb
         iwWlwvJK5QVKyhOhfrOmnAtBQ6ftGFKcHDw8Rym+veIN/kqPRiycMtJqsIK5Ta8YSJpe
         UESw==
X-Gm-Message-State: AOJu0YwhQoesKaNeGg0C/Zi9W7r1HZ8zXt1Gz2FSaiiIjlX5z1kDwh6V
	gQhC1CLgzvh2vPNQZIrM0bCfOg==
X-Google-Smtp-Source: AGHT+IHe06aBbh9cJYmhqakMWZst6wfeunpERpdFX37tNWm9qlXgiyZOLVNhqtDJeCb17FIz6tXzTQ==
X-Received: by 2002:a0c:f541:0:b0:67a:93b3:cae3 with SMTP id p1-20020a0cf541000000b0067a93b3cae3mr335262qvm.42.1701373183189;
        Thu, 30 Nov 2023 11:39:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b11-20020a0cb3cb000000b0067a6c448f55sm771465qvf.22.2023.11.30.11.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:39:42 -0800 (PST)
Date: Thu, 30 Nov 2023 14:39:41 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/24] pack-objects: multi-pack verbatim reuse
Message-ID: <ZWjk/TYzsrdHefgy@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <ZWhha2h2zzZWCXrw@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWhha2h2zzZWCXrw@tanuki>

On Thu, Nov 30, 2023 at 11:18:19AM +0100, Patrick Steinhardt wrote:
> > Performing verbatim pack reuse naturally trades off between CPU time and
> > the resulting pack size. In the above example, the single-pack reuse
> > case produces a clone size of ~194 MB on my machine, while the
> > multi-pack reuse case produces a clone size closer to ~266 MB, which is
> > a ~37% increase in clone size.
>
> Quite exciting, and a tradeoff that may be worth it for Git hosters. I
> expect that this is going to be an extreme example of the benefits
> provided by your patch series -- do you by any chance also have "real"
> numbers that make it possible to quantify the effect a bit better?
>
> No worry if you don't, I'm just curious.

I don't have a great sense, no. I haven't run these patches yet in
production, although would like to do so soon for internal repositories
to get a better sense here.

There are some performance tests at the end which try and give you a
sense of at least the relative speed-up depending on how many disjoint
packs you have (IIRC, we test for 1, 10, and 100 disjoint packs).

> > I think there is still some opportunity to close this gap, since the
> > "packing" strategy here is extremely naive. In a production setting, I'm
> > sure that there are more well thought out repacking strategies that
> > would produce more similar clone sizes.
> >
> > I considered breaking this series up into smaller chunks, but was
> > unsatisfied with the result. Since this series is rather large, if you
> > have alternate suggestions on better ways to structure this, please let
> > me know.
>
> The series is indeed very involved to review. I only made it up to patch
> 8/24 and already spent quite some time on it. So I'd certainly welcome
> it if this was split up into smaller parts, but don't have a suggestion
> as to how this should be done (also because I didn't yet read the other
> 16 patches).

I suppose that one way to break it up might be:

    pack-objects: free packing_data in more places
    pack-bitmap-write: deep-clear the `bb_commit` slab
    pack-bitmap: plug leak in find_objects()

    midx: factor out `fill_pack_info()`
    midx: implement `DISP` chunk
    midx: implement `midx_locate_pack()`
    midx: implement `--retain-disjoint` mode

    pack-objects: implement `--ignore-disjoint` mode
    repack: implement `--extend-disjoint` mode

    pack-bitmap: pass `bitmapped_pack` struct to pack-reuse functions
    pack-bitmap: simplify `reuse_partial_packfile_from_bitmap()` signature
    pack-bitmap: return multiple packs via `reuse_partial_packfile_from_bitmap()`
    pack-objects: parameterize pack-reuse routines over a single pack
    pack-objects: keep track of `pack_start` for each reuse pack
    pack-objects: pass `bitmapped_pack`'s to pack-reuse functions
    pack-objects: prepare `write_reused_pack()` for multi-pack reuse
    pack-objects: prepare `write_reused_pack_verbatim()` for multi-pack reuse
    pack-objects: include number of packs reused in output
    pack-bitmap: prepare to mark objects from multiple packs for reuse

    pack-objects: add tracing for various packfile metrics
    t/test-lib-functions.sh: implement `test_trace2_data` helper
    pack-objects: allow setting `pack.allowPackReuse` to "single"
    pack-bitmap: reuse objects from all disjoint packs
    t/perf: add performance tests for multi-pack reuse

Then you'd have five patch series, where each series does roughly the
following:

  1. Preparatory clean-up.
  2. Implementing the DISP chunk, as well as --retain-disjoint, without
     a way to generate such packs.
  3. Implement a way to generate such packs, but without actually being
     able to reuse more than one of them.
  4. Implement multi-pack reuse, but without actually reusing any packs.
  5. Enable multi-pack reuse (and implement the required scaffolding to
     do so), and test it.

That's the most sensible split that I could come up with, at least. But
I still find it relatively unsatisfying for a couple of reasons:

  - With the exception of the last group of patches, none of the earlier
    series enable any new, useful behavior on their own. IOW, if we just
    merged the first three series and then forgot about this topic, we
    wouldn't have done anything useful ;-).

  - The fourth series (which actually implements multi-pack reuse) still
    remains the most complicated, and would likely be the most difficult
    to review. So I think you'd still have one difficult series to
    review, plus four other series which are slightly less difficult to
    review ;-).

It's entirely possible that I'm just too close to these patches to see a
better split, so if you (or others) have any suggestions on how to break
this up, please don't hesitate to share them.

> I'll review the remaining patches at a later point in time.

Thanks, I'll look forward to more of your review as usual :-).

Thanks,
Taylor
