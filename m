Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269C0C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbiCJNgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242424AbiCJNgh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:36:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BE314E96E
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:35:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u1so7983095wrg.11
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R+aj06l2QUkOWVDFbCilpCivZJqea21joZzAjJBAknc=;
        b=VLARxbjt63ISywL/AVjsZ5Sf5Tixct0kUR/J0NFvTaafk7yVsIrNZXJdhf1t/yFpO9
         WjjmON2owX0Z46ov5XYGmydWiAc3ok8Y+APM83NBU8TJSlhLEqUI/HNsXzreHBpR5Wfz
         sATYSGQsC7K++mnberBy+yFj23XBKpkHLb8mySc+ZH71gvoO0U0KCu7K23mgdEvzpoyp
         KM+MZIP8S2PCwFgH5oaoqcICFUS9gYVu+WTNP5LaAxPuELa/KUcJCZ+q9KoVjB10S3cg
         UlbwlXlHcGLutmKTzBb8T/vYvr5GzQn5aClwR1LFi+M4+5EwB9Q2MZ7QtIwFmuG23zFG
         fv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R+aj06l2QUkOWVDFbCilpCivZJqea21joZzAjJBAknc=;
        b=QKPn4ZOuCBSoijOfQEIvfI96O5dZ7O/D2H8mXg8DAcdmegNPrdB96JWPrQpebDBiyX
         14OnbehD/SDgCIj6nSLRqrj5KMlUM2P5gmILaM4ZFV5CURSfxYWL7U+nxmXT2jKEjAcL
         M5YSsvu6Yxt67l0Knj+9PFu8JhyLjQCgUEycA9sbHtuwKvNL6XRKqDvgq3sjiOQT5YSE
         0Tc2UdSBFCkE7DKx8hEoRRdHK7RPYb5JMuB8R7WBVp69kaXospkRY2WYYCWyFMl9eXNE
         8pzODGeaKPPmSWH8i+AlItwsxIHyliKMhXk9/HA+MWZG+zifKrnLDv5kHoOytl1qzcn6
         IWeQ==
X-Gm-Message-State: AOAM530lf1kAXro43vgHwrCOTZZhxIkNU54ccfcYw4CcXXQAosTe6rYT
        ubUgm+8/zOL0SZmysSOA5SdTgnYPp30=
X-Google-Smtp-Source: ABdhPJxBTSNLOxye9PrBCQfkzUgXsdXQluKWbdWwM09EAEHlLG4yKfIgCQwOheg9NyKH1xRegVPPmg==
X-Received: by 2002:a05:6000:156a:b0:1f1:f168:69ac with SMTP id 10-20020a056000156a00b001f1f16869acmr3883392wrz.184.1646919335711;
        Thu, 10 Mar 2022 05:35:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12-20020adfa10c000000b001efb97fae48sm4393907wro.80.2022.03.10.05.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:35:35 -0800 (PST)
Message-Id: <b893f6a7faf8e27fc7ba3d214bc44925614638cf.1646919331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 13:35:30 +0000
Subject: [PATCH 3/4] trace2 docs: fix a JSON formatted example
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The example was not in valid JSON format due to a duplicate key "sid".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-trace2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 8ef921a4e4d..285f713ed84 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -128,7 +128,7 @@ yields
 
 ------------
 $ cat ~/log.event
-{"event":"version","sid":"sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"3","exe":"2.20.1.155.g426c96fcdb"}
+{"event":"version","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"3","exe":"2.20.1.155.g426c96fcdb"}
 {"event":"start","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621027Z","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
 {"event":"cmd_name","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
 {"event":"exit","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
-- 
gitgitgadget

