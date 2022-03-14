Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C400AC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 05:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiCNFnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 01:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiCNFnR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 01:43:17 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D923E0F0
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 22:42:08 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y17so3122916ljd.12
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 22:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=XbxH0sdNBHX7Bxf/P7GmJ1FPgg/5cjYSpsZ/2UhOuUk=;
        b=p0yUJOtu9fPaXC5LDJ9ZEvgA/OiQfV9nElOwh7k+NCrBtTW0ruQuftlJ4zeiJ2yXrC
         0H1VttNGe/j2bBGPOgGqRFpDtVrJtPZRZfbKA/MeJx4KK9HVcu2Y5QMa49ykVXUo+JQ1
         2Qdke7yCamxV7uIfHDVYFcL2trGfAH+R5EGd0KSot0xUQRaQUjFQRwIcxtN6B2wt+j6t
         cQZpbXaCayL5eFBVXreM2QQMhI7qG/wdskbHIpi5fpwCJOZiYmza1UAIFmxm6b9a8g+s
         hbePchygkFLCVsIjI6rKbfTVSHwA1xDmszNy2HrJCCSIhoWix+PGzNMNlWGbkfvjetHk
         e6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XbxH0sdNBHX7Bxf/P7GmJ1FPgg/5cjYSpsZ/2UhOuUk=;
        b=h/fhzmenrp4yq70IrOvp7winCEZUP8Rayl4NIli4ibx+c+SgtdzpYQ4kjWX/KMPU8v
         qghxJ7n8SrAvn+tnGwH4KmWjef0VwsPiMtq85hn6xkDzHhs/YG+F6EAaMMdNJIHkgoNM
         hfsATvxga3xIZN2izv7goDwgkxswiI/o2vNqG1vajmUex0xP3zeijy+L8+Bb4foZAY39
         er4T56NeWL8ByYDVDbs9QIQBdJFgK303O0OPuU+ZEB5ZHt8DHszDaE6JE3j5HLe9fZA3
         ZmS29zM4MZuXvZUBPjrIfi7Jn7/CFOHnQ/rEPsj1ZzaKPTA4iZqAo88RWOaETpgTOQ2z
         iL/w==
X-Gm-Message-State: AOAM533dT6i4AjGosPGIbUNzmpTvQPW/+iK+8tXrcFLIDNwBisoXWLff
        x/ABNrz3rA/VdWmko0JcfIqt8TLPOf6Jo6eOfpDanywfF6Rf
X-Google-Smtp-Source: ABdhPJyJrxkP0HtWFnXAb8xhZa1CaPNQKKa6AV+I7mFBQGt5Z4XQRhW/juKIyle7SFzvjTE4Fz2IvPizOViYP8JBpss=
X-Received: by 2002:a2e:9997:0:b0:247:ec9c:8efb with SMTP id
 w23-20020a2e9997000000b00247ec9c8efbmr13006940lji.297.1647236526608; Sun, 13
 Mar 2022 22:42:06 -0700 (PDT)
MIME-Version: 1.0
From:   Yubin Ruan <ablacktshirt@gmail.com>
Date:   Mon, 14 Mar 2022 13:41:55 +0800
Message-ID: <CAJYFCiPw6VPPKpiC0f1iwdYf0LCFCbfrpNSHFs1qbwtGXX6pUA@mail.gmail.com>
Subject: git cherry-pick with --no-verify option
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Is there any version of Git that supports the cherry-pick command with
"--no-verify"?

It is supported in "git commit" command but not in "git cherry-pick"
command, and I always have to move .git/hooks/pre-commit away to work
around this in case of "git cherry-pick".

Or is there any reason that it is not included in "cherry-pick" command ?

(Please include me in reply since I does not subscribe to the list)

--
Thanks,
Yuibin
