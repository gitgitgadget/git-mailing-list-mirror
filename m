Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF396EB64DD
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 19:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjGLTnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 15:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjGLTnN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 15:43:13 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5AC1FE5
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 12:43:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-553ad54d3c6so23131a12.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 12:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689190988; x=1691782988;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNa6JI11T5WTWOntcWO76oQ4tXDlzBvb5vkmuXHtOg4=;
        b=FzlRtH/2CdDGsjxq9OSDQb90Kc0YxOk3hOfRZ9F8wz8HRjxXabvO+XCxnu55GP8LOE
         qbAsqQbGT0bmEtnKDLPUlufdge1Dq/LAJ3nXAa+scXpKUM7rMBI2UKoKv4vyWBNHpuub
         ZYJquXkaRSHBASa894NqJd/p5wak7+siSCWKrBnFtWxRFM9m4meJA5l/2vsRtlFj406y
         nRypfcGCREWFIggKYD52kqw0qFBkht9zUS39lkROP06RtBxEY1vz3JNYGlMMZFG1m1bz
         Nky6q6Lls0BfR7F98xYp4cRXZDYer2XCQFr58A/pKNI+EbgYzpyqteXYTlOIJpBafo1D
         BQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689190988; x=1691782988;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNa6JI11T5WTWOntcWO76oQ4tXDlzBvb5vkmuXHtOg4=;
        b=OPn5Y67RbJ9iti9zdkxsWKnse5vLCGbH7Df/k5tIUYO+oYhVyLtpAnP/jmpf8x0+Rj
         Fcjqnt4uXpZLMyMXSsCw/ytT+Hd32RiBD/xGZ4AhcbaDWgll5uHwwc0kgY5jYQuiyFxo
         ygck30gJafVp5u3hpwsBEcJMfwSpOSv7Jj6B/V0Y9PBvPclx/boJB31z7NAH+l51Lb5L
         ujgEvRCRmZUHAw5UCWvRAI933WpHTmShTxlOEOcQ8JmHc/zH121vL676jaQlTEDfOY3Z
         k/IXjbkBlLJ3pI6GhnxntwvV5gn4Ta9QflDizIqcImBcWwLUnacnPrK9xRxQkZQWrGRu
         D3ug==
X-Gm-Message-State: ABy/qLaDvDWgZG1MeyRl2ow+mM1FvRX8p2EwAixE2biZ7dBCbxOmZhhh
        ZM2GddLlxwjN/VXQsLoo+a1mPGVumCM=
X-Google-Smtp-Source: APBJJlGfGYiA20PwLIJBf/wt615kaY1dnTzLRjspkj2A8/BxhPqhyXcVkfVdZDtVoG2fT3wGjM1YoQ==
X-Received: by 2002:a17:903:182:b0:1b8:944a:a932 with SMTP id z2-20020a170903018200b001b8944aa932mr17709609plg.2.1689190987718;
        Wed, 12 Jul 2023 12:43:07 -0700 (PDT)
Received: from five231003 ([49.37.159.40])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902b68200b001b9be3b94e5sm4302207pls.303.2023.07.12.12.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:43:07 -0700 (PDT)
Date:   Thu, 13 Jul 2023 01:13:03 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [GSoC] Blog
Message-ID: <ZK8CR7h9-Na1leT2@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIdrQybUsjEcxMrb@five231003>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Week 7 post is here

	Week 7: https://five-sh.github.io/2023/07/12/week7

Feel free to suggest any changes or comment on or off list.

Thanks
