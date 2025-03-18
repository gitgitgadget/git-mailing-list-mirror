Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BBC7E9
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337860; cv=none; b=q255FX7wdZYYDAYkdBd4Vaf6HwsvsDyodL2+TT9KKPwcn32y/WS9I9Hpv2ZDRUT+gegs7ASJCq01dN7IDgBWHPnvd8vqsE1AL1h+XorIaa2ZJlu3JEwKBozKwrXMLefnmf1Org/nvt8cBgMECr7csirJDzwUv4ICf1OR+UWravw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337860; c=relaxed/simple;
	bh=hUvdBRPowklsOHPOFEym8Y/igBRzM7zRjLAvJRbg0wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSKR0H2d8L2ywQ2vj43kj+KbOOa/B0NhU8MSCotdZKswlz3BvXKH4Sjz7lTZaEOZ3YGf3znFvvnxK24l5OHzWz3R7jPATYJQQXLstwNpOj1z2JRBnDNJaene/42vJm3ApvZHw0AHNbdEvbUPssTRJQE9RbHiQrZalEXfHaFtUGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bosK7oy6; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bosK7oy6"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8ec399427so48049696d6.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742337858; x=1742942658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OWaCrpeXXEj5cNykqLz+3k13Mnxv9QhDxzUFEMB/Aes=;
        b=bosK7oy6Q1lb1YfuW+fHmKiVpdT7h2VLiJURpvpMASg74talKh90LxHJhCcbgd3jSK
         oHvhusa8QLjTL8hr3boHk3lsTdEeL5atfFBSG89YNmQxrCAtzxBjkPZKdaHEakHUAXaf
         9ChzhASgG5QahYD0orWgzKWt3LwjvGZ+0C/ce1oE0yF8UkFLz9xYywroRaSEKwTVzQCS
         FkpxVtnfZ55CYyXQdhgXX06cgrAHnvVnZTpknmei6jtwAui5EtWwkt+rs8ljocSZZBaG
         EESadPv3XZ8G2SWGVRAyBsQGK3nt86K/JsOJH/l4bzXoKhnV8nLyArmtTOh17l5EeGwk
         8MUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742337858; x=1742942658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWaCrpeXXEj5cNykqLz+3k13Mnxv9QhDxzUFEMB/Aes=;
        b=ECdwISEGb9jrHnh+M8YQeCf9X6897AMHmANWcw6tLA3Qn+7wMXGXo4SXE2JeLUJWR5
         bxoPMmglpH4sMbyqdeA91mLAD6ylTmAiBK+OI5A34wkSthahKEd577CDFCWpm+IHIiBB
         QT6kfGCRZlXPIohfmU6RlIy81HLblf5YRvtNpHa82pNkRTTDgTTT/aTK5Pg32Kly+9Lc
         GOU62Zaz47ribGB3YogKBnshFEocUnGWAFfuAPOnKA8sMFBzmPn3r4hnfkKd3vk7cjE4
         e5NOwFzt/wXM0k5XqBbnn/ugpS7fl1xi4KcaGDI5wRstV0JKFmxp5kcDFAMIJS6U9ZQL
         1eDA==
X-Gm-Message-State: AOJu0YzX3ff6OEAfFjknprsbMPXClXyWFsWl5i07rxKCoVhQVTaVyHkW
	uWRHdMYI6Lu1PYhMIvDrBEYgD1fwXJRKuNpnl87HfWSjHOZ62rC54lfPho1Z8mk=
X-Gm-Gg: ASbGncsFnkPra69VIq+klcRHF3vI4u1+Hp379stymqnpHIuINTPT9TdLCbnTv/T967f
	mqevtuNN2QcoeF66bOkdJC8BoU33kduq5mVKA0Xu1WpxX1cRtmae23f+eGhulc08bt0lcLLu9KE
	OE4ArzTlAKXMtAw0v3uJxqGRbBf9gsAIoAEnGcgjHKSauzS1+3PrTssDeCsQpaB4H8HXi6XQTlo
	qtIGrTmjGIiUto496jA40KuxMAJyj0D5RGcMtpQjTB2nd2MyB616bzLVe5grUo8t+FTjdmPfIJP
	dcJluL+radmRqGi23glFgFTVovR6f1FCJYhXrGoRVmI3kTe8CRefRXSA0+g+HRTeb462HTwomA7
	YgCGmaGrWMuO7m6l5B/IpgkavLZc=
X-Google-Smtp-Source: AGHT+IGiLL1gAFRqmyBS8waiXrwoohxq3iuc2pQnc8NlPxObJTgu2e/F3TUn00bdBlPo/ieX/ME9+A==
X-Received: by 2002:ad4:5c67:0:b0:6e4:4484:f35b with SMTP id 6a1803df08f44-6eb29467a44mr10831736d6.30.1742337857708;
        Tue, 18 Mar 2025 15:44:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade34c5f7sm72272766d6.96.2025.03.18.15.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:44:17 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:44:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 1/4] refspec: treat 'fetch' as a Boolean value
Message-ID: <Z9n3QGmNYsp3QJoJ@nand.local>
References: <xmqq5xkdrrhs.fsf@gitster.g>
 <cover.1742250259.git.me@ttaylorr.com>
 <7e662acb5ac50b778917cbf2f9f791d35e95e31d.1742250259.git.me@ttaylorr.com>
 <20250318002436.GC1470172@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318002436.GC1470172@coredump.intra.peff.net>

On Mon, Mar 17, 2025 at 08:24:36PM -0400, Jeff King wrote:
> On Mon, Mar 17, 2025 at 06:24:24PM -0400, Taylor Blau wrote:
>
> > Since 6d4c057859 (refspec: introduce struct refspec, 2018-05-16), we
> > have constants called REFSPEC_FETCH and REFSPEC_PUSH. This misleadingly
> > suggests that we might introduce other modes in the future.
>
> I don't know that I'd call it misleading. We _could_ introduce new modes
> if we had new operations. But I do agree it's unlikely (even if we had
> other operations like git-archive, cat-file, etc, they would probably
> not have refspecs).
>
> So it seems like a reasonable direction to me.

Fair, I think a more accurate statement might be to swap "misleadingly"
for "confusingly". I'll swap that and amend the paragraph to say "[...],
which is possible, but highly unlikely"

> The one thing I don't like is:
>
> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index 9c4a00620a..8bbfcce729 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -738,7 +738,7 @@ static const char *get_tracking_branch(const char *remote, const char *refspec)
> >  	const char *spec_src;
> >  	const char *merge_branch;
> >
> > -	refspec_item_init_or_die(&spec, refspec, REFSPEC_FETCH);
> > +	refspec_item_init_or_die(&spec, refspec, 1);
>
> The third argument here (and elsewhere) becomes much more mysterious to
> the reader.  Maybe not a big deal, though.

Hmm. I see later on in the thread that the final patch resolves this
awkwardness. I figured that readers might have a similar thought here,
which is why I included "Note that this introduces some awkwardness like
[...]", so perhaps there is a way to clarify that. But...

> > diff --git a/git-diff-pairs b/git-diff-pairs
>
> Hmm.... :)

...I could forgive you for not noticing given this ugliness ;-).

Thanks,
Taylor
