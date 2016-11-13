Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957AE2021E
	for <e@80x24.org>; Sun, 13 Nov 2016 01:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932187AbcKMBXb (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 20:23:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56725 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932127AbcKMBXa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 20:23:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1DC34E60D;
        Sat, 12 Nov 2016 20:23:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yMYHjqAZftTinTPSsl+SxJvfvJw=; b=Dyvi/c
        4MAitqSoi+QxP/6CVmKVEYbEtSuQTFz6F7AwCiSPx37MKDtD291A4/1GupN7tqdF
        ix9ryJoz1zI+3yewLaYH4UNAMCFsH8irKaKoTvMAeAsp7KSyog1dtmewjUpUyWGB
        jVIKe1lXd966bvgQom+5lmUfTvtP0wXUHYO6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FVcaJUnFdkNHLGuiNLfNtWN66z2tKiL9
        3C5JnoJsYsBTSNgQfvC3PR0Slhpir2viVXphCGOqqnt/IH9SuQ1/qXMYUTEm4ivG
        ubG7fIIy9hT0D7svTR7LBpmm6rS6rPkxg8mRE5Ohf05UTKeJNkTFmH1GevlKsYuN
        JwecuX1BNDI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA4D44E60C;
        Sat, 12 Nov 2016 20:23:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5759C4E60B;
        Sat, 12 Nov 2016 20:23:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, spearce@spearce.org
Subject: Re: [PATCH v2] upload-pack: Optionally allow fetching any sha1
References: <1478885028-30357-1-git-send-email-dturner@twosigma.com>
Date:   Sat, 12 Nov 2016 17:23:27 -0800
In-Reply-To: <1478885028-30357-1-git-send-email-dturner@twosigma.com> (David
        Turner's message of "Fri, 11 Nov 2016 12:23:48 -0500")
Message-ID: <xmqqpom0yxyo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7EEFECE-A93F-11E6-90B4-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 43665ab..8d3db40 100755

It seems that I haven't heard of 43665ab.

> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -306,6 +306,28 @@ test_expect_success 'test allowreachablesha1inwant with unreachable' '
>  	test_must_fail git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
>  '

Specifically, the above seems to be missing in my tree.

Perhaps you noticed the lack of test for allowReachableSHA1InWant
and added one, but forgot to send it out, while building this patch
on top?

> +uploadpack.allowAnySHA1InWant::
> +	Allow `upload-pack` to accept a fetch request that asks for any
> +	object at all.
> +	Defaults to `false`.

