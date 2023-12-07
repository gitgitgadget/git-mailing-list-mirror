Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fuvhLPiZ"
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B09B171D
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 12:34:55 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67a894ccb4eso7951596d6.3
        for <git@vger.kernel.org>; Thu, 07 Dec 2023 12:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701981294; x=1702586094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9S5FRAd5+Cc0WOx1kz/ZBj/kPtPpdS5jF45/XQWvdXw=;
        b=fuvhLPiZVuoPDRro0fwv9sm4zu2GIW1fzlqopU/XBZ4M5H+CH84y21crwtIXFWYSdr
         W1acnzSp13x+HW5SYFL+tFi2mcKSB1MMyhuIQNW28OOltRQKmPpykVJaXFQKhj9U/WBY
         HXpXsF1d+5gHtOr4Lra+YFUle8hPBvxri16NgT3keNaFYM390UaJkUIdQ88aP2PRQ88B
         id9KxMO+tYjcAntPsywcUNRtSP3zf3l++xT6z2zgG+vod0PGtf4e4RHnZy0llhlq+LSq
         zOmtlE+esOtuLvSKMfotEwhgTrgRzmCWtuJMx38DVJAJ/QgL4a5hlEuWEJlxvsqlXekT
         geuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981294; x=1702586094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S5FRAd5+Cc0WOx1kz/ZBj/kPtPpdS5jF45/XQWvdXw=;
        b=euLpXkJ6ncSkzLPZozkwhRWZInSnu2mwmE5mz2W23vG6yLbzwjEbj8GB6wVhA2gUaC
         efUeMaXKcbl5H4+zDwG22keknHm0H+C6M2juSVxrCukzU2V0zrSZ9qmSttPTuiAGV4dJ
         6/Y1rg3zoDbLRs7WPiyXnoYS9R2tZ2MShnbfNuxBnZjseWjb9m3wXtI4MnpyHtIvLZSv
         vQFmO7PUWZYroqtBFm0ZN5JjTziVZF2B4+lXeGx/ATiitwtSqKlZhQJ3k0+Dv9ObSvGU
         h6Y45xxqpwmynQP9VBGoYk9VsbbpDrvStbrSTaIns6Nm2biOiRNwTnhJSFhC49hy7pKX
         14Hg==
X-Gm-Message-State: AOJu0YyQEiqEs8CV5K+JOLPLjaCLoPOexH8tT7RkCh+JX4tJ+Pm2DZSZ
	kPBjDK5lgOGtAk+9+uCpEhv7hfv46Su4J0lBQjA=
X-Google-Smtp-Source: AGHT+IGBUc/lHWAtdIphynBLiD1PKU/hkrZLDal3VSvBjDIdg9mdZV+2xF9ZbhRIKpl6tBKMZHy0KA==
X-Received: by 2002:ad4:42af:0:b0:67e:a9cf:d575 with SMTP id e15-20020ad442af000000b0067ea9cfd575mr187977qvr.83.1701981294168;
        Thu, 07 Dec 2023 12:34:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w11-20020a0cfc4b000000b0067abdf75926sm186740qvp.14.2023.12.07.12.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:34:53 -0800 (PST)
Date: Thu, 7 Dec 2023 15:34:52 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/24] pack-bitmap: pass `bitmapped_pack` struct to
 pack-reuse functions
Message-ID: <ZXIsbO++u9n/yDYi@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <970bd9eaeae038adb6e7d4c399c9b033668a8864.1701198172.git.me@ttaylorr.com>
 <ZXHE6Ym3CICtNxFd@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXHE6Ym3CICtNxFd@tanuki>

On Thu, Dec 07, 2023 at 02:13:13PM +0100, Patrick Steinhardt wrote:
> > +	if (bitmap_is_midx(bitmap_git)) {
> > +		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
> > +			struct bitmapped_pack pack;
> > +			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
> > +				warning(_("unable to load pack: '%s', disabling pack-reuse"),
> > +					bitmap_git->midx->pack_names[i]);
> > +				free(packs);
> > +				return -1;
> > +			}
> > +			if (!pack.bitmap_nr)
> > +				continue; /* no objects from this pack */
> > +			if (pack.bitmap_pos)
> > +				continue; /* not preferred pack */
> > +
> > +			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
> > +			memcpy(&packs[packs_nr++], &pack, sizeof(pack));
> > +
> > +			objects_nr += pack.p->num_objects;
> > +		}
> > +	} else {
> > +		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
> > +
> > +		packs[packs_nr].p = bitmap_git->pack;
> > +		packs[packs_nr].bitmap_pos = 0;
> > +		packs[packs_nr].bitmap_nr = bitmap_git->pack->num_objects;
> > +		packs[packs_nr].disjoint = 1;
> > +
> > +		objects_nr = packs[packs_nr++].p->num_objects;
> > +	}
> > +
> > +	word_alloc = objects_nr / BITS_IN_EWORD;
> > +	if (objects_nr % BITS_IN_EWORD)
> > +		word_alloc++;
> > +	reuse = bitmap_word_alloc(word_alloc);
> > +
> > +	if (packs_nr != 1)
> > +		BUG("pack reuse not yet implemented for multiple packs");
>
> Can't it happen that we have no pack here? In the MIDX-case we skip all
> packs that either do not have a bitmap or are not preferred. So does it
> mean that in reverse, every preferred packfile must have a a bitmap? I'd
> think that to not be true in case bitmaps are turned off.

It's subtle, but this state is indeed not possible. If we have a MIDX
and it has a bitmap, we know that there is at least one object at least
one pack.

On the "at least one object front", that check was added in eb57277ba3
(midx: prevent writing a .bitmap without any objects, 2022-02-09). And
we know that our preferred pack (either explicitly given or the one we
infer automatically) is non-empty, via the check added in 5d3cd09a80
(midx: reject empty `--preferred-pack`'s, 2021-08-31).

(As a fun/non-fun aside, looking these up gave me some serious deja-vu
and reminded me of how painful discovering and fixing those bugs was!)

So we're OK here. We could add a comment which captures what I wrote
above here, but since this is a temporary state (and we're going to
change how we select which packs are reuse candidates in a later patch),
I think it's OK to avoid (but please let me know if you feel differently).

Thanks,
Taylor
