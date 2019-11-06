Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E46A1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 09:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfKFJU0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 04:20:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37563 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKFJUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 04:20:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id p24so11887129pfn.4
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 01:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ql+fCyjaqpZDjpJ0BRCoLhUdX5j9q/sJg2rbNptvQpE=;
        b=UgUvVqG2TJE69cQiWCzbKRA/lP5Id4wkl7uMJ6QzaB/KSksUMkL/ke0HaB3GrONq0t
         86+KRfaGnE4df9NaqEAijSP4aC22aQPGAR7W7fEkxBlNk1eCW0aeX0oGFXoCMMyhnPkS
         b1agx4p5VK0dpQirsQv8fSbUGXksV8mj2PoMFAEXY0pkK3fPV/Mhn6CaEARch9CQ0rWF
         4iPB172dHxlOYR5xXo61gnBE1Z6w07UBG97uDQpgQLJjgpQCN5t0SNXa1pl5pZxQgd5x
         UbLsLfODRGoF2D+kS7Apm28wCkyMrX3e0UD0gXNYq0WwnISkOSKHnHWPOY50oGnYCVDa
         oeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ql+fCyjaqpZDjpJ0BRCoLhUdX5j9q/sJg2rbNptvQpE=;
        b=q2S7Dw9auyuDxAv7szVdM2QQlYBWzZFuUa+j1GY1b+1ldXdPq5RL4RVZ25M3eLG4u7
         ePSXawyv3d+yLodGrm9Y1dIeO1rAwVcx+4zJLmSTinVvrCaeVkECJg7RmbrbPPebrEoF
         4/Rm+x/NstFlxn+VR0bKokOkVjXLDeEhFPukDa/jmc+88sxsa9zwM/JWPROPDweCsd2F
         YltdWH8ZIIMzXFEy9WPs8MPDoGkktZML5SwFxiDUEfau4C2ZyvkTGvRSLlVLYiHhuYJw
         C1RPC3Ne1qHxhmkFhFeb0WIPwT//oV4TTST60dFC2d7dkpDGEcC37k+eYUxCeYpcUGSU
         yKgg==
X-Gm-Message-State: APjAAAVKtLrMsEauRFG77MTfON2K9l0mNbflgjf7NadrpoEBfMvdlT7E
        eEhBmwBD0iW2vGCG1mnuJjvkvsKM
X-Google-Smtp-Source: APXvYqwMvCYWB0wUlpJ/RGNlW/ObTLepqehSVwq4jWE6DFveAQj959Y2PpnSmVdhZXTmeccoCD9Iyw==
X-Received: by 2002:a63:9543:: with SMTP id t3mr1724040pgn.350.1573032022510;
        Wed, 06 Nov 2019 01:20:22 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:4ba:cb41:a2ec:2198:454b])
        by smtp.gmail.com with ESMTPSA id c1sm4696984pjc.23.2019.11.06.01.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:20:21 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v3 0/8] Correct internal working and output encoding
Date:   Wed,  6 Nov 2019 16:19:58 +0700
Message-Id: <cover.1573031848.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.4.g6a51fdd29c
In-Reply-To: <20191031092618.29073-1-congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The series is shifting from fixing test that failed on musl based Linux to
correct the internal working encoding and output encoding of git-am
git-cherry-pick git-rebase and git-revert.

Doan Tran Cong Danh (8):
  t0028: eliminate non-standard usage of printf
  configure.ac: define ICONV_OMITS_BOM if necessary
  t3900: demonstrate git-rebase problem with multi encoding
  sequencer: reencode to utf-8 before arrange rebase's todo list
  sequencer: reencode revert/cherry-pick's todo list
  sequencer: reencode squashing commit's message
  sequencer: reencode old merge-commit message
  sequencer: reencode commit message for am/rebase --show-current-patch

 configure.ac                     | 49 ++++++++++++++++++++++++++++++++
 sequencer.c                      | 21 +++++++++-----
 t/t0028-working-tree-encoding.sh |  4 +--
 t/t3900-i18n-commit.sh           | 42 +++++++++++++++++++++++++++
 4 files changed, 107 insertions(+), 9 deletions(-)

Range-diff against v2:
1:  8b30028425 ! 1:  b3d6c4e720 t0028: eliminate non-standard usage of printf
    @@ Commit message
            one, two, or three-digit octal number, shall be written as a byte
            with the numeric value specified by the octal number.
     
    -    printf '\xfe\xff' in an extension of some shell.
    +    printf '\xfe\xff' is an extension of some shell.
         Dash, a popular yet simple shell, do not implement this extension.
     
         This wasn't caught by most people running the tests, even though
2:  7c2c6f0603 ! 2:  f07566c60c configure.ac: define ICONV_OMITS_BOM if necessary
    @@ Commit message
     
         However, typing the flag all the time is cumbersome and error-prone.
     
    -    Add a checking into configure script to detect this flag automatically.
    +    Add a check into configure script to detect this flag automatically.
     
         Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
     
-:  ---------- > 3:  662e5bd545 t3900: demonstrate git-rebase problem with multi encoding
3:  b7927b2723 ! 4:  6a51fdd29c sequencer: reencode to utf-8 before arrange rebase's todo list
    @@ Commit message
         first, then format it and convert the message to the actual output
         encoding on git commit --squash.
     
    -    Thus, t3900 is failing on Linux with musl libc.
    -
    -    This problem wasn't specific to musl libc. On Linux with glibc, this
    -    problem can be observed by:
    -
    -    for encoding in utf-8 iso-8859-1; do
    -            # commit using the encoding
    -            echo $encoding >file && git add file
    -            echo "éñcödèd with $encoding" | iconv -f utf-8 -t $encoding |
    -              git -c i18n.commitEncoding=$encoding commit -F -
    -            # and then fixup without it
    -            echo "$encoding fixed" >file && git add file
    -            git commit --fixup HEAD
    -    done
    -    git rebase -i --autosquash --root
    +    Thus, t3900::test_commit_autosquash_flags is failing on musl libc.
     
         Reencode to utf-8 before arranging rebase's todo list.
    +    By doing this, we also remove a breakage introduced in the previous
    +    commit.
     
         Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
     
    @@ sequencer.c: int todo_list_rearrange_squash(struct todo_list *todo_list)
      		find_commit_subject(commit_buffer, &subject);
      		format_subject(&buf, subject, " ");
      		subject = subjects[i] = strbuf_detach(&buf, &subject_len);
    +
    + ## t/t3900-i18n-commit.sh ##
    +@@ t/t3900-i18n-commit.sh: test_commit_autosquash_multi_encoding () {
    + 	old=$2
    + 	new=$3
    + 	msg=$4
    +-	test_expect_failure "commit --$flag into $old from $new" '
    ++	test_expect_success "commit --$flag into $old from $new" '
    + 		git checkout -b '$flag-$old-$new' C0 &&
    + 		git config i18n.commitencoding '$old' &&
    + 		echo '$old' >>F &&
-:  ---------- > 5:  d382e35e4e sequencer: reencode revert/cherry-pick's todo list
-:  ---------- > 6:  340902eb67 sequencer: reencode squashing commit's message
-:  ---------- > 7:  7f0df0f685 sequencer: reencode old merge-commit message
-:  ---------- > 8:  69ec40bb1d sequencer: reencode commit message for am/rebase --show-current-patch
-- 
2.24.0.4.g6a51fdd29c

