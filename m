Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75DF1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 21:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeBTVGL (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 16:06:11 -0500
Received: from titan.plasma.xg8.de ([85.10.203.189]:37550 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeBTVGK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 16:06:10 -0500
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w1KL69lS001210
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Feb 2018 22:06:09 +0100
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w1KL69FF001209;
        Tue, 20 Feb 2018 22:06:09 +0100
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w1KL5soV024725;
        Tue, 20 Feb 2018 22:05:54 +0100
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w1KL5sAh024724;
        Tue, 20 Feb 2018 22:05:54 +0100
Date:   Tue, 20 Feb 2018 22:05:54 +0100
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180220210554.GA24474@helen.PLASMA.Xg8.DE>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1802192257100.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180219220819.GA10466@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1802201127140.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1802201127140.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Tue, Feb 20, 2018 at 11:46:38AM +0100, Johannes Schindelin wrote:
> If I were you [...]

It seems all pretty straight forward, except for

> I would probably invent a file format (`<mtime><TAB><path><LF>`)

I'm stuck there because of <path> being munged.

To obtain or set the mtime of the file, I need the unmunged path.

How to get it?

----

What follows is irrelevant for progress.

> I don't think that code was ever there. Maybe you heard about some file
> mode being preserved overzealously (we stored the octal file mode
> verbatim, but then decided to store only 644 or 755).

I'm not sure. I'm not able to find that source anymore, though.

> As you can see from the code decoding a tree entry:
> 
> https://github.com/git-for-windows/git/blob/e1848984d/tree-walk.c#L25-L52
> 
> there is no mtime at all in the on-disk format of tree objects. There is
> the hash, the mode, and the file name.

I didn't comletely get the code in tree-walk.c since the parsing 
architecture seems to pass around pointers via global variables. 
It seems that in addition to hash, mode and file name, the on-disk 
format has at least the object type, see git cat-file -p master^{tree} 
Perhaps I got it wrong.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
