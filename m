Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37DF9207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 06:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbcI0GIr (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 02:08:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61903 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752186AbcI0GIg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 02:08:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF95641F19;
        Tue, 27 Sep 2016 02:08:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hqYU4d/zfAm3ssBdE3b2OHpV7Fw=; b=Qp7752
        v7myquBhB5IxV/qTNjqoEupu5txTN2wgXG+xrAi7pRDeTzW5F2NzYhpcUSH3HrTG
        wBuZO2fLC14OGM9rDFBtgQRIGkR/P2ro6kwTflcI2rFReAvLSViaJivpZ+PWAsuW
        8Odica3Ys/4YAITEzK8xdbmFGplcbrsMo8RaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fpO8tpWDup5Nt/klZbwx+hOqKZqmf9Rs
        kwgdVotEbwCMUkBom5+2Vwm9GmoqRTLRHitILlyOgVWL3IrU+6BpUjo2vsX/tkRz
        NF+XKiUo5ngppcNqLGadgpuC+y7P2d5w5wPFsbtV+O6IVhiJ1BTJDSMUk8PxY/xS
        KMbx3KvpsYU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D715841F18;
        Tue, 27 Sep 2016 02:08:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 605FF41F17;
        Tue, 27 Sep 2016 02:08:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] utf8: accept "latin-1" as ISO-8859-1
References: <20160927012211.9378-1-gitster@pobox.com>
        <20160927012211.9378-3-gitster@pobox.com>
        <20160927055744.el2jbxzdqfhjl6qt@sigill.intra.peff.net>
Date:   Mon, 26 Sep 2016 23:08:32 -0700
In-Reply-To: <20160927055744.el2jbxzdqfhjl6qt@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 27 Sep 2016 01:57:45 -0400")
Message-ID: <xmqq7f9xswm7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2822CEE-8478-11E6-9727-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I have to admit that I don't care too deeply about performance for
> somebody who wants to convert "latin1" to "ISO-8859-1". If one of your
> encodings is not UTF-8, you are probably Doing It Wrong. :)

Exactly.  Note that the "you" in the above are usually plural,
collectively referring to both the sender and the receiver.  I
usually am on the poor receiving end ;-)
