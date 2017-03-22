Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B09120323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbdCVVRP (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:17:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59901 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751886AbdCVVRH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:17:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECBFA7C6FC;
        Wed, 22 Mar 2017 17:17:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qwa7Rrfdgkw+qP5jM86cdwncAM0=; b=PtrSwW
        BvJQ1XqVo2D/U3IUiNbkb2ec7qm6fo1w9zff6IDMEHYb1RyK9XxzBEmL4oqVL24T
        JqcatIsNR973RU9Uvi8RDHv/kgalD9V1OaRxfrFfhQmMJcFsp+4YmPxB8hdqg7IX
        nIY3q0yBjZii8hTpCWarAvDqKMT30JDSvAktE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XC0cuKjwHZOdb0kFk+FUzdTV/7deij9a
        BzClIwBkktdKBDs+HcYgsbPYXEPoFNi79/07Pyxp0b77YcoaOtbh/d+0qmdxXQsb
        YukpLlPvmw7enhmX7iOan51E/ICidOLrl7ob7GSQ1rdLtTHtYBRWZSLshshgv7ED
        wdSR4U4GgvA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E53DB7C6FB;
        Wed, 22 Mar 2017 17:17:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5A0D07C6FA;
        Wed, 22 Mar 2017 17:17:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] push options across http
References: <20170322195102.165314-1-bmwill@google.com>
Date:   Wed, 22 Mar 2017 14:17:04 -0700
In-Reply-To: <20170322195102.165314-1-bmwill@google.com> (Brandon Williams's
        message of "Wed, 22 Mar 2017 12:51:00 -0700")
Message-ID: <xmqqshm5huzz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E648D05A-0F44-11E7-B398-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> This series enables push options to be sent across http using remote-curl
>
> Thanks to Jonathan Nieder for helping troubleshoot.
>
> Brandon Williams (2):
>   send-pack: send push options correctly in stateless-rpc case
>   remote-curl: allow push options

Thanks.  Why does the topic name sound familiar to me?  Did we have
a recent attempt to do the same that didn't work well or something?

>
>  builtin/send-pack.c     |  5 +++++
>  remote-curl.c           |  8 ++++++++
>  send-pack.c             | 20 ++++++++------------
>  t/t5545-push-options.sh | 30 +++++++++++++++++++++++++++++-
>  4 files changed, 50 insertions(+), 13 deletions(-)
