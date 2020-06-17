Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40A3C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 21:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA2B2166E
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 21:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFQVXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:23:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:35006 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgFQVXe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 17:23:34 -0400
Received: (qmail 11826 invoked by uid 109); 17 Jun 2020 21:23:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Jun 2020 21:23:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4696 invoked by uid 111); 17 Jun 2020 21:23:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Jun 2020 17:23:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Jun 2020 17:23:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 01/12] fast-export: do anonymize the primary branch
 name
Message-ID: <20200617212333.GB2809@coredump.intra.peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
 <ebd10f73cd73a8fca84d1862e5a4b7b62a549bcd.1592225416.git.gitgitgadget@gmail.com>
 <20200616125833.GE666057@coredump.intra.peff.net>
 <xmqqmu51v9qy.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmu51v9qy.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 17, 2020 at 11:16:05AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Of course that only helps you for _one_ branch. A more generally useful
> > mechanism would be to teach fast-export to write the ref mapping (and
> > perhaps file mappings, etc) to a separate file. Then you could convert
> > any reproduction recipe to use the anonymized names, and share only that
> > recipe along with the anonymized dump. But that's _way_ outside the
> > scope of your series. This seems like a good interim step to retain the
> > status quo.
> 
> Actually, dropping this special case, and dropping the other special
> case with fmt-merge-msg, we can do without the notion of the
> "primary" branch.

That leaves us in the interim with a "fast-export --anonymize" that is a
little harder to use (you have no way to know which branch was which).

But I don't mind at all implementing the map-dumping feature to help
move this along. As long as both make it into the same release, then
fast-export only gets better, and never regresses. :)

-Peff
