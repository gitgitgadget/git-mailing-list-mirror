Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URI_TRY_3LD autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290BAC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 06:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE5C233EA
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 06:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbhAHGqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 01:46:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65275 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbhAHGqG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 01:46:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F54B106498;
        Fri,  8 Jan 2021 01:45:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bpBGuGAkcPSDiyf3J3PYF1+l/n8=; b=i8mweP
        O/zbWP/EGKz0I76vYm4LoYyVK1qEKvVNkwAjGVX5tpNRq4g1PFzEq7QnSReY9/9Z
        zB/Rkah8GldEx21ocsC+WzBKmJuFZIcNL/+sGUc55qaksaRStRHhj/PFxvLCOCZW
        CL++5IatxZHm70qqx8G6zgFRM2V7L2qh2vZvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W64tMwXARcBOO3/rzKJ9FVDYXktEnQEZ
        yquPIaxFnvia+/eij0PTWbIWO6TknuNtSLTD4CB9+O1v/vW4O91HhktX936FF+IA
        wj9rA3o2hMF+yytIm+Fuo8NTjNzpeRnAbtPeDX1KSVisuHLokDWKFFBNC/sRWW3I
        yJE2rBhdIHo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 566EB106497;
        Fri,  8 Jan 2021 01:45:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A3E9D106495;
        Fri,  8 Jan 2021 01:45:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Vasyl Vavrychuk <vvavrychuk@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] git-send-email.txt: mention less secure app access
 with Gmail
References: <4303fab303fb59b67b8fda036256ae61a528dfc1.1610079311.git.liu.denton@gmail.com>
Date:   Thu, 07 Jan 2021 22:45:20 -0800
In-Reply-To: <4303fab303fb59b67b8fda036256ae61a528dfc1.1610079311.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 7 Jan 2021 20:17:17 -0800")
Message-ID: <xmqq1rewj5a7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14372FB0-517D-11EB-AF6D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> From: Vasyl Vavrychuk <vvavrychuk@gmail.com>
>
> Google may have changed Gmail security and now less secure app access
> needs to be explicitly enabled if two-factor authentication is not in
> place, otherwise send-email fails with:
>
> 	5.7.8 Username and Password not accepted. Learn more at
> 	5.7.8  https://support.google.com/mail/?p=BadCredentials
>
> Document steps required to make this work.
>
> Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> [dl: Clean up commit message and incorporate suggestions into patch.]
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---

Thanks for tying loose ends.  Will replace.

> Range-diff against v3:
> 1:  274475559a ! 1:  4303fab303 git-send-email.txt: mention less secure app access with Gmail
>     @@
>       ## Metadata ##
>     -Author: Denton Liu <liu.denton@gmail.com>
>     +Author: Vasyl Vavrychuk <vvavrychuk@gmail.com>
>      
>       ## Commit message ##
>          git-send-email.txt: mention less secure app access with Gmail
>     @@ Commit message
>      
>          Document steps required to make this work.
>      
>     -    Original-patch-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
>     +    Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
>     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     +    [dl: Clean up commit message and incorporate suggestions into patch.]
>      
>       ## Documentation/git-send-email.txt ##
>      @@ Documentation/git-send-email.txt: edit ~/.gitconfig to specify your account settings:
>
>  Documentation/git-send-email.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 0a69810147..0db0783f2f 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -494,10 +494,14 @@ edit ~/.gitconfig to specify your account settings:
>  	smtpServerPort = 587
>  ----
>  
> -If you have multifactor authentication setup on your gmail account, you will
> +If you have multi-factor authentication set up on your Gmail account, you will
>  need to generate an app-specific password for use with 'git send-email'. Visit
>  https://security.google.com/settings/security/apppasswords to create it.
>  
> +If you do not have multi-factor authentication set up on your Gmail account,
> +you will need to allow less secure app access. Visit
> +https://myaccount.google.com/lesssecureapps to enable it.
> +
>  Once your commits are ready to be sent to the mailing list, run the
>  following commands:
