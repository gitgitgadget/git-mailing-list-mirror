Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147211F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfFRMYG (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44636 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbfFRMYF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:24:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so21416915edr.11
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OQcXUHxBS6yq224kqYH1CH+e5fbZrkv0VTnNS0DDVFk=;
        b=AJ5X0bLyqdBKvfDAUp9z3X5wvq9vtfzpgCBwc4ZU1HOwW4VQOGjKq4LJeldFC5ICmm
         XvLUIM5xIxsmkawTF16KppFnLqni1db3QnpI+QV4cRsjgbeLrvn2lYqRQZmZrs5m78rl
         AuB6evdCQOAfbRDBojhN6WNvn24Jkx4rgmRS3rR/jurOnp7Ty07HJj3bP5uLzP7Y7/ew
         iqL/NPHzHno/R4oCl1MZteSHHxxFljiQZNQqwWnfTBt3LkBlhP9iIT4Dulool6f4qcJd
         eHCbfFQaBDsz/C34lrbwyJjAHxVEiymPuAT0ELwLVJrieVdQ/QcMgtDKnPJiX4sgFEFk
         3HgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OQcXUHxBS6yq224kqYH1CH+e5fbZrkv0VTnNS0DDVFk=;
        b=sKCOUDov5aeiIXz6IZt+jzuRsrtm0VmYBTRaMutHughnLjCJbxRdlrMr5ps9l6tTe+
         yfjeK/9DLuyTHrCmg8P0iA4FW3sqm89P8PdNTeQjAltedUNb2beDGfEN64Q4fwFnz9/p
         lVxmAet8zsBlwQ1bqYkYpBosUfx2ngLhe/Qdr7zSvG78pDidajkUP9vwaeIqBny+JNd6
         8Go3YiO/9KEs/DjwfLFZ6rA5x1OukgkOLiV+kLfkba2oq2lquIjjlqn6qMsiPU24siWI
         NuYgZ59nQhmWOEHB3bit1zKQh0x4Fp25wnKZ6H3SG7yQA52jtIcuUfSFihLhe1GTBcnY
         Q3/A==
X-Gm-Message-State: APjAAAXK0KFtomYS5JWta5uOEhK87eZAfd4IAqj4mK8wdMi8LxBfornn
        2nGXgDGVtgu+lZfJZ58dSGiPwNEw
X-Google-Smtp-Source: APXvYqwtUusohH5gY5kEyCec2Hd+z0uO/uiU71auIO54njeks7Pg1V5v0fWeFaj8sxI+UP9zMAAOig==
X-Received: by 2002:a17:906:e94:: with SMTP id p20mr3981109ejf.59.1560860643055;
        Tue, 18 Jun 2019 05:24:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm1994484edr.17.2019.06.18.05.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:24:02 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:24:02 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:47 GMT
Message-Id: <2ed60dfffc26445cb3ee876bbde90916c24234c8.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 10/17] msvc: do not re-declare the timespec struct
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

VS2015's headers already declare that struct.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index 210f1b01a8..a03e40e6e2 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -352,11 +352,13 @@ static inline int getrlimit(int resource, struct rlimit *rlp)
 #ifndef __MINGW64_VERSION_MAJOR
 #define off_t off64_t
 #define lseek _lseeki64
+#ifndef _MSC_VER
 struct timespec {
 	time_t tv_sec;
 	long tv_nsec;
 };
 #endif
+#endif
 
 struct mingw_stat {
     _dev_t st_dev;
-- 
gitgitgadget

