Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83FAF1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750817AbeCXHUG (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:20:06 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:37603 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeCXHUF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:20:05 -0400
Received: by mail-qk0-f172.google.com with SMTP id w6so15278563qkb.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZLJpnF7HXhORbbKS7nI1MQUBlVYHfYKZT7mwB20W/t0=;
        b=bQihMdDq273WElaJpcP1q8BiQ4zfmyrYxyUkyyl0GUdb033g+x5TkE3SQ2B/6dqMhE
         81e9xLEEsqu+7Z1XTyS6yu9FZbX00dABAL9oo6J6HgLoERa+DVFkfg1+JUG+ShLbz3Dz
         tjn80Fu1SP6kRf7RWuihQq9kqdu6L94Q6wBh1rarWroHfn57oQoPtgNjLKBjn+homoNC
         BYOrDB/SdRAv+LKfZxa1cuc0EJjrRY/nR3to+HY6Dz2DJXH1zj5EyNSgUdsAXTZ6s+Go
         96S9b4W4IqU+K4oVBgGK4bsRDaHhRc1UfmVPFtgNXDZVvi9jlhe3jAHwWttnGJ09qKoN
         aicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZLJpnF7HXhORbbKS7nI1MQUBlVYHfYKZT7mwB20W/t0=;
        b=o2iYCqzhGpsovDCQBrR+Rkvi5vJ/6kfY9hkG6C3Y+EarmMKLXHtY8Tff2D6umhnJxN
         Ernj7WuRqwiDXfG66hIrsL4iTTqPAvzs/r9J7W9xjTMQeu8rU/3N9jTAsF1D6jclVPXP
         ISWQMJxgF/tJ5ooFQrSmAiIwu72J/6tYL0fz8pgximKJO2B+akJWiL8T7ofG99DYl9Hg
         BnwgzpaoK4vrexQbPcqTRQ5zaPrFnEuUyghBNDTQdUKgszRyEedx/x70YtprTlIl5KkT
         vppVcF+MDoWpl1r2WWjmeLishw20+s8M0lbl0LFGJUAmRGWxk6Lb/wqaCB+BerGHXxG9
         Vpow==
X-Gm-Message-State: AElRT7FKGE8iJO5xYk5ZTz2xLkGekbateJEUT27WBdu3gNPEt/Lpfnu+
        W1Ve4KRZt1qUQQnqjNsDoZlPSCkMDWERgLglVMw=
X-Google-Smtp-Source: AG47ELt05bAt/djS5NYlss8i/jsAh2Cu01/CgRk4sa7UGkv9DdEV0pLyuK3kn36E9ktS6a4/WaOA7mRsmb51fkAQskY=
X-Received: by 10.55.3.140 with SMTP id 134mr45397535qkd.26.1521876004649;
 Sat, 24 Mar 2018 00:20:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 24 Mar 2018 00:20:04 -0700 (PDT)
In-Reply-To: <baf0d9bab81bb3a80d0428c4aaa33cf32b3823e4.1521839546.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com>
 <baf0d9bab81bb3a80d0428c4aaa33cf32b3823e4.1521839546.git.wink@saville.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 24 Mar 2018 03:20:04 -0400
X-Google-Sender-Auth: joILpIh8hTXLJhgXPb0Au4DfNok
Message-ID: <CAPig+cQO78r9ym-Tq7Qfheq6OyjDFQB=SngXiGGVmh23piv=7A@mail.gmail.com>
Subject: Re: [RFC PATCH v5 4/8] Extract functions out of git_rebase__interactive
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>, gister@pobox.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 5:25 PM, Wink Saville <wink@saville.com> wrote:
> The extracted functions are:
> [...]
> Signed-off-by: Wink Saville <wink@saville.com>
> ---
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> @@ -740,8 +740,20 @@ get_missing_commit_check_level () {
> +# Initiate an action. If the cannot be any

s/the/there/

> +# further action it  may exec a command

s/\s+/ /

> +# or exit and not return.
> +#
> +# TODO: Consider a cleaner return model so it
> +# never exits and always return 0 if process
> +# is complete.
> +#
> +# Parameter 1 is the action to initiate.
> +#
> +# Returns 0 if the action was able to complete
> +# and if 1 if further processing is required.
> +initiate_action () {
