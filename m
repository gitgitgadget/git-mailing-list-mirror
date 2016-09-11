Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42BD41FCA9
	for <e@80x24.org>; Sun, 11 Sep 2016 23:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755179AbcIKXfQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 19:35:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52698 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754788AbcIKXfP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 19:35:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13A543C0BB;
        Sun, 11 Sep 2016 19:35:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KQPRWGkmIZ2mOp3851ZUyyHhkWg=; b=wFvI7n
        TnG2xAmwRWQcpA5Bkm6EcBYoNjOHK75Frin+KBd39Wlrq7xJyD0de/hrcuIYX1JX
        EClr6XzGFm3Jn744OeYPLDnljLhHBfsgws/OQMSgCuNXUZTiSdq2TPkeGs8okOj/
        S6xGISColZgKQMskwY8D8a/+oj7xORsHw/DLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kKJj8Q+La6jB5CIJFACAC4oGQC3Q8oyi
        AQmQRjum6EaOxIYwh4CSMkX2I/H/dRHHJTvQaIB6xBsjTjTYPt5N8CAQsH4q0kI7
        W75PPISPcnosXS6+lIAe7YXD0Eb3JJdC4Jn2SWZzChsrbWNZTOoYpRPcmJWZn5zb
        vjZkzTNKr/s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C9703C0BA;
        Sun, 11 Sep 2016 19:35:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 844C93C0B9;
        Sun, 11 Sep 2016 19:35:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 22/25] sequencer: remove overzealous assumption in rebase -i mode
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <d0066b1a8dc6d8d6d45161203cd5c08ef8f2216f.1473590966.git.johannes.schindelin@gmx.de>
Date:   Sun, 11 Sep 2016 16:35:11 -0700
In-Reply-To: <d0066b1a8dc6d8d6d45161203cd5c08ef8f2216f.1473590966.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 12:55:51 +0200
        (CEST)")
Message-ID: <xmqq1t0q6mds.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 631BC204-7878-11E6-97F1-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> While at it, error out early if the "instruction sheet" (i.e. the todo
> script) could not be parsed.

Sounds good.
