Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F8E1F660
	for <e@80x24.org>; Tue,  3 Jul 2018 13:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeGCNRS (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 09:17:18 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:43883 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeGCNRR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 09:17:17 -0400
Received: by mail-pf0-f173.google.com with SMTP id y8-v6so1014859pfm.10
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=whileimautomaton-net.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=eH7Z5KKZGT2APIsaWXAoY+Sr2PyIDBCiuq+sKTAVXOI=;
        b=Y7H63Fl1xHXJUvkzp0unj7xwXtHebuyRBuCC3GzIZQFz63yACZ+676n3pQ2T0n1C6d
         lI7i9gGbYkOx+3+TNtwOMA5EdQLpZ34NicTS8Co56VE3f5HQ+Rz0sXJJURhKeuFK4a8U
         kA90M53480glGWZLyBSjGVxbY6G8KQNBzBSt4Wro2M39aZaqJK+ZxZTT9jUhc8EWDZOB
         CiO0alvKGOo7FqedRpUmitFlojRm8XcqgT6IGN+NPOjUp2ve3eSsA1zEHctT/7hTflP/
         om+ufaXo2GnO08ngb+Pbv29hZ7ZdvR1I6r4kPIAAsSwxuEzlP5hchLR3u6AWNGNBtOJH
         zIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=eH7Z5KKZGT2APIsaWXAoY+Sr2PyIDBCiuq+sKTAVXOI=;
        b=BGqa7Am1hycm1zfumj7y/9JgKFTfKdBaK1vwB2CP7+l4dMURHC1L/QhP+7rSV+bL0C
         lzSSw59CYWzlcoppiGkjKMNDDE5WBdH3vIcxaRgG2RvIjB/vLOeg8cwhxKznoMo/U11l
         5tsYidFAlumSXlwdiBr8IiTDZ5YpAtQJ5eOhw7Sqbm74L/Y+mX6HSeU6A4q0rpcr7tLW
         dKW3WE5uoZ0aUDBguqUkvRYNLzk3pTl7qDd380MbTo01lG+g+Hm3K4Q/i/N15e0u2umY
         H50mUoNSPYaDxw+93bfoQoFKOMP1s+4CYGKuLdzzwhGy16hWQXduivr1sXPEL8YYM1TF
         z8Nw==
X-Gm-Message-State: APt69E2Ybt9HVhKoyVYZK9sIU+1B6v4wa6JktTDgN7HyVnyH6jBioL/D
        cmsYqFOBOYHbd9ik5TtkAF7d9RM1thbBKQ==
X-Google-Smtp-Source: ADUXVKLmnE/Yguz4KW+LQHVRgV6ySgZYsod5lQ+aA9fTpqWr3FGF4C0m3pqXo0P09uc1sPa5YOScYA==
X-Received: by 2002:a63:6092:: with SMTP id u140-v6mr25373150pgb.433.1530623837006;
        Tue, 03 Jul 2018 06:17:17 -0700 (PDT)
Received: from localhost.localdomain ([150.249.215.106])
        by smtp.gmail.com with ESMTPSA id 14-v6sm3664730pft.10.2018.07.03.06.17.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 03 Jul 2018 06:17:16 -0700 (PDT)
From:   Kana Natsuno <dev@whileimautomaton.net>
To:     git@vger.kernel.org
Cc:     Kana Natsuno <dev@whileimautomaton.net>
Subject: [PATCH 0/2] userdiff: support new keywords in PHP hunk header
Date:   Tue,  3 Jul 2018 22:15:38 +0900
Message-Id: <20180703131540.60789-1-dev@whileimautomaton.net>
X-Mailer: git-send-email 2.10.1 (Apple Git-78)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recent version of PHP supports interface, trait, abstract class and
final class.  This patch fixes the PHP hunk header regexp to support
all of these keywords.

Kana Natsuno (2):
  t4018: add missing test cases for PHP
  userdiff: support new keywords in PHP hunk header

 t/t4018/php-abstract-class | 4 ++++
 t/t4018/php-class          | 4 ++++
 t/t4018/php-final-class    | 4 ++++
 t/t4018/php-function       | 4 ++++
 t/t4018/php-interface      | 4 ++++
 t/t4018/php-method         | 7 +++++++
 t/t4018/php-trait          | 7 +++++++
 userdiff.c                 | 2 +-
 8 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/php-abstract-class
 create mode 100644 t/t4018/php-class
 create mode 100644 t/t4018/php-final-class
 create mode 100644 t/t4018/php-function
 create mode 100644 t/t4018/php-interface
 create mode 100644 t/t4018/php-method
 create mode 100644 t/t4018/php-trait

-- 
2.10.1 (Apple Git-78)

