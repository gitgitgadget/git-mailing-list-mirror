Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D696F1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 20:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503594AbfJQUnt (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 16:43:49 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52495 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503586AbfJQUns (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Oct 2019 16:43:48 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0224B22033;
        Thu, 17 Oct 2019 16:43:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 17 Oct 2019 16:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=0GWZplg1lHj9uska7zCj9PE8q3N
        F/PMsDFYPaL401Qs=; b=rNF00he2SUsCh26tUeQy2gzEYyib1bJyJINKSZM02dE
        W0iC0qlykIeGOqtWwAeCeAD6rIzVP6LWaSKf0i0AcCR5xfB22+/4Q/7sQaMpGlJp
        sYEtkPrV4fdLvh2ZTMwHIhtK/3Tl7Q9Ht///bh0H0d2qCEH8oA+GP/znSEHfkOMM
        mxhQMV/W5vjisFQEPk6LbUZ8P5BhtM1qtS5p4yKT2viGCJFt5PtfbY2mqBcc376q
        lzm+0qXPLetEWlFagHHDVUa1kyw6yDENUBTZCOK3+mxb1nK0oah5SoR1FbgRPaHR
        xE2UfwxQ85EjlCtDtBkp4oyLjPmrTzqy2lup2/wa6nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0GWZpl
        g1lHj9uska7zCj9PE8q3NF/PMsDFYPaL401Qs=; b=I2xp2OR4sbJsehpKZJAwQZ
        2CMukoTmNhTzf3znYd0E/pMGufuxo40LAGAdFxplEHDZvYPLYjXBiJ4HMwqeFf5C
        fKKEfWtSKSRHn9cS8iOb1mBsEMPrv5JjGb+HYQRUskHo7QOJZrVTxwC1OZq9JHUm
        fDXvefJx8uURpTW1AyWrQIg3YrYZyDxbAyfqt618XRlqvPpXMU9b9TljlpkWE2fK
        bLgrbuRNoTvswsN74B7LTUatG/1houDI1IfNjI7GNWO4Oz0TJRf+lamGn0+pp1wb
        GEJbP2PP8WKavlQrx91KdimAsU+wmQMHdrLa8zuhvIjjku37sFf4NUU+iL60hJZg
        ==
X-ME-Sender: <xms:gtKoXTT_j9K8VQTyXDxHHy2ELsrlRorBTUJpwSH7qDcwVOfm_RquKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrjeejgdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppedutdegrddufedvrddtrd
    dutdelnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:gtKoXavq2nQsosFvGuBVQgaSCnuy95IzVM7dAKf2TZbLOK8smkNvpA>
    <xmx:gtKoXSiY9BZbGfhiC66nCxS1oRSZybiKGpIdhVuvfpu8Bx8-y_l_1w>
    <xmx:gtKoXT3d1G6W_wEp0m0dAQ5DSp0rYS7yK80Cn1OS5lBs5Q81xsjxrA>
    <xmx:gtKoXY7nHENjnQjBjyVpU3Uh2U17D7rDRytdHb3mwPg0nvjCbV3KHw>
Received: from localhost (unknown [104.132.0.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0530C80063;
        Thu, 17 Oct 2019 16:43:45 -0400 (EDT)
Date:   Thu, 17 Oct 2019 13:43:43 -0700
From:   Greg KH <greg@kroah.com>
To:     Santiago Torres Arias <santiago@nyu.edu>
Cc:     Willy Tarreau <w@1wt.eu>, Vegard Nossum <vegard.nossum@oracle.com>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191017204343.GA1132188@kroah.com>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 16, 2019 at 10:45:19AM -0400, Santiago Torres Arias wrote:
> Hi Willy, Vegard.
> 
> On Wed, Oct 16, 2019 at 01:10:09PM +0200, Willy Tarreau wrote:
> > Hi Vegard,
> > 
> > On Wed, Oct 16, 2019 at 12:22:54PM +0200, Vegard Nossum wrote:
> > > (cross-posted to git, LKML, and the kernel workflows mailing lists.)
> > > 
> > > Hi all,
> > > 
> > > I've been following Konstantin Ryabitsev's quest for better development
> > > and communication tools for the kernel [1][2][3], and I would like to
> > > propose a relatively straightforward idea which I think could bring a
> > > lot to the table.
> > > 
> > > Step 1:
> > > 
> > > * git send-email needs to include parent SHA1s and generally all the
> > >   information needed to perfectly recreate the commit when applied so
> > >   that all the SHA1s remain the same
> > > 
> > > * git am (or an alternative command) needs to recreate the commit
> > >   perfectly when applied, including applying it to the correct parent
> > > 
> > > Having these two will allow a perfect mapping between email and git;
> > > essentially email just becomes a transport for git. There are a lot of
> > > advantages to this, particularly that you have a stable way to refer to
> > > a patch or commit (despite it appearing on a mailing list), and there
> > > is no need for "changeset IDs" or whatever, since you can just use the
> > > git SHA1 which is unique, unambiguous, and stable.
> 
> I wonder if it'd be also possible to then embed gpg signatures over
> send-mail payloads so as they can be transparently transferred to the
> commit.

That's a crazy idea.  It would be nice if we could do that, I like it :)

greg k-h
