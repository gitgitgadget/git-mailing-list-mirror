Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD9F1FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 14:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753430AbdDROYU (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 10:24:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32905 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbdDROYT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 10:24:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id o81so15062443wmb.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eepZ/H3mEdSC/QdxGd1WLSagS7n7sKCfBD7XrjY8DvM=;
        b=EiUV3lRqzMbQm+kg7b0fuYncudiWuktE6A9f27/qsYGpsNh3MAbQFM5gqm+8i9HD9J
         i76wIz3N/ootcBFbSuzFBe39IKAKJIazBtiL2/TjD2q0YOvxMw+2oNrvj1FkFF1YC9To
         4F+lgCqHulmGCuCblfAa2GidM/Hh0PBx5QUiPyNvc0Es1pW5kkgg/otc4Dvt4rktc5YQ
         YgHSEmPRmn9xE/HFSZcX1eN3qEihRWPwFBTUTqv/1NYQ18PyxUj9ycZkufnxKRtpVk/p
         w0ywmNqO/UpTlFF/6wuffqPY7lwJO2x7T7DgPqBnRPKvYFkHnYigEK3xr6ANifRRTQbu
         oouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eepZ/H3mEdSC/QdxGd1WLSagS7n7sKCfBD7XrjY8DvM=;
        b=ANhH9Ky+It3MCVBOXdVJsmwL6V1VKfUdU4zKsxX/hkKgJd3XdokZ8gaAj8LeyUHWjX
         U6V1R9Ky4YHv00XF9eADGhsFDVCkRSQz5h4Ext7yXtJ9WIetkHdkPm4VYlSauAM4fxVU
         USaKm73/e6xCYyU/ps/Z5AZDkLzG8IMg+fTm5NWZWu6R7ITWYBOG036pSDmGHhMvVH6I
         dJqA5Lu53GhJEbRIeUzRAKkhTOf51ik4MkUpyARGy6F+TOBLULx5HC18DLA3EdkyTAD3
         Ibl/5gnmjFuRv0W2auCWvtfzApknk9HgUvTuxPIJmIVtc0kKGE7gqFnHEEUjYiN8bsFV
         IAfQ==
X-Gm-Message-State: AN3rC/6l2F+tYZYsuO1ZCYlTmStVIK5Y4IwGxAmVQuXSeZM3MSGqhHwl
        VqCRtZ+kcq+XSg==
X-Received: by 10.28.157.84 with SMTP id g81mr12498090wme.120.1492525457949;
        Tue, 18 Apr 2017 07:24:17 -0700 (PDT)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id w52sm18935446wrc.14.2017.04.18.07.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 07:24:17 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] p0004: make perf test executable
Date:   Tue, 18 Apr 2017 16:24:07 +0200
Message-Id: <20170418142407.20976-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.2.635.gf331bb6d3a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like in 89c3b0ad43 (name-hash: add perf test for lazy_init_name_hash,
2017-03-23) p0004 was not created with the execute unix rights.
Let's fix that.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/p0004-lazy-init-name-hash.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 t/perf/p0004-lazy-init-name-hash.sh

diff --git a/t/perf/p0004-lazy-init-name-hash.sh b/t/perf/p0004-lazy-init-name-hash.sh
old mode 100644
new mode 100755
-- 
2.12.2.635.gf331bb6d3a.dirty

