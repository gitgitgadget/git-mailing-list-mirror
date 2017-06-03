Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E2B209FD
	for <e@80x24.org>; Sat,  3 Jun 2017 20:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbdFCUxW (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 16:53:22 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33452 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbdFCUxV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 16:53:21 -0400
Received: by mail-pg0-f50.google.com with SMTP id f185so5543752pgc.0
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MMoo9EGuhar7VRCxjQt2jk0NNW0kizrV8eErLqhMQRU=;
        b=n1Ri77JuJK2+5LKFGLuRFwnnxzim79/uGHKxRD3sbYFa+dlvbwGqnyvPDu/yotPqaw
         lwcw8PX8tBdaRtpf0Fpul5DXEM+DSIP2ZScJv6Br0NgMdwq+0BWooG+O9unucwdAHcBg
         FQZqO0rL8yhfkPvxcGOev68RugHYdCAEwz4U11j98HkdUuhF9HjVIdNsN8LIgpllAKz/
         3qDimW+ef3gyIfwXB961R7SuW/yW65chzNHLWi2gq82+GLQ1EGnC3JxBao1oRa7Kaikm
         PHj6xHuVKJq9nEpy5/XqHtUDJ23yEnt5Kn1ppR0RE2KblDcWiZXVrgurfcjFQ11wEL0A
         5NIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MMoo9EGuhar7VRCxjQt2jk0NNW0kizrV8eErLqhMQRU=;
        b=NfmSqIFScc5hQgJVkbaP143V5LKzdbi68bgX8nLDDRcUS0GArOQN6yWLY37F5djyCu
         wOgOT7rAxiez0pCeSmVVAOS8mISifjxWTmWy4guEk7qYKWSYgWTk1HCPSWPjvjrq8/uz
         9XhfMX0khE8X2ySFEuBDxQ4i4oPtuudoIdKIvCFlhE6V1mLzdLry2Oxq51+EYtshx9jU
         3idJ6/a2BhW7PADyyA4NBWAS7l1dkABaHfuHWXJ0WlK4N2rMjDKApMg6kZa6MGFYFzqt
         /t30Dgn7jw6wI06gNXIsLH8V8fnZOa7brbGWDQ2/cdAkcYSz5MwE7zM5UXDkYZoy+Fs9
         Mttw==
X-Gm-Message-State: AODbwcA7W8N6Q4e/XhSsfuWBpd/RS/+ap3MuuQ7OIlupLAeR0PLToQHj
        k4iicSL1F/fGgRche+TbC1hvqFSQLV+S
X-Received: by 10.84.213.8 with SMTP id f8mr6676309pli.22.1496523200644; Sat,
 03 Jun 2017 13:53:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.128.86 with HTTP; Sat, 3 Jun 2017 13:53:20 -0700 (PDT)
From:   Dun Peal <dunpealer@gmail.com>
Date:   Sat, 3 Jun 2017 16:53:20 -0400
Message-ID: <CAD03jn5CEwZ0H+UKO4yW3PoL+XPXcwUGnehhv-KyBYQCYzAXGQ@mail.gmail.com>
Subject: How do I regularly clean up .git/objects/pack/tmp_* files?
To:     Git ML <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I try to follow the best practice of regular repo maintenance, which
afaik consists of running `git gc` every week or so.

So I thought I had a well-maintained repository, and was quite
surprised to discover some very large .git/objects/pack/tmp_* files,
which apparently are entirely needless and should be cleaned up, but
`git gc` doesn't clean them.

Is there another command I should regularly run, instead or in
addition to `git gc`, to keep my repo well-maintained, and
specifically, to remove such unnecessary files from my .git directory?

Thanks, D.
