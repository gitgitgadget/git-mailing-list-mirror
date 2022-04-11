Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36159C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 11:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbiDKLNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 07:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346090AbiDKLNM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 07:13:12 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E139D9
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 04:10:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u18so7221351eda.3
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=anhS78osYJqAXSVji6gtcsE1BSoSKmAW17g1Tq4g11U=;
        b=Ggc+mCS7fr6JWiIcbrg1WbOdHvzoJfDJXsfKqBd0WnncxkQXJ6M+IZddldtjc6UzFr
         fX/6xVfOkP9nZdz8KnSZfrFDKM5wrM9hLlIJ+s5i384XZffnLehL4TF2G82mxBbhUtuu
         Km/CgPTopu4V9Zws1MPFn32L8kYcxM7NtRIoSnxtYSermOv6M+C7WPmGER0sO7Z1aEk1
         IG/nDnWtXfDoUyZiCXMf+UipGwQO8po9+ljMQR5gnmvn4k/IhjzNQ5ukHTWXcHUKoXB/
         hSdWueGLKvKswx1Hf1mKTczxMoEJIPTaXGtDO7GBhxAHN5hKXa/lFMVzRYTY1wEpBbzI
         tFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=anhS78osYJqAXSVji6gtcsE1BSoSKmAW17g1Tq4g11U=;
        b=2a7wjTo9XQnaTV0Xggfb6v0EhctDaPYyytGAgDTRoazCDe4rjtVdiGgdQswWxHkgZk
         LFKpPZPTWe/eCwkTkdk9RAIRJ5Hrpw0nwRXjJJrByfOV+U1/OPW0iAXWQ90jxYUdHInT
         sx+ofzuehQniL4elJKhCNTRJM/UMHUnAfYj3+FwjgcXKCFsCKxpDf9XoEX5gmkR2RpcW
         qGTU+q71ujbE+qT2+bTUhS0LkNEi2GLcp+HpSq5gHi6PQhetTGhlTJ5Z0OWSq7cOU6B6
         ipkqjhxYCXD4j0B2QeAvFq32CrZQNumi+i+HgDC9wJvpM9T1HeI8IscGpi5py7jvsHh/
         eKhg==
X-Gm-Message-State: AOAM531typbjbbdlgae7JoB0p66V/h3XIKz7ycg8r1sWoKZ6/QuxenBk
        Pwrsius6uzkNI5R6co3WyMiEyRPNDFI=
X-Google-Smtp-Source: ABdhPJzQMAe87m3lBRAxeWUwAXAc5BbR+rI1RgB57ih41hDE2XDsxa3/MAXAAs/Z1w71ez+u6JL79w==
X-Received: by 2002:aa7:d553:0:b0:416:4dfc:126d with SMTP id u19-20020aa7d553000000b004164dfc126dmr32262902edr.213.1649675456776;
        Mon, 11 Apr 2022 04:10:56 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id fy5-20020a1709069f0500b006e841c87243sm4235480ejc.64.2022.04.11.04.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:10:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ndrwd-000euw-SS;
        Mon, 11 Apr 2022 13:10:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Plato Kiorpelidis <kioplato@gmail.com>
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br,
        mhagger@alum.mit.edu
Subject: Re: [RFC PATCH 5/6] t0066: remove redundant tests
Date:   Mon, 11 Apr 2022 13:10:10 +0200
References: <20220410111852.2097418-1-kioplato@gmail.com>
 <20220410111852.2097418-6-kioplato@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220410111852.2097418-6-kioplato@gmail.com>
Message-ID: <220411.86sfqjj2o0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 10 2022, Plato Kiorpelidis wrote:

> Remove dir-iterator redundant tests since the new tests introduced in
> 045738486f (t0066: better test coverage for dir-iterator, 2022-04-07)
> supersede them.

This is presumably a forward-reference to the OID for your local version
of 2/6. Let's instead squash this change into that commit.
