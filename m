Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEFFD20248
	for <e@80x24.org>; Sun, 17 Mar 2019 11:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfCQLJL (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 07:09:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41261 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfCQLJL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 07:09:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so9313753pfn.8
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bnNTFJMua0pMWlYz4Oq7Wg+MNIqi/NpCg8HT4/MQt1Q=;
        b=sXvNGJskp2qN63s162EHnDr378mDkOkCA1hn9wMUNoUfTsxLAsqfxriFGlzO9PzeW9
         lll4LQKwhpB7qglzJ77PiDQn2oZ0Y1P2c5y6QrWCK9pH89oEbp41zjX8jV6HOB399OI/
         cJFabHtQgRcDPi8eS48/qX2qoJ7jDDlrf6Sqds7oq89OoKjaWyZ+kpIXeSaDCL3MQsvX
         3vF3exNVrletfxfMV9wi5TlXkACtB+HH77rCPXoxb92HI8jTUbGSc449b+DZzfjXo6JC
         ji6RKFLyqkHKjq1SIh5t4tZzHaQcdpx9n3uAD/j3Kagu9JRrKP5Abcjbc96848099Ou0
         66lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bnNTFJMua0pMWlYz4Oq7Wg+MNIqi/NpCg8HT4/MQt1Q=;
        b=gwnOzoh7NkbXzjnFXTw/rOY5yXWwop7wlHEhZHwgPqN6xe69T9gY7c4Q85bk/pWRDh
         H1omYuXGVj/RLHhh6OtfxiJb/A8R5WQt7RPHv6u69NcqQN0ks4cDxmkXdcLGLNJ8FYtT
         /f3mcN69pHjzZuN4Rmo0rSqze7u8K7aWa0adKX1Ubg5lYDVyl1CaM9P3zzT54qWQrKkm
         2FtDFl0pLqJetrwN12t449+W1Nx3vjZnXkX1B8d8EHDMAY/il3qh24z3x/DZgKLnm6w0
         E0AfM0pANaTajVgebk4pskWOP83j6lzV54IyqhpNZ3eaiFkMYc2EkIxeubVqPwPid/Jf
         EbBQ==
X-Gm-Message-State: APjAAAUZx77CpDGeF6SoAlj4bHyp2keOd/vCJgwiR97IVmYTYOtAZN1I
        leGFm4s7d0YqsUrqjhsUr+0ASiKeLRY=
X-Google-Smtp-Source: APXvYqxkjG2C4jXHsdDVdnNC32SNUzOPQ02VEp5oWY0w8RRWjmQlqyg7X+t+la0D2vV6LptPovqsug==
X-Received: by 2002:a17:902:123:: with SMTP id 32mr919418plb.187.1552820950102;
        Sun, 17 Mar 2019 04:09:10 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id q207sm12836419pgq.88.2019.03.17.04.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 04:09:09 -0700 (PDT)
Date:   Sun, 17 Mar 2019 04:09:07 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Denton Liu <liu.denton@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        vincent.guittot@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
Message-ID: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation used to consider

	git diff <commit> <commit>

and

	git diff <commit>..<commit>

to be equal counterparts. However, rev-list-ish commands also use the
<commit>..<commit> notation, but in a logically conflicting manner which
was confusing for some users (including me!).

Deprecating the notation entirely is not really an option because it
would be an arduous process without much end-value. In addition, there
are some valid use-cases that we don't want to break.

Document the preference of the first form so that future confusion can
be minimised.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Thanks all on your feedback on the discussion thread[1]! I opted for
just the documentation-only route so we don't break any valid use-cases.

[1]: https://public-inbox.org/git/20190311093751.GA31092@archbookpro.localdomain/

 Documentation/git-diff.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 72179d993c..10c7a2220c 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -63,7 +63,11 @@ two blob objects, or changes between two files on disk.
 
 'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
 
-	This is synonymous to the previous form.  If <commit> on
+	This is synonymous to the previous form.  However,
+	users should prefer the previous form over this form
+	as this form may be more confusing due to the same
+	notation having a logically conflicting meaning in
+	linkgit:git-rev-list[1]-ish commands.  If <commit> on
 	one side is omitted, it will have the same effect as
 	using HEAD instead.
 
-- 
2.21.0.512.g57bf1b23e1

