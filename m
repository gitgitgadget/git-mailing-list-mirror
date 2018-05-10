Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F1881F406
	for <e@80x24.org>; Thu, 10 May 2018 18:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeEJStl (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 14:49:41 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:38022 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeEJStj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 14:49:39 -0400
Received: by mail-yw0-f196.google.com with SMTP id y123-v6so850426ywa.5
        for <git@vger.kernel.org>; Thu, 10 May 2018 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XJSsWetLUwmeD2BUO+FwCh3f+NyKcEpcB+BeQZSTKQE=;
        b=aFcMGnQDBYLsBdPnk5V0vEZ5R8i66pSUMtXCcv0+NjX7tmqjeSLjz0SajVfcruGgWt
         Jfn2CSBUFFkO8oxMlk0E6awMLpsE8dpfBmDk/RZy5i14ZLgonizaWICLzl/fh/ElrLJk
         QPx0aEoHpMGmZBftAIv4gzhmx+yWp/gPGf3QtL3lzR40YtibYiPbBkOPvoIalf5St7AU
         I0dv34XKpUhZJ5P3jNME4mS+we7jqfMNSJ5yh6oOppCOiUuuLO0gl5mcP+xkI00aV7+t
         IQVYCW/xZ+w0GxyvDQfpcCLwhW9k29P5QQTjpdDvZ0RSrjlkO50VLpqhIIg/HmQmm6RG
         /eSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XJSsWetLUwmeD2BUO+FwCh3f+NyKcEpcB+BeQZSTKQE=;
        b=sUCtRUgY+Quty/rX2WPT585kRSBTsibTIihjhSlrak4bDboFokxPXo6Yt2BVtj5w34
         +d49ymhDetOX1uzRekOUdtd5VknFLHvyjMr0FXheioEIG+TvXiz9mRM54oce7A5w3A9q
         2pGpIqHS73Ei10yH6CwpnMdZp+uH2By205wZyhj51r10U49gNU1zpORE7s41Yo2ehsEB
         rsc8Nbsh91g15aIml10c9cgg3zj/wvMDd7Zzw4GHQsQpJHGyx3IG2hqk0g23V568Au6y
         m0kTBnpTkmCfVjRe3ct3+wIxIvSZLE3VGzc1AA7EUsjV21Uboazv7DKNJ0/Tl37pqWU/
         +JmA==
X-Gm-Message-State: ALKqPwfJU78nbv/drGe0CQqYB8eSy+62JCbUXGDKvyEwgW8PO0iz2B3C
        1zxnZ7cSQ3j6sOuMv5vI2s34AYHuIFe8p/Dwts2434Xw
X-Google-Smtp-Source: AB8JxZozw1eE+IH73E6NHB61LnDdnW/8mJPVefj5vm++egzVBznS95OkD6bhc6KurzfiVSlNW0guVpu6GxatqCgpDjw=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr1252766ywf.238.1525978178106;
 Thu, 10 May 2018 11:49:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 10 May 2018 11:49:37
 -0700 (PDT)
In-Reply-To: <20180510182657.65095-2-leif.middelschulte@gmail.com>
References: <20180510182657.65095-1-leif.middelschulte@gmail.com> <20180510182657.65095-2-leif.middelschulte@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 May 2018 11:49:37 -0700
Message-ID: <CAGZ79ka3kVHSZ9oG=NOvr0=KCHODngxJQLbKApDsFY=xNPhU=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Warn about fast-forwarding of submodules during merge
To:     Leif Middelschulte <leif.middelschulte@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 11:26 AM, Leif Middelschulte
<leif.middelschulte@gmail.com> wrote:
> From: Leif Middelschulte <Leif.Middelschulte@gmail.com>

Hi Leif!

thanks for following up with a patch!

> Warn the user about an automatically fast-forwarded submodule. The silent merge
> behavior was introduced by commit 68d03e4a6e44 ("Implement automatic fast-forward
> merge for submodules", 2010-07-07)).
>
> Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
> ---
>  submodule.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/submodule.c b/submodule.c
> index 74d35b257..0198a72e6 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1817,10 +1817,12 @@ int merge_submodule(struct object_id *result, const char *path,
>         /* Case #1: a is contained in b or vice versa */
>         if (in_merge_bases(commit_a, commit_b)) {
>                 oidcpy(result, b);
> +               warning("Fast-forwarding submodule %s", path);
>                 return 1;
>         }
>         if (in_merge_bases(commit_b, commit_a)) {
>                 oidcpy(result, a);
> +               warning("Fast-forwarding submodule %s", path);
>                 return 1;
>         }

The code looks correct, however I think we can improve it.
(Originally I was just wondering if stderr is the right output,
which lead me to the thoughts below:)

Looking through the code of merge-recursive.c,
all the other merge outputs are done via 'output()'
that is able to buffer up the output as well as handles
the output for different verbosity settings.

So I would think we should make the output() function available
outside of merge-recursive.c. (and rename it to a be more concise
and descriptive in the global namespace) and make use of it.

Funnily we already have MERGE_WARNING in submodule.c
which outputs information for all the other cases. I would think
we ought to convert those to the output(), too.

Thanks,
Stefan
