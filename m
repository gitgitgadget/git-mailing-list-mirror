Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1E220966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbdDENx4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:53:56 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35692 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbdDENxv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 09:53:51 -0400
Received: by mail-io0-f194.google.com with SMTP id f103so1419513ioi.2
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fFAyIqJQqIcxNV8L8g+jYzCW30CktxClCaN0S17K4QQ=;
        b=NRXtF3QA4bb1UWKKkvbfD99+X7xJdDlsUVC3hy25iiUTyPw7CE8wSVtBWURqnVMDSb
         AJyh7v9RpdEDk4BBs4Hhechv//CRIHDqvLoOZaDn06Zqd8wgrcioF5XLGdDmmQXGdwfq
         6UUjZxL/G9JlTgL0RzBMs/Ww7ttCdpdNLZWZLT7HLdVUwX1vqvMcX/eaGSVeizOesqSL
         QY+VrhCzz8JJuatGcDzreXXb7pm8D1ZFFrI+7ISNtES+YFs8VY36vjHqxaJauQuSGMek
         F5gg8Vk4itkOgO4fNAbeR6KNaTOw131qDIKpOjXazizKp9DeHi2UEDB13b2ztBqJm44z
         Unkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fFAyIqJQqIcxNV8L8g+jYzCW30CktxClCaN0S17K4QQ=;
        b=btuR8DL66bVN8EX3azmJtP2N5hb0mDtYSelLtKeAZqQ5Rafm+O+YblUYygRc4to0wO
         taFobm3SROeK5K0hbREU9OpKDbwTfFBovpwEeSI6gUrdIDGXN1Jrb1IkZCXJbW9mCJEa
         qKUsZD/nth9ji1KEA+E3qr2GCRslp/s8iSWRg+kSEDFIEeLUV/Im9DF27CKInXFX0Qdg
         G/B9+/3G5W/TIPcWJ6IH+RU4tbXZdBiPO9HXKB8vDtepQjNAAwkGR2w8mVWM+RmrMxMn
         LkBT6iNWkjpSUYLDnKZpl9OWF/qpDZYmI+yVc0HhWp48yrF8lqH3W1ds1Q7pcpwdnEQY
         Zf6A==
X-Gm-Message-State: AFeK/H2/BACQ4Hi/3SSDbY8aUzqEMyG3ccgW9OVoZ2Evo7WlSM2/oobccVHyf80WV+FSlvd7/QhrrNjW0aLoBg==
X-Received: by 10.107.32.199 with SMTP id g190mr30073758iog.117.1491400430822;
 Wed, 05 Apr 2017 06:53:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Wed, 5 Apr 2017 06:53:29 -0700 (PDT)
In-Reply-To: <20170405130424.13803-8-tgc@jupiterrise.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com> <20170405130424.13803-8-tgc@jupiterrise.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 5 Apr 2017 15:53:29 +0200
Message-ID: <CACBZZX7wc+aMgonzeLpv-O7c2p0AC9-q+EP5rf+SuR89V=WEVw@mail.gmail.com>
Subject: Re: [PATCH 7/7] Do not use curl_easy_strerror with curl < 7.12.0
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2017 at 3:04 PM, Tom G. Christensen <tgc@jupiterrise.com> wrote:
> Commit 17966c0a added an unguarded use of curl_easy_strerror.
> This adds a guard so it is not used with curl < 7.12.0.

Looks good to me. Eric Wong added this in 17966c0a63.

> Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
> ---
>  http.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/http.c b/http.c
> index a46ab23af..104caaa75 100644
> --- a/http.c
> +++ b/http.c
> @@ -2116,8 +2116,12 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
>                 CURLcode c = curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE,
>                                                 &slot->http_code);
>                 if (c != CURLE_OK)
> +#if LIBCURL_VERSION_NUM >= 0x070c00
>                         die("BUG: curl_easy_getinfo for HTTP code failed: %s",
>                                 curl_easy_strerror(c));
> +#else
> +                       die("BUG: curl_easy_getinfo for HTTP code failed");
> +#endif
>                 if (slot->http_code >= 300)
>                         return size;
>         }
> --
> 2.12.2
>
