Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0065D1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 23:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbcLEXTs (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 18:19:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57619 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752215AbcLEXTr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 18:19:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4E1D56554;
        Mon,  5 Dec 2016 18:19:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1rtmInFwH0VfsyjUPycyDsX19IM=; b=hbZugd
        /KBvqlSXI61yrjoxdUjCM29r4TYM7qMtNj/LaBZdh+QBl61yCMi4sWnA92jRD17k
        oX4oX6mNvns3kTR2GgQyhvBNU4hST8ZTkMNgUMeTofXCBF0oWcdcxVlol5UpsJvA
        eOCDzsvSgcFS2vmM5IGpjbmpWkCrDib23efQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fz+WUSQQD3IAbXEOmn3xdczRsRJ+VjWG
        xBMcaZYGMdw0+zECTkCqpj4XRQz+WRPH56bG1eHMXkTakXSmbHd1kTDbh7uGcjhQ
        RNJBdtuv1QfjEKh2nreFQqKIx6o8YyXLd8Q5pT20KFrlNIZQI7EM7k0lap1LhZYd
        DUvRrirLUHc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ACB9756553;
        Mon,  5 Dec 2016 18:19:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28A5B56551;
        Mon,  5 Dec 2016 18:19:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, sbeller@google.com,
        bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to is_transport_allowed
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
        <1480623959-126129-1-git-send-email-bmwill@google.com>
        <1480623959-126129-5-git-send-email-bmwill@google.com>
        <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
        <20161201230738.GJ54082@google.com>
        <xmqqh96n6x63.fsf@gitster.mtv.corp.google.com>
        <20161201235856.GL54082@google.com>
        <xmqqr35m3zx7.fsf@gitster.mtv.corp.google.com>
        <20161205222211.GF68588@google.com>
Date:   Mon, 05 Dec 2016 15:19:36 -0800
In-Reply-To: <20161205222211.GF68588@google.com> (Brandon Williams's message
        of "Mon, 5 Dec 2016 14:22:11 -0800")
Message-ID: <xmqqa8ca2cc7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A230B8E-BB41-11E6-9E67-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> I just took Jeff's series and applied it on top of mine (and fixed the
> small problem causing t5812 to fail) and then rebased it to v2.9.0.
> There were a few issues that needed to be resolved but nothing too
> hairy.  So it would definitely be doable to backport it to the
> maintenance tracks.

Thanks for trying.  I'd definitely prefer a series that is based on
an older codebase that is merged to pu->next->master->maint (in
other words, avoid "backport" and rather have "forward merge").

