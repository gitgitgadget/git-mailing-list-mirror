Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6A131F597
	for <e@80x24.org>; Mon, 23 Jul 2018 12:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388235AbeGWN4k (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 09:56:40 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:51547 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387883AbeGWN4k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 09:56:40 -0400
Received: by mail-it0-f54.google.com with SMTP id g14-v6so1306066iti.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+1n/CEEGzZjfOLWoQuQMXm/06lfsXmbsLMJzFNGz7o=;
        b=o7jPK/QQRGjZ/+72PAsQetAIaoE6qAQbvcqINDA+t5qc4o8mo7RQg+1BO/l+x/H3Aq
         PGDQ74yPe25nADtWQ4CJfko5UuPTMMU1fK7+y6bB1UEti/q1GLGYjkCZQrhov3KhfE7m
         4iQZyRJ+pD1oN6TfqD0JVViTjlprF8oYWjYsPJXOCPcZ7haIJ6sqkLR9ByFnVy+M45c3
         DgJ7l0Dhe14e4Gv8I/ItHrq0tm+tiRDOE7C2Rd9FHNdCODQVfIb5leIWPl1NfcduVx5Q
         IV+OrK5q+FbmZQu51EBjmCEakunsGqkPDyieetZhaZsu9rtvNGn2w3pGQ7aj7hc9dFpX
         AALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+1n/CEEGzZjfOLWoQuQMXm/06lfsXmbsLMJzFNGz7o=;
        b=KOOZsvdRA6mwOeJo8/R13EAe5WbqJm/gdlOg5vm/SBxsH4Q3vhcKXaveb38HEowP8M
         FpaWtJk8uX9XWDMjN6TnUmie8ZM4BGAtKmZ3XyMLPqwuTlWIcl1ZjDfnTY95dZnlMUis
         vpnNTsTjfbjQtQJNM66gdRltefTEZ02kPeNC83+eegyptn8St2yZzP8EgQHL3lAQZ3bk
         wQwz5UQX+Xa2P2aNqYzFKOJvIZ6nLRrZVlwP/nJU/IDJ8dET1fi4SCy9rU0LHRbpknIs
         qQ1EEn/6xRJ5ceRtBqXV0NlFEG7LVlSf4NyOmbs8AAPH12iGLOAtzMyRmToisWV31zD3
         Ca2w==
X-Gm-Message-State: AOUpUlEC64PNHtsz9tnXQDPvM0tD0bpwGfeRKc8zwjpXY3CLRzbCL1mc
        6L0fZtsnYixtfp4aLiydxxbx6SwFPcFhgMzo1Ms=
X-Google-Smtp-Source: AAOMgpfwQoMvfMm659VILnqCGJqQAfWUUVhWddQKXb9TD5KTDtFDuAFpooknklVu6qeO++akaKEiCqIuUbH6l1yejF4=
X-Received: by 2002:a24:2143:: with SMTP id e64-v6mr10728346ita.66.1532350532595;
 Mon, 23 Jul 2018 05:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net> <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
 <20180721235941.GG18502@genre.crustytoothpaste.net> <CANgJU+X39NoEoMyLu+FX38=x19LrRqatz_dUpUAc+WFV+Uw+=A@mail.gmail.com>
 <98111891-a605-1cfd-e92b-a3b5b4186ac2@gmail.com>
In-Reply-To: <98111891-a605-1cfd-e92b-a3b5b4186ac2@gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Mon, 23 Jul 2018 14:55:21 +0200
Message-ID: <CANgJU+U+XEpBLQAZKkNTqcAKTfKqMStNBk2pr7wjLq2q+BELww@mail.gmail.com>
Subject: Re: Hash algorithm analysis
To:     Sitaram Chamarty <sitaramc@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, agl@google.com,
        keccak@noekeon.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 23 Jul 2018 at 14:48, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On 07/23/2018 06:10 PM, demerphq wrote:
> > On Sun, 22 Jul 2018 at 01:59, brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> >> I will admit that I don't love making this decision by myself, because
> >> right now, whatever I pick, somebody is going to be unhappy.  I want to
> >> state, unambiguously, that I'm trying to make a decision that is in the
> >> interests of the Git Project, the community, and our users.
> >>
> >> I'm happy to wait a few more days to see if a consensus develops; if so,
> >> I'll follow it.  If we haven't come to one by, say, Wednesday, I'll make
> >> a decision and write my patches accordingly.  The community is free, as
> >> always, to reject my patches if taking them is not in the interest of
> >> the project.
> >
> > Hi Brian.
> >
> > I do not envy you this decision.
> >
> > Personally I would aim towards pushing this decision out to the git
> > user base and facilitating things so we can choose whatever hash
> > function (and config) we wish, including ones not invented yet.
> >
> > Failing that I would aim towards a hashing strategy which has the most
> > flexibility. Keccak for instance has the interesting property that its
> > security level is tunable, and that it can produce aribitrarily long
> > hashes.  Leaving aside other concerns raised elsewhere in this thread,
> > these two features alone seem to make it a superior choice for an
> > initial implementation. You can find bugs by selecting unusual hash
> > sizes, including very long ones, and you can provide ways to tune the
> > function to peoples security and speed preferences.  Someone really
> > paranoid can specify an unusually large round count and a very long
> > hash.
> >
> > Also frankly I keep thinking that the ability to arbitrarily extend
> > the hash size has to be useful /somewhere/ in git.
>
> I would not suggest arbitrarily long hashes.  Not only would it
> complicate a lot of code, it is not clear that it has any real benefit.

It has the benefit of armoring the code for the *next* hash change,
and making it clear that such decisions are arbitrary and should not
be depended on.

> Plus, the code contortions required to support arbitrarily long hashes
> would be more susceptible to potential bugs and exploits, simply by
> being more complex code.  Why take chances?

I think the benefits would outweight the risks.

> I would suggest (a) hash size of 256 bits and (b) choice of any hash
> function that can produce such a hash.  If people feel strongly that 256
> bits may also turn out to be too small (really?) then a choice of 256 or
> 512, but not arbitrary sizes.

I am aware of too many systems that cannot change their size and are
locked into woefully bad decisions that were made long ago to buy
this.

Making it a per-repo option, would eliminate assumptions and make for
a more secure and flexible tool.

Anyway, I am not going to do the work so my opinion is worth the price
of the paper I sent it on. :-)

cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
