Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C742027C
	for <e@80x24.org>; Fri,  2 Jun 2017 18:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751184AbdFBSzd (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 14:55:33 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33330 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbdFBSzc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 14:55:32 -0400
Received: by mail-pf0-f169.google.com with SMTP id e193so55309547pfh.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jh6JbgLtG2uzYNmHYRlTY5mglZvKo93zyZBXvHMYd9k=;
        b=mdP4jrHK9Px+f6RiJnBlWvagshIDXCRGeBH0LuDx9MpuagrF+qNDRA+15F5VRwNebT
         jHVf+j9htB2U0Vef+EcAvXISPYcmMMYWVT39luxrCoH1er0puE5hIOYCW6FEPdrztvHH
         JVeNauyAjtXhZdSfOJ2sIUXH/Cmvjkrq4gAMxvLR0rPFA5j1f6oh5VDRDTGI77I9Vsti
         U8NteBVGgJEhwbvib2gY3hFqnrOIqzyJRC1ehEC4E/67MzC8hS7HqXwNzUlbJA2fD5J7
         Po/b+u0YuhINh+v7UWvIrJvz9v+KTVt/G4BMPWCq8EWobOtWwFqqQoErKbUFY7FdnuTW
         fo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jh6JbgLtG2uzYNmHYRlTY5mglZvKo93zyZBXvHMYd9k=;
        b=rByHetXmixK5MWZJDHAk20m6gy0PZlNOLdwRrOmrQhbaKxqXViZJqIl32qxQJeNfma
         iqWggI1H5SiD+Vj4xpWBjeVN80ggTbPbn5x9dueRMKxCtq7nAe7WQKchWMOo/f/bGXhi
         jkQcBzYGiqTXU33EvQ5zX9BW4mX2D9DLFfTq42nf/UkBe1fnCbE1PVJmOHV2Y5vLHk9w
         nUzE+QZN3TKXw6Js9l+dcDO+NKe3td5Y65lgrtI0FeOIIPWRBqgbrByKu/44vp/DFGRC
         NS9ap1NcvEZcqDSDLeM+4J6paenP8W2y3r2Qb0hYHjTquzhIGX/Q4KeBvpKmivsiSM6w
         smfA==
X-Gm-Message-State: AODbwcANMWKaBl+PYQDDogd57VVZULi2NYeviPmoy6n4LSJGadh7Rifc
        BINm3kON+7I9ms9d
X-Received: by 10.99.131.65 with SMTP id h62mr7672743pge.151.1496429731205;
        Fri, 02 Jun 2017 11:55:31 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:89d2:8d21:abcd:1e61])
        by smtp.gmail.com with ESMTPSA id k86sm41148762pfk.125.2017.06.02.11.55.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 11:55:30 -0700 (PDT)
Date:   Fri, 2 Jun 2017 11:55:28 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 25/33] notes-merge: convert verify_notes_filepair to
 struct object_id
Message-ID: <20170602185528.GC57260@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
 <20170530173109.54904-26-bmwill@google.com>
 <xmqqpoen2p2a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpoen2p2a.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/02, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  notes-merge.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/notes-merge.c b/notes-merge.c
> > index 55dbb3659..962e9b1bc 100644
> > --- a/notes-merge.c
> > +++ b/notes-merge.c
> > @@ -22,21 +22,21 @@ void init_notes_merge_options(struct notes_merge_options *o)
> >  	o->verbosity = NOTES_MERGE_VERBOSITY_DEFAULT;
> >  }
> >  
> > -static int path_to_sha1(const char *path, unsigned char *sha1)
> > +static int path_to_oid(const char *path, struct object_id *oid)
> >  {
> > -	char hex_sha1[40];
> > +	char hex_oid[GIT_SHA1_HEXSZ];
> >  	int i = 0;
> > -	while (*path && i < 40) {
> > +	while (*path && i < GIT_SHA1_HEXSZ) {
> >  		if (*path != '/')
> > -			hex_sha1[i++] = *path;
> > +			hex_oid[i++] = *path;
> >  		path++;
> >  	}
> 
> It's no brainer to do s/GIT_SHA1_HEXSZ/GIT_MAX_HEXSZ/ for all of the
> above, but ...

I'll fix this.

> 
> > -	if (*path || i != 40)
> > +	if (*path || i != GIT_SHA1_HEXSZ)
> >  		return -1;
> 
> ... this one is tricky.  
> 
> What's in our envisioned future?  Are we expecing to see object
> names, named with two or more hash functions, in a same repository?
> If so, and one is 20 bytes and another one is 32 bytes, then this
> should check 'i' against 40 and 64 and pass if 'i' is one of these
> expected lengths?

That's a good question, and at this point in time do we have an
envisioned future?  From some of our conversations I seem to remember
that we don't want a single repository to have objects based on two
different hash functions, but rather some translation layer to convert
between two hashing functions (for compatibility with other
non-converted repos).  Though nothing has been settled upon yet so I
don't know what the future would look like (and the best way to prepare
for it).

> 
> > -	return get_sha1_hex(hex_sha1, sha1);
> > +	return get_oid_hex(hex_oid, oid);
> >  }

-- 
Brandon Williams
