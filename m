Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C45CC433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 21:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0020D61041
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 21:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhISVkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 17:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhISVkz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 17:40:55 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA394C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 14:39:29 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t4so9790815plo.0
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Dol0SwXJ/mESzMBlD4QsKzHnCHutscdg/mg7bUMFgpc=;
        b=mqqcgwXYFcWCZgJQ1THPduZMcMzBTlysIR/TdPP1JAbC3zuxa3ZU/WQDakREO3fvqX
         2/t4aCh+Xk/gbTsgKWPoJ8X7bAvLw4a5/lKP15a1mYKk9Bc99Sg0Zgsd92I2CHNubATg
         +04I33rknk/oiWn4nuQ1UdJvBMq5FrlSjga9/o13OgvOvtWiY77Ov7mFq5subdzGozhp
         4zwFoHc08Qge+aJ7WltDh+mzeWjTWlrVr4AHKZ8ORr7FIhLXqz8AykrdPcF7WfXFDrzf
         PxlLESId/m588evrMw33zajwfg8v2u2ySW7HstVdttnaC5rFASAQn9q7mTZ1XdXkLWYP
         BjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Dol0SwXJ/mESzMBlD4QsKzHnCHutscdg/mg7bUMFgpc=;
        b=Y6IOm+LH6RAETo6Bf41sxSPzNRpNuBnUHimOm84P8bgI9oZMbmyEnpMPTF59MjuY2l
         IWLnei8dOp0yEv3rXO9kOvbZjfGnZyIDGr8M0H9UguIYozzHOSFO/KlEdwklFU/eT8FC
         ak2GFNwDqu2ZAzSQjQMdk4rQyw8ennfcH30+Tcp322lLts0f2xg26GwPuwfXWAMdHXhX
         d0jDfLoiCah4nOacyHpnkPJE1t4cmp28DcoChl/6cwXMjVBtOVt6SUA31ppKtCCxN2px
         fjqv7VfGoj5+qyN5FMNGc5vxjpp5CfGFU240OdIqwaMRz0G1/JJ5sEl51SO1fGF8uv3a
         UeRg==
X-Gm-Message-State: AOAM531SgbGOGEPQP0BjT2HIjnsi4B5lbyz8rrfesW4LYesQv/FrcH52
        CPqQUYLk/NMaGF7toE8qnp8a0eOgvvj2XSMhhuZ+7Oj194U=
X-Google-Smtp-Source: ABdhPJwM9hwS1AgJvA40slcsFDwpE7SNM/xIuyPkPvM/CJR6G8yFUHcd6hq4OIxSGVDfYB27xVDKaQZZNs/NIYcLqNE=
X-Received: by 2002:a17:90a:bb13:: with SMTP id u19mr34170905pjr.42.1632087568748;
 Sun, 19 Sep 2021 14:39:28 -0700 (PDT)
MIME-Version: 1.0
From:   Ariel Man <arielman22@gmail.com>
Date:   Mon, 20 Sep 2021 00:39:18 +0300
Message-ID: <CANgfOPtz9JqCs-7z1DJnOqxnsGiQS6BBPD6tKTWnTpC0K3qZ9Q@mail.gmail.com>
Subject: =?UTF-8?Q?Question_about_git_merge_=2Ds_ort_command=E2=80=8F=E2=80=8F?=
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
following the below thread, led me to do some tests:
https://stackoverflow.com/a/69114710/11705021

One of the test can be seen here, in the last example in my question:
https://stackoverflow.com/questions/69150777/git-mv-doesnt-work-as-expected-wrong-files-location

I wanted to get confirmation for my case:
Does `git merge -s ort` command, doesn't know to detect new folder
location when merging it? It did worked for folders and files
renaming, and new files under existing folders (as describe here:
https://stackoverflow.com/a/52227201/6309)

Ariel
