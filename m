Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AA6C433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6880920702
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q0H/nyso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHTX5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:57:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57822 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgHTX50 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 19:57:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D9DE0DA01F;
        Thu, 20 Aug 2020 19:57:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cngq6aqoSZcjHBggu5GQsdDRJ/E=; b=Q0H/ny
        sod/DQr+vYg5c/OkdnBvtZRt/emY6wW5n0oVJlRX4SV7GAhkUMtg2iTJYKsnRvAn
        J1ggqp0CC2qvGGPpPT4w15xPLM+SKY2XyoWYh3kkvlNJG4EhBz4SSx1ImEz0ve+p
        aT1lcxWHQJ1Su/foN+mMmnpTOLmoARY+AHgjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=anI8aw5B50NWLPonSUzI8q+Q3g3dbTh1
        dHNqtcwYGK/CXXOIpfNCUauhyvu5HoiCPdyHvp/ya4Y+Go2l+njzCEZnkIkoi9QD
        7YBWV+sb7tAt/glIJvLW7Z3Bxc0a5iZecsQkJojlj8rZjQwCzzPgLfNmqwGLQh2g
        tK6EmSvLAzM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF4B1DA01E;
        Thu, 20 Aug 2020 19:57:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 056E6DA01D;
        Thu, 20 Aug 2020 19:57:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] git-apply.txt: update descriptions of --cached, --index
References: <20200820231051.85134-1-ray@ameretat.dev>
Date:   Thu, 20 Aug 2020 16:57:19 -0700
In-Reply-To: <20200820231051.85134-1-ray@ameretat.dev> (Raymond E. Pasco's
        message of "Thu, 20 Aug 2020 19:10:51 -0400")
Message-ID: <xmqq4kowc1ls.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2C7E258-E340-11EA-A99C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> The blurb for "--cached" says it implies "--index", but in reality
> "--cached" and "--index" are distinct modes with different behavior.
>
> Additionally, the descriptions of "--index" and "--cached" are somewhat
> unclear about what might be modified, and what "--index" looks for to
> determine that the index and working copy "match".
>
> Rewrite the blurbs for both options for clarity and accuracy.
>
> Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
> ---
> How's this for an updated wording?

s/blurbs?/description/

>  Documentation/git-apply.txt | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index b9aa39000f..91d9a8601c 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -61,18 +61,18 @@ OPTIONS
>  	file and detects errors.  Turns off "apply".
>  
>  --index::
> -	When `--check` is in effect, or when applying the patch
> -	(which is the default when none of the options that
> -	disables it is in effect), make sure the patch is
> -	applicable to what the current index file records.  If
> -	the file to be patched in the working tree is not
> -	up to date, it is flagged as an error.  This flag also
> -	causes the index file to be updated.
> +	Apply the patch to both the index and the working tree (or
> +	merely check that it would apply cleanly to both if `--check` is
> +	in effect). Note that `--index` expects index entries and
> +	working tree copies for relevant paths to be identical (their
> +	contents and metadata such as file mode must match), and will
> +	raise an error if they are not, even if the patch would apply
> +	cleanly to both the index and the working tree in isolation.

I do not see why we want to stress the last part after ", even if".
The safety mechanism insists on the working tree file and the index
entry to be identical, and the location where in the file the
difference is, is irrelevant, whether it is outside the area the
incoming patch touches, or it overlaps.

I however am OK if your thrust is to stress the fact that the paths
must be up to date.  I think we can do so by making that the first
thing readers would read about the option, e.g.

	After making sure the paths the patch touches in the working
	tree are up to date (i.e. have no modifications relative to
	their index entries), apply the patch both to the index
	entries and to the working tree files (or see if it applies
	cleanly, when `--check` is in effect).

>  --cached::
> -	Apply a patch without touching the working tree. Instead take the
> -	cached data, apply the patch, and store the result in the index
> -	without using the working tree. This implies `--index`.
> +	Apply the patch to just the index, without touching the working
> +	tree. If `--check` is in effect, merely check that it would
> +	apply cleanly to the index entry.

This side looks good.

Thanks.
