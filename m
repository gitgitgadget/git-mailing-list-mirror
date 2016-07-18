Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49EAC2018F
	for <e@80x24.org>; Mon, 18 Jul 2016 20:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbcGRUDy (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 16:03:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47412 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbcGRUDw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 16:03:52 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A6332018B;
	Mon, 18 Jul 2016 20:03:52 +0000 (UTC)
Date:	Mon, 18 Jul 2016 20:03:51 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, Ren?? Scharfe <l.s.r@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: stricter unzip(1) check
Message-ID: <20160718200351.GA61232@plume>
References: <20160718064431.GA10819@starla>
 <20160718130405.GA19751@sigill.intra.peff.net>
 <xmqqshv6ivfk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshv6ivfk.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> +test_lazy_prereq UNZIP_AUTOTEXT '
> +	(
> +		mkdir unzip-autotext &&
> +		cd unzip-autotext
> +		"$GIT_UNZIP" -a "$TEST_DIRECTORY"/t5003/infozip-text.zip &&
> +		test -f text
> +	)

/usr/bin/unzip actually takes -a on FreeBSD, just not in the
same way the Info-ZIP version does, so I suspect "test -f"
here is not enough.

I would test this, but I can't apply it:

> diff --git a/t/t5003/infozip-text.zip b/t/t5003/infozip-text.zip
> new file mode 100644
> index 0000000..a019acb
> Binary files /dev/null and b/t/t5003/infozip-text.zip differ
