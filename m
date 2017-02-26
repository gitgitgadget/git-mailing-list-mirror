Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4931201B0
	for <e@80x24.org>; Sun, 26 Feb 2017 00:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbdBZAQN (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 19:16:13 -0500
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:43730 "EHLO
        pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751912AbdBZAQN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Feb 2017 19:16:13 -0500
X-MHO-User: b5f385e6-fbb8-11e6-b3c2-c9f38144898e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 173.50.81.193
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [173.50.81.193])
        by outbound2.ore.mailhop.org (Halon) with ESMTPSA
        id b5f385e6-fbb8-11e6-b3c2-c9f38144898e;
        Sun, 26 Feb 2017 00:15:43 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id B0A1D80018;
        Sun, 26 Feb 2017 00:16:07 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io B0A1D80018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1488068167;
        bh=Z7/raLPujRdwGD4xB2tjmP+pbgQXPKVxmQGjRKjfg+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=TBXBhsRr70MBu9X1kLpZqI2UTHLInDaXy8NAaVyUukUI//APsPwj28016tsa6Sc+A
         L26EJu37iopNExnr3Vb1hMTgZ4lNCBQZSFM6nLWmdNmiVMs65aqJbtCGrXoEVlRBXH
         8brwmAIduBeL3GegJJgzMnb6Aay/bNmMq3iOG9J/2SNksJmj+Rg5hcKb7jiKWE6AcJ
         YDypBK5yw5MEKs4FUSKB7gfS81NQkPakghosgkaVEC+UezG8pZ/c6eZEnnb28wJQe/
         S/s2Fo6VCEwurdawzYNFImE9w0oI1MnzQWmopHik/R695TT99mi0Sx0+DQlyDCmVkn
         I3i6vAoqlMYpA==
Date:   Sun, 26 Feb 2017 00:16:07 +0000
From:   Jason Cooper <git@lakedaemon.net>
To:     ankostis <ankostis@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>, David Lang <david@lang.hm>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>
Subject: Re: SHA1 collisions found
Message-ID: <20170226001607.GH11350@io.lakedaemon.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <nycvar.QRO.7.75.62.1702240943540.6590@qynat-yncgbc>
 <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>
 <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com>
 <CA+dhYEVOyACM9ARP2deKVLm1hHOVsTah1WfGoNzGGKO6CGrQpw@mail.gmail.com>
 <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com>
 <CA+dhYEVwLGNZh-hbcJm+kMR4W45VbwvSVY+7YKt0V9jg_b_M4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+dhYEVwLGNZh-hbcJm+kMR4W45VbwvSVY+7YKt0V9jg_b_M4g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Feb 25, 2017 at 01:31:32AM +0100, ankostis wrote:
> That is why I believe that some HASH (e.g. SHA-3) must be the blessed one.
> All git >= 3.x.x must support at least this one (for naming and
> cross-referencing between objects).

I would stress caution here.  SHA3 has survived the NIST competition,
but that's about it.  It has *not* received nearly as much scrutiny as
SHA2.

SHA2 is a similar construction to SHA1 (Merkle–Damgård [1]) so it makes
sense to be leery of it, but I would argue it's seasoning merits serious
consideration.

Ideally, bless SHA2-384 (minimum) as the next hash.  Five or so years
down the road, if SHA3 is still in good standing, bless it as the next
hash.


thx,

Jason.

[1]
https://en.wikipedia.org/wiki/Merkle%E2%80%93Damg%C3%A5rd_construction
