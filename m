Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F86A207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 19:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbcILTrD (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:47:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57780 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751260AbcILTrC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:47:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BADB3C743;
        Mon, 12 Sep 2016 15:47:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QWCaTylbG2Vr6fEQbwSAm/2AR/I=; b=gjcL4b
        vHGwlwneOQ7w4LbR0L0ZptdpEE8vqsjRDd98HZt+ZXUbp6tWDNQ+hi56gYULUyhX
        jBmL28pS37Wo7S3VTlbP9mn7LI1rMoD3JsI8omypf8helGpSutSIDnbu++5VSfW4
        nWkBv5sFVFZdxx53XN06djxeTRRLzapbN0ads=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A6waRxR8SRfEJJMDK1XXHJmBvxADFmXG
        MIsj4Myz1B9Pn8iavv1+F7T2tm2P+kkupARpG0LQbeKb1sWgFtRHtDSuSSJkTfro
        1YXl9O4gOWjkzLGYJiHqWUsSBlSQTt7CCEIa0+UViHoX6yR5FoYoyVhShZf3w/FU
        KktYOplwvcY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDFA73C742;
        Mon, 12 Sep 2016 15:47:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 235B33C741;
        Mon, 12 Sep 2016 15:47:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 01/25] sequencer: use static initializers for replay_opts
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <666493d3f166d839deb817042ed7d1636b11f19e.1473590966.git.johannes.schindelin@gmx.de>
Date:   Mon, 12 Sep 2016 12:46:58 -0700
In-Reply-To: <666493d3f166d839deb817042ed7d1636b11f19e.1473590966.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 12:52:30 +0200
        (CEST)")
Message-ID: <xmqqvay02959.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB9EDF94-7921-11E6-8E4C-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This change is not completely faithful: instead of initializing all fields
> to 0, we choose to initialize command and subcommand to -1 (instead of
> defaulting to REPLAY_REVERT and REPLAY_NONE, respectively). Practically,
> it makes no difference at all, but future-proofs the code to require
> explicit assignments for both fields.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

OK.
