Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93183C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 05:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313B3207FB
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 05:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F1+/He3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgIJFNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:13:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59294 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJFNm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 01:13:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13FF18EA08;
        Thu, 10 Sep 2020 01:13:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LFpdzNdOX3rxb2TWE9SxnJC/QoU=; b=F1+/He
        3F/SzWuYu71Y/ATOIPb3342pg+NoD6wbgB+RDayXirMSTCLR4X7oqLgrJbP/9mba
        Wydd2QOLEgtZisIEeITYkZQANyxFcXb9e/L/7552xVjBWGt31e3qa5ianjF7uEsc
        Mew27My7PbDUMp9xBMwbhnKNtnJ6ClE6OhM7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vSojnTEuF8jsz7gkOxdwl4Nb38acuwdO
        8frrpG6DnF33OAfTOFhOoFfcVFpUieC17ePt770HM7fiTt/U+yMmK98UALxO2s6s
        z7YL3oFxqG8Gu5ebZQ1XXLujpiGGX/8cypvrVy+p+3hY8qZn1O/u3oroFDBcfj3e
        XZb00ZHEVfk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B5508EA06;
        Thu, 10 Sep 2020 01:13:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D47B8EA05;
        Thu, 10 Sep 2020 01:13:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kyohei Kadota via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        "KADOTA\, Kyohei" <lufia@lufia.org>
Subject: Re: [PATCH v3 1/2] Fit to Plan 9's ANSI/POSIX compatibility layer
References: <pull.694.v2.git.1599680861.gitgitgadget@gmail.com>
        <pull.694.v3.git.1599704262.gitgitgadget@gmail.com>
        <534378c4e558057ce66e291c5a104b7227eb84f3.1599704262.git.gitgitgadget@gmail.com>
Date:   Wed, 09 Sep 2020 22:13:39 -0700
In-Reply-To: <534378c4e558057ce66e291c5a104b7227eb84f3.1599704262.git.gitgitgadget@gmail.com>
        (Kyohei Kadota via GitGitGadget's message of "Thu, 10 Sep 2020
        02:17:41 +0000")
Message-ID: <xmqqa6xyrz7g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6324ABD2-F324-11EA-A406-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kyohei Kadota via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kyohei Kadota <lufia@lufia.org>
>
> tr(1) of ANSI/POSIX environment, aka APE, don't support \n literal.
> It's handles only octal(\ooo) or hexadecimal(\xhhhh) numbers.
>
> And its sed(1)'s label is limited to maximum seven characters.
> Therefore I replaced some labels to drop a character.
>
> * close -> cl
> * continue -> cont (cnt is used for count)
> * line -> ln
> * hered -> hdoc
> * shell -> sh
> * string -> str
>
> Signed-off-by: Kyohei Kadota <lufia@lufia.org>
> ---

This round, without the confusion between 'h' and 'H' commands, I
see nothing funny in it.

Will queue.  Thanks.
