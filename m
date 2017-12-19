Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E901F406
	for <e@80x24.org>; Tue, 19 Dec 2017 17:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbdLSRIr (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 12:08:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57648 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751107AbdLSRIq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 12:08:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06776D1992;
        Tue, 19 Dec 2017 12:08:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YyA52pYQYhf1+el2OhzuKpY0cco=; b=tOStic
        ATWq235FTjvcYe16M3Ma+BdCf78KghV1VDNg0pUMCNZXVMWbTUyvqFaG+1a9i1ec
        tSUlWzCGMKY9Bz89Z7tNAc/6Mw20BO6KI1xnwtKU5w77vaGye1WUtVZSK0wHt6mm
        lnspOdAWfywGdaIqAlt57XviRucZLYCHkJuD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kkpxYQFMoWifpowc6EUqr+YOkLKh/MPV
        V5DmN9M9PxhQrBeByXJ72BNziZ1TOJI4HdnNIKotgz27ZyXFszKLN/by/5PrRM0b
        pfgEEN25Mn0TLAYtNvhcxz3MznoYNBNeEKc6fV9wZJMCCX0JnRYB83IrtTNJE87b
        mCLu1Py1MhQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1D76D1991;
        Tue, 19 Dec 2017 12:08:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 706A9D1990;
        Tue, 19 Dec 2017 12:08:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jakub Zaverka <jakub.zaverka@deutsche-boerse.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: difftool uses hardcoded perl shebang
References: <f5d4c8e7bceb410a95a34a8cce4c31dd@deutsche-boerse.com>
        <20171219162528.GA5804@sigill.intra.peff.net>
        <xmqqlghywuct.fsf@gitster.mtv.corp.google.com>
        <20171219164532.GA6745@sigill.intra.peff.net>
Date:   Tue, 19 Dec 2017 09:08:44 -0800
In-Reply-To: <20171219164532.GA6745@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 19 Dec 2017 11:45:32 -0500")
Message-ID: <xmqqh8smwspv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 459B9BBC-E4DF-11E7-AAB9-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In the meantime, pointing to the actual build-time perl is a workaround
> (but obviously not if it's being done by a third-party packager who has
> no idea where your perl is).

Is such a binary packaging scheme actually in use that deliberately
leaves it up to the end user where/if a perl is installed and if it
is an appropriately recent version?  It sounds rather irresponsible
to me.
