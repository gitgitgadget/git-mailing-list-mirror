Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD09C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 02:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiBOCJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 21:09:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiBOCJy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 21:09:54 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B90140C32
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 18:09:45 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id i10so4341091plr.2
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 18:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SNRmamrIlQGOjp3jqPbZx/AP6WBq1cBE3Igc+cDLZMA=;
        b=BlzPWF7ZCwl3seuw8KcXgy0NM7mME5lAy4VWldCH3k+MHH45XvcbZ/mq3BS1CvYaNP
         2sZNY+Y+aEAKe3PO+xpgAprZTIdEkyLlGVdWs9qqj7NFaCNAXfbvGqcQpajJ9HLKDICu
         GC0iVg9z9cgZXib0gGXoJmxxItwTd7d28vZc1QZnqqk6OaDlomBMRUECed/RJRkc85wy
         J5fqar78nfZHUTbfMxKgedLTOoXp1jQVbwP8p4RJdVTYSs0GG4rdeP/UX28vF/3hsdC+
         E/gUOSReVu3jUmBjFKI7bTRYRYPHaGleOoRAPYNONdzRVW0ritcXVBES6Y+ZQ+BiISFD
         +3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNRmamrIlQGOjp3jqPbZx/AP6WBq1cBE3Igc+cDLZMA=;
        b=pJ4Xi8LUDT7NYSBmnrf8GAvZW0ZByRa9LM0xH3IZBcSb/ZOeRGLfX7DB95LJlWF4z1
         9KWtnysQ03T4rhFqQHcd/CLJMD7JV8JtMRjN0sKytjc4VOPMlTCLsB0gtUUYQ+VHG0SY
         Dxn/zmj3GhyFCjPDYLxhFA8j5AIMSWH4DkG9adbsKWlR5nJX2LUv0w7E26Ii1cVCPqz3
         fRfQgWhWx/VKkBPFFUg4I4OulE686/k2Dy4E2IH3yctf76g8NgQNcn7zCQAOazI/isu1
         oRku+B0CDI/x86hhwS3xLOKwsTtETFz6W+mAh1/3F526n+9lb4EX7JeYflPZaQC/nZAJ
         Xb1w==
X-Gm-Message-State: AOAM530ueIzqGfOGYobiBM177cNm5fNgFyaI7EkfJcJyQRBbjXpezhA1
        lgW9tJocPVJ6viewEXH+sHBP8PctnYyR9fyP
X-Google-Smtp-Source: ABdhPJw4UU6VMCg3LNWXf1NwGtDIU8GM81NF2Lb5pVPq/te1M/tU/TYpXNh7oQYvXwyGnLx23sCxCQ==
X-Received: by 2002:a17:90a:fe07:b0:1b7:bb99:c848 with SMTP id ck7-20020a17090afe0700b001b7bb99c848mr1965283pjb.98.1644890985220;
        Mon, 14 Feb 2022 18:09:45 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id m21sm725043pgh.69.2022.02.14.18.09.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Feb 2022 18:09:44 -0800 (PST)
From:   Chen BoJun <bojun.cbj@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2022, #03; Sat, 12)
Date:   Tue, 15 Feb 2022 10:09:23 +0800
Message-Id: <20220215020923.38168-1-bojun.cbj@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <xmqq5ypj6rw6.fsf@gitster.g>
References: <xmqq5ypj6rw6.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * cb/clear-quarantine-early-on-all-ref-update-errors (2022-02-01) 1 commit
>  - receive-pack: purge temporary data if no command is ready to run
>
>  Check if "receive-pack" will do any ref updates (various conditions
>  could reject a push) before received objects are taken out of the
>  temporary directory used for quarantine purposes, so that a push
>  that is known-to-fail will not leave crufts that a future "gc"
>  needs to clean up.
>
>  Will merge to 'next'.
>  source: <20220129063538.24038-1-bojun.cbj@gmail.com>

I noticed that the merged patch was v2, not v3 which I sent last week. Apart 
from a more complete commit message, there is no change in patch v3. So merge 
patch v2 is OK.
