Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53EA9202FB
	for <e@80x24.org>; Wed,  8 Mar 2017 21:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932071AbdCHVCD (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 16:02:03 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36642 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754203AbdCHVCB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 16:02:01 -0500
Received: by mail-wr0-f171.google.com with SMTP id u108so31957040wrb.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 13:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NzM0ORbdAakCklAa87nx6BBjgw1HBiFlnR6CJ9eCrBw=;
        b=M23TrRcbLDUo36fL1w20c8ctan+wdW7Aht69T53XfqZXwySYMtpUX4WLfJlDowN0yu
         gUGHirsGGbY/Q7X6Y1WhruE2xs8/KvAz9E58M9qyCenxPi8qp/SDLJMkF3djQlv7QMDH
         lG1S7PhveQcKToJdoiqsVrjS27A1rNmGPNueFQ4/qLB0KO9qDUrcf3BG61FfHSdxsi1S
         ManqSQYtVhbBKFXvnBW1LjQD1wemngz0lYAY/8fzdoFfzM5JkmDo6i36VyAcJMKrtPiJ
         VBV4Y7F+D5pfsiXZkIglfs5NoRWazXWac8aKJdxPpSavQA5PV537PWHirsfiMx3BQfaD
         Ql3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NzM0ORbdAakCklAa87nx6BBjgw1HBiFlnR6CJ9eCrBw=;
        b=F9MXjrvJZN/tXVkpwbCJMtg5fEoeyQymxFtDh/5NBBikFkidCtEv343L+wf8O1BItu
         tDjpO2fmdzl+HKz0RwwEbWyB3iFnEEBbZDQM+XQ+KM/SGVtLfbRs+QvsXyWOAUQ6AvS7
         M3llsu2MmcWF12WFAdKxlTjGuKLgt0XIKsHVHcW6S8F7UBaz3dPdwfCFIaC4xupRvuCo
         r5bO151RBZbmZLswiubm0fFjL/MpEpqiGIVlQWAihBl4Ajszr+pVo1Fi6/rnHrkonHUv
         MKAhGni7Q5i3nWwHey3F1krAwmWCgxeIYz5a/YONkO2PzZ49v1Dh2pHB72vKerosLTjE
         QB4w==
X-Gm-Message-State: AMke39kkkgN67VVG8AHVP5+lq7awEL0tgwjq9vslZ5LMw6T2Cly+J1qoCGBLuDZ8JUH8yg==
X-Received: by 10.223.133.228 with SMTP id 33mr8072910wru.0.1489006384320;
        Wed, 08 Mar 2017 12:53:04 -0800 (PST)
Received: from localhost.localdomain (2a02-8388-0b40-0580-f50d-465b-b746-dc93.cable.dynamic.v6.surfer.at. [2a02:8388:b40:580:f50d:465b:b746:dc93])
        by smtp.gmail.com with ESMTPSA id 40sm5604065wry.22.2017.03.08.12.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Mar 2017 12:53:03 -0800 (PST)
From:   =?UTF-8?q?Florian=20Sch=C3=BCller?= <florian.schueller@gmail.com>
To:     paulus@ozlabs.org, git@vger.kernel.org
Cc:     =?UTF-8?q?Florian=20Sch=C3=BCller?= <florian.schueller@gmail.com>
Subject: [PATCH 0/4] Gitk Inotify support
Date:   Wed,  8 Mar 2017 21:52:51 +0100
Message-Id: <20170308205255.18976-1-florian.schueller@gmail.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Inotify Support
    
    Just automatically update gitk when working in a terminal on the same repo
    
    Features:
    * Detects inotify support
      if inotify is not detected the options is not available
      in the preferences
    * Enable/Disable auto update in the preferences
    * Select "debounce" time for redraw
      i.e. the redraw will be postponed for the given time.
      if a new change is detected in this time the redraw is postponed
      even more
    * Automatically scroll to the new HEAD after redrawing
    * Depending on the type of change the UI is "Updated" or "Reloaded"
    
    Open points for now:
    * release watches for deleted directories seems to
      cause problems in tcl-inotify (so I don't)
      I'm not sure how often that happens in ".git/"
    
Signed-off-by: Florian Schüller <florian.schueller@gmail.com>

Florian Schüller (4):
  Inotify Support
  Update of German translation
  Updated de-Translator
  ignore backup files

 .gitignore |   2 +
 gitk       | 171 +++++++++++++++-
 po/de.po   | 684 +++++++++++++++++++++++++++++++++----------------------------
 3 files changed, 540 insertions(+), 317 deletions(-)

-- 
2.9.3

