Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C726A20437
	for <e@80x24.org>; Mon, 16 Oct 2017 13:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbdJPN4d (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 09:56:33 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.93]:31598 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbdJPN4c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 09:56:32 -0400
Received: from [193.96.224.22] (helo=book.hvoigt.net)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e45sa-00062n-0G; Mon, 16 Oct 2017 15:56:28 +0200
Date:   Mon, 16 Oct 2017 15:56:23 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     sbeller@google.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
        bmwill@google.com, git@vger.kernel.org
Subject: [PATCH v4 0/3] implement fetching of moved submodules
Message-ID: <20171016135623.GA12756@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous RFC iteration can be found here:

https://public-inbox.org/git/20171006222544.GA26642@sandbox/

This should now be in a state ready for review for inclusion.

The main difference from last iteration is that we now also support
unconfigured gitlinks for push and fetch for backwards compatibility.

To implement this compatibility we construct a default name for gitlinks
if there is a repository found at their location in the worktree.

Cheers Heiko

Heiko Voigt (3):
  fetch: add test to make sure we stay backwards compatible
  implement fetching of moved submodules
  submodule: simplify decision tree whether to or not to fetch

 submodule-config.h          |   3 +
 submodule.c                 | 200 +++++++++++++++++++++++++++++---------------
 t/t5526-fetch-submodules.sh |  77 ++++++++++++++++-
 3 files changed, 210 insertions(+), 70 deletions(-)

-- 
2.14.1.145.gb3622a4

