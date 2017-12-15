Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09721F407
	for <e@80x24.org>; Fri, 15 Dec 2017 17:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755675AbdLORpx (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 12:45:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51488 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755506AbdLORpx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 12:45:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54F1AB89EE;
        Fri, 15 Dec 2017 12:45:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nTQVlR3e4Y/CTn13lMI9vb3/FpE=; b=GorHx1
        HT3Oazx4qg8t4cVkRaFcgO0jw8Ukmix+VStNabe4IPOK9b/3Avq/5gzrKyre30fl
        s2XL4sqWbEkA4VHid0E5Sk1DnwlNUiEw4Jqw3xJ2on3oxLmRzptTnc1n0j4hA6nF
        xGgtv1O4q6L+TLpkxoHIFaRzFZPDqubKsrJKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FoWtK1JJgUaNi+aqizgKbUeYtWu7wt2D
        pzV7Hdf7cACcjvRLY6QMXz1Mvfkpahgo2S67uF5PzHa+NcJ6hJycrAI1gzhDWUGJ
        pgJRpSgWksrVgHHWWgagBLG9L+JEXRQsEuHRX/F5eH1lPFLXM9HvJYedgBkrOHgH
        xcW+xfHA7bs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D976B89ED;
        Fri, 15 Dec 2017 12:45:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C32A4B89EA;
        Fri, 15 Dec 2017 12:45:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/2] Offer more information in `git version --build-options`'s output
References: <cover.1512752468.git.johannes.schindelin@gmx.de>
        <cover.1513294410.git.johannes.schindelin@gmx.de>
Date:   Fri, 15 Dec 2017 09:45:50 -0800
In-Reply-To: <cover.1513294410.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Fri, 15 Dec 2017 00:34:28 +0100 (STD)")
Message-ID: <xmqqind7rik1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAF4BF14-E1BF-11E7-B7A1-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> - when no commit can be determined, it now says
>
> 	no commit associated with this build
>   instead of
>
> 	built from commit: (unknown)

I find this output somewhat klunky for machine parsing (and it is
inconsistent with the style used for "sizeof-long", which hints that
these are "<token> <colon> <value>" lines where whitespaces are
avoided in a <token>), but hopefully this is primarily for human
consumption and scrypts that are trying to find a specific piece of
information would know how to use 'grep', so the inconsistency does
not make much of a difference in practice anyway.

Queued.  Thanks.
