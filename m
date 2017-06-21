Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940F620D0C
	for <e@80x24.org>; Wed, 21 Jun 2017 16:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbdFUQdD (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 12:33:03 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33421 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFUQdB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 12:33:01 -0400
Received: by mail-pg0-f65.google.com with SMTP id u62so23331307pgb.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 09:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=O6IRiL8iE87psJ0OFFvSR/Xx1AODtt16OrcxZw2DGFU=;
        b=gH7VnLQLCnyei6mtsioCB/9OyCNmJNvqyUz/PmZVti0o/Kz8g1xL3gla2O1BBNuyGC
         CSlxFkNC5uCOqR/xpYsgOTIsUIBtHLyJ9Ba5cmFY6k2eA4NJOcOGfDe9hPis/tDjWWo9
         ve6Kk1LJPmnzbDOlrI/aQn8Tsgo2GxjyxX58NXT4z64USK9+bYvq1yh6XGSO+kQa+WVR
         J/G9g0IlhT1ZtFe8VVTcQGOBz6Q3Nd+5SZVEd0gZAMz/A73eRsGaP9bg3s+rY48kSrMy
         DnwNV/n12al3pR02RnOZN1ytbnbOKnplqC0JlUch143BPOHLcj53e/9ZCCx0vfPUzaAY
         7csA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=O6IRiL8iE87psJ0OFFvSR/Xx1AODtt16OrcxZw2DGFU=;
        b=RkXNmRJ9GGEQ7WIVWpr3yxXhCyPCHjZExl9CZHW9S0UoCNpTkaXA3OAjLCHtc9A8LH
         Jxupn3GMlEYavGVjtk48eBlbhTqpcGq4UFbhTGrhZhMoymGyldym8QN/p29CKCK3E90O
         a0Bf7geXtd7LN/4vo9FS/NZu3j7k/c1wDewPDi6i+1gz6mUFLQ9PS/jhK4OMN9gI/CE/
         YsNmdyTtNScWEEFoM9jFp/VwboD6aOgbNZ04P8piUioiw33BYD4RJPBemTWH4BYqyNm1
         FMUaX7ObKgjIJXQWU4gKB7uiPX52f7nG3+wNauatr5AqenMVESgKdtzLopPvQeXmtiro
         ZpAg==
X-Gm-Message-State: AKS2vOzF/5FCHd8zcOJOQXADqWzLFWbjjWL+JCDqXoST4D9sZlc3vV/n
        XVuVVFXjKBgSBw==
X-Received: by 10.99.176.71 with SMTP id z7mr7577702pgo.78.1498061490347;
        Wed, 21 Jun 2017 09:11:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id y28sm34068312pfd.32.2017.06.21.09.11.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 09:11:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH/FINALRFC] Documentation/git-submodule: cleanup
References: <CAGZ79kbMhQpxUa5TXK=WCzzKUCZ5vx3oC+fFTTozpgQihsUjTA@mail.gmail.com>
        <20170620031214.7616-1-kaarticsivaraam91196@gmail.com>
        <CAGZ79kbJx4p2y6Vjp3dVBP2pd=MYa_j3Mxfv=zUygHY-bHj0wQ@mail.gmail.com>
        <CAGZ79kbJB8dFUYu_70TAYbFWxLQiACEWMrE8M71GSEpnXqqzQQ@mail.gmail.com>
        <1498014140.5419.3.camel@gmail.com>
Date:   Wed, 21 Jun 2017 09:11:28 -0700
In-Reply-To: <1498014140.5419.3.camel@gmail.com> (Kaartic Sivaraam's message
        of "Wed, 21 Jun 2017 08:32:20 +0530")
Message-ID: <xmqq4lv9s4lr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> Helped-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  In case no other changes are required then this is the final version
>  of the patch.
>
>
>  Documentation/git-submodule.txt | 49 ++++++++++++++++++---------------
> --------
>  1 file changed, 21 insertions(+), 28 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-
> submodule.txt
> index 74bc6200d..6e07bade3 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -63,14 +63,6 @@ add [-b <branch>] [-f|--force] [--name <name>] [
> --reference <repository>] [--dep

The patch is heavily line-wrapped and whitespace broken, unlike
previous patch messages you sent to the list.  

Did you do something differently?
