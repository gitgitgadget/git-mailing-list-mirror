Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6E1C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 23:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355709AbiFOXgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 19:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354405AbiFOXgF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 19:36:05 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9F91FA70
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:36:04 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so1946764wma.4
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 16:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Rz4Spf9wJ4JUzJ6rRlAuh8KL9eEdhg8OuaHDT2kKLkE=;
        b=erDyRc619uxEPNLB1Q/eN+3sYi6HNuibA7yUbPDkBhiyKsXzalA2h/XldpiKahhnpF
         zKjGVNChR5NJZRsKb6CmQuOOYWQFHCY0Ddc1g6gxRmfMfdNq2lcu7sTFpY+mtPmWl+4c
         xT/4McwmGkLDzFGKyl6IK9aV1y9JiFNNuRT3mPzEf6OGoVcGQyiKBiXBx8YbgVgrKvOG
         9ueY/W8JAZlJEwCUd+nlT0vfZk/BhY7LSOYRYQsOnqu/Yho9Gb2LEQNPO/PrQYotITV8
         VatmctypKYqdDcQmALwbFME1hpy5Cn9GnBa4bjLcy+4YInYFS/3VvaO9wfxlMdCWF0Ra
         Xobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Rz4Spf9wJ4JUzJ6rRlAuh8KL9eEdhg8OuaHDT2kKLkE=;
        b=y0h8F9ppRfXQhHfv/iF6ehwxY0gt8oYMR0/j22xhbEhjLJLwAD6QqPw0sMjrLfzIac
         3rCjMkWfKLXhNC+XOLSxkWb28BxyLnu9X0qSbHlFEnWc8T+07xwQTgRO6H31HHPvls1u
         A6AWSox7ExdkopcoR6ecmKETnrt5th0T+RQ4s8Wiq9/Lx+fPOgtXGaMWsVlTnvPPXTZ9
         6wA2iXAPCodUMm5GSb1JUKivzes9dYVQjyxJoU+e8CQLvcO85mh886fIIXbVDlIA3qRO
         bg56kDzA/bh0iFZRpnM0vUe4CMEuFQCQxIc2aENEpPswH55Htt2kmA+zp0b8dmsBxxmU
         Fz8Q==
X-Gm-Message-State: AOAM531NMGYHvBZJLV+N4+h64fmUAmJeN97hUVEGf3E7MnyUFPratUY7
        bpHpbyHIMaATN/dOGbNXLmTvwQXHmpTeRQ==
X-Google-Smtp-Source: ABdhPJzAYZ/OLJVofTMJZpMjsc5HV23Y+3hlmfD4GGIvklzguH+bda+nTzcIlkIJbpg6zmg/MFkAbw==
X-Received: by 2002:a05:600c:3ba7:b0:39c:5b80:3b76 with SMTP id n39-20020a05600c3ba700b0039c5b803b76mr12572880wms.35.1655336162745;
        Wed, 15 Jun 2022 16:36:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3-20020a5d5943000000b002103136623esm229630wri.85.2022.06.15.16.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 16:36:01 -0700 (PDT)
Message-Id: <b176e5764f990fbf8c132ae1563027531bd8cc9f.1655336146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 23:35:43 +0000
Subject: [PATCH 09/11] pack-mtimes: avoid closing a bogus file descriptor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 94cd775a6c52 (pack-mtimes: support reading .mtimes files,
2022-05-20), code was added to close the file descriptor corresponding
to the mtimes file.

However, it is possible that opening that file failed, in which case we
are closing a file descriptor with the value `-1`. Let's guard that
`close()` call.

Reported by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 pack-mtimes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pack-mtimes.c b/pack-mtimes.c
index 0e0aafdcb06..0f9785fc5e4 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -89,7 +89,8 @@ cleanup:
 		*data_p = data;
 	}
 
-	close(fd);
+	if (fd >= 0)
+		close(fd);
 	return ret;
 }
 
-- 
gitgitgadget

