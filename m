Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C79207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 03:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164405AbdDXDTx (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 23:19:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57702 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1164399AbdDXDTw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 23:19:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33DEC81275;
        Sun, 23 Apr 2017 23:19:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S7xfu0szeUQ2HBmGZl3UbEhSk5g=; b=PLSe5t
        FBliJEvJbAJCQE8dnfHt1eHOrog59CxkkrLRw8h/4khfsV1EdjqEMXBBt7GiTlGt
        6jEc2pnvJq5w9eGVXlvMdZTkEDdtF/Py3zf7IuPo2MhJYCpoX2Jl84ddn67bHhNk
        Juj0JK5+Ky4KkpXcHVkyZBcZrxRE9LUHqLmpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=waxMx3f8E1brLdQGgjVz7yeGlljAlLn0
        mkDvmWLOUF0a6Lo5WH1fFUc0ZM++VPHT3XVix/w05pFXrsvy1WMH1jQxihXNbzAA
        jiaEBu7uohflv/h1El8eClE+63XPZLzn7zSjOuuqnuiETRsl9Ir685xlj+HUaMbd
        rdhMgdnPPlg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A1FF81274;
        Sun, 23 Apr 2017 23:19:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 82DCE81272;
        Sun, 23 Apr 2017 23:19:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 4/9] Specify explicitly where we parse timestamps
References: <cover.1492721487.git.johannes.schindelin@gmx.de>
        <cover.1492771484.git.johannes.schindelin@gmx.de>
        <403936fa1df1b1c6d8daade2bfe853579b97bad3.1492771484.git.johannes.schindelin@gmx.de>
Date:   Sun, 23 Apr 2017 20:19:49 -0700
In-Reply-To: <403936fa1df1b1c6d8daade2bfe853579b97bad3.1492771484.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 21 Apr 2017 12:45:44 +0200
        (CEST)")
Message-ID: <xmqqmvb61oh6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E08DE24C-289C-11E7-B64D-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Currently, Git's source code represents all timestamps as `unsigned
> long`. In preparation for using a more appropriate data type, let's
> introduce a symbol `parse_timestamp` (currently being defined to
> `strtoul`) where appropriate, so that we can later easily switch to,
> say, use `strtoull()` instead.

Apparently a very good first step in this series.
