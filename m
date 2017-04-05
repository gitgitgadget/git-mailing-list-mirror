Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6091320966
	for <e@80x24.org>; Wed,  5 Apr 2017 13:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754948AbdDENx7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 09:53:59 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36235 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754590AbdDENwp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 09:52:45 -0400
Received: by mail-io0-f195.google.com with SMTP id 68so1418640ioh.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 06:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rBe6GXs+fTAQ7U7BFAT8Rlzy3SJ/oamjQ2XNJmM+TSs=;
        b=BIBM24EMRZ7rIl8RhywNBqde3F1sSUfR8L0IpZEnfYAaSmZlVgBfvEvGOGvoOWmOKC
         u3GrenV749eE2lCH8Aw2KKgeRIiDSEK+uYPVCUVWEr8iMLdsXEsFb3hrJ58mfBqiHEtI
         d1DEFed0lL+i1A9PxYqba8Ab9lL/NTplIdjrgT/nxICAdpK67xtw3OeyyRAL5Y0MQZvE
         RumQCfiRu0pwOrmW2Iyp7o/LvwrD7CmrYDq44hcHAHhQfjQHzXEebQZjs4kvLP3yKZ5X
         zCU+oC1mxNX1rj411NIJbEJoEGqp7SxPF7+q2DnDI39aM0420HUnGxiy2pppke6WHOWF
         0Vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rBe6GXs+fTAQ7U7BFAT8Rlzy3SJ/oamjQ2XNJmM+TSs=;
        b=KJKdPhUxAp/JtGgBzZx0XbVicI0cURfFJleotf35X93ws/TZAhkF6vWVid9sScnZhO
         lJY/4020Fy1rUsUnEqya775v+f659AR0DJuJkVH4I2mkEgMXwXtxSehxnRcBWZSRi+0H
         APjn9kQlAtNceRoxiKnOb5qYiE3J0dpol5DeQhpQRentzHOeDdE6QV9/1nMUB9Xb6W1d
         izOAAE4N4EUD7LBpjem7om8TlgtrOJWpC1Wp5vP7k7olE/8VP2WrI7TiZzjo5nzhlF+c
         J/0W+D7lL6iRcmhseSdzuUVmZziGmm205XDoaQd1A6HMrGzUZnVVDQ+TBDBxtBUaZYt4
         q+xg==
X-Gm-Message-State: AFeK/H0M3gmvI8RHv8mJqUUGcFtPWMnthVmvULumR84TwTTos74kqVjREHcKrtdG2FMKmWW67jNHofwOkC4hOg==
X-Received: by 10.107.150.201 with SMTP id y192mr30962703iod.33.1491400364858;
 Wed, 05 Apr 2017 06:52:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Wed, 5 Apr 2017 06:52:24 -0700 (PDT)
In-Reply-To: <20170405130424.13803-7-tgc@jupiterrise.com>
References: <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170405130424.13803-1-tgc@jupiterrise.com> <20170405130424.13803-7-tgc@jupiterrise.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 5 Apr 2017 15:52:24 +0200
Message-ID: <CACBZZX43nYQH3+TX5vvrM-btzQNWsOWi62G6zPXw_BZmZb2dJA@mail.gmail.com>
Subject: Re: [PATCH 6/7] Handle missing CURLINFO_SSL_DATA_{IN,OUT}
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elia Pinto <gitter.spiros@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2017 at 3:04 PM, Tom G. Christensen <tgc@jupiterrise.com> wrote:
> Do not try and use CURLINFO_SSL_DATA_{IN,OUT} for curl < 7.12.1.

Disables code added by Elia Pinto in 74c682d3c6. Looks harmless to me
since it's just omitting some information when GIT_TRACE_CURL is set.

> Signed-off-by: Tom G. Christensen <tgc@jupiterrise.com>
> ---
>  http.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/http.c b/http.c
> index ce618bdca..a46ab23af 100644
> --- a/http.c
> +++ b/http.c
> @@ -649,10 +649,12 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
>                 text = "=> Send data";
>                 curl_dump_data(text, (unsigned char *)data, size);
>                 break;
> +#if LIBCURL_VERSION_NUM >= 0x070c01
>         case CURLINFO_SSL_DATA_OUT:
>                 text = "=> Send SSL data";
>                 curl_dump_data(text, (unsigned char *)data, size);
>                 break;
> +#endif
>         case CURLINFO_HEADER_IN:
>                 text = "<= Recv header";
>                 curl_dump_header(text, (unsigned char *)data, size, NO_FILTER);
> @@ -661,10 +663,12 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
>                 text = "<= Recv data";
>                 curl_dump_data(text, (unsigned char *)data, size);
>                 break;
> +#if LIBCURL_VERSION_NUM >= 0x070c01
>         case CURLINFO_SSL_DATA_IN:
>                 text = "<= Recv SSL data";
>                 curl_dump_data(text, (unsigned char *)data, size);
>                 break;
> +#endif
>         }
>         return 0;
>  }
> --
> 2.12.2
>
