Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C0F91F404
	for <e@80x24.org>; Sun,  4 Mar 2018 17:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeCDRJ1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 12:09:27 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:42233 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbeCDRJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 12:09:26 -0500
Received: by mail-qt0-f178.google.com with SMTP id t6so17769936qtn.9
        for <git@vger.kernel.org>; Sun, 04 Mar 2018 09:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vsTBua9sXPwjfNRKRXict/vXemuAm7VaobDlrXvNTvM=;
        b=Ce0cQIrifKrJVk0Si/N8/SGm+EimXhUD+CldXgqWn1FSZu0Ph3RtxpW1kbMxKBMp1J
         yyCQ6p99/0npUHzkCwxitPHyRg/YsW/Gx8Q7Kgg9D5feq+JDTwny4SfMJKAau7gK5dkt
         IH4UcxYjmvjsDPGRfBKfLw8/tOiR6q+jeB9iDWiNHgnZsBsY46hPuYEToMSGT3AwLxwB
         Ut5yWgUQJck6gB0A/ap65zGBOuFYsaFPSZA5eTQkiEoLrMC6MvLydb1lV4C027vl96nt
         cbU7pFZ1McUSFty99U65xoStsCGl87sChbLzE56+ayTXpAXU2ocVaeyvusrJqh6M71Lx
         KorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vsTBua9sXPwjfNRKRXict/vXemuAm7VaobDlrXvNTvM=;
        b=V8JcKcggLcKsQW5U0gDnRSQzwuRTH3vEV3hjRG1bwo/aSvtmSO8b2ZNEINogI7VMt1
         0BO5Kcoapy818ofSp1PgBvLXUJaYhPUXJuQwKjaN5JgNSKExXSEopDw8fy4o5Sr8O6AA
         gGgp6QHXKAgneTEWj+YUiBe9nP/Oolv4C/8jGM7Mq5NdaVfxK0gSZYSgyYrWwaZ+9ltl
         DNVWJSkYNjYwPiQM2IfKGoJ3r/TbGmIVcM2XJIkr4b0WaLSuQviuXQJGi5Gl7Inu0+H1
         uvquVZ2Lb/1lIjT12ySJWa1wtRmYAoUI9FgU46vmZTXsQOCKmcf6/67kcID3wjXRVkzB
         GmBQ==
X-Gm-Message-State: AElRT7HvPUidrwtQFyeluTyrdODAaEqoCDqIE2OqkQpSjY/Q6j40HVGi
        OEJ3TW6oyu3IMOWXBmAlYTUeo9guNG0ZuhD1/JouBJLR
X-Google-Smtp-Source: AG47ELvVuW5ix9PaF//v2yaAnk3MJ8JXYP9Eu3vmzI4Ni7IW0dQvSOlVtOmqBrHdU3J76KpasiSjA6NGlAHhBfL+zAE=
X-Received: by 10.200.11.70 with SMTP id m6mr18790630qti.95.1520183365784;
 Sun, 04 Mar 2018 09:09:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.67.84 with HTTP; Sun, 4 Mar 2018 09:09:25 -0800 (PST)
From:   Larry Hunter <larhun.it@gmail.com>
Date:   Sun, 4 Mar 2018 18:09:25 +0100
Message-ID: <CAL+2DvQZ2V9c5Tmn8KCoDOuioOiBsGJspSTVin4qw1oFO2QAwA@mail.gmail.com>
Subject: [Bug] git log --show-signature print extra carriage return ^M
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is bug using "git log --show-signature" in my installation

    git 2.16.2.windows.1
    gpg (GnuPG) 2.2.4
    libgcrypt 1.8.2

that prints (with colors) an extra ^M (carriage return?) at the end of
the gpg lines. As an example, the output of "git log --show-signature
HEAD" looks like:

    $ git log --show-signature HEAD
    commit 46c490188ebd216f20c454ee61108e51b481844e (HEAD -> master)
    gpg: Signature made 03/04/18 16:53:06 ora solare Europa occidentale^M
    gpg:                using RSA key ...^M
    gpg: Good signature from "..." [ultimate]^M
    Author: ... <...>
    Date:   Sun Mar 4 16:53:06 2018 +0100
    ...

To help find a fix, I tested the command "git verify-commit HEAD" that
prints (without colors) the same lines without extra ^M characters.

    $ git verify-commit HEAD
    gpg: Signature made 03/04/18 16:53:06 ora solare Europa occidentale
    gpg:                using RSA key ...
    gpg: Good signature from "..." [ultimate]

Thanks,
Larry
