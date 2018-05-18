Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03BBE1F51C
	for <e@80x24.org>; Fri, 18 May 2018 19:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeERTn1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 15:43:27 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:46857 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeERTn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 15:43:26 -0400
Received: by mail-wr0-f173.google.com with SMTP id x9-v6so7425164wrl.13
        for <git@vger.kernel.org>; Fri, 18 May 2018 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4/oerecgmCKna6TJ4iMr7zIJ72I012kFVAgbp4kcA4c=;
        b=ktuj1xhoKsvbgw22eCLNstsTRpLa4fyZrO5KIRpkchsf4pDAkq/xbXchh5c+aUD9gc
         JXzRsnItTygI3AXmzGs8qPn2iJ+QqYiFswg6tvINWofMUj/UB5vUxaKJuzX80z7OTW6p
         beSmEdt0tuFUSIbCxql0CbFfWHT5v4AwVXg1NPnZClnyGL2WfgtQ4yASDYEdwkyal3HF
         9FQQ4iYAsE7qhM+pI6jprvKla4r0llPSjm0MpN0UA+gbM4Egf06iRylWZQRDr8roZgpx
         SY0eKqzXtk13tjOk28EBi1HJLjgH35nA7VP4BW/jOyksyvJy+QFDnkwXipUy1AFUkki4
         azkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4/oerecgmCKna6TJ4iMr7zIJ72I012kFVAgbp4kcA4c=;
        b=RsVyrboS8KVQaq7GR27qXzNwYw6U+w9PCmX8ZhcG6PESwwqFt6NiuwVM6UvJun8INh
         PYAG12jjQTh6EHSPbq3e4NpUgN1OKo8hTRiqMob4VyVRAGb6pZgtg/nDI7jp7eJupn0d
         t9HkEGUEOs32eeE3/wivnCThjDYM6sb2CSPh5u3KGBFBH7PE72MBEaR9JkBnOvhxDEnv
         65cGyqZakpuDBIGFhG7VQ5agTljf0h5K3dmdG1TVpyfnLKzvWEAR92IAtRBGzG7nLyh0
         DhM2SGdtnJfx51w1PC7GeKIlSrZZJ3wsqxHm59BzyJKTt739bPbUkwsdrnIDH/RmnPVq
         MKQQ==
X-Gm-Message-State: ALKqPwdGrjoLY1latSRgEgaBrNcM9z1C68D9vrbpP4sVBeFMoiLEGcpp
        AbVJ9tot9g8Be70XRw7nJGs=
X-Google-Smtp-Source: AB8JxZqL8euZktqNyVILWKJ+zEE0KVs/7YHfdD+i3EvRwwftCPrllkFY2R2kEGWX2YSR5VUgxE5UeA==
X-Received: by 2002:adf:85f4:: with SMTP id 49-v6mr8618580wru.33.1526672605151;
        Fri, 18 May 2018 12:43:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8071:b6aa:7d00:445a:d637:6fb:6000])
        by smtp.gmail.com with ESMTPSA id w18-v6sm4588552wrl.78.2018.05.18.12.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 12:43:24 -0700 (PDT)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        leif.middelschulte@gmail.com,
        Leif Middelschulte <Leif.Middelschulte@gmail.com>
Subject: [PATCH v2 0/1] rebased: inform about auto submodule ff
Date:   Fri, 18 May 2018 21:43:16 +0200
Message-Id: <20180518194317.28043-1-leif.middelschulte@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180517184008.25445-1-sbeller@google.com>
References: <20180517184008.25445-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Leif Middelschulte <Leif.Middelschulte@gmail.com>

This is a follow-up on Junio C Hamano's comments [0] and Stefan Beller's request
[1] for a more explainatory/elaborate commit message.

[0] https://public-inbox.org/git/xmqqk1s474vx.fsf@gitster-ct.c.googlers.com/
[1] https://public-inbox.org/git/20180517184008.25445-1-sbeller@google.com/

Leif Middelschulte (1):
  Inform about fast-forwarding of submodules during merge

 merge-recursive.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.15.1 (Apple Git-101)

