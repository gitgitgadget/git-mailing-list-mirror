Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE21B20248
	for <e@80x24.org>; Mon, 25 Mar 2019 21:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfCYVlh (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 17:41:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38297 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCYVlh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 17:41:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id q14so8928431edr.5
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 14:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HudhKBgIm+pDyUAeRm26JkfGlSvw+VxgVHd170fsWzI=;
        b=mjZDuAcwfiMAc4AyfPy48tOedCtcmQLOrOjJ0VsuAQJl8kflgOJAVZZ6iUcQWfIWcw
         TmkQU+CozRvmzbJqAZ7u64r4TDpKxFzomOLncXFUVx/AwZIpBudQIUvAZm/5WwipWkSu
         LbO9NE6djsPU8rq4eFTJQbp4dvShOEXyVYPzMy5UH714A+ftd84k9fpHWgsibutRzzs8
         Acr7+ZMgzwcCcdeYJMCGKS5wctBxHJz2iU11DwBETO//61tvjo+1W2e7uotRzSDjKsjQ
         DoL2E/FxlfVbds1eoqnNJ6I2dySu3FM373SwxfZsxxlQ2EsK888CcYI2asGm6ttgCh0t
         SPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HudhKBgIm+pDyUAeRm26JkfGlSvw+VxgVHd170fsWzI=;
        b=ldlg8GrC2Y53iW1frC9tNnBvEWvGaaB8K9ENSWLFniHcs7pjOD3zq12fy5MRlJIsBm
         yTR7r6G49ddKAHpDRiVqyd6yr3aQXCEVpQnUgJdvPTbMkdrTc2B/evO6yGK2V4Edj5Or
         TSqt8u3IsTsJ+kj01vKlUmuRQlMX2iCckEmPxqfDiuM1QbYf2+okYvEAZ5lkIDTnsSBP
         CI/O0uVXdmewACCsStGrZziOdohdEsEzNJFptLsnFgHyxdMW4QJEmJ+P4lKiqkrpenpe
         Kf/4vkZG740dfn8Lb9iyR71K+y+U26ZAAp/FJl+5kCj+PfqiuAqgJVhKOOWYG0j28Cml
         q2MA==
X-Gm-Message-State: APjAAAXVSpez4U954RHQ6cfuL1ItrxFINGPuV+mGjclfC5j0ZEADfWtr
        z8XRP5H3KV7+MjnDml5xehHRdnB4
X-Google-Smtp-Source: APXvYqyBrKsjguZivkNbsC1sxoZiK/E9kKXcngX41o+FazgnMva4aTrPNMD2z3MPeI6+lbFhwLCGmA==
X-Received: by 2002:a17:906:fd5:: with SMTP id c21mr15374899ejk.86.1553550095990;
        Mon, 25 Mar 2019 14:41:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6sm3711777eja.50.2019.03.25.14.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:41:35 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:41:35 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 21:41:29 GMT
Message-Id: <pull.162.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.162.git.gitgitgadget@gmail.com>
References: <pull.162.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/5] Fix make check-docs on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I stumbled across this when investigating one of Duy's bugs in the CI
builds.

Changes since v1:

 * We no longer add an extra space in front of the $(patsubst ...) in the
   second loop, but fix the underlying bug that prevented check-docs' part
   from working where it discovered documented commands that are actually
   not installed.
 * As a fall-out, the gitremote-helpers page, which does not refer to a
   command, but to a concept, was moved from section 1 to section 7.
 * As a second fall-out, the documentation for git remote-testgit, which is 
   a command, but not installed, was removed.
 * As a "while at it" patch, the part of the check-docs target that tried to
   identify commands that are listed in the help, but not implemented, was
   fixed to no longer mistake guides like gitattributes and gitcli for
   commands.

Johannes Schindelin (5):
  docs: move gitremote-helpers into section 7
  docs: do not document the `git remote-testgit` command
  check-docs: really look at the documented commands again
  check-docs: do not expect guide pages to correspond to commands
  check-docs: fix for setups where executables have an extension

 Documentation/Makefile                |  2 +-
 Documentation/git-remote-ext.txt      |  2 +-
 Documentation/git-remote-fd.txt       |  2 +-
 Documentation/git-remote-helpers.txto |  2 +-
 Documentation/git-remote-testgit.txt  | 30 ---------------------------
 Documentation/gitremote-helpers.txt   |  4 +---
 Documentation/urls.txt                |  2 +-
 Makefile                              |  7 ++++---
 8 files changed, 10 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/git-remote-testgit.txt


base-commit: e902e9bcae2010bc42648c80ab6adc6c5a16a4a5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-162%2Fdscho%2Fcheck-docs-on-windows-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-162/dscho/check-docs-on-windows-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/162

Range-diff vs v1:

 -:  ---------- > 1:  0ad38649c0 docs: move gitremote-helpers into section 7
 -:  ---------- > 2:  810d2c5a94 docs: do not document the `git remote-testgit` command
 -:  ---------- > 3:  0dad6abd2f check-docs: really look at the documented commands again
 -:  ---------- > 4:  1097be7678 check-docs: do not expect guide pages to correspond to commands
 1:  f06126c3a1 ! 5:  b26aa40c61 check-docs: fix for setups where executables have an extension
     @@ -24,7 +24,7 @@
       	) | while read how cmd; \
       	do \
      -		case " $(ALL_COMMANDS) " in \
     -+		case "  $(patsubst %$X,%,$(ALL_COMMANDS)) " in \
     ++		case " $(patsubst %$X,%,$(ALL_COMMANDS)) " in \
       		*" $$cmd "*)	;; \
       		*) echo "removed but $$how: $$cmd" ;; \
       		esac; \

-- 
gitgitgadget
