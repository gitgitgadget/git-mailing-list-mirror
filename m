Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EEB02023D
	for <e@80x24.org>; Thu,  2 Mar 2017 02:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754006AbdCBCgR (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 21:36:17 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50864 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753860AbdCBCgR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 21:36:17 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5B4842023D;
        Thu,  2 Mar 2017 02:11:35 +0000 (UTC)
Date:   Thu, 2 Mar 2017 02:11:35 +0000
From:   Eric Wong <e@80x24.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH 03/18] lib-submodule-update: teach test_submodule_content
 the -C <dir> flag
Message-ID: <20170302021135.GA26453@starla>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
 <20170302004759.27852-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170302004759.27852-4-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> wrote:
>  test_submodule_content () {
> +	if test "$1" == "-C"

Use a single '=' for portability in sh.  It's also a good idea
to prefix variables with 'x' or some such, since "$1" could be
"-n" or some other supported switch for test(1).
So, something like:

	if test x"$1" = "x-C"

...or use a case statement.

On Debian systems, I use the "checkbashisms" from the
"devscripts" package to find and avoid bash dependencies.

Thanks.
