Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD85D1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 19:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbdLLT5b (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 14:57:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63854 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752329AbdLLT5b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 14:57:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B24F5C0888;
        Tue, 12 Dec 2017 14:57:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Dy0yc+0O7gV/nWxgNRVUVcessM=; b=Q4ATlq
        EFGLH1gC/ul6iypSdczMzNAJApaOm7XQfdCGt/RSWkRksiS+ELvhYssHpCujfQtC
        AU3bMxDS3BRjQ0AEt/It83LXw7O2moZCkCoo8dDrlO8Z2iucBsPcxZUtg6whuZyu
        xiBrhc4DcEpi5I+fhhDDrwn/xj9wqURmqGcao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iQIC2VWnhwtU/Gk5DpNwBGkTjsfYH+FR
        ngO8MzezlWj/k9FhyExXz/baRGQy2uUNbCFErJhT/4fi+kWiFoE767nNMi+gV2C6
        Os5UzHe9uhMy/VkGTMuI2K4iQ1jd0GqrRKJOIwQod9t1QjrbANrbic2eL/KEE0TF
        YEa0O1TYUs0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAC39C0887;
        Tue, 12 Dec 2017 14:57:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2926AC0886;
        Tue, 12 Dec 2017 14:57:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: allow NO_DC_SHA1_SUBMODULE to be set in config.mak
References: <7272c221-c1b6-ca41-3be4-329275e94b8a@ramsayjones.plus.com>
        <xmqqk1xr204t.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 12 Dec 2017 11:57:28 -0800
In-Reply-To: <xmqqk1xr204t.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 12 Dec 2017 11:53:54 -0800")
Message-ID: <xmqqfu8f1zyv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF831230-DF76-11E7-9B2F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Makes sense.  The patch looks scary by appearing to move the
> includes far to the front of the Makefile, but it in fact is moving
> the NO_DC_SHA1_SUBMODULE block slightly down and it is a sensible
> and safe move.

A completely unrelated tangent.  This was a good change to try your
anchored diff on.  Viewing this change with

   $ git show --anchored='include config.mak'

looks a lot less scary than the way it is shown by default (which
matches what was posted on the list).

Good job.
