Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407561F403
	for <e@80x24.org>; Tue, 19 Jun 2018 17:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030284AbeFSRmC (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 13:42:02 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41431 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030225AbeFSRl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 13:41:59 -0400
Received: by mail-pf0-f194.google.com with SMTP id a11-v6so212747pff.8
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 10:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PqhVF18CoA/EOmJ4GTrB3e99jtdFKYNPdXoVKd81Oko=;
        b=d5wzy5ZzGB6xd7QQohwF3CJTJgt70NUW4fFm7xoHlhVA1RYP4HKiCvIvfbqCrk+9Wj
         LAvvDzxC869pcSQiJa00AYUpZz3F923IWvo0prUqNfxJqSTnQsO4NhllgYaX3w2ZQxmz
         dh9DMaxXOYGPhcJhi3APhshU5xWWKNOZjtNRfnHEByB2cXfdHXTNDIDkfDAoQ+HNIyff
         +1TlgxjzCLa5ZhDbPs0CUpACH0DEXPajELIGW5v7UX2UHeB6uIKdgT2JAjYwvKhrebVd
         ZhDfcgMOjuRHv9DYnXb2PO5cbGFeWpwdcEBvggixqs9mTCSRrSkKWOK88ZQ8QAm5LRlM
         u8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PqhVF18CoA/EOmJ4GTrB3e99jtdFKYNPdXoVKd81Oko=;
        b=Fs+0TS+Bxn+vJA3Rq+coNq8mdd6dttTy5cHpUs+xm9/GLCb2ObYzYSj/eRBtH1dANH
         KrIwvGe6CH2u0BXHkcczyWpcpj/H6gA3UmFT9/AOX2BvLBXHOwx+hjmC23vEx469M/Th
         8a0hRGe2OzCsrL2pLcje/hqYa1Xpa+LhUR+Q7n7onj/VYVl5JVSLPmj0r/4sdvh84KXD
         1D/iOFqpr7B/vynOEGQMZI1FVmZhptbeZe0duIYhgqfvxVezyOSDdj+qeN8HquGAe0aK
         9DRTSDxQzo35CvNhJ98g3lXmC+uzNOXijlX/R4uW7Z4yeB7loMydL9wzUWcbr4XM2ZEo
         cOZw==
X-Gm-Message-State: APt69E2FURkkhhZ4xab0JfNjokLjyZt8f9Zrlp5C8euJsgzjwBcf4+GH
        biYLpDOK+s5fJndUKVsLJ7droADZawQ=
X-Google-Smtp-Source: ADUXVKLSzcfXHkNynZdB1E3buXcihotxD6QytKxX5AJ9TDrc7m2Oo1s10Ery5DaCoYiF6R9k6rdS/g==
X-Received: by 2002:a65:5d09:: with SMTP id e9-v6mr15754660pgr.150.1529430119178;
        Tue, 19 Jun 2018 10:41:59 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p73-v6sm300459pfa.142.2018.06.19.10.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 10:41:57 -0700 (PDT)
Date:   Tue, 19 Jun 2018 10:41:56 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 7/8] fetch-pack: put shallow info in output parameter
Message-ID: <20180619174156.GB199585@google.com>
References: <20180613213925.10560-8-bmwill@google.com>
 <20180614235939.205716-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614235939.205716-1-jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/14, Jonathan Tan wrote:
> > @@ -1122,6 +1124,7 @@ static int do_fetch(struct transport *transport,
> >  	int autotags = (transport->remote->fetch_tags == 1);
> >  	int retcode = 0;
> >  	const struct ref *remote_refs;
> > +	struct ref *new_remote_refs = NULL;
> 
> Above, you use the name "updated_remote_refs" - it's probably better to
> standardize on one. I think "updated" is better.

Good catch I'll update the variable name.

> 
> (The transport calling it "fetched_refs" is fine, because that's what
> they are from the perspective of the transport. From the perspective of
> fetch-pack, it is indeed a new or updated set of remote refs.)
> 
> > -	if (fetch_refs(transport, ref_map) || consume_refs(transport, ref_map)) {
> > +
> > +	if (fetch_refs(transport, ref_map, &new_remote_refs)) {
> > +		free_refs(ref_map);
> > +		retcode = 1;
> > +		goto cleanup;
> > +	}
> > +	if (new_remote_refs) {
> > +		free_refs(ref_map);
> > +		ref_map = get_ref_map(transport->remote, new_remote_refs, rs,
> > +				      tags, &autotags);
> > +		free_refs(new_remote_refs);
> > +	}
> > +	if (consume_refs(transport, ref_map)) {
> >  		free_refs(ref_map);
> >  		retcode = 1;
> >  		goto cleanup;
> 
> Here, if we got updated remote refs, we need to regenerate ref_map,
> since it is the source of truth.
> 
> Maybe add a comment in the "if (new_remote_refs)" block explaining this
> - something like: Regenerate ref_map using the updated remote refs,
> because the transport would place shallow (and other) information
> there.

That's probably a good idea to give future readers more context into why
this is happening.

> 
> > -		for (i = 0; i < nr_sought; i++)
> > +		for (r = refs; r; r = r->next, i++)
> >  			if (status[i])
> > -				sought[i]->status = REF_STATUS_REJECT_SHALLOW;
> > +				r->status = REF_STATUS_REJECT_SHALLOW;
> 
> You use i here without initializing it to 0. t5703 also fails with this
> patch - probably related to this, but I didn't check.

Oh yeah that's definitely a bug, thanks for catching that.

> 
> If you initialize i here, I don't think you need to initialize it to 0
> at the top of this function.

-- 
Brandon Williams
