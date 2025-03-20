Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B9AD39
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429784; cv=none; b=KNdgV9o2XIR3lGGREyt8TcLcZpQnt2GdYkcQVa8521CZchoyttneUUoTvU7dcrGwKVq4Q+KuRu9soxofC7cJEY/iDkLxs8mHglovc/mkTM+7Rp6okqEUKBh3mXLsOCy7TFI0HSnkZCotQOdmF2BqhHtuJ6FgWCfAo5Zi/zlA2WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429784; c=relaxed/simple;
	bh=cRX6LIgzh3F9rJ1gG73A3sagBlvhW3lQCMrA6E7p3bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZCq/MF+bRnfD350mkoPXj8AEMtPrJSeYPiUxXWNBJMX5Nf1RY1Bovmtted4XtL/5NlMvkzYHPwIOR58VSTdTp+9ad59/NTaE1i77NTWwyiT/t/2O4mokfULyAqfaS5PsKbJyffBjHGnAGPpqmFqaOQRodMgG25id+BP/H3hybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TKYu5pv+; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TKYu5pv+"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e86b92d3b0so1628676d6.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 17:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742429781; x=1743034581; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=izrvCt6AtOgWKz98fZy40cAaf9FnEfONHATEYrYuOtg=;
        b=TKYu5pv+xBUCs33Pk77vyNt5LJUwt6dZGjI6fPvbMDsHx45qkMsmvR5ET6T3733DkA
         6Vkyju355qPYMiqhbkuDbQ4xNib0Szk2t61hrqtV8G01nNh6UTPFfvsnkX+Q/F6x7oWD
         rG4CcuQB1FqfdkKzWjnFWPHlK0pE/t1KCn9uNNR23K9tt20maMNKuhiDceEYrw4L801B
         szZQ7e0lpMwODxa7ATjE2+8neX5sgou+W2zjhjuqHnix+9lBroTXMC13Hb7TXfB+h5fr
         /p+bEnYmdV1SXeXaIUs2XHhrX9ogpvh0A2FGtfpKTtgLjZ8Xv9P2WntBNZHDx25WOfVE
         EZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742429781; x=1743034581;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izrvCt6AtOgWKz98fZy40cAaf9FnEfONHATEYrYuOtg=;
        b=PX1FgnbIg9Kx0jk5+JzI1B0WFid82fM1nP2MeTw48qSXQBDS4mHT8p40bw2GDH6pjl
         dbnEIa3txTG3pnnw4I7TGWkEh1RcnvQPtznT5dmRVkhrC6s+ngsigWy85l4Y5jZX/GHi
         79hY5SMTrfNGLuy6hjddDZzEiMGnFDWFcnRU4igdgU8FeGVb4gnviZOZTcOUO0jGi+Va
         txHqc3uXK8JRa3bLdiuUvFYupCQTG7KNVFETXehetwsgtF/1XrM5D45/7MsDCSvz9Tj+
         08llFp3qj6g0PkH71kz5iooq/bq0w2tyLb8nyv1HgHQCT+oyXfUUG8v0YMbU3DjNwcvM
         m1Pw==
X-Gm-Message-State: AOJu0YydQNju4wVVXLnRdRUYkG78BjzrVH8w0BEzurNWIa9fC+xWYR/Z
	TIo3+UWVwXzOKfzgYBb+8WR5XBk5+PS0bk28r9AZXYQQaqSUU6Uoiax7qCyJNnY=
X-Gm-Gg: ASbGncuPJ4FAhcoAcGhELi665JCh6WlLtbHh3VpQa3tnrK/qwG6JnFDazcHYjeaYgUJ
	7C1+v2ceMz602+mKKRToBCEAdpAGVZCF/t2XKHx86bphazGubOphh5e3awyLuNNfxy/rEOTCrcB
	R7ymA3Iv3HVUlKFTMyse4+kN5VSJLhirTAIa7i3BZoBgAC3X4T1tFXRTIQyV75u+M/dRPvi6fv5
	b9qKQaeq9P4rsA1hGnyoybFplin+q3tR8b2lOfpg0aNV5HUSkwsnT9gvGwAo5zYSy6HRIjMuopY
	xU2vTjmHh2Oxj1wwbGTZ0TtEC4USYoaisXk7dP8qMDpCzW6UHuzwC3zrazsCGOa+Sgah9n3LqQu
	pWTziPowde+cpJnfs
X-Google-Smtp-Source: AGHT+IGu9al2nbwJkHFI+NjKL4LyjMSyI/kAPx5epL8ih0yWaN5EZrZkY6rTGLHVH5nz3SpOBHbtqQ==
X-Received: by 2002:ad4:5b84:0:b0:6e8:f6d2:e074 with SMTP id 6a1803df08f44-6eb2940f25dmr71520556d6.28.1742429781281;
        Wed, 19 Mar 2025 17:16:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade208b20sm85950646d6.9.2025.03.19.17.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:16:21 -0700 (PDT)
Date: Wed, 19 Mar 2025 20:16:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 13/13] midx: implement writing incremental MIDX bitmaps
Message-ID: <Z9teUzEvSmK6V2XF@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <d0d564685bc66df71b4c3ed1093452e58e0f54fd.1741983492.git.me@ttaylorr.com>
 <CABPp-BF4msjkhV=aQYt8GrK8ptKaciE28OqQx0y64xrjWKrPMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BF4msjkhV=aQYt8GrK8ptKaciE28OqQx0y64xrjWKrPMA@mail.gmail.com>

On Tue, Mar 18, 2025 at 10:13:03AM -0700, Elijah Newren wrote:
> On Fri, Mar 14, 2025 at 1:19 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> [...]
> > diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> > index e92341b8fa..056c410efb 100644
> > --- a/ewah/ewah_bitmap.c
> > +++ b/ewah/ewah_bitmap.c
> > @@ -399,7 +399,7 @@ int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it)
> >         return ret;
> >  }
> >
> > -void ewah_or_iterator_free(struct ewah_or_iterator *it)
> > +void ewah_or_iterator_release(struct ewah_or_iterator *it)
> >  {
> >         free(it->its);
> >  }
> > diff --git a/ewah/ewok.h b/ewah/ewok.h
> > index 4b70641045..c29d354236 100644
> > --- a/ewah/ewok.h
> > +++ b/ewah/ewok.h
> > @@ -158,7 +158,7 @@ void ewah_or_iterator_init(struct ewah_or_iterator *it,
> >
> >  int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it);
> >
> > -void ewah_or_iterator_free(struct ewah_or_iterator *it);
> > +void ewah_or_iterator_release(struct ewah_or_iterator *it);
>
> Was the rename from these last two hunks squashed into the wrong
> patch?  Since you're not changing its definition, I'm assuming the
> updated name should have been applied to when it was introduced.

Hah! I knew that I made this change, so I was confused in

    https://lore.kernel.org/git/Z9oQ4moLVKh3+vul@nand.local/

when it didn't show up in that patch.

It got rebased out of my local copy of this patch automatically since I
had manually applied the rename to the earlier patch while responding to
that review comment.

Thanks,
Taylor
