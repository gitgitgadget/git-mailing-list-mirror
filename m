Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66A811F462
	for <e@80x24.org>; Tue, 28 May 2019 16:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfE1QZo (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 12:25:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61954 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfE1QZo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 12:25:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1431D148BB8;
        Tue, 28 May 2019 12:25:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QNdRBOZHdgyL
        Y6SzZS6Kl41ICOg=; b=YfJ4rs+2SXTbhL6B0uiKK07Zq/csE5wF/3GVEQiOR7/J
        rWK/r/wnubWWmYyn0RXHImxw61zmtl2tCfxaG1pMHm+UHhsJ9HFVbYC3jcU6huzk
        GUl0oNdbxXlrLf3zZKpjQ7/TXVPKrCEGOzBcfAcWx/zBomgfQaQ65BjLXCifF3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yDHJSI
        loaaTRcybVJa87pT8ZqmMYlLS8ry5yaEhwHUeSmUZw65ypofZtUklvYocOw9mMpr
        8P0yvnYJhTvQp/ieaNC1etdQFvyKglEjSoE/FZpeyxbGhkn03YMnREkGZwdH0Gcn
        vu29Z583PyBrKst9X610BXvWq2/XQoR0RQg6M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CA75148BB7;
        Tue, 28 May 2019 12:25:42 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72B3E148BB6;
        Tue, 28 May 2019 12:25:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@jeffhostetler.com,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] trace2: rename environment variables to GIT_TRACE2*
References: <20190510211502.GS14763@szeder.dev>
        <20190519144309.9597-1-szeder.dev@gmail.com>
Date:   Tue, 28 May 2019 09:25:40 -0700
In-Reply-To: <20190519144309.9597-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Sun, 19 May 2019 16:43:08 +0200")
Message-ID: <xmqq36ky5ywr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3C4C9CE0-8165-11E9-ACCD-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> For an environment variable that is supposed to be set by users, the
> GIT_TR2* env vars are just too unclear, inconsistent, and ugly.

FWIW, I personally am in favor of this change and would prefer to see
this done before the use of the names with unguessable abbreviation
gets ingrained too deeply. =20

I do not see any objections around these two patches after waiting
for a week or so, but I do not see any Yay!s, either, so ...

> OTOH, we don't gain anything at all by omitting the last three
> characters of "trace" from the names of these environment variables.
>
> So let's rename all GIT_TR2* environment variables to GIT_TRACE2*,
> before they make their way into a stable release.
