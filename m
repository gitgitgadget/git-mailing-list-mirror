Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC7D01F404
	for <e@80x24.org>; Tue, 17 Apr 2018 21:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeDQV3z (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 17:29:55 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:43198 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753318AbeDQV3w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 17:29:52 -0400
Received: by mail-wr0-f181.google.com with SMTP id u4so7930151wrg.10
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 14:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I+ylLF3mnk5dv9PUZAXlp9/u3K9wJQtyhRKNGr25Rsw=;
        b=hWgc8nkmRR7eupj6QeQIes1lpd0iarjfpbCcdJ8QH7DijCO2Lq7gr3U/ybZD4uVcGh
         QM5kuvAx4PHMniCvFW1iuUmlIlt6GydP8TZHYf9dirWUBU54WjwSjefe0xWN29vOfR63
         B2lgJqEZyQFk3g/SR4O01sr9B+uj9dfZR7UykNKTSzuvkeb8T4hzSP/BXBn49R5Ss5xx
         1VsIA4yEX6pJ0X5Vm7mthuh/X35IJSVym3hpq6nSqJ6tWeqMtyPZdA8aOOsd62iK9ZNp
         Z4JkVfFpHEQgDSUkWyZy2NhIhXQnIqutT2uJOGCpwI8kRXUpUGJNaa/TdHxqud4ta6BR
         v7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I+ylLF3mnk5dv9PUZAXlp9/u3K9wJQtyhRKNGr25Rsw=;
        b=HLuSqwuABM275ocMCIicsHKaYZlQ7KKQf/QyRqk3B4pTzm5GeTpK+7yORoyMeho1sF
         6GrvJFpH8Q7qosoLSb+wFgO/jIqxZts0aB7rmKdp6PQGlKcNmcfPWwZV/sHPykN/L3NI
         2bykeCbkTIknulIwi2U6c8wnH/SOp3efjl6iI8MK0g9i3lyQBzB+yxcOrDYghByFHJvX
         e7vQm9B8hM+OlfmjoLNu49k1kqd5Xf3w7wkp1x0b3vOg7tsUweHBhATfrunX5C1XEbcn
         Hor8I6OhWrf5P3y8rvyDYhfw0X1tcwCuIXaG0bPWN5lRCoQZh9WJSrtOdqjolxfENwVJ
         ouCQ==
X-Gm-Message-State: ALQs6tDYmVUo/A6gRL68KjEHhNuZB3C9MxTBpMSWXCHmp567arbjuu9n
        t3Hqvp7rXHJjRs+LbSdoHDuTQYAg
X-Google-Smtp-Source: AIpwx49f3b+V7AeZh48zUZ9y3/9enS21TGPccJxpeGoXOmVbRjDVYnyQQijDdejtViQTftE9VhO8XQ==
X-Received: by 10.28.173.4 with SMTP id w4mr2180513wme.54.1524000590915;
        Tue, 17 Apr 2018 14:29:50 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id y42sm441731wry.21.2018.04.17.14.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 14:29:49 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/3] completion: improvements for git stash
Date:   Tue, 17 Apr 2018 22:29:42 +0100
Message-Id: <20180417212945.24002-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this series we stop completing the 'git stash save' subcommand in
git-completion.bash.  The command has been deprecated for a while, so
I think we're doing the users a disservice by still completing it,
making them think it's still supported while we already deprecated it.

The first commit is a preparatory step for doing that, while the third
commit is an improvement that I thought would be good to do "while
there".  The most interesting part of the series should be the second
commit, where we actually remove the completion of 'git stash save'.

Thomas Gummerer (3):
  completion: rename save_opts to default_opts for stash
  completion: stop completing 'save' as stash subcommand
  completion: make stash -p and alias for stash push -p

 contrib/completion/git-completion.bash | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.17.0.252.gfe0a9eaf31

