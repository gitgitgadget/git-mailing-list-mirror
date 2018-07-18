Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E17A61F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbeGRRrk (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 13:47:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46326 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbeGRRrk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 13:47:40 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so2308900pld.13
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oMpgTJRqK7w2d0iA4CNzXqDN/w9e43rr3l5vqOnoAmo=;
        b=I3j3FJ+pI/MnSCsradNTfKRtoIpTe+FSSIhq4DkpcGfLIEk3Ivq8+2QEqWTJYrRoqt
         4QOPJTkzu9PiL9xBZDvtND5A9tZe68CgXloUsOKPO8l9dMQaIemOIglAe2lSqelkrmxh
         UIq1CzBAihHBUZncIfkEpKVf1oRbxh02ZN2VqOqvK/2xLiLXNGw/hzQjpaB7N+lP2bGm
         j9XkztdiGYnTI0o70vsZxsUR6O8rBl8l/gozrhd7ahvB1a2dtPPTXWh8VvB4GrPh4BDa
         Q0ServjNJ1vaIHq1kevkeen81FWyzeq82m595h6daUf+/R8OW/U9deKlAaFMVB4FqQBm
         VYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oMpgTJRqK7w2d0iA4CNzXqDN/w9e43rr3l5vqOnoAmo=;
        b=um8vySrePwYGAZPbhWn/bYeV2WH7Bxg4rbKJvUPIdIca1kj9LgvZOBt1P3i9eJIqqT
         nVndnHawZ+IFyMcqYhGryEw5SCmmKUe8WKE0OGWwDlxqAUHL9J+dUb767oKKH7ag2tZO
         B3wfRUqJgoRhZ3Z0kx41QGkvYXqlvodrgvZmS0JRzIcUl6JDeDmny1Zx+HuOF5XiBIyQ
         6klo0PW4Vi3AKWPPl612qE0xlh/IKF33CZdGogF4zHpa/8i+nUKMZqAvNgOKp0dRcNV/
         u9J0UHfCqXu08UP+mHCNM6wRhtQ8ADPTqcg92iYzzIUbaFKdIyHiL/EJbko+u7cm2EG2
         5g2Q==
X-Gm-Message-State: AOUpUlFa/Zjz1EEPGbk44Y2DPNPJoHEFLnIXkDxbUTVI7hfU8ihJdCLT
        gfEYk8OSFdzgMqDeTJMRLzwNU5iH1c8=
X-Google-Smtp-Source: AAOMgpeFLXe6u45WniTGGIeZn0W67+sAq2e+iFKSbWwGyAMme+eXz/7J77bfDSVxR2+Ea1CZEs1dew==
X-Received: by 2002:a17:902:5ac3:: with SMTP id g3-v6mr6661407plm.90.1531933728990;
        Wed, 18 Jul 2018 10:08:48 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id d22-v6sm9189069pfk.69.2018.07.18.10.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:08:47 -0700 (PDT)
Date:   Wed, 18 Jul 2018 10:08:46 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFC] push: add documentation on push v2
Message-ID: <20180718170846.GA17137@google.com>
References: <20180717210915.139521-1-bmwill@google.com>
 <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/17, Stefan Beller wrote:
> On Tue, Jul 17, 2018 at 2:09 PM Brandon Williams <bmwill@google.com> wrote:
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >
> > Since introducing protocol v2 and enabling fetch I've been thinking
> > about what its inverse 'push' would look like.  After talking with a
> > number of people I have a longish list of things that could be done to
> > improve push and I think I've been able to distill the core features we
> > want in push v2.
> 
> It would be nice to know which things you want to improve.

I mean this tackles the main point I want to improve.  Others include:
rebase/merge-on-push, push symrefs, and then the inclusion of other
capabilities from v0 like atomic push, signed push, etc.

> 
> >  Thankfully (due to the capability system) most of the
> > other features/improvements can be added later with ease.
> >
> > What I've got now is a rough design for a more flexible push, more
> > flexible because it allows for the server to do what it wants with the
> > refs that are pushed and has the ability to communicate back what was
> > done to the client.  The main motivation for this is to work around
> > issues when working with Gerrit and other code-review systems where you
> > need to have Change-Ids in the commit messages (now the server can just
> > insert them for you and send back new commits) and you need to push to
> > magic refs to get around various limitations (now a Gerrit server should
> > be able to communicate that pushing to 'master' doesn't update master
> > but instead creates a refs/changes/<id> ref).
> 
> Well Gerrit is our main motivation, but this allows for other workflows as well.
> For example Facebook uses hg internally and they have a
> "rebase-on-the-server-after-push" workflow IIRC as pushing to a single repo
> brings up quite some contention. The protocol outlined below would allow
> for such a workflow as well? (This might be an easier sell to the Git
> community as most are not quite familiar with Gerrit)

Yes the idea would be such that we could easily add a "rebase" or
"merge" verb later for explicit user controlled workflows like that.
This proposal would already make it possible (although the server would
need to be configured as such) since the server can do what it wants
with the updates a client sends to it.

> 
> > Before actually moving to write any code I'm hoping to get some feedback
> > on if we think this is an acceptable base design for push (other
> > features like atomic-push, signed-push, etc can be added as
> > capabilities), so any comments are appreciated.
> >
> >  Documentation/technical/protocol-v2.txt | 76 +++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >
> > diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> > index 49bda76d23..16c1ce60dd 100644
> > --- a/Documentation/technical/protocol-v2.txt
> > +++ b/Documentation/technical/protocol-v2.txt
> > @@ -403,6 +403,82 @@ header.
> >                 2 - progress messages
> >                 3 - fatal error message just before stream aborts
> >
> > + push
> > +~~~~~~
> > +
> > +`push` is the command used to push ref-updates and a packfile to a remote
> > +server in v2.
> > +
> > +Additional features not supported in the base command will be advertised
> > +as the value of the command in the capability advertisement in the form
> > +of a space separated list of features: "<command>=<feature 1> <feature 2>"
> > +
> > +The format of a push request is as follows:
> > +
> > +    request = *section
> > +    section = (ref-updates | packfile)
> 
> This reads as if a request consists of sections, which
> each can be a "ref-updates" or a packfile, no order given,
> such that multiple ref-update sections mixed with packfiles
> are possible.
> 
> I would assume we'd only want to allow for ref-updates
> followed by the packfile.
> 
> Given the example above for "rebase-on-push" though
> it is better to first send the packfile (as that is assumed to
> take longer) and then send the ref updates, such that the
> rebasing could be faster and has no bottleneck.

I don't really follow this logic.  I don't think it would change
anything much considering the ref-updates section would usually be
much smaller than the packfile itself, course I don't have any data so
idk.

> 
> > +              (delim-pkt | flush-pkt)
> 
> 
> 
> > +
> > +    ref-updates = PKT-LINE("ref-updates" LF)
> > +                 *PKT-Line(update/force-update LF)
> > +
> > +    update = txn_id SP action SP refname SP old_oid SP new_oid
> > +    force-update = txn_id SP "force" SP action SP refname SP new_oid
> 
> So we insert "force" after the transaction id if we want to force it.
> When adding the atomic capability later we could imagine another insert here
> 
>   1 atomic create refs/heads/new-ref <0-hash> <hash>
>   1 atomic delete refs/heads/old-ref <hash> <0-hash>
> 
> which would look like a "rename" that we could also add instead.
> The transaction numbers are an interesting concept, how do you
> envision them to be used? In the example I put them both in the same
> transaction to demonstrate the "atomic-ness", but one could also
> imagine different transactions numbers per ref (i.e. exactly one
> ref per txn_id) to have a better understanding of what the server did
> to each individual ref.

I believe I outlined their use later.  Basically if you give the server
free reign to do what it wants with the updates you send it, then you
need a way for the client to be able to map the result back to what it
requested.  Since now i could push to "master" but instead of updating
master the server creates a refs/changes/1 ref and puts my changes there
instead of updating master.  The client needs to know that the ref
update it requested to master is what caused the creation of the
refs/changes/1 ref.

> 
> > +    action = ("create" | "delete" | "update")
> > +    txn_id = 1*DIGIT
> > +
> > +    packfile = PKT-LINE("packfile" LF)
> > +              *PKT-LINE(*%x00-ff)
> > +
> > +    ref-updates section
> > +       * Transaction id's allow for mapping what was requested to what the
> > +         server actually did with the ref-update.
> 
> this would imply the client ought to have at most one ref per transaction id.
> Is the client allowed to put multiple refs per id?

No code has been written yet, so idk.  Right now i don't see any reason
to have multiple updates using the same id but that could change.

> 
> Are new capabilities attached to ref updates or transactions?
> Unlike the example above, stating "atomic" on each line, you could just
> say "transaction 1 should be atomic" in another line, that would address
> all refs in that transaction.

I haven't thought through "atomic" so i have no idea what you'd want
that to look like.

> 
> > +       * Normal ref-updates require that the old value of a ref is supplied so
> > +         that the server can verify that the reference that is being updated
> > +         hasn't changed while the request was being processed.
> 
> create/delete assume <00..00> for either old or new ? (We could also
> omit the second hash for create delete, which is more appealing to me)

Well that depends, in the case of a create you want to ensure that no
ref with that name exists and would want it to fail if one already
existed.  If you want to force it then you don't care if one existed or
not, you just want the ref to have a certain value.

> 
> > +       * Forced ref-updates only include the new value of a ref as we don't
> > +         care what the old value was.
> 
> How are you implementing force-with-lease then?

Currently force-with-lease/force is implemented 100% on the client side,
this proposal extends these two to be implemented on the server as well.
non-forced variant are basically the "with-lease" case and "force" now
actually forces an update.  Right now you can still have a "forced"
update fail to update when using a stateless transport because by the
time you send the ref-updates they've changed from what you read in the
ref-advertisement (this can happen with projects with high velocity).

If you just wanted to preserve the existing force-with-lease/force
behavior you can simply use the non-force variant of a ref-update.

> 
> > +    packfile section
> > +       * A packfile MAY not be included if only delete commands are used or if
> > +         an update only incorperates objects the server already has
> 
> Or rather: "An empty pack SHALL be omitted" ?
> 
> > +The server will receive the packfile, unpack it, then validate each ref-update,
> > +and it will run any update hooks to make sure that the update is acceptable.
> > +If all of that is fine, the server will then update the references.
> > +
> > +The format of a push response is as follows:
> > +
> > +    response = *section
> > +    section = (unpack-error | ref-update-status | packfile)
> 
> As above, I assume they ought to go in the order as written,
> or would it make sense to allow for any order?
> 
> > +             (delim-pkt | flush-pkt)
> > +
> > +    unpack-error = PKT-LINE("ERR" SP error-msg LF)
> > +
> > +    ref-update-status = *(update-result | update-error)
> > +    update-result = *PKT-LINE(txn_id SP result LF)
> > +    result = ("created" | "deleted" | "updated") SP refname SP old_oid SP new_oid
> > +    update-error = PKT-LINE(txn_id SP "error" SP error-msg LF)
> 
> Can we unify "ERR" and "error" ?

No, these are very different.  You could have one ref update succeed
while another doesn't for some reason, unless you want everything to be
atomic.

> 
> > +    packfile = PKT-LINE("packfile" LF)
> > +              *PKT-LINE(*%x00-ff)
> > +
> > +    ref-update-status section
> > +       * This section is always included unless there was an error unpacking
> > +         the packfile sent in the request.
> > +       * The server is given the freedom to do what it wants with the
> > +         ref-updates provided in the reqeust.  This means that an update sent
> > +         from the server may result in the creation of a ref or rebasing the
> > +         update on the server.
> > +       * If a server creates any new objects due to a ref-update, a packfile
> > +         MUST be sent back in the response.
> > +
> > +    packfile section
> > +       * This section is included if the server decided to do something with
> > +         the ref-updates that involved creating new objects.
> > +
> >   server-option
> >  ~~~~~~~~~~~~~~~
> >
> > --
> > 2.18.0.203.gfac676dfb9-goog
> >

-- 
Brandon Williams
