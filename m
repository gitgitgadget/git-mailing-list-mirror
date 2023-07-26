Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A6BC0015E
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 20:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjGZUi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 16:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGZUi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 16:38:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45854EC
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 13:38:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666edfc50deso114991b3a.0
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690403932; x=1691008732;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3magClF23rzAqrrM5IfilUKjVQihuSoubxrOQpgGDA=;
        b=XjDb8VY9Re/EE+v4xL9/Gm4UjoO7c03SuDt46QYMcsupu0wdsPJkwJf/3IB0v7CWQm
         YBUgd++L6bAU2c3c4MVSzUJaZQOske6kRwHZt3Yy6pz+FYQ67Yv7niH0G7Q7Fr5lpV1W
         WTRRIRPje6GSiXdhzSwVFVWBW5RXiDWAVV8jfZgsKmuDI81Df32QxpLtjOYcAe8xEbCv
         Gzpy68cyWJOOmsQ0Y1U4yHO/aIaNz9tNNPnBlSJs76lVd6YueQsBEN/yyvEdh8tCatP2
         Tzkyh04yYN2/vYuSd6udOCH1Fc/DSXCvEmkWFJtoUvfQRNUWzoD+wnUqeTg062bfmJQZ
         YbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690403932; x=1691008732;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3magClF23rzAqrrM5IfilUKjVQihuSoubxrOQpgGDA=;
        b=TWBU0XiEBuHB1UPvLHQXgoTCrZOT53Ecj+IUiNgx+PU7Vt/Bz2Y/6do0J1oh3gUOPw
         eKhdQcCyoetHlXD8KdAJVidNU3pPUOwfIaDjoDBreCGWUSXPWwCtUTjrLpiO9qsS3GCq
         vq67HKVtxJnPXn1+Z9QnIklfLyDC1X1LqdX7SLgS0HOaOezzNAF4g/ujP4lAKdVQmwwt
         cRCxOVRGRVyzXP3SQ+Aix3QnML/g/m43nJcTpLseU/RY9jPpBoBbZFg6cyZgKQdfBZej
         wuRz5OX/ljrgxeTTO18PkObQXskwhJnUMTLM+kP1xr8iwcQOEN8iiqt78xrLzbigy5Z0
         dD8w==
X-Gm-Message-State: ABy/qLZ9oY/9NJ8lxJPJ8wJiJgJKpQ3cQAbIK//yStfCWVm4HYFxCMis
        gly60pTNO9nuojkTpEtvAyL45cTVvItauQ==
X-Google-Smtp-Source: APBJJlG8bZNC09HXtnCS/J7u/+Hs9kX0J2T9kI7bjLj8kgZ9WKQCp0pEQ/ghcXPCxev3RrqqnGi/TA==
X-Received: by 2002:a05:6a20:8f01:b0:132:d09f:1716 with SMTP id b1-20020a056a208f0100b00132d09f1716mr630115pzk.2.1690403932281;
        Wed, 26 Jul 2023 13:38:52 -0700 (PDT)
Received: from five231003 ([49.37.158.10])
        by smtp.gmail.com with ESMTPSA id m14-20020aa78a0e000000b006826df9e295sm20860pfa.113.2023.07.26.13.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 13:38:51 -0700 (PDT)
Date:   Thu, 27 Jul 2023 02:08:48 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [GSoC] Blog
Message-ID: <ZMGEWK7eYc3qv9ah@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIdrQybUsjEcxMrb@five231003>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Week 9 post is here

	Week 9: https://five-sh.github.io/2023/07/26/week9

Feel free to suggest any changes or comment on or off list.

Thanks
