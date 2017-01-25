Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594BE1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 18:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbdAYS3K (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 13:29:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62840 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752236AbdAYS3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 13:29:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7519D62865;
        Wed, 25 Jan 2017 13:29:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E+9AJPCBIM7IUwTZnUs84FaJIgI=; b=c3YISJ
        3Jm1PHOfm5WcoKdRG5o4MnQk30S26Wb8lva9nSf3pZwuDtl4YG6v2P3MT7tlGYRV
        CR1sWHRzzoA8CrnSX73MlRouI61vAemVNhTPdkFZi3chr44/sPpY2wG/IxI1blpk
        dEQeksCQXPlUKx68D7ZxpXegfxD4XP/23m/dM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TTE1GGU2sSSEGfcis+aSbYemdNlBIgV5
        zg+0tgHzMrS5dzfC0KxF/wT9ymgSa+/PFu1ZkWk9y45s5zTovTXPm5tZKGm85BI3
        7NGSIIfWWJoe+jiJFRTsYX8XxboTzo7SxL3HBntPkmtL+O4w20FfjgO3MBbIdNL8
        clRs8L0m7QM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B16C62864;
        Wed, 25 Jan 2017 13:29:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C273B62863;
        Wed, 25 Jan 2017 13:29:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/12] for_each_alternate_ref: use strbuf for path allocation
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
        <20170124004038.njjevfku4v7kmnh4@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 10:29:05 -0800
In-Reply-To: <20170124004038.njjevfku4v7kmnh4@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 23 Jan 2017 19:40:38 -0500")
Message-ID: <xmqqvat3at8u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27DB3778-E32C-11E6-8645-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We have a string with ".../objects" pointing to the
> alternate object store, and overwrite bits of it to look at
> other paths in the (potential) git repository holding it.
> This works because the only path we care about is "refs",
> which is shorter than "objects".

Yup, this was probably copied from a lazy original I wrote ;-)
Thanks for cleaning up.
