Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C00FC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 21:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbiDMVFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbiDMVFw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 17:05:52 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50BE83B09
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 14:03:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a11so2268466qtb.12
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=oSZozF7ZKM8WS5s9IaTGY2bb0oHid0Ca75UlHRP5t1o=;
        b=CJr9Su8URWsS+ogRW/eY3h3TspIRsObtzHoLQwq4O8dP2JhEmUY48L2QFJrcKzdhVl
         6mzztPaxtoZQ6QSLQSLsKwA+Z3cBxC4hJ/wvHeYhLkc99utXr0Jc9Tp1lHfdo8wnHsAV
         VxLnEV4pDNckLvQ7wA+wliGK3HuihnplTAlsNxJ12f3aoSc4ujlu5cbbHbsSVOcW61iu
         u370QSksyzUfTWglJP9BXFSYXdocjf6IQ5I82ikbU3ihRo6ElTW0/T15Lrry/tugfgk4
         FAK0cn7ngNWsx544Fdr3PTIwvPQfcDQss7FofaYKXEG/C2hgX5AzPC+h+Bv9t0M7De+H
         TPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=oSZozF7ZKM8WS5s9IaTGY2bb0oHid0Ca75UlHRP5t1o=;
        b=yj7rP+GPlCT8E0HwTUeJrRT65lXMDzE09rqeCQs1IEx7ucZStJ+++LjLEIgeg1pfyv
         f+QjqdP7wjAtBAwZ42qGNtCm1sX3DZKDSBmjAcZZxLNhTKnMYWg1OaAuYsaKM0VMftrj
         by4PHOQBYg3dyQAtxgPJtZEEBlHxd8okeJrmmR96qN/uHPxYjxsCx2XSQ4i80OhWzOK4
         wzD3G3gil98QJw5qe4yeSYDzQy799qqb4TfIvcJ3sehNE0Zt6Zm7rQepvaa1H91L3s+v
         T/ePkXEKB05hU4WSFv45e6WMRidMIi8uZPX7a3Y8zTHH4Rr6HzPpabPo1zEVrzfXwt6/
         OItw==
X-Gm-Message-State: AOAM531X7qUaNdjEBDEEOkQOB2M1csOBRagNDCRrv4A+qvlF1Gd1iGn4
        7xyowyWNjR6oU1Bmnny2X7UZGs/y8SX4VTwc
X-Google-Smtp-Source: ABdhPJyi8BfPg0QkvQfBanemutNEMIwPfQAKqXwvHe+VzCTv+riS16FJKl8M/i6qBFaVXiRudzJ00g==
X-Received: by 2002:ac8:4710:0:b0:2ed:b95f:5d92 with SMTP id f16-20020ac84710000000b002edb95f5d92mr8520484qtp.651.1649883809347;
        Wed, 13 Apr 2022 14:03:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u12-20020ac858cc000000b002ef01d55d2asm13049qta.78.2022.04.13.14.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:03:29 -0700 (PDT)
Date:   Wed, 13 Apr 2022 17:03:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] Documentation/RelNotes: fix a typo in 2.36's relnotes
Message-ID: <d23e51b8dc78651dbd751473c0f8b3dcd6bc3ac6.1649883760.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Noticed while reading the RelNotes for GitHub's release highlights blog
post.

I'm pretty sure that this is a typo for "not-so-uncommon", but I could
be wrong (in which case, feel free to drop this patch on the floor).

 Documentation/RelNotes/2.36.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.36.0.txt b/Documentation/RelNotes/2.36.0.txt
index d61ade21e2..98e1c97617 100644
--- a/Documentation/RelNotes/2.36.0.txt
+++ b/Documentation/RelNotes/2.36.0.txt
@@ -46,7 +46,7 @@ UI, Workflows & Features

  * "git branch" learned the "--recurse-submodules" option.

- * A not-so-common mistake is to write a script to feed "git bisect
+ * A not-so-uncommon mistake is to write a script to feed "git bisect
    run" without making it executable, in which case all tests will
    exit with 126 or 127 error codes, even on revisions that are marked
    as good.  Try to recognize this situation and stop iteration early.
--
2.35.1.73.gccc5557600
