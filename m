Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C042D1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 18:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbeGRTBE (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 15:01:04 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:34917 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeGRTBC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 15:01:02 -0400
Received: by mail-pl0-f47.google.com with SMTP id w3-v6so2408281plq.2
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YHYRjcWtODgS0+XBFbfChskSWIojg90kPRQ1BbBXaDo=;
        b=mr3P7RBYcZbYl6AeloarGwvWyBcgkDtt+fiZry7q4Vcl77Wf/ay5d5YU9fDyu0gEOU
         QNygIVHROaxX7Zgmd7yNr5PZYw/A+BursHajfutFWtqLdUwIr05yy6zLb8OEJdZxg9lC
         u5BKcAuYZKg2F12/mEGsZijtngdW9tjrLbSfDqka0liE/Oo43KaExYnKRk7qepr+UNMF
         Z2ahlf2E1OqrZXmyJyD87/UkHCR1/QY/uyHQiDqOx5kCXwjzoHQaFpArHEQJahJ9SHF0
         15lpPY21M8pHu9j15krrwfksnal2qPx6cZsk4VAmtA7h7hHUHFwySUZV8AY+cPGiHzt2
         +tsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YHYRjcWtODgS0+XBFbfChskSWIojg90kPRQ1BbBXaDo=;
        b=adR074FTRbHWN84xwtgjHxGCbihRMg41FofLqvJ3bxQxm4VcoKwYx1NjYtAoYeV9F+
         LFCyGa52dj3bt7jlicLkkJC9aLs2MtA7W3vAQUBaYzdY0h8+igi8gt++LmVxQWfPSIg2
         NUsUI4HQH6IVWxx5Zu/HRJlodYLZchMWe5QzIzmN88Lw4yaGOU7LewYL5+hkdkNmsLPJ
         haTyc9bbb1/q697ULCGQnzyj4EaK9LqrM5BuF7xqvi5aHrrKCylnuLL20dvf60R9heBt
         Lj2S5JHLfkPn7Eq15TxkDyaSNLx9XswkUgMlOD5fT13JRDjp/aGqjxtLkyVvLzg6k3LS
         WxLQ==
X-Gm-Message-State: AOUpUlH+YIAcHaUNGBBVxPJa8g3q4nm7U9+OwePtNIqh9V8k9SZY/JzD
        Jp6gpKvBxg2Kfw6ne1d3WjpcLA==
X-Google-Smtp-Source: AAOMgpehr3iWGSBDwi1H1pcs/WsBsgcrIALnXsSsi9gyvp2pAeJqHTgcXORzRvOZekL9zEGKYIn54A==
X-Received: by 2002:a17:902:740a:: with SMTP id g10-v6mr1810182pll.204.1531938116279;
        Wed, 18 Jul 2018 11:21:56 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id c85-v6sm12149474pfd.110.2018.07.18.11.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 11:21:55 -0700 (PDT)
Date:   Wed, 18 Jul 2018 11:21:54 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFC] push: add documentation on push v2
Message-ID: <20180718182154.GE17137@google.com>
References: <20180717210915.139521-1-bmwill@google.com>
 <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
 <20180718170846.GA17137@google.com>
 <CAGZ79kZ4HOvo-xaDK=USveJ5zaLdJSddh8XNxsOsFHQuu7KcZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ4HOvo-xaDK=USveJ5zaLdJSddh8XNxsOsFHQuu7KcZQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/18, Stefan Beller wrote:
> > > Given the example above for "rebase-on-push" though
> > > it is better to first send the packfile (as that is assumed to
> > > take longer) and then send the ref updates, such that the
> > > rebasing could be faster and has no bottleneck.
> >
> > I don't really follow this logic.  I don't think it would change
> > anything much considering the ref-updates section would usually be
> > much smaller than the packfile itself, course I don't have any data so
> > idk.
> 
> The server would need to serialize all incoming requests and apply
> them in order. The receiving of the packfile and the response to the client
> are not part of the critical section that needs to happen serialized but
> can be spread out to threads. So for that use case it would make
> sense to allow sending the packfile first.

I would think that a server needs to read the whole request before any
actions can be done, but maybe I need to think about this a bit more.

> 
> > > > +    update = txn_id SP action SP refname SP old_oid SP new_oid
> > > > +    force-update = txn_id SP "force" SP action SP refname SP new_oid
> > >
> > > So we insert "force" after the transaction id if we want to force it.
> > > When adding the atomic capability later we could imagine another insert here
> > >
> > >   1 atomic create refs/heads/new-ref <0-hash> <hash>
> > >   1 atomic delete refs/heads/old-ref <hash> <0-hash>
> > >
> > > which would look like a "rename" that we could also add instead.
> > > The transaction numbers are an interesting concept, how do you
> > > envision them to be used? In the example I put them both in the same
> > > transaction to demonstrate the "atomic-ness", but one could also
> > > imagine different transactions numbers per ref (i.e. exactly one
> > > ref per txn_id) to have a better understanding of what the server did
> > > to each individual ref.
> >
> > I believe I outlined their use later.  Basically if you give the server
> > free reign to do what it wants with the updates you send it, then you
> > need a way for the client to be able to map the result back to what it
> > requested.  Since now i could push to "master" but instead of updating
> > master the server creates a refs/changes/1 ref and puts my changes there
> > instead of updating master.  The client needs to know that the ref
> > update it requested to master is what caused the creation of the
> > refs/changes/1 ref.
> 
> understood, the question was more related to how you envision what
> the client/server SHOULD be doing here, (and I think a one txn_id per
> ref is what SHOULD be done is how this is best to implement the
> thoughts above, also the client is ALLOWED to put many refs in one
> txn, or would we just disallow that already at this stage to not confuse
> the server?)

Oh sorry for misunderstanding.  Yeah, as of right now I think having a
one-to-one relationship makes it easier to write/implement but I don't
know if there are other workflows which would benefit from multiple per
txn_id.

> 
> >
> > >
> > > Are new capabilities attached to ref updates or transactions?
> > > Unlike the example above, stating "atomic" on each line, you could just
> > > say "transaction 1 should be atomic" in another line, that would address
> > > all refs in that transaction.
> >
> > I haven't thought through "atomic" so i have no idea what you'd want
> > that to look like.
> 
> Yeah I have not really thought about them either, I just see two ways:
> (A) adding more keywords in each ref-update (like "force") or
> (B) adding new subsections somewhere where we talk about the capabilities
>   instead.
> 
> Depending on why way we want to go this might have impact on the
> design how to write the code.
> 
> > > > +       * Normal ref-updates require that the old value of a ref is supplied so
> > > > +         that the server can verify that the reference that is being updated
> > > > +         hasn't changed while the request was being processed.
> > >
> > > create/delete assume <00..00> for either old or new ? (We could also
> > > omit the second hash for create delete, which is more appealing to me)
> >
> > Well that depends, in the case of a create you want to ensure that no
> > ref with that name exists and would want it to fail if one already
> > existed.  If you want to force it then you don't care if one existed or
> > not, you just want the ref to have a certain value.
> 
> What I was trying to say is to have
> 
>     update = txn_id SP (modifier SP) action
>     modifier = "force" | "atomic"
>     action = (create | delete | update)
>     create = "create" SP <hash>
>     update = "update" SP <hash> SP <hash>
>     delete = "delete" SP <hash>
> 
> i.e. only one hash for the create and delete action.
> (I added the "atomic" modifier to demonstrate (A) from above, not needed here)

I understood what you were asking, I was just pointing out the rationale
for including the zero-id but i guess you're correct in that simply
omitting it would work just as well for what I outlined above.  So I
think I'll go with what you suggested here.

> 
> > >
> > > > +       * Forced ref-updates only include the new value of a ref as we don't
> > > > +         care what the old value was.
> > >
> > > How are you implementing force-with-lease then?
> >
> > Currently force-with-lease/force is implemented 100% on the client side,
> 
> Uh? That would be bad. Reading 631b5ef219c (push --force-with-lease: tie
> it all together, 2013-07-08) I think that send-pack is done server-side?

send-pack.c is the client side of push while receive-pack is the
server side.  There currently doesn't exist a way for a server to
understand the difference between a force/force-with-lease/non-force
push.

> 
> > this proposal extends these two to be implemented on the server as well.
> > non-forced variant are basically the "with-lease" case and "force" now
> > actually forces an update.
> 
> I think we have 3 modes:
> (1) standard push, where both client and server check for a fast-forward
> (2) "force" that blindly overwrites the ref, but as that has a race condition
>     in case multiple people can push to the remove we have
> (3) "with-lease", disables the fast forward check both on client and server
>     but still takes out a lock on the server to ensure no races happen
> 
> Now you propose to have only 2, making (1) and (3) the same, deferring
> the check to have "fast forwards only" to be client only?
> The server surely wants to ensure that, too (maybe you need
> special permission for non-ff; depends on the server implementation).
> 
> I am not sure I like it, as on the protocol level this indeed looks the same
> and the server and client need to care in their implementation how/when
> the ff-check is done. Though it would be nice for the client UX that you
> need to give a flag to check for ff (both client and server side? or can we rely
> on the client alone then?)

IIRC there are no checks done server-side for force, with-lease, or
fast-forward (well fast-forward can be checked for but this is a config
and has nothing to do with the protocol).  Most of the work is done by
the client to ensure these checks are made.

> 
> > > > +             (delim-pkt | flush-pkt)
> > > > +
> > > > +    unpack-error = PKT-LINE("ERR" SP error-msg LF)
> > > > +
> > > > +    ref-update-status = *(update-result | update-error)
> > > > +    update-result = *PKT-LINE(txn_id SP result LF)
> > > > +    result = ("created" | "deleted" | "updated") SP refname SP old_oid SP new_oid
> > > > +    update-error = PKT-LINE(txn_id SP "error" SP error-msg LF)
> > >
> > > Can we unify "ERR" and "error" ?
> >
> > No, these are very different.  You could have one ref update succeed
> > while another doesn't for some reason, unless you want everything to be
> > atomic.
> 
> I did not mean to unify them on the semantic level, but on the
> representation level, i.e. have both of them spelled the same,
> as they can still be differentiated by the leading txn id?

Oh I misunderstood again :) yeas we could standardize on ERR.

> 
> 
> Thanks,
> Stefan
> 
> P.S.: another feature that just came to mind is localisation of error messages.
> But that is also easy to do with capabilities (the client sends a capability
> such as "preferred-i18n=DE" and the server may translate all its errors
> if it can.
> 
> That brings me to another point: do we assume all errors to be read
> by humans? or do we want some markup things in there, too, similar to
> EAGAIN?

This sort of thing could be added as a protocol-level capability where
the client sends LANG=<some language> so that those sorts of msgs could
be translated server side before sending them.

-- 
Brandon Williams
