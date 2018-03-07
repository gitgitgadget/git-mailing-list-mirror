Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC091F404
	for <e@80x24.org>; Wed,  7 Mar 2018 21:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934062AbeCGV4v (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 16:56:51 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:45793 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933780AbeCGV4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 16:56:50 -0500
Received: by mail-wr0-f182.google.com with SMTP id p104so3676248wrc.12
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 13:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=gdLrnqOXVuOWZEzlB6Je4O13XaIbrSVKXWpOKjCrcjU=;
        b=geu3Lc+Bm56NDXqI8ecXs7zoxJfCq895ss8lOS6baUHmfK0AltYF7xoT3AeJMHTJSf
         Xm0g44rMtzxPNFYqA7TLonZejIVtBhP6faIDc2NpFVqjVymd6BtSFfiJmOsReOCWL6Dh
         AW1x/ybZx08b6N2uBVImFp0x+GLlrWjWNikdJO5k1adZZo/YhespHNZhNHc8JErdRIQi
         0PkR9lrTkaNMR50qgkQx/cjmtvdAllavPf7f0bq/TmCm0UBDHKIL2JGfZRahIVT1N5xv
         JWg8WwMDlSVUKJRePtaI5OfkUCi5+p2NQQGALJQIID58fSHGihORmVt8k9qKVe4RwDaU
         8yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=gdLrnqOXVuOWZEzlB6Je4O13XaIbrSVKXWpOKjCrcjU=;
        b=HZDW/+EeEkV3BCitTuzvNDxp1QW4Cq3ilhRC7ymhh74bKdUJiYhbwnrLqEyTwidvex
         gZlC1AsdS0nWqRT/4TkyTSEP3lflIN/BjiStDrxbMe3hQLwEm3Be7vlLkt04162ffsbp
         okt4LdE9J0Z/Z/3J2czLb9BZ3viHbZ+aJKV7iuolK743aCNh8xs7A3FSQh6c4o/gwEts
         kbA6uKuAQ6mZaCfwuM5FxXR4DwsdumLeOUwrtLpiwkElWePZkNd2e121cMYIRLqJlCLd
         EQ0nAUlS2ngVAEDl3V3B8ATOe7vwwIhGraNIG/YeUgkRaxLtbtUmbZOdld2lqeTVAwKJ
         RRKA==
X-Gm-Message-State: APf1xPAP76PsQnwELDY9/glgu7wMyaKP9xCv8EMnyeZPIRn8Fiu3Vvg0
        Ycz6wqdoQYv4TGf0Nxn0IfjAJpAq
X-Google-Smtp-Source: AG47ELst3wIkKF+PXGiqm7bTW3i/+AJ2FQqIh9V6nXUEcYFMqj+KkJA1GAEzaTbZeMS4d8qCqkSOsw==
X-Received: by 10.223.191.6 with SMTP id p6mr19707950wrh.247.1520459809432;
        Wed, 07 Mar 2018 13:56:49 -0800 (PST)
Received: from [192.168.0.104] (AToulouse-658-1-177-54.w86-199.abo.wanadoo.fr. [86.199.164.54])
        by smtp.gmail.com with ESMTPSA id 142sm15268309wmq.47.2018.03.07.13.56.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Mar 2018 13:56:48 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC] Questions about "convert interactive rebase to C"
To:     Git List <git@vger.kernel.org>
Message-ID: <43904e83-4ada-a550-430d-b70364bdc567@gmail.com>
Date:   Wed, 7 Mar 2018 22:56:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was reading the email related to the "convert interactive rebase to C"
idea[1], and I have a few questions about it:

> So the first goal would be to retire git-rebase--interactive.sh. For that
> to happen, --root needs to be supported first.

Combining rebase -i and --root seems to work fine, am I mistaking? Is
there still work to be done here?


> And then the
> command-line option parsing needs to be moved to rebase--helper, too.

rebase--helper was originally made for rebase--interactive, and it is
still the only script that uses it, according to git-grep.  If someone
rewrites rebase--interactive in C, why parse the command line in
rebase--helper instead of retiring it? Is there other plans that I missed?

Regards, Alban.


[1]
https://public-inbox.org/git/alpine.DEB.2.20.1609021432070.129229@virtualbox/
