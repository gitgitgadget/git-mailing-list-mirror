Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2370AFA3741
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 23:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJ1XnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 19:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ1XnN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 19:43:13 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B059B841
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 16:43:13 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id r1so3743574ilg.6
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 16:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wxrvkFp30g9RscftVrVw6zduEJ9o2RClRNt5y8mKyis=;
        b=SYA5vjCwqgxO8MdmIPi5CjwQr4oUO8C1xfBGfp7HrM40PscAU1xkDhEa+lFlg16LPX
         1vPcah1cqYqH3WlYihfzvrnsKIqYK7gCGQ+gLfDWJY3grGX09QRBA5fCM3CHNQyRif7L
         hZBgzR6euuy/8YmOgfIIkkKArLeqKbHsLANo7FMF+wJiQN3U4qs4bo+19+vquHb7GOHw
         4QAXFoXOrckAsle93k/Ql44q/nB5SohwhCKIqYwXHK8t4b2e8Rzd38IuE11GxG4YMfn5
         OCRp8gFSLuyYcKf0Uv1Sb3V8fB0zkgQ4hMpyBshxuAZ9LErCCFPo/R2x695x7cOceMQn
         aKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxrvkFp30g9RscftVrVw6zduEJ9o2RClRNt5y8mKyis=;
        b=NLD/PHcG0J85oLNJCsVVpWaA1hZCOjNaWVAgfLP6cP8KOYRoW0k93pDVRx3g/s5Wkw
         XCVAbVvGF2G2GYRmRo+VW3AIjVjxqRKd9n+kLb5B7znJEKUGaH6fEv0v7ilbSybk0xbT
         9TP3I7DTE2N59YfptdSS3FIGL1EgsqTuxEGrCsLHpE1NgQ8xtfvO48DyTZmHHWFPLgaB
         XukqyM/iFx55tlTPP7nQS36srMj2KwSscvuK44JI99fR8LK9sVUdX8jcYhew1sPC758f
         3M46UytwvlwJX/godtS/ObCvit39h3qhs5QiKGrmoqViZaHL7pDfCuYWp/vXViQLrHW7
         R3ow==
X-Gm-Message-State: ACrzQf1w9YaXRah+ECo/uWxodkCnSDoiOqLLZGKG3xj4cQtdHFH8rEhs
        TVufMCGjFTQ3h+mr3kDvo0TNXFbAXlLhbvy9
X-Google-Smtp-Source: AMsMyM5PcKfVt05LlztH2k02Day5btq/R+Un4/irorHVqrqOXq0Y7oxx1v8JWLgHZY9nrpW+IvzHzQ==
X-Received: by 2002:a92:6b0e:0:b0:2ff:df3e:995b with SMTP id g14-20020a926b0e000000b002ffdf3e995bmr846630ilc.193.1667000592110;
        Fri, 28 Oct 2022 16:43:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z14-20020a056638214e00b00363aec42c13sm21731jaj.65.2022.10.28.16.43.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 16:43:11 -0700 (PDT)
Date:   Fri, 28 Oct 2022 19:43:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: A note from the (interim) maintainer
Message-ID: <Y1xpDuyKccCRJCv7@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While Junio is gone for a few weeks, I'll be filling in as interim
maintainer.

I am planning on picking up topics from the list to keep things moving
steadily on "master" and "next". I'll publish the broken-out topics to
my fork at:

    git@github.com:ttaylorr/git.git

...which is analogous to how topics are broken out in Junio's own
fork.

I'll keep the main integration branches up-to-date at the usual spot:

    git@github.com:git/git.git

...though note that the other mirrors (including kernel.org) will not
be kept up-to-date. Junio can push out the state of the main
integration branches to those mirrors once he is back.

There is nothing new in either of those spots yet. I'll start
graduating existing topics to master, based on any comments from the
last "What's Cooking" message [1].

I'll do a new push-out in the next couple of days. If you have a topic
in flight with no response, I probably just haven't looked at it yet.
If you don't see it in the next "What's Cooking", though, I probably
missed it and you should nudge me or resend it.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/xmqqy1szef49.fsf@gitster.g/
