Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8727A1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 14:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755328AbdCGOAP (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 09:00:15 -0500
Received: from squ.vm.bytemark.co.uk ([212.110.189.216]:53359 "EHLO
        squ.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755113AbdCGN77 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 08:59:59 -0500
X-Greylist: delayed 8372 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Mar 2017 08:59:58 EST
Received: by squ.vm.bytemark.co.uk (Postfix) with ESMTPSA id AD40888AC7;
        Tue,  7 Mar 2017 09:45:52 +0000 (GMT)
Date:   Tue, 7 Mar 2017 10:45:50 +0100
From:   Tom Jones <tom@oxix.org>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [Request for Documentation] Differentiate signed
 (commits/tags/pushes)
Message-ID: <20170307094549.GB23052@dufour.oxix.org>
References: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
 <20170307092353.ibirvitsxhzn3apz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170307092353.ibirvitsxhzn3apz@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use git to manage a config management repository for some
servers.  We have tens of signed commits a day; all get deployed.
The logic on each host is roughly "is signed by sysadmin key and
is more recent than currently-deployed version".

Also, what is all this about "GPG"?  The protocol is OpenPGP.  A 
particular implementation is GnuPG / gpg.  It is completely mad
that this implementation detail is in the interface specs for git,
such as --gpg-sign for git-commit(1).

It is an indictment of a lack of appreciation of the relationship
between interfaces and implementations, and the importance of
proper treatment thereof.

If Bob creates Bob's git compatible program, and he happens to use
Bob's OpenPGP implementation, his compatible option for git-commit(1)
still has to be called "--gpg-sign".  Madness.

  Tom.

