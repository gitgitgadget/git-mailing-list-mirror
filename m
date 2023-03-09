Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F6BC64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 13:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjCIN5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 08:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjCINzo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 08:55:44 -0500
Received: from qproxy5-pub.mail.unifiedlayer.com (qproxy5-pub.mail.unifiedlayer.com [69.89.21.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809C6DD597
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 05:55:34 -0800 (PST)
Received: from alt-proxy28.mail.unifiedlayer.com (alt-proxy28.mail.unifiedlayer.com [74.220.216.123])
        by qproxy5.mail.unifiedlayer.com (Postfix) with ESMTP id 6F148803153D
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 13:55:33 +0000 (UTC)
Received: from cmgw15.mail.unifiedlayer.com (unknown [10.0.90.130])
        by progateway1.mail.pro1.eigbox.com (Postfix) with ESMTP id 21AAA10040614
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 13:55:32 +0000 (UTC)
Received: from box5922.bluehost.com ([162.241.30.80])
        by cmsmtp with ESMTP
        id aGk0pXVnx9Qs9aGk0p8mV0; Thu, 09 Mar 2023 13:55:32 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=PJbKRdmC c=1 sm=1 tr=0 ts=6409e554
 a=u+82WREdhvUKZ7QTvcqjvQ==:117 a=u+82WREdhvUKZ7QTvcqjvQ==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=k__wU0fu6RkA:10:nop_rcvd_month_year
 a=3EOfIcITIxQA:10:endurance_base64_authed_username_1 a=pygM2RYxLqpcUcsY5BEA:9
 a=QEXdDO2ut3YA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8ScSyAghfcZBuTQBqnZWZbb9XsuRdjHhMbmP92ME7mA=; b=KmwR3uspHm2w1gmCcYrysGDrtn
        SFKfWNbQUImK9BF6llESJvqP2kamTMYG4PFRiHBLN/0fBseqCV5HueC4ihE6U4pqf6SvniI47nF8Z
        uJu3t/gBsqk9y6yZeArNfAD/l;
Received: from [160.231.0.90] (port=41033 helo=llin-psh13-dsa.dsone.3ds.com)
        by box5922.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <paul@mad-scientist.net>)
        id 1paGjz-0014bv-PP
        for git@vger.kernel.org;
        Thu, 09 Mar 2023 06:55:31 -0700
Message-ID: <64282d0f99df59085a18585846d2086a652677e2.camel@mad-scientist.net>
Subject: Re: Fetching everything in another bare repo
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     git@vger.kernel.org
Date:   Thu, 09 Mar 2023 08:55:27 -0500
In-Reply-To: <ZAl/lQMhaQ54BDXN@coredump.intra.peff.net>
References: <6215dde710670fdf0da3ba0549429eaa32db257b.camel@mad-scientist.net>
         <ZAl/lQMhaQ54BDXN@coredump.intra.peff.net>
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
X-Exim-ID: 1paGjz-0014bv-PP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (llin-psh13-dsa.dsone.3ds.com) [160.231.0.90]:41033
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTkyMi5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2023-03-09 at 01:41 -0500, Jeff King wrote:
> On Wed, Mar 08, 2023 at 05:39:07PM -0500, Paul Smith wrote:
>=20
> > I have a tool that wants to preserve every commit and never garbage
> > collect (there are references that need to be maintained to older
> > commits/branches that have been deleted).=C2=A0 This tool keeps its own
> > bare clone, and disables all GC and maintenance on it.
>=20
> OK. It's not clear to me if this archive repo retains the old
> references, or if it simply has a bunch of unreachable objects.
> That distinction will matter below.

Sorry; I've been using Git for a long time but am still not totally
immersed in the terminology :).

Basically, these bare clones have "gc.pruneExpire=3Dnever" set, and have
never had any GC operations run so all commits are still present (when
you say "unreachable" I assume you mean, not reachable through any
reference).

There is a separate database of information containing SHAs for these
commits, that is used to find them, but there is nothing in Git itself
that references them so they are indeed unreachable as far as Git is
concerned.

> I think you probably want to treat the objects and references
> separately. It's safe to just copy all of the objects and packfiles
> from the old clone into the new one. You'll have duplicates, but you
> should be able to de-dup and get a single packfile with:
>=20
>   git repack -ad --keep-unreachable

Oh interesting.  I did a quick verification and all of the objects /
packfiles in the old clone either don't exist in the new one, or are
identical.  I'm sure you expected that but I needed to reassure myself
I wouldn't be overwriting anything :).

One question: is the objects/info/packs file anything to be concerned
about or will git repack (or something) take care of handling it?

> And then you can do any ref updates in the new repository (since it
> now has all objects from both).

It's actually possible that I don't care about refs at all.  I might
only care about objects.  I'm not sure, I can check what exists in the
old clone.

But if I need them I can deal with them as you suggest (or something
similar).

Thanks Jeff!
