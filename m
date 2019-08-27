Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533171F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbfH0EEw (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:04:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44560 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0EEv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 00:04:51 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so34653986iog.11
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 21:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vK+C9bnVtG8Y4lfOkKkjMTj8c9Gd/hBl8DadRRRnIyg=;
        b=uR2tf1RsfEVY8L/heRJqY3+R5LJfbTEfIhEalKZbWUERw8zoj0qOoYCdmzR1Su8l0r
         qZuEq70aV39OA5ht49vt0dGzaG5JjJk5r2mdsuI73B2F+lFjzXan2QplVobSHaEVAghk
         Y2SLIcTnfDxbi8tNH3D8FOvyoPNwFCktCHEoEUA6nHJ4KXe02MSmTby75JyBHUsvvtdg
         TQiiuJ0mkA6pitj9l7psNGflJYfHUl9XEBE8ZObDG381TP5bkCG3jvJVoLfXR4CiVMIV
         Q0p7zC4Z62+vYyEUKRSCjH0CVmd6baeQAXVw3BaE891zzhsDZ8qClDbCCYSxDh06btB+
         w6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vK+C9bnVtG8Y4lfOkKkjMTj8c9Gd/hBl8DadRRRnIyg=;
        b=VI9npJdODLounloR7jhOWCD/kEBhYO87pOLKqoZNN3GfcL2+i8yUsTJvCRSxePHbBN
         haIoHZ4DGBsceFbqjSdwNSRrAc8gDvy4djU9I+DpnoJLkW6U71U5RevUoo6Z7KJpx+WA
         jPZHbfEZKldeSFTGHndAtp47fQ7QgM2KbZCiNx+VALekgqTr6KTFwGku/lKhTUZFLiDn
         U3R8xojghLUJrvG2nKehdYiIY9mztkkWouJUFqd57FlEjihuP7urxWvp4ukV2tcSOcZf
         ySCal0ABJhTGwDu7foEYEsavoFTfJoYXC7ll3YiZV0s8+7xKH0r92fzMQhpCU4RBEkHK
         bP9Q==
X-Gm-Message-State: APjAAAUwWQki9a+fNdQsUTY/L7FoqDK1zvSmd6ZXWlxru9dkD8Tz/LSu
        svOKde1sFMO1HISdRnm9CfpKcrvS
X-Google-Smtp-Source: APXvYqxm9mtYB1/SNUv1fxIT/W+IpKXaCA7m/BaFLcAsCzw5nPFgesS0m/vZClOr1uUHiXsWYq8iRQ==
X-Received: by 2002:a5d:9ad0:: with SMTP id x16mr5216890ion.66.1566878690123;
        Mon, 26 Aug 2019 21:04:50 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id y25sm23057365iol.59.2019.08.26.21.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:04:49 -0700 (PDT)
Date:   Tue, 27 Aug 2019 00:04:47 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 00/13] format-patch: clean up tests and documentation
Message-ID: <cover.1566878373.git.liu.denton@gmail.com>
References: <cover.1566635008.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566635008.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this reroll, I squashed Junio's suggestion into the correct patch.
Also, I took Eric's suggestion and removed the weak justification (i.e.
better error messages) from the sed patch since it doesn't really
contribute.


As one of the older parts of the Git, the tests and documentation for
format-patch have been needing cleanup for a while. Let's do that in
this patchset!

This patchset is based on v3 of "format-patch: learn
--infer-cover-subject option (also t4014 cleanup)"[1].

Changes since v1:

* Squash Junio's patch into the correct patch ;)

* Remove weak justification (better error messages) in 8/13

Changes since v3 of "format-patch: learn --infer-cover-subject option (also
t4014 cleanup)":

* Squash in Junio's and Hannes' suggestions

* Add 't4014: let sed open its own files'

[1]: https://public-inbox.org/git/xmqqwof3ljcz.fsf@gitster-ct.c.googlers.com/T/#m19570aff4828dfbd65d57cacf231c2938af1dc9f


Denton Liu (13):
  t4014: drop unnecessary blank lines from test cases
  t4014: s/expected/expect/
  t4014: move closing sq onto its own line
  t4014: use sq for test case names
  t4014: remove spaces after redirect operators
  t4014: use indentable here-docs
  t4014: drop redirections to /dev/null
  t4014: let sed open its own files
  t4014: use test_line_count() where possible
  t4014: remove confusing pipe in check_threading()
  t4014: stop losing return codes of git commands
  Doc: add more detail for git-format-patch
  config/format.txt: specify default value of format.coverLetter

 Documentation/config/format.txt    |   1 +
 Documentation/git-format-patch.txt |  23 +-
 t/t4014-format-patch.sh            | 814 ++++++++++++++---------------
 3 files changed, 421 insertions(+), 417 deletions(-)

Range-diff against v1:
 1:  fb000bfca2 =  1:  fb000bfca2 t4014: drop unnecessary blank lines from test cases
 2:  0a5ce9b95f =  2:  0a5ce9b95f t4014: s/expected/expect/
 3:  5c49703aa4 =  3:  5c49703aa4 t4014: move closing sq onto its own line
 4:  02a11147fd =  4:  02a11147fd t4014: use sq for test case names
 5:  8d9791c061 =  5:  8d9791c061 t4014: remove spaces after redirect operators
 6:  90ad0fcf70 =  6:  90ad0fcf70 t4014: use indentable here-docs
 7:  804b3163f8 =  7:  804b3163f8 t4014: drop redirections to /dev/null
 8:  7d9a24a979 !  8:  967e624bb4 t4014: let sed open its own files
    @@ Commit message
         t4014: let sed open its own files
     
         In some cases, we were using a redirection operator to feed input into
    -    sed. However, since sed is capable of opening its own files and provides
    -    better error messages on IO failure, make sed open its own files instead
    -    of redirecting input into it.
    +    sed. However, since sed is capable of opening its own files, make sed
    +    open its own files instead of redirecting input into it.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
 9:  d068d42098 =  9:  9a42ec2b7e t4014: use test_line_count() where possible
10:  6a9409cee0 = 10:  8acc90f74d t4014: remove confusing pipe in check_threading()
11:  c580ce447b = 11:  bc7355485f t4014: stop losing return codes of git commands
12:  a97f861e6a ! 12:  fd343b99c5 Doc: add more detail for git-format-patch
    @@ Commit message
         In git-format-patch.txt, we were missing some key user information.
         First of all, document the special value of `--base=auto`.
     
    -    Next, while we're at it, surround option arguments with <>.
    +    Next, while we're at it, surround option arguments with <> and change
    +    existing names such as "Message-Id" to "message id", which conforms with
    +    how existing documentation is written.
     
         Finally, document the `format.outputDirectory` config and change
         `format.coverletter` to use camel case.
    @@ Documentation/git-format-patch.txt: SYNOPSIS
      		   [-n | --numbered | -N | --no-numbered]
      		   [--start-number <n>] [--numbered-files]
     -		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
    -+		   [--in-reply-to=<Message-Id>] [--suffix=.<sfx>]
    ++		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
      		   [--ignore-if-in-upstream]
     -		   [--rfc] [--subject-prefix=Subject-Prefix]
    -+		   [--rfc] [--subject-prefix=<Subject-Prefix>]
    ++		   [--rfc] [--subject-prefix=<subject prefix>]
      		   [(--reroll-count|-v) <n>]
      		   [--to=<email>] [--cc=<email>]
      		   [--[no-]cover-letter] [--quiet]
    @@ Documentation/git-format-patch.txt: Beware that the default for 'git send-email'
      will want to ensure that threading is disabled for `git send-email`.
      
     ---in-reply-to=Message-Id::
    -+--in-reply-to=<Message-Id>::
    ++--in-reply-to=<message id>::
      	Make the first mail (or all the mails with `--no-thread`) appear as a
    - 	reply to the given Message-Id, which avoids breaking threads to
    +-	reply to the given Message-Id, which avoids breaking threads to
    ++	reply to the given <message id>, which avoids breaking threads to
      	provide a new patch series.
    + 
    + --ignore-if-in-upstream::
    +@@ Documentation/git-format-patch.txt: will want to ensure that threading is disabled for `git send-email`.
    + 	patches being generated, and any patch that matches is
    + 	ignored.
    + 
    +---subject-prefix=<Subject-Prefix>::
    ++--subject-prefix=<subject prefix>::
    + 	Instead of the standard '[PATCH]' prefix in the subject
    +-	line, instead use '[<Subject-Prefix>]'. This
    ++	line, instead use '[<subject prefix>]'. This
    + 	allows for useful naming of a patch series, and can be
    + 	combined with the `--numbered` option.
    + 
     @@ Documentation/git-format-patch.txt: you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
      --base=<commit>::
      	Record the base tree information to identify the state the
13:  7c8522abf2 <  -:  ---------- config/format.txt: specify default value of format.coverLetter
 -:  ---------- > 13:  4e429e1989 config/format.txt: specify default value of format.coverLetter
-- 
2.23.0.248.g3a9dd8fb08

