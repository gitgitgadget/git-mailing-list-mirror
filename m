Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C73EC2FC0E
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 00:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347268AbjHQANF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 20:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347323AbjHQANC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 20:13:02 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4044026A5
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 17:13:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BB26E19582;
        Wed, 16 Aug 2023 20:13:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gKFeNHo1+xzqke/3wozfdl5CAWe7NcK6ABE8YV
        YppAg=; b=Fm/YswCU6IaGFzsQ9illHeDgtMcy1F0AeiPGMkCFsTIxKO8yDcu1qc
        5iO9F8mAj3r9ujCzCmBc4xb4KcZTGdGevi/eqWVu12ejW9gm5xZK3JhiMcWAWtnh
        3bOW6JaJcv3ExqWUJGrz1YldNVkrfMa35Ajy+0vbXAMXC/znBi8FI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFC6919581;
        Wed, 16 Aug 2023 20:13:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 946C21957E;
        Wed, 16 Aug 2023 20:12:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, linusa@google.com, calvinwan@google.com,
        phillip.wood123@gmail.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v6 2/3] unit tests: add TAP unit test framework
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
        <cover.1692229626.git.steadmon@google.com>
        <ca284c575ece0aee7149641d5fb1977ccd7e7873.1692229626.git.steadmon@google.com>
Date:   Wed, 16 Aug 2023 17:12:55 -0700
In-Reply-To: <ca284c575ece0aee7149641d5fb1977ccd7e7873.1692229626.git.steadmon@google.com>
        (Josh Steadmon's message of "Wed, 16 Aug 2023 16:50:06 -0700")
Message-ID: <xmqqpm3mcyrc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D11C10CA-3C92-11EE-A9B2-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> diff --git a/Makefile b/Makefile
> index e440728c24..4016da6e39 100644
>
> --- a/Makefile
> +++ b/Makefile

With that blank line, I seem to be getting

    Applying: unit tests: add TAP unit test framework
    error: patch with only garbage at line 3
    Patch failed at 0002 unit tests: add TAP unit test framework	

And with that blank line removed, I seem to then get

    Applying: unit tests: add TAP unit test framework
    error: patch failed: Makefile:682
    error: Makefile: patch does not apply
    error: patch failed: t/Makefile:41
    error: t/Makefile: patch does not apply

This is on top of "The fifth batch", the commit your cover letter
refers to as the base of the series, so I am puzzled...

