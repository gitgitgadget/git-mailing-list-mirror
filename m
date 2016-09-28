Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77DF1F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 21:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754708AbcI1VZP (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 17:25:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58242 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934054AbcI1VX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 17:23:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F99340991;
        Wed, 28 Sep 2016 17:23:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RFCPBMPuXYRCGuaz3h09zYPs9lg=; b=OvpDHE
        16vhRBwZIMgHEiJeRHYspyITIG4o++lgSauSPiB822jHVFeXNB3zsf3xPb5bQtBM
        HfqVHap3SlmgkvYzwpSaTEBN6UMk3/SGbt10ZkftUu9/Z8DR9PHdvBppCiZDVE4i
        /h1xNPj21XtVgM9QMwlrJHyBDsd+qygqfMRSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NKjUA7Al4AkFFJrj7qmEliMhEC3AEkHg
        PJF7Jwdyr8I2qc/lXHigOLQ/0c0rCIIeLMTxaTOWknkcsFlXOKEUuyj2+4yZfLDD
        w+vGRntWZCAaIIf8QFtvDlp3JjT9gHp/DTvxgIT3Vm1OCboGHQnGP/JIv7Rb0zGj
        uleNdyKaKSs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67E3440990;
        Wed, 28 Sep 2016 17:23:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD5AB4098F;
        Wed, 28 Sep 2016 17:23:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Petr Stodulka <pstodulk@redhat.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] http: Control GSSAPI credential delegation.
References: <1475078752-31195-1-git-send-email-pstodulk@redhat.com>
        <20160928171610.pbghg4sk23vm4xnp@sigill.intra.peff.net>
        <9c9e9949-cfe0-5465-6ae1-3e8254ff055b@redhat.com>
Date:   Wed, 28 Sep 2016 14:23:25 -0700
In-Reply-To: <9c9e9949-cfe0-5465-6ae1-3e8254ff055b@redhat.com> (Petr
        Stodulka's message of "Wed, 28 Sep 2016 20:19:47 +0200")
Message-ID: <xmqqd1jniur6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC0188FC-85C1-11E6-8016-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Petr Stodulka <pstodulk@redhat.com> writes:

> However, I discuss it with libcurl maintainer and he confirm that this
> option can be required in some cases and this is what I need to do.
> this already. I tested just setting of parameter in libcurl according
> to description and nothing else seems broken. So anyone else who will
> be able to test complete behaviour, where delegation is needed, is welcomed.

Thanks; let's queue this in 'pu' to make it easier for people who
would be affected to try it out.
