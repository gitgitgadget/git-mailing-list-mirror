Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD59C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 16:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCUQlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 12:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCUQlU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 12:41:20 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A25F51CA0
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 09:40:55 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id i22so10695593uat.8
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679416843;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BxPZqO+H8+5uMgCsbsSO81vf5wTk2JocTAZ/dp9sfFU=;
        b=owkumrWzZU7gw3y6phaWGIppT4FIQzLfut9TbtK7sExugC9pdxCQ888624TwEKmR2O
         Hch52txIEEnypXlSoZtxuFtCwyXbSQuBZ2RB+VQdB+UNsKqX5UCWTSFtHIFrib66Ibel
         sX+16xyjzCvUeaWzdD0sPndrJrL5wwKlQlkyLbPhwOVf9+PVDn9m9P18Y4DnKuJ5c+op
         x4G9ocZ++uonkxbJYjLeJmfsQKVsNXl5uM5tGhz6YKMpNpyHuCxY2/5i42w5cjBkQu38
         8FTvVvJksycisQyKFA8LqqSCQTNyJ4gUeuUYxCMYbbXvUq7FnmH3aWueMg2LxlEp00qW
         PbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679416843;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxPZqO+H8+5uMgCsbsSO81vf5wTk2JocTAZ/dp9sfFU=;
        b=pLDlmScdJFC+ax+432C/7yL6e0zeezelibbkqooAgcDbvd1e9+KLFaB6RtwIqFh/zw
         TnQQGNfmUop75j+LeqqL3KUh8eRERAJEEwTtrO/CjaEO/+2j0o0yaZXTzqDnwaXBzhHB
         NQ5Fq3a2RnQymhBpVBMCNR3xFmlAughTeNzSbT7fF/nEr7/BVRhDZiuPegONBZZo6asD
         aHXLcxbvtdTaNfaq96feDzcE61tBpLAWSPU15ZyIgFi++Y6kqPv0OG/9o9bVu2CGQKmT
         Z+NgBWSR8IhXBH2yEBRfcd9wP7t3WiaPfDXC2XdT9w89F+p9NGJeasJYz7XxaTZV219X
         VMEQ==
X-Gm-Message-State: AO0yUKWKujk7UThC+IG/Y7D4NJ71MZVWEFNvXBIPpfgVbU3uvYfKUjts
        6BMoZc9E+LYXBxicgZ28DBIFZLcxifBnU7hBuBBp8Qhz/GQ=
X-Google-Smtp-Source: AK7set/9y2qizzhNbUdX71vfXoZfaEGexGltF0j1oyBQr0q1vBgzp1NU+8hGCVldxwV8NVZgBq2osJA8ldBNDU1/IVY=
X-Received: by 2002:a1f:2144:0:b0:432:9a63:1696 with SMTP id
 h65-20020a1f2144000000b004329a631696mr1767824vkh.1.1679416843021; Tue, 21 Mar
 2023 09:40:43 -0700 (PDT)
MIME-Version: 1.0
From:   Kai Grossjohann <kai.grossjohann@gmail.com>
Date:   Tue, 21 Mar 2023 17:40:32 +0100
Message-ID: <CAFmGgWVVdgQj_gzcDw4Lyzt1aBc-7oyt8=JT3GskHegUu+8sTg@mail.gmail.com>
Subject: Documentation: "git am" should point to "git format-patch"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The man page of "git format-patch" already mentions that its output
can be consumed by "git am".  I suggest to add a similar remark to the
man page of "git am" to mention that it consumes output from "git
format-patch".

I read the output of "git format-patch --help" and "git am --help",
using git version 2.40.0 installed via Homebrew on macOS 13.2.1
(22D68).

Kai
