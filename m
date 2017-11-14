Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0054A201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 01:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdKNBPX (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 20:15:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55696 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751161AbdKNBPW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 20:15:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67470AA4B4;
        Mon, 13 Nov 2017 20:15:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o7PRNBRoVeC5cbwY/JMnRyvL04c=; b=A2XzwV
        pGcw/8Hyl9spmzwso8h/od3o4FFF2Fx1rEybAb4lNJ8IAiFsbF6YuV6LHMm09Tw0
        ci9qvaaHiBNj4ODdEdoRw4Q9qFmvCrd1ZlmFKiB3bONLxjrj25LsKvNgQZP+ZHEV
        U3LqM2cCaj6iWev9oL0WbRcxvjuRxBXRuwUh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LrHIdgd4FsazJnwgpdmEySyb6Fxh9VPp
        n1tWucH4QBbzaeGpxCzh0vkfvcI7cEunr8MGppvRC4M0fQZqScvqFqmPeTnk8wuH
        TWRDLBSkaEBp0YwhS1DudCNGbcmflek+nFWZgYeaMO/V9Yesu6bO4HNzj/SwT+nz
        U7hVwQV2iUc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5ED11AA4B3;
        Mon, 13 Nov 2017 20:15:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAA99AA4AF;
        Mon, 13 Nov 2017 20:15:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/9] sequencer: dont't fork git commit
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171110110949.328-1-phillip.wood@talktalk.net>
        <xmqqo9oadjn5.fsf@gitster.mtv.corp.google.com>
        <f1c0efa2-fb8a-43bc-f229-c22dada95b03@talktalk.net>
Date:   Tue, 14 Nov 2017 10:15:19 +0900
In-Reply-To: <f1c0efa2-fb8a-43bc-f229-c22dada95b03@talktalk.net> (Phillip
        Wood's message of "Mon, 13 Nov 2017 11:24:34 +0000")
Message-ID: <xmqq1sl18xug.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 487EF9AE-C8D9-11E7-A708-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> Are you happy with the '--signoff' is handled (I didn't modify my
> changes in the last iteration as you were still thinking about it)?

I am not, but I am not unhappy, either.

As I understand from your responses, it seems that the existing code
had an untriggerable mess and the patch replaced it with another
that is also untriggerable, and if that is the case, well, we do not
have an immediate need to clean it up either way, so... ;-)

