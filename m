Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AD2F2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 01:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755438AbdCUB7u (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 21:59:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42048 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755123AbdCUB7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 21:59:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5265420958;
        Tue, 21 Mar 2017 01:59:48 +0000 (UTC)
Date:   Tue, 21 Mar 2017 01:59:48 +0000
From:   Eric Wong <e@80x24.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <Jeff.Hostetler@microsoft.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: Safe to use stdatomic.h?
Message-ID: <20170321015948.GC6536@starla>
References: <000801d2a1b7$1ec41620$5c4c4260$@gmail.com>
 <20170320232240.k3egololfj7wt5cf@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170320232240.k3egololfj7wt5cf@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> I could support the argument for ditching RHEL/CentOS 5 support, but I
> expect other people might disagree.  After all, we're still targeting
> C89.

Yeah, I still use and support CentOS 5 in some places (but maybe
not git, still using ancient versions there, too).

Anyways, I'm still relying on the traditional __sync_* builtins
from in earlier gcc 4.x releases in some code GPL-3.0 code I
maintain for older systems:

	https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html

Since git is GPL-2.0, it is license-compatible with all the
atomic macros in the Linux kernel, as well as the kernel-derived
userspace atomics (uatomic) found in liburcu <http://liburcu.org/>
