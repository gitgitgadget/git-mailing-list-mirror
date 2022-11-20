Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA10C433FE
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 11:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKTLYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 06:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKTLYw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 06:24:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4C345EFF
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 03:24:50 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vv4so13553552ejc.2
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 03:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWU2FkiIDknU3eL7yBdN1CJHAT08IPjtqgkR16/dXJ4=;
        b=BQcTO4fptlLvPtjKBHfXeHeMICfLiuXdSUa8NYHnA69wjB9xlUU5pnNXFJVS+xd+Nj
         04WGcdfyyFmrQhkbfbrAZ06I/+3XcMmgWiOaF8m7arEVdaWMjRssURCjpe8HITNlbEU8
         drJkVZWY5T5iCnKVT5XDxOv3yjyyae0fwGaAR7EKFf/o/ElN4dVGG4+TKLOHDjcYsvo8
         Kx/Mn0RQ+obG/SZQN04guvcOkgEayNQ60CrydwT9zC6kw2ldZI7crDTWfXcFAP36mv84
         P+vnDLLphiv84T1zhbXTkUgD07nhpv2x9tezNCe+RQry7F27+aiRbHuKDSltWM3GB+Dc
         MYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWU2FkiIDknU3eL7yBdN1CJHAT08IPjtqgkR16/dXJ4=;
        b=2Y5SIuoRM3IIrqiJKhOSmznjiiSx35dGUEhDN4pSUeul26Ttz9KAYh9ohrj3kpYec6
         S3el19wvVYrR4iChlOlU3e74N//8InXEoj4d7XijEw6fOqLG88DM74KrvCkzuAvbA19b
         GnewOGP3dnDuaMgz2AmJ0nFTrVxcDgpfp29yf0Xf4PXgyC/hjr11Q7Ks48B4qXO8Jh9e
         rpc3b6b64Sfhlc2Rh5b86ONu54g0UGbQmiAtSBwq9aPAI4o64937gk/g7JVe8pqxghYn
         +vb3c+v8r6aSvOWhv6sPjwCuISpz3DXY5nn9nBG4YF6BRmDBYxzvyjguqWkDZwWiVk+6
         ZlbQ==
X-Gm-Message-State: ANoB5pmDU285tHIgBiLWznpocSKDguNRvNsPICNkuMwd4detGtQaFG5v
        DNctwZW1xZ2xyuA7hQCFM/s=
X-Google-Smtp-Source: AA0mqf5QKKGPVVqhXk2qSbi9mnp1ZiLjvyEHX5urVW8vkG7cJQ+YY8Ifh55vNRT+JGRi934cdIArfQ==
X-Received: by 2002:a17:907:1308:b0:7a3:9fca:785d with SMTP id vj8-20020a170907130800b007a39fca785dmr11687641ejb.303.1668943488648;
        Sun, 20 Nov 2022 03:24:48 -0800 (PST)
Received: from localhost (94-21-23-70.pool.digikabel.hu. [94.21.23.70])
        by smtp.gmail.com with ESMTPSA id el5-20020a056402360500b00459ad800bbcsm3877159edb.33.2022.11.20.03.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 03:24:48 -0800 (PST)
Date:   Sun, 20 Nov 2022 12:24:46 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
Message-ID: <20221120112446.GA4039@szeder.dev>
References: <Y3g95OYdwzq2OP3z@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3g95OYdwzq2OP3z@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 09:22:28PM -0500, Taylor Blau wrote:
> * sg/plug-line-log-leaks (2022-11-02) 3 commits
>  - diff.c: use diff_free_queue()
>  - line-log: free the diff queues' arrays when processing merge commits
>  - line-log: free diff queue when processing non-merge commits
> 
>  A handful of leaks in the line-log machinery have been plugged.
> 
>  Expecting a reroll.
>  source: <20221102220142.574890-1-szeder.dev@gmail.com>

I thought no reroll was necessary, because in

  https://public-inbox.org/git/Y2m7gielFOvTYbvi@nand.local/

you said "Let's start merging this down."
