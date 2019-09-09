Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF66A1F4B7
	for <e@80x24.org>; Mon,  9 Sep 2019 18:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405371AbfIISLp (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 14:11:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50950 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730049AbfIISLp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 14:11:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 924F392A87;
        Mon,  9 Sep 2019 14:11:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t1czNfVmsZrziU7cujUiGG6+b/I=; b=eZbCr/
        +JejePGlpTTZjAlNpVbXxsxvhRUKZRezSu+U5SoFYMfB1ZewFsrph8jtJbMCeGdH
        Uneb1ykowAFgdjO8hpf7ZjvrmckOzobbmpAmKRGmnMSxFN/bR1pefe0q9a0KBnq9
        5z2OVaFRVmgv9rgqtTDwvSPPIgwlRSlnblmFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t6mtj0n26xAz/M2PKY0chaHzF2niymgb
        Oz4EjQT9u24gKb7lTlVrI70SEVWoCo9+Dis6Yc03cSz3xkg+zA9QDQitGCNYynpJ
        Nv4nm7Q72zFLBKhdQZGCzKvH1/3rFvjcar/dPXKzJb592BKjQlsDJwTQqx3ayIfS
        +5x8dR1lCho=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BCE092A86;
        Mon,  9 Sep 2019 14:11:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BEE2392A85;
        Mon,  9 Sep 2019 14:11:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk, Warren He <pickydaemon@gmail.com>,
        git@vger.kernel.org, wh109@yahoo.com
Subject: Re: [PATCH v2] rebase: introduce --update-branches option
References: <nycvar.QRO.7.76.6.1909031345330.46@tvgsbejvaqbjf.bet>
        <20190907234413.1591-1-wh109@yahoo.com>
        <31a37eb1-8a75-40f7-7d1c-a8b7b9d75f92@gmail.com>
        <nycvar.QRO.7.76.6.1909091605540.5377@tvgsbejvaqbjf.bet>
Date:   Mon, 09 Sep 2019 11:11:38 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1909091605540.5377@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Mon, 9 Sep 2019 16:13:16 +0200
        (CEST)")
Message-ID: <xmqqwoehjq5h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45B50D2A-D32D-11E9-B223-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In contrast, I would think that
>
> 	label --update-branch my-side-track
>
> would make for a nicer read than
>
> 	label my-side-track
> 	branch my-side-track

Because labelling while recreating a mergey history is conceptually
the same as temporarily updating the branch head from end users'
point of view, so this sounds quite sensible.
