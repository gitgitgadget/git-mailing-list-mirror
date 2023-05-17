Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E45C77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 15:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjEQPts (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 11:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjEQPtn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 11:49:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5955B61A9
        for <git@vger.kernel.org>; Wed, 17 May 2023 08:49:42 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B39191E86F1;
        Wed, 17 May 2023 11:49:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6u3vCJItSfsV2r8hQimwuf57asa/409jSuC26Y
        5VliU=; b=v/C9hmKk+qdGfEGrko9V+jO9omIT98LkdvTVndrqr1eHo6p9s9iKbd
        YEFO0JojqOe/gz8wlQBMhxLMjw6jQ40Y81UX0+CyI+eBUBbkjJBvQBbn29sOXY8C
        uPgWx4IHBuSx5zGyw5Ia19c3E/D3LceEDJeHYxXCGOBxJjnns4Fj4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ABAA61E86F0;
        Wed, 17 May 2023 11:49:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D622A1E86EF;
        Wed, 17 May 2023 11:49:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Hesse <list@eworm.de>
Cc:     git@vger.kernel.org, Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
References: <20230517070632.71884-1-list@eworm.de>
Date:   Wed, 17 May 2023 08:49:37 -0700
In-Reply-To: <20230517070632.71884-1-list@eworm.de> (Christian Hesse's message
        of "Wed, 17 May 2023 09:06:32 +0200")
Message-ID: <xmqqwn17q7ou.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E44DFB4-F4CA-11ED-8421-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Hesse <list@eworm.de> writes:

> From: Christian Hesse <mail@eworm.de>
>
> We use xstrfmt() here, so let's include the header file.
>
> Signed-off-by: Christian Hesse <mail@eworm.de>
> ---
>  imap-send.c | 1 +
>  1 file changed, 1 insertion(+)

Puzzled.  For me Git 2.41-rc0 builds as-is without this change just
fine, it seems.  I know there are many header file shuffling patches
flying around, and I have seen some of them, but is this a fix for
one of these patches?

Thanks.

>
> diff --git a/imap-send.c b/imap-send.c
> index a62424e90a..7f5426177a 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -29,6 +29,7 @@
>  #include "run-command.h"
>  #include "parse-options.h"
>  #include "setup.h"
> +#include "strbuf.h"
>  #include "wrapper.h"
>  #if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
>  typedef void *SSL;
