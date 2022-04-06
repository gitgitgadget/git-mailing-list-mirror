Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DA7C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 21:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiDFVk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbiDFVi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 17:38:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AB419028
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 14:10:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id n6-20020a17090a670600b001caa71a9c4aso4092069pjj.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 14:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Q2VxlbyqSiWEllIwGgcc+KNg6/HLc+tacK46OBGgvc=;
        b=jJbmfor9oPE5h2k1uZsDv+kZnwRjEDen07R4K6xpbbmgtYMUjOUnaL8hqN4jjoSTqx
         46fBYelK4yWu5l5UihIe9/xhrXhny81v1zdaurubWKSFYN9K9/RWKPaPTWiJ+4J57gOu
         y/+tKfoejBmmneIf6SgS9iiQsM2DnnkODn86QlnpxpDjR1OpI0s+4oVRkw2Si+6cQ3lh
         irnm/v4JlwgyiBlNZ0/BKfKCnCAiSIEz5MebCdGVOaecrE4Mavy35dDodI6SgLJ+UT90
         GJFaEd5Tc8t1N2pfUHrdIpWZ4OaG2W+z/XXWT6Is2brHHKqCF5Rl4sOHplyuf/ipr7Ca
         II6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Q2VxlbyqSiWEllIwGgcc+KNg6/HLc+tacK46OBGgvc=;
        b=eBuBtMEAEbkTO6it0DkGKWE85xv61ueui5+Tk5KWLs1ca8l9KiPSezwLGYRLxQ8fwS
         9SItDTbWXph5P+6quoY/X7/f8mED8N8S+HEFDgANaw1Oopb0/WBEB86y38KczzhFqjLN
         Hyv+iIt6pdVBfm2Fh0hu+qsjrTEoxNCoC5pallRX+N8Vn8rnt0HmE7Q1A9KGQKAPc15v
         1ho9tHnr72qL5pZ7UUDLjwfPC1cwRTbmTjDB0w/09pXcfq06YJ5vEGpxe+yeFNmw2fP8
         cx9X5vCRC2fS7om3UEUn8Uz1e4vtlMgohsWMBQcmtCPNHrzwzdhyXxdp1Ke6Jep3hMAu
         yC4A==
X-Gm-Message-State: AOAM532iPzal1tt+b4k4B6XWkwS0AYJOXJUPsb9zHxcUIDvaf4tlIsPW
        J/xli5AGB1BFqmcgbeb11aA=
X-Google-Smtp-Source: ABdhPJwnGOaO7s8XGOYK13HJ74KV3S/3F7xw1Xk8ksG3Iz1+2M5RtHe3YNCROTubUeKRUO8YeijhFg==
X-Received: by 2002:a17:90b:224f:b0:1c9:949e:2202 with SMTP id hk15-20020a17090b224f00b001c9949e2202mr12006655pjb.56.1649279402150;
        Wed, 06 Apr 2022 14:10:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2c00:1377:21af:a46a:d6a7:f39f])
        by smtp.gmail.com with ESMTPSA id b13-20020a056a000ccd00b004fadb6f0299sm20447602pfv.191.2022.04.06.14.09.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Apr 2022 14:10:01 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        vdye@github.com, gitster@pobox.com
Subject: Re: [GSoC v1 0/1] GSoC 2022 proposal rough draft
Date:   Thu,  7 Apr 2022 02:39:38 +0530
Message-Id: <20220406210938.27565-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CAJyCBOTHT+oLQ5Z0rKhj7tfiA97_rpXAU3mVjokUV09DB9bkvg@mail.gmail.com>
References: <CAJyCBOTHT+oLQ5Z0rKhj7tfiA97_rpXAU3mVjokUV09DB9bkvg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:

> Not sure why, seems that the previous email does not show up on the
> mailing list.


Same for me. I am also trying to send the proposal. But for some
reason, it is not showing on the public mailing list.


Thanks :)

