Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90406EE49B5
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 14:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbjHWOwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbjHWOwP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 10:52:15 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40B8E6D
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 07:52:13 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-58cf42a32b9so63703067b3.2
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692802333; x=1693407133;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fi4Vj+bI6RQVpxBFGsMF10gGoTgo4hDzcFywDYyrhUU=;
        b=fcPt8WubJ+jx2c22T/Qcr7Qd+BvUWNEN9nBkWlVyL3E9wtHsZNMhQc0/gQ0e6FS34O
         XRrTESy6Jo31QjKKE0zjOpxu7Hch5rTMNaaN/syPNGRVSjnG9p+6cvqNBJBAk/Mj1YKA
         66Rjozjvz/bXbWn5RVVmt7jQdovEpyDLX+IPRW/5tt4YBNLRSzYjrxW7b4jHwugZS2Pa
         LKeUyKoULt4IP4Ql/wVlSKJB/PAav7NufxQ5uXydrlyvmF+1CZ3BksRfdJPUm0sWAYEX
         sVKqJyjj0kxwvkwf6bXGDx2JiEx4BG5Wrtr5jJgxu/W19PmmlTCHcu6k0Z8djuCdiRxV
         merA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692802333; x=1693407133;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi4Vj+bI6RQVpxBFGsMF10gGoTgo4hDzcFywDYyrhUU=;
        b=XznFwd/yI0NchGlsemWJau/TLjcHvwWV4Ikyu4EPdJ20qwWiCVSa1FJkUumaGY4XSm
         om3OJRkqwB/Zui/B89BfQNDLfp4KEur3OfiCINsP2FxCbJmaROmkTjBt8pmWKpwDz/z1
         KVFy7XcUGrtmHMUTvZsb3xn9F4+Sr4qzijXNThZw1FBwxZ9uqDo8bxi1fkv3VeKmeIop
         X1cIDw9D3unJ9UJsr396MPZg05c2nP7lx2ypK+v7TMLd4Xli0ynjpdYPkIGtpPx+e+LE
         oMfikyB74Hamzm9A7W/UnJ7mQmqXKj/2QTKWGl45R2nlThIp38B7lCIORUm2ZijbP4kO
         1zJg==
X-Gm-Message-State: AOJu0Yz34J916I94+ysIbULlE/DFTmcCFFr1jgp3p8v4Q1SndzCCXuKO
        FIuYvPfKsQrve1v2pH4H2/RmuwizXQYZXyuHOCcpRw==
X-Google-Smtp-Source: AGHT+IH9vH8mHdtGBDHaP/05paCywNe+rWyibFp80hpceJLh7muNDG9GKgDIZqDodFZrvwG6MJVzNQ==
X-Received: by 2002:a81:6d44:0:b0:576:ffe3:b95 with SMTP id i65-20020a816d44000000b00576ffe30b95mr13266685ywc.40.1692802332995;
        Wed, 23 Aug 2023 07:52:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m124-20020a0dca82000000b005897fd75c80sm3370525ywd.78.2023.08.23.07.52.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:52:12 -0700 (PDT)
Date:   Wed, 23 Aug 2023 10:52:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: 2.43 release date adjustment?
Message-ID: <ZOYdG8RtPIgymtBV@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we're on the other side of 2.42, it looks like the tentative
release date for 2.43 has been scheduled for 2023-11-20.

That week is a US holiday (Thanksgiving, on 2023-11-23). I figure that
many US-based folks may take a good portion of if not the whole week
off.

Should we consider pushing back the release to the week after
Thanksgiving, say on 2023-11-27? This cycle is already somewhat long so
we could move the release up to 2023-11-13, but I think it would be
nice to have folks around in case of any brown paper-bag fixes.

Thanks,
Taylor
