Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA741E9B03
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815808; cv=none; b=e6qgkrdux13GoiQDDHVl416rJJK7EbARdwEQqGgwpBi/NaZ7A0Or29dcYjTbkz9inXY+7GwQnIelqFz3xyLpCxjLI7XvBMrG03QRTPXtexZc1sPqQK1VSpx8ovinks2+No6ETJ1q5iOfyPP2CmGSURmWYoinAzhCxQ2Sw9flMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815808; c=relaxed/simple;
	bh=aHg8o04NZtszqamqXfpuQcoJ0xBXW6otD27s8Iuzsf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMM89ByYoJuYR+xmn2yNJIYos4XG5fdDnM4WENcq3JoDC65QpMI2skJWAj/FM4UJfZ5SteNN3oJMbePoWAupiQ4uwdBLGJSX4sbAOw8P497C0+2ti00ATtny7XdLtVT5JdZ7kfEmT/jUsxssxNZeIGAQB38rvQeXi4JA31rCAhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=YX7lET2Y; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YX7lET2Y"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ff1814102aso12165097b3.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741815806; x=1742420606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AxihhQSeMPdDLEeFEndib280oNxZMAnzHUEFz/G0WFw=;
        b=YX7lET2YukOSnXB7Gke4yD+km4gvnZkOuBpw9wvVlcTaoD5VVXK+k9qN4NokVJNirB
         UG2HMBAnW6uXEIzVCaDuE8hyS+VdJ/4ohKs3xIVzsjd9U+3v/Au/Tq2UL8sLYGyzLPKc
         XhK/HLMy+oX/wytrHSKqsEtZqx3+Cm+lOmNAnEcz+Zq/HJyQznu27Y8XDNTg0QofqK0H
         Sre3uikBCFWH1IQuDPIN4Gl/Q9n/mgpSwsRSJa47OwleKnIk1D/oPtULg8OxnCNEVjOG
         U8O6dKiCP8bjL+nkwBiNYFaqfEC6PR3BwRz1bLXJFSrtDDxo83b3nzsk1MlL4iFfjrcs
         qmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741815806; x=1742420606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxihhQSeMPdDLEeFEndib280oNxZMAnzHUEFz/G0WFw=;
        b=BjDNHcv4Dj1cyTsTh1Crij+PDSt76vWL/9UBqT8Eq+Z9Lqu35jYf8FvEcW+OrFAjzs
         RFne6w4nhvKA8SCtcPw2oVaZiVWgggQ2FXpT9WMM/8UmUZxr1MCLdzkjpdUQjzMvUPdw
         RBlckmJhWziltFOBw996KHzkoxP3dnuENZ8196qKg1S4fvv+sQh87Jz/KEnBvYRDaoSb
         yldh2CMK61Z1cvUxS1NSH4ghTwvNHkurIA888w09pRZw+Kpsp6q26MactkJ+VheXODP2
         Yf/HPxddEBmEUCu2UmiPsoZwanrpKpxrc2Dv++VqFw/HT+IodCJezFpSQcIgb7JCRuzI
         L9Pw==
X-Gm-Message-State: AOJu0YwxgTMYGcU7uralziclUu0JBAuFnJaFMVfuTcM6aXB5VUr3iewg
	nJEh1XDdne17cuhQWCLXTsTzTC88zhl4oFy9Z3+FxqNirZlPfsFrgEvfTNmVa04=
X-Gm-Gg: ASbGncvfTGrZsKekq2qZS7/8PrW6h2uscvQPhBFh645+Qc/gyXdiw34LoA2U1H+yRj6
	Ik6tTyY7FvV1GLEZNnm6UVDfmAlnzlgrJ5aAPaeqPG6H4TXb++LgpGSi4Lhztzu2psCoQuWfQey
	YjIXSKPxPDOUyAxmkvJ2NYZ7i2l9eHMda7wBO8RjbbirL+VjUmpmZh1bS6ksUU+sRIEsVPDo4qM
	ZoHOwRufonVNuvEJl0kEY/AIQQ8Udn9lJT+OjdwjAlOcS07JCL+0V7ihjnC+4S3JtWWfdARhJ7e
	W47IkyQrRT4z5Tzk5AeU9TlcDqWB2ycUBIDdpuwHR8iUzQ1OjzMKBDDiZ9Y2h87vUQz5uQXSTJw
	oQtA6paXOjkP/LxQK
X-Google-Smtp-Source: AGHT+IGyoJbTJS4Ae7L2yp+DJGgqRg/m8o94qAUlzq7yB7gn1i0a892hiSjLbjvpLjLUe9FsOzXk4g==
X-Received: by 2002:a0d:e945:0:b0:6f9:e4e1:a86 with SMTP id 00721157ae682-6ff2f861cb1mr1587167b3.16.1741815805721;
        Wed, 12 Mar 2025 14:43:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fecfe92e1bsm25408067b3.47.2025.03.12.14.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:43:25 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:43:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 6/9] fetch: ask server to advertise HEAD for config-less
 fetch
Message-ID: <Z9H//JHtYTGqHI3n@nand.local>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
 <20250309030847.GF2334191@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309030847.GF2334191@coredump.intra.peff.net>

On Sat, Mar 08, 2025 at 10:08:47PM -0500, Jeff King wrote:
> If we're not given any refspecs (either on the command line or via
> config) and we have no branch merge config, then we fetch the remote
> HEAD into our local FETCH_HEAD. In that case we do not send any
> ref-prefix option to the server at all, and we see the full
> advertisement.
>
> But this is sub-optimal. We only care about HEAD, so we can just ask
> for that, and ignore all of the other refs.
>
> The new test demonstrates a case where we see fewer refs (in this case
> only one less, but in theory we could be ignoring millions of them).
>
> This also removes the only case where we care about seeing some refs
> from the other side, but don't add anything to the ref_prefixes list.
> Cleaning this up means one less maintenance burden. Before this patch,
> any code which wanted to add to the list had to make sure the list was
> not empty, since an empty list meant "ask for everything". Now it really
> means "we are not interested in any refs".

Yes. The optimization is nice on its own, but I think this is the real
benefit to this patch IMHO.

> This should let us optimize a few more cases in subsequent patches.

;-).

> Note that we'll add "HEAD" to the list of prefixes, and later code for
> updating "refs/remotes/<remote>/HEAD" may likewise do so. In theory this
> could cause duplicates in the list, but in practice these can't both
> trigger. We hit our new case only if there are no refspecs, and the
> "<remote>/HEAD" feature is enabled only when we are fetching from a
> remote with configured refspecs. We could be defensive with a flag, but
> it didn't seem worth it to me (the absolute worse case is a useless
> redundant ref-prefix line sent to the server).

Yeah, I think that we already do this in some instances that you and I
talked about off-list, but I can't remember exactly what I did to
provoke it. In either case, the server responds correctly, so I don't
think it's so urgent to deal with ATM.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 95fd0018b9..f142756441 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1766,6 +1766,14 @@ static int do_fetch(struct transport *transport,
>  					    branch->merge[i]->src);
>  			}
>  		}
> +
> +		/*
> +		 * If there are no refs specified to fetch, then we just
> +		 * fetch HEAD; mention that to narrow the advertisement.
> +		 */
> +		if (!transport_ls_refs_options.ref_prefixes.nr)
> +			strvec_push(&transport_ls_refs_options.ref_prefixes,
> +				    "HEAD");

Makes sense. If we know that we just want to fetch HEAD into FETCH_HEAD
and we haven't already limited the advertisement, we are free to do so
now.

>  	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index cea8f92a3d..2f0a52a72d 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -679,6 +679,21 @@ test_expect_success 'default refspec is used to filter ref when fetching' '
>  	grep "ref-prefix refs/tags/" log
>  '
>
> +test_expect_success 'set up parent for prefix tests' '
> +	git init prefix-parent &&
> +	git -C prefix-parent commit --allow-empty -m foo &&

Any reason to use a bona-fide "commit" here instead of "test_commit"?

Not a big deal either way, of course, I'm just curious.

> +	git -C prefix-parent branch unrelated-branch
> +'
> +
> +test_expect_success 'empty refspec filters refs when fetching' '
> +	git init configless-child &&
> +
> +	test_when_finished "rm -f log" &&
> +	GIT_TRACE_PACKET="$(pwd)/log" \
> +		git -C configless-child fetch ../prefix-parent &&
> +	test_grep ! unrelated-branch log

Very clean, nice.

Thanks,
Taylor
