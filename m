Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1651F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 21:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbfJGVqv (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 17:46:51 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:35495 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfJGVqu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 17:46:50 -0400
Received: by mail-pg1-f202.google.com with SMTP id s1so3207656pgm.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Eob6mh+W+ZBrR3DjcAk+HEi1wj4vEhV+IJn2GgrMgP4=;
        b=vNBhzNj14Oemy9SV+twVbzb1YimBKzSLZ201Y8SBvjamFHwz8FjKfgIwLBBO+oUmXQ
         HddwAnNFxI9lBefAOnK+Xa+31Tl/nW+Xj0U5VKhAtr+ut0Ve6atSmIRJVrf9gX+pQwQi
         LIqnNJHGF6gin4V+6+R95fKguNyBHSWxYpiWD56IohQwVd21H0bJe1Eq54gF8AXUFckQ
         ccXzAiVNcv1TQ0mtOKqszThRZGe90y701VWuourEW6h9qaoPPBFmVaCNP8cOwuPyOb/C
         dHrmFi2fGVoJOCJN+0SMnNwDEFMIlCmTAnSQzS+jBGoNuxVrT6kN8BETnSjWUHvMPXCx
         VKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Eob6mh+W+ZBrR3DjcAk+HEi1wj4vEhV+IJn2GgrMgP4=;
        b=PZdcODeo453PVbQLFAaX46SSPtX70E9i0f1Rr7u17kzDXeVFlOy9lPgMfapNjbF7Yw
         6EsltZlpJFlPTim9sDDoViX7bc8tURYQrj54OcV+3f2MwIgZ/3S2Ef/NCTsQ1/mIB2eC
         83VW3jPZa/eVI/mkKhutDIfRl972zXWQ0vSQcoMzZRjxdEoM27CoL4s6jpah3Ykg/GqW
         nh0L5sSDWDvqkaVzy9XKC7LrMzIvgV7zYa+qopITZvXFRY+yWTVQRN7MrHLwfxMe0LjG
         w8sXYhYmMkKsLkBHCO5YZTCXnRM194FSCd7uhPpSkMjeybyccIcvwXVCYPMe8zVCspju
         Ifxg==
X-Gm-Message-State: APjAAAWa24BceroqGZqINUeb4RFseaa24NtuXV7bSDqgvcFhXXupwvE6
        LYejEHZfl1GegiV4wkVbsXKMUq7XbfoD2kpVFPF6
X-Google-Smtp-Source: APXvYqxSgSV1LzqhgfuvHrGaQyIz6hN85fcWieD7DmFArJTRyzk3AhHVC3jClT5qSADMLvUUdxAPtpTNr8UlgYOPbtTR
X-Received: by 2002:a63:3583:: with SMTP id c125mr13596848pga.110.1570484807886;
 Mon, 07 Oct 2019 14:46:47 -0700 (PDT)
Date:   Mon,  7 Oct 2019 14:46:44 -0700
In-Reply-To: <cover.1570059953.git.steadmon@google.com>
Message-Id: <20191007214644.236055-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570059953.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: Re: [PATCH 0/2] add trace2 regions to fetch & push
From:   Jonathan Tan <jonathantanmy@google.com>
To:     steadmon@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> We'd like to collect better statistics about where the time is spent in
> fetches and pushes so that we can hopefully identify some areas for
> future optimization. So let's add some trace2 regions around some of the
> fetch/push phases so we can break down their timing.

Thanks.

Patch 1 looks good to me - different regions at the same level
(builtin/fetch.c, so it will be just for "git fetch") and one specific
one just for negotiation, which has to be in fetch-pack.c because only
that file operates at that level.

Patch 2 mostly looks good to me too - unlike fetch, a lot happens in
transport.c, so it's reasonable to put most of the regions there. One
comment: in transport_push(), should trace2_region_{enter,leave} take
"r" instead of "the_repository"?
