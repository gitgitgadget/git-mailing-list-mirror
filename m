Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289AB2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 17:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbcIORGZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 13:06:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55648 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751021AbcIORGX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 13:06:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5AC83D9B2;
        Thu, 15 Sep 2016 13:06:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f6wRrItHGU7O3WPORGW55Y0NTrE=; b=r4YCbT
        Qgc0a2DASSil6zK8FWn9bIjbu4IOIBB8n9aKxesDhF2ppFl0ZOVjpc3COS/xW044
        gqesKIquESZZWK8LVSnkfZvnWTHBR6k6HqbpSXvE67znTjvWv0gGRTCFAhiUSiwG
        fiNJJdMQi+VBYKyUEJzHilaY+SEfEB4iAxUOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lh/CuETxanofbZC8W9Qt4iINZnCuxMec
        wP08J5PTKakomqmW4BIsyNfnqx6SjLLhwVGSQVUi8n8I4uxye2XZvnbMmJD1rdXw
        zPH5CYU6iveb1gCWjtqLXNxKqddzIYzU5HpBCUu8+rqNIxRptp5c2wB3r4gYxfpr
        ryYwM0fn0B8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B59D63D9B1;
        Thu, 15 Sep 2016 13:06:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B47D3D9B0;
        Thu, 15 Sep 2016 13:06:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] Move format-patch base commit and prerequisites before email signature
References: <xmqqshtags0o.fsf@gitster.mtv.corp.google.com>
        <20160908185408.5qtfnztjbastlrtw@x>
        <20160908200819.pkg7jqcvxjpdqr3a@sigill.intra.peff.net>
        <xmqqd1kef5k5.fsf@gitster.mtv.corp.google.com>
        <xmqq7fakc12z.fsf@gitster.mtv.corp.google.com>
        <20160909200721.xfkbud377ja4wkrt@x>
        <xmqqpoocajbb.fsf@gitster.mtv.corp.google.com>
        <20160909210040.zlsczhcotrxnu4e4@x>
        <xmqq7fakai5k.fsf@gitster.mtv.corp.google.com>
        <xmqqmvjaozrz.fsf@gitster.mtv.corp.google.com>
        <20160914235231.GA12672@cloud>
Date:   Thu, 15 Sep 2016 10:06:19 -0700
In-Reply-To: <20160914235231.GA12672@cloud> (Josh Triplett's message of "Wed,
        14 Sep 2016 16:52:31 -0700")
Message-ID: <xmqqeg4lozxw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9A01C2E-7B66-11E6-ADD0-D68312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> I'd suggest squashing in an *additional* patch to the testsuite to
> ensure the presence of the blank line:

Thanks, will do.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 535857e..8d90a6e 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1515,8 +1515,9 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
>  
>  test_expect_success 'format-patch --base' '
>  	git checkout side &&
> -	git format-patch --stdout --base=HEAD~3 -1 | tail -n 6 >actual &&
> -	echo "base-commit: $(git rev-parse HEAD~3)" >expected &&
> +	git format-patch --stdout --base=HEAD~3 -1 | tail -n 7 >actual &&
> +	echo >expected &&
> +	echo "base-commit: $(git rev-parse HEAD~3)" >>expected &&
>  	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expected &&
>  	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expected &&
>  	signature >> expected &&
