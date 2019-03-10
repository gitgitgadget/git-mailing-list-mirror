Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC3F20248
	for <e@80x24.org>; Sun, 10 Mar 2019 01:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfCJBJs (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 20:09:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33025 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfCJBJr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 20:09:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id c13so11388713wmb.0
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 17:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HOjsCbWkaxoFdYXKjXJZO/VIAwjjORgtyniizhhuaNA=;
        b=SrQq686xk+DUlGpNe4M76G1dfPr3jPMTsrzXkdAmwCxmWVPG93+mXgSY0biyCZzllt
         TSkqaJpuvLBZyE0bOH5m6MVI0avzHhpT2NnWbplFGutQkICM3rlo0T4IhlRlR8ElRi/P
         0zx0rSi+SKJCKdbWbzZxWwp9d4muivkQOfwkjL7Hbqfd7WJLu/kI+y4X8w8s0jdirWaT
         +iVuY+hgXXRpPziSYjDkHZXZlyiMgtBcCKk4CzyPQxtGikCQxZ7m00C6E3xn2heOP5sc
         PdQiCXTOnZmkEOsAGD2S0dHVb6I7odRYRzTAP4b607dpEzRRivFMn7f2rICEXberGi+v
         0Enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HOjsCbWkaxoFdYXKjXJZO/VIAwjjORgtyniizhhuaNA=;
        b=cbKMVDCKk3vssUWmhqW7gyQuMeIE1O5Tyh+lLiNi/+pGACQ2NiI6G2li0RLwwmJcpn
         VIQ7aWcvPKLUX3ZJk504rmQ/QgMX+Go/71BwdLNRDNYA/d7BiOhZ5tlgmNSjOURhRp2A
         LCpHj9B7OKH2KmKUgzhoTOkKLgvnYovHsxGbb0qMCYww7kpAutUMkJYfCLLkL4QBtrfX
         WLyyDhm/OOEGyNbHp9qVOZmkSszYsUOxEqZHfrFcXuYJ6mvsL0hFggA2QqavKbsssLia
         Q1gLquigbTTXCkrL5YnsZVfg6YwrGxaedtmFwMAtFD/4xNjECaLM9ia35jfWUibyt6+z
         5vuQ==
X-Gm-Message-State: APjAAAWLoOsJi0uiN+jNxVdQyooveE5JE/WXT1z+8B5WB/B1z0h6Y7pg
        MOccFV5a3iw5LZ10dRv6n5M=
X-Google-Smtp-Source: APXvYqw7JCklc8oSIQ1LD4kMbZjwEB96iL9csp/TLS7VvUnsNdBsNaWviBTe5DeeUY0RLxwED/iY4A==
X-Received: by 2002:a1c:3d84:: with SMTP id k126mr13087440wma.60.1552180185075;
        Sat, 09 Mar 2019 17:09:45 -0800 (PST)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id b4sm8313702wmj.3.2019.03.09.17.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 17:09:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] mingw: allow building with an MSYS2 runtime v3.x
References: <pull.160.git.gitgitgadget@gmail.com>
        <ba1a87e845919804c86a7859abb85ec50125628f.1552060278.git.gitgitgadget@gmail.com>
Date:   Sun, 10 Mar 2019 10:09:44 +0900
In-Reply-To: <ba1a87e845919804c86a7859abb85ec50125628f.1552060278.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 08 Mar 2019
        07:51:19 -0800 (PST)")
Message-ID: <xmqqr2bfmt5z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> So let's invert that test case to test for *anything else* than a
> version starting with "1" (for MSys). That should safeguard us for the
> future, even if Cygwin ends up releasing versionsl like 314.272.65536.

An obvious alternative is to do "2" -> "[23]" *and* update the else
to an explicit check for "1", *and* add an else that fails the build
when it sees "4" and other unknown ones.

I do not know how compatible MSYS2 runtime v4.x will be with the
settings the part inside the ifneq() we see here protects, but you
probably do, so I think this would be good enough.  The only case
that makes any difference is when v4.x _mostly_ satisifies but
slightly differs, affecting the built binary in a subtle way that is
not discovered right away.  But in such a case, the more cautious
"fail on '4' that we do not recognize" will not help much, as the
first reaction after seeing the error would be to copy the settings
that used to be OK with v2.x and v3.x anyway (which is what is being
done here---we start with the assumption that the support needed for
v3.x is largely the same as v2.x).

Will queue directly on top of... 'maint'?  'master'?

Let's say 'maint' and merge that up to 'master'.

Thanks.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.mak.uname | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index c8b0e34c31..0207e895a4 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -569,7 +569,7 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
>  	NO_GETTEXT = YesPlease
>  	COMPAT_CLFAGS += -D__USE_MINGW_ACCESS
>  else
> -	ifeq ($(shell expr "$(uname_R)" : '2\.'),2)
> +	ifneq ($(shell expr "$(uname_R)" : '1\.'),2)
>  		# MSys2
>  		prefix = /usr/
>  		ifeq (MINGW32,$(MSYSTEM))
