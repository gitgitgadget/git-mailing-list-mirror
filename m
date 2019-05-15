Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09D891F461
	for <e@80x24.org>; Wed, 15 May 2019 05:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfEOFgF (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 01:36:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55103 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfEOFgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 01:36:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD5A51447B0;
        Wed, 15 May 2019 01:35:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sMW31Z279D3dSh71Cb8uX0uUh7Y=; b=QPoNhf
        QLUYgLJHJWIGASULBWNa0fsX4T+Sm0pJBAfLqJ0Nn8S6QVDDKQuIXGOyXPoP1h3c
        WjkdR6u26pmwu2Q/3T2tyVEkwhqfaPweC55xLUmCgZT+P6UIhMvVF3XOVJ433uiS
        Sgd4sL9PEu8EZFYu371nJAOWVd5K44FQyI5pQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ROzAfMLHjSjHJiQsbQdmTNAyTwANbAMM
        5lxPbJ3fOr6B1xzT8fmill1y2VC3T0/7gVq+PUFfHT/iPQapX3bVFJk1CBn9/yVS
        1SiJZJmxjyMtZGWqsOvlEwVPx5JbyfnBJQwNmE663dB04LzSSdFPPmkEjrMeEV67
        Lr37QarB2S8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4AEC1447AF;
        Wed, 15 May 2019 01:35:59 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F3371447AE;
        Wed, 15 May 2019 01:35:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Boxuan Li <liboxuan@connect.hku.hk>
Cc:     git@vger.kernel.org, avarab@gmail.com, philipoakley@iee.org
Subject: Re: [PATCH v3] userdiff.c & doc/gitattributes.txt: add Octave
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
        <20190511041331.51642-1-liboxuan@connect.hku.hk>
Date:   Wed, 15 May 2019 14:35:58 +0900
In-Reply-To: <20190511041331.51642-1-liboxuan@connect.hku.hk> (Boxuan Li's
        message of "Sat, 11 May 2019 12:13:31 +0800")
Message-ID: <xmqq4l5w7001.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51A46D62-76D3-11E9-8A4F-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Boxuan Li <liboxuan@connect.hku.hk> writes:

> Octave pattern is almost the same as matlab. Besides,
> octave also uses '%%%' or '##' to begin code sections.

My reading of the above hiccupped at around "Besides, octave also
uses...".

Checking the differences in patterns, I think

	... the same as matlab, except that '%%%' and '##' can also
	be used to begin code sections, in addition to '%%' that is
	understood by both.

may be easier to read. It makes it clear that you'd want to stay
away from %%% and ## if you want to be compatible.

Thanks.

> Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> ---
> Update from v2: fix indentation
> ---
>  Documentation/gitattributes.txt | 2 ++
>  userdiff.c                      | 5 +++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 4fb20cd0e9..45374c7dd3 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -821,6 +821,8 @@ patterns are available:
>  
>  - `matlab` suitable for source code in the MATLAB language.
>  
> +- `octave` suitable for source code in the Octave language.
> +
>  - `objc` suitable for source code in the Objective-C language.
>  
>  - `pascal` suitable for source code in the Pascal/Delphi language.
> diff --git a/userdiff.c b/userdiff.c
> index 3a78fbf504..7d07b82116 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -60,6 +60,11 @@ PATTERNS("java",
>  PATTERNS("matlab",
>  	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",
>  	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
> +PATTERNS("octave",
> +	 /* Mostly the same as matlab. In addition, Octave
> +	  * supports '##' and '%%%' for code sections */
> +	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^(%%%?|##)[[:space:]].*$",
> +	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
>  PATTERNS("objc",
>  	 /* Negate C statements that can look like functions */
>  	 "!^[ \t]*(do|for|if|else|return|switch|while)\n"
