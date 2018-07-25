Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28831F597
	for <e@80x24.org>; Wed, 25 Jul 2018 17:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbeGYS7I (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 14:59:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41647 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbeGYS7H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 14:59:07 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so3589711ply.8
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fI8ThwDFqvNoFjNPteRAXg9fKYqgUxBr8WcGgekEFhg=;
        b=qToOP2VE6Q0JEyo8UsQKrfhWwhWOa6c4JJOxwkW7DgYnD2IPoeyFkoKSTuUTMyl9sf
         0/dbB2G+bMcL+XYVpvwMSud6yEgp7EhMnAn3B7aqjR589F0Yd8bJGdNvEWZCWCzrtWcV
         59vX1tpg6K6rIjwQT+7/JaM1fa5Fzv+oxFRFEn/71nR9RZFiQUt8TxBzB1EJxRn8F1wB
         bGsf/pZ35Yhw2qx6sFVS4dBJon8H552ApFQ3znUGktPDWQ1ip2dI5TxZwLwXf7GvpSpS
         zMqfagpofvqh8S5mYD1XVZ+Dn20pAMeJktslubwkb9PYskns3JjBgSYn4MCvee51aPNR
         uaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fI8ThwDFqvNoFjNPteRAXg9fKYqgUxBr8WcGgekEFhg=;
        b=EKFzaNA2T/7AeTxmHIR2VEYKF6xM5nJK1Cg8/9APQmcHXkmS3/k0H9fnaa0OiHpgVw
         E5RNOLXbA3fHjZmCKGxcIIcyTnsFbjcjd1gIDfgAUPW3+5Nu55DLR+bOFBVX2BJE6JEJ
         1RYI0elOSwvc9rkyRdaWiOpI+Ow9NdjgEXFAccPwyhkzXteOTGeqoiOBVtGw2EAMW6Bw
         AOaFPR3cjyV1CSb/VNdpT4Xf3GaWCapt3A+4B7mWmAZRX+h9O8gAgeyiC6vIRSzbz3+S
         bk6lN8yRrPcWMCfXJG6gWR8BLYOa14mXLZdx+jv6bqFbn+y9NqkKDWQUk8gg4/ElZrw9
         fMpA==
X-Gm-Message-State: AOUpUlHWqKFizkf7cLqZopcDrHE3orFGd6ewsMR9VQNIaQOBwOrouhoZ
        yxusB6Awhc9gL4x6YIsYkhKF/w==
X-Google-Smtp-Source: AAOMgpczTeDGcz5yIy0KgvDnFx/lDp8zwgdJcDRvdjCl3MRgTeX15AsdD3yainb5WsprYlnK/16j8Q==
X-Received: by 2002:a17:902:59da:: with SMTP id d26-v6mr21816861plj.42.1532540784990;
        Wed, 25 Jul 2018 10:46:24 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id h24-v6sm32547352pfk.113.2018.07.25.10.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 10:46:23 -0700 (PDT)
Date:   Wed, 25 Jul 2018 10:46:22 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC] push: add documentation on push v2
Message-ID: <20180725174622.GA4850@google.com>
References: <20180717210915.139521-1-bmwill@google.com>
 <20180724192811.GC225275@google.com>
 <CACsJy8C9z14GsxfyPm_pDuGwAQqm6Cdi2dO3bsqiYDE0scVbkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8C9z14GsxfyPm_pDuGwAQqm6Cdi2dO3bsqiYDE0scVbkQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/25, Duy Nguyen wrote:
> On Tue, Jul 24, 2018 at 9:29 PM Brandon Williams <bmwill@google.com> wrote:
> >
> > On 07/17, Brandon Williams wrote:
> > > Signed-off-by: Brandon Williams <bmwill@google.com>
> > > ---
> > >
> > > Since introducing protocol v2 and enabling fetch I've been thinking
> > > about what its inverse 'push' would look like.  After talking with a
> > > number of people I have a longish list of things that could be done to
> > > improve push and I think I've been able to distill the core features we
> > > want in push v2.  Thankfully (due to the capability system) most of the
> > > other features/improvements can be added later with ease.
> > >
> > > What I've got now is a rough design for a more flexible push, more
> > > flexible because it allows for the server to do what it wants with the
> > > refs that are pushed and has the ability to communicate back what was
> > > done to the client.  The main motivation for this is to work around
> > > issues when working with Gerrit and other code-review systems where you
> > > need to have Change-Ids in the commit messages (now the server can just
> > > insert them for you and send back new commits) and you need to push to
> > > magic refs to get around various limitations (now a Gerrit server should
> > > be able to communicate that pushing to 'master' doesn't update master
> > > but instead creates a refs/changes/<id> ref).
> > >
> > > Before actually moving to write any code I'm hoping to get some feedback
> > > on if we think this is an acceptable base design for push (other
> > > features like atomic-push, signed-push, etc can be added as
> > > capabilities), so any comments are appreciated.
> > >
> > >  Documentation/technical/protocol-v2.txt | 76 +++++++++++++++++++++++++
> > >  1 file changed, 76 insertions(+)
> >
> > Pinging this thread again to hopefully reach some more people for
> > commentary.
> 
> Could you send a v2 that covers all the push features in pack version
> 1? I see some are discussed but it's probably good to summarize in
> this document too.

I can mention the ones we want to implement, but I expect that a push v2
would not require that all features in the current push are supported
out of the box.  Some servers may not want to support signed-push, etc.
Also I don't want to have to implement every single feature that exists
before getting something merged.  This way follow on series can be
written to implement those as new features to push v2.

> 
> A few other comments
> 
> If I remember correctly, we always update the remote refs locally
> after a push, assuming that the next 'fetch' will do the same anyway.
> This is not true for special refs (like those from gerrit). Looking
> from this I don't think it can say "yes we have received your pack and
> stored it "somewhere" but there's no visible ref created for it" so
> that we can skip the local remote ref update?

This is one of the pain points for gerrit and one of the reasons why
they have this funky push syntax "push origin HEAD:refs/for/master".
Because its not a remote tracking branch for the current branch, we
don't update (or create) a local branch "for/master" under the
"refs/remotes/origin" namespace (at least that's how i understand it).

So in order to support the server doing more things (rebasing, or
creating new branches) based on what is pushed the status that the
server sends in response needs to be more fluid so that the server can
describe what it did in a way that the client can either: update the
remote tracking branches, or not (and in this case maybe do what you
suggest down below).

> 
> Is it simpler to tell a push client at the end that "yes there's new
> stuff now on the server, do another fetch", sort of like HTTP
> redirect, then the client can switch to fetch protocol to get the new
> stuff that the server has created (e.g. rebase stuff)? I assume we
> could reuse the same connection for both push and fetch if needed.
> This way both fetch and push send packs in just one direction.

I really, really like this suggestion.  Thank you for your input.  This
would actually make the protocol much simpler by keeping push for
pushing packs and fetch for fetching packs.  And since my plan is to
have the status-report for push include all the relevant ref changes
that the server made, if there are any that don't correspond with what
was pushed (either the server rebased a change or created a new ref I
didn't) then we can skip the ref-advertisement and go straight to
fetching those refs.  And yes, since protocol v2 is command based we
could reuse the existing connection and simply send a "fetch" request
after our "push" one.

This does mean that it'll be an extra round trip than what I originally
had in mind, but it should be simpler.

-- 
Brandon Williams
