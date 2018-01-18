Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAC021FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 16:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932642AbeARQ1Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 11:27:24 -0500
Received: from verein.lst.de ([213.95.11.211]:34942 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932228AbeARQ1X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 11:27:23 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6ABED68DB6; Thu, 18 Jan 2018 17:27:21 +0100 (CET)
Date:   Thu, 18 Jan 2018 17:27:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
Message-ID: <20180118162721.GA26078@lst.de>
References: <20180117184828.31816-1-hch@lst.de> <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com> <87h8rki2iu.fsf@evledraar.gmail.com> <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com> <20180117235220.GD6948@thunk.org> <CA+55aFxgg6MT5Z+Jox2xyG28g9jNJ4cL3jNZ5AgTOmUODuiBsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxgg6MT5Z+Jox2xyG28g9jNJ4cL3jNZ5AgTOmUODuiBsA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[adding Chris to the Cc list - this is about the awful ext3 data=ordered
behavior of syncing the whole file system data and metadata on each
fsync]

On Wed, Jan 17, 2018 at 03:57:53PM -0800, Linus Torvalds wrote:
> On Wed, Jan 17, 2018 at 3:52 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > Well, let's be fair; this is something *ext3* got wrong, and it was
> > the default file system back them.
> 
> I'm pretty sure reiserfs and btrfs did too..

I'm pretty sure btrfs never did, and reiserfs at least looks like
it currently doesn't but I'd have to dig into history to check if
it ever did.
