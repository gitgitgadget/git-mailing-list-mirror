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
	by dcvr.yhbt.net (Postfix) with ESMTP id D3BC91F462
	for <e@80x24.org>; Wed, 22 May 2019 02:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfEVCo1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 22:44:27 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39228 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfEVCo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 22:44:27 -0400
Received: by mail-it1-f193.google.com with SMTP id 9so726074itf.4
        for <git@vger.kernel.org>; Tue, 21 May 2019 19:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L7daJjtNZCbBrtxZnPjyi7Y0xUAovZpi14fSEoHeScw=;
        b=UQ6AlUCFp12A8cn4Yl5nSTMCKV/G/hOWEXIjNYSGJfF4brqOPhW6kMCVKRMvXPDJat
         P8cL0VaowzK3AbfxvxAHNp8GOpgifH9yBy9gSf66PZnaNclv6TcsHMji9YDjHX7T0wA6
         WgPqZzrd9HwsAyxc5baIlFxEVKAmJoeIjud9sVObzKquQhaFanONrA/N7aYpj+tFv0Od
         0IjnVRBfiZNBp9rRxFDDI11N1iNZFgALPpb140J/M9b6Cayishv1G3CtWw3UNL7qAMKU
         yNu+2LotD4FMuNNxGFuFlPl3COvqSCHGNHG2jt7hIHx6Wv9NVoCY3AZSnMfGeu6W3rcF
         GRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L7daJjtNZCbBrtxZnPjyi7Y0xUAovZpi14fSEoHeScw=;
        b=BY4/jFzCUXWrJ4m+V4gSt883rmL72jEyiBimEDOg+LcSnvYGHspvOU493Evi3ZmL/b
         2q3We0oLx8p6e4igF3njKmzniIPcBh5+Qyp+rh/wENEcZJCt2ShublwYItaW7wPKUhNL
         tH/bdBVrXR6KIgsz1dcEDhUx3Nb4QlGodwaY6YLxlxARX9epRY+aDdyPycQrgnZCNrvx
         o6qN3q+KLeZteapHIJegsu+GRfHigsiqMHFnzt0uqgiX9i/k/uVGE442/8kEADuDv5Jz
         96Czzhx3idFJLYbT9Xj/0c7W8z10XHPvct1oF/Uv6OZt11q54Fl+r1nJubSDunLb4SOD
         RrEg==
X-Gm-Message-State: APjAAAWCerXIWoI8fcqzFwqfQ7Jw3yj8xzZg2ITEXN1f0uYkITXhnluL
        AKNsiuxZQbMr64p14Dhrpg6In7En
X-Google-Smtp-Source: APXvYqzxFHZTNnSFHHWKti882EC9oJB0wb3BQ+IDtMLTdX13A/6sg96T5Sjxe9cO2NxumDn/PGzCpA==
X-Received: by 2002:a24:9289:: with SMTP id l131mr6518974itd.45.1558493066299;
        Tue, 21 May 2019 19:44:26 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id m25sm2226634iti.24.2019.05.21.19.44.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 19:44:25 -0700 (PDT)
Date:   Tue, 21 May 2019 22:44:23 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/8] teach branch-specific options for format-patch
Message-ID: <cover.1558492582.git.liu.denton@gmail.com>
References: <cover.1558052674.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558052674.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I've gotten rid of all the `format.*.coverSubject` stuff and replaced it
with a generic `format.inferCoverSubject` that will read the subject
from the branch description. I've also made `git branch -d` stop
deleting the `format.<branch>.*` variables.

A new addition in this patchset is that format-patch is now taught to
understand the `format.<branch-name>.outputDirectory` configuration.

Changes since v2:

* Replaced `format.<branch-name>.coverSubject` and `--cover-subject`
  with `format.inferCoverSubject` and `--infer-cover-subject` which
  reads the subject from the branch description
* Do not let `git branch -d` delete `format.<branch-name>.*` configs
* More documentation cleanup
* Taught format-patch to read `format.<branch-name>.outputDirectory` as
  well

Changes since v1:

* Used format.<branch-name>.* variables instead of branch.<branch-name>.*


Denton Liu (8):
  t4014: clean up style
  Doc: add more detail for git-format-patch
  format-patch: infer cover letter from branch description
  format-patch: move extra_headers logic later
  string-list: create string_list_append_all
  format-patch: read branch-specific To: and Cc: headers
  format-patch: move output_directory logic later
  format-patch: read branch-specific output directory

 Documentation/config/format.txt    |  17 +-
 Documentation/git-format-patch.txt |  44 +-
 builtin/log.c                      | 237 ++++++---
 string-list.c                      |   9 +
 string-list.h                      |   7 +
 t/t4014-format-patch.sh            | 739 +++++++++++++++++------------
 6 files changed, 667 insertions(+), 386 deletions(-)

Range-diff against v2:
1:  92d7be10aa = 1:  82c0dc9cc8 t4014: clean up style
2:  930a021b7f ! 2:  a8cc599fd2 Doc: add more detail for git-format-patch
    @@ -9,7 +9,10 @@
     
         In addition, document the special value of `--base=auto`.
     
    -    Finally, while we're at it, surround option arguments with <>.
    +    Next, while we're at it, surround option arguments with <>.
    +
    +    Finally, document the `format.outputDirectory` config and change
    +    `format.coverletter` to use camelcase.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
    @@ -67,3 +70,25 @@
      
      --root::
      	Treat the revision argument as a <revision range>, even if it
    +@@
    + -------------
    + You can specify extra mail header lines to be added to each message,
    + defaults for the subject prefix and file suffix, number patches when
    +-outputting more than one patch, add "To" or "Cc:" headers, configure
    +-attachments, and sign off patches with configuration variables.
    ++outputting more than one patch, add "To:" or "Cc:" headers, configure
    ++attachments, change the patch output directory, and sign off patches
    ++with configuration variables.
    + 
    + ------------
    + [format]
    +@@
    + 	cc = <email>
    + 	attach [ = mime-boundary-string ]
    + 	signOff = true
    +-	coverletter = auto
    ++	outputDirectory = <directory>
    ++	coverLetter = auto
    + ------------
    + 
    + 
3:  075e2c0721 < -:  ---------- format-patch: make cover letter subject configurable
-:  ---------- > 3:  e3b8c96b1c format-patch: infer cover letter from branch description
4:  323179377e ! 4:  52ee126825 format-patch: move extra_headers logic later
    @@ -7,10 +7,10 @@
         logic later in the function so that this happens. (This patch is best
         viewed with `git diff --color-moved`.)
     
    -    Note that this logic only depends on the `git_config` and
    +    Note that this logic only depends on `git_config` and
         `repo_init_revisions` and is depended on by the patch creation logic
    -    which is directly below it so this move is effectively a no-op as
    -    no dependencies being reordered.
    +    which is directly below it so this move is effectively a no-op as no
    +    dependencies being reordered.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
5:  7a8fa4f5f6 = 5:  27c60c715c string-list: create string_list_append_all
6:  9d7338f067 ! 6:  f2a1546b2d format-patch: read branch-specific To: and Cc: headers
    @@ -59,29 +59,20 @@
      	far (from config or command line).
      
     @@
    - -------------
    - You can specify extra mail header lines to be added to each message,
    - defaults for the subject prefix and file suffix, number patches when
    --outputting more than one patch, add "To" or "Cc:" headers, configure
    -+outputting more than one patch, add "To:" or "Cc:" headers, configure
    - attachments, and sign off patches with configuration variables.
    - 
    - ------------
    -@@
    + 	inferCoverSubject = true
      ------------
      
    - In addition, for a specific branch, you can specify a custom cover
    --letter subject.
    ++In addition, for a specific branch, you can specify a custom cover
     +letter subject, and add additional "To:" or "Cc:" headers.
    - 
    - ------------
    - [format "branch-name"]
    - 	coverSubject = "subject for branch-name only"
    ++
    ++------------
    ++[format "branch-name"]
     +	to = <email>
     +	cc = <email>
    - ------------
    ++------------
      
      DISCUSSION
    + ----------
     
      diff --git a/builtin/log.c b/builtin/log.c
      --- a/builtin/log.c
    @@ -96,7 +87,7 @@
      static void add_header(const char *value)
      {
     @@
    - 	return 0;
    + 	fprintf(rev->diffopt.file, "\n");
      }
      
     +static void add_branch_headers(struct rev_info *rev, const char *branch_name)
    @@ -186,25 +177,6 @@
      		strbuf_addstr(&buf, extra_hdr.items[i].string);
      		strbuf_addch(&buf, '\n');
     
    - diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
    - --- a/t/t3200-branch.sh
    - +++ b/t/t3200-branch.sh
    -@@
    - 
    - test_expect_success 'test deleting branch deletes branch config' '
    - 	git config format.my7.coverSubject "cover subject" &&
    -+	git config format.my7.to "To Me <to@example.com>" &&
    -+	git config format.my7.cc "Cc Me <cc@example.com>" &&
    - 	git branch -d my7 &&
    - 	test -z "$(git config branch.my7.remote)" &&
    - 	test -z "$(git config branch.my7.merge)" &&
    - 	test -z "$(git config format.my7.coverSubject)"
    -+	test -z "$(git config format.my7.to)" &&
    -+	test -z "$(git config format.my7.cc)"
    - '
    - 
    - test_expect_success 'test deleting branch without config' '
    -
      diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
      --- a/t/t4014-format-patch.sh
      +++ b/t/t4014-format-patch.sh
-:  ---------- > 7:  70e28c5472 format-patch: move output_directory logic later
-:  ---------- > 8:  b23c3c16f7 format-patch: read branch-specific output directory
-- 
2.22.0.rc1.169.g49223abbf8

