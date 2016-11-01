Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4AB620229
	for <e@80x24.org>; Tue,  1 Nov 2016 19:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbcKATT0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 15:19:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63092 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752154AbcKATTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 15:19:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6780490BB;
        Tue,  1 Nov 2016 15:19:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F+pAJGWzw21xEzHUFtkxS2noC4E=; b=rPJcSk
        sAImdgpyZFDaicLuyyncdKPTd6tQosJHQpOVB5OTq+/vPeOu5ioMjzGhiBEmcCXX
        P4RfzJZlu1EYGj5Wl+7uTDcFnYL7XXU9iQa37MIbWZZ8IONkpRs01N8v0p/tPaEA
        yBqUmaBvAnR2IjRvCsmoQBn8WEHybwSOD5xDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pTfB7t0CP3uu9/Za7QEEAppDF2MICHee
        VFBVHGfMig2j6OfKbho+JBtK2GLJeU0ehErEPsKWLfmD/vu3h5cLEVSwGwZq3fln
        EmioCWm8vpXE1e2uvnqk6ZCWwMda/uRkQTBeb1loOV/UFkYmbBuCEvag9oSXvjpI
        5niX9oSSiO8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEBF2490BA;
        Tue,  1 Nov 2016 15:19:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 29ABB490B9;
        Tue,  1 Nov 2016 15:19:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 12/19] Documentation/config: add splitIndex.maxPercentChange
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
        <20161023092648.12086-13-chriscool@tuxfamily.org>
Date:   Tue, 01 Nov 2016 12:19:22 -0700
In-Reply-To: <20161023092648.12086-13-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 23 Oct 2016 11:26:41 +0200")
Message-ID: <xmqq8tt3ovnp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 193DDD30-A068-11E6-88D7-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/config.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 96521a4..380eeb8 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2763,6 +2763,19 @@ showbranch.default::
>  	The default set of branches for linkgit:git-show-branch[1].
>  	See linkgit:git-show-branch[1].
>  
> +splitIndex.maxPercentChange::
> +	When the split index feature is used, this specifies the
> +	percent of entries the split index can contain compared to the
> +	whole number of entries in both the split index and the shared
> +	index before a new shared index is written.
> +	The value should be between 0 and 100. If the value is 0 then
> +	a new shared index is always written, if it is 100 a new
> +	shared index is never written.

Hmph.  The early part of the description implies this will kick in
only when some other conditions (i.e. the bit in the index or the
other configuration) are met, but if this disables the split index
when it is set to 0, would we even need the other configuration
variable?  IOW, perhaps we can do without core.splitIndex?

> +	By default the value is 20, so a new shared index is written
> +	if the number of entries in the split index would be greater
> +	than 20 percent of the total number of entries.
> +	See linkgit:git-update-index[1].
