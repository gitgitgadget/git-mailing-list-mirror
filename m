Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA079C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbiGSSY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiGSSY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:24:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA355C9EF
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:24:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7DF9119BE76;
        Tue, 19 Jul 2022 14:24:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rXVx1vwSMuqlGtavW2G3ztjuAcjwyMfqY/Z3hq
        kVHTs=; b=dJoOGbqFzOE5bdLW+sW4VqhuuznUYkUPadG72KFZPP1iB3kZrU49NR
        jRitInMHoVUrankiiyO5qYhLvYoVYkpkTDPVS+S/L7h34MHlij1HlP9tzWA84NtY
        nf0SwTsqq8H37OyKF8/W62j5zWiXt7Pwf0OWhFH7SmcSxvgxS0uyk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7673E19BE75;
        Tue, 19 Jul 2022 14:24:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C160A19BE72;
        Tue, 19 Jul 2022 14:24:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH] osx-keychain: fix compiler warning
References: <pull.1293.git.1658251503775.gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 11:24:50 -0700
In-Reply-To: <pull.1293.git.1658251503775.gitgitgadget@gmail.com> (Lessley
        Dennington via GitGitGadget's message of "Tue, 19 Jul 2022 17:25:03
        +0000")
Message-ID: <xmqq8roparkd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14725976-0790-11ED-A33A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Update git-credential-osxkeychain.c to remove 'format string is not a string
> literal (potentially insecure)' compiler warning by treating the string as
> an argument.
>
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---

Perfect.  Thanks.  Will queue.

> @@ -168,7 +168,7 @@ int main(int argc, const char **argv)
>  		"usage: git credential-osxkeychain <get|store|erase>";
>  
>  	if (!argv[1])
> -		die(usage);
> +		die("%s", usage);
>  
>  	read_credential();
>  
>
> base-commit: 71a8fab31b70c417e8f5b5f716581f89955a7082
