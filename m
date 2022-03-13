Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFE6C433FE
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 22:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiCMWXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 18:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCMWXa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 18:23:30 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C813386E0C
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 15:22:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BB6A170033;
        Sun, 13 Mar 2022 18:22:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QYfcgzdKKwlIBDisjmazfCREO2fiapRhgxHaj3
        EhtwE=; b=J3xXdKwMWI/1Df7pn5+kbeXj1df3qfG2QmtvBcZeKQpknD87qOlT49
        48HvU9a1wHB6tZcC28/zgy5OLhcIKH3M62mQaISMk3dzosLbzzuVVtBu0XcTUpKq
        Bcs0gnYbMmXJ3RDOlDznyG5TrspbIVRD2ZCCc3fcO38EMdAB12bqA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 94BE8170032;
        Sun, 13 Mar 2022 18:22:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B7B8170030;
        Sun, 13 Mar 2022 18:22:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove. duplicate include directives
References: <20220313195536.224075-1-gitter.spiros@gmail.com>
Date:   Sun, 13 Mar 2022 22:22:16 +0000
In-Reply-To: <20220313195536.224075-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Sun, 13 Mar 2022 19:55:31 +0000")
Message-ID: <xmqqzglttrvr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A676706-A31C-11EC-94C6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> This series of patches does not solve any particular problems but
> only eliminates unnecessary duplicate include directives
> from git sources
>
> Elia Pinto (5):
>   attr.c: delete duplicate include
>   builtin/gc.c: delete duplicate include
>   builtin/sparse-checkout.c: delete duplicate include
>   builtin/stash.c: delete duplicate include
>   t/helper/test-run-command.c: delete duplicate include

Thanks.

It matches the output from the pipeline:

$ git grep '^#include' \*.c |
  sort | uniq -c | sort -n | sed -e '/^ *1 /d'
