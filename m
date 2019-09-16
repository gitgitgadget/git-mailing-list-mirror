Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5881F463
	for <e@80x24.org>; Mon, 16 Sep 2019 19:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390893AbfIPTXK (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 15:23:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36759 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387404AbfIPTXK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 15:23:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so340552plr.3
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 12:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zLUDXBexpFGbOwwR9tXgKuQvUKTicZV5Dz5xqJKW674=;
        b=GKy0pG6xHiDlR/8SYX0jH/t+dIpSNIV8KY56iuI8BRwG6huKGa6Jq/aUW2/+yUnnBS
         3gdkR8gxnOiEXr3pVjo8s6pi/XqsryWd3DMS3RPrTGPbqtP4HO9vpLAPJ3DEwTLokdee
         RuZ3JBQYXUKKcrdHLkpFhn0/6PLcCJoyhLCdMAo/mfJtTG9zlAAIOrtTjJ25/KW+kEpm
         u5NKssZ/F24WpO+Gzaej0o5SZL/Pf/X89XXw4Jp59h/RDG0GJXIO2fhcxg6JTkrDtEjO
         jy7R4VjEQBsv9HvrEm3LBTjftpmQZtC96KZYayQssVTUx949v5+pvupCTPydfSEbpl6M
         leOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zLUDXBexpFGbOwwR9tXgKuQvUKTicZV5Dz5xqJKW674=;
        b=rS/UsWoq2JcEGn2Iv0BnLaJN7vgRHu4DERAXEIDrLXae7pbemoNWHj7SSaLji9yC4Q
         +N5EbpYPWIFMxvgbsjf42q2HP8jF2HS+gQN0pPEaTmDoXi0KgNULOfugKPT3qZKiNqE3
         3zk2OsrK73ci/0k/x3pfJVMHzRk/2uRl85Txw3SMgr4npFe6RKk1SqxqoYSJjCsj27Gc
         koDd9assh5CPmpjvBXnl22qttODdBqsZtF12SqysMT/5VsXiyX4lRIIxVOB/OQjJIJKn
         0iiEh4XfWQsERy2uxOiJ2mQJhz7/1AL+RXM5PVSGUC+XMBt77WI9K71/25iomTWLQ+4s
         7kXQ==
X-Gm-Message-State: APjAAAUBDcAkw4Yw3yQlm7dsbQsFMq0aQZhQPcuXqUqTES6tpx0qOI6j
        9SJgKawCdMNJQ6AeGp4TJKTjvFmA6do=
X-Google-Smtp-Source: APXvYqwjopr5MRPjyA1MWOH7QFV79Zb5kXrTyBI8R5GSgGa/UQ08X+aqN1AqhE0T0+QnlHr3VZzMCg==
X-Received: by 2002:a17:902:5a06:: with SMTP id q6mr1519623pli.268.1568661788325;
        Mon, 16 Sep 2019 12:23:08 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id a1sm34678861pgh.61.2019.09.16.12.23.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 12:23:06 -0700 (PDT)
Date:   Mon, 16 Sep 2019 12:23:03 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/4] Makefile: run coccicheck on all non-upstream sources
Message-ID: <cover.1568661443.git.liu.denton@gmail.com>
References: <cover.1568309119.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568309119.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all, I spent the weekend brooding over this and I opted to not
convert $(FIND_SOURCE_FILES) into a list of filenames. I put the
justification for it in 4/4 so, hopefully, it'll make sense for someone
who might want to do the same change in the future.


Before, when we ran coccicheck, it would only run on files that are
currently being compiled. However, this leaves us with a blindspot where
Windows-only sources are not checked since Coccinelle does not run on
Windows.

This patchset addresses this by making the "coccicheck" target run
against all source files in the repository, except for source files that
are pulled from some upstream source.

This patchset should serve as a continuation of the original discussion
about running coccicheck on all sources[1].

These patches depend on "ds/midx-expire-repack" and "dl/compat-cleanup".

[1]: https://public-inbox.org/git/nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet/


Denton Liu (4):
  Makefile: strip leading ./ in $(LIB_H)
  Makefile: define THIRD_PARTY_SOURCES
  Makefile: strip leading ./ in $(FIND_SOURCE_FILES)
  Makefile: run coccicheck on more source files

 Makefile | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  e7fa5e1df7 Makefile: strip leading ./ in $(LIB_H)
1:  72b4cc68f5 ! 2:  a7c855a973 Makefile: define THIRD_PARTY_SOURCES
    @@ Metadata
      ## Commit message ##
         Makefile: define THIRD_PARTY_SOURCES
     
    -    After looking through the source files in compat/ and investigating the
    -    files' content and/or its Git history, I've determined the list of files
    -    that were copied from a third-party source. Place the names of these
    -    files into the THIRD_PARTY_SOURCES variable in the Makefile.
    +    Some files in our codebase are borrowed from other projects, and
    +    minimally updated to suit our own needs. We'd sometimes need to tell
    +    our own sources and these third-party sources apart for management
    +    purposes (e.g. we may want to be less strict about coding style and
    +    other issues on third-party files).
     
    -    In addition, add the sha1collisiondetection/ and sha1dc/ sources as well
    -    since they are also imported from a third-party source.
    -
    -    In a future commit, this variable will be used to determine which files
    -    are excluded when running the "coccicheck" target.
    +    Define the $(MAKE) variable THIRD_PARTY_SOURCES that can be used to
    +    match names of third-party sources.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Makefile ##
     @@ Makefile: SCRIPT_SH =
    @@ Makefile: BUILTIN_OBJS += builtin/verify-tag.o
      BUILTIN_OBJS += builtin/worktree.o
      BUILTIN_OBJS += builtin/write-tree.o
      
    ++# THIRD_PARTY_SOURCES is a list of patterns compatible with
    ++# the $(filter) and $(filter-out) family of functions
     +THIRD_PARTY_SOURCES += compat/inet_ntop.c
     +THIRD_PARTY_SOURCES += compat/inet_pton.c
     +THIRD_PARTY_SOURCES += compat/obstack.%
2:  a51acfec66 ! 3:  71861cbdf8 Makefile: strip leading ./ in $(FIND_SOURCE_FILES)
    @@ Commit message
         to remove the `./` prefix in the $(FIND) case.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Makefile ##
     @@ Makefile: FIND_SOURCE_FILES = ( \
3:  75c36bc9a1 ! 4:  0ecfcd8858 Makefile: run coccicheck on more source files
    @@ Commit message
     
         * compat/obstack.c
     
    +    Instead of generating $(FOUND_C_SOURCES) from a
    +    `$(shell $(FIND_SOURCE_FILES))` invocation, an alternative design was
    +    considered which involved converting $(FIND_SOURCE_FILES) into
    +    $(SOURCE_FILES) which would hold a list of filenames from the
    +    $(FIND_SOURCE_FILES) invocation. We would simply filter `%.c` files into
    +    $(ALL_C_SOURCES). $(SOURCE_FILES) would then be passed directly to the
    +    etags, ctags and cscope commands. We can see from the following
    +    invocation
    +
    +            $ git ls-files '*.[hcS]' '*.sh' ':!*[tp][0-9][0-9][0-9][0-9]*' ':!contrib' | wc -c
    +               12779
    +
    +    that the number of characters in this list would pose a problem on
    +    platforms with short command-line length limits (such as CMD which has a
    +    max of 8191 characters). As a result, we don't perform this change.
    +
    +    However, we can see that the same issue may apply when running
    +    Coccinelle since $(COCCI_SOURCES) is also a list of filenames:
    +
    +            if ! echo $(COCCI_SOURCES) | xargs $$limit \
    +                    $(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
    +                    >$@+ 2>$@.log; \
    +
    +    This is justified since platforms that support Coccinelle generally have
    +    reasonably long command-line length limits and so we are safe for the
    +    foreseeable future.
    +
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Makefile ##
     @@ Makefile: check: command-list.h
    @@ Makefile: check: command-list.h
     -else
     -COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
     -endif
    -+FIND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
    -+COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FIND_C_SOURCES))
    ++FOUND_C_SOURCES = $(filter %.c,$(shell $(FIND_SOURCE_FILES)))
    ++COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
      
      %.cocci.patch: %.cocci $(COCCI_SOURCES)
      	@echo '    ' SPATCH $<; \
-- 
2.23.0

