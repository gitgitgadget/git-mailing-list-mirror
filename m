Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026861F404
	for <e@80x24.org>; Mon, 15 Jan 2018 10:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933875AbeAOKW3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 05:22:29 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]:45268 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933664AbeAOKW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 05:22:27 -0500
Received: by mail-oi0-f42.google.com with SMTP id j129so7921328oib.12
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 02:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bz7euiFlI0GpTwc5Bgt3qO7PmS6XzV10DB/ew5rTu24=;
        b=T0UtMVIQG525jMij4vEnjKZ11m/fH4RLlBMTnvaxanldbsvqKPxYhC+r5mNBpSltpD
         TzWh+fb/aj1yrj4gOMbNsGyetJZxcvOIYd9iS5UQw6qfz9gN5Rk+F8FeE9Zag9JL326b
         rK9OIF7n7JbjMucp0vLGsdAN4vLYc/VXMy5Q72MI5vzQfTvj3phEwpE9iUvWGUS0/RT9
         XPxShxomnqlwBNaH5gqH/b2iLT7UmcaTvsJU+brRHUnQ57R2gErcoLmvEEQ+viAUNOlg
         9VK6QLB0fiMseAtAJrNfbjxW1FafAARh6xIJAzfY8nz+NDDpnotOC8OCl32hj5DsV8WW
         NvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bz7euiFlI0GpTwc5Bgt3qO7PmS6XzV10DB/ew5rTu24=;
        b=TPia4aHRdGHvsrXMIy5fp6yoUdc3qEqJdCD/+BoXeGmldvqakqFd9rK88ZyWEcA2Qv
         76ysdVdYlt2Tdvi7QZie9vOzruytLjVdNFUXdZqRowVKFSS9YLKcb3LlK13+KEJX78RB
         4IrOWaWF0hZBuOhI1izaKPTRwxTXG4xGqPuCNnocpAeDzGCpO+V0eUXK4unul945tLYG
         +Nf8dWxTLbwxcYtWZaAUXicRL672YYKdfWS/mA4cMwlr1qSNRe6cqVIYQRCHjdzDy5Ca
         oZQuW7AaYOj8hbKj9OFMMNG/dHdAXEaAvo8av+WQAdK4w3SABI6KYpMAh/pMZpcrhXw4
         iYmA==
X-Gm-Message-State: AKwxyteuiaV7Nush0N7IjpZ0vlGXWtdK5rgZ/OIpGClJ0In5SQCKwoKH
        KLl+c/m1JOwV1RHH0ncwy8sCI3m1XyFYyXOfWTA=
X-Google-Smtp-Source: ACJfBov2uber6ccH+2qOOzAKC0gzSItCnXFDB/3sBe925qb3WIn3EB9wcjRr2BLkjhhXiMDL80XHJlZIeRGJS15t5qY=
X-Received: by 10.202.171.195 with SMTP id u186mr9054659oie.253.1516011747080;
 Mon, 15 Jan 2018 02:22:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Mon, 15 Jan 2018 02:21:56 -0800 (PST)
In-Reply-To: <20180115054419.4112-2-ash@kambanaria.org>
References: <20180115054419.4112-1-ash@kambanaria.org> <20180115054419.4112-2-ash@kambanaria.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 15 Jan 2018 17:21:56 +0700
Message-ID: <CACsJy8B4zfu4q-KPEWZp=5cGRmpfhK75D41MB_SX_kU0LNgQUA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Mark messages for translations
To:     Alexander Shopov <ash@kambanaria.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, martin.agren@gmail.com,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 15, 2018 at 12:44 PM, Alexander Shopov <ash@kambanaria.org> wrote:
> @@ -160,7 +160,7 @@ int check_filename(const char *prefix, const char *arg)
>                 free(to_free);
>                 return 0; /* file does not exist */
>         }
> -       die_errno("failed to stat '%s'", arg);
> +       die_errno(_("failed to stat '%s'", arg));
>  }

The new ")" is at a wrong place. It should be %s'"), arg); not %s'", arg));
-- 
Duy
