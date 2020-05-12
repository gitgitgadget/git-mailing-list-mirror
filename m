Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217F3C2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 21:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC4A8205C9
	for <git@archiver.kernel.org>; Tue, 12 May 2020 21:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CVtmYYmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgELVTa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 17:19:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59115 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELVT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 17:19:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E85FD3FBB;
        Tue, 12 May 2020 17:19:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gCpO54ACbHf7uSVrmglLFdG3xb8=; b=CVtmYY
        mY5zvLuWflhKi1djiplDuaNYw0/mld6++QcKq5Ftj/B50ZGOWVN8ER+Bd+aMewKU
        r9QYjfP0kKsfzu7mpnzn31raeoUkS9XlNJaCC6+rduVCfsZ/B7D3UFxjt1gsKH5W
        S0doBn3LQin392eqdIvZk7DazTchCwU+TH2V0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a80dAR0zm+/Ys6T2vJuADIbZqcHvOBLg
        uj+e+dyFCE/mWlKhnRQ6C3hVHnU8ijTbt2YP9uey9kYZ404hrxhI0xyUIQZx4318
        iVhYKK+h5MtZa+wWMuf/LaTmsIHJ/svtORjtdzNWrVZEPhjgrHpgfdBIPlRjLBTC
        PaBZigoe+hw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 06DDDD3FBA;
        Tue, 12 May 2020 17:19:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4F94FD3FB8;
        Tue, 12 May 2020 17:19:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 02/11] cmake: generate the shell/perl/python scripts and templates, translations
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <ca242cf5bda74aafca6c169ad53ce33a62761027.1589302254.git.gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 14:19:23 -0700
In-Reply-To: <ca242cf5bda74aafca6c169ad53ce33a62761027.1589302254.git.gitgitgadget@gmail.com>
        (Sibi Siddharthan via GitGitGadget's message of "Tue, 12 May 2020
        16:50:45 +0000")
Message-ID: <xmqq7dxgc0mc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41842788-9496-11EA-B9D2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
>
> This patch implements the placeholder substitution to generate, say,
> `git-request-pull` from `git-request-pull.sh`.
>
> The shell/perl/python scripts and template are generated using CMake
> (very similar to what sed does).

We do not say "This patch does X" or "I do Y in this patch".
perhaps.

	Implement the placeholder substitution to generate scripted
	Porcelain commands, e.g. git-request-pull out of
	git-request-pull.sh

	Generate scripts and templates using CMake, instead of using
	sed like the build procedure in the Makefile does.

