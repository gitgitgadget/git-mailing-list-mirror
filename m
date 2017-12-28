Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 690DA1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 22:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754160AbdL1Wp0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 17:45:26 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:38452 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdL1WpY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 17:45:24 -0500
Received: by mail-qt0-f173.google.com with SMTP id d4so52639225qtj.5
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 14:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=aGC8Io5tRQsqjS9a/41xnBHNlLSMhi9mVD8ASmnTrL0=;
        b=NCMEtsbsYrmhvShj6pQS5IIzLCjmLODHPdk2x2Y5zsalNizzt41ImWsi2Z3GhcjzWJ
         hrt7IKbv4+t3oKf6c1XH45sKa8vsJXWs6OH+f2h7joIrDOnf6NiTRj6YrvS5aNbi+S56
         H3VDen6Px5W1Tdid90unah2JW6Nh5GvRb3DQeHaXy9uXPS0GgZgJUf8C61NCFxt/Zp40
         Uxf7QsBiGIAHXG6RH4Ss4qcLG6+nxhLcZPVmltx9ffQnqe6bnoRp8wXePzLSYqlTsxH/
         +JOE4gpP/24XBnCcRHbZaOUiQXggnlWLvT7j4dIe3XZsX+xB8cW8v/XQNQbjUEgBKS6e
         L7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=aGC8Io5tRQsqjS9a/41xnBHNlLSMhi9mVD8ASmnTrL0=;
        b=OPDJFvSFI2sYhD01Y57tKAixDlIIiwT5F5TwwO9QRf4MVx8IUm/rmQJRsCfHjHSCp8
         LsxwH0OSF8BaKSTF1+fLZjAqrUqz4kSFER0sbCsku89cogmBDfdU05Swdxiqn+em22zE
         ZS7Ws0OInAEFw9vsVRQmL524exYhv+mvqR0cCuWNjyIKSvGG2FY8dwLYfyb36fYz5dM0
         dfzjc95BVMtJLA/6z1TTa5rjk6LAPldJjkX2ay5rUQKP/TMS6y4K90UOC20JV0x76foZ
         sb5EBtGz3oE3kvs69SOTgu4sTZ23jUI/S17VxvO0H5G+eoHCxCfbYtunO3LK000EKDb8
         wm6w==
X-Gm-Message-State: AKGB3mKQeCEWwZcJ7OzeCplOlO+2cwdSUPtE9BegzwXLjVh3BSwfsIoH
        +io0DnQu2h56Ti9XR1whKrUDCgizdpERlfa9W88=
X-Google-Smtp-Source: ACJfBotIJK4zAkjgM/Hbo3QU2u3DtxCXIPByQEREUoTH8JEZZQPUpgPsPpe23wpj5aKJhjAEh9ExShOpwhuBXeD/h3k=
X-Received: by 10.237.35.37 with SMTP id h34mr46612980qtc.9.1514501123899;
 Thu, 28 Dec 2017 14:45:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Thu, 28 Dec 2017 14:45:23 -0800 (PST)
In-Reply-To: <20171228210345.205300-5-sbeller@google.com>
References: <20171228210345.205300-1-sbeller@google.com> <20171228210345.205300-5-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 28 Dec 2017 17:45:23 -0500
X-Google-Sender-Auth: 4Hkl8v-2PfiuCbahahtLex5kX5E
Message-ID: <CAPig+cSSzqdACu45tMraB7fzD=h+RMrf7WZ4s454i9qys7ATJA@mail.gmail.com>
Subject: Re: [PATCH 4/4] builtin/blame: highlight recently changed lines
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 28, 2017 at 4:03 PM, Stefan Beller <sbeller@google.com> wrote:
> Choose a different color for dates and imitate a 'temperature cool down'
> for the dates.

s/for the dates/depending upon age/

> [...]
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/blame.c b/builtin/blame.c
> @@ -777,6 +847,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
> +               OPT_BIT(0, "heated-lines", &output_option, N_("color lines by date"), OUTPUT_HEATED_LINES),

s/date/age/
