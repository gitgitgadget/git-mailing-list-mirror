Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB19C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 22:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbiHSWSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 18:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240889AbiHSWRl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 18:17:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A54106F8A
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 15:17:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6993819F3E0;
        Fri, 19 Aug 2022 18:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R5R6TYd3tOzreCAQ5dKRn6aEdMHNoksT0fxW2k
        cS27Q=; b=vj7KtNIY3qFctBQ5g5qndXE+93TcKSld1zzRbO5k/1cWNiYKHGSJfv
        5Fg8exBEUEohgIPoIX8V2rQdr+bvaOb2gqUXk2nK4JEeXfiUgPNThORY9WCt7XzL
        BSFJDFRE5hTvrAWbIatVBJZ83DICT2sYDt9R+MeZwSgF+u0RSC700=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62B6E19F3DF;
        Fri, 19 Aug 2022 18:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2019E19F3DC;
        Fri, 19 Aug 2022 18:17:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v4 0/3] t0021: convert perl script to C test-tool helper
References: <cover.1659291025.git.matheus.bernardino@usp.br>
        <cover.1660522524.git.matheus.bernardino@usp.br>
        <oop2rosn-011s-9rpn-04s5-ss12n45q615p@tzk.qr>
Date:   Fri, 19 Aug 2022 15:17:15 -0700
In-Reply-To: <oop2rosn-011s-9rpn-04s5-ss12n45q615p@tzk.qr> (Johannes
        Schindelin's message of "Mon, 15 Aug 2022 15:01:54 +0200 (CEST)")
Message-ID: <xmqq8rnjkhec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF528BD4-200C-11ED-A3F5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 14 Aug 2022, Matheus Tavares wrote:
>
>> Main changes since v3:
>> Patch 2:
>> - Mentioned in commit message why we removed the flush() calls for the
>>   log file handler.
>> - Removed 'buf[size] = \0' and relied on the fact that packet_read()
>>   already 0-terminates the buffer. This also allows us to use NULL
> ...
> The range-diff looks good to me, and I think this iteration is good to go.

Thanks, both.  Let's merge it down.

