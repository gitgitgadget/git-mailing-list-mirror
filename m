Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C712C2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 19:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbdCRTRb (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 15:17:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61034 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751661AbdCRTRa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 15:17:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 805DC8824E;
        Sat, 18 Mar 2017 15:17:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=npDTqHBHLzJt57hB2G8p/3cNwi0=; b=jNoBEV
        5fM6/HLy8qQl5Esg++Vq2mB9UTxBE9PpGIgVwsT+rvduF+TCBiQlw9g/eRYI3JF0
        VAiQoyRomg1bNv+m+LIDByKGgxhoiWt76sMcWCAhI4ssOnEccFWJhP/fP6gJB63u
        fGQy7UTEly+jJbuWfRELpK5yRBJzEReiIChlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uwzh3pZdDnWcMGO1QU/3Fp3Rmu6WG0AC
        C7tX9P536k8qiPxbn7CHL5xlls12OhwouadvQW5y3NyAtj1wMCERUbAhjNNtViki
        rRo8de8wAmEUEvDKodk2WgtIu1l40hRinsv2G4EbkX4eexGSSIVdw9iK3JkFzpZv
        2U/sgnw54TM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77D668824D;
        Sat, 18 Mar 2017 15:17:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C80BF8824C;
        Sat, 18 Mar 2017 15:17:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] pickaxe: fix segfault with '-S<...> --pickaxe-regex'
References: <20170318151239.17196-1-szeder.dev@gmail.com>
        <xmqqefxu2yzg.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 18 Mar 2017 12:17:26 -0700
In-Reply-To: <xmqqefxu2yzg.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 18 Mar 2017 11:58:43 -0700")
Message-ID: <xmqqshma1jjt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 867A9A92-0C0F-11E7-98CE-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Interestingly, the new test fails (with the patch) under prove but
> not when run from the shell (i.e. "cd t && sh t4062-diff-pickaxe.sh").

Sorry, false alarm.
