Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E476C1F51C
	for <e@80x24.org>; Mon, 21 May 2018 20:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbeEUU53 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 16:57:29 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:39072 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeEUU5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 16:57:24 -0400
Received: by mail-yb0-f193.google.com with SMTP id g140-v6so5561036ybf.6
        for <git@vger.kernel.org>; Mon, 21 May 2018 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8rJH30TjCmKPCv73rdVT5bveC8Yh23I++0fvPH4znaY=;
        b=KcFsBrjVkSy2QfSv2gUe9ZepJTklpq2riJR6ZtMuRKiOOdxWM2HFi+gfa041ysAUiX
         Y82dHUyvUX6YO1FoNCO47bsmV1fZdSTcE6M82IGpjoCDp+fAqFq11/Xjm5O4phHYZ0gw
         WNeVLMcf8NppHs1wpaaKqa6Ule+mE3EPAlO0qEB6GWOFRVgARml3dRrig7IMyGcPC7Fd
         0MvlKejl/bfeOZOyTUmV3K+OVnwjVzTMJCLerIqdlZIgs9geosEXsMkDcU7KX12DX74s
         mZ1Fyu2KYzxP6KlABaS08zgNHGgtxAsK/4vlI/I8KYbxZ0ez/yobGBDzFu3NdD4F2+43
         zrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8rJH30TjCmKPCv73rdVT5bveC8Yh23I++0fvPH4znaY=;
        b=mGXBZHtYR8sFWitK/8unaQXqZdaiRq1+volhheHtTEFDAklrj7HFOOspkJYMUWNDd3
         X+CrGYJTGcpih+FWghzeeOmi/lN+n0ASS9CBC8MQb6hnAuqksiGE87VdizebkPSs46Kl
         0XBBFFPa7y/j5z8heHYRjeZEmQpOMBSF2BGyfBNhUI3EW5YcUpA5QRFvPZiuRzB9Wtsd
         1E8MQFIYWBZj2I7L0x1YtiDzrWS4cVNZmt/p0KunoBYdIAmCdT5ZZxYUTKUT8Cag9CL8
         Qzb8bRutMXOxzClWEj8qeljHEmbdYdujSg0D4ckDsCvAM2BPWhZMFHNZttwNo9H9bmCk
         9cjA==
X-Gm-Message-State: ALKqPwcv0LjVwXYI3DDstMfPv/zwUFrcBukk1mboTXuuJx8hbv2k9tv7
        JztFFmP8AAFxIAABoge9+wIzHPg+AYKjs9cJoYhipQ==
X-Google-Smtp-Source: AB8JxZpncX/AnQFBMuvxyO0cP7f+nS2F0+BvfkkK8tPq0WsGNu9ycegndMFBL1h+6cCJkRbl2V0u5TYnARvZOlK0Xjo=
X-Received: by 2002:a25:31c3:: with SMTP id x186-v6mr1181900ybx.352.1526936243296;
 Mon, 21 May 2018 13:57:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 13:57:22 -0700 (PDT)
In-Reply-To: <20180521194120.GA9742@sigill.intra.peff.net>
References: <20180519015444.GA12080@sigill.intra.peff.net> <20180519015636.GA32492@sigill.intra.peff.net>
 <CAGZ79kYZ9HSCC95qCZ4Zix1oEFLscsU1HZe64s--6KuWEz2ojg@mail.gmail.com> <20180521194120.GA9742@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 13:57:22 -0700
Message-ID: <CAGZ79kbPuR8w1goGu6qgMRqF+myMUhtmXYSA7Wxh8VQy8dRBig@mail.gmail.com>
Subject: Re: [PATCH 1/5] http: use strbufs instead of fixed buffers
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 12:41 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 21, 2018 at 11:11:51AM -0700, Stefan Beller wrote:
>
>> Hi Jeff,
>>
>> On Fri, May 18, 2018 at 6:56 PM, Jeff King <peff@peff.net> wrote:
>>
>> > @@ -2421,4 +2426,5 @@ void release_http_object_request(struct http_object_request *freq)
>> ..
>> > +       strbuf_release(&freq->tmpfile);
>>
>> Do we need an equivalent in release_http_pack_request as well?
>
> Yes, but isn't there one?
>
> From the original patch:
>
> --- a/http.c
> +++ b/http.c
> @@ -2082,6 +2082,7 @@ void release_http_pack_request(struct http_pack_request *preq)
>                 preq->packfile = NULL;
>         }
>         preq->slot = NULL;
> +       strbuf_release(&preq->tmpfile);
>         free(preq->url);
>         free(preq);
>  }

which is at the very top, but I was not looking this far up,
but looked for functions order that my editor had.

Clearly I have to practice code reviews, still.

Sorry for the noise.

Stefan
