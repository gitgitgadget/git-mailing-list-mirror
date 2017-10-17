Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15A591FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 17:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762920AbdJQRkk (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 13:40:40 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:49110 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753310AbdJQRkj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 13:40:39 -0400
Received: by mail-pg0-f67.google.com with SMTP id v78so1981625pgb.5
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zHdBvwNat5eJVMVywDLiYZGJ1QYaHqe3kvfkq6wWQfY=;
        b=el3/XKqw4YhSwyDpg9boO9CQiRddQ7jw2cCjK9wZ8ijWSOvDKFoZPVz97GgCdun3/5
         PRbnS/D7QWY4nIADiRd0eyALLuZqtLxN5m4dXh1Gulpz+IpcGP6yHNlUqV9lt4Cdd309
         M4+an+CiOoffL/YMh01P7GXNq0Wq2BEDgH+/CopiASZSupu+m6AyORR9A/An17WdBHr7
         XQY06TwKieyyrMxRQiEfST+hRRJki0EMg7OzPWusNWY9HBUVIzbuWuP98tSM+K/BkzQc
         o62yq5XqxNbRqoZdPg2g4nzjYsJtqPYAo4IVtd8gyMMUlK29jPOXk1vAknd58WrDtXSN
         uOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zHdBvwNat5eJVMVywDLiYZGJ1QYaHqe3kvfkq6wWQfY=;
        b=hMm545KW+N2Dir+LQ2bSEveBwERgCd2TinDksBKRWzWkesKTQgxqCpwnI4bgTJol1t
         dL0EDABOGDHXvqzbIPY7D1ctWEKP1+Ouq/DJRcrWd/Y/0r1pQZsBeUlDMJdQKEmmVgll
         QiHDJaqDUCr9R/hCaIMhAPRWC6duMWRbEaskLJf9dRVpRz5lGrfqJ/FpXVf469XBaDKw
         fA1rrexzd+7ZNgD++DjvSDh2An0GhatBFaVR3tOlmA3uYIagP5xHScBlHNo0ER/4F/QZ
         9jFMyPaNd0ziiMggspCCjNrENc6FyW9A5U40cJJL+E3Y7gDAUrpUIvQT/wTa/wyp3DHH
         lxrQ==
X-Gm-Message-State: AMCzsaWLVv09bix5esMCbu30mOl0wxuUXIBz8bJtVKN30w+4+lryTW13
        F5rYUcSaZOUSVfYEvvQEjGRcXxha3FSufhpD/K8=
X-Google-Smtp-Source: AOwi7QAPg+ZLlfLYUoysTyJ2PF4H6yeJdgqDVv8Hqq/2sjPbtXU7syTXLwkl5V0E+FdPPUYKXTGVgCLfsBeFt+mrfhc=
X-Received: by 10.98.212.70 with SMTP id u6mr12353170pfl.321.1508262038672;
 Tue, 17 Oct 2017 10:40:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Tue, 17 Oct 2017 10:40:37 -0700 (PDT)
In-Reply-To: <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de> <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 17 Oct 2017 19:40:37 +0200
Message-ID: <CAN0heSrR5v3JSXiQaqNTzf58G_CAXO-rL4W-GhQzb+OqLjK6QQ@mail.gmail.com>
Subject: Re: [Alt. PATCH] ls-remote: deprecate -h as short for --heads
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17 October 2017 at 17:39, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Stop advertising -h as the short equivalent of --heads, because it's
> used for showing a short help text for almost all other git commands.
> Since the ba5f28bf79 (ls-remote: use parse-options api) it has only
> been working when used together with other parameters anyway.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> That would be step on the way towards more consistent command line
> switches, in the same vein as d69155119 (t0012: test "-h" with
> builtins).

FWIW, my first inclination would be to go with a patch like this instead
of the other two (where you introduce an exception so that git ls-remote
-h does not display the usage). ba5f28bf79 was in 2.8.0. That's 18
months ago. Not an eternity, but still some time ago. Not fixing this
regression has an obvious downside, but there's also a downside to
adding the exception.

As long as a lone -h may give the usage or do something else entirely,
then -- put bluntly -- to know whether you can request the usage with
git foo -h without risk of messing up your repo, you'll need to look up
the usage some other way. At which point you've solved your original
problem, without -h.

Of course, we could promise that -h will give the usage or, in case of
historical wart(s), do something harmless. But it seems a bit awkward,
and might limit the perceived usefulness/safeness or -h.

> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remot=
e.txt
> index 5f2628c8f8..898836a111 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -21,7 +21,6 @@ commit IDs.
>
>  OPTIONS
>  -------
> --h::
>  --heads::
>  -t::
>  --tags::

Do we want to document -h as a deprecated alias, so that people have a
slightly larger chance of noticing and adapting?
