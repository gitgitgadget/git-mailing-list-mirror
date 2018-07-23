Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FEE7208E8
	for <e@80x24.org>; Mon, 23 Jul 2018 18:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbeGWT4Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:56:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37263 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388038AbeGWT4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:56:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so1719327wrd.4
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SEXGXD5qc/VpYnQ1WM0/nttKfgrbFYKWO40CQx3Uw44=;
        b=sVWTBohq8m0JOCKQf3pN5Km7kHbVGW0I5i8+snpfd0U00stRW+secertGAv0gVy2/r
         ajNJbLhMoEZG5CJFrSOTgoo6W+CqIGRhYPwkxqA9lRPkmhTiOdY25z3+sm+ohz7gcooq
         JganXsiITMi2lZwfaKbXES7r0Qssa59illUK+2eHaVC6vhRUp8NR4GuaaKNLvYMlViM0
         2OTAK9S2pfcDGQH7QKA2zjzoWP7MHkTkAsFZNKxKiuOAiavZEpr7Nlda4o5hFung2VyY
         aMvLq5Ox1T2CEqKVgZUZvuA0L7OA7pJpBp/YStTNDEJql8h2CPYn93hKvcm3qLnJLInF
         D1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SEXGXD5qc/VpYnQ1WM0/nttKfgrbFYKWO40CQx3Uw44=;
        b=iiPE8E0TktNsPocdxdvEBFlcatl/GeWnPfdig4zFdaNLQeNSEvefei2FFOXaY7AGme
         yBMAlEK6CafhysjMFvQrUYT524LzwIaxJIing5Haop10yk9JchGhg0O0R3uS+RGg1nV/
         /niNsUNUAEBoiiOU5S1pSwDhUFRIIJ8II2Zn0LiBy4bEx3MZ54d4dJ58d2Oaq7thxRGw
         F3IfXDU5aDrncRu8X+O3olhZ+sIDQWQngWCzSX5mBGCCN3PhAcSKrZSrA1V/BCVJ9Bj/
         G+3SXnYNECOvFegMGgXvXJxxs2BNlYfsWa6HiO9N2HpluuaAVxj2AsjJPU1ZcSJAR7fk
         uOOw==
X-Gm-Message-State: AOUpUlHZPSKaXc3wK51vLeFZeAJV3qY6s1zLGGP9pyqdj9wNJm/Ktxgu
        CfPeB94sIEG5RKOKvUzU8cQ=
X-Google-Smtp-Source: AAOMgpc00trlRLZyvKWZzyRTjO46adjFW3ziXfmWvR65uBw/7Vn+4z33a3P1cRQFf/2zVdhVdwa05g==
X-Received: by 2002:a5d:6a03:: with SMTP id m3-v6mr9126254wru.192.1532372020718;
        Mon, 23 Jul 2018 11:53:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v5-v6sm10774535wrp.87.2018.07.23.11.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 11:53:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] Makefile: add a DEVOPTS flag to get pedantic compilation
References: <20180721203647.2619-1-dev+git@drbeat.li>
Date:   Mon, 23 Jul 2018 11:53:39 -0700
In-Reply-To: <20180721203647.2619-1-dev+git@drbeat.li> (Beat Bolli's message
        of "Sat, 21 Jul 2018 22:36:47 +0200")
Message-ID: <xmqqva956ax8.fsf@gitster-ct.c.googlers.com>
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
> -DUSE_PARENS_AROUND_GETTEXT_N=no.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>
> This is the convenience knob for all developers that led to the series
> bb/pedantic[1]. It does not depend on this series, though.

Yup, but "make DEVELOPER=Yes" build won't pass unless this patch is
queued after those clean-up ;-)

Remind me if I forget to tweak =no back to =0 before pushing the
result out.

Thanks.

> [1] https://public-inbox.org/git/20180708144342.11922-1-dev+git@drbeat.li/T/#u
>
>  Makefile       | 6 ++++++
>  config.mak.dev | 5 +++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 0cb6590f24..2bfc051652 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -484,6 +484,12 @@ all::
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
> diff --git a/config.mak.dev b/config.mak.dev
> index 2d244ca470..e11dd94741 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -1,6 +1,11 @@
>  ifeq ($(filter no-error,$(DEVOPTS)),)
>  CFLAGS += -Werror
>  endif
> +ifneq ($(filter pedantic,$(DEVOPTS)),)
> +CFLAGS += -pedantic
> +# don't warn for each N_ use
> +CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=no
> +endif
>  CFLAGS += -Wdeclaration-after-statement
>  CFLAGS += -Wno-format-zero-length
>  CFLAGS += -Wold-style-definition
