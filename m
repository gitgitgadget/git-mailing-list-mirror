Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C9E1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 16:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfBHQNj (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 11:13:39 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:59700 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfBHQNj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 11:13:39 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gs8mS-0000ms-00; Fri, 08 Feb 2019 16:13:32 +0000
Date:   Fri, 8 Feb 2019 11:13:32 -0500
From:   Rich Felker <dalias@libc.org>
To:     Kevin Daudt <me@ikke.info>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kevin Daudt <git@lists.ikke.info>, git@vger.kernel.org,
        larsxschneider@gmail.com
Subject: Re: t0028-working-tree-encoding.sh failing on musl based systems
 (Alpine Linux)
Message-ID: <20190208161332.GW23599@brightrain.aerifal.cx>
References: <20190207215935.GA31515@alpha>
 <20190208001705.GC11927@genre.crustytoothpaste.net>
 <20190208060403.GA29788@brightrain.aerifal.cx>
 <20190208114502.GD11927@genre.crustytoothpaste.net>
 <20190208115511.GA30779@alpha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208115511.GA30779@alpha>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 12:55:11PM +0100, Kevin Daudt wrote:
> On Fri, Feb 08, 2019 at 11:45:02AM +0000, brian m. carlson wrote:
> > On Fri, Feb 08, 2019 at 01:04:03AM -0500, Rich Felker wrote:
> > [..]
> > > In any case, this test seems mainly relevant to Windows users wanting
> > > to store source files in UTF-16LE with BOM. This doesn't really make
> > > sense to do on a Linux/musl system, so I'm not sure any action is
> > > needed here from either side.
> > 
> > I do know that some people use CIFS or the like to share repositories
> > between Unix and Windows. However, I agree that such people aren't
> > likely to use UTF-16 on Unix systems. The working tree encoding
> > functionality also supports other encodings which musl may or may not
> > support.
> > 
> > If you and your users are comfortable with the fact that the test (and
> > the corresponding functionality) won't work as expected with UTF-16,
> > then I agree that no action is needed.
> 
> So would you suggest that we just skip this test on Alpine Linux?

I'm fine with that as an outcome here. Admittedly I'd rather see git
do this in a way that doesn't make assumptions about what an ambiguous
"UTF-16" encoding argument to iconv_open does, but nothing is actually
breaking because of this.

Rich
