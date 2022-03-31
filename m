Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74551C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 19:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiCaTRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiCaTRU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 15:17:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D72232101
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:15:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r23so497421edb.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSD7J5WOtsKJUblhhrgt242OTCb6ubnE8xkVEeCytJc=;
        b=PDCe0HEaE0WNO7rIDcEh4YwcwpMyDE1OD3GfFQbc2198iBNS88Y0jM6aCBE6XXchK4
         J/FNj+Rd+XuGR0qNoGMAnVg0PY/0LdNWiaA1Vyew4S6IaJdo/4y7PA/fZ9NcEAlJOqhD
         F3KaFIrXVNuwnv2m4tPtcVLumGSRckUUHjTUl4ouIhfxW3qhFCwtM9cUXTE18OtGZTlE
         CLeg9HOKkASg3cY7HvJKgd151sxSU4sAhsNy4iOW+ObEP17tbp7Alt9nWrxmnDRza9jq
         BbCy1P0e/Q0rumQW78yUHsugABkfDau6vw4+n7Rb5/bZM42+nOfDQZIMiTsbvjfKWwBA
         /caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSD7J5WOtsKJUblhhrgt242OTCb6ubnE8xkVEeCytJc=;
        b=G1lQ6+ud4XvHz7kiZ7v6b13wKZCzmyCiK+OKTJ6dhcWdnCbUIUdcbOkvrAE+6jDgGm
         9RDq/LAVJO9t8uTm1xdMBo125gtJR+xkTzWpM9LcNs7mr1Ej7Trwo40CXGxY/yWrf2Wr
         xvs2D6VfouaUvi6jVvufa4djuK26ettjcjgde4NABeW1pL/BI5S3d4F451iDuhDcY00i
         NpZIrPh8dhHvhzSIdcKq3TBXKMbMvbH9PHMwGPQJsDHWUJhMhVS8rHF7QklWNhXhd732
         wAGRzoLtc2v9SJSlnPSHB7p8vd0sjhlWGuIlP6frOOsSeKmYeji7jLu5Ar9M/LszA5Y1
         hr7g==
X-Gm-Message-State: AOAM532C4RZbIlwXIAdjKfdwY9wg8qH0lfohsUugUzmCJY6u4XcucUGh
        gqpDpme95/CntnCHBhlwQkPSiD95SJvKKEuk
X-Google-Smtp-Source: ABdhPJwkpEeH0FpQjKgZ7dG5UJRyGGKzIYhY/ki2oSz9d0uCgD4M3y7rkARTXI3liFM8uNLWVYmcYA==
X-Received: by 2002:a05:6402:84f:b0:419:638f:2bd5 with SMTP id b15-20020a056402084f00b00419638f2bd5mr17730416edz.283.1648754130329;
        Thu, 31 Mar 2022 12:15:30 -0700 (PDT)
Received: from a35b75bc573c.europe-west4-b.c.codatalab-user-runtimes.internal (81.245.204.35.bc.googleusercontent.com. [35.204.245.81])
        by smtp.gmail.com with ESMTPSA id hp12-20020a1709073e0c00b006e02924bf20sm106181ejc.117.2022.03.31.12.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 12:15:29 -0700 (PDT)
From:   Labnann <khalid.masum.92@gmail.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        khalid.masum.92@gmail.com
Subject: [PATCH v2 0/3][GSoC] t3501: remove test and test -f 
Date:   Thu, 31 Mar 2022 19:15:22 +0000
Message-Id: <20220331191525.17927-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <220331.86bkxnt77a.gmgdl@evledraar.gmail.com>
References: <220331.86bkxnt77a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!
Thess remove test -f from t3501 and test command. It uses test_cmp 
to hide exit code of git.

Can I get help with "git reflog -1 | grep revert"? About which helper
function I can use to hide the exit code.

Thank you.


Labnann (3):
  t3501: use test_path_is_* functions
  t3501: don't ignore "git <cmd>" exit code
  t3501: test cherry-pick revert with oids

 t/t3501-revert-cherry-pick.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

Range-diff against v1:
1:  8b7d38a66f = 1:  8b7d38a66f t3501: use test_path_is_* functions
-:  ---------- > 2:  04b0bf1c5d t3501: don't ignore "git <cmd>" exit code
-:  ---------- > 3:  36445b40fb t3501: test cherry-pick revert with oids
-- 
2.35.1

