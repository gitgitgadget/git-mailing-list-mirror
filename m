Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 696991FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 23:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933805AbcK3Xqt (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 18:46:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57463 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933268AbcK3Xqr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 18:46:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 606065432D;
        Wed, 30 Nov 2016 18:46:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=umrBv+ipDpUfK2/yHepS+YwMw5A=; b=dWpcB6
        cf2Qb7zcIyPM8u6CIgJ67xUotdDNkcGMPdfDXHI+b4YNQAAh3f8opavOL4u08GPL
        w9eygAIqhOI8FDRFo457Quuqpd8idZEsc8a/mHPhObmkztv9BUo++5nWtlutxUtI
        xP47yqQnvHUE1y/yME4JjSOsrnbaEvZthexvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vkWyNsZ5rlO+KCbJdLkO95/1BE0xO2OZ
        99l1YSWpwJ+AKwgyiTVt9RkNI1i1WzKpWL3pcOV/IM0IzhVRz36ymGe567NCDL8p
        yLKdFC9aM4VIdnPPZfHyFeYAv+ScBiJx1/nwZDuGdRc+oJYCYQ1UurqlyAgoKThI
        Cl9SUzpSeU8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57E075432C;
        Wed, 30 Nov 2016 18:46:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C77795432B;
        Wed, 30 Nov 2016 18:46:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] difftool.c: mark a file-local symbol with static
References: <4ddad7ea-5ac8-20b2-da9e-5843c486878a@ramsayjones.plus.com>
        <alpine.DEB.2.20.1611301204020.117539@virtualbox>
        <29abc89b-9ca5-930f-8e90-ca446ac2b96a@ramsayjones.plus.com>
        <xmqqtwaod7ly.fsf@gitster.mtv.corp.google.com>
        <20161130212510.ihcmvig7jq44p3nx@sigill.intra.peff.net>
        <3e6a6685-19ec-4536-4a5f-3a56e30fb530@ramsayjones.plus.com>
        <20161130231848.v5ge6otytim2t6d2@sigill.intra.peff.net>
Date:   Wed, 30 Nov 2016 15:46:39 -0800
In-Reply-To: <20161130231848.v5ge6otytim2t6d2@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 30 Nov 2016 18:18:48 -0500")
Message-ID: <xmqqinr4bkf4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3DCDCC7C-B757-11E6-A42B-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I forgot, we ended up reversing course later and silencing them:
>
>   http://public-inbox.org/git/20140505052117.GC6569@sigill.intra.peff.net/
>
> By the rationale of that conversation, we should be doing:
>
>   warning("%s", "");
>
> here.

I forgot too.  Thanks for digging up that thread.

