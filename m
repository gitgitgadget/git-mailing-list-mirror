Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C9C202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 18:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753855AbdCHSdu (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 13:33:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54463 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750770AbdCHSds (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 13:33:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95C926D06A;
        Wed,  8 Mar 2017 13:33:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VEd5UMo5e/+QtzGSIQw0SC5ZJco=; b=uyop6f
        VF/7LpduzGrt6NrxPwy48O4zM85ef7p2vkbFkHn1/s3dSpUF6Dnm0EW1u55reT6m
        aouBiQvXJmCzzUzrxxw+WnXaVdAt59o2X3tiqEfThcXHUrdiZEUmesVNwle2wshw
        51DYg+ONut2e9760CMgLQBVoyuud6IoJq4eRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=axhItMWAV4pL+Z4rAtBwt8uK4jZVZsK+
        nVcskAqau8FgohSN9OxCTQQy1m4iJipg/4PsRYD4LdhK9wJsuqalAiKHZe6Au8tt
        mp0htDSomuILmmCepIe6qtnppp11yitMobH8NgJnMLbOqUQMTiGwyKNU/XvOVEMH
        AAEqXV35akg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E33D6D069;
        Wed,  8 Mar 2017 13:33:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D97736D067;
        Wed,  8 Mar 2017 13:33:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Guillaume Wenzek <guillaume.wenzek@gmail.com>
Cc:     git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: BUG Report: git branch ignore --no-abbrev flag
References: <CAAvNd=ir1qNQVaKphdg51AfGnsNgTrfvW2L6cca3SHiZrWNgHA@mail.gmail.com>
Date:   Wed, 08 Mar 2017 10:33:39 -0800
In-Reply-To: <CAAvNd=ir1qNQVaKphdg51AfGnsNgTrfvW2L6cca3SHiZrWNgHA@mail.gmail.com>
        (Guillaume Wenzek's message of "Wed, 8 Mar 2017 19:14:24 +0100")
Message-ID: <xmqqlgsf39fg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C09366D0-042D-11E7-B3C5-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Guillaume Wenzek <guillaume.wenzek@gmail.com> writes:

> After updating to git 2.12.0 on Monday I noticed that the "git branch"
> wasn't behaving as usual.

Are you sure you are trying 2.12?  v2.12.0 and before should behave
the same way and honor --no-abbrev as far as I know.

On the other hand, 'master' has 93e8cd8b ("Merge branch
'kn/ref-filter-branch-list'", 2017-02-27), which seems to introduce
the regression.

Karthik?
