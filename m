Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF4401F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 08:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753598AbeGFIRt (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 04:17:49 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:50682 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753341AbeGFIRr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 04:17:47 -0400
X-Greylist: delayed 927 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jul 2018 04:17:47 EDT
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id w668232U002272
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Jul 2018 10:02:03 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w66823oB028726;
        Fri, 6 Jul 2018 10:02:03 +0200
Date:   Fri, 6 Jul 2018 10:02:02 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/8] gpg-interface: add new config to select how to sign
 a commit
Message-ID: <20180706100202.6e3efd45@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180706010148.GA7697@genre.crustytoothpaste.net>
References: <cover.1530616446.git.henning.schild@siemens.com>
 <9bb55c019c3bc025d77d9d491818e442233bf8d3.1530616446.git.henning.schild@siemens.com>
 <20180706010148.GA7697@genre.crustytoothpaste.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fri, 6 Jul 2018 01:01:48 +0000
schrieb "brian m. carlson" <sandals@crustytoothpaste.net>:

> On Tue, Jul 03, 2018 at 02:38:15PM +0200, Henning Schild wrote:
> > Add "gpg.format" where the user can specify which type of signature
> > to use for commits. At the moment only "PGP" is supported and the
> > value is not even used. This commit prepares for a new types of
> > signatures.  
> 
> We typically prefer to have option values specified in lower case.  I
> also think "openpgp" might be better than "PGP", since that's the name
> of the specification and it would avoid any potential unhappiness
> about compatibility with PGP or trademarks.

Thanks for your input. I was assuming the names to start a discussion
and i do not have a preference here.
Let us wait for further comments on naming, i will then implement
whatever the consensus is or what the maintainer requests.

In fact "gpg.format" could be dropped and we could try both "gpg" and
"gpgsm" and see where the signing-key is available. I decided to not
implement that because gpgsm (unlike) gpg does not return an error when
"--list-secret-keys" does not find anything. And we could have the odd
case where both would find a matching key. In which case we would need
"gpg.format" again to specify which one we prefer.

Henning
