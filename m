Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393D276D36
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702665; cv=none; b=K7ftmlWdqP/bts55rgxgbJ+q7RV2iDHA0yL8flzJ/1upXLy1ib9azAF5Gk9x5JlOUVwAy6lGsjVQzjuV5F0Ve7oR/bSjdVR4Bbxlzjc0lQGmRcsTEKAR4XUuTb+R6AHGdf2aX5QjyMYvNXLCbL9qk04eUllBDjeW+WbmbWFBjZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702665; c=relaxed/simple;
	bh=f4LUZ2lmyk/gD6oZccNrq7mvhSX0fFlWyP0k4jmOFvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivFsNwE4NR3wtiSv9FY17f6olXitlZVOfcR2ioiIstqEjboJIq/WRufTgLg2mYIkPQmWilEObUegjh5T6iIhhmrnxq4EYkg/17Exg0Ry81rGYOPhGAZyX42sg3JM+b5g/X55HuroXppkoo+Tm1Nmd6BeHUjzUm+5CRAach4ehxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lN5cLl6h; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lN5cLl6h"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e461015fbd4so1147313276.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740702663; x=1741307463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CgVz5UBcT4r+c/03hhVkzYr5yqz6qtHW/qs7XHvLt6I=;
        b=lN5cLl6hT8jFeMnyYFvZJnsfzyKjUJvOgB4kmCvc+Iq5J8arsHtb4z1Xi10OtCNf9M
         wWZBldw9GeZ8m3r7mjnehMc8y6rGD5wr0B5xyCnO/oSt83ee9jFsQ1IxCHoGd4QfbR8t
         IugfKRdHWqHwVS7AKIkbaXuZxiwNpy8ze0XZb1JBJyMT3VZF8tWJDjuqxKA1JVWBDXxM
         Bsi10ENaUHV6hxYdOQwGYYK/gJNHZEf5+A9017EZ0Pg2GMclhIlVLDut8G88PLONKojg
         0bL2zEhxKlDSOi4NRFaoKeAg4JlbFkHiqQJPa74qxGuurGw+SZGCpjPYoteZnUO/pXiU
         5/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702663; x=1741307463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgVz5UBcT4r+c/03hhVkzYr5yqz6qtHW/qs7XHvLt6I=;
        b=szg1qHYO4cfuAO6XsFmhitOucEcop/rk0fFtf1E6UHD+PYP8z5cU9U1KpMPEnGoDXq
         h16Y8wws+Ya4K+XydXIh2MrEmYpQZDfbLbLqJD6WZ1775CWzECJorXxwMdYsXRVfaYF4
         bMbOYhu7+HY9X5Cji32f8jUF3cZ0soR9qOS0bWb/W3dIBW8IEXYwtCXLPBGB4P3m/unP
         wrczZh3dYIhZt6upa9deoClJvBPQA7gqLHRrNKqvFGHkjbASXuJlkNO2Y+GJC4rvpQ9K
         SWzI0CQhN3XFpt2yXLgI4gpLaTWo/eRWDa3wcj25SwSPpVcKML1IDUcUF5iCjhApp97l
         P8aw==
X-Forwarded-Encrypted: i=1; AJvYcCUKxtkRs3RaCk9+CsN9v2nd7jV7vpFMQWnhsd2ivkqwKQPVs3evEju3NobeKnzGZi3cTro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqG5SkiAHEIqSLD6kbTmXwcXJV3PCJWl4ZD7YvaIf+XTjLqp2C
	yDt62CWKx4CuqWZ7bcsYXCDhRZOyz/p7vwXxBpFIXEGVOhAKkkTTMhtg5hz8AXM=
X-Gm-Gg: ASbGnctYd/FcngDIxJoZhjtdWtSo0lm2gVKwortxDurty1wOLaLmvWH7UCoC5CbIXJW
	Ii3IHmhBvIBqMY7BJT+tmaaHA5OtKpHg4pTE6r+LGCE0t4igcGqRtREfKaSyoNYj9JgXOww85aQ
	7XHHBWczkOFYfobo7piksXfVEx26h9GP9mJCuL4iuNc5o2257U3a4k2et+N4sfe5CAm7/zGFJ/N
	cOJhZErrybJJhuSjAAJWotzv5cVJSMPRnMDCwAjZcCowf1uFKlpyf3h5N8CngOZUQI6K3FeOsWT
	3G/LqCG5HlCFkeRcW88Em//T8gMmrVR2Y/QWD9GsrGWudUjkuKkInR7diSb/3NxLbp16FiJWfg=
	=
X-Google-Smtp-Source: AGHT+IHxkYq5kYIXELWPrKD1MC1c3zhThSPy1v/xXkjRMTUhoA6KfSsYq+WfsUD5pDFQdMrV88skAA==
X-Received: by 2002:a05:6902:1ac9:b0:e60:b077:ed4a with SMTP id 3f1490d57ef6-e60b2e860bamr1388234276.6.1740702662679;
        Thu, 27 Feb 2025 16:31:02 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e60a3aa4ce0sm741830276.35.2025.02.27.16.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:31:02 -0800 (PST)
Date: Thu, 27 Feb 2025 19:31:01 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 05/10] git_inflate(): skip zlib_post_call() sanity check
 on Z_NEED_DICT
Message-ID: <Z8EDxd3f/U+EdoLO@nand.local>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225063026.GE1293961@coredump.intra.peff.net>
 <xmqqr03kg7mb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr03kg7mb.fsf@gitster.g>

On Wed, Feb 26, 2025 at 05:26:04AM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > But these do not correspond when we see Z_NEED_DICT! Zlib consumes the
> > bytes from the input buffer but it does not increment total_in. And so
> > we hit the BUG("total_in mismatch") call.
> >
> > There are a few options here:
> >
> >   - We could ditch that BUG() check. It is making too many assumptions
> >     about how zlib updates these values. But it does have value in most
> >     cases as a sanity check on the values we're copying.
> >
> >   - We could skip the zlib_post_call() entirely when we see Z_NEED_DICT.
> >     We know that it's hard error for us, so we should just send the
> >     status up the stack and let the caller bail.
> >
> >     The downside is that if we ever did want to support dictionaries,
> >     we couldn't (the git_zstream will be out of sync, since we never
> >     copied its values back from the z_stream).
> >
> >   - We could continue to call zlib_post_call(), but skip just that BUG()
> >     check if the status is Z_NEED_DICT. This keeps git_inflate() as a
> >     thin wrapper around inflate(), and would let us later support
> >     dictionaries for some calls if we wanted to.
> >
> > This patch uses the third approach. It seems like the least-surprising
> > thing to keep git_inflate() a close to inflate() as possible. And while
> > it makes the diff a bit larger (since we have to pass the status down to
> > to the zlib_post_call() function), it's a static local function, and
> > every caller by definition will have just made a zlib call (and so will
> > have a status integer).
>
> Ouch.  I am not sure if I would have made the choice you guys made
> if I were writing this fix, but that is mostly because I do not
> anticipate that we would ever support NEED_DICT and the other two
> options seem simpler, and certainly not because I have any concrete
> reason to oppose the third approach.

It's been a few weeks since I last looked at this patch, but I have a
vague recollection that we chose the second approach while discussing
this together.

And indeed, looking at the copy I have from that session, it looks like
we did

--- 8< ---
diff --git a/git-zlib.c b/git-zlib.c
index 651dd9e07c..265d3074e1 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -122,6 +122,8 @@ int git_inflate(git_zstream *strm, int flush)
                                 ? 0 : flush);
                if (status == Z_MEM_ERROR)
                        die("inflate: out of memory");
+               if (status == Z_NEED_DICT)
+                       break;
                zlib_post_call(strm);

                /*
--- >8 ---

I actually have a vague preference towards that approach, since I too do
not anticipate that we'd ever need/want to support Z_NEED_DICT (and if
we did, we could always change from option (2) to (3) later on).
Likewise, the resulting diff is considerably smaller by line count,
though on the other hand this diff is not all that more complicated
overall.

I don't have a strong enough preference to suggest you make any changes
here, but I thought I'd mention it nonetheless.

> > +test_expect_success 'object reading handles zlib dictionary' - <<\EOT
> > +	echo 'content that will be recompressed' >file &&
> > +	blob=$(git hash-object -w file) &&
> > +	objpath=.git/objects/$(test_oid_to_path "$blob") &&
> > +
> > +	# Recompress a loose object using a precomputed zlib dictionary.
> > +	# This was originally done with:
> > +	#
> > +	#  perl -MCompress::Raw::Zlib -e '
> > +	#    binmode STDIN;
> > +	#    binmode STDOUT;
> > +	#    my $data = do { local $/; <STDIN> };
> > +	#    my $in = new Compress::Raw::Zlib::Inflate;
> > +	#    my $de = new Compress::Raw::Zlib::Deflate(
> > +	#      -Dictionary => "anything"
> > +	#    );
> > +	#    $in->inflate($data, $raw);
> > +	#    $de->deflate($raw, $out);
> > +	#    print $out;
> > +	#  ' <obj.bak >$objpath
> > +	#
> > +	# but we do not want to require the perl module for all test runs (nor
> > +	# carry a custom t/helper program that uses zlib features we don't
> > +	# otherwise care about).
> > +	mv "$objpath" obj.bak &&
> > +	test_when_finished 'mv obj.bak "$objpath"' &&
> > +	printf '\170\273\017\112\003\143' >$objpath &&
> > +
> > +	test_must_fail git cat-file blob $blob 2>err &&
> > +	test_grep 'error: inflate: needs dictionary' err
> > +EOT
> > +
>
> Wheee.  I guess an ugly and down-to-bit-sequence test is much better
> than having no test at all ;-)

As a fun aside, Peff wrote this Perl script (unsurprisingly, I strongly
dislike writing Perl), and amazingly it worked the first try when we
were still hypothesizing about what this bug would look like. It was
quite the surprise to both of us, I think, that it worked so well.

Thanks,
Taylor
