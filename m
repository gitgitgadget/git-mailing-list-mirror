Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 727F8202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 22:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753416AbdJ3Wff (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 18:35:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55202 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753389AbdJ3Wfe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 18:35:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id r68so19449055wmr.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IYrc6Lb0Dhqqva6YVWNHFy99B1kRyOt+mTe65eOFn9o=;
        b=EzBaTtZeKOoUeeh8Ysj4kD+nE5nGNAvErY6gkDjS7A/1nz3E8i8QtUQceshJTjpcrg
         HH5/dv3jzPQdlHHiNBMHeTNrk5G0qWfAm7HSZ60aP4dZ6fFSAgPtnfxHKeXMCWRhVHpb
         957S/UzyTC1td3SMyR8ZYnkGrvt7BPNupD96ozk8rMZFughI2oIGyXTO+06iNNsJvsMl
         au7Zz/icy/z4/5jBo32+1p51LCR8laFqr3Y4AVf1C+u01DCBZui+M9Ss0OziD5SXaO2M
         CGqnkpYzg/c1guHjkeybQa+dWGKw4NfyAhTzPr2Igm0gsFzy+wGkWAr3CfTwM9T+eg9k
         OGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IYrc6Lb0Dhqqva6YVWNHFy99B1kRyOt+mTe65eOFn9o=;
        b=dKX0UrQGmacAEsMfHMFlBoyJ3bngvzN0R7SfRwW/r4c/0yNsr1JyW4FA0YIXXWEAy5
         8jwE5mC6yo9WGcfCUz9830CDaHdmbbk+HovILndm9D184nlbiQO91kGw09pmRSPdtjWa
         zvaGtnFs6T611BspeRl+hLeSyKnSlbQdPICxyfpt5DRp44iLybBFRzEDnHFEqO4RlY2K
         sYMwG7yjjI4SQZSkcm7H/ssrCyAxdACjiN+t40n6aJWnFo2YjLclxYTleGUH+Myrrf/B
         du8gPrLTIbYKza33cpgEd/A5ZbsbE8wELk5nlpoC9VxH0NC2nRWaR8bva8q6SvS3miUk
         5DDA==
X-Gm-Message-State: AMCzsaXEfJUHkIdIXrYYdsUhc8EMFBq9hBWdp2Pep52BtcJocjyy/UXp
        l5ylGo5hor7Yg9XKSlQFCdTRXw==
X-Google-Smtp-Source: ABhQp+Qwky+XlPgH54Xpj7u4dXobplAmECnRqyiGmTfXNJ1LqmmYxUTKSvhb4KZT+QyaHqNUqA2t+w==
X-Received: by 10.28.139.72 with SMTP id n69mr202717wmd.29.1509402932778;
        Mon, 30 Oct 2017 15:35:32 -0700 (PDT)
Received: from localhost.localdomain (AMarseille-654-1-544-80.w92-158.abo.wanadoo.fr. [92.158.136.80])
        by smtp.gmail.com with ESMTPSA id k69sm353676wmg.45.2017.10.30.15.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 15:35:32 -0700 (PDT)
From:   Payre Nathan <second.payre@gmail.com>
X-Google-Original-From: Payre Nathan <nathan.payre@etu.univ-lyon1.fr>
To:     git@vger.kernel.org
Cc:     matthieu.moy@univ-lyon1.fr, timothee.albertin@etu.univ-lyon1.fr,
        daniel.bensoussan--bohm@etu.univ-lyon1.fr,
        Payre Nathan <nathan.payre@etu.univ-lyon1.fr>
Subject: [PATCH 0/2] New send-email option --quote-email
Date:   Mon, 30 Oct 2017 23:34:42 +0100
Message-Id: <20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.14.1.731.g083517f57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Those patches implements a new --quote-email=<file> option.

Typical use case: the user receives a bug report by email and replies with a patch.
Before this patch, to make a proper reply, the user had to perform
several steps manually using "git send-email":

* Add --in-reply-to=<message_id> to the command-line for proper
  threading.

* Include the original recipients of the message using --to and --cc.

* Copy and prefix the original message with '> ' in the "below triple
  dash" part of the patch.

This patch allows send-email to do most of the job for the user, who can
now save the email to a file and use:

  git send-email --quote-email=<file>

"To" and "Cc" will be added automaticaly and the email quoted.
It's possible to edit the email before sending with --compose.

Based-on-patch-by: Tom Russello <tom.russello@grenoble-inp.org>
Signed-off: Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
Signed-off: Matthieu Moy <matthieu.moy@univ-lyon1.fr>

Tom Russello (2):
  quote-email populates the fields
  send-email: quote-email quotes the message body

 Documentation/git-send-email.txt |   5 ++
 git-send-email.perl              | 146 +++++++++++++++++++++++++++++++++++++--
 t/t9001-send-email.sh            | 134 ++++++++++++++++++++++++-----------
 3 files changed, 240 insertions(+), 45 deletions(-)

-- 
2.14.2

