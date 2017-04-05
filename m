Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D584620966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753588AbdDENwQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:52:16 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35078 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753407AbdDENvT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 09:51:19 -0400
Received: by mail-io0-f193.google.com with SMTP id f103so1412564ioi.2
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+t9CHWREkP314le1ylga6kwHfRO4Fp2OIBAfGMRNkfg=;
        b=lvOPrZfhGrWR9m9yI5IJSUOlcAiFKWX9ErF4Gg7//cqMDCt3LsRnlqUDfNDK8DLey0
         HkWfjF2tfaBkCA2BDDBq+OYJ4f376y/oXzJHh495WY0lfwuIODmfgXDX2jkExAWX+8hB
         FJQHbSk9aClnfBE9YPzksmqICs4SM+Wo3iHS7EypTurDHraEBcm2N49m5JM1CzPtgRes
         bDJDG4GL+aFv049aBBZx3YtFCiRcjgp3CKicTMMn6ff7kzMk5MQQR3TwLPylvNHxyApz
         B6oLZxLtmJpEhRtlF07TLV4bL/91gUAIBn4GuFYfOEV4IuMvYLDkCpEBX23jUNtKLzfz
         cwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+t9CHWREkP314le1ylga6kwHfRO4Fp2OIBAfGMRNkfg=;
        b=gXZDXXjdPhZMfkkZI6pmYQep2ZW3A+xxhO7vboxR8NJmUA+wqbohat6r9XXjSwHTcL
         xdJZFuXYHyhSvuCme4rDmuFs+aV8CGIYLHiK+nJ6JdqOZHE5Xfv1xmwyIw88j/ocj2An
         KZ7yBGCbapzYa//mYsNRVgHrLect8dBeLRHGOku2wQxZPZ/LnUNo6YDCavv5itzJExPJ
         JTHcDEv3kB1L2i8XDic6dz5NnL2k25JFwSopqTNY8HleKSWXMYG8L6kcBQSvdYxz+ZHM
         fMRHw17KiMN33DeWexTkXMtR6vMPXpZAAUx3mrL4BOs1Nkb4lFEqfzEnh/sF6u1o7Ofn
         TT0g==
X-Gm-Message-State: AFeK/H3Lp2s522yv4onFRhwvPkEnNMxNclqgDHQGI5/ft6S3ulLMwf5+KqYvAsc15UNeSB5vib1B0mVOWCazQQ==
X-Received: by 10.107.150.201 with SMTP id y192mr30955683iod.33.1491400278919;
 Wed, 05 Apr 2017 06:51:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Wed, 5 Apr 2017 06:50:58 -0700 (PDT)
In-Reply-To: <20170405130424.13803-5-tgc@jupiterrise.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com> <20170405130424.13803-5-tgc@jupiterrise.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 5 Apr 2017 15:50:58 +0200
Message-ID: <CACBZZX4OVy0QOnPLYNY0pptvno+OJ-c6=sRtVWcT+40aaEGY2w@mail.gmail.com>
Subject: Re: [PATCH 4/7] Handle missing HTTP_CONNECTCODE in curl < 7.10.7
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Knut Franke <k.franke@science-computing.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2017 at 3:04 PM, Tom G. Christensen <tgc@jupiterrise.com> wrote:
> With curl < 7.10.7 we cannot get the proxy CONNECT response code.
> As a workaround set it to zero which means no response code available.

CC-ing Knut Franke <k.franke@science-computing.de> which added this
code in 372370f167.

This effectively disables that code & this later check:

+               if (results->http_connectcode == 407)
+                       credential_reject(&proxy_auth);

What's the impact of not taking that branch when the proxy returns a 407?

> Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
> ---
>  http.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/http.c b/http.c
> index 96d84bbed..ce618bdca 100644
> --- a/http.c
> +++ b/http.c
> @@ -214,8 +214,12 @@ static void finish_active_slot(struct active_request_slot *slot)
>                 slot->results->auth_avail = 0;
>  #endif
>
> +#if LIBCURL_VERSION_NUM >= 0x070a07
>                 curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
>                         &slot->results->http_connectcode);
> +#else
> +               slot->results->http_connectcode = 0;
> +#endif
>         }
>
>         /* Run callback if appropriate */
> --
> 2.12.2
>
