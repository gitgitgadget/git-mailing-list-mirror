Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBBBD1F6BF
	for <e@80x24.org>; Mon,  5 Sep 2016 10:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933227AbcIEKYv (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 06:24:51 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36376 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932444AbcIEKYu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 06:24:50 -0400
Received: by mail-wm0-f42.google.com with SMTP id b187so12741834wme.1
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jJJOOXV3xn9VcZpuMOqe2f9LpYeU1oixB/XUBRlVvLY=;
        b=0YpYW762z0Zfm/U9S3eg/BWExLhTfpkWQIMJ1dygl2Qpiyuy58ydpuP/C2TC6HuCqL
         EnCQqoH4XnCgST/d9xeYrs+WOHLrWaeuRsIgycrI5cDnCuB4llE/+yW3EDPhmhM7mXJM
         i9acx2nJM4VfSZ2tyYvCUpASy2UssbH7zdAe9EaTxUzyWq/0Vu0I/nlWoAdg1h9Otoma
         PuP/hsEEX1Hm98KuN/EyDoh/RTWF9crjdyduoxna/jDCDmtj2IZ7cadKTsgMPopTsQWT
         EGTLN2K9qTFsj8tGcctpNaT2Uk0vC/EETohFjr7avNjrm+pQXj1gY7ihBLC8yG2042cd
         lpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jJJOOXV3xn9VcZpuMOqe2f9LpYeU1oixB/XUBRlVvLY=;
        b=bKHWGo0Dccp4qUNjJp443mUvGOQvUGmhKF3hqDbTskYqAGa60BlS3ONaMDTNbCLmsR
         sZpJx1P+wNauqFQY+LUK3SKgFBUxhTCjE25HZzEyVt3xhETO2iESnRV9imBkalVtLUOz
         0cmLl9h8BT6+NT1iWI4UQ2QLYLuNr1g7bToQHRo+BdNlwj9pb2myhq7lcsBcryXzY3A6
         soyZzk46EIgPWdhikRw0P6KwNSLjhPr5Fg1TxDKGn0RHrsbqhrzQRdsPvXFz5hAaXCKY
         QL11ntey41CCZPyFec43zFIuIV/XtLdjN/ve64uN358ntdRZrvL99Jlf4Tg/g0xbPxRB
         5JqQ==
X-Gm-Message-State: AE9vXwPfCYVWyoBFQXZUh59iU0FzhaShYp4g7wELrOSDYBWz0PT1x+GybTXAgc2JfULlyQ==
X-Received: by 10.28.10.21 with SMTP id 21mr15435496wmk.3.1473071088761;
        Mon, 05 Sep 2016 03:24:48 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id gg10sm27001666wjd.4.2016.09.05.03.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Sep 2016 03:24:47 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 0/4] test suite: use the GIT_TRACE_CURL environment var
Date:   Mon,  5 Sep 2016 10:24:40 +0000
Message-Id: <20160905102444.3586-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.10.0.308.gf73994d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the new GIT_TRACE_CURL environment variable in the test suite 
instead of the deprecated GIT_CURL_VERBOSE.

Elia Pinto (4):
  t5541-http-push-smart.sh: use the GIT_TRACE_CURL environment var
  test-lib.sh: preserve GIT_TRACE_CURL from the environment
  t5550-http-fetch-dumb.sh: use the GIT_TRACE_CURL environment var
  t5551-http-fetch-smart.sh: use the GIT_TRACE_CURL environment var

 t/t5541-http-push-smart.sh  |  2 +-
 t/t5550-http-fetch-dumb.sh  | 13 ++++++++-----
 t/t5551-http-fetch-smart.sh | 15 ++++++++++++---
 t/test-lib.sh               |  1 +
 4 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.10.0.308.gf73994d

