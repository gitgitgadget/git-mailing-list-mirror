Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963F1DFC8
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xkWc1rPB"
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB2F3DC61
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 08:27:43 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7bae8dd095cso840154241.3
        for <git@vger.kernel.org>; Fri, 10 Nov 2023 08:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699633662; x=1700238462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sFiuIphpQdOryaK42gcN2k93ROexv/qHHgJskBydPhU=;
        b=xkWc1rPBJnFdHfKp5TyX0V5nPve8o4TXkfjoCXvD02Kr8/kxynEGuvZdw65uKyEf3K
         6UfWFk5U8DYz3yNHtw815UhgnSMDaDWDHdaHDh/hYX6iKQ0w1U3OwWiJIgjmZehFNJas
         vXkoIQdFG9uPxiKjCjwofsyhmwdk0KfrkYEOh0ADXBTIdqaIGbN2wExc/8ANaRk9/Sxk
         4ZNtQuHGi+KRvNMevoTeH+0Q0inPIwNbEC0g2dKTr3fE26XorzoUzDiSXmqPWbVKwUGZ
         FFC+7PX1FkYqHrMnJ0tTFaS1KWLVMlumfJyMa5u9SOBlR1hfCNbtctLR6xQlc/8k/bjd
         bSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699633662; x=1700238462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFiuIphpQdOryaK42gcN2k93ROexv/qHHgJskBydPhU=;
        b=Sdk+sSTRzOsQ4dtYjz72DwsckY3c7j3YNSGnwvNxzy4+zDTufW9NC8DHh2hLK6Kryv
         036oHZGJc2KJ5Bv+PjWDUVW0IAjRh1lVeLr/ITjhEyLrzZRdN4cHl9q+NDxBhitlltnn
         U8rHPIG0K55DWXI9izRVbvDvbZ+ZOeQXNVguk9S8UYqJFk3yatapYEi7e8hEwkgJU3hv
         7Iwvvhx93tlGoRrO96JzndgD+UYyxy92RH+wmUA5MvWaurf5axriD5IFoyTqX1nQjYKu
         RXUoLvcmFyx6xLO/5rLESaXDNEYMfiErF9bnkceRlayFB4M0dEAzPy8r+BBIqCK5PSua
         hslg==
X-Gm-Message-State: AOJu0YxTMwMFDir+jsQokMWw+96/kZbroqFHRTEl/6I0XKTq9WQ/vMGF
	1csAz81/fNW5c+hON36rIJCuzw==
X-Google-Smtp-Source: AGHT+IHmuzQROCbqJ43fFVC6q2jp1o2ms31YTFctqpjIm/1mkBhtKyvzOX8kU7nt9yZM66yL+5e4sw==
X-Received: by 2002:a67:ef07:0:b0:45f:b975:f717 with SMTP id j7-20020a67ef07000000b0045fb975f717mr3172796vsr.34.1699633662433;
        Fri, 10 Nov 2023 08:27:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t19-20020a0cea33000000b006648514e276sm2994816qvp.78.2023.11.10.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 08:27:42 -0800 (PST)
Date: Fri, 10 Nov 2023 11:27:41 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/7] chunk-format: introduce `pair_chunk_expect()` helper
Message-ID: <ZU5Z/Z4PcdNP5U1r@nand.local>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <cover.1699569246.git.me@ttaylorr.com>
 <af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
 <xmqqedgyw6jv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedgyw6jv.fsf@gitster.g>

On Fri, Nov 10, 2023 at 01:55:48PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > +static int pair_chunk_expect_fn(const unsigned char *chunk_start,
> > +				size_t chunk_size,
> > +				void *data)
> > +{
> > +	struct pair_chunk_data *pcd = data;
> > +	if (chunk_size / pcd->record_size != pcd->record_nr)
> > +		return -1;
> > +	*pcd->p = chunk_start;
> > +	return 0;
> > +}
>
> I know one of the original places did the "divide the whole by
> per-record size and see if it matches the number of records", the
> same as we see above, but the check in the above could also be
>
> 	if (chunk_size != st_mult(pcd->record_size, pcd->record_nr))
> 		return -1;
>
> which would also catch the case where chunk_size is not a multiple
> of the record size.  Your conversion of OOFF in midx.c loses this
> protection as the original uses the multiplication-and-compare, but
> the rewrite to call pair_chunk_expect would call the above and
> checks with the truncating-divide-and-compare.

Hmm. I was thinking of Peff's "commit-graph: handle overflow in
chunk_size checks", but I think that I was overly eager in applying the
same reasoning to the MIDX code.

The important piece of the rationale in that patch is as follows:

    In the current code this is only possible for the CDAT chunk, but
    the reasons are quite subtle. We compute g->num_commits by dividing
    the size of the OIDL chunk by the hash length (since it consists of
    a bunch of hashes). So we know that any size_t multiplication that
    uses a value smaller than the hash length cannot overflow. And the
    CDAT records are the only ones that are larger (the others are just
    4-byte records). So it's worth fixing all of these, to make it clear
    that they're not subject to overflow (without having to reason about
    seemingly unrelated code).

In particular, that g->num_commits is computed by dividing the length of
the OIDL chunk by the hash length, thus any size_t multiplication of
g->num_commits with a value smaller than that hash length cannot
overflow.

But I don't think we enjoy the same benefits in the MIDX scenario. In
this case, the num_objects field is just:

    m->num_objects = ntohl(m->chunk_oid_fanout[255])

so I don't think we can make the same guarantees about what is and isn't
save to compute under size_t arithmetic.

I'd be curious what Peff has to say, but if he agrees with me, I'd
recommend taking the first five patches, and dropping the two
MIDX-related ones.

Thanks,
Taylor
