Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034F41F453
	for <e@80x24.org>; Thu,  7 Feb 2019 20:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfBGUFq (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 15:05:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35670 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGUFq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 15:05:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id z18so1253273wrh.2
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 12:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=as3slEebjMv8Uo66ldwhGGb8MmVmZ3eFb0PPeQPzT1Q=;
        b=emXv0LS83iXdZ644PqrjV4LS0E6QJH4hPVgDGpsTTJlR3VkFE+kh2T2quKmAqSYool
         VvJn3b7t6rFLdbM34ptXdYucV9hrcYpHsK2pCMiSvroha/LtViZjyhWI0aKEbjlQ0u+7
         V/e8sTvthIl+5g2QjyZoV5/4e3+Bs0MYQK6QIeGYZOUJiMPO4UyxSnvhSVfGkwr1omNp
         wFAZXo1Ij+jJhrS6yLxgmIxbsSNJk9A3qVVMJ0/M0MeyPixxxrp3YIlj6qsZz27BD3Lt
         ZER0OwtZH7NeoM7kNuoDOCvAm2P3boxhNkT/LeU96Rp9JUfbwGT15M60blav1PIxcvNc
         n5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=as3slEebjMv8Uo66ldwhGGb8MmVmZ3eFb0PPeQPzT1Q=;
        b=iNCp/F5/CIQctXxH/X3VqezS4qoTBPzElVrCaVigvNyUF2hh//t5ZgyKaPrdt3W3l/
         LDXzjwl8lJi7/H9K6ySHVFIQpz6j/vdeUehibf8A2tPwDOoLf/tkM3K7ollUN+esk12z
         WR/4ACHHDQ5rm7jlfsUeoVavLHz6UGOW+zYyWIHjvLIZGNHnsXnEL5/EmG7V519GaCjn
         Pb6OORRiS5dtDnso1iLB6mnNeJeJPCMzKCYoe6ZSfvic90nB+R6Ow7RtrpwV/N+VaU2y
         OTI4Y4T/3QYLTAEsDbGSbajJC/NGG8z645Ak7MzDN3B0CncoHfwOr2ut/WTriDMK8/iF
         Ta2w==
X-Gm-Message-State: AHQUAuZ3qjJ5z3Puhkj6hmslEJLXYg/FKZ/lkF7gWYYawJmhcdTtkWoC
        joM2sKDhSu3IRpx4YGxH25k=
X-Google-Smtp-Source: AHgI3IaEFH6SC+q62CGTsTwUd+JJnvm2frQx9ZBaumeEdeXGmr0OmFEGOq/YBav+2U0aIkFbu7oOGg==
X-Received: by 2002:adf:c5cc:: with SMTP id v12mr13212554wrg.176.1549569943470;
        Thu, 07 Feb 2019 12:05:43 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k4sm16279266wrp.8.2019.02.07.12.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 12:05:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] submodule--helper: teach config subcommand --unset
References: <cover.1549521103.git.liu.denton@gmail.com>
        <cover.1549534460.git.liu.denton@gmail.com>
        <e90dfe992e96b33f167d08fe51df49ab1d10ef23.1549534460.git.liu.denton@gmail.com>
Date:   Thu, 07 Feb 2019 12:05:42 -0800
In-Reply-To: <e90dfe992e96b33f167d08fe51df49ab1d10ef23.1549534460.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 7 Feb 2019 02:18:57 -0800")
Message-ID: <xmqqmun7nz3d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This teaches submodule--helper config the --unset option, which removes
> the specified configuration key from the .gitmodule file.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  builtin/submodule--helper.c | 18 ++++++++++++------
>  t/t7411-submodule-config.sh |  9 +++++++++
>  2 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b80fc4ba3d..a86eacf167 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2148,17 +2148,22 @@ static int check_name(int argc, const char **argv, const char *prefix)
>  static int module_config(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> -		CHECK_WRITEABLE = 1
> -	} command = 0;
> +		NONE,
> +		CHECK_WRITEABLE,
> +		DO_UNSET
> +	} command = NONE;

I do not think the above, except for addition of DO_UNSET, is a good
change.  The language spec may guarantee that NONE is 0, but in the
way the original is written, it is much more obvious that integer
zero is a special value and the variable is initialized to that
special value, and that is important.  The above rewrite makes it
look as if there are a bunch of symbolic constants defined by this
particular caller and one random value NONE, whose only significance
is that it is different from any other value, is picked as its
initial value---but that is a wrong impression to give to the
readers.  parse-options.c::get_value() special cases integer zero as
"unset" for any CMDMODE, so inventing a symbolic constant used by
this particular user is counter-productive.  Needless to say, it is
not such a great idea to use such an overly generic word NONE here.

The way the original did to make sure all enum values are non-zero
(by explicitly documenting that its first value is 1) and used
literal 0 as "not specified" is much better aligned to the way how
OPT_CMDMODE() is to be used, I think.

>  
>  	struct option module_config_options[] = {
>  		OPT_CMDMODE(0, "check-writeable", &command,
>  			    N_("check if it is safe to write to the .gitmodules file"),
>  			    CHECK_WRITEABLE),
> +		OPT_CMDMODE(0, "unset", &command,
> +			    N_("unset the config in the .gitmodules file"),
> +			    DO_UNSET),
>  		OPT_END()
>  	};
>  	const char *const git_submodule_helper_usage[] = {
> -		N_("git submodule--helper config name [value]"),
> +		N_("git submodule--helper config name [--unset] [value]"),

That gives an impression that "config name --unset value" is a valid
input; isn't it more like "you can unset, or you can set to a
value"?  The way to spell it would be "... config name [--unset | value]"
but it raises a larger question.  What if you want to set to a value
that is a string "--unset"?  Actually, allowing an option that comes
after "name" (which is an arbitrary end-user supplied thing) is one
thing, but writing it in the documentation as if we are encouraging
it is probably not a good idea.  Shouldn't it be "config --unset name"?

In any case, seeing the new test in 7411, I think the best way to
write the above usage text would be to add one new line without
mucking with the existing "show it, or set it to the given value"
and add

	git submodule--helper config --unset name

as a separate item to the list.

> diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
> index 89690b7adb..fcc0fb82d8 100755
> --- a/t/t7411-submodule-config.sh
> +++ b/t/t7411-submodule-config.sh
> @@ -142,6 +142,15 @@ test_expect_success 'reading submodules config from the working tree with "submo
>  	)
>  '
>  
> +test_expect_success 'unsetting submodules config from the working tree with "submodule--helper config --unset"' '
> +	(cd super &&
> +		git submodule--helper config --unset submodule.submodule.url &&
> +		git submodule--helper config submodule.submodule.url >actual &&
