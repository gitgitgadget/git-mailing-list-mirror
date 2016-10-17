Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223AD1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 21:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030182AbcJQVvJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 17:51:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55900 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933711AbcJQVvI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 17:51:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7CE848B78;
        Mon, 17 Oct 2016 17:51:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wwEcRitOaz+Gt0vrI9RfFSjQcKU=; b=OZGvaa
        gLQ79BUdXqxM7FaSs5N62hmeKzh43Dl12RTV2H+ZOwGP64FJhFmKYEHYm1axuMaI
        K6n68yRG5e2W9R5Ewj0PgcMcabNJw8Lg7WELMJpskB82W/vXmg/0PaRalZ4pl+mD
        1VrKRZQ1aHU5SEGMGH9rfceo8ek3aS6HgDkbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JsZyLUM6ip5AmhCgVfiGd13x+3tPa2vS
        cu4nsLv7ZXhy0BpkHBeo9mdDq5w+mZiHKYFZynkXXaB7St2dhBzEjXsdXm4K5AG1
        RGTTzqrrHemPipVCTo/gYKSwt1VHxEnNxUJR9zlggnBcPsD1EE/8W4o3NeT72uEM
        u1S/DMLavyU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9B7A48B77;
        Mon, 17 Oct 2016 17:51:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B32F48B76;
        Mon, 17 Oct 2016 17:51:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t0040: convert all possible tests to use `test-parse-options --expect`
References: <01020157c8505fc5-cb313aa8-0182-4e19-95fa-cb36c573ee4c-000000@eu-west-1.amazonses.com>
Date:   Mon, 17 Oct 2016 14:51:04 -0700
In-Reply-To: <01020157c8505fc5-cb313aa8-0182-4e19-95fa-cb36c573ee4c-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Sat, 15 Oct 2016 12:28:13 +0000")
Message-ID: <xmqqzim2skzb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE4CB1F8-94B3-11E6-A446-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Use "test-parse-options --expect" to rewrite the tests to avoid checking
> the whole variable dump by just testing what is required. This commit is
> based on 8ca65aeb (t0040: convert a few tests to use test-parse-options;
> Junio C Hamano; May 6, 2016).
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  t/t0040-parse-options.sh | 183 ++++-------------------------------------------
>  1 file changed, 13 insertions(+), 170 deletions(-)

Whoa.  Quite a lot of repetitions removed.

