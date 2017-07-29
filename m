Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63AB2089D
	for <e@80x24.org>; Sat, 29 Jul 2017 03:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbdG2D5m (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 23:57:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57881 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753403AbdG2D5l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 23:57:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 665459EF74;
        Fri, 28 Jul 2017 23:57:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4oGuydxBlUfB
        vjFhsFMUPnJ+ymI=; b=uw/ZQVF6VrHTYUz/gaQ15Vku0axaFKj7ypkOff62Litv
        cZTxM5lUiCiDkyPoE5GkRoC9GctXUT0KGaKUVenLSf1rRNo5npbtqc1WPSQutjee
        CUhJYfty0zWUJwfSUC2E86UTWylRXw88T2FPCfL3+Gi4M8XAUx23ZYwD7jbEUVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cFVeYz
        ONyAAUTLOJcbajWXpKVUryd8HvJQ/DxXZF+DL9ivQdJQlu3e1lHwykI4qVddevRw
        ajLQyzncs7QafaGYYt36sL3Gpz4KMxzQAlD9nqOm4qTgXdMZIVHgc7OllFFsxO++
        KzBC8ec0hnCRrwsbllaC4DoBaIEu0IIS/JtBs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DBC19EF73;
        Fri, 28 Jul 2017 23:57:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7FA19EF72;
        Fri, 28 Jul 2017 23:57:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Guidlines for error messages
References: <1501297078.2711.2.camel@gmail.com>
Date:   Fri, 28 Jul 2017 20:57:38 -0700
In-Reply-To: <1501297078.2711.2.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sat, 29 Jul 2017 08:27:58 +0530")
Message-ID: <xmqqa83nlwst.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 10C571DA-7412-11E7-8F30-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> On reading the CodingGuidelines, I saw a section that specifies rules
> about the structure ...
> ...
>     That makes me wonder, has the guideline changed ?
>     Is this something that must be fixed=C2=A0?
>     Am I missing something ?

This applies not just to the message format but with ANY guideline
we have around here.

As we did not have perfect foresight when we started the project,
the guidelines grew out of the best practice we learned over time.
We try to catch violations for new code during the review process,
so that we won't add violators, but we do _not_ actively hunt for
existing violators and change them _only_ to fix them, which is
unneeded code churn.  Instead, over time as people notice, most
often while doing a real work in the vicinity of the code that has
violations, we fix them as preparatory clean-up patches before the
real work happens.
