Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA564C433FE
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 12:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJOMWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 08:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJOMWk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 08:22:40 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1D951413
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 05:22:40 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id b145so8506477yba.0
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 05:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9lC4XVGLS3xS02F6Ag9dCmXQl7Sz6KkvoznZxNdGyB4=;
        b=C1U9NN0PWEo8PmtTOk03nVV+DB3Yzqf6z0GnIK/yWJDJbu1J2a+0DG5I8S1UOY/zch
         2dh2RwOobmE5xl7Eczye8I1kt2fyWzNLEg0ulimyH0hE86WaaW/x4vrDlRMAxZdTh0/F
         0bMS0xVjSAzs6Iu2dCF1Sr1sImyWUiK1WaqFFemUUudzby0HhGip7MT1cGvua/hxoFBi
         QbMVMwaHr/0ocJKDyO2eayQ7/IE4tBuu/B3T/hvUzPWThCMJ+CfXycKNbc3G0ehRR16t
         FCLKuVMFG8HuL8MrLookdu6ZB3H0ebVGurouz2gfcimtJZL7NAeBJv1ezSpDCCoPNHHr
         ffqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lC4XVGLS3xS02F6Ag9dCmXQl7Sz6KkvoznZxNdGyB4=;
        b=ziiTmteatD96ru3qurJRmLXXUjf2Wj8f+tkEFYPz6vUYemuXVh9Uz7t/23B5DrLwlF
         W/hd7RHEmj/QiyTfi9M9h/5dk1vP2ZsO841MWx1mVgymklZEARByvg5dNy3swEPNJZbV
         dvd8W6iLmHuD0sUS5Tn7zf+PvETOHNWxUPa8NRct94D6e2OA+tQXGIXa2W14y1+vergP
         ldWZU3+oKXX9MbdIbKNADDcrB63Gh930KIrAH53PfTCvG4ip0M7F0MbVOrYzohKzQ8pO
         YWfelRMgYmj/Q02iEN/rqymtn9E2oK6nk8yp35WXlH0TCyCKKrgStYYTv4M14gKz7rDL
         Mnkg==
X-Gm-Message-State: ACrzQf1sBsWRW1dP6FjVndPWE230+CeemrV4mhGdwP4xsHa3/8n68jFI
        sfITBtD10ZfwO0Frb5nsPSO0skCWM92VQnCxfz1uXmQTLtNVdzUU9d0=
X-Google-Smtp-Source: AMsMyM5Ht75b54SMTpaujvhzILnLlHGlZockYpuuFGm0MJyUNddGZGU7Oh3QhFiE334vmZaV2Brso6JKdZl79P3jlhg=
X-Received: by 2002:a25:8605:0:b0:6be:975f:d0ae with SMTP id
 y5-20020a258605000000b006be975fd0aemr1922554ybk.178.1665836559168; Sat, 15
 Oct 2022 05:22:39 -0700 (PDT)
MIME-Version: 1.0
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Sat, 15 Oct 2022 15:22:27 +0300
Message-ID: <CA+PPyiEsN9dJj61VdnoT2=TYV54WTLA_-qL4CiT7=imuvuBdmw@mail.gmail.com>
Subject: [Outreachy]Amend error messages and prompts of various (sub)commands
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

My first microproject is still at seen stage, so I decided to look for
a good first issue from the repo to get more familiar with the process
of patch submission and I found I would be interested in
https://github.com/gitgitgadget/git/issues/635

The Git suite CodingGuidelines suggest this about Error messages, but
I found that git-compat-util.h contains die("Cannot handle files this
big"); which breaks one of the rules

I want to change it to die("cannot handle files this big");

Someone should give me a go ahead on this

Thanks,
Wilberforce
