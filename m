Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DD3C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 21:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBFVSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 16:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBFVSt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 16:18:49 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D8A13D5B
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 13:18:48 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id v17so14548810qto.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 13:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GZ5ze6g6l9NUpcHN0JhxUezjd4Cy53pZKoXLg/qP2Q=;
        b=NlRjLoxCcWF43SvQhBcKjbhv+ipG1qGTEWIdcKb8npoc6z0ut51XqiBbrdAEP2Q9Q3
         GKh2ed/BLIH5yJ8330T2gFuwYOXb2H7UPV1eunXlpY6GldfvXfSYhUZagnzUQFfW4gVo
         GtKmlqRe3tyRY+CrOBsXJsflTr+JBSmrtcr9Th6f1HLlVopPno0rgDEPtwHfIAfilbZr
         n155XCUTMTBS6y38Tx8gYMW30DsGdzdR42CiiDPToB5U8IqlRbKWmurunndvdqM2Ewes
         mtl8qG3vfvWPJ9xwRJEDZ4RdI+7+JRrgguLIA+H7FQOznPfSx1HqysdwnHPCzC/I5J/A
         JNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GZ5ze6g6l9NUpcHN0JhxUezjd4Cy53pZKoXLg/qP2Q=;
        b=5vTAR/gtteUZVZweGXCHqDxxvf+QM/ljTA+6u7uNAF9tcQugrdcr5v2jvGg92JYU84
         ZoVc1HWrfSValCxOiZkCfN0hd2e4sYQihsvi0QLpjOxr9xdTYjXR8AYN2VZJJDTE2O9V
         xJM6zITntddrEWJffEkN72Z2pMZl0Wve4fmzpUnCk1gtAMQmXm7YgJUWPsRbYUpmv+Cs
         N587o+Waiba2Q1PXu/HSpuuwd+/naaBlFSrzTkZRzPwoCUztyW/uLAhx496mwtCoYSFu
         rBCK3f0ELZrzRpybrhWIB/OEpcp0CYbWhpQ34pnKOp3mFnb74vKwa9f84RlV1gpvmwoB
         xEsg==
X-Gm-Message-State: AO0yUKW8g3rId+yton2x4puL/loD3k5GUHdwhIlsNyTG4WN7NZpo9+3G
        eFU1WsyjnFUEZFLkI34aJFBGszZaocwpoQ==
X-Google-Smtp-Source: AK7set/Ty+yQkq6qNJwr8CpBS7jnVh8kH4lb3GKkM3NSujKvI4TucYhkiohMABfE6oTnF6so4C/0YA==
X-Received: by 2002:ac8:5992:0:b0:3b8:6442:2575 with SMTP id e18-20020ac85992000000b003b864422575mr1446454qte.49.1675718327108;
        Mon, 06 Feb 2023 13:18:47 -0800 (PST)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id f11-20020ac8014b000000b003b86d5c4fbbsm8033014qtg.1.2023.02.06.13.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:18:46 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v4 0/3] t4113: modernize style
Date:   Mon,  6 Feb 2023 16:18:20 -0500
Message-Id: <20230206211823.8651-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230205145245.11078-1-cheskaqiqi@gmail.com>
References: <20230205145245.11078-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Slightly different from V3:

1.Swap patches 2 and 3 because in patch [v3 2/3] leaves a mix of tab and
space indentation in the tests

2.Change the commit message in patch [v3 3/3] to indent with tab.

Shuqi Liang (3):
  t4113: modernize test script
  t4113: indent with tab
  t4113: put executable lines to test_expect_success

 t/t4113-apply-ending.sh | 79 ++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 41 deletions(-)


base-commit: c48035d29b4e524aed3a32f0403676f0d9128863
-- 
2.39.0

