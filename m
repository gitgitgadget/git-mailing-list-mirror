Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8848E1F42E
	for <e@80x24.org>; Mon,  7 May 2018 10:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeEGKKq (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 06:10:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42171 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbeEGKKl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 06:10:41 -0400
Received: by mail-pf0-f194.google.com with SMTP id p14so11104063pfh.9
        for <git@vger.kernel.org>; Mon, 07 May 2018 03:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ddfy+dit7EDK+Y8pYhtd1UDSkCuze0n5TJV77AxwaSc=;
        b=Nsm4TTMGLjGnxNN0qpjIiSCPmYzPH6SGpM+edP1q9nmomW/tikz6KYAiQ2hYotwGcO
         Ans+ZyIGGmmzbvPX8YyZTKTfuMRAwdwgrSqW8AAtwqXyeCAZyeXY2yy9ODSrruV26B4d
         oRnn48NrNgCCASRWYN2zG2k9ycrrB70iMOdECSv8UFQ9q2sImtFh/5d1hnzABBi0cUPw
         38m6ALmeXRKXdpGJBZle89hgnlrO2FfVkMLrgLsn/nCFYwvEJpD05EVoM/8vG9hYZmux
         QTfl/5TLNy2ByoBK4gcGgmEyLu7jve5ndfdUrgKRJz/yi4+miSWVw4h8vZ8jwWSpakMI
         07iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ddfy+dit7EDK+Y8pYhtd1UDSkCuze0n5TJV77AxwaSc=;
        b=LSyGBUPBlpwzqtAQLYkkh2A+zc12zLumSwtHXbeNXLuRRwemVhO7nqPtygXaCJJOcr
         /dfQ/1/l1Hrfc8NiuSRnkyAWf58tnK0KKC8ZkF7khJFkBLJFhJToi+CGfvbtgkzJ/uNs
         QshUW6S/h1BJwH9SdmGeGS9KoHarIJu8pCi/Fu+eC3SSdSj4ecrPb/dYK3Mun79xZDJl
         /cBmY31Kh7QZFsEv6FQ8pH/7gF/QDQWCVZS6D8E7neGW9QWveB0iPWlobias0iWkGcnb
         HfI4iQzwdDEDGyxTfg+uLS3nwYgH1TZQsaKR8kBDEmsP1LWnFWwNYUHkn9anVZUmtFus
         R+OA==
X-Gm-Message-State: ALQs6tBTldkKRRC414E1o3yHlg4x4tGrqEn9nyG8kfhCZHNO41juI2Hu
        vZd4nupKoenKkCMrHD9jT9dmC9Om6E144EPqx1Q=
X-Google-Smtp-Source: AB8JxZo5MgoDo4Pi2XX1VkywSqRWJMDAA+hhY+Nkzfi7GZZivsXuwtKDfZOhpVKXXcC3XApmi0P89Ii9JKFotTTIXbw=
X-Received: by 10.98.11.3 with SMTP id t3mr36382111pfi.32.1525687840567; Mon,
 07 May 2018 03:10:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Mon, 7 May 2018 03:10:39 -0700 (PDT)
In-Reply-To: <20180506231752.975110-2-sandals@crustytoothpaste.net>
References: <20180506231752.975110-1-sandals@crustytoothpaste.net> <20180506231752.975110-2-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 7 May 2018 12:10:39 +0200
Message-ID: <CAN0heSqk0siv4y5BGz2+sLhAyNG=TEZmgucKoCDGyx2i8_O+tQ@mail.gmail.com>
Subject: Re: [PATCH 01/28] t/test-lib: add an SHA1 prerequisite
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7 May 2018 at 01:17, brian m. carlson <sandals@crustytoothpaste.net> wrote:
> Add an SHA1 prerequisite to annotate both of these types of tests and
> disable them when we're using a different hash.  In the future, we can
> create versions of these tests which handle both SHA-1 and NewHash.

Minor nit: s/can/can and should/

> +
> +# SHA1 is a test if the hash algorithm in use is SHA-1.  This is both for tests
> +# which will not work with other hash algorithms and tests that work but don't
> +# test anything meaningful (e.g. special values which cause short collisions).
> +test_lazy_prereq SHA1 '
> +       test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> +'

So SHA1 means roughly "git hash-object uses SHA-1, so supposedly
everything on disk is SHA-1." I could imagine one or two different
meanings: "Git was compiled with support for SHA-1 [oids]."

Do we actually need more SHA-1-related prereqs, at least long-term, in
which case we would want to find a more specific name for this one now?
Is this SHA1_STORAGE, or some much better name than that?

I am thinking for example about a repo with NewHash that gets pushed to
and fetched from a SHA-1 server, see hash-function-transition.txt, goal
1b. We'd want to always test that SHA-1-related functionality in git.
(But only until the day when someone defines a prereq such as "SHA1" to
be able to test a git that was compiled without any traces of SHA-1
whatsoever.)

Martin
