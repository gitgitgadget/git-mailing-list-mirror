Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6041F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 22:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941878AbcJEW27 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 18:28:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62811 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934595AbcJEW25 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 18:28:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0715843A76;
        Wed,  5 Oct 2016 18:28:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eeirsSvROxl3K6qO2jj5LKKOFwI=; b=fIPY6H
        KGXR3ygV7HCy/wa9TAWCDSuFc3mU2PceMMJhH29mTZzuGDgJM1nyxL+Iv+fI7rIh
        cWOWQn+bpvoMOgjgoa1MqKhWABmHGWg571hkxAtHlDIvmt8roFchQ+K3vAmr8Jhv
        CWxDmwz+NvaBp3Gek1n5692CfpudiEByLWmbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sanTXSbkGp9XifxXglUUsbu8Tqb2JGeS
        dfeeWUxf10vkZ6ROhJd+bcm1ZwAyMDWY/fZwZ0qdU7z7V83FXF5yWa1umCOOkLjV
        1RSFkdOIDJDRDiC0TOMX7aad7YVd68yD/lrA2s1gsMKHYUrJQ+gcXAHF5r3gWyLR
        Ywp6Cm0hHLI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F066D43A75;
        Wed,  5 Oct 2016 18:28:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6009743A74;
        Wed,  5 Oct 2016 18:28:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Jakub =?utf-8?Q?Na?= =?utf-8?Q?r=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 03/14] i18n: add--interactive: mark strings with interpolation for translation
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
        <20161005172110.30801-4-vascomalmeida@sapo.pt>
Date:   Wed, 05 Oct 2016 15:28:53 -0700
In-Reply-To: <20161005172110.30801-4-vascomalmeida@sapo.pt> (Vasco Almeida's
        message of "Wed, 5 Oct 2016 17:20:59 +0000")
Message-ID: <xmqqshsamnve.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19E65ADC-8B4B-11E6-AE96-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

>  				if (!defined $bottom) {
> -					error_msg "Huh ($choice)?\n";
> +					error_msg sprintf(__("Huh (%s)?\n"), $choice);
>  					next TOPLOOP;
>  				}
>  			}
>  			if ($opts->{SINGLETON} && $bottom != $top) {
> -				error_msg "Huh ($choice)?\n";
> +				error_msg sprintf(__("Huh (%s)?"), $choice);
>  				next TOPLOOP;

Doesn't this want "\n" just like the other one in this hunk?

