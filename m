Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD62B1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfFMRKy (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:10:54 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:35088 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbfFLWeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 18:34:16 -0400
Received: by mail-lj1-f171.google.com with SMTP id x25so11964235ljh.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 15:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wOJnm5G7y6TOzy2M1X48An72AGdG87PncM8NTAxF9Ds=;
        b=GbtQexkc3lgisu06w1gmYV2FlOkf2HyMlsCGhJansPfxwZJzfPabCUco6wdi4TsSjJ
         vx5hDAWqYxDJiT5TP+dekWvPXfybG+rWFqBYbz+Zre2fNWAmyoo7tNHCMP7ZAa/ER+bU
         8KvAUHi+5uvFH3uQo7eaWhhYnAYCvm+HZXuesZlKT0XephohVi0moF2t7pOwFXJoYuRS
         NLzDb3nsc9Y6D9DhjALCi3eyBq9AnUHhmm9HGb0uvy+Ir8X/hLbYplWLv44fryb9DFJW
         9TRKBqTqPYPYbwRPak6iQmDFb/oYcAPcNp+CX9tjElx05ZXV4EJKZ6NDWKWkbX3jG1Wh
         NsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wOJnm5G7y6TOzy2M1X48An72AGdG87PncM8NTAxF9Ds=;
        b=hHtA6POQiMAnyFmN5ECCIKantF6v98lxrI1Wa8/nPv9enJ6CZxnMdP3gsKG/tNIwZ4
         U+SWieHFEVSqDwxTr6R3u/+/i8mhXUkQCZHXtkA2FpCUdRmz+DRd+96dS5NkMul9NEdh
         lZycTpDSib1d+tYCJr59KUjAaE4QCZgR9dH61/Jv7hAwW93/ipcvRRQQI/vjzHWfnPpt
         tzAFGWVI89Zgm+Pn1z8QhEg1nol8hLK+ZCDBr2gzGWasws+rfS+vPmBFDvl/XM+IJ5kJ
         ks6l8Ii2JoyKTEdrXdx5PEMLgGOiXcjSzw3JKLEy23spdpoP+8z9DpYLQRjGqV2Ol6X6
         Kbhw==
X-Gm-Message-State: APjAAAWXwcGaHlHkc37Hcl1Ay8g3VtgFgPCEjrfvOdtaTmIJmNDk3RYC
        I0vJD8raLDTosIoB3yZ880POeFefmm9z0W+qyh9qjYg2
X-Google-Smtp-Source: APXvYqwxl/qFcSvA0bd1Mp43eZNzgMGaYJ/C44nC9AJWcusVReUemu7ueTaAXjfPLldbUOYhWc+TUoasQi6gRm9U99Y=
X-Received: by 2002:a2e:8716:: with SMTP id m22mr45534494lji.128.1560378854295;
 Wed, 12 Jun 2019 15:34:14 -0700 (PDT)
MIME-Version: 1.0
From:   Pedro Larroy <pedro.larroy.lists@gmail.com>
Date:   Wed, 12 Jun 2019 15:33:43 -0700
Message-ID: <CAC_CU1iWBCTt5jLQ0Zp2HoyA0oFgG3shDB2rLfOsmC+x67NdAw@mail.gmail.com>
Subject: git bisect should return 1 when the first bad commit is found
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I'm using git bisect, and for complex reasons I can't use git bisect
run to drive the bisection. I don't think git bisect bad/good is
returning a different status code when the first bad commit is found
and this would be very useful to stop the driver of the bisection.

What do you think?  Would such a change be acceptable?

Thank you!

Pedro.
