Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D805C1F463
	for <e@80x24.org>; Sun, 22 Sep 2019 11:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfIVL6X (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Sep 2019 07:58:23 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:33128 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfIVL6X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Sep 2019 07:58:23 -0400
Received: by mail-lj1-f175.google.com with SMTP id a22so11084009ljd.0
        for <git@vger.kernel.org>; Sun, 22 Sep 2019 04:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQWtkXD3xYH+PYHNVzp2d3PvdUqj598FX8eWNjtzcis=;
        b=O1WJn0lsQ4d4IIhdJPOgsNasTjME8SgZhXDEOvAiWp6/AlYzggu3iXQ5g0kC2voldp
         RHX7tFhE8u+9hBwOfzFwv9zOmHmuIKxNrB9vEfIQr/kxxa4GXGCojd1F2U8e3RWG2+kg
         rcVyLdSlDF/IYuSk+PpEnBKsKs2Y2dnaiya8GOkT30hLi0AQyfdnPK0j1+nEFIN4Ahfh
         mnqHXv1E2Lhj0hYiJuG3kfwADf++VXq2zVWQlYBcwE0XIcEVUQ5CdP7ytFDarIqvLGUK
         f/9dNnIXO/N4tIvKFlEg7PqtIF92S5eJQsWLWlBccN1Olf4UZkr3ZZqgctlUeM6L0a3Z
         tkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQWtkXD3xYH+PYHNVzp2d3PvdUqj598FX8eWNjtzcis=;
        b=JhASwDiMuoF6PLykIgAYvzz3fOPSLCEz2mLmzr6w2Sq888+Ne0MMJdoRVohr6IpVx5
         0gptavFxetTDvciG1WX9mASawbESXNAgLgCNKY2uQqM1nipiE4+EjHepPDcq+JfNdYAS
         3XFD5wHiXrH4JSoNtzrrGTxKzY+3d/1EJVyUR00tPxMrTYeCyboG/ZWDADqvj7RtxIp+
         LQSGZi3jTpZI41YDmSTJuEqVsUxzqEb86vzMcywfpqLsNhBnM6L2kPyzI+JwQQTDa5Kp
         pVPKPzinSPn6i7zlzJEdXgXwhz49bzgP70P5rNxwixobvMyzzVUK/tIpnRzsm1Tjk1YH
         U4Xg==
X-Gm-Message-State: APjAAAXQvpg3atn5MySn9Uu/oD3Sg4LVQKfe/J+m6MKOpbyxlssBjICw
        TahbglCAP88ulsyVpbzv2AHvF/Tm
X-Google-Smtp-Source: APXvYqwqAWy1Xc2ikNa8vSGBo8BSQfh6Km/NzQrnllIJHHyCKbf65tm4QuQTgquzZzjoBIZHZ2vw4g==
X-Received: by 2002:a2e:2953:: with SMTP id u80mr14990723lje.233.1569153499880;
        Sun, 22 Sep 2019 04:58:19 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id q24sm1622413ljj.6.2019.09.22.04.58.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 04:58:19 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] fix user-manual with Asciidoctor
Date:   Sun, 22 Sep 2019 13:57:55 +0200
Message-Id: <cover.1569152396.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes user-manual.html and user-manual.pdf render well with
Asciidoctor. The first patch is a while-at-it. The other three patches
then align Asciidoctor-rendering with AsciiDoc, first with two
bigger-scope patches, then with a local ASCII-art fix.

I was happily surprised that there weren't more issues like the one
fixed by patch 4/4. After this series, scrolling through AsciiDoc- vs
Asciidoctor-rendered versions of the user manual side by side is a quite
pleasant experience.

Tested with Asciidoctor 1.5.5 and 1.5.7, but also with 2.0.10 using
brian's recent work on getting 2.x to build the docs.

Martin

Martin Ågren (4):
  user-manual.txt: add missing section label
  user-manual.txt: change header notation
  asciidoctor-extensions.rb: handle "book" doctype in linkgit
  user-manual.txt: render ASCII art correctly under Asciidoctor

 Documentation/asciidoctor-extensions.rb |   7 +-
 Documentation/user-manual.txt           | 377 +++++++++---------------
 2 files changed, 137 insertions(+), 247 deletions(-)

-- 
2.23.0

