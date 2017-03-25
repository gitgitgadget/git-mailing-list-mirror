Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2638820966
	for <e@80x24.org>; Sat, 25 Mar 2017 21:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbdCYVM2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 17:12:28 -0400
Received: from imap.thunk.org ([74.207.234.97]:50704 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750994AbdCYVM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 17:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=TCNWXMIVL5KMDAq21NfZ5q7T8FTThGHTNpnxJU0Cilo=;
        b=KqRV9PdjmfZvR1QX/3GEmRtcDskD/KoEmC9/p3RQoYUt7JJ3bRxI2eJo5ZK/PatEtYUYcTvpgFcakTUjaYxDd0xmkReab6HozsumcKFewduxgSNtQjpg9ZEJvovC9Pp8mB7g6oWX79CN65n1wHIIh3hW/5TAnXPBf5eiUbx76YU=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.84_2)
        (envelope-from <tytso@thunk.org>)
        id 1crsyG-0002Ib-V5; Sat, 25 Mar 2017 21:11:37 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 04CDEC01383; Sat, 25 Mar 2017 17:11:35 -0400 (EDT)
Date:   Sat, 25 Mar 2017 17:11:35 -0400
From:   Theodore Ts'o <tytso@mit.edu>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: Will OpenSSL's license change impact us?
Message-ID: <20170325211135.62sa76hlvyiexvje@thunk.org>
References: <CACBZZX6F47uC9jLxppgkUnwVpGV2jpzzP4kwTuqKgayCevomeA@mail.gmail.com>
 <CANgJU+UCJ9qR-pi9w3+oYjEwDdhbtNX9Nv6brj31VXvt-k-3Lw@mail.gmail.com>
 <CACBZZX7dXsdu0bwt4Rznregw4=v=Sc3cFTQbxJcb-ynf3HXq3Q@mail.gmail.com>
 <CANgJU+UG1JGYomyQa1FgyN8Q6SkPeEtGKEJfNETrkbtGwrMn9g@mail.gmail.com>
 <CACBZZX4Haah8JmSG6BbfpdOA1aAxtjiuYirLH4=jt01kHL4eQA@mail.gmail.com>
 <CANgJU+WR4L-7-r97od7ids6VK9QyO-QzAntbg7SazmPGj0yWXA@mail.gmail.com>
 <CACBZZX5bK=emjaQ80J7QuTHXHm=nT3G80zq4xogMqC7Eq9Bs+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5bK=emjaQ80J7QuTHXHm=nT3G80zq4xogMqC7Eq9Bs+g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 06:51:21PM +0100, Ævar Arnfjörð Bjarmason wrote:
> In GPLv3 projects only, not GPLv2 projects. The paragraphs you're
> quoting all explicitly mention v3 only, so statements like
> "incompatible in one direction" only apply to Apache 2 && GPLv3, but
> don't at all apply to GPLv2, which is what we're using.

It's complicated.

It's fair enough to say that the FSF adopts a copyright maximalist
position, and by their interpretation, the two licenses are
incompatible, and it doesn't matter whether the two pieces of code are
linked staticaly, dynamically, or one calls the other over an RPC
call.

Not everyone agrees with their legal analysis.  May I suggest that we
not play amateur lawyer on the mailing list, and try to settle this
here?  Each distribution can make its own decision, which may be based
on its legal advice, the local laws and legal precedents in which they
operate, etc.  And indeed, different distributions have already come
to different conclusions with respect to various license compatibility
issues.  (Examples: dynamically linking GPL programs with OpenSSL
libraries under the old license, distributing ZFS modules for Linux,
etc.)

We don't expect lawyers to debug edge cases in a compiler's code
generation.  Programmers shouldn't try to parse edge cases in the law,
or try to use a soldering iron, unless they have explicit training and
expertise to do so.  :-)

				- Ted

