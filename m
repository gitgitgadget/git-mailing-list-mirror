Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3344C20248
	for <e@80x24.org>; Mon,  8 Apr 2019 21:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDHVzk (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 17:55:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35113 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfDHVzj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 17:55:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so945456wmd.0
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 14:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UgiHJ2r86Bke4G4RfDNN2y42tuUVqCFLeR6Q8Yl0ubI=;
        b=Pvan3WDGJ7wD47KkPGpzx1e36f2aVW/tAViQ1BCEi1oX/syhDTRuY8uRUszU4JazRW
         yptSmtMl0q77C5m47j2vlcl8NQDGlqNR/RXSSGl7EiK6MhcVVKqSIx8wDe2elOjbGnZF
         orwArbvbgzSp+h5XPEZt3/nhxRv7cUZ4FLILsdkADufrBqw1FcZae8gsYomCuDiNxlBD
         ZH/XQQgFTazWoRMqUeDUxcRySx3yynzVtA8HRua6OUj7aprnCFTKaWtmusTbFxkzo2Q5
         /h6gpquX7yN+nqorcoDEePujxaL1VJl8gwD9ZU43UDGZAV3jEmbNhRYibQdpHF3emW1+
         gfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UgiHJ2r86Bke4G4RfDNN2y42tuUVqCFLeR6Q8Yl0ubI=;
        b=Q+rEPRIQMm5mN8xbaXpt5pyDPIXHLaBgMfhpy+i9zk6Ogw/zrDDPGMhs33fwzexyV3
         xJSRtYc6CggoQ7KGYoy7ozXOBH2RZroQLGRIs5ED8xmEuzLd7ahZA7xQs0SRY25Lln2C
         zioNw1GvTrR7iHz1rypgdAVoGvRczrxPgvrEA8DBEkSCZXAZkHgcHOWEElhllOWY3e6W
         7xEsxBJzOxcZ5PN9tZT2nI7f16F0rivbEv7X4fA9mBIeT8AcXEu4shhhapbbFBG6yNzU
         U7zpWLjDpq8oheASV/XRixZw2slWRGswSROlNxaOTS4USmpiJRh7M12SeLM+LUhL3ke9
         PKdg==
X-Gm-Message-State: APjAAAU5fSeAsXE9uVMHRqh4b7mQHDlgJeci/D+cgOF6Xj+VC5auQ6oM
        RZjTsJ+2JokDPVM+Xd0KhqE=
X-Google-Smtp-Source: APXvYqyDd0gfDZrIhrWecbb94Q0bnE1ORgcMMmWTbBayCK91dED7gOA47yWyzN64obDc0N1GsYQqew==
X-Received: by 2002:a1c:cf46:: with SMTP id f67mr18646889wmg.98.1554760537569;
        Mon, 08 Apr 2019 14:55:37 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id y125sm23114747wmc.39.2019.04.08.14.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 14:55:36 -0700 (PDT)
Date:   Mon, 8 Apr 2019 22:55:35 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GSoC][RFC] discussion about stashing with conflicts
Message-ID: <20190408215535.GB32487@hank.intra.tgummerer.com>
References: <CAMknYEN1x5zDPn4vaZmw3ch-Oy2=NQ=cfF9YmXumcbZGWvTToQ@mail.gmail.com>
 <20190407183857.GA32487@hank.intra.tgummerer.com>
 <CAMknYEOAg1S8cNYdLPgJemxgikisNpmeuw74T0w+7PUo93stVg@mail.gmail.com>
 <CACsJy8Dc3fuXWOOO-hNJqGNomufP7bffoHVf5hHLTubHQvq9vA@mail.gmail.com>
 <CAMknYENqH==YcAfU-B16Jytc4Pts4viNQn9deTFag++zZVb1+Q@mail.gmail.com>
 <CACsJy8D7mQZgJhZ4H8Z929EnjYe1Wp7idrbXqkUsmL1Ypn83dg@mail.gmail.com>
 <CAMknYENGZBQ6-8sJ5UrKS_ZLLoz79K8FYUHFQqSpV2JrkSuf6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMknYENGZBQ6-8sJ5UrKS_ZLLoz79K8FYUHFQqSpV2JrkSuf6w@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/08, Kapil Jain wrote:
> while understanding add_index_entry_with_check()
> i got to do_invalidate_path().
> 
> the commit hash for do_invalidate_path() function is
> `749864627c2d3c33bbc56d7ba0b5542af698cc40`
> 
> in the commit message it is explained that, cache-tree is used to
> store object names of index file objects and it is kept separate from
> index file because adding it would change index file format.
> 
> the part i couldn't understand is:
> "During various index manupulations, we selectively invalidate
> the parts so that the next write-tree can bypass regenerating
> tree objects for unchanged parts of the directory hierarchy."
> 
> what exactly does invalidating means here ?

FWIW, I don't think you need to understand cache-tree for the stash
GSoC project.  Your time is probably better spent taking what you
learned, and trying to make that into a proposal, as the application
period is coming to an end.

That said, since we are talking about a cache here, invalidating means
simply making part of the cache invalid, which means the caches
contents need to be re-calculated next time they are needed.

For the cache-tree in particular that means that we need to
re-calculate tree objects that have been invalidated, while we can
just re-use the ones that have not.

If you want to have a look at the cache-tree, you can use
't/helper/test-tool dump-cache-tree .git/index' from your locally
built git, which will dump the cache-tree that can be found
'.git/index'.  Compare the output of that command just after you did
'git reset --hard' on your repository (of course it needs some
contents), and after you modified some file, and added it to the index
using 'git add'.  In the latter case you will notice some directories
that are marked as 'invalid'.
