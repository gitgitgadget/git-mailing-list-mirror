Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C361F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbeACACp (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:02:45 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:47073 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbeACACo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:02:44 -0500
Received: by mail-vk0-f51.google.com with SMTP id m15so32516vkf.13
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XB9eOImMkYrabIVCadYtbqO9hRfmxytFm0azF0xgclg=;
        b=JvuPFGPiWqYdxIIxR+Nm0qdPUYlleOzE0qlZk3uQ7Y2MiqKQPTeo+vMELUp/0B9A56
         cE2cYPn1cqYYu8UE4p+0chl9pA9IVAQ+eTnZfutSWZWGjcZPrli9mEyW5JuF4pQjSy7O
         5DpTu0P5oyaXWUPpGmEKktleqYWpyXOI9rNTLYCIHRWijmPiOqePO3aNQV5FkMv0IQdL
         RvvYH8OqpbQ8FJOifT9qL08uNUuBaW/BNeVPZYeCKHFbupUDcPDLUboMpHnMmCInH+d5
         XM5WxMl+bMXASwf/wfRq6j+d2nCETLDucShkunLZK2mWaveXkIEmXz7NoW55YtIBHEsc
         60bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XB9eOImMkYrabIVCadYtbqO9hRfmxytFm0azF0xgclg=;
        b=pPxm6foXEnfPHF3hay7+OEKfuHqsEoJseCpYlP6CJtEg/Y9iB+hUJS9XsD+M5N2KdJ
         OBuWu2Vm37OiBXRpAmmDtBJ5GeASn9618YdQqJIKR5Sej8hqwCKEnx7N9QmA6DHgtEv9
         z5YX9eH8yu4sWe1XYDxyVyPym64C7FjNHgnYGGdhJ3d/qcwtamBxO6SOTzSlnlUDy1GC
         tqLd7GqCq1UUoeyhf8SKBvEnyBEmA2vJWRncIhq1qgwX4IC4xAZMpRv7rbi/TJZTgT7t
         KCyKrHNpvSuZVzAfKGfIM4YbgkH2R4XzLJxXoZ++j2qdVZYvGzqboPcAM/l0/hwNhWJp
         Zsjw==
X-Gm-Message-State: AKGB3mJ1y2GlntNm8nMB3dSAYrY/r2TTpbrvzaZTcJOO/EToJZeb8zmM
        k8Vb/l8oKb4Rwqwn17JOzWRobz+RhZKy7PJN5CAODg==
X-Google-Smtp-Source: ACJfBou8j7E41gKijTyqbFEufsQskPij2s4rzZ6/zkEGVGIABsG7XJFeGmNW6oOhg91JzRDg5MJ3fACp1m439Zb4DSg=
X-Received: by 10.31.150.79 with SMTP id y76mr40249301vkd.183.1514937763901;
 Tue, 02 Jan 2018 16:02:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.82.5 with HTTP; Tue, 2 Jan 2018 16:02:43 -0800 (PST)
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 Jan 2018 16:02:43 -0800
Message-ID: <CABPp-BEnpm=OEXZXMeuaxBaOLimucoEKH643jm516YufrtQ-iA@mail.gmail.com>
Subject: Re: [PATCH v5 00/34] Add directory rename detection to git
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 27, 2017 at 8:13 PM, Elijah Newren <newren@gmail.com> wrote:
> This patchset introduces directory rename detection to merge-recursive.  See
>   https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/
> for the first series (including design considerations, etc.), and follow-up
> series can be found at
>   https://public-inbox.org/git/20171120220209.15111-1-newren@gmail.com/
>   https://public-inbox.org/git/20171121080059.32304-1-newren@gmail.com/
>   https://public-inbox.org/git/20171129014237.32570-1-newren@gmail.com/
>
> Changes since v4:
>   * Squashed Junio's GETTEXT_POISON fixes into the appropriate commits

As per Jonathan's request[1], shamelessly re-sending Stefan's request
for further review.  :-)

Quoting Stefan:

"I have reviewed the first three patches (which could form an
independent series)
that it would warrant a Reviewed-By: Stefan Beller <sbeller@google.com>

While I reviewed the earlier versions of the later patches, I would
prefer if there is another reviewer for these as it seems like a bigger
contribution at a core functionality.

I cc'd some people who were active in some form of rename detection
work earlier; could you review this series, please?"

My note: Stefan also looked through the testcases pretty closely and
even suggested additional tests, which would account for another 11
patches or so, but extra eyes on any part of the series always
welcome.

Thanks!
Elijah

[1] https://public-inbox.org/git/20180102221916.GE131371@aiede.mtv.corp.google.com/
