Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24756278771
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760137034; cv=none; b=bDm0VbSIkEOkJ/M2II5WZVcLpb9erSLmt5bgPLUIv0CJOhBSmKmnUiXBPNiH9Us6881JnshXAMM+oGI/1fWHiDUplXb/6Eogo9yp0kk7joWX05T9Yz7A7v+ao/I2tZ7tYAn0rm5v0H99x+ioMzaE5XEt7da5de20YqV0TmArMq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760137034; c=relaxed/simple;
	bh=U7KNnJuzqLTmBDGFa3mrPqdiWFHO+7KUKlUo5ZKtW8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmWF26lCfTTBM09qokb9kUUGw5PKiSm9rqqd9rZ8IdKKlgml1YiLdFU828Hiw5ZpchByYkxWremH90kkdRWhGPRvMs9xWK9xkg/f/OT3+JWWu11DZtyWybn4KvizoGP5sN5KUu602XyYi46NDRXh7O8tzYGG0+29ljIRQCOZIX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=P8yH6eH+; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="P8yH6eH+"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d6051afbfso27120857b3.2
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 15:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760137030; x=1760741830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CALqs9wpxHZbB+wJy6k8qdIkke5E3sEVdeSbKBHOobQ=;
        b=P8yH6eH+Q0c/GoM38w0XdQ9xyjt0B/GXMsORmLLq3JxgcQsi3uxHTkE/vVufObX5Sb
         nyyMn4Vxcax6wYpDL7mRvgAz46YlYruBZYUXuqD8E0YzT0D9iXW3tb1KyWOsrxc+Myej
         7yMzrc01srMKeCD7HjvHc/OR8F5EbuKapjJfH6jFwmta8OehQwPCNgFKEJwNu70qxYIB
         yWulKmZLUpzG/vs1tbs33zuST4VVQ2SN8bZE7gyoIS1G1TPEa+nLq8rN6uWangU2dOTA
         3JGCk0HKx8SS2cV5E8ZbisgzqZTrG3jE80ZhFGEbcbyBDY7r9z8yvQ4mcdnSdRqP5Rdr
         xmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760137030; x=1760741830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CALqs9wpxHZbB+wJy6k8qdIkke5E3sEVdeSbKBHOobQ=;
        b=cnQtZ1ensnwUF6Qbf20fCKnjcFBWhAEwQvK+l/crBup8Fo030jh2U16MIPc2iU2WWo
         T5UGeKkhwBkVuavnaC36YBQoh/51JFu090Cf8shgmxKsHAlEb8acheG643s6NeEsI39s
         5tRb9MPkrcQ3+YhiMiwEm/+yra/krBLt5UYjfEdv7wy0jAJ2oXcTHhbdZYevnbsMPRTQ
         4myCLcaWPxwIwBP5ECgqwcpjNrM2bta7fbqRRq5tiJMBzt57KU+t0fa/f1yNBy7Mu9TD
         valZCN8hfUdVL7AyVWQFYUtcnoVjn0cG+cI1NVZWIt1vLMFncZSiHz0hx8TRPketmgMI
         vW7w==
X-Gm-Message-State: AOJu0Yw3Cm8v2xnmWmNhtSgxhxQW7k1AQSI4vG98M8IeuUSZVlTBYIZ6
	mPkm/Us/XSCFgHfZ424uiDe7sLlf/y+IV+8VTTP8XMZkchl54n6YEZHBghIfxznaYiyQZ1zk4f/
	tDfaIv0qeqQ==
X-Gm-Gg: ASbGnctqx7mhYFDn79YPvCaeY42WC5fFI8Ou0DFJoZ395uLkDPmcnSK56kkAO346PJG
	24HAERVVH2jKCaSTE05XHx+habgmezFbOZomWgAmHJe/a8mAOMmKhSW90PAi+s8IGZ4LAotImMv
	mhCieJ3MV5dKY9nJMXCJrQTFBQIOgBISBooV677y0gG5HcTaXgyz8yPT1cWLS7bizJR/lSTbAGg
	R9gOSXeC0CyUDxOB8/nXn6NsryMZRDQaowH6ZoVnthJgz/AfFCjt3arAOvN80fiMxMG0/PsRLOU
	Vjit5nOW+J2nPrz+0YoQ/TAkZByZ+rubvLlFO9baJ2ilDnaEHJWYLxmF1K1lcu0cx24tT0RO/12
	sZUl1q1kZ0Gu/JAq+enwc+/BbfX8Z6H1eETUrVvx4DcIpgUS4N/o0HIMA9a4yfnU0XMIemah59E
	Pq7wBenfqMBUEzjUy8D5wMDMH5wGuFVKZVr9/2+vulxh0L
X-Google-Smtp-Source: AGHT+IEfviuNsYZ9gpHZbOHKAChSl7oUI22wgNT71RH9I+UXtzq35SjrWPfVFvRhlmKgDn5LZR+sdQ==
X-Received: by 2002:a53:eac7:0:b0:63c:ec55:3221 with SMTP id 956f58d0204a3-63cec5535f0mr3085237d50.21.1760137029884;
        Fri, 10 Oct 2025 15:57:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cd9516228sm2036520d50.5.2025.10.10.15.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 15:57:09 -0700 (PDT)
Date: Fri, 10 Oct 2025 18:57:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 19/49] repack: remove 'existing_packs' API from the
 builtin
Message-ID: <aOmPROWM95FX57wC@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <ae267fcc820dc19497f9f897bc5915b2040739e5.1759097191.git.me@ttaylorr.com>
 <20251010060836.GG1965904@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010060836.GG1965904@coredump.intra.peff.net>

On Fri, Oct 10, 2025 at 02:08:36AM -0400, Jeff King wrote:
> On Sun, Sep 28, 2025 at 06:08:23PM -0400, Taylor Blau wrote:
>
> > --- a/repack.h
> > +++ b/repack.h
> > @@ -2,6 +2,7 @@
> >  #define REPACK_H
> >
> >  #include "list-objects-filter-options.h"
> > +#include "string-list.h"
> >
> >  struct pack_objects_args {
> >  	char *window;
> > @@ -31,4 +32,38 @@ void pack_objects_args_release(struct pack_objects_args *args);
> >  void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
> >  				  const char *base_name);
> >
> > +struct repository;
> > +struct packed_git;
> > +
> > +struct existing_packs {
> > +	struct repository *repo;
> > +	struct string_list kept_packs;
> > +	struct string_list non_kept_packs;
> > +	struct string_list cruft_packs;
> > +};
>
> Earlier, I saw remove_redundant_pack() got namespaced with a "repack_"
> prefix. Which I think makes sense, since it's a pretty generic name and
> the symbol now has global visibility. But none of this existing_packs
> stuff got the same treatment.
>
> I don't know how much it matters. I certainly have no plans to call
> something existing_packs elsewhere in the code, but I do wonder if the
> naming should make it more clear this is all repack-related.

I think this is a similar case as `struct pack_objects_args`. We could
prefix this as `repack_existing_packs`, but it seems a bit verbose, and
existing_packs is a semi-useful API by itself.

Thanks,
Taylor
