Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C7FC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 18:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiGASSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiGASSl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 14:18:41 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3539414016
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 11:18:36 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id ck6so1006397qtb.7
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LE99A2cP0EtJx1USbEU2N08v3K/ziBZVFontOSyUftE=;
        b=ZNP5B6bwLNQ7nmF9jcuruRt/2D4u1PiYmpStktwYDeEyWLKclGdlk6MErvp/fyio9J
         dC5o2amy54CBod2OElAx5NOUKcZm6C4MroZojIw4Qbnra8kG2Pi6sF9bTub8muNfe+D6
         WeZBmyfGq25ehMlB8CQM3iaG0ZnaPhqBzQDHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LE99A2cP0EtJx1USbEU2N08v3K/ziBZVFontOSyUftE=;
        b=IcF2HEyIaKcQJIrmZn7FEJjig+qSAHD4b2bXlPE/5ritmZ0FHiMAgN3L/HgFXmsSQ+
         9paK108OmJSgNDDHq4IukbVXJ3O4p4vuqrgvqyzV6xVJY5aybYeBtDWN1Cs/bo18CB+C
         Wd0p9CiNX5M/Pd/RxQfeQdcxakvZVN2j4C8QZa483HiJsSnDvfPmJMH0h9Fyny9SN4BE
         a3sD8Dck3qwPyPwtcl0itpqR7Q9PmP9P4n9YOr6Wop1mXN+zobn98VJXOQZmcV6B1WCi
         N0HdsF1r5e9mUjO/Oq0YW6YDZH+DNZOzw9ax1yzZUsxcMULts3hMaacff8Iv2QYqiDAX
         aVnA==
X-Gm-Message-State: AJIora8UlLex1JTmw118NaHhz2ifMSKbS2KUIBVoOqkf4uvUVTRKh6Iv
        JT6nIEokPIpXEMk5yUDgI3EZ56CeyWEP+A==
X-Google-Smtp-Source: AGRyM1vpMzvvyQ2U6wtGlx7pn+wJZCZAkRNiAS9i6bNktnTmOMqaMoI1pDr0wVKQ5L3sQg7jZjI+nw==
X-Received: by 2002:ac8:5981:0:b0:31d:3c4e:bd77 with SMTP id e1-20020ac85981000000b0031d3c4ebd77mr2348978qte.237.1656699515243;
        Fri, 01 Jul 2022 11:18:35 -0700 (PDT)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id s9-20020ac85289000000b00304efba3d84sm15287784qtn.25.2022.07.01.11.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 11:18:34 -0700 (PDT)
Date:   Fri, 1 Jul 2022 14:18:33 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Non-interactively rewording commit messages
Message-ID: <20220701181833.yf3wmg2k3vyk4v6n@nitro.local>
References: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
 <CABPp-BHX5H1co+cMS2LEt=NYB5==5e4YK_sK=h_O1-zxaNocAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHX5H1co+cMS2LEt=NYB5==5e4YK_sK=h_O1-zxaNocAA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 09:01:33PM -0700, Elijah Newren wrote:
> One possibility would be to tweak
> https://github.com/newren/git-filter-repo/blob/main/contrib/filter-repo-demos/signed-off-by,
> modifying the line setting the 'trailer' variable to make it be a
> Reviewed-by rather than a Signed-off-by.  You could tweak the script
> to also make other automated commit message changes unrelated to any
> trailers, if you wanted.

Oh, this is neat, I was unaware of git-filter-repo. It looks like exactly what
I need for my purposes -- maybe I can just use it as a subproject. Thanks for
the suggestion!

-K
