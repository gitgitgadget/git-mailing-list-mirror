Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D99C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 09:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiGRJUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 05:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiGRJUK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 05:20:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3756557
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 02:20:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t3so14436986edd.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 02:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sLVkM4ar8dqoEM8WociKDgjeUqczQVDER3GI9A4hUJ4=;
        b=jIDRI8UlylqSVwCTQn5Z1HdiNdhwItuhmzdlbBljhTpBOWVJXtz9/F9qK8lzcxc3U2
         bMUJdiWQtuhMpW7t+ZmvpZQsbF0WoMNV7J5OIQ7VRCw7n3WAohEWZ2WuZJQCqMlUzejV
         wqP5OxCPqt+Gr3fstdFXGySnYGfWQ01xd8zeABZDu0F9RBb3q6iuCHgJPSQ03HEDVF5a
         9/aEqNgbG127BMqxW5wJ1tl+FnEL1BWoaJrkXb6FuJJmnUjnx0hZwjmkklQtPWXjpNd9
         fJtTlCH9v/svk3jGI1HrxVP6c3yGEoFzSASAXzO0trF0QO8ST+fB/o9SBBlJ52VvugJq
         Y0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sLVkM4ar8dqoEM8WociKDgjeUqczQVDER3GI9A4hUJ4=;
        b=O4C9KFqCRcDoKrPBGzSwhOL1xKlG9JCYD13yrnRbIYT5Od3MZfr7zEKfHm2TIMbMxX
         qfGGg6H6am/jPm1hpeJZxorMVSKQ6Cz9stWwA98FrY1FowqAUYuOHgiEChjGKOA5lk9h
         4bGnLjC3O5ISYj1+82qAw1/k6ejkJTGMKGmWhHycayVKNvgfks0lQLpp1h9FKYcFQA/y
         6fgHI5Oxef4IE5LnIflrnVFlSvUoBdSM+bm/Flgp+coV6wYS9YSaK2hPIt3GOTMiUXr+
         yonPnaaXoGhjTg9PWxcOjtAc3IQtCec3nTVJq+FpnlTyFr1J/ygvqRxbgfEfrwr1VE9P
         Tq/g==
X-Gm-Message-State: AJIora+qFbd1hvGFhTWidGEMi0KYF4K7BaXTPI7ARts7tAGVdR2jekZt
        3bhDY7rwjB6ROcED3XroJUefTSigHs4=
X-Google-Smtp-Source: AGRyM1tSKpZtAaB8eTSMkdSITYINNcKR74KZP5KPOl6O8+JvacpEUfgEXLpCz1PRm3hK3C51DSmo6w==
X-Received: by 2002:aa7:d955:0:b0:43a:7241:4cf9 with SMTP id l21-20020aa7d955000000b0043a72414cf9mr34439109eds.247.1658136008368;
        Mon, 18 Jul 2022 02:20:08 -0700 (PDT)
Received: from localhost (92-249-246-211.pool.digikabel.hu. [92.249.246.211])
        by smtp.gmail.com with ESMTPSA id kw20-20020a170907771400b006fe8ac6bc69sm5349861ejc.140.2022.07.18.02.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 02:20:08 -0700 (PDT)
Date:   Mon, 18 Jul 2022 11:20:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/6] docs: document bundle URI standard
Message-ID: <20220718092006.GB5616@szeder.dev>
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <d444042dc4dcc1f9b218ca851fcf603a3afce92f.1656535245.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d444042dc4dcc1f9b218ca851fcf603a3afce92f.1656535245.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 08:40:40PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
> new file mode 100644
> index 00000000000..a0230a902a4
> --- /dev/null
> +++ b/Documentation/technical/bundle-uri.txt

> +Implementation Plan
> +-------------------
> +
> +This design document is being submitted on its own as an aspirational
> +document, with the goal of implementing all of the mentioned client
> +features over the course of several patch series. Here is a potential
> +outline for submitting these features:
> +
> +1. Integrate bundle URIs into `git clone` with a `--bundle-uri` option.
> +   This will include a new `git fetch --bundle-uri` mode for use as the
> +   implementation underneath `git clone`. The initial version here will
> +   expect a single bundle at the given URI.
> +
> +2. Implement the ability to parse a bundle list from a bundle URI and
> +   update the `git fetch --bundle-uri` logic to properly distinguish
> +   between `bundle.mode` options. Specifically design the feature so
> +   that the config format parsing feeds a list of key-value pairs into the
> +   bundle list logic.
> +
> +3. Create the `bundle-uri` protocol v2 verb so Git servers can advertise

s/verb/command/ or s/verb/request/

'bundle-uri' is not a verb, but even if it were, the protocol v2
documentation talks only about commands and requests, but never
mentions a single "verb".

> +   bundle URIs using the key-value pairs. Plug into the existing key-value
> +   input to the bundle list logic. Allow `git clone` to discover these
> +   bundle URIs and bootstrap the client repository from the bundle data.
> +   (This choice is an opt-in via a config option and a command-line
> +   option.)
