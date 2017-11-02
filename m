Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00FAD20450
	for <e@80x24.org>; Thu,  2 Nov 2017 08:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755632AbdKBIBU (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 04:01:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:43714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755623AbdKBIBO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 04:01:14 -0400
Received: (qmail 18167 invoked by uid 109); 2 Nov 2017 08:01:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Nov 2017 08:01:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19084 invoked by uid 111); 2 Nov 2017 08:01:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Nov 2017 04:01:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Nov 2017 04:01:12 -0400
Date:   Thu, 2 Nov 2017 04:01:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: On the nature of cover letters [WAS Re: [PATCH 0/6] Create
 Git/Packet.pm]
Message-ID: <20171102080111.edh5wqyklkoqkvlg@sigill.intra.peff.net>
References: <CAGZ79kbHwXpWXhUkokA9=XGN9D1YZevO_8MhbOztMXpkkHMFbg@mail.gmail.com>
 <20171101071422.c2k4plhntlgpdnbk@sigill.intra.peff.net>
 <CAGZ79kYKK69Xw0-2OxFpo9Q=Kv1hvw8D7YkfhMFFcgzTuevTCQ@mail.gmail.com>
 <CAGZ79kYghF6=AzL1N96fe2zixHCERXu=RpxHw2-kdUrU+j4CXw@mail.gmail.com>
 <20171102072237.wbmrzrgfyxdb3m3v@sigill.intra.peff.net>
 <xmqqh8udqfxe.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8udqfxe.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 02, 2017 at 04:48:45PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If the clutter is too much, it could also go into a git-notes ref
> > (that's not already implemented, but it seems like it would be pretty
> > easy to teach "git am" to do that).
> 
> FWIW, that is what I use a notes ref "amlog" for.

Right, I completely forgot that you were already doing that. So jumping
to the thread for a commit is basically:

  $browser $(git notes --ref=amlog show $commit |
             perl -pe 's{Message-Id: <(.*)>}{https://public-inbox.org/git/$1/t}')

(Or whichever archive you prefer to use). Thanks for the reminder.

-Peff
