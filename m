Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC3CC433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 21:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05522610A6
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 21:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbhDPVdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:33:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57525 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241945AbhDPVde (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 17:33:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D95212C9CA;
        Fri, 16 Apr 2021 17:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mJthKWgGrKAU5z9mDIaOoNMinM4=; b=mzbMUE
        0l8tNnp/LF9u8KGne2awnAld8vuxxcPolqgIGI5NoPdMo09htzonnzUYAzvHuGCd
        6Mxea0QKmxDU9fwQIg67bu370gIr6suUtDxUYENOG7mFPJJeeOSKwxTRRfQosbra
        3A0xueS51SjS0hgmDbUoMQcu8C7uNGdPxt/YM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z4xk4MuvbJzozOfqt0geDtE/FISVgYnR
        wUQ19mFJpQQR1iuNb3NC+ortm57odRThYqphTNobsIYbVeE+OuU7IfaUa2UDfVgD
        IDSP0pBQ1MMSDZuFP8SZ2WzQJq6hcOANjyKVMsk0AsIIE3GNjmTsszU9HlE6QyfU
        tWoXLETVPLQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 262F912C9C9;
        Fri, 16 Apr 2021 17:33:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7523312C9C8;
        Fri, 16 Apr 2021 17:33:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, newren@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v4 0/7] add/rm: honor sparse checkout and warn on sparse
 paths
References: <cover.1615588108.git.matheus.bernardino@usp.br>
        <cover.1617914011.git.matheus.bernardino@usp.br>
Date:   Fri, 16 Apr 2021 14:33:04 -0700
In-Reply-To: <cover.1617914011.git.matheus.bernardino@usp.br> (Matheus
        Tavares's message of "Thu, 8 Apr 2021 17:41:21 -0300")
Message-ID: <xmqqzgxxkj8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54FF9304-9EFB-11EB-9F27-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> Make `rm` honor sparse checkouts, and make both `rm` and `add` warn
> when asked to update sparse entries.

OK, has the back-and-forth concluded and this is now ready to be
merged down to 'next'?
