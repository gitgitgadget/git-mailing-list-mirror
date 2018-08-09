Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8DA11F405
	for <e@80x24.org>; Thu,  9 Aug 2018 11:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbeHIN3H (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 09:29:07 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:34267 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHIN3H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 09:29:07 -0400
Received: by mail-lj1-f178.google.com with SMTP id f8-v6so4168326ljk.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 04:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tEN2bgGTVVcxoDkTaQS57i0uARlvO23ptL3MaJwBB3g=;
        b=TTZjtmmVYZ3aUb2bpcsfifpOA/Blznqb2RyweSBrXJxTfeuaga0eYaJuvg1zsVeWtS
         DXu1OnU8iYtJRLY39UUlKHaOx+ZGBtnzy4iJjgX809jFJgSop4xwAkaXFi+2PPUaj2y6
         b6J5rcjwTOp12+xm1f7zqggOnWydmIG87ySUCMsKIH/C05A1WzIK+/xGLOW8SNCz9Ok5
         acljxgpA0/G/tHfCEuCoQMSW87PwmcqjBg0DB0gj9XmEDI/VQNQbQby6m7C7/fuHvthU
         jqTq7Po1o7EZDHwS7u8EK6PPZr++MlreQlOn3sk3kRshopf26c+up4u4SYKaIyAliMy/
         U/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tEN2bgGTVVcxoDkTaQS57i0uARlvO23ptL3MaJwBB3g=;
        b=oa3jR7YxYxeNxJ1T3pw0eTPXu+Q2D74MpHSxJO9PsTDJqlW8R/clGThBhhroInCyYk
         oxPPEivgF64YvlMXazLafaTDLkSSfpIuyHCky7jI/UxKpH+NObNvBCWTzOplY4zGx2w9
         rxyT74HM6ftVSHGArmx6t4CHGF+JzdYsCHKycBK0GVN3QWPg0ekAueud2ZG5yBP8/Qak
         W1qyLQYbbvPMxhaxPFHZrYxd7+oc8itAjwf+TESv20nJUQ9mi26UYB6YZ38BASrXTWI9
         tzgIa3Xv4Jetx81c9Ytwro9rRxIb13bV1Giey9igCKOUAoZGDaCkQ6Gs46iG8actGdRK
         ixIg==
X-Gm-Message-State: AOUpUlGHoufUookkw/pJYtiUiOoLNNcWGhjf1YIhwWB8MRO7WHiqkrz5
        LRkojpNZUlRtNsPenxwjKCdebrzAt3CT6m+c8nu8lXKq
X-Google-Smtp-Source: AA+uWPzTgo+DMjtFwQAJhze0rebsD/6pFyOVaTG4OTJItctCb8z+d0VIT9F/twRx5hQ/8bpK16kDCBnoTysTHSuxFA0=
X-Received: by 2002:a2e:712:: with SMTP id 18-v6mr1406855ljh.101.1533812684451;
 Thu, 09 Aug 2018 04:04:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:3bd2:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 04:04:43 -0700 (PDT)
From:   Bartosz Konikiewicz <izdwuut@gmail.com>
Date:   Thu, 9 Aug 2018 13:04:43 +0200
Message-ID: <CAAdU=LuNn7qdXf81C3-3=0uh7NOSihm3U3dfDcXPiKxfaZMaFQ@mail.gmail.com>
Subject: What's the use case for committing both the freshly created file and
 it's exclusion in .gitignore?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there!

I hope that the subject of my message (i.e. the question) is
exhaustive enough, so I'll just stick to reproducing my issue.

Steps to reproduce:

1. Create a new file.
2. Stage the file.
3. Add the file to .gitignore.
4. Stage the .gitignore.
5. Commit changes.

I imagined that the file would now be removed from the stage (because
it's ignored now and not yet committed) but it isn't. Where this
behavior would be desirable? I know that a 'git add' command can be
invoked with an '-f' flag, which would yield the same result, but I
can't come up with an explanation where can it be applied.
