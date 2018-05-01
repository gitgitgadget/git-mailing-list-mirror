Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B1C215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756353AbeEASPi (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:15:38 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41057 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756264AbeEASPh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:15:37 -0400
Received: by mail-qk0-f195.google.com with SMTP id d125so9427272qkb.8
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jhon8KfSj7Uxf5YeXmz7EW52h2pA66wRa10CfJueEy8=;
        b=MikzzrHlE8f3wEkV/mn4Xsv1V36A8VXj8G6QyBErVRYHN4hOLKijEi8Yik+OrGb8hg
         Y/Ne1g1Tve88R/o0U5tGrVgQf0LZ9OpU4dJpilSp0bSB/Wv/WLk9ZCRFt5xOC9XmU3WM
         1gvUU7o73LtKCZMQ8SU1rCsmTR2qPctOqpdhXVjekozYMo4OlBDygBPiCMgFqA2H90x+
         +qI2xBh65ghGjdA8/KLHgjXpglUKKg77QCAz46zOhs4lxdGs8cNyWaV0zFS7IASYwZYI
         KXo1WJJJ7j1EBm/r5yrt/nT5sOu911qT+vA15485eyi6/DvBmjZTh3BnomYPP0+8a+xn
         /w9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jhon8KfSj7Uxf5YeXmz7EW52h2pA66wRa10CfJueEy8=;
        b=ULXbHCR96Umu4wL2rdE6B7toc9BETkFS5LaPTtOhF42cmL8yXpXPAWtHUPaezLyIDB
         oPsKaGY+p3Z8i/RxhLToB2mKf1HHxG9wAlKdNKtjGgUXgnb0WfrOnopxOF5ylTYg/rvz
         +Jwkve4NSrShFjkyHC6LN462Xl9hAeFkODYO81U494ZJ4w+O2S+li5eow6eTiCka3Os3
         0u2ZxvPqX5LKbos+K4LVi2rJDEPuqsaspS8luQSOWipiMufU6tMrrlPsxxwOvuHY/uBt
         LEubQVYORMyHRys+TDFkyd0mIR6ChAVpuGQaPq15uABsKHtnWmMO39yIW5Kmql+zl8x9
         zxRw==
X-Gm-Message-State: ALQs6tCbi0c2VZCP7mojDRxkY8feY890YvPl5llrV/A8uTAG30cBWBJb
        H+UbccmMKE2kiYPICkDQVPd/CG4x
X-Google-Smtp-Source: AB8JxZo+SNU+lXYFoklaOoWmFEN+Y50RXKXQ6RNU3Mph1ca+yc5gMc8pbo2RlyyTF2/jkdBS1PUgBw==
X-Received: by 10.55.156.202 with SMTP id f193mr13691657qke.161.1525198536370;
        Tue, 01 May 2018 11:15:36 -0700 (PDT)
Received: from localhost.localdomain (64-121-142-251.s4089.c3-0.eas-cbr1.atw-eas.pa.cable.rcncustomer.com. [64.121.142.251])
        by smtp.gmail.com with ESMTPSA id z16-v6sm9271945qta.34.2018.05.01.11.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 11:15:35 -0700 (PDT)
From:   Casey Fitzpatrick <kcghost@gmail.com>
To:     git@vger.kernel.org
Cc:     Casey Fitzpatrick <kcghost@gmail.com>
Subject: [PATCH 0/2] Add --progress and --dissociate to git submodule
Date:   Tue,  1 May 2018 14:09:06 -0400
Message-Id: <20180501180908.17443-1-kcghost@gmail.com>
X-Mailer: git-send-email 2.17.0.1.ge0414f29c.dirty
In-Reply-To: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches add --progress and --dissociate options to git submodule.

The --progress option existed beforehand, but only for the update command and
it was left undocumented.

Both add and update submodule commands supported --reference, but not its pair
option --dissociate which allows for independent clones rather than depending
on the reference.

I apologize for any errors I may have made in creation of these patches or the
formatting of these emails. This is the first time I have submitted patches to
a mailing list.

Casey Fitzpatrick (2):
  submodule: Add --progress option to add command
  submodule: Add --dissociate option to add/update commands

 Documentation/git-submodule.txt | 17 ++++++++++++++++-
 builtin/submodule--helper.c     | 17 ++++++++++++++---
 git-submodule.sh                | 13 ++++++++++++-
 t/t7400-submodule-basic.sh      | 31 +++++++++++++++++++++++++++++++
 t/t7408-submodule-reference.sh  | 17 +++++++++++++++++
 5 files changed, 90 insertions(+), 5 deletions(-)

-- 
2.17.0.1.ge0414f29c.dirty

