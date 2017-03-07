Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E498C202D7
	for <e@80x24.org>; Tue,  7 Mar 2017 11:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbdCGLVZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 06:21:25 -0500
Received: from quickstop.soohrt.org ([85.131.246.152]:58633 "EHLO
        quickstop.soohrt.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752681AbdCGLVW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 06:21:22 -0500
X-Greylist: delayed 1038 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Mar 2017 06:21:22 EST
Received: (qmail 29436 invoked by uid 1014); 7 Mar 2017 11:14:06 -0000
Date:   Tue, 7 Mar 2017 12:14:06 +0100
From:   Horst Schirmeier <horst@schirmeier.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: Re: regression: git push in non-shared repo stalls (v2.11.0+)
Message-ID: <20170307111406.GB1955@quickstop.soohrt.org>
References: <20170307110328.GE7566@quickstop.soohrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170307110328.GE7566@quickstop.soohrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 07 Mar 2017, Horst Schirmeier wrote:
> I observe a regression that seems to have been introduced between
> v2.10.0 and v2.11.0.  When I try to push into a repository on the local
> filesystem that belongs to another user and has not explicitly been
> prepared for shared use, v2.11.0 shows some of the usual diagnostic
> output and then freezes instead of announcing why it failed to push.

Bisecting points to v2.10.1-373-g722ff7f:

722ff7f876c8a2ad99c42434f58af098e61b96e8 is the first bad commit
commit 722ff7f876c8a2ad99c42434f58af098e61b96e8
Author: Jeff King <peff@peff.net>
Date:   Mon Oct 3 16:49:14 2016 -0400

    receive-pack: quarantine objects until pre-receive accepts

-- 
PGP-Key 0xD40E0E7A
