Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F571F597
	for <e@80x24.org>; Wed, 25 Jul 2018 16:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbeGYSKZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 14:10:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51458 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbeGYSKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 14:10:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so6158673wma.1
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=//4DnfEo8AbIf81mYT/KBlViXmgS7VbpCbzkLp5tvGk=;
        b=CXkS3oZhPX5MAEFJY6RmRDpl6LYCRrwLVkj7Fwnx18YBpl5VD/LTviY8M6l+IPPhQ8
         963K2iWsrHglFNPUzJo6zz34MXDZn1qHyBsfBEXWp/PHHjbgasxnSI4TCkkxg9mAM84M
         PY1Mh7IRXDQ4+SxJOKxI6g9ZJC3qsRwgxxp+5eljLrrjGA6ePxK6LMonGIF3U2AfK4nC
         za3UGLzwXOgy4G3MX6J+CcvWpcCeszGdsTvJ14eHIxHR4/YDX96vW8D4NvcG5oWMfJsj
         Ir46ILgIqb01ZdXTCXf2V16IBk8jhIBwArMH7N4U6WKwAeEZJz0AHun/APEYVS9MojrQ
         vsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=//4DnfEo8AbIf81mYT/KBlViXmgS7VbpCbzkLp5tvGk=;
        b=h+amTR+9I3AMAp16VE74sKUvjvjbqQ79hCqwinWtmv/ysBA+ZK8bFZagCk9fG0ue+J
         6o2KqqCJEKVL6F+fWJYWbqDVWAVFz7jXNhtRK0viosHrKKJfZy0AU9T/7Blh5eqpH5gr
         sVzdLoSLuhasvrYoU0ZDnuYAbRTXSS3QMzRFCf0Ush3yhQFNHI7f9TxkngHWviZ7g23p
         qAhhi+4P0Jyjg39qlgoDrO3gXJsHsLxBJc/lAhVr+Povyzy87AOgSDSpLtJXBrygqTvf
         3DSRckipubhTFIRS1OjUWtX4Q2nk01FBrezH1GEXYhLdr5oNpLO0NhcphqdL7SUOmZAd
         pXdQ==
X-Gm-Message-State: AOUpUlHSTkTcKEMduJIymspCFYzm1LOn0UnNECM5wc1zLyzunWjux15O
        R+42V50MfS127E0tGcRNA0o=
X-Google-Smtp-Source: AAOMgpeEqbCbEkjvKEclJ+UkLRKX3Ibt5JBqN7nwURALBfsbikGzHWbpNxH3oUUk9deOBEp5WQpO3Q==
X-Received: by 2002:a1c:888e:: with SMTP id k136-v6mr5381036wmd.6.1532537871235;
        Wed, 25 Jul 2018 09:57:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t70-v6sm6836229wmt.30.2018.07.25.09.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 09:57:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] Makefile: add a DEVOPTS flag to get pedantic compilation
References: <20180724171339.18983-1-dev+git@drbeat.li>
        <20180724192643.21505-1-dev+git@drbeat.li>
Date:   Wed, 25 Jul 2018 09:57:49 -0700
In-Reply-To: <20180724192643.21505-1-dev+git@drbeat.li> (Beat Bolli's message
        of "Tue, 24 Jul 2018 21:26:43 +0200")
Message-ID: <xmqqzhyfuub6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> In the interest of code hygiene, make it easier to compile Git with the
> flag -pedantic.
>
> Pure pedantic compilation with GCC 7.3 results in one warning per use of
> the translation macro `N_`:
>
>     warning: array initialized from parenthesized string constant [-Wpedantic]
>
> Therefore also disable the parenthesising of i18n strings with
> -DUSE_PARENS_AROUND_GETTEXT_N=0.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---

Hmph, what did you change between v3 and v4?

> diff --git a/Makefile b/Makefile
> index 0cb6590f24..2bfc051652 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -484,6 +484,12 @@ all::

The postimage of this hunk is supposed to be 11 lines long, as you
have five additional line in the middle of 6 original context lines.
Where did this 12 come from?  I am only interested in finding out if
our patch generation tool(s) have some bugs with this question.

If this is only because you hand-edit your patch, then we have no
tool breakage to worry about, but please refrain from doing so in
the future (instead always go back to the commit, amend it, and
re-run format-patch).

Thanks.

>  #        The DEVELOPER mode enables -Wextra with a few exceptions. By
>  #        setting this flag the exceptions are removed, and all of
>  #        -Wextra is used.
> +#
> +#    pedantic:
> +#
> +#        Enable -pedantic compilation. This also disables
> +#        USE_PARENS_AROUND_GETTEXT_N to produce only relevant warnings.
>  
>  GIT-VERSION-FILE: FORCE
>  	@$(SHELL_PATH) ./GIT-VERSION-GEN
