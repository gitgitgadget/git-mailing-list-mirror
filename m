Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77592C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 19:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjHIT3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjHIT3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 15:29:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D930410FF
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 12:29:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb7b8390e8so1858075ad.2
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 12:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691609374; x=1692214174;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ffiG0Nkt427yVfO0IGuprsQtchln8FYNJdf1Nz7GRE=;
        b=ZZKoAMGWeph//Z1+cp9QOuDudtkNbZuSSKH1Danz9UgaZuDNh5dlQQfd8H1rkZBji9
         wKrHgU+vRxZ5hX34ri/clYuRkrsPMLcbTOqXY3BZ2WKnK1SqHGZl0z2uUpzE6gWHT/bR
         mF+Awgk825zkxwF3fXzidzgSSkUI3GpDxtDSkZVdi/eFffg6H26upllioHK6V9jN28j3
         5AexnynWQsFQrDvQYNR8MCKZ4moMTMHlUrkKLlDFAcuk0veZxCqA1EzEjxqZ6hNYpfgE
         xOdDH8GDa1X6dUtCUbPDTALJqXwFrLhgC7l+ut4QhMIwyFAL+BQwCaPiCUjpPzznV57s
         Sp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609374; x=1692214174;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ffiG0Nkt427yVfO0IGuprsQtchln8FYNJdf1Nz7GRE=;
        b=FbJyE9hPiSt0IM83QeOS/jBExH+XVO2WC1thCfT5hj71hQtRMn1GyZIMCsZR7/OenB
         Sr0maJwepc/TxMSOq2OIKOiWh1a4USMzOAKvhV2TTCnwAcybXphaj498lm5axDKFLpg/
         n76Z3dumGqsz9Nv1Q9aFmEj39DES66HG4Fu/hJMlUx0q3pwy213lxzy9y5UpSYlh82lN
         633oqa+AVTMWYNSf+9waOmDNl//jEtmbRIkx1NR4HYHtOWMgGh1LPvfhr0xgVYP+9FIW
         zsKNcWCUv0ch1YkCcRSuEJoVpyDR+W7jCF7yeEehfVLYi+ZNlQOX0GHHaN4joLZKv7Kv
         r5Jw==
X-Gm-Message-State: AOJu0YwFklu9q0MhD8bMeK8p2A6hmJYbPf3501HK/d8NP7q/IN0J2Wsd
        nGuFH1gHhya3LOweg/evz+G5I3uCIjP3aw==
X-Google-Smtp-Source: AGHT+IGpGIQ61kYf2ploGvX+x45W/+GrHFdQJcb9rq5dQXUjLZ3NepgPkcsk1zPtBFNst6pV4Ms9qg==
X-Received: by 2002:a17:902:b084:b0:1bb:3406:a612 with SMTP id p4-20020a170902b08400b001bb3406a612mr26913plr.57.1691609373999;
        Wed, 09 Aug 2023 12:29:33 -0700 (PDT)
Received: from five231003 ([49.37.158.253])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e5cd00b001bb33ee4057sm11497998plf.43.2023.08.09.12.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:29:33 -0700 (PDT)
Date:   Thu, 10 Aug 2023 00:59:29 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [GSoC] Blog
Message-ID: <ZNPpGcBSkh1pwj-Z@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIdrQybUsjEcxMrb@five231003>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Week 11 post is here

	Week 11: https://five-sh.github.io/2023/08/09/week11

Feel free to suggest any changes or comment on or off list.

Thanks
