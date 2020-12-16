Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC726C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C82A2389A
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgLPX1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 18:27:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51147 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgLPX1i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 18:27:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DE0C8ED67;
        Wed, 16 Dec 2020 18:26:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/d63M/XEdom8jQLfgEngEVK5JhQ=; b=xPLphz
        z171zxUmUO6rcIRX6h1/22eqS0tXMfzjI+CwzNaGmmNz1nDYPydTuDtkj9HO6IHT
        O8gBLn0N+t+5T/rc3Y4lR6nuBspkTnHpY09r21KbPaqr8Hadz6ETAtX6Sq2qoznK
        O63PHscNuIzoO9aERQC02tFsE5/aY+j8f+fqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D9CtyG+PTuXb4zbN4uT+lxCPXsrLYAzb
        FWr+kszh21hcH26ObwYbDYy/gGHmxSDb76b+VELG+1rD1G/6KUIetQLiIb3KcrRB
        +V+kMLPW8kESeD+tDUU99zr4W4ldzHGNASsm2DBuL2Trc00e8kRsGGEN1ZO7XUZ+
        a4cXHo1MZXk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9691F8ED66;
        Wed, 16 Dec 2020 18:26:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 224628ED65;
        Wed, 16 Dec 2020 18:26:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Patch 1/1] config.mak.uname: remove old NonStop compatibility
 settings
References: <20201216220752.6371-1-randall.s.becker@rogers.com>
        <20201216220752.6371-2-randall.s.becker@rogers.com>
Date:   Wed, 16 Dec 2020 15:26:55 -0800
In-Reply-To: <20201216220752.6371-2-randall.s.becker@rogers.com> (randall
        s. becker's message of "Wed, 16 Dec 2020 17:07:52 -0500")
Message-ID: <xmqq1rfp2uyo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FCF6C58-3FF6-11EB-91A5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

randall.s.becker@rogers.com writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> The MKDIR_WO_TRAILING_SLASH and NO_SETITIMER options are no longer
> needed on the NonStop platforms as both are now supported by the
> oldest supported operating system revision.

Nice to read "supported by the oldest supported version"; very
assuring that it is the right thing to unconditionally remove these
settings.

Will queue.  Thanks.

>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  config.mak.uname | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 5b30a9154a..198ab1e58f 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -574,10 +574,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	NO_MMAP = YesPlease
>  	NO_POLL = YesPlease
>  	NO_INTPTR_T = UnfortunatelyYes
> -	# Bug report 10-120822-4477 submitted to HP NonStop development.
> -	MKDIR_WO_TRAILING_SLASH = YesPlease
> -	# RFE 10-120912-4693 submitted to HP NonStop development.
> -	NO_SETITIMER = UnfortunatelyYes
>  	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
>  	SHELL_PATH = /usr/coreutils/bin/bash
>  endif
