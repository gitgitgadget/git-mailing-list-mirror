Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC9FC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 20:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383092AbhLCU14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 15:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383090AbhLCU1z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 15:27:55 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D7AC061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 12:24:30 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id j17so4581401qtx.2
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 12:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MZHAh4jemnULDzU35LXZaako1c2EUVU26ZW5zTNCd44=;
        b=GB8KZ/9nHuI6oIOmlQYoFrbb3qXBz93FzJC7vyLNY5FldJbEj/3arXrrvaRR+a5lUY
         SFEgb7UhwvHzZxNgKcgYKezkqfjCHajGEliEx89GO/IeKJEjwDVevbVLmR1vxSSaIw6l
         Mo04nDQb6Krgx81Q69Rm4eEz4LGdx5NaJBU8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MZHAh4jemnULDzU35LXZaako1c2EUVU26ZW5zTNCd44=;
        b=XG/x1QVXLBd0PXeNm44aV58wgQAWhtH8oT2vnJso0HCNT+PovVFoe6zBGnZ65yOA+6
         JeLIJrx7X/ss6UAP9Qj6Sp9rUfpojqfH8W+0TSq2fmWVJNc743iZqIFsAl7vKRn/5acm
         fy0HHSV+EjG0UUz2bKaeBCKjxv6kZt9Lks6Qf3dPqENZiCWwfpCiaa81Mur0PBu9YWvQ
         Zc9p7p9vFrnQo3YxeLd946Am1xqKsiw+ng0rM6ZXBXVYpZVh9gO4r3Rh9GMptWdJJUN8
         Oql/NQcDIGu9SyuWdon0LjyPAR5DCXFYLxfiaGD9X42meFnUNxGJ3XPBUpahwOZ8HktN
         KCBQ==
X-Gm-Message-State: AOAM531BC2qdBu73FUn/s+A28H78++5qh2D/23pKtDQmZSO6h46XMk2/
        7IwIt9Izp7Utv3AuFtmSKsuZwg==
X-Google-Smtp-Source: ABdhPJx0WYqStZJhT7T0EfOtE3w6sv4Y/AS4CSPfs/bLvWhBucfNMqZKZpbpSQ3KcOp/jceivEK5Ww==
X-Received: by 2002:a05:622a:d:: with SMTP id x13mr23191636qtw.229.1638563069726;
        Fri, 03 Dec 2021 12:24:29 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id j12sm753882qta.54.2021.12.03.12.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 12:24:29 -0800 (PST)
Date:   Fri, 3 Dec 2021 15:24:27 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Large delays in mailing list delivery?
Message-ID: <20211203202427.o575sgrx4auqkmjp@meerkat.local>
References: <CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.gmail.com>
 <211203.86sfv9qwdm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211203.86sfv9qwdm.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 03, 2021 at 09:02:48PM +0100, Ævar Arnfjörð Bjarmason wrote:
> When I've experienced delays (sometimes of half a day or more) both
> https://public-inbox.org/git/ and https://lore.kernel.org/git/ have been
> updated.

Btw, you can source lore.kernel.org straight into your gmail inbox. :)

    https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
    https://people.kernel.org/monsieuricon/lore-lei-part-2-now-with-imap

Or, you can read it via nntp://nntp.lore.kernel.org/.

Best regards,
-K
