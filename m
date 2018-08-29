Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F011F404
	for <e@80x24.org>; Wed, 29 Aug 2018 14:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeH2S23 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 14:28:29 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:43613 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH2S23 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 14:28:29 -0400
Received: by mail-pl1-f171.google.com with SMTP id x6-v6so2367789plv.10
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8G+7FEDsped4oQdOT6qLPSd5D6FDwJJthMck3XwCHkc=;
        b=GnKR2sJF0PzGk7PbXQX3GgAp9DuZFkEncCCDgyY+HfIB/Ok1bBnRqvILR6pFD5IB/E
         MTv034Rwkiwxxxd/Q3iAQ085mdiTQ2oKWakh4SFlLTAoaiqZAVllCa7MF6RD+PBCt/EM
         HAI3KlIz6Bdiy9njp8v46ez4JCFNN8PsUMtKLG2q0Yp7i/4n5enp3V6q0zepXIZOKOpb
         wBPwYbvv6F0ORDRRxyTqFVvycrAtvw5H731jScZb8Y/1dbXMU3C0DT2VG9moo8/kr272
         hzVV4ZNU21aKeDeaZ6cOvZKSYEn4PBLkWe8/pX+63/va80PIoFOCc7SRTjyQ8dOcDd8J
         Pqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8G+7FEDsped4oQdOT6qLPSd5D6FDwJJthMck3XwCHkc=;
        b=a0KzzZmTGN69menUmCgduvB252VyDRAN0QjhMR8BogUKLQUeUxSjzQaxw0hgd1xaVS
         m2mIKPei6d/05MaXCCec98E8dnpCSUTZV6OEG5/hr9+9EW68ch/uyAK4OSZgqUeCxssR
         k6zB4JBLH3VTisF8egP5h1MA0v6d15Wl6rWePhkwJq7bJlu4lULn+9nDpFrf2gXccHd6
         jbRdkPPukXMrsiM+LFJNDFaMvtQnuYiauh3CuOXVnjQ1+zJn22kFbphMU/lgcsvgtj8k
         fD5klmuBs9oKGcMusilSA7gexo+C9snLWt4VGdnltBYETstgOOOZ9yuhcaelHDRY2YGH
         obVw==
X-Gm-Message-State: APzg51CYncq5KIqivp0gTv1E//277JW6YaCpCWKmLEwmyLoZUpXl5J+J
        lbHM9SCSZZv1uZG84o33bKlH2bdT
X-Google-Smtp-Source: ANB0VdbN968X4HZir23/NexvlW3ow0mw5j35LBvjx/UkB7dTvZaJpu8Di+afLQXAn0nqplPmEfXcaQ==
X-Received: by 2002:a17:902:48c8:: with SMTP id u8-v6mr6379264plh.152.1535553076186;
        Wed, 29 Aug 2018 07:31:16 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id 143-v6sm6141540pfy.156.2018.08.29.07.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 07:31:15 -0700 (PDT)
Date:   Wed, 29 Aug 2018 07:31:15 -0700 (PDT)
X-Google-Original-Date: Wed, 29 Aug 2018 14:31:12 GMT
Message-Id: <pull.23.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.23.git.gitgitgadget@gmail.com>
References: <pull.23.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Teach the builtin rebase about the builtin interactive rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The builtin rebase and the builtin interactive rebase have been developed
independently, on purpose: Google Summer of Code rules specifically state
that students have to work on independent projects, they cannot collaborate
on the same project.

The reason is probably the very fine tradition in academia to prohibit
teamwork, which makes grading easier (at the expense of not exactly
preparing the students for the real world, unless they want to stay in
academia).

One fallout is that the rebase-in-c and rebase-i-in-c patches cause no merge
conflicts but a royal number of tests in the test suite to fail.

It is easy to explain why: rebase-in-c was developed under the assumption
that all rebase backends are implemented in Unix shell script and can be
sourced via . git-rebase--<backend>, which is no longer true with 
rebase-i-in-c, where git-rebase--interactive is a hard-linked builtin.

This patch fixes that.

Note: while this patch targets pk/rebase-in-c-6-final, it will not work
correctly without ag/rebase-i-in-c. So my suggestion is to rewrite the 
pk/rebas-in-c-6-final branch by first merging ag/rebase-i-in-c, then
applying this here patch, and only then cherry-pick "rebase: default to
using the builtin rebase".

Changes since v1:

 * replaced the too-terse commit message by a copy-edited version of this
   cover letter (leaving out only the rant about disallowing teamwork).

Johannes Schindelin (1):
  builtin rebase: prepare for builtin rebase -i

 builtin/rebase.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)


base-commit: ae497a044508ebaac1794dcdd7ad04f8685686b2
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-23%2Fdscho%2Frebase-in-c-6-final-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-23/dscho/rebase-in-c-6-final-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/23

Range-diff vs v1:

 1:  29d49819fa ! 1:  5403014be7 builtin rebase: prepare for builtin rebase -i
     @@ -2,8 +2,21 @@
      
          builtin rebase: prepare for builtin rebase -i
      
     -    It is no longer a shell script, so we need to call it in a different way
     -    than the other backends.
     +    The builtin rebase and the builtin interactive rebase have been
     +    developed independently, on purpose: Google Summer of Code rules
     +    specifically state that students have to work on independent projects,
     +    they cannot collaborate on the same project.
     +
     +    One fallout is that the rebase-in-c and rebase-i-in-c patches cause no
     +    merge conflicts but a royal number of tests in the test suite to fail.
     +
     +    It is easy to explain why: rebase-in-c was developed under the
     +    assumption that all rebase backends are implemented in Unix shell script
     +    and can be sourced via `. git-rebase--<backend>`, which is no longer
     +    true with rebase-i-in-c, where git-rebase--interactive is a hard-linked
     +    builtin.
     +
     +    This patch fixes that.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      

-- 
gitgitgadget
