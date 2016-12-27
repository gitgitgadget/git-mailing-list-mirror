Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8D79200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 19:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756067AbcL0TJX (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 14:09:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52538 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754578AbcL0TJU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 14:09:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3D5F59A0D;
        Tue, 27 Dec 2016 14:09:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fKy9VW5q+BxvM1et9GL2d4EM0C4=; b=BxUfen
        C/jlCSfSWkfu0meWoQ7dMQrlthmKF9/PSravoMv9bQogpmfynPqYewDNF7t0VEzV
        ZIyLvrtUyCVXbc6S+c2k9d4cHeIw0Da/vCMyCDhc1GgOLbSlKZK3u1TdmzDlTmsO
        nHiNlRf+n1ajE5ASPIRP9XMYLYMGo6qb3RPyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mBUidYECAry426/1RNlRTO33WVdRQbEk
        T359ZsohFbE8P/JgZgcYhqbp4T+iwPM7rR+IS93cxvNDyyL8b5EqkPwZLkn8RkeZ
        EqvxPOb+1cES2mKmqqVH8yBaYpqfqIFfhDfaZBuvFQANwRUKGmFB9uoakvizWkgG
        LniIxuGMi1g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CBFBF59A0C;
        Tue, 27 Dec 2016 14:09:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C9B959A0B;
        Tue, 27 Dec 2016 14:09:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 12/21] Documentation/config: add splitIndex.maxPercentChange
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-13-chriscool@tuxfamily.org>
Date:   Tue, 27 Dec 2016 11:09:17 -0800
In-Reply-To: <20161226102222.17150-13-chriscool@tuxfamily.org> (Christian
        Couder's message of "Mon, 26 Dec 2016 11:22:13 +0100")
Message-ID: <xmqqlgv1b34y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F740F1DC-CC67-11E6-8E44-E98412518317-77302942!pb-smtp1.pobox.com
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
> index 221c5982c0..e0f5a77980 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2773,6 +2773,19 @@ showbranch.default::
>  	The default set of branches for linkgit:git-show-branch[1].
>  	See linkgit:git-show-branch[1].
>  
> +splitIndex.maxPercentChange::
> +	When the split index feature is used, this specifies the
> +	percent of entries the split index can contain compared to the
> +	whole number of entries in both the split index and the shared

s/whole/total/ to match the last sentence of this section, perhaps?
"The number of all entries" would also be OK, but "the whole number
of entries" sounds a bit strange.
