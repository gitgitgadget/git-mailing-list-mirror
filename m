Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B153D203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 22:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbcLLW01 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 17:26:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65219 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751518AbcLLW01 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 17:26:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11C9B570BB;
        Mon, 12 Dec 2016 17:26:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L8B4cEGB4huxdUG1wl8MoQbVJmY=; b=sy06WE
        FpqbQQViu+iJ1alzI1jdnB5D3sQ+u8nuiP5dT/NDn6owa8z91eOwaUGZCaPIwN6a
        emGj8kO0AOZeykaxJrAIgQ4uhhQedSWR2rcHmQ/NQ1rez9oMV4gcQjLd7VWXKREP
        5DScVRpQg2dRH4zAJwDN4eRt7/quffMabbjEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rs25h0UrR8IqxhkIQEf4LknpL0nP2p5d
        22yAZcc33mGkQaJaqoCznWkygHGO8GxT1ke2WKVbfGwimmcuerKSTniiLSpED0Qe
        7zYdRoH+xpuL7gTmtRUhoKe/NMhJKWa4ccIpJlLPnVvay/bkOmpat36UgKNS940L
        2b5wMmKrdr0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06F97570BA;
        Mon, 12 Dec 2016 17:26:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75253570B9;
        Mon, 12 Dec 2016 17:26:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, ramsay@ramsayjones.plus.com, tboegi@web.de,
        j6t@kdbg.org, pclouds@gmail.com
Subject: Re: [PATCH v3 4/4] real_path: have callers use real_pathdup and strbuf_realpath
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
        <1481566615-75299-1-git-send-email-bmwill@google.com>
        <1481566615-75299-5-git-send-email-bmwill@google.com>
Date:   Mon, 12 Dec 2016 14:26:24 -0800
In-Reply-To: <1481566615-75299-5-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 12 Dec 2016 10:16:55 -0800")
Message-ID: <xmqqzik07pin.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04A2C8E6-C0BA-11E6-9D4A-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Migrate callers of real_path() who duplicate the retern value to use
> real_pathdup or strbuf_realpath.

Looks good.
