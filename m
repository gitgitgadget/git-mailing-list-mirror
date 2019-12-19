Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA044C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49ADA222C2
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C86OptTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLSS0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:26:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59303 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfLSS0r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:26:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 393129704E;
        Thu, 19 Dec 2019 13:26:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/Ubq9NTdDUZ+VEtRNMK+alFFqqU=; b=C86Opt
        TwyDPFxxpQ+9hdbZxMZG9ebqRrt7dDUe5N0JCgHhE/ndFckOmOHnd2oY9ejPHjdg
        j2fgWBJy4jxARIoquSDre4DPKi4UXWipGf99gf8mY10rqFcTLb3jmIdmjKXW3xJE
        3/rOQaQC/h6mUUPScR01Qgl59vO5DTmd68tmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fS7Y/NboMOtgA4ADxVAhWfdxmCQshawa
        +kz24yYd9s/wbTGU6pdc9/4Y4n5ZuH6e+273e1bvjx7J+mJ97zXNaIqCOYVKrfWK
        oSUo37K+BT61/qJZNrF7McCS+Vf3fUC4O5vzv03cnpNiCUtNLFqQwy2Qx4/Znlti
        J8XCM0BHqRE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3285E9704C;
        Thu, 19 Dec 2019 13:26:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5138B97049;
        Thu, 19 Dec 2019 13:26:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v2 0/1] [Outreachy] commit: display advice hints when commit fails
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
        <pull.495.v2.git.1576746982.gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 10:26:40 -0800
In-Reply-To: <pull.495.v2.git.1576746982.gitgitgadget@gmail.com> (Heba Waly
        via GitGitGadget's message of "Thu, 19 Dec 2019 09:16:21 +0000")
Message-ID: <xmqqlfr8b28v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1ACB7AA4-228D-11EA-9EB1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      @@ -19,16 +19,16 @@
>             #   (use "git add <file>..." to update what will be committed)
>             #   (use "git checkout -- <file>..." to discard changes in working directory)
>             #
>      -      #   modified:   ../builtin/commit.c
>      +      #   modified:   /builtin/commit.c

Really?
