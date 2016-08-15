Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4731F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 13:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbcHONro (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 09:47:44 -0400
Received: from mta02.prd.rdg.aluminati.org ([94.76.243.215]:49616 "EHLO
	mta02.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753086AbcHONrm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2016 09:47:42 -0400
Received: from mta02.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 3A19E23136;
	Mon, 15 Aug 2016 14:47:36 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTP id 2FFD93410;
	Mon, 15 Aug 2016 14:47:36 +0100 (BST)
X-Quarantine-ID: <ewjks7iZK77u>
X-Virus-Scanned: Debian amavisd-new at mta02.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta02.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ewjks7iZK77u; Mon, 15 Aug 2016 14:47:34 +0100 (BST)
Received: from john.keeping.me.uk (unknown [10.2.0.9])
	by mta02.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 5398933F2;
	Mon, 15 Aug 2016 14:47:29 +0100 (BST)
Date:	Mon, 15 Aug 2016 14:47:28 +0100
From:	John Keeping <john@keeping.me.uk>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Philip Oakley <philipoakley@iee.org>,
	Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: storing cover letter of a patch series?
Message-ID: <20160815134728.atwmswrlxtwzpaxl@john.keeping.me.uk>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
 <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
 <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com>
 <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
 <CACsJy8BdmR5USJvjJ6xbjj=bP787tdS72_oL+PDq0D+FPYmiPA@mail.gmail.com>
 <DD86BC6E2E3245BA991E4D65CE66E4A8@PhilipOakley>
 <CACsJy8DWDEQOKLV+c1zCXhiHZbxF3iM9_rFWhju3hk=Ji1i3ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DWDEQOKLV+c1zCXhiHZbxF3iM9_rFWhju3hk=Ji1i3ZQ@mail.gmail.com>
User-Agent: Mutt/1.6.2 (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 08:30:03PM +0700, Duy Nguyen wrote:
> On Mon, Aug 15, 2016 at 7:37 PM, Philip Oakley <philipoakley@iee.org> wrote:
> > I appreciate there has been a lot of discussion, but it mainly appears to be
> > about an upstream / integration viewpoint.
> >
> > I'd hate it if there was a one size fits all solution that was only focused
> > on one important use case, rather than having at least a simple fallback for
> > simple folk.
> >
> > Personally I liked the idea that I could start my patch series branch with a
> > simple 'empty' commit with a commit message that read "cover! <subject of
> > the series>" and continue with the cover letter. It's essentially the same
> > as the fixup! and squash! idea (more the latter - it's squash! without a
> > predecessor). For moderate size series a simple 'git rebase master..' is
> > sufficient to see the whole series and decide which need editing, rewording,
> > swapping, checking the fixups, etc.
> 
> I think you hit the jackpot (or are getting very close). This removes
> the special status of "the commit at the tip of the branch" cover
> letter. Maybe I just like it so much I have a hard time finding
> anything wrong with it :)

I haven't followed this thread too closely, but has anyone mentioned
U-Boot's patman tool[1] yet?

It defines several special trailers that can be used to annotate commits
with additional information to use when mailing them and which are
automatically removed from the commit message in patches sent using
patman.


[1] http://git.denx.de/?p=u-boot.git;a=blob;f=tools/patman/README
