Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78426207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 17:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933853AbcI2RFP (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 13:05:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54303 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751287AbcI2RFN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 13:05:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2653C40693;
        Thu, 29 Sep 2016 13:05:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LmFrFzlwENyUrejO3CWJYqZIeh8=; b=xo3azZ
        F+24OvgunWoMZzE9IfJ8kOpYoh+L/ZhJ67WaV5wMmonc5U6G+gn1zxYzCEuqHXNK
        txGtcR30st+AOopsNFazcHV/lQ53ih2uRm25t3tjoasIV3mPRCzinoFP/AXDhpug
        1RAtIuaFoW8hxOLi/+BF1MN/JDBohrE6OlPhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vRxD4UmiEXqs8nSuDGFQ1Ty9tFdS/D2F
        RosRCC34WqzWBNj6nkBREnRoJqWFyFhljj3ypBHBj9YLJ/fgUBulv2LYN1CIWTNT
        QtYM5MHEngV5Gtxyr2v1iMSsORMD21hJ/sZjY0VMxTt+rP5Zeu1tuQicw15ndwEs
        XM896oITVsk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DF9140692;
        Thu, 29 Sep 2016 13:05:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9007940691;
        Thu, 29 Sep 2016 13:05:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 02/11] i18n: add--interactive: mark simple here documents for translation
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
        <1472646690-9699-3-git-send-email-vascomalmeida@sapo.pt>
        <xmqqmvivy4i9.fsf@gitster.mtv.corp.google.com>
        <1475159493.2435.7.camel@sapo.pt>
Date:   Thu, 29 Sep 2016 10:05:09 -0700
In-Reply-To: <1475159493.2435.7.camel@sapo.pt> (Vasco Almeida's message of
        "Thu, 29 Sep 2016 14:31:33 +0000")
Message-ID: <xmqqfuoihc1m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1E4C90E-8666-11E6-8837-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> On the other hand, would it make sense to translate these commands? If
> so, we would mark for translation the commands name of @cmd in
> main_loop().
>
>  sub main_loop {
> -       my @cmd = ([ 'status', \&status_cmd, ],
> -                  [ 'update', \&update_cmd, ],
> -                  [ 'revert', \&revert_cmd, ],
> -                  [ 'add untracked', \&add_untracked_cmd, ],
> -                  [ 'patch', \&patch_update_cmd, ],
> -                  [ 'diff', \&diff_cmd, ],
> -                  [ 'quit', \&quit_cmd, ],
> -                  [ 'help', \&help_cmd, ],
> +       my @cmd = ([ __('status'), \&status_cmd, ],
> +                  [ __('update'), \&update_cmd, ],
> +                  [ __('revert'), \&revert_cmd, ],
> +                  [ __('add untracked'), \&add_untracked_cmd, ],
> +                  [ __('patch'), \&patch_update_cmd, ],
> +                  [ __('diff'), \&diff_cmd, ],
> +                  [ __('quit'), \&quit_cmd, ],
> +                  [ __('help'), \&help_cmd, ],

I don't know offhand.  If the code to prompt and accept the command
given by the user can take the translated word (or a prefix of it),
theoretically I would say it could be made to work, but to me it is
dubious the benefit outweighs its downsides.  It would make teaching
Git and troubleshooting over the phone harder, I would guess.

 A: "Hi, I am in a 'git add -i' session."
 B: "Give 's' at the prompt."
 A: "My Git does not seem to take 's' as a valid command."
 B: "What? I've never seen that problem."
 ... back and forth wastes 10 minutes ...
 A: "By the way, I am running Git in Portuguese."

;-)
