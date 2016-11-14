Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0137A1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 20:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936411AbcKNUA0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 15:00:26 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:32934 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933969AbcKNUAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 15:00:25 -0500
Received: by mail-qk0-f169.google.com with SMTP id x190so109705870qkb.0
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 12:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vgFp76eqGJ9ASSx+m5FDn3TJ3htUgDMYRr7+4X/iuAA=;
        b=oh3PuHcBr1pwTPv0I9LfKddv6enWJFPv7+lL+bzi+NPOHvlkLaxmUKKOZrH7ooW72M
         fQlP+yEPeplbs4QBqVwRHjpwpF1C4BV2m09I8pg+najF9JG6VOU9bbJdOIq0Oh4mBgXS
         0T/fqo8AWNyg1HZmbsPWFG0CKzi1OOtIGk5VNm3g0sq92pP3xan8INWXhtyDaakkBdfd
         86LPagdwS+MMCJXSQcNyh62aIa8BRlPBE0l9xUGNojFyTR4kLKQUJsbOeVhXcXT+W5Bb
         carVZNtqT7Ykj5p40L72ILyN+fLWJBVDGzwYhSmM/DuTj+bU5X3TwSGyqyF5LvPrq4+K
         hcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vgFp76eqGJ9ASSx+m5FDn3TJ3htUgDMYRr7+4X/iuAA=;
        b=PNMNurCeIhTtTDyff6TGpLxhHLrqYNLPZexAemjKbx5HQ7hhYgZaym8gwUhOoPZ2om
         10kYnZzkY2CJnllkmuyq8E9OZyQMi/pf8fXq7FbWTsAhQvJWUZ3gOmtgdk35oTJWXfh2
         a6oKzXoUPWogjbwWCFQ+nC0F2Pumzy2X4JtbwHnF9YMMNN2tHohwJAIatGWeR+KL4iRo
         X1HLNoBJoG0H3SkG7mTlz7as1xa6lgku/X2SO1pmYJ43dSbjo1CGgnUO1zEw79V6sk77
         1B9YnFsQiPcRtESDhH7aKBx6Q/Wcdb2W/4MjFngOJhCEvRF0TH58/p5Dx/YeOmheDdnL
         TN2w==
X-Gm-Message-State: ABUngvd7KYBdNl0f6QacOvyDv9j44YqpFfRslhFiVqGqx4RPMvxo9k48grEkHk0g3O2OdezU6KCgFej439svIVTT
X-Received: by 10.55.191.134 with SMTP id p128mr7525418qkf.58.1479153624230;
 Mon, 14 Nov 2016 12:00:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 14 Nov 2016 12:00:23 -0800 (PST)
In-Reply-To: <83508d1f-e809-f6be-5afc-4c23195dbd08@ramsayjones.plus.com>
References: <83508d1f-e809-f6be-5afc-4c23195dbd08@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Nov 2016 12:00:23 -0800
Message-ID: <CAGZ79kaDK3syiNKvAKQf8q6AtcoXZuFz8fvxGZTj2Ced+Hu3Pg@mail.gmail.com>
Subject: Re: [PATCH] attr: mark a file-local symbol as static
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 13, 2016 at 8:42 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Stefan,
>
> If you need to re-roll your 'sb/attr' branch, could you please
> squash this into the relevant patch.

will do. I have it applied locally

>
> Alternatively, since there is only a single call site for git_attr()
> (on line #1005), you could perhaps remove git_attr() and inline that
> call. (However, that does make that line exceed 80 columns).

I'll look into that.

Thanks,
Stefan

>
> Thanks!
>
> ATB,
> Ramsay Jones
>
>  attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/attr.c b/attr.c
> index 667ba85..84c4b08 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -169,7 +169,7 @@ static struct git_attr *git_attr_internal(const char *name, int len)
>         return a;
>  }
>
> -struct git_attr *git_attr(const char *name)
> +static struct git_attr *git_attr(const char *name)
>  {
>         return git_attr_internal(name, strlen(name));
>  }
> --
> 2.10.0
