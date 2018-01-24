Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04FA1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 22:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932846AbeAXWZT (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 17:25:19 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:41802 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932072AbeAXWZT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 17:25:19 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id DDF9E1F404;
        Wed, 24 Jan 2018 22:25:18 +0000 (UTC)
Date:   Wed, 24 Jan 2018 22:25:18 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: Git packs friendly to block-level deduplication
Message-ID: <20180124222518.GA24157@whir>
References: <87bmhiykvw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bmhiykvw.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> If you have a bunch of git repositories cloned of the same project on
> the same filesystem, it would be nice of the packs that are produced
> would be friendly to block-level deduplication.

Fwiw, I currently get around this when mirroring by having all
the remotes I care about mirrored to a "hidden" root repo, and
having other repos point to the hidden root objects via
object/info/alternates.  Not that great for usability and
probably potentially racy...

> Has anyone here barked up this tree before? Suggestions? Tips on where
> to start hacking the repack code to accomplish this would be most
> welcome.

The Debian version of gzip(1) has an --rsyncable patch which
might be of help.
