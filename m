Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911B81FC19
	for <e@80x24.org>; Sun, 26 Mar 2017 09:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdCZJPt (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 05:15:49 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34163 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbdCZJPt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 05:15:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id o126so4707058pfb.1
        for <git@vger.kernel.org>; Sun, 26 Mar 2017 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RmWHrqLX9u/9lX7Rp/SQq1KmU5ubOXaEyV1Y+ivMQ8s=;
        b=ae/rq9V9DZKpeCfyLq5vRrLeGmxwfbtBRpJSCsSbPS1ehEu+WPUcuKBtKl+Wz3z8ou
         2vuUbezYn777D12lhlg6uvbcCniGJQUVRYe62LeQLBd7xiB1PO8pBaltAnqXuYTS2RrL
         sZ3GMDq2PTMXTcbuyPnHbeFFgt99Kw+kwLYoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RmWHrqLX9u/9lX7Rp/SQq1KmU5ubOXaEyV1Y+ivMQ8s=;
        b=JmR8ZBcZnihGCXArzUYvfHnXUH8UvU0mo1P93gZjZdmckO3BozVdyQwE+Wd+z0M9tt
         +rNbmFcYjbPLdGFcYVDg5gYCYmC0gfVZLD+y7+ucCgqPducWrIa2kxiCDrecOHkheogG
         wPdantvRd1pv1L2t4Z3IDrqIOmAN+oOzRiNHQ4m2ZSDxA964oQDX82/5L2w74uhVHsQV
         jRIqoFkIs1FrZLFuuvxhcS7LpoIozjNv7mkMLFNLDlbWTz71b+0MA4gGCz2+19Ji2NNm
         qj14uISmNAZBl4z8cwUwvk6K5gLLLHJAQcaaPfoLPU4yhoGU8PPX8iaq08JOL7zNs11+
         XPFA==
X-Gm-Message-State: AFeK/H0jPNZwnqby+gEQjS3gW89UURlsT3rjwBZen9hrUS/VMULXTujxsWOzrEtzcnRyjg==
X-Received: by 10.84.231.193 with SMTP id g1mr21538803pln.59.1490519747708;
        Sun, 26 Mar 2017 02:15:47 -0700 (PDT)
Received: from ethel.corp.roku (cpc108967-cmbg20-2-0-cust367.5-4.cable.virginm.net. [81.101.7.112])
        by smtp.gmail.com with ESMTPSA id p24sm14307977pfd.26.2017.03.26.02.15.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 26 Mar 2017 02:15:46 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: Add failing test case for name-rev vs symbolic-ref
Date:   Sun, 26 Mar 2017 10:15:36 +0100
Message-Id: <20170326091537.2707-1-luke@diamand.org>
X-Mailer: git-send-email 2.8.2.703.g78b384c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As per the discussion about use of "git name-rev" vs "git symbolic-ref" in
git-p4 here:

http://marc.info/?l=git&m=148979063421355

git-p4 could get confused about the branch it is on and affects
the git-p4.allowSubmit <branchname> option. This adds a failing
test case for the problem.

Luke Diamand (1):
  git-p4: add failing test for name-rev rather than symbolic-ref

 t/t9807-git-p4-submit.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.8.2.703.g78b384c.dirty

