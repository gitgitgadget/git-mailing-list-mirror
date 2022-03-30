Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B927EC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 12:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbiC3Mro (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 08:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345641AbiC3MrI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 08:47:08 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDC42180A
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 05:43:53 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id k125so16490779qkf.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OZKInu7Jod1PU6axU6LCsL2VNX5aN5HA2MoKYMraOYc=;
        b=MKhwtVWaFX3QKx/RtyPvD44htgiDFV9QQ8BoRLj8sqLr2SBtTMhN6j8dpnKHqfb1Eg
         TvgPkdyNzdjvBNRR1xus/EsJ+ei9RGZ2n7NuVxN1El3kmt9gST0KfW0le0dd+2VyUNA+
         FbDuzMYIXBr1bKJ7kmdE9BGCSNJFdRQB/6ysXHPmgw7ZxIDLfDS+fngLI8FsNWHPag4R
         gQxpgelnoDYkWyl7mBbbZ0pRqSZm1hijNmZAi1zRn281JQqg7nYRcE19pb8KCQiVqAGW
         QfK2ErpjlSj3dYaekp2AE13/njQoNnHwSP4SV2niPE5BgvZPul7ABaV+BI10OdZucxie
         Ulkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OZKInu7Jod1PU6axU6LCsL2VNX5aN5HA2MoKYMraOYc=;
        b=kTuo44VK7PU/i8b63FbuRfU2mFsQowx4BWK2Rb/0+m8h1PHZBrPPAB8fi0J5pH6tN7
         bIUqlIXqKQQ+CFlRF0AQR7yyNc+ZuMUHSZXUbkf04cBS7QVbziB6GLQW5/tg46wu1EfZ
         xfIxnZ0c3hhMGPdI5RVAEBa2WCUvPyCN750ed+3zbaIW0fhZ9NkKZDAm1Vc/PkmwjsP1
         bZOh5fddoGDN/qitKmPl/+Pay5u/RD3L9PTn+oi8TEIZAd/xqw3tJOkZWBD1ZxiSWORa
         sAsaQciihdSaPX0rXnvzqo/x03fTWydapwCYNkaNTQRvghwV6h5LqflwFdKrQCehi0Ph
         G5Ng==
X-Gm-Message-State: AOAM530iZYuD5lR3+e1IH6MWvej048ba8ZdGGNv0bMQY+ChaKzWGuP7e
        O+xKK1OkpCUsxlDF/JD/R+E=
X-Google-Smtp-Source: ABdhPJz5s9bd86+5Bntl+VfNcAnrCEw1/ks6VyTrnR0UFHUSPhoWINXN4xkn1qnkoMlgqYgAV/GmTQ==
X-Received: by 2002:a05:620a:284b:b0:67d:1ce7:328b with SMTP id h11-20020a05620a284b00b0067d1ce7328bmr23935196qkp.312.1648644232655;
        Wed, 30 Mar 2022 05:43:52 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id h6-20020ac85e06000000b002e1e8a98abbsm17908014qtx.41.2022.03.30.05.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 05:43:52 -0700 (PDT)
Subject: Re: [PATCH v8 5/5] mergetools: add tools description to `git help
 config`
To:     Fernando Ramos <greenfoo@u92.eu>, git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, rogi@skylittlesystem.org, bagasdotme@gmail.com
References: <20220328223019.271270-1-greenfoo@u92.eu>
 <20220329224439.290948-1-greenfoo@u92.eu>
 <20220329224439.290948-6-greenfoo@u92.eu>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <da6472b4-65e6-a3ca-8d8b-892afb6f0fac@gmail.com>
Date:   Wed, 30 Mar 2022 08:43:50 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220329224439.290948-6-greenfoo@u92.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Fernando,

Le 2022-03-29 à 18:44, Fernando Ramos a écrit :
> Now the output of `git help config` not only shows the name of each
> tool (as before) but also a short description (as it is the case when
> running `git mergetool --tool-help` or ` git difftool --tool-help`)
> 
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>

This commit is authored by you but is missing your sign off. 
Also, I did not give my sign-off on this patch (that can't be assumed, 
it always has to be expressively given).

When people provide "in mail" diffs like I did in [1] and [2], it's usually meant
to be squashed into a commit of the series. In this case I think it would
be best squashed in 3/4, since as I explained in [3], the description of
each merge tool is already included in the 'git config' documentation after your
3/4, the below patch to the Makefile just makes it an Asciidoc "description list"
(and formats the merge tool names between backticks) instead of a plain list
as it was before.

Granted, after 3/4 only vimdiff and friends have a description, but that can be 
explained in the commit message, and the rest of the descriptions are added in 4/4.

> ---
>  Documentation/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 1eb9192dae..faed285462 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -302,12 +302,12 @@ $(mergetools_txt): mergetools-list.made
>  
>  mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
>  	$(QUIET_GEN) \
> -	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
> +	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && TOOL_MODE=diff && \
>  		. ../git-mergetool--lib.sh && \
> -		show_tool_names can_diff "* " || :' >mergetools-diff.txt && \
> -	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
> +		show_tool_names can_diff' | sed -e "s/\([a-z0-9]*\)/\`\1\`;;/" >mergetools-diff.txt && \
> +	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && TOOL_MODE=merge && \
>  		. ../git-mergetool--lib.sh && \
> -		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
> +		show_tool_names can_merge' | sed -e "s/\([a-z0-9]*\)/\`\1\`;;/" >mergetools-merge.txt && \
>  	date >$@
>  
>  TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))
> 

Cheers,

Philippe.

[1] https://lore.kernel.org/git/1363db57-74de-226a-468f-69feffde6ba5@gmail.com/
[2] https://lore.kernel.org/git/d0a0d00b-5c1a-4a0c-a91c-b03403578f80@gmail.com/
[3] https://lore.kernel.org/git/f56a7a0b-8525-c4cc-7bc7-5ac4bba59206@gmail.com/
