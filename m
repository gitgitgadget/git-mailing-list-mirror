Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 245771FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 22:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754817AbcLBWn3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 17:43:29 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34862 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753809AbcLBWn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 17:43:28 -0500
Received: by mail-pg0-f65.google.com with SMTP id p66so9082935pga.2
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 14:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yBpA48WXvL4/OKfeYUGZsu7znQJ0ni6a/AXzMROA5pA=;
        b=gbH/JBagKjgExks06FOoDzSTiAVKLJSrGi86S6wrI9oKxyrzU6sQLMqZPb8xqDgIhE
         FjJe8VWU6YmZMtfCfpaRST92e2KxNdci0TvQ2ElDJbg0seswOeK+tr2SWh5u6pcQPQQN
         RHGAjk8Bh9Lohkc9Kb8HJXkgRb65QxfBQ4txc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yBpA48WXvL4/OKfeYUGZsu7znQJ0ni6a/AXzMROA5pA=;
        b=UfjkR9bqd69TIw0vyy/PW6Gr6qHiPYGhMY4lGrXt2V8+nN6KH1RgBEwBJmOeMd84TE
         T8KfrvK3Bvb94FncibgGZIwXCwZXWx5rKEIaPYhSnzVXBpfgOLyjJ1694tAkSNuzSGAr
         6+UAZ7pFQyOn2gGxS+2jsGiobtlrV3jJSlpRVBazwdeecNxtSnQV1do/NJ/+K0op1n+4
         u+drQ07KS/YHTB6vr2t65i5YKaYn3FEIEtQ2uAczsi6fPDroTQdb0ZXLfR+b8Z3xXuzj
         ybqdNV92x0CIzhcc69uF4kR/K+HGxrSMgF7Slibfc3JixT4nVX7PqZUBGhcspIMfgUUD
         knTw==
X-Gm-Message-State: AKaTC00SB2JbN/bnkY+B4sQHW4iw+UZUaJ+4g198X3+N8BosmyJ3XiQUC4hzh98ddhbyKg==
X-Received: by 10.84.218.7 with SMTP id q7mr101163089pli.18.1480718608095;
        Fri, 02 Dec 2016 14:43:28 -0800 (PST)
Received: from lgd-kipper.corp.roku ([50.224.7.248])
        by smtp.gmail.com with ESMTPSA id 16sm9992784pfk.54.2016.12.02.14.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Dec 2016 14:43:27 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com, Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 0/2] git-p4 patches
Date:   Fri,  2 Dec 2016 22:43:17 +0000
Message-Id: <20161202224319.5385-1-luke@diamand.org>
X-Mailer: git-send-email 2.11.0.274.g0ea315c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a couple of small patches for git-p4.

The first just teaches git-p4 about git workspaces, so that you can
do "git p4 submit" from within a workspace (P.S. workspaces
are completely *awesome*).

The second follows on from the work by Vinicius for shelving
changelists, by letting you update an existing shelved changelist.

This is a bit like using "git commit --amend" only far more painful....

Luke Diamand (2):
  git-p4: support git-workspaces
  git-p4: support updating an existing shelved changelist

 Documentation/git-p4.txt |  4 ++++
 git-p4.py                | 39 +++++++++++++++++++++++++++++++++++----
 t/t9807-git-p4-submit.sh | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 4 deletions(-)

-- 
2.11.0.274.g0ea315c

