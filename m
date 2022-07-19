Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E963EC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 21:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiGSVDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 17:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiGSVDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 17:03:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2359B50076
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 14:03:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 276D11270A8;
        Tue, 19 Jul 2022 17:03:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YC2IgS9bdM/bLbchiLUJM9jxHueox3veXvmt0o
        KjBEc=; b=p8UsrOaE2tsm5zKxV7q//tqaIkuHN27M1/AelcsZMQoVtPd/AJQvjM
        vv9qZLI+IeqwiDeyr6Ddsw6VNvykHTGxfuEO2W7eCkA/E1NEXZ2ylRa+/yZWxUwl
        kaHoQB6WCZ2s/PqAtfxMjZ4hxWmlg9gpSPXvoe1axkY93e9SgDvCY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FD381270A7;
        Tue, 19 Jul 2022 17:03:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E7621270A6;
        Tue, 19 Jul 2022 17:03:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v7 7/7] tr2: dump names if config exist in multiple scopes
References: <cover.1658159745.git.dyroneteng@gmail.com>
        <a01ae8478d3a8545241c5b064b6d369a330ee59f.1658159746.git.dyroneteng@gmail.com>
Date:   Tue, 19 Jul 2022 14:03:11 -0700
In-Reply-To: <a01ae8478d3a8545241c5b064b6d369a330ee59f.1658159746.git.dyroneteng@gmail.com>
        (Teng Long's message of "Tue, 19 Jul 2022 00:46:06 +0800")
Message-ID: <xmqq4jzcak8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 335C36FC-07A6-11ED-9C2C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Subject: Re: [PATCH v7 7/7] tr2: dump names if config exist in multiple scopes

This make it sound as if we do not show the scope if a configuration
variable appears only in one scope, but I do not see how the updated
code achieves that.  Instead, it seems that it shows the scope
unconditionally in addition to the key-value pair.

If that is the case, a retitle is in order.  Also this should
probably be a separate topic, unrelated from the other 6 patches.

