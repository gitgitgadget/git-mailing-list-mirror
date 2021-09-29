Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DA0C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 19:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59ABD61529
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 19:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346532AbhI2TRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 15:17:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53892 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344094AbhI2TRO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 15:17:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C8143153195;
        Wed, 29 Sep 2021 15:15:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iCuoNwB5uPsr7GESdR/w3Lilv6l6O6m6+Am+xl
        j06Vw=; b=X6HXVMUQiLh3Rz1Ci4bjwLCfxGrrFQqboRK55LO3f17AwaWSpj7Lh5
        ceDk36JOx2mjBZ4IenSmwKVdCBk0WaDZEMdugdQ/2pQuZwiSEkKhzjN62DffOpVP
        PtVGmuOIavQhvHDan/D1HHvH/GulC26D1pbldFfhbdYCPeozhqsrY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE0AE153193;
        Wed, 29 Sep 2021 15:15:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 17E99153191;
        Wed, 29 Sep 2021 15:15:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org,
        "Dr . Matthias St . Pierre" <Matthias.St.Pierre@ncp-e.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>
Subject: Re: [PATCH v2 2/2] blame: document --color-* options
References: <20210929124935.41917-1-bagasdotme@gmail.com>
        <20210929124935.41917-3-bagasdotme@gmail.com>
Date:   Wed, 29 Sep 2021 12:15:29 -0700
In-Reply-To: <20210929124935.41917-3-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Wed, 29 Sep 2021 19:49:35 +0700")
Message-ID: <xmqq35pndwha.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C61E5CC-2159-11EC-A4B7-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Commit cdc2d5f11f1a (builtin/blame: dim uninteresting metadata lines,
> 2018-04-23) and 25d5f52901f0 (builtin/blame: highlight recently changed
> lines, 2018-04-23) introduce --color-lines and --color-by-age options to
> git blame, respectively. While both options are mentioned in usage help,
> they aren't documented in git-blame(1). Document them.
>
> Co-authored-by: Dr. Matthias St. Pierre <m.st.pierre@ncp-e.com>
> Signed-off-by: Dr. Matthias St. Pierre <m.st.pierre@ncp-e.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/blame-options.txt | 12 ++++++++++++
>  Documentation/config/color.txt  | 12 ++++++------
>  Documentation/git-blame.txt     |  4 ++--
>  3 files changed, 20 insertions(+), 8 deletions(-)

Nicely written.

> +--color-lines::
> +	Color lines differently, if they belong to the same commit as the preceding line.

Is "belong" the right verb?  I view these lines "come from" their
originating commits, so "they belong to" -> "they come from",
perhaps.

>  color.blame.repeatedLines::
> -	Use the customized color for the part of git-blame output that
> -	is repeated meta information per line (such as commit id,
> -	author name, date and timezone). Defaults to cyan.
> +	Use the specified color to colorize line annotations, if they belong to the

Ditto.

Thanks.
