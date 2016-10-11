Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CC8B1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 21:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbcJKVEx (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 17:04:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35913 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbcJKVEw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 17:04:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id b80so589451wme.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gzpIEiL4Vzd2Yb+tiNghaYBbMEdRwh3zOWP7xyuG7vU=;
        b=Znu1e0VAb5zMtlVkmB1M07eRRboFveJr80oGT1TUDcZcISgPrvEEEvGBP9zyXRxhaC
         0Y5j3PNwzYD2+wPLMpkI2SVqF9UxPQ8cbtq4vDDhU6GC5lAm9pyosKLUxd11RvbEmL/2
         8MoAESAGqCN+Y6gKWqHfh9fHgyScMoZpeu/evFeTpS3HCznYed++QV+Xj9cU1jWRsocG
         CZqJ/LDHrPetPGqQ7pO36sykJ0ef/I3LPBUYgpBNZea+90e5uJS+spo++RLTDIOfXvTO
         Q0JlkB/elralIH0DUUJUFpGTmpoKQBQQ+MFHCZjSTai5yStnBW8GT7Gq6Xff4SsivaoG
         nkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gzpIEiL4Vzd2Yb+tiNghaYBbMEdRwh3zOWP7xyuG7vU=;
        b=JqQASp3R0KNR6K4w4W4LHtEDbSLpjsJJm45Ko8GnxVeO3GExk4ffDiYxZ+EAoTgxF7
         M7ZdIg0rmqlqEzikVfXVMzgS1Y8flzVOBKxh0lx1ydSv1OlP894Xw5c2T49a17+T4+15
         sCvvGEWSP/Aujc/DeNgH0QRoxZdYqALEGh9ExlI5JYnF9nu3Jm8FWq3fdnmsgzkkJBNg
         pG5jQiaALZ2BkykI6ubRGtzqI4h5QCGBsoq1Z0gYP9pnJGBbOdFw7ZGEGlzz9MPwcKQn
         HwTvf0RsttOWDAZHdnIHJ93izvsjzZ4ZH/t3uOSLvUelK3z76f60Hx0k6+Jt+D47pIsJ
         1irQ==
X-Gm-Message-State: AA6/9Rn7xLgWjnF5Pr2t82JFpiloEVwfSlycZl3gx94duCauajGg248zDkzlvE66CjX63g==
X-Received: by 10.194.105.196 with SMTP id go4mr7026874wjb.60.1476219003369;
        Tue, 11 Oct 2016 13:50:03 -0700 (PDT)
Received: from [192.168.1.26] (adaq66.neoplus.adsl.tpnet.pl. [83.11.252.66])
        by smtp.googlemail.com with ESMTPSA id kg7sm8891780wjb.34.2016.10.11.13.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 13:50:01 -0700 (PDT)
Subject: Re: [PATCH 2/2] reset: support the --stdin option
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1476202100.git.johannes.schindelin@gmx.de>
 <2c7a52e43be710c7f37c4886629bda38df183c21.1476202100.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <dc76476b-9ad5-a3b6-f12f-33cda2ca5814@gmail.com>
Date:   Tue, 11 Oct 2016 22:49:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <2c7a52e43be710c7f37c4886629bda38df183c21.1476202100.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 11.10.2016 o 18:09, Johannes Schindelin pisze:

>  SYNOPSIS
>  --------
>  [verse]
> -'git reset' [-q] [<tree-ish>] [--] <paths>...
> +'git reset' [-q] [--stdin [-z]] [<tree-ish>] [--] <paths>...

I think you meant here

  +'git reset' [-q] [--stdin [-z]] [<tree-ish>]

Because you say "*Instead*" below.

> +--stdin::
> +	Instead of taking list of paths from the command line,
> +	read list of paths from the standard input.  Paths are
> +	separated by LF (i.e. one path per line) by default.

And die if <paths> were supplied:

> +		if (pathspec.nr)
> +			die(_("--stdin is incompatible with path arguments"));

Of course you need to fix it in built-in synopsis as well:

> +	N_("git reset [-q] [--stdin [-z]] [<tree-ish>] [--] <paths>..."),
>  	N_("git reset --patch [<tree-ish>] [--] [<paths>...]"),

-- 
Jakub Narębski

