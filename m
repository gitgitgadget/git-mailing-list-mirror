Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DBC01F406
	for <e@80x24.org>; Thu, 10 May 2018 14:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965967AbeEJOXP (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:23:15 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:41455 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965340AbeEJOXO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:23:14 -0400
Received: by mail-ot0-f170.google.com with SMTP id t1-v6so2483255oth.8
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2RHeLVFHeSQ4yOPnjPenDw9t7mj70rYYaEcpKynn0R0=;
        b=rCpbl9AZdHU9Uv4pXokBxxFQVp/4Y2kpkGizDyWJe5GhXP7WJUxbFu0suAYdqvpnbg
         aWw1dyCMv+O6fpYYhMsauJ/0tLO8t66UlRW1VLVJqcMe34o5x6w29+nF9lctZ0agVYIB
         jIfaj1VWTFEaScfb8Q4Aoekk67lossF6v+qxs0gvyWtAsmGWb0IWH6gb9fRBGnuDStOd
         PSdSOXvSs8UxbrEQHc8FoOEWkB1qyzhWmeZBfE+Q8bqp8SxEQHmxolMkHFX0uW3Dw7SW
         d0Vy/xned1JhtaKf3sQlICOZRL2X3037NNb6bvc8aIk0qQbYbQy49n188vQiR1Fy8uUp
         +RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2RHeLVFHeSQ4yOPnjPenDw9t7mj70rYYaEcpKynn0R0=;
        b=JU4t3+EjSD24dlRKmm9ga92tpDba0nkKFm21agsVYtWCvhZ1URXUBEu6y5g0hlQOQB
         vJOesEyQke0cQR9o/Q17geh3FMiy8mR3Bh3ERILpSESWG6UVzWSWoRIjGLwb6iWX4mGf
         2dh6p+JaPXb5J/EYtIfzfRJ9hHIWXOJp2wE2NND2DenbTUWHvLVyA/QwVU2w0p+XRHZ9
         HMwMEA9h4mZBhEcmBOIV7dT29MkiyNAsrBNVWoBPEHq7TgSoOYyLp6HedISPRq5YBc1m
         P4rcp6Ioui1wGuua7yjgZA/tmv3Yb3j1VILJSsU5YnArRgsBrLbTKR8WdjJB0ccTYWP5
         4MCw==
X-Gm-Message-State: ALKqPwdFNFMJQb83qu5+SznGU4Brzbc7NrRGYn9v8UTFkNby0brAuwpY
        9CjjyhlhcHe0CaD7hYcTerkSnXFlpSE4SCyLVMo=
X-Google-Smtp-Source: AB8JxZpKTL8qskWLwuCBt/5DdT8lbDQigOKMgGHMsEy0ZdCf05B1YCz9uc0WKIORL09v7TV+z9DFteYh2Aa6kv6Zw00=
X-Received: by 2002:a9d:e8f:: with SMTP id 15-v6mr1166831otj.14.1525962193607;
 Thu, 10 May 2018 07:23:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Thu, 10 May 2018 07:22:43 -0700 (PDT)
In-Reply-To: <20180510141927.23590-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 10 May 2018 16:22:43 +0200
Message-ID: <CACsJy8CvbZfVK6TdQAGMGfBWiHuRcVgxQ-MEPNQ_Rcmf1EnFtw@mail.gmail.com>
Subject: Re: [PATCH 0/9] completion: avoid hard coding config var list
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 4:19 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> (on top of nd/command-list)

Oh.. and it does make use of C99 designated initializer feature. I
could go with out it, but since git-clean has used it for some time
without anybody complaining, I figure I should take advantage of it.
--=20
Duy
