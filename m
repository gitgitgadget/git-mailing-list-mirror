Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B3F320986
	for <e@80x24.org>; Tue,  4 Oct 2016 18:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbcJDSwl (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 14:52:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54200 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752596AbcJDSwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 14:52:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAD5F423B4;
        Tue,  4 Oct 2016 14:52:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qzJf1XCltkwSjEuRm/zi65Y5RNQ=; b=dOIGgi
        zre+yb5I3FBoEy6qMwAlIj3CZOVIRFTO0cN6LW4eO57jTghX+I7bQ/W0k4oFmrSZ
        dK0UqQTQui0tEkwTldjUX8EDs0D6UHkkaBrQD3nLr25eO03D21WLx51DCsEgDnZQ
        8uDGbbwy+lPb/EGTri/iDc+N5+bWfTjz1teYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V3ZCtTHhJtHE+3z1Gx0lgUoRMFz7tmtJ
        gU6DbP44WF+srVlhUh+C3pHezUVkblH2Nl/5f7oENhVYRGH6qUsFBOkGZu5p51+m
        wS+GusjRLoLomOnnKWZc/BKJYptLdRYrpLRY4KWFnZecVvG3eayxNLKjIUP6Y1pK
        v6daUP/zyOo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A36EB423B3;
        Tue,  4 Oct 2016 14:52:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25774423B2;
        Tue,  4 Oct 2016 14:52:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/6] Make the require_clean_work_tree() function reusable
References: <cover.1473580914.git.johannes.schindelin@gmx.de>
        <cover.1475586229.git.johannes.schindelin@gmx.de>
        <3b4f46b761589d84b7713c869d00d3231ab346fd.1475586229.git.johannes.schindelin@gmx.de>
Date:   Tue, 04 Oct 2016 11:52:36 -0700
In-Reply-To: <3b4f46b761589d84b7713c869d00d3231ab346fd.1475586229.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 4 Oct 2016 15:05:25 +0200
        (CEST)")
Message-ID: <xmqqy424t097.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B868C660-8A63-11E6-9689-50B112518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It is remarkable that libgit.a did not sport this function yet... Let's
> move it into a more prominent (and into an actually reusable) spot:
> wt-status.[ch].
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Thanks.

I'd tweak the message while queuing, though.

    wt-status: make the require_clean_work_tree() function reusable
    
    The function "git pull" uses to stop the user when the working
    tree has changes is useful in other places.
    
    Let's move it into a more prominent (and into an actually reusable)
    spot: wt-status.[ch].
    
    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Readers won't care whether you found something remarkable and even
if they wanted to care, it is rather hard to sympathize with you
unless they know what "this function" does well enough to understand
why it is a good thing to make it available more widely.  That is a
more important point to address in the log message.

> diff --git a/wt-status.c b/wt-status.c
> index 9628c1d..b92c54d 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -16,6 +16,7 @@
>  #include "strbuf.h"
>  #include "utf8.h"
>  #include "worktree.h"
> +#include "lockfile.h"

Makes sense.  We'd be opportunistically refreshing the index.

