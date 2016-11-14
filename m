Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A351F858
	for <e@80x24.org>; Mon, 14 Nov 2016 19:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935195AbcKNTrO (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 14:47:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53003 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934507AbcKNTrN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 14:47:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A8134F54A;
        Mon, 14 Nov 2016 14:47:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+M9iUR2o0RHeTKTZwuSxnk0XiIo=; b=TNC5Vu
        uUKM91Rk7vtitD01g4omuXksjbiBpTZbD52iE5D1hN2VwMBF+jBWt5wZ3NbNMzDS
        ArsqTk4zsdFfGBrFqXXZwgWyebY89gGE2kepqIl0HDAJ/po7RSb8fthFge8WJmev
        72ENUSk82w3ytW3eVTOOxUk/HBFqgv/rEZUPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IBHiE/6j+Jm7jkEMq5+lUTi4u7EAP1PE
        sDQLM24DRG/nIDmC86dAOzGh9qcPmG9Rjtnty4o6eHKLnLKnWRIVwZmnVVeqE4pk
        DQVdeFb2v8xzYV0dTjMUlJD+6Uba/mbpSRRZxrw4FEgt9Nv39C5eqzB88Erh1fcE
        MaHNXAkVfzY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82ED04F549;
        Mon, 14 Nov 2016 14:47:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E94FE4F548;
        Mon, 14 Nov 2016 14:47:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: [PATCH] fetch/push: document that private data can be leaked
References: <xmqqy416uvan.fsf@gitster.mtv.corp.google.com>
        <1479001205.3471.1.camel@mattmccutchen.net>
        <xmqq1syezs3g.fsf@gitster.mtv.corp.google.com>
        <1479148088.2406.27.camel@mattmccutchen.net>
        <xmqqbmxhyjij.fsf@gitster.mtv.corp.google.com>
        <20161114190725.fxjymvztc2eiomv6@sigill.intra.peff.net>
Date:   Mon, 14 Nov 2016 11:47:10 -0800
In-Reply-To: <20161114190725.fxjymvztc2eiomv6@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 14 Nov 2016 14:07:26 -0500")
Message-ID: <xmqq37ityhc1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22AFC816-AAA3-11E6-95A8-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I think the in-between answer is "it is OK to push to an
> untrustworthy place, but do not do it from a repo that may contain
> secret contents".

Yes, that sounds like a sensible piece of advice to give to the
readers.

