Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA48202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdKTWZf (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:25:35 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:34489 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbdKTWZe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 17:25:34 -0500
Received: by mail-it0-f41.google.com with SMTP id m11so5569526iti.1
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 14:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lQtY9c5hGEZh07ONFccIdjgogVm9FZAAuBVdBG3+IAw=;
        b=kIkzsvjeJVYf65L5mwl2ihtKp2/kBxDfl6DVTouu5GvrA8psOuGreHL6oU7KpDBjy3
         ixosMlUJ1oT1lfdvWTaobTYNIHWToD5dQhzUA9MGyoK+H+UHaNckOm5nU/+fyWsPxG/9
         mXUz9ajIRX1H3iv3enRyqt5Gwgvqaqq264xHduLNym4oMz1kjlMDJHhcJeyZn2ceUNnT
         +LvKqWqXGVh0xDsVCQOWgLTUFB1IweGBJdDIsUUWX1x0v4t55gTD1DbeyqBuc/t1z6Ox
         zcD4RaWVzIIHaT7N9ugSLO+8YW1YciuW7bKriaHFiIeE+cv2sE+YCL95xIBvkJpJYp4a
         iyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lQtY9c5hGEZh07ONFccIdjgogVm9FZAAuBVdBG3+IAw=;
        b=TqR/ZwEFxBlttf/awhfS77qPFBZ6YmYIi9/iR/3Hd913sPkEtBp5EdZDIMrVs1NAY6
         7Nw0lYxpEhO7P0f9nde4FGbARxbTtO1fzJImxPKZSbHIdzRb+5PxSGiJsQTcm+PtNy+Q
         Nz10KFU2MYCnDIp/X1GjVUHKQ+HnTH6C9m2OktPUS3Wx3RB9o3SXhBXdRozk2j9bAmgd
         iyUcuPQJFQmzDrEdE61s8T8LX/3IAv99fknbgqabp56vgnDpqppjgruDYIvFqfOVCRTm
         8ctn06L2QeHyL/+OgoxNdCw/eTZ9PioeRWCGrRgiCG9791Q39WqRGGG7ongVaRNM6CZA
         +6bQ==
X-Gm-Message-State: AJaThX5LJ8FVBn6uOv2CFMrZveuRDfQW5iehymX3MAbM6GBW/Tp8BySx
        vwas8uvREBqa2YzksEEM2c3uYzfow5I=
X-Google-Smtp-Source: AGs4zMahQPA2cwYNiMWKyIwGQpmPN3l8ifQi6rzNwOkMeimWIg7DaCKJx94WG6g57Y6FewHhqL4iwQ==
X-Received: by 10.36.10.73 with SMTP id 70mr20442839itw.145.1511216733783;
        Mon, 20 Nov 2017 14:25:33 -0800 (PST)
Received: from localhost ([2620:0:100e:422:d59e:3b74:3df:d3bb])
        by smtp.gmail.com with ESMTPSA id z2sm5586190ite.26.2017.11.20.14.25.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Nov 2017 14:25:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/1] Teaching the diff machinery about blobfind [WAS: git describe <blob>]
Date:   Mon, 20 Nov 2017 14:25:28 -0800
Message-Id: <20171120222529.24995-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This seems to be an easier approach; thanks Junio for hinting at it.
This certainly solves our immediate needs, we may want to build
'git describe <blob>' on top of it or defer it until later.

Thanks,
Stefan

previous descussion
https://public-inbox.org/git/20171028004419.10139-1-sbeller@google.com/

Stefan Beller (1):
  diffcore: add a filter to find a specific blob

 Documentation/diff-options.txt |  4 ++++
 Makefile                       |  1 +
 builtin/log.c                  |  2 +-
 diff.c                         | 20 ++++++++++++++++-
 diff.h                         |  3 +++
 diffcore-blobfind.c            | 51 ++++++++++++++++++++++++++++++++++++++++++
 diffcore.h                     |  1 +
 revision.c                     |  3 ++-
 t/t4064-diff-blobfind.sh       | 35 +++++++++++++++++++++++++++++
 9 files changed, 117 insertions(+), 3 deletions(-)
 create mode 100644 diffcore-blobfind.c
 create mode 100755 t/t4064-diff-blobfind.sh

-- 
2.15.0.128.gcadd42da22

