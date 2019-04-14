Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3DD20248
	for <e@80x24.org>; Sun, 14 Apr 2019 21:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfDNVJn (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 17:09:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36646 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfDNVJn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 17:09:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so19207771wrd.3
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 14:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8u5C4U8XEr12LGRS4G68qnbvO8+UjcyjxuJeQvM5c+c=;
        b=bxwRGXVRWCJRN3INFGZFRqiH+bO4KhFLA5p7acB0ROj4vwkV9jvJL5S1krEo4SP27R
         sBqoEq5aH7kqwriYrgfUDTk0r2ZxMR8ik+O03XLoKMtXt4n1924cC6ZvJT0MXSH+r/rg
         NXZ7vPKKTPJJM0wa5kzWNhZaXpCOtioja3zPUUid5U0r6uMxTiIPho7Q2RMQlBKmHvKj
         2LUwD7hoL6thi09HLnPXmSFQ9+GQSWS9ClT7dFk61jfOWWn4Z54VkxfofVfmRQeueDt0
         X7txB8aQ4wMHE2mwvqViIu+gC+0I4JXGZ0D1rjIEtw/iQRU1d2sAV7saDBYtWiwUyoxI
         7N/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8u5C4U8XEr12LGRS4G68qnbvO8+UjcyjxuJeQvM5c+c=;
        b=ncUQzmRo+Y7pV1zeBjSax2XfkEIQGn6yylXwrCPZVFqMZhguTqBk+3EiyOBZMlQoHJ
         8f4pcIwGkRTEG6eCGyJ+2SHrOc00xSdJnQ4pZXGWkp6Wvf94NXenXDyMMs6zaYeVWHNl
         dQ6oKKboHt2jgClDdP/lLkfuiomY2aBqJPqqGs4Zg1P2bS9dGhJ/eAhr6y0Uls2XEs4H
         oS9ZUynWw9QayZ3Lq/QyEaOs9re8Aj5Bo7HNUfRB25RxRa7E9lfdq+drVf+FTKL8FJxO
         b0EBMPA00lCCwN/kE3DBZgBXiBqoPpoffCvwcxo70yKZXE1yG5DVbx7O8F7t5QxNbiop
         z+WQ==
X-Gm-Message-State: APjAAAUQtb2rf8CyWhoDJsqSBXvkzP+xYnGX66t9yRUU9UVhtGRCgdQH
        N3IsJGUMeYmvUpCfCbtlaRBO1nq1
X-Google-Smtp-Source: APXvYqxCUkAvHnacDd6pwgYJuvIidjzvZFAfqw+t4etteKzgV3/hbbbqx2riFsxgPv4oHzqewEiaUg==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr43232727wrj.8.1555276180418;
        Sun, 14 Apr 2019 14:09:40 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id o12sm48002701wrx.92.2019.04.14.14.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 14:09:38 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC PATCH 0/4] output improvements for git range-diff
Date:   Sun, 14 Apr 2019 22:09:29 +0100
Message-Id: <20190414210933.20875-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e1
In-Reply-To: <20190411220532.GG32487@hank.intra.tgummerer.com>
References: <20190411220532.GG32487@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series aims at improving the output of 'git range-diff',
especially in cases like the one mentioned in [*1*], where a diff
header, that was before the outer diff's hunk header was
misinterpreted as being the filename of the diff that followed it.

It does so by substituting the diff header of the inner diff with a
range-diff specific "section header", which is then parsed by a
userdiff pattern, so it's included in the outer diff's hunk header.

Additionally, instead of stripping out the whole hunk header of the
inner diff, and replacing it by just an "@@", only strip the line
numbers from that hunk header, but keep the funcname/xfuncname.

This information is not added to the outer diff's hunk header, because
it feels like that would end up in too much information, and I feel
like the filename is the more useful bit of information if we have to
pick one of them.

As an example, here's what the relevant part of the range-diff from
the original thread would look like now:

    @@ -99,10 +90,10 @@ modified file Documentation/git-revert.txt
     -should see linkgit:git-checkout[1], specifically the `git checkout
     -<commit> -- <filename>` syntax.  Take care with these alternatives as
     +should see linkgit:git-restore[1], specifically the `--source`
    -+option  Take care with these alternatives as
    ++option. Take care with these alternatives as
      both will discard uncommitted changes in your working directory.
      
    - OPTIONS
    + See "Reset, restore and revert" in linkgit:git[1] for the differences
     
     
     
    @@ -129,10 +120,11 @@ modified file Documentation/giteveryday.txt
        * linkgit:git-commit[1] to advance the current branch.
      
     -  * linkgit:git-reset[1] and linkgit:git-checkout[1] (with
    -+  * linkgit:git-reset[1] and linkgit:git-restore[1] (with
    -     pathname parameters) to undo changes.
    +-    pathname parameters) to undo changes.
    ++  * linkgit:git-restore[1] to undo changes.
      
        * linkgit:git-merge[1] to merge between local branches.
    + 
      @@ Create a topic branch and develop.::
      ------------
      $ git switch -c alsa-audio <1>

Note that this patch series doesn't modify or add any tests, and was
just manually tested locally, thus it is still marked as RFC.  I'd
love to get some feedback on the output format first, before touching
any tests, as I expect there might be some discussion on the final
format.

*1*: <20190411111729.GB5620@ash>

This series can also be fetched from
https://github.com/tgummerer/git tg/range-diff-output

Thomas Gummerer (4):
  range-diff: fix function parameter indentation
  range-diff: don't remove funcname from inner diff
  range-diff: add section header instead of diff header
  range-diff: add section headers to the outer hunk header

 range-diff.c | 55 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 10 deletions(-)

-- 
2.21.0.593.g511ec345e1

