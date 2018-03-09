Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27CAA1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 20:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751227AbeCIUSK (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 15:18:10 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:42163 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeCIUSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 15:18:09 -0500
Received: by mail-qt0-f172.google.com with SMTP id t6so12327084qtn.9
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 12:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WB+E1EwGRs92XNjareLmGoL1A1aXD2wc2MjMgqV9r50=;
        b=T3h+NhTqJ4Y9u6q+wAfzdwl5OXxbFczU2oumSni8usenucKw6ZQNrFzBRpLq8JJjnQ
         RC2fR5SIu77pf5RTokGPw1ctrjmo43ihDbLiPxjIUXg2Kajua40RQ6yx3MQu9W+aW4lB
         lZe2wreCtV76vMwpDJ031+QZHsmsZbZOAZRGH9c6sVNvJpuT3FExy/eV0z+y8afAKmzh
         5Bk8gg1R6xyqV/utmeQ9VNfCDQzKwf/vNXO4t7EncHnf3Ejdj0zZ1+QYgfxUazZZHmmg
         6fLgvVHHh7MDCBUt7zq3e76zeA9+u6dCDxZDabZvz9IG6zytxh5BSG56z5q279M7p4Bs
         KBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WB+E1EwGRs92XNjareLmGoL1A1aXD2wc2MjMgqV9r50=;
        b=OjEpFKyhaJUl0X5B8K2r52vzU69yWGV92rUC1U3W2ihyLl6NKND8Ro4UtRkvoLaepC
         EhZv4tXHpALrJ/b8bsEKtRsRxkqeW4R6+BIoK1SHb4dEIdTkkTbuhLrazuz2OMhu0JJe
         2uaXwuh13e2nwqOFRXCtSo/vsdX2y/Hkb6X2MZdj7QoAtI4VSWILhLZ/TiqTL+VaJFpS
         NqTYNBQ7gT12Pigqurbog4QAldKYt89VY73TtRFdHu2CmkyT2XZDbGCy+73AzOOvCFmR
         WT6qIKZDWD3/db09tc6ZJULcUNCcx6nD3h+hDn28XuOoNa8mU1ELPB5Xxwcsa/g+99/o
         Bqmg==
X-Gm-Message-State: AElRT7HJhgsOVmsJRTTltNceOkzg/QiswviTo7Ppkg7GzMC+l5UEAMVh
        ty/q4RcHjvS31SQ65sThf47yN0sceilTnEpIRaw=
X-Google-Smtp-Source: AG47ELvni6q57D1+lPyfzGvUwnt4jjlw71POhYLhZ9bfcarNFK2cNGUV/Ql3ug++CJoV3LNLOtjk6I4KtQsOodo6xPA=
X-Received: by 10.200.36.189 with SMTP id s58mr43208797qts.0.1520626688911;
 Fri, 09 Mar 2018 12:18:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Fri, 9 Mar 2018 12:18:08 -0800 (PST)
In-Reply-To: <20180309173536.62012-11-lars.schneider@autodesk.com>
References: <20180309173536.62012-1-lars.schneider@autodesk.com> <20180309173536.62012-11-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 9 Mar 2018 15:18:08 -0500
X-Google-Sender-Auth: wn8QHxbkR1lsGtVue6X0HJeNjBs
Message-ID: <CAPig+cTH7wmrBwiyBxr=D1g6dTw65ZRfGPX_ok2PYaMoGJk0Dg@mail.gmail.com>
Subject: Re: [PATCH v11 10/10] convert: add round trip check based on 'core.checkRoundtripEncoding'
To:     Lars Schneider <lars.schneider@autodesk.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 9, 2018 at 12:35 PM,  <lars.schneider@autodesk.com> wrote:
> [...]
> Add 'core.checkRoundtripEncoding', which contains a comma separated
> list of encodings, to define for what encodings Git should check the
> conversion round trip if they are used in the 'working-tree-encoding'
> attribute.
> [...]
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/convert.c b/convert.c
> @@ -1150,7 +1227,7 @@ static const char *git_path_check_encoding(struct attr_check_item *check)
>         /* Don't encode to the default encoding */
> -       if (!strcasecmp(value, default_encoding))
> +       if (is_encoding_utf8(value) && is_encoding_utf8(default_encoding))
>                 return NULL;

This change belongs in 6/10, not 10/10, methinks.
