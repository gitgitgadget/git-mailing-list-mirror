Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF481F404
	for <e@80x24.org>; Fri,  6 Apr 2018 21:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeDFVXy (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 17:23:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:56478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751750AbeDFVXx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 17:23:53 -0400
Received: (qmail 29110 invoked by uid 109); 6 Apr 2018 21:23:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 21:23:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29997 invoked by uid 111); 6 Apr 2018 21:24:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 17:24:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 17:23:51 -0400
Date:   Fri, 6 Apr 2018 17:23:51 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 09/15] config: avoid using the global variable `store`
Message-ID: <20180406212351.GB7870@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <cover.1522772789.git.johannes.schindelin@gmx.de>
 <a9689c880f9226c236aec58f8036740ff39efbb8.1522772789.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9689c880f9226c236aec58f8036740ff39efbb8.1522772789.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 06:28:34PM +0200, Johannes Schindelin wrote:

> It is much easier to reason about, when the config code to set/unset
> variables or to remove/rename sections does not rely on a global (or
> file-local) variable.

Agreed.

> -static struct {
> +struct config_set_store {

This made me think of the existing "configset", which is quite a
different thing. Maybe just "config_store_data" or something would clash
less.

-Peff
