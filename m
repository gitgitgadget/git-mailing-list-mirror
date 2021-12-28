Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDB6C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 20:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbhL1UVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 15:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbhL1UVn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 15:21:43 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6041EC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 12:21:43 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id p15so6684948ybk.10
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 12:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UVtIM8ZvKecfh/GF7o19h6OTtK7zKVBgpcZuW7hVKnI=;
        b=e70aGHyIBI/IcmtaVML8nlsNMeNffSSYpsa/tXj6aLzaZ9bE6LouzDU6PFkx4905AE
         p352pWrZ/cTRaPJThJ8tLoEH5MXpGD56SMAwX7Z+o6py6cjxvJsO0fIeN20pIg8nj6w3
         FonLvQYcd1w3FmKWBRN45FNqUYWVi3FyFjBAqkYE9fwDzWjn8nkaBzYXOj4VGlXGfmx9
         q3pm0jxp7IGix5CtqApVQqkec9NeOjK6bXEeaBuTlT/P0HdRSF4ZpAkfpN0n70iszP1M
         PQzQZTlfgZOXsxmHJSCZ182Eyk8cNibhjEo+IF0aF1BdS9RtJi6wwgn++rlSwy/hGQMR
         al8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UVtIM8ZvKecfh/GF7o19h6OTtK7zKVBgpcZuW7hVKnI=;
        b=EB/ItNQoshrpP1G2XaplY4oR6LWkiGNyccNxoKz3xn/jxNEojk+Bz4Flp3PR2L9XjQ
         QhPQxx5oi7lubALnQkwzBxsMGvW004VrZ63UBBsvL2eKKqGtR9mO1hlAhjiBb6TdS5C2
         z40xksP0qTwpJczmIVPJbpJDAVsBrEm0gGZ6klRUTErukWBTGv1Mod8pk9yCEAtSAc4n
         1gtz6gv3FVT1/N2vgFPdukTNO7At1VMZOBiC5m3YQU7gJzA5UmE1038tfmEGAQDyoPpj
         YuXC2obnTy399BTvCxTUugBEbVsnwMTTJiejzO+CnDQmW6mtCuee2f+xsqVXXqqTn6Cp
         01zw==
X-Gm-Message-State: AOAM531+PnOUN3AKVfKmlboKpIuVPqTen13J6NFnEk0R3P22Sj9p2rig
        1EGELE2bxlYFPsjSahMLx6IYn0rhAYmGLep24z4/IkZhx54=
X-Google-Smtp-Source: ABdhPJwljyj41IVnWDsPKwgZLZe3TS0x4hAfdgDU4fcV4qWWJPhrOo+J4yYJ7QzYQJEw7cjz8yGMiNeV3wn8aIhnzS8=
X-Received: by 2002:a25:4dc4:: with SMTP id a187mr28280238ybb.631.1640722902211;
 Tue, 28 Dec 2021 12:21:42 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 28 Dec 2021 21:21:31 +0100
Message-ID: <CAP8UFD0ffHduEjAjEVrdstWMeLTqi-+4Rqs8fbUeULMpKYJ8Gw@mail.gmail.com>
Subject: Draft of Git Rev News edition 82
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        Fabian Stelzer <fs@gigacodes.de>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-82.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/532

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Monday
December 30th in the evening.

Thanks,
Christian.
