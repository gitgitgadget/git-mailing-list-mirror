Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFB8420A28
	for <e@80x24.org>; Tue, 19 Sep 2017 20:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdISUhT (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 16:37:19 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:53165 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdISUhS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 16:37:18 -0400
Received: by mail-pg0-f49.google.com with SMTP id i195so452105pgd.9
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 13:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZEo6VSUAlJdmFpuzlQPMHyrDpIvjbwdR5TAqTKXbhUE=;
        b=TAJGgdJuCAtUYwgdJ5J8+DcNAoshu9ztb1h1zOnL21Tchrd/u2HDHV2Rx8uVfPKIqC
         AKSewlt+jq4lbCFmFN7l3eEl5Ivc5Lgj/yakebqA3MW9DCgvLtKwrI3sXjXsATQSyndS
         0is+VXaZH5E41njmubhUUJVQ8KyRgL/CYkGxBzey6Ez7oVQ8dUuGD7YDDWdYQ+WiPb2Z
         c0ZZblLzK6susG63WGe1OoMHUxy/ha1H7zvjZL4mktppwL12IU3arvDzxeldGhY9pdUy
         SfmCNo4kRS7TMNPXwKUAlU2bYVxG0a83FV6ARgEgqdFFYeIbK0EyjUmgmMjBhc1Ysvfb
         nvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZEo6VSUAlJdmFpuzlQPMHyrDpIvjbwdR5TAqTKXbhUE=;
        b=hPQOksP4UDkh8Xf3h1u00XBKxPVY7bbbRjscrIcu6i0X8lZ0y0eAjRVobAMqzoAYiY
         ydApkzkUk/EEy2fYjUrstdouC6NJm2H4MYIegrXIqtJeDDSb5AYXlUW63UdJDQ0dZ/p0
         npgzavFQ9Yefxp8ZQduEWxVNARnQlzr17PqJypb97YvvzYvQzY+YyhvusDhVckfUqT/v
         nM2tkewgKhU5dEXJM0LUSZcue2x6L/oXMMJuHCTtotEaPQCuAGqRnzZ+br66lfa4MTgs
         7uCD/Hb8W1/1nIj+mBrWGLZoD3NalZ1+DweEiOsoGWOFr/5awGx3/QlrszErN4WOhZDZ
         +FtQ==
X-Gm-Message-State: AHPjjUhyTAzQALFHHYfW3Vbzp+nopdqIf8BTQNGsPZMr1o7jjB65u7pH
        PF8Ashd0TS4aiYdsSRY3OuI=
X-Google-Smtp-Source: AOwi7QC8r9++2KCYCNehb3nddObuY0K5KaWtrirYxof9ytSFldcRjfWljj3RuDx7Xq9/Tbi+OFOTnA==
X-Received: by 10.98.74.4 with SMTP id x4mr2396113pfa.222.1505853437609;
        Tue, 19 Sep 2017 13:37:17 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:ed67:93b4:3411:bf26])
        by smtp.gmail.com with ESMTPSA id h10sm3503663pgq.86.2017.09.19.13.37.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 13:37:16 -0700 (PDT)
Date:   Tue, 19 Sep 2017 13:37:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/1] test-lint: echo -e (or -E) is not portable
Message-ID: <20170919203714.GF75068@aiede.mtv.corp.google.com>
References: <ce17a042-91e4-bf84-d9e6-36a9e99f3644@web.de>
 <20170917054318.28560-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170917054318.28560-1-tboegi@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> wrote:

> Some implementations of `echo` support the '-e' option to enable
> backslash interpretation of the following string.
> As an addition, they support '-E' to turn it off.

nit: please wrap the commit message to a consistent line width.

> However, none of these are portable, POSIX doesn't even mention them,
> and many implementations don't support them.
>
> A check for '-n' is already done in check-non-portable-shell.pl,
> extend it to cover '-n', '-e' or '-E-'
>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
>  t/check-non-portable-shell.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

An excellent change.  Thanks for noticing and fixing this.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
