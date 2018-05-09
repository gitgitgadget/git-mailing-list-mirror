Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D1A1F424
	for <e@80x24.org>; Wed,  9 May 2018 16:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935444AbeEIQBy (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 12:01:54 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:40195 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935442AbeEIQBx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 12:01:53 -0400
Received: by mail-wm0-f54.google.com with SMTP id j5-v6so28871177wme.5
        for <git@vger.kernel.org>; Wed, 09 May 2018 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/fzYHJyxQy/KFO5igIH6XpQ8BhE2EpOsY792s5UqXhQ=;
        b=rJNdsGXwFS6tKf8PpE5ig7SHJhKounCRVAi/EyIlAN8o0T5RV+H+ZP3VPWWtFpn5HP
         t9bWuUyfKmwvJ/wEtn+2RexG1lmnFwzyvgsfKb+/mJ57/HeeluYBXTGL5mtcC7vajZNh
         YDXgiJ9u+/NIIyaCVQaZbaAoqbnG93PKh2X0NAldyo791TEk4+IKeZ1RiQnT+PpYM6zg
         UEQHkXoFgRFnN3CKpr2Kc3NCzf4koHnr8C+DM6fsvAxq1l/NATHk2k0NqV40julhdqD0
         Gs22lO5fR+c6FCh5r3uGaFlPVoYfHbvUwB24JZGfLYb7zlO76UrK7i7LVltS6dVcRMBC
         Z1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/fzYHJyxQy/KFO5igIH6XpQ8BhE2EpOsY792s5UqXhQ=;
        b=fqvTi+asC1I5xWGXALwOQXU/ZZ16jijQWAGW3oxaEOhYZOiPOt1c1l+fIOBvITaYe9
         9zLBPsilDoNzFvbhPEOj99Kd7P3w+K/KlytAJYcA8ZTKINssB1pWmB1SkFd+UJUQ62HN
         Box3GQEK370XI9Qi2Rj1uUNGQD9P/A6ZZS4dnBNjHk4uUMoWxDF/vmWwTeLPrjnZZX5X
         3Ijo7oRDGqA5ns+QF3BEm2dqHEHKqRuBXsFyezadhx4Vr08Vx5TdXnR+Jx1UcN6SL84x
         9c4bwdAAhxIr1N7LTH4w3Aop5ByjhbeLA94+1uz5Aq0XPQPwXNsV6UdWoK0xeJCSubuU
         3xjw==
X-Gm-Message-State: ALKqPweirP/ZxRQlR/piGkaGtaufZp0bhSB1K5S6Gonu936LRXsuaQ+1
        uqPBaONvbFGKRrsOZ3b7bjoxxS2kr8BDBJwiLoKAyVgp
X-Google-Smtp-Source: AB8JxZo1fASPpXv91wWkzqEbCvfzqD30oQYDKzX78LtwEDIh2ys3iCEvOCvNjbcshZPTKY3CLl1kzq+y2vMMjvjMD54=
X-Received: by 2002:a1c:3b87:: with SMTP id i129-v6mr6604540wma.51.1525881712511;
 Wed, 09 May 2018 09:01:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.152.138 with HTTP; Wed, 9 May 2018 09:01:32 -0700 (PDT)
From:   Ilya Kantor <iliakan@gmail.com>
Date:   Wed, 9 May 2018 19:01:32 +0300
Message-ID: <CAFU8umjyrJc1m65hu6QMQUiNmsJtbV65tovcWjvmzFpsCr668A@mail.gmail.com>
Subject: Is rebase --force-rebase any different from rebase --no-ff?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Right now in "git help rebase" for --no-ff:
"Without --interactive, this is a synonym for --force-rebase."

But *with* --interactive, is there any difference?

After doing some tests and looking in the source I couldn't find any
difference between those two at all.

Probably, there was a difference some time ago, but not now?

Then one of them can be safely deprecated.

---
Best Regards,
Ilya Kantor
