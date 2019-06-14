Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B38DE1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 21:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFNV4P (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 17:56:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37331 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNV4P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 17:56:15 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so9035743iok.4
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 14:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oeQyyZrBe/tzjMX6WSVTwDjwyeqaNPCLIgIY5PdYddI=;
        b=A0lpcndIbjWW3Zv2uvsNOr95MWnOBB5nBTYa9WEGZR3dqV2txSEbJaqqKXOYeUUkWF
         PUN/yjnSJ6hoOW5LEfzsuc6en7h8p8ynWuvyZXBkksxQYDV1mM0+2a52VktRSOYf/qak
         G5gfDY1ObOEhIdiATgdtwYs8Z3LUxoFjkFUr7IZqO/c3YKuqwiauo3lGukwesnNuKI3z
         KSOMEavewXIVRZiLzYsKhSSR3ZbUO3TKhSnysUOkRi1IdE8f1cpBC9DVAwohIwFmmx5w
         lDTIITINoA6E8zl7OGRpHEshuNbaFEoMqyz7v9f7cCkoLs3Vhx7WhdYXqg/0zuGJWEfV
         AW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oeQyyZrBe/tzjMX6WSVTwDjwyeqaNPCLIgIY5PdYddI=;
        b=Rt0RGKvudUfYIs3hfMFsuK8NEHkQWuuSnMEHzVwfDCWMshR69QyPwKrQxo4OO4w3bS
         YrAThCbHly82LthDLtWP3ErLN4KQeSr1IBnMNB/avMRUZPl7cNlZxoyDm2iSc4xoZ3JH
         M6+pEwYE1m/ucTpvx3cAgjWkig8MkMuIApaYnn5W2G1UmbYVyEj57UnE9MWuk0h082ys
         zosma9Y/SEbKi5i5U5TBuYTZ7f/p+Jwea4KWQoazv1MLMocVlXx6FWuWmESTBqfSb5yJ
         QdS9NOPJtXPI4Nc46YAED+PO8btVgzm3+cNoYz+wBbLkWJWebjrs7DozARE/FGp3COO4
         P9Pg==
X-Gm-Message-State: APjAAAVlc9X76T+rzTIGJ9VdpAr+MevmlY37XuvDbn+7DZOWGnsrf/Xc
        2K6Y99WBxVen1UfeWeSwjsLUI8kZ
X-Google-Smtp-Source: APXvYqzk8IZtw5KQOUMyt/zqCm292yHyVpDZhxXGiNWso2+x3tOXJbqcVryspXdx9AntD9qtTJRo9g==
X-Received: by 2002:a02:c918:: with SMTP id t24mr70262605jao.111.1560549374001;
        Fri, 14 Jun 2019 14:56:14 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id i3sm5210826ion.9.2019.06.14.14.56.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 14:56:12 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:56:10 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RESEND PATCH v3 0/8] teach branch-specific options for format-patch
Message-ID: <cover.1560547500.git.liu.denton@gmail.com>
References: <cover.1558492582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558492582.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Although 'config: learn the "onbranch:" includeIf condition'[1] seems to be
on track for "next", the content in this patchset is not entirely
superseded by it.

Patches 1 and 2 should be relatively uncontroversial since they just do
a bit of cleanup.

Patch 3 is a new feature that isn't included in the config onbranch
stuff at all. In introduces the `--infer-cover-subject` command-line
option which would allow a cover-letter's subject to be automatically
inferred from the branch's description.

Finally, patches 4-8 are all needed to implement branch-specific
format-patch options. Although this behaviour can be replicated by the
config onbranch patches, it's not a direct replacement. Consider the
following:

	$ git checkout foo
	$ git format-patch master..bar

With config onbranch, this would generate patches using foo's settings
but with this patchset, we would generate patches using bar's settings,
which seems more desirable and intuitive for users.

I suppose if adding a `format.<branch>.*` option is controversial since
we won't be sure if we're adding other intermediate format keys, we
could follow onbranch convention and use `format.forbranch:<branch>.*`
as configuration keys instead.

Thanks,

Denton

[1]: https://public-inbox.org/git/49e22269d5a66d1975fca71a300e9099f46e1c40.1559769658.git.liu.denton@gmail.com/

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
1:  75474e18f4 = 1:  650f04bc04 t4014: clean up style
2:  9ae349bf8a ! 2:  14b40b1dec Doc: add more detail for git-format-patch
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
3:  c0403f5139 < -:  ---------- format-patch: make cover letter subject configurable
-:  ---------- > 3:  ca2b4c21c1 format-patch: infer cover letter from branch description
4:  534c6fd48a ! 4:  82a56a0d76 format-patch: move extra_headers logic later
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
     
5:  491297c40a = 5:  3554164deb string-list: create string_list_append_all
6:  e2c71fa593 ! 6:  6ad1b25858 format-patch: read branch-specific To: and Cc: headers
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
-:  ---------- > 7:  3bc1b95a4e format-patch: move output_directory logic later
-:  ---------- > 8:  2cf7c77f59 format-patch: read branch-specific output directory
-- 
2.22.0.355.g3bfa262345

