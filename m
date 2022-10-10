Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D58C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 19:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJJTLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 15:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJJTLv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 15:11:51 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDBDCCE
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 12:11:50 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75CF515DB51;
        Mon, 10 Oct 2022 15:11:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sui2Ugz5F2TfAdEz4yQJlaLIMJDEQ3sIAq9A8L
        xTTGE=; b=RU50uW4OrTWJM/q27KjGECSsgDHOU4kKGAsZ9aLP3uh0evyLly1FVL
        LfKmJmcP880BuBp70WVLirIz9QIOHXJYFpN+9w2z3FRpL6qVpZlBgbuVzaOWhtha
        IR+73OvqrnR2A13Eri4uNbaWpZd+ZmmMRhLwpUqec4Df6KnxzBRUI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E5DC15DB50;
        Mon, 10 Oct 2022 15:11:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB5EC15DB4F;
        Mon, 10 Oct 2022 15:11:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     sndanailov@wired4ever.net
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: git-send-email: difference between ssl and tls
 smtp-encryption
References: <20221010172859.13832-1-sndanailov@wired4ever.net>
Date:   Mon, 10 Oct 2022 12:11:47 -0700
In-Reply-To: <20221010172859.13832-1-sndanailov@wired4ever.net>
        (sndanailov@wired4ever.net's message of "Mon, 10 Oct 2022 19:28:59
        +0200")
Message-ID: <xmqqy1tn1ojw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63DBB310-48CF-11ED-AD58-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sndanailov@wired4ever.net writes:

> From: Sotir Danailov <sndanailov@wired4ever.net>
>
> New explanation for the difference between these values.
> It's hard to understand what they do based only on the names.

True.  The names we use, 'ssl' and 'tls', emerged historically and
are not the best ones in retrospect.

It may also help understanding if you mentioned STARTTLS somewhere
in the description of "explicit" one, as (some) readers may be more
familiar with that term than "implicit vs explicit".

>  --smtp-encryption=<encryption>::
> -	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
> -	value reverts to plain SMTP.  Default is the value of
> +	Specify the encryption to use, either 'ssl' or 'tls'. Any other
> +	value reverts to plain SMTP. The difference between the two for Git is
> +	that 'ssl' uses implicit encryption and defaults to port 465, 'tls'
> +	uses explicit encryption and defaults to port 25. Other ports might be
> +	used by the SMTP server. Default is the value of
>  	`sendemail.smtpEncryption`.
>  
>  --smtp-domain=<FQDN>::


