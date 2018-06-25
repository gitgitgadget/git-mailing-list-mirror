Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697BE1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 18:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964882AbeFYSSY (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:18:24 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32882 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934772AbeFYSSX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:18:23 -0400
Received: by mail-pg0-f67.google.com with SMTP id e11-v6so6426100pgq.0
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jpFHgccxRG+ru3WGbHIV+3wARR5sgXjIj3IVeZRCKko=;
        b=GeTaPEM40rsxUmKxHa5EQkAHs6/n7l0bNi/Q07gDPhlrdfDnAvfO0keq0bz7iOLXtd
         eu1EUeOflqJWwOjtLWUj+Z3EBFezH+n7tSqEdFzAK/KifZuQwFRXoAChvituqv2PGIve
         hED9MmOvzzp1ZYVRGYpcujHHTXG5d2tbyYLHbCEvS5lHZCvRESTFn2rGBbJ5WYg8vJbs
         JprWFIv04o6+XDDyveLXkbrUPCo4bM/BK7yJ34RmHEJGGGn2/HJf8OB+wdIv3RMqGRjr
         GnBNdhZMdjTRNYlOZ4S9ULkivOHaR1aQvZHy++DQ8qCVLJ8UjGSFz9NlNpmfCt//1jZv
         8ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jpFHgccxRG+ru3WGbHIV+3wARR5sgXjIj3IVeZRCKko=;
        b=o1uL3J9VhbwLowoF9tn4HjCp77MKYW3EoYDu2c8gIHUdo+JCZtsbj3y1/a7E2wKKB6
         Q6sMMtR/geNREngKsS2gFjKdFFyqig9BEhBpND5+cdDzUvHNtrykYntpsS3jWz7t95P0
         Zsg7+l7H76pRfqfRibuyp9tNrFqB9yjWcWo87tQ5KYfml2UqAh4p8ko7qLz8e1htanlM
         6qYzyAdnIRGjJSQwxSOyeNbcJWmCHRJ5AVmNQYKedy9OXOehA+WbW9dShO2q01MniIrB
         zV6Dmopw77hicecxndbKAIN9qDkbgg8Lsx4c0J0OZhweUFn2s5nmZMdX5BxEwL5A18+l
         Y9Rg==
X-Gm-Message-State: APt69E19+2iQ32nyYIHSOGRylqxZik6Iy1KxxuV5ChYzL6ReTZ/Gm8tC
        d7Wy05/7d50yb2BAFEgIo0zUTA==
X-Google-Smtp-Source: ADUXVKKIU/mPKeOtT28YL3u7iOoYdYUXOZH6/NK72a/p1DQGuIQZDmBeoOxmlMHT/ZohX5y3EQSscA==
X-Received: by 2002:a65:47cc:: with SMTP id f12-v6mr11610795pgs.173.1529950702748;
        Mon, 25 Jun 2018 11:18:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id y2-v6sm11609992pfa.43.2018.06.25.11.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 11:18:21 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:18:20 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: Re: [PATCH v3 7/8] fetch-pack: put shallow info in output parameter
Message-ID: <20180625181820.GB19910@google.com>
References: <20180620213235.10952-8-bmwill@google.com>
 <20180625180353.227420-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625180353.227420-1-jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/25, Jonathan Tan wrote:
> >  static void update_shallow(struct fetch_pack_args *args,
> > -			   struct ref **sought, int nr_sought,
> > +			   struct ref *refs,
> 
> update_shallow() now takes in a linked list of refs instead of an array.
> I see that the translation of this function is straightforward -
> occasionally, we need to iterate through the linked list and count up
> from 0 at the same time, but that is not a problem.
> 
> >  			   struct shallow_info *si)
> >  {
> >  	struct oid_array ref = OID_ARRAY_INIT;
> >  	int *status;
> > -	int i;
> > +	int i = 0;
> 
> Remove the " = 0" - I've verified that it does not need to be there, and
> it might inhibit useful "unintialized variable" warnings if others were
> to change the code later.
> 
> Optional: I would also remove this declaration and declare "int i;" in
> each of the blocks that need it.
> 
> >  static int fetch_refs_via_pack(struct transport *transport,
> > -			       int nr_heads, struct ref **to_fetch)
> > +			       int nr_heads, struct ref **to_fetch,
> > +			       struct ref **fetched_refs)
> >  {
> >  	int ret = 0;
> >  	struct git_transport_data *data = transport->data;
> > @@ -354,8 +356,12 @@ static int fetch_refs_via_pack(struct transport *transport,
> >  	if (report_unmatched_refs(to_fetch, nr_heads))
> >  		ret = -1;
> >  
> > +	if (fetched_refs)
> > +		*fetched_refs = refs;
> > +	else
> > +		free_refs(refs);
> > +
> >  	free_refs(refs_tmp);
> > -	free_refs(refs);
> >  	free(dest);
> >  	return ret;
> >  }
> 
> Instead of just freeing the linked list, we return it if requested by
> the client. This makes sense.
> 
> > -int transport_fetch_refs(struct transport *transport, struct ref *refs)
> > +int transport_fetch_refs(struct transport *transport, struct ref *refs,
> > +			 struct ref **fetched_refs)
> >  {
> >  	int rc;
> >  	int nr_heads = 0, nr_alloc = 0, nr_refs = 0;
> >  	struct ref **heads = NULL;
> > +	struct ref *nop_head = NULL, **nop_tail = &nop_head;
> >  	struct ref *rm;
> >  
> >  	for (rm = refs; rm; rm = rm->next) {
> >  		nr_refs++;
> >  		if (rm->peer_ref &&
> >  		    !is_null_oid(&rm->old_oid) &&
> > -		    !oidcmp(&rm->peer_ref->old_oid, &rm->old_oid))
> > +		    !oidcmp(&rm->peer_ref->old_oid, &rm->old_oid)) {
> > +			/*
> > +			 * These need to be reported as fetched, but we don't
> > +			 * actually need to fetch them.
> > +			 */
> > +			if (fetched_refs) {
> > +				struct ref *nop_ref = copy_ref(rm);
> > +				*nop_tail = nop_ref;
> > +				nop_tail = &nop_ref->next;
> > +			}
> >  			continue;
> > +		}
> >  		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
> >  		heads[nr_heads++] = rm;
> >  	}
> > @@ -1245,7 +1263,11 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
> >  			heads[nr_heads++] = rm;
> >  	}
> >  
> > -	rc = transport->vtable->fetch(transport, nr_heads, heads);
> > +	rc = transport->vtable->fetch(transport, nr_heads, heads, fetched_refs);
> > +	if (fetched_refs && nop_head) {
> > +		*nop_tail = *fetched_refs;
> > +		*fetched_refs = nop_head;
> > +	}
> >  
> >  	free(heads);
> >  	return rc;
> 
> And sometimes, even if we are merely simulating the fetching of refs, we
> still need to report those refs in fetched_refs. This is correct.
> 
> I also see that t5703 now passes.
> 
> Besides enabling the writing of subsequent patches, I see that this also
> makes the API clearer in that the input refs to transport_fetch_refs()
> are not overloaded to output shallow information. Other than the " = 0"
> change above, this patch looks good to me.

Perfect, I'll just drop the " = 0" part (making the diff slightly
smaller)

-- 
Brandon Williams
