Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD52E1F51C
	for <e@80x24.org>; Sun, 20 May 2018 16:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeETQdo (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 12:33:44 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34012 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbeETQdn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 12:33:43 -0400
Received: by mail-wr0-f193.google.com with SMTP id j1-v6so2724981wrm.1
        for <git@vger.kernel.org>; Sun, 20 May 2018 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4F0eB/piVCgqUoVbrF5fxUyw5gq4WHYDmCzZbIGI0CY=;
        b=Ea5zSXbixwJPk+lHh7HqDA2+6323txxvYgrHQtFf4PZQbgLxXQDae46J4mouVO1RnY
         Z9FvV25l6GI4IXOs1W0T/N2UuZc1Q19DxUTSfFDXQKv+NcFaJrFet/teP0v2JK14lgwL
         EKfAL7N9Y2x4vPmCN0aSKKidy2a6bzAsSHU7KJiJ66EvqkGfPZ3oolvUlX4t23dxxmGr
         +057lTDfuHoz7FAAhWgbVSr2RfsA42FhW91JSnWjRHsjt6h3pLLKBlEzNOWDN4UBv5cU
         cm1sRR6mdfYZXZNEouO1UloP0XA5iN8Ai5Lvgw1HMgsWVZdqlpCxJbea/tY1C6dNmAIw
         tLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4F0eB/piVCgqUoVbrF5fxUyw5gq4WHYDmCzZbIGI0CY=;
        b=K2hiClo1pX65VpcNLa+7UrBYqqQHMEdY0atqWSjFI9bntyyIEVGsptd8Qmpqlafc1I
         C34cxmUzw/VnMrA3SB9d1EI9jzm/OtB2Nekq31YGHNoS/AQJKz2500WdUwtMRQ/ZAyAd
         ZVClFE2Bah4BEJIcom8GafjoTBsExr7XTSqkG2gqcTHIFQUrUBu3v+IlRojUHlIPoHCK
         ffpbRf65MtqFvyaLu5VZsfo7j3TqwGCUU2Njh4YD40QOw9dz95OtpV0Kb5Zq68FWHiI4
         VsctWAZqbISq2YmzWsrFqQivgF0kyLSmEfvHGXhx/pOjC89s81j7QeloQSyqm0O/ijjl
         xAWw==
X-Gm-Message-State: ALKqPwdLvvQUkgLYESiZDj05dsWXBQvO5AfcR6wuA09Ph2pSvhufo7EV
        kRwljP2Ajr2/wzf3hATwm6Ns7w==
X-Google-Smtp-Source: AB8JxZrMxepYMQWhWYDNK28PL4XLXuIlHLZQzm0Muthvo/qgJLGG6eNw4GqX29xBambwhA8FH1oMYA==
X-Received: by 2002:adf:ce03:: with SMTP id p3-v6mr12720448wrn.110.1526834022437;
        Sun, 20 May 2018 09:33:42 -0700 (PDT)
Received: from localhost.localdomain (x4db14276.dyn.telefonica.de. [77.177.66.118])
        by smtp.gmail.com with ESMTPSA id r14-v6sm14410234wra.41.2018.05.20.09.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 May 2018 09:33:41 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 8/9] completion: support case-insensitive config vars just a bit
Date:   Sun, 20 May 2018 18:33:29 +0200
Message-Id: <20180520163329.12202-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.799.gd371044c7c
In-Reply-To: <20180510141927.23590-9-pclouds@gmail.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> config variable names are technically case-insensitive while this case
> construct is by default case-sensitive. Moving it to case-insensitive
> could be a lot more work.

Bash v4 supports the case modification expansion in the form of
${prev,,}.  Alas OSX (or older LTS/Enterprise Linux releases) ships
Bash v3.2, which doesn't yet support this syntax, and there is ZSH,
which doesn't understand it either (though I suspect it has its own
weird syntax for case modification).  Supporting them could look
something like this:

  local varname
  
  if [ "${BASH_VERSINFO[0]:-0}" -ge 4 ]; then
          varname="${prev,,}"
  else
          varname="$(echo "$prev" |tr A-Z a-z)"
  fi
  
  case "$varname" in
  <....>

Not pretty, but I think the additional complexity and overhead is
acceptable.  Yeah, on some platforms/shells we would run an extra
command substitution and an external command, but I suppose on those
platforms the overhead of the extra processes is not that critical.
And where this additional overhead matters the most is Windows, but
luckily Git for Windows ships with Bash v4.


> Instead let's just accept the form that is
> more likely to show up in practice.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 8d3257c4de..e7829b5b24 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2084,7 +2084,7 @@ __git_compute_config_vars ()
>  _git_config ()
>  {
>  	case "$prev" in
> -	branch.*.remote|branch.*.pushremote)
> +	branch.*.remote|branch.*.push[Rr]emote)
>  		__gitcomp_nl "$(__git_remotes)"
>  		return
>  		;;
> @@ -2096,7 +2096,7 @@ _git_config ()
>  		__gitcomp "false true preserve interactive"
>  		return
>  		;;
> -	remote.pushdefault)
> +	remote.push[Dd]efault)
>  		__gitcomp_nl "$(__git_remotes)"
>  		return
>  		;;
> @@ -2162,7 +2162,7 @@ _git_config ()
>  		__gitcomp "$__git_send_email_suppresscc_options"
>  		return
>  		;;
> -	sendemail.transferencoding)
> +	sendemail.transfer[Ee]ncoding)
>  		__gitcomp "7bit 8bit quoted-printable base64"
>  		return
>  		;;

'git help config' shows 'color.showBranch' and
'sendemail.aliasesfiletype' in camelCase as well.

