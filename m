Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8EEC64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 14:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCIO0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 09:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCIO0L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 09:26:11 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AA04FF23
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 06:26:09 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id r16so2060409qtx.9
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 06:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678371968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KcRdhGYek3PluUQqeLaKNSGrdBvvxpxGjODqqS5dtAo=;
        b=N1wOOgADd2KibRMEtuuTVH3UHGfxe5N1jKd0LGHybXbaY4CCA9ry0MGiKeNzTDFvIs
         qKgYepLbkRYZBpt/h44qJFbQgajsNcivx//1XGV5R7WpJX1BbW8hT9JaVYzlEsUMPKI0
         4d2LEuVGI4N+pPaSf5dEu+rfefJFhlB25bAK6L5oqPNP1tDtCPa5+RnoDa6U9UAz6/qy
         V9Q7p2drhHdRg6MH70G71UCm5qCmsiQIiPXa0Mj+BTgOiF1j/0jMbwW8t/mT46YrPSkB
         msw0rneQOKvIS54A/TV46+Nd+tBcIK4WIhcL8fsvL+P8CyR+CDykSWhugeVoYKAkDLK1
         aedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678371968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcRdhGYek3PluUQqeLaKNSGrdBvvxpxGjODqqS5dtAo=;
        b=H65qqwXO1NxcTi3d6JqqvF0d7YdyuXTIyXV8s17EVlPgX8ljYAnBKmFKQvZ+vU/nnh
         N4ZwOCquj7o/UgUhGcDcvTksxrs9FDwi+qqfdydtjxBoJXSvKT9fwJmNztBmVh0kXsLT
         WS/AW+JsL2XtOkT9sRLBLwex9Fd40AWlEgrE+jghIUw6+kM82yf/bbiEZONTxdaCesty
         z1iXbYcdCgMUnVV5Nt2IgNQNrpa9J4nSB26t+zid3MaanZzK7lX/CylLYb5WTCKqboDy
         c3ZFgUpNXYb6IDdR82DKCJsaYYkn1Ty348+9PYfcqJNGKJnRTXIJXWjACL1wFzfHM9Ts
         bvmQ==
X-Gm-Message-State: AO0yUKVD93n+IfuXKEAWRk9tWDNYcld772CIzzyV/wVzQJ3c2modH08f
        UPcM3nj3VGUj3hNYVdSpPHsb
X-Google-Smtp-Source: AK7set/mdRosQKPnpRPR3utaKKO9HMoFBIH/Cr/MKe/xiu9qONP4LMiLO9Pv43TMvGAYwnA8e79a0g==
X-Received: by 2002:a05:622a:48:b0:3ba:1d8d:f6d0 with SMTP id y8-20020a05622a004800b003ba1d8df6d0mr40533721qtw.23.1678371968010;
        Thu, 09 Mar 2023 06:26:08 -0800 (PST)
Received: from [172.16.105.140] ([204.116.190.176])
        by smtp.gmail.com with ESMTPSA id v25-20020ac873d9000000b003c033b23a9asm6481028qtp.12.2023.03.09.06.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 06:26:07 -0800 (PST)
Message-ID: <7097d1d6-00a1-2a82-1923-610d41f4053f@github.com>
Date:   Thu, 9 Mar 2023 09:26:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [GSoC23] Working on project Idea from SOC 2011
To:     Khalid Masum <khalid.masum.92@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAABMjtGXGZtUnU+8KgEccNeLXRJmWnE5f24BMG8ysbZKfT-ctQ@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAABMjtGXGZtUnU+8KgEccNeLXRJmWnE5f24BMG8ysbZKfT-ctQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/23 7:07 AM, Khalid Masum wrote:
> There is this SOC 2011 idea named "Resumable clone" here:
> 
> https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/SoC2011Ideas.html
> 
> ...
> Currently cloning a remote repository has to be done in one session.
> If the process fails or is aborted for any reason any already downloaded
> data is lost and one has to start from scratch.

> Goal: Allow Git to resume a cloning process that
> has been aborted for any reason.
> Languages: C

"for any reason" is going to be pretty difficult.
 
One direction that is relatively new in the Git project
(much newer than that project idea) is the bundle URI
standard, allowed by "git clone --bundle-uri=<X>". It
helps bootstrap clones by fetching bundle files and using
them to populate the object directory before finishing
the clone with an incremental fetch to the origin server.

Since the bundles are expected to be precomputed files,
it is much easier to use standard HTTP range queries to
download only the "missing" portion of the file from the
bundle server.

I think one thing that would need to change on the Git
client is the location of the temporary file being used
to store the bundle as it is downloaded. It currently
uses a random name, but if the name was a hash of the
URL, then it would be predictable and could restart the
download if the 'git clone' process was halted for any
reason. (Resuming a download due to a network error
noticed in-process is possibly simpler.)

This might be a more focused approach that is more
likely to have progress in a GSoC project.

That said, I don't have the capacity to be a mentor,
but I thought it worth mentioning this variant of the
project.

Thanks,
-Stolee
