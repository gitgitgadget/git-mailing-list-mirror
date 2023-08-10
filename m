Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD53C04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 19:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjHJT4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 15:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjHJT4h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 15:56:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FB32720
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 12:56:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A663F2B757;
        Thu, 10 Aug 2023 15:56:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mYaIr4C5bJyTtlD5rtHZaJDbNiJ3S1MZXA5t00
        hUx48=; b=vuQ2Ahk43zYJAOWdCp/XHpJfZ8z0s03Y5802H8Wr08/3FfwDg2R4dy
        JpIpj43cmte2+wOazpRylvwDtgXFC1dJCOiy4A99txp/br3eSV7VZp3lAiaKFtnL
        8QcBwFeA5DUteNbCegc6hP/4EZ3hTsnIRWYjjXQ5KRjPckxwkrXVk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9EC3F2B756;
        Thu, 10 Aug 2023 15:56:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F23822B755;
        Thu, 10 Aug 2023 15:56:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4] send-email: prompt-dependent exit codes
References: <xmqqmsz1a547.fsf@gitster.g>
        <20230809171531.2564739-1-oswald.buddenhagen@gmx.de>
        <xmqqo7jgm3hd.fsf@gitster.g> <ZNS1VyGgtk9JmMe0@ugly>
Date:   Thu, 10 Aug 2023 12:56:31 -0700
In-Reply-To: <ZNS1VyGgtk9JmMe0@ugly> (Oswald Buddenhagen's message of "Thu, 10
        Aug 2023 12:00:55 +0200")
Message-ID: <xmqq5y5msmc0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0148237C-37B8-11EE-8496-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> fwiw, other users who noticed this problem most probably preempted it
> by adding appropriate --confirm=* and --suppress-* options. but this
> doesn't fit my use case of a "light" wrapper.

I have no problem with giving the command an option to allow it to
report if one or more messages were held back via its exit status.

Others may even want to know which ones among many messages weren't
sent, not just "there were some that weren't sent", to make it
easier to identify which ones to be resent after touching them up.

In any case, I consider such changes (including the "were there any
that weren't sent" bit) optional new features.

Thanks.

