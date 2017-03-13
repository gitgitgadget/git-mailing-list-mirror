Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CCD31FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 17:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754432AbdCMRWx (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 13:22:53 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36200 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752966AbdCMRWw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 13:22:52 -0400
Received: by mail-qt0-f195.google.com with SMTP id n37so7043634qtb.3
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=XH1y4plGRqpASqmXDGz7BgT9raERZiRi0ajOFyXSJxQ=;
        b=n965XAgRT71YpKBbZ8wMcjXJ0R0SKiyKeyUO9KN5hpBtRxFKs0AATFH094K3S98qjW
         9EkAfxkZWQohoL78JGWTFWTUokNX2PxM2q7evEt7gWahVQzmmgX9sIdCY1/k+Qz95Q2S
         IioXxdlBfM2JYIUR1eZmQw9B1apBzRGmaFDe//8Dndlfr/SPsJGQvEBwtytMYc8//JOR
         ObYTF2Gm6IbL154tazZjM3Y0lih0HmOLVuvhRwhe3GrCRCmn7m9zzKMt22ze3wmKHK+L
         pIMDLZ15KYV64EljsL6jFL1BZeSXf4CJVbYbvHR13BHDKTMa7XDbAZC1GaDWfVilX88D
         A2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=XH1y4plGRqpASqmXDGz7BgT9raERZiRi0ajOFyXSJxQ=;
        b=TJO9z45PK91nVJ3udFPBmdQSCHsRparLkMg8beLjSHn4lNM/Rp7r11J99I94wmUzL6
         2/GYxv2aduKnKsaMfLwuDYU2klMAGeEmXKFqfzRVDsMSZjycJbHJfjL5c/fJOtqkYVYY
         J5+N1UQWh17cq2ezCO810Hi/B+4YH3oP1X6XqF2OnNS87F95h+A5kpsULPerN6TZxPDm
         7xRNVyiIkZqmBbiFUfUOCQfVyDwT04rKenSDjPwcbLpuQP+5nhTwcAJBszgHqTNTbg/j
         mLRJcRhE41AMD5vjW3WuYrd8lgSGuXah1Ij9x7hD1EYEUXErfEFPhpKtwGKDLnlsbogT
         6lkA==
X-Gm-Message-State: AMke39kTVDXNyu0fQIKnY3gNnphdVpHQmBXICmW+tjNcPx7VbE5/GjhTR0nWSXIqweOd6w==
X-Received: by 10.237.37.229 with SMTP id y34mr34381112qtc.30.1489425770844;
        Mon, 13 Mar 2017 10:22:50 -0700 (PDT)
Received: from mango1.eduroam.cornell.edu (nat-128-84-124-0-821.cit.cornell.edu. [128.84.127.53])
        by smtp.googlemail.com with ESMTPSA id n19sm12579114qtn.35.2017.03.13.10.22.50
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 10:22:50 -0700 (PDT)
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH 0/3] Move ~/.git-credential-cache to ~/.cache/git
Date:   Mon, 13 Mar 2017 13:22:29 -0400
Message-Id: <20170313172232.96678-1-lehmacdj@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patches for my Microproject. I took into consideration the feedback I
recieved on an earlier email thread and now look for a socket at the old
default location before creating a new socket in $XDG_CACHE_HOME.

Documentation/git-credential-cache.txt |  3 ++-
cache.h                                |  7 +++++++
credential-cache.c                     | 15 ++++++++++++++-
path.c                                 | 15 +++++++++++++++
4 files changed, 38 insertions(+), 2 deletions(-)

