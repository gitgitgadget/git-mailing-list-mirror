Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C1BC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 19:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiBXTJC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiBXTJB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 14:09:01 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4D21A805F
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 11:08:31 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m3so4212008eda.10
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 11:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=yzLvyPsPw85fRx5bxe1Wj4txe9TSXnzdlnYM7GOVCFY=;
        b=QDR6JUwkqYxzZ89gkEiduw911GzB4jUMxTLBUmYBx6ETz/QXJMXUZ3eqTycbfCeOXp
         7Tkhjx6bCgOJ0nAPFzjZ0jJ/f15bQnCvu0kUESroaI0OrlKgmtb7XDE4OIMJ7t8oXAuT
         c1Cygm1tFGduRYkkD6BG0fhATJcjwTANcJDhLfNVckn8wno37qBXeZAfxMeCU9fefJ//
         poGkCqQMgCpOfBkr29RpbMXmCWKKiFobOFuUo20+8dhnh5pcNsrXFQMnrjBYnzVS1rn/
         aIGw34vuOcDKWsXl1/JA6sVcejCTLWbMGQsmdBGOsx2n5sAXuLyoFU2uKryIKNL8rFCi
         25mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yzLvyPsPw85fRx5bxe1Wj4txe9TSXnzdlnYM7GOVCFY=;
        b=Gf+hJP5+FpB7c1yvLRdlZ6m4HXV2hfAxMMflGRZaZgoZwpqD2gfWJeSf7u0vZLNeKh
         Z5pM1tvIpUFYHojuq8tUVGUuvevTR5S7oZxhujGC8JGtXSOKlQkf4jz6KK02eqxVBmr8
         oQyuZWs6cBZ9n2CrHse77vd+oZsb4yoGzWCs1igjgwWyLf/hdTXtrYPU+uMba10Qi1RP
         LuBQP4ITqv8s5kZqyNzvs5+Xi6nvlOB7f4+gFxIB2CUdsgqKLgTRpRpVBT1jhL/zkukz
         QszTGKQLL8/SdgSlcjuyFyXrZP6qBsKNkjVeVMmkIWZ45oMFv12cN9doRyFofy5aEkf8
         M/mQ==
X-Gm-Message-State: AOAM531y2+HKVuVYjgUvR3hC3hM1OitmQ6cpsl1sdhsrLUBE1ZvH1Dey
        vqGrvkE9tL+yF8RuqeWBuehhPdfSjFP3bw7eO270ZBRqlRc=
X-Google-Smtp-Source: ABdhPJyDpgYJob02go3sOP7qNMEVexfTrPdUGog6gsQxyPfObIlCdfnL0YdVp+8GnGGYuOsdzYPSid49W1JS5KK5sF4=
X-Received: by 2002:a05:6402:35c7:b0:412:f150:420e with SMTP id
 z7-20020a05640235c700b00412f150420emr3715924edc.63.1645729710072; Thu, 24 Feb
 2022 11:08:30 -0800 (PST)
MIME-Version: 1.0
From:   Jake Herrmann <jtherrmann1@gmail.com>
Date:   Thu, 24 Feb 2022 10:08:18 -0900
Message-ID: <CALiY8nFgenz3vKtCz-RPrz6MGU5tV4CrUxfnQBTt5TDye_ocqg@mail.gmail.com>
Subject: Feature request: complete Git shell
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is anyone interested in implementing an official Git shell? Just a
minimal shell that would essentially pass every command to git, to
save the user from having to type "git" repeatedly. Example:

git> status
git> commit -a
git> push

Various third-party solutions to this problem exist, but it would be
nice to have an official shell included with git so as to avoid having
to install a third-party program on every machine where one uses git.

Obviously it would need to be named in such a way to avoid confusion
with the existing git-shell command.
