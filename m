Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B30A920248
	for <e@80x24.org>; Sun,  7 Apr 2019 21:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfDGVwL (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 17:52:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48398 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfDGVwK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 17:52:10 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e]:60188)
        by eggs.gnu.org with esmtp (Exim 4.71)
        (envelope-from <dak@gnu.org>)
        id 1hDFhv-00057u-C4; Sun, 07 Apr 2019 17:52:07 -0400
Received: from x5d858390.dyn.telefonica.de ([93.133.131.144]:59266 helo=lola)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <dak@gnu.org>)
        id 1hDFhu-0001ae-Vu; Sun, 07 Apr 2019 17:52:07 -0400
From:   David Kastrup <dak@gnu.org>
To:     michael@platin.gs
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>
Subject: Re: [PATCH v5 6/6] RFC blame: use a fingerprint heuristic to match ignored lines
References: <20190407214635.12984-1-michael@platin.gs>
Date:   Sun, 07 Apr 2019 23:52:04 +0200
In-Reply-To: <20190407214635.12984-1-michael@platin.gs> (michael@platin.gs's
        message of "Sun, 7 Apr 2019 23:46:35 +0200")
Message-ID: <8736mtqy9n.fsf@fencepost.gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

michael@platin.gs writes:

> From: Michael Platings <michael@platin.gs>
>
> Hi Barret,
> This is the updated fuzzy matching algorithm, sorry for the delay. It does
> highlight a bug in the calculation for the number of lines ("int nr_parent_lines
>  = e->num_lines - delta;") - if you apply the patch, build it, then try to
> ./git blame --ignore-rev <the patch commit ID> blame.c then you'll get a segfault
> because nr_parent_lines is a negative number. I haven't had time to investigate further
> but I have confirmed that the bug is not due to my patch.

If you segfault with the patch and don't segfault with the patch, there
is not much of a point in declaring this "somebody else's problem", is
there?  It has to be fixed anyway in order to make the patch get in.

Or am I fundamentally misunderstanding something here?

-- 
David Kastrup
