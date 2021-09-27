Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E18C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 19:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F190F60F94
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 19:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbhI0Tp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 15:45:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51442 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbhI0Tp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 15:45:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D7E2157D51;
        Mon, 27 Sep 2021 15:44:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SAYJNcGpcm1HnMv8UnNpgSHUwDuJexkFg05LBV
        uKajk=; b=BfiG6GzvhFiSOnmWe8gZIA4zWaLvBYyMLRK0Y59wshM0wcKP9juy1H
        E0FXLEXtcAskOVAoR/DgvydiCmQQE5WgIYRz8XZaqba1KqZO0scMAmuCoryjleMT
        uJZA8gOPfb4uykQTLXINDqpdQFN9lWdwoWm7QOEoBicTu4ft27+rs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 265BB157D50;
        Mon, 27 Sep 2021 15:44:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8DF6D157D4D;
        Mon, 27 Sep 2021 15:44:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     "Dr. Matthias St. Pierre" <Matthias.St.Pierre@ncp-e.com>,
        git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] blame: document --color-* options
References: <d918fe0de6b04d8d848050d4aedbe060@ncp-e.com>
        <20210925121817.1089897-1-bagasdotme@gmail.com>
Date:   Mon, 27 Sep 2021 12:44:14 -0700
In-Reply-To: <20210925121817.1089897-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Sat, 25 Sep 2021 19:18:18 +0700")
Message-ID: <xmqq5yulregh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C06BAD8-1FCB-11EC-9B20-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index 117f4cf806..b15999a3c8 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -136,5 +136,13 @@ take effect.
>  	option.  An empty file name, `""`, will clear the list of revs from
>  	previously processed files.
>  
> +--color-lines::
> +	Color lines that contain repeated metadata. The color used is set with
> +	`color.blame.repeatedLines` config option.
> +
> +--color-by-age::
> +	Color metadata depending on age of the line. `color.blame.highlightRecent`
> +	config option controls what color is used for each range of age.

Nowhere in "git blame --help" output we mention anything about
"metadata", so the readers of this new description will be left
puzzled what the word means in the context of this command.

We would need to pick words or phrases that readers can link easily
with the description of "THE PORCELAIN FORMAT" section.

Thanks.
