Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14061F461
	for <e@80x24.org>; Tue, 14 May 2019 21:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfENVK7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 17:10:59 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:46185 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfENVK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 17:10:59 -0400
Received: by mail-pg1-f202.google.com with SMTP id t16so323824pgv.13
        for <git@vger.kernel.org>; Tue, 14 May 2019 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JafqFTyROl8DKOEZEpWEeAv6z7kkYM5PHsN1xoVe6W8=;
        b=KKCJg1A+8ptShxNykRD4BGrJVwrsd+qKTZeGu41+s7G+4QlvGRwklXdhOJ7Zzx842z
         D+skMJMm/Y6suwCCmOaJmDARiPpNjj2QKhOOyIIAn2+er7pep7gsiyBul1sYEHRFHlPd
         9qYpz+o+8vDPK9en1+O0HFRtvBHtC8fyB6hhC0ivNpFo88X7ayt/T4pBxWMMhqR5J50k
         muptRUkpJQ8dSAXFJO6uSvkPVeb4uMvtSHoPN7q6sBLcWXggtXAEK6Dz36SR6OFG21Yg
         QsG2uhwyB3j60pCnIlyBgFHeO6kls14gWQajDDRCStUafrYNLI9dg3/kQIcfcWoFnULB
         aOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JafqFTyROl8DKOEZEpWEeAv6z7kkYM5PHsN1xoVe6W8=;
        b=JZKPhjOlbrzsUV3lPMHDhkdEI0MUIY6nIRqvulEEg//IQJHak1YLYNk7kS46hXJrJ1
         IpfZngEpf9DUAJjq6knebnnuJzBlzGizelPf4NQ3Ts7B86TOb4kiaJHTm4Ny5RPXLiu2
         0gKiSdn2lNWhHAg1iVOYbkZiLQFr6OSZ/jY+kG1WygOtBGYphrVedxNsse73urKv2ZKD
         Doe4vI4cev8W1VMTjfyFs7WO/x0SzuAPF/g3j+ItLJZqyEAShBbP9ChXRgRkwdIugr1E
         3uE5cxaI4Kf+6upn1l6XNMQMGqVdQJAnQEC+CLK7EkBtKyd2215Qvpxsu33OS52ZU7Jv
         P+Lw==
X-Gm-Message-State: APjAAAUaDYtmMTiDE2SggM2/8WidWpx7LufqFpV/JyKNnB8TAVneB51c
        XKz++UxkZ3TMevbBMCxpFLPFxUlCo1E1PmyV7u0gOLhCfTInKsMUawNKMJuAKFcx4hdK9t92yY9
        8Mxzk7ynpzzMhTGKmij79bM/vJgiWCaZ6wCykSZEEZKBJej0L7biG+JzEMOzLhEgi/THji93cNY
        dB
X-Google-Smtp-Source: APXvYqxkyvFQdPfh11mgicD+CqQgzwKl1GWsMf2j5iaduBRjzrSxtXJeleh6IeNaQwQ8g5hgkiD5+SujkoYy+ejt9Mj7
X-Received: by 2002:a63:fb02:: with SMTP id o2mr39171016pgh.357.1557868258542;
 Tue, 14 May 2019 14:10:58 -0700 (PDT)
Date:   Tue, 14 May 2019 14:10:53 -0700
Message-Id: <cover.1557868134.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH 0/2] Partial clone fix: handling received REF_DELTA
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is an issue when fetching into a partial clone, and the server
sends a REF_DELTA object that is based on a missing promisor object.
Here is a fix; more details are in the commit message of patch 2.

Jonathan Tan (2):
  t5616: refactor packfile replacement
  index-pack: prefetch missing REF_DELTA bases

 builtin/index-pack.c     | 26 ++++++++++-
 t/t5616-partial-clone.sh | 95 ++++++++++++++++++++++++++++++++++------
 2 files changed, 106 insertions(+), 15 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

