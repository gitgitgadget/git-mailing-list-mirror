Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFAC61F463
	for <e@80x24.org>; Sat, 28 Sep 2019 04:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbfI1E7X (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 00:59:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55340 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfI1E7X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 00:59:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F22E360CC;
        Sat, 28 Sep 2019 00:59:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4l+9zpaLN+XIN3to0GxBuCCa8dI=; b=wmB/CA
        t/i0eR7qtjZLK3ixxPGlqDxsDpviRKW6UyYNAeKgVkDm/JSkuuGtNJv2JJmnA4I7
        Io9i/RbWF4yuQDfam0daRwDmgZMC/hxQSShCVHmfNKPTWPTBwtsD6I2KodoCHyl5
        mZRKwE4wPtQUMmo70wjnNZV4bzJp3QTOQgJNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=giXqHuh5z7PdSmg/2X1Nt1RImczJ6eHR
        RINrNqUttrMOJrBKVbH6sjMGm0xXwm/OGsfLwEYvho6e3bY8sQl6zbDiySkfCXL4
        Dbg+3eNPkI5QKyxQw2DvpO/0AHK+ZwHGpfYJLHuVRScpyOBM+b1f/lhZPwOq+Y6B
        WtParc/rjxI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28133360CB;
        Sat, 28 Sep 2019 00:59:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8BAF3360CA;
        Sat, 28 Sep 2019 00:59:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] Makefile: use $(ALL_CFLAGS) in $(HCO) target
References: <cover.1569263631.git.liu.denton@gmail.com>
        <0336d1345abfef563d9228e250316cc58a01f2b3.1569263631.git.liu.denton@gmail.com>
        <nycvar.QRO.7.76.6.1909261449230.15067@tvgsbejvaqbjf.bet>
        <20190926173801.GA42456@generichostname>
        <nycvar.QRO.7.76.6.1909262144060.15067@tvgsbejvaqbjf.bet>
Date:   Sat, 28 Sep 2019 13:59:19 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1909262144060.15067@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Thu, 26 Sep 2019 21:47:43 +0200
        (CEST)")
Message-ID: <xmqqr241j9so.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB626602-E1AC-11E9-B382-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The only problem is that my patch made it into `next` already, according
> to https://github.com/gitgitgadget/git/pull/129 (look for the labels on
> the right side, or for the comments on the bottom), and
> https://github.com/gitster/git/commit/a3f332f4fb10 agrees (look for
> names of the branches containing that commit, under the commit message).
>
> So we should explicitly as for my patch to be backed out from `next` and
> be stopped from advancing to `master`.
>
> Junio, would you kindly do that? According to the PR, you gave this
> branch the name `js/honor-cflags-in-hdr-check`.

OK, so the topic should be dropped and replaced by the Denton's
series.  Thanks, will do.
