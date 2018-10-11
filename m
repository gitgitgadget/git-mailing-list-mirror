Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8978F1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 02:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeJKJmm (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 05:42:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38287 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKJmm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 05:42:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id a13-v6so7809908wrt.5
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 19:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Bqpgm+laIsvvkEYGNFFk4cakjfc5u9pRarB1PqbEar0=;
        b=spwaPRqcs/oz/OI2mJW7tsOJN9S7UfIPzCb+qmlBhOsqbu35o22nMcWfpSq0QJPI8r
         sK6JFj+I5d7DhTR+iHqOrUUvPLBXcCfjOmM33c/FwRQh6YZwuIoTScQ/K2LhE7d/fHpr
         0ow9uLkRBHG2UK5eD+y+Kkn/oTbhTXxqekytdMO7N940yQ00OymYOmH7jqojSoG4evZc
         hZPmnKXXyFiUQeOU0PdYUtNST1bwR74KII9GX6KlTu6k7rlxZc18m8bnRGwDcnlKTe4w
         OHNKNm/ulG1UGK21+WgGjMe7a3kO7+ptAMQWyjeuKXFCi58GLfNXfLA//Dnht46op3pR
         qk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Bqpgm+laIsvvkEYGNFFk4cakjfc5u9pRarB1PqbEar0=;
        b=rMV9ZjbMSwoM8PemwEytnji9D1+UB0FeeLB+x3cU2jAdg/y1W7Z4+9V2LWO83KB+Bl
         H+zletppXHTbiLkz9rQlpbIRcqNu6qmi/Nt8fQesaB6zNpJ17HndceXx7aK5+Ad52PX7
         HVlOhCbAS2heOwNnOhah6b9WBEWjzg0ji8vFxYlAz1erRbaCF0Xc5epW43eLL1KQte0K
         Nfa9mHcW2b93Uexvg0N6HSkblxy3ri3fEARJKvkAjO79ZEShr33oc3zsDV7zOS6MHJA5
         VY1Ezd40+kRZnbaKqiEuGcBYSXWQKNSHyVEkNjnU1esDmJhSO3tyt9q0p/lLX15msaBj
         SlsA==
X-Gm-Message-State: ABuFfog+qJECB0uE50IoO94kimTUSnBO3fT9K18+DnojlCXQiTHTxvuI
        JTIkFizVhQnn3mQBqRCQ5YGGI9Eik/c=
X-Google-Smtp-Source: ACcGV63IlDXUneIApRjSmIVWJxIotu6v3a/ZzJeM7muHHR1DF6VUSOaB4CzQ+S2Tf5iit0Oa6wCarg==
X-Received: by 2002:adf:da43:: with SMTP id r3-v6mr26089076wrl.221.1539224260764;
        Wed, 10 Oct 2018 19:17:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m136-v6sm11128337wmb.4.2018.10.10.19.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 19:17:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH] fixup! builtin rebase: support `--gpg-sign` option
References: <xmqqzhvlgref.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 11 Oct 2018 11:17:39 +0900
In-Reply-To: <xmqqzhvlgref.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 11 Oct 2018 11:15:36 +0900")
Message-ID: <xmqqva69grb0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Thu, 27 Sep 2018 14:48:17 +0200
>
> The `--gpg-sign` option takes an *optional* argument, not a mandatory
> one.
>
> This was discovered as part of the investigation of
> https://github.com/git-for-windows/git/issues/1836.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
>  * I am sending this out as I want to mimize the number of
>    non-trivial changes that come into my tree without hitting the
>    list archive.
>
>  builtin/rebase.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index a28bfbd62f..43bc6f7915 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1030,8 +1030,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "autosquash", &options.autosquash,
>  			 N_("move commits that begin with "
>  			    "squash!/fixup! under -i")),
> -		OPT_STRING('S', "gpg-sign", &gpg_sign,
> -			   N_("gpg-sign?"), N_("GPG-sign commits")),
> +		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
> +			N_("GPG-sign commits"),
> +			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },

This allows "--gpg-sign" in addition to "--gpg-sign=ARG" and stores
an empty string in place of ARG when accepting the option without
arg.  

The result in gpg_sign is used by checking if the pointer is
non-NULL and formatted with xstrfmt("-S%s", gpg_sign).

The change looks correct; will squash into what has been queued on
'pu'.

Thanks.

>  		OPT_STRING_LIST(0, "whitespace", &whitespace,
>  				N_("whitespace"), N_("passed to 'git apply'")),
>  		OPT_SET_INT('C', 0, &opt_c, N_("passed to 'git apply'"),
