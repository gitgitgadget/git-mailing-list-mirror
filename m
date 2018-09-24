Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5DB1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 21:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeIYDYs (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:24:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36977 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeIYDYs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:24:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so21111305wrr.4
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 14:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=U7bf8mPqwbE4Ix4PeO9vR3j4KYdw6P/0Az2UZt7e5ik=;
        b=Af2KYJnS1iygXZuSC5c5YDBONInJBYHLkdrp0wFLIOTlKkwEgnhsMGsHoWT1eB0kgv
         UBzHXABtexurQlv4/+Jy0rVYUlSXAlz3bnIjeM33TVb7c6VT1CIplGPoR07cJW4ruNCA
         hyWaXd45r6FLvdiAZ9zkFGpmiwPqwcpV9Fl0qRJQ3fywrWzH5+KPhMd0S79b3IflpabT
         ThaRimYOR7hn6I5zlbK9DnbTFY1ZREekqj7I6oyQiztUasaP20lyxAMG41g8ab96/ShH
         Cn9Wt44H9uiZCBkgEqO44Ur+2MdSMwwNhk90NHR512imOHzK5fjgNW8hpzBl0QMmh6yn
         fDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=U7bf8mPqwbE4Ix4PeO9vR3j4KYdw6P/0Az2UZt7e5ik=;
        b=jmSd2ZwWGGYrdG1xuZuPsKkEa7vhIDPPfygzGwIbCQA8G+HvLXL86uGhRKyebjVxBG
         ZmGhAYoO9GbHmPXMoqZRSWJ7oQx2syAxnXmZgi2mDJ+LhGAQrJha/6Qu/xji/F4+fkF7
         667kC6SI78soPBm9mQohHXqRX159conTxpYCWUx825oqg3m7IXHRBC8wjTzkPo9opD7l
         eQNVA8cnVE7nXcQwLkfDguerOYDwkbB3K/WHLG8CgHS+ZvskOxuAKuuytDDZDLzi6iLN
         5P9MxDF9tCECcnlnwuSgBZqh74F321jkObvVe1bFPT31t4tSs9GRzGIUIILNRjGV6bVS
         OxeQ==
X-Gm-Message-State: ABuFfoiyywKIe4wpbW8HEDQTuBu2rNb/X2SYgdtDJ+Pfw3xdx2qG58zI
        Ne6j6fWNSTYi/sIzi2KSDDH4rOCB
X-Google-Smtp-Source: ACcGV63WRf+PUVorup4XEWNEyMo0oUsR2qJa+hUKC+goL9ZA3i2SESaX69ZsXBc4kQWhREymYTyMOw==
X-Received: by 2002:adf:e792:: with SMTP id n18-v6mr464818wrm.136.1537824037351;
        Mon, 24 Sep 2018 14:20:37 -0700 (PDT)
Received: from localhost (x4db15232.dyn.telefonica.de. [77.177.82.50])
        by smtp.gmail.com with ESMTPSA id p2sm279165wrx.80.2018.09.24.14.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 14:20:36 -0700 (PDT)
Date:   Mon, 24 Sep 2018 23:20:34 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, "H . Merijn Brand" <h.m.brand@xs4all.nl>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Olga Telezhnaia <olyatelezhnaya@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ref-filter: don't look for objects when outside of a
 repository
Message-ID: <20180924212034.GF27036@localhost>
References: <20180922124215.0c8172d1@pc09.procura.nl>
 <20180922141145.10558-1-szeder.dev@gmail.com>
 <20180924181722.GA25341@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180924181722.GA25341@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 02:17:22PM -0400, Jeff King wrote:
> On Sat, Sep 22, 2018 at 04:11:45PM +0200, SZEDER Gábor wrote:
 
> > diff --git a/ref-filter.c b/ref-filter.c
> > index e1bcb4ca8a..3555bc29e7 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -1473,7 +1473,8 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
> >  		oi->info.sizep = &oi->size;
> >  		oi->info.typep = &oi->type;
> >  	}
> > -	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
> > +	if (!have_git_dir() ||
> > +	    oid_object_info_extended(the_repository, &oi->oid, &oi->info,
> >  				     OBJECT_INFO_LOOKUP_REPLACE))
> >  		return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
> >  				       oid_to_hex(&oi->oid), ref->refname);
> 
> Would we perhaps want to give the user a hint that the object is not
> really missing, but rather that we're not in a repository? E.g.,
> something like:
> 
>   if (!have_git_dir())
> 	return strbuf_addf_ret(err, -1, "format specifier requires a repository");
>   if (oid_object_info_extended(...))
> 	return ...;
> 
> ?

I think it makes sense.

I wanted to preserve the error message, because the description of
'--sort=<key>' in 'Documentation/git-ls-remote.txt' explicitly
mentions it, and I added the condition at this place because I didn't
want to duplicate the construction of the error message.

However, if we go for a more informative error message, then wouldn't
it be better to add this condition in populate_value() before it even
calls get_object()?  Then we could also add the problematic format
specifier to the error message (I think, but didn't actually check),
just in case someone specified multiple sort keys.


