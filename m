Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A39EA1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 23:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbeJLGba (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:31:30 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:33802 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJLGba (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:31:30 -0400
Received: by mail-ed1-f49.google.com with SMTP id w19-v6so9803453eds.1
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxznLojTlZswBiND5q8ogOPdbyr6h/Ysj4nvF4gI3bc=;
        b=NCH5W+wkMHFUtgwDdBkh9F+asariPJqwuJUZWogbgc8kMu2/xXFc76RbPoIF+TquMe
         eWbgZSY2X64Js2tFrnNikoRwTOM4bnZ5N3BECtyXSB0T4ZrJh/ZLGaB9VroGVSGPofeZ
         GQl4H7A6QtchK+ufAfEVeHg3FD/XJZyYFCdZJSnbryrNTfGr2Qdc1DF61f6isz9kGDD6
         lr4J++d1cMXhXStzloIg3o8quP1/Rs+S/+Nzq/fRoG9ys3Isngtab8+W2APSqOiEshVG
         MdaBdbVKB7ZnifhxsD7TH1a0aBJt/8KYFW4roY8eHX0hhlnrPeBhArprCangHyfrcT/d
         BkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxznLojTlZswBiND5q8ogOPdbyr6h/Ysj4nvF4gI3bc=;
        b=R8aVByJtZR3F87n8db7F0oabV/qQwMPhwdyP9mtTborMNRlwnF0XM1K6Zy1U5BGAHk
         jPL8x4a0HbceSiXD6IYlQ7TATuQ8bOMa0vRC9xqCbHimi6FBArs9qwFvOKcVJoJnvzO/
         G6Z67sH6O+L6H5mhGABYCxHBVEV2bOpGBeTitHjBDFhf+epfmlTCPHoWILD5VXdKRzG9
         MieFtxL6DihjzPbbtesJHtqGPc7Snma7JJaN7gJqGesvo8EGWlnaLLyYbjccFzKIjlzd
         sbc/BsyA/Kb3ilb4bUaKPz0wVmN2bXVq4rmTL5PIjod/5zfacsOQ7NX3qU9fbvbyonlj
         +2cA==
X-Gm-Message-State: ABuFfoiQ6NCdLnAZUDuzEbDMCipuirZ1imiB6FjIcWeyL5R3m2JTjagu
        p+4/fb2/Xx7n4b7MxAjv6hcvezbE0kyWZpd6kRExvw==
X-Google-Smtp-Source: ACcGV61HtAQ+ZJdW+T6h+nGs8JqR2k7hPRozEEe3npgC/n9pUZmd7HLDrIYgYNDZeB9gnl7hbIGRcqA6yvQdD+LX2M0=
X-Received: by 2002:aa7:d709:: with SMTP id t9-v6mr5565897edq.231.1539298923010;
 Thu, 11 Oct 2018 16:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa7nkf6o4.fsf@gitster-ct.c.googlers.com> <20181011225928.76051-1-sbeller@google.com>
In-Reply-To: <20181011225928.76051-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 11 Oct 2018 16:01:52 -0700
Message-ID: <CAGZ79kbpHB8QPXTRsZhnxrrTm=P8Mg3CHpvZB+G1E7BmFRv9sQ@mail.gmail.com>
Subject: Re: [PATCH] diff.c: die on unknown color-moved ws mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, phillip.wood@talktalk.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 3:59 PM Stefan Beller <sbeller@google.com> wrote:

> -                       error(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
> +                       die(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);

s/ignoring// as it was sent in a haste.
