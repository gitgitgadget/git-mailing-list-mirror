Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D7FC64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 18:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCISPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 13:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCISPj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 13:15:39 -0500
Received: from qproxy5-pub.mail.unifiedlayer.com (qproxy5-pub.mail.unifiedlayer.com [69.89.21.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A37B3283
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 10:15:37 -0800 (PST)
Received: from progateway7-pub.mail.pro1.eigbox.com (gproxy5-pub.mail.unifiedlayer.com [67.222.38.55])
        by qproxy5.mail.unifiedlayer.com (Postfix) with ESMTP id 24DCF8025524
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 18:15:37 +0000 (UTC)
Received: from cmgw13.mail.unifiedlayer.com (unknown [10.0.90.128])
        by progateway7.mail.pro1.eigbox.com (Postfix) with ESMTP id A6E6010042D0F
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 18:15:36 +0000 (UTC)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with ESMTP
        id aKngpYgCLNX2aaKngpGADz; Thu, 09 Mar 2023 18:15:36 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=NMAQR22g c=1 sm=1 tr=0 ts=640a2248
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=k__wU0fu6RkA:10:nop_rcvd_month_year
 a=3EOfIcITIxQA:10:endurance_base64_authed_username_1 a=LhLT5SzZ9r9AOfd0xhUA:9
 a=QEXdDO2ut3YA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x/F8B8jN9TS+xL31TAdLFtQAhRFZmUGY6NfNu6qrx0k=; b=QWpyhgsyPXq/Y1ykwMkIAMXgjA
        yk9wigJejZlWq4cIuUpRzZhgDin6uD8+VGkC46UHr9WQ1IoQQh5zwud0Zaj9y74N6pO5wAatNM6pm
        +OzkuahbYKbt0WR/ApX8zO2wW;
Received: from [160.231.0.90] (port=17865 helo=llin-psh13-dsa.dsone.3ds.com)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <paul@mad-scientist.net>)
        id 1paKng-004F5d-Ag
        for git@vger.kernel.org;
        Thu, 09 Mar 2023 11:15:36 -0700
Message-ID: <42ea54b4b4d74d6760faca8325a657ee71f342d7.camel@mad-scientist.net>
Subject: Re: Fetching everything in another bare repo
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     git@vger.kernel.org
Date:   Thu, 09 Mar 2023 13:15:33 -0500
In-Reply-To: <ZAn80gnIFLOF4Gco@coredump.intra.peff.net>
References: <6215dde710670fdf0da3ba0549429eaa32db257b.camel@mad-scientist.net>
         <ZAl/lQMhaQ54BDXN@coredump.intra.peff.net>
         <64282d0f99df59085a18585846d2086a652677e2.camel@mad-scientist.net>
         <ZAn80gnIFLOF4Gco@coredump.intra.peff.net>
Organization: Please remain calm--I may be mad but I am a professional!
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (by Flathub.org) 
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5922.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 160.231.0.90
X-Source-L: No
X-Exim-ID: 1paKng-004F5d-Ag
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.0.90]:17865
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2023-03-09 at 10:35 -0500, Jeff King wrote:
> > Basically, these bare clones have "gc.pruneExpire=3Dnever" set, and
> > have never had any GC operations run so all commits are still
> > present (when you say "unreachable" I assume you mean, not
> > reachable through any reference).
>=20
> Right, that's what I mean by unreachable. And no, you didn't use any
> terminology wrong. I was just not sure if you realized that running
> "fetch" would not get the unreachable objects. :)

I definitely did not realize that, so good looking out :)

Of course in retrospect it makes perfect sense: why would you fetch
unreachable objects (normally)?

> > One question: is the objects/info/packs file anything to be
> > concerned about or will git repack (or something) take care of
> > handling it?
>=20
> You can ignore it.

OK thx.

> Yeah, if you have a separate database of branch tips, etc, then the
> refs aren't necessary. As long as you are careful not to run "gc" or
> repack without "-k".

It's actually a code review facility so it doesn't even care about
branches, it's basically just storing before/after SHAs of changes to
be reviewed.  But the historical code reviews can sometimes be gold,
even if they're some years old, so I'd prefer to keep them available.

> You may want to try the "preciousObjects" repository extension, which
> was designed to prevent accidents for a case like this.

Oh interesting, I'll take a look.

Cheers!
