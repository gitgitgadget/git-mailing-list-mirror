Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D1DC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 13:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242718AbiCKNX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 08:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242502AbiCKNX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 08:23:26 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC531C2F7E
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 05:22:23 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t14so7460630pgr.3
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 05:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOTjLMq5Cq5CEha89zlris23/hLR+fsRlNGLJlHasIQ=;
        b=X7RaWrVpzW0zP0rVv0AjAfgA2hHorSnpURK8Gkk4yeAS2EoBZgfDKsWa43CGVJkOhr
         tY/yWQL+9U6BwuHV4rs46Xe1hD6Up3dvSYpyXKL+JL2cZyS+S6a+jSGw635Um/rOkuzm
         9MjbeDZt1TLcy3vD0GxeIkuc6Eq9P6MpzNOxYWHQWHRUegSUoC7CWfY54violJ7lFp1K
         fTF6AGoUGHwRAuTyrH3pzCL7tAn8TG7LbBobKZd1X0DmibmGmXAlavOYjrJMQ1JUaA6o
         lDfcQkuyyA5RFOlNaZtlKqfwmxyEGmxeDAkjo8CIPqWeH1UWRTR0dyJf5uPHIO6ijtVc
         g/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOTjLMq5Cq5CEha89zlris23/hLR+fsRlNGLJlHasIQ=;
        b=v049mX1iPWm0cDS28bbUFZVXhmN6mBOB34U5lec3EyheNRILLgvchMyC54AGk4lj+O
         u3FF3XUzSs//fV7UurY1ZjojN8W/MQaRz50tSkENpuTXaexSBEb+hF1no/HnyMm6YCbq
         diNhADOT47Ykqov3YLauSS43DlZqpHkNXqohVcXfYtStnHJNZ/Tnat5fAvbN0tGDgUBt
         lxxEjOLc6Xb8sQmAu8WNTTXxWBKGGUyyr4xg9XzayYZa8e3FtPe6k+l8SOm5Rus4GnaZ
         l9elngojCwn8V0V4kAzrKI/ZW6rxFx81i1WwT/pYIoUfQe7t8o9T2/QA1YWEuNTAjmC2
         pe/w==
X-Gm-Message-State: AOAM533KnXMvIDCarbusnyMtafURG3hsEDzQ1ojZtju9tqxxc8vIdqVj
        /4I5HNSesLStUHEwrjZjA4D3vVci1S0=
X-Google-Smtp-Source: ABdhPJwhNnHIaDPgH280TIxy+V7G06LBPElkix7wQzcaWDxZ5Vdeqy8qIBZry1F/Mi2J2rvcWYBfwg==
X-Received: by 2002:a62:7793:0:b0:4f6:27a8:ae6d with SMTP id s141-20020a627793000000b004f627a8ae6dmr10261802pfc.65.1647004942198;
        Fri, 11 Mar 2022 05:22:22 -0800 (PST)
Received: from ffyuanda.localdomain ([119.131.143.198])
        by smtp.gmail.com with ESMTPSA id l10-20020a056a00140a00b004c55d0dcbd1sm10496882pfu.120.2022.03.11.05.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 05:22:21 -0800 (PST)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com, newren@gmail.com,
        bagasdotme@gmail.com, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [RFC PATCH 0/1] Documentation/git-sparse-checkout.txt: add an OPTIONS section
Date:   Fri, 11 Mar 2022 21:21:40 +0800
Message-Id: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an OPTIONS section to the manual and move the descriptions/explanations for 
these options from below COMMANDS to OPTIONS. 

This patch is based on Elijah's series [1].

[1] https://lore.kernel.org/git/pull.1148.git.1646725188.gitgitgadget@gmail.com/

Shaoxuan Yuan (1):
  Documentation/git-sparse-checkout.txt: add an OPTIONS section

 Documentation/git-sparse-checkout.txt | 63 +++++++++++++++++----------
 1 file changed, 39 insertions(+), 24 deletions(-)


base-commit: b5b154774abc80247a09c488c5125d328153c1cb
-- 
2.35.1
