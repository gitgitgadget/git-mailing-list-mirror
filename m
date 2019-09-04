Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8F81F461
	for <e@80x24.org>; Wed,  4 Sep 2019 11:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfIDLVJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 07:21:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38499 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDLVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 07:21:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so6493091pfe.5
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 04:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ykfDWlEyUHkWfPGej8X/VNlCdDULG76HkzuHdJd6Gj4=;
        b=lxV2hi79mnuMJ7TbCsHyWYwYfINz+NLS+SmEFDIZMuNhHp2QLBtGrdGp3UPSMPMI8q
         MclwYYAntAugc/iUDtFhnCrpC0xHr6bHUxsOywaUV2cyi0tnVpJvLbsk0H/zNrvD/w7l
         legS90Rc5/XsMfTbudf1rX4gwLJx7XSLIlDabUvRx8ve5Q6+SRuo3GkoGaO6hYPb+MQO
         XqNDeTaAlu6UAVxCGuu/71h1sZDrvg7ilAlVuAGYv91lXueyhCzpwco1Eq42CsoeZJBv
         pGygC22krEIe8ioE0qsji7HYNGdTk7mgirw3PQ6/BmvQMmf+zA+J23gRPoAeVE5m3Rq+
         z8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ykfDWlEyUHkWfPGej8X/VNlCdDULG76HkzuHdJd6Gj4=;
        b=XAatx7badiXN0n5Lv2HDNcrUqBOFKHheuOdhbo2jeTFf4YpG4tkpRg0GusUfExD2FB
         XCgxFKyrPUtCmxp+EgKskG/aaFaS75pqbZGbaPMEf41bTlvaIg9yHgLydo/nUruGXKFb
         bEnfF3569d+cRdFYBH7a4bNQ6MTywA6ekB/0a47uKROGGEpdT7UDYHMy0tc6Lnp2kyn0
         8kS7oTnUvo1Gj82ZNG0c6wfOO0bIzhch5m23MkuPlrWK5Bl/WQTdODyNzrbiCcwjaZTJ
         SRB/QT7+1bnt0Rfja6EXJp6ziTtPpeegNoRa+MhK3mJByuGEl3g9Jvrr1s4GwPdsHhyl
         kq1g==
X-Gm-Message-State: APjAAAVVyVuVi/7fPbFCP0nZF25mUbvNoTn3gRpLmtxrOB+jawIPmgWg
        9rV9yTaj0Nuvxgg+/9/gscm7WCKVIKE=
X-Google-Smtp-Source: APXvYqxfwR+7hudxfNTuIvuS35SOepZznssIFcHg6k6YLrBaIsArEWRxcgBNghUIoVAcwmLen4IILw==
X-Received: by 2002:a63:460d:: with SMTP id t13mr33598927pga.205.1567596068111;
        Wed, 04 Sep 2019 04:21:08 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id a1sm11452923pgd.74.2019.09.04.04.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 04:21:07 -0700 (PDT)
Date:   Wed, 4 Sep 2019 04:21:05 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 00/13] format-patch: clean up tests and documentation
Message-ID: <20190904112105.GA27933@archbookpro.localdomain>
References: <cover.1566635008.git.liu.denton@gmail.com>
 <cover.1566878373.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566878373.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I see that "dl/format-patch-doc-test-cleanup" currently has the comment
"Expecting a reroll." This should be the reroll that you're expecting ;)

Also, since there haven't been any comments on the topic in a while, I
propose that it should be ready for inclusion.

Thanks,

Denton

On Tue, Aug 27, 2019 at 12:04:47AM -0400, Denton Liu wrote:
> In this reroll, I squashed Junio's suggestion into the correct patch.
> Also, I took Eric's suggestion and removed the weak justification (i.e.
> better error messages) from the sed patch since it doesn't really
> contribute.
> 
> 
> As one of the older parts of the Git, the tests and documentation for
> format-patch have been needing cleanup for a while. Let's do that in
> this patchset!
> 
> This patchset is based on v3 of "format-patch: learn
> --infer-cover-subject option (also t4014 cleanup)"[1].
> 
> Changes since v1:
> 
> * Squash Junio's patch into the correct patch ;)
> 
> * Remove weak justification (better error messages) in 8/13
> 
> Changes since v3 of "format-patch: learn --infer-cover-subject option (also
> t4014 cleanup)":
> 
> * Squash in Junio's and Hannes' suggestions
> 
> * Add 't4014: let sed open its own files'
> 
> [1]: https://public-inbox.org/git/xmqqwof3ljcz.fsf@gitster-ct.c.googlers.com/T/#m19570aff4828dfbd65d57cacf231c2938af1dc9f
> 
> 
> Denton Liu (13):
>   t4014: drop unnecessary blank lines from test cases
>   t4014: s/expected/expect/
>   t4014: move closing sq onto its own line
>   t4014: use sq for test case names
>   t4014: remove spaces after redirect operators
>   t4014: use indentable here-docs
>   t4014: drop redirections to /dev/null
>   t4014: let sed open its own files
>   t4014: use test_line_count() where possible
>   t4014: remove confusing pipe in check_threading()
>   t4014: stop losing return codes of git commands
>   Doc: add more detail for git-format-patch
>   config/format.txt: specify default value of format.coverLetter
> 
>  Documentation/config/format.txt    |   1 +
>  Documentation/git-format-patch.txt |  23 +-
>  t/t4014-format-patch.sh            | 814 ++++++++++++++---------------
>  3 files changed, 421 insertions(+), 417 deletions(-)
> 
> Range-diff against v1:
>  1:  fb000bfca2 =  1:  fb000bfca2 t4014: drop unnecessary blank lines from test cases
>  2:  0a5ce9b95f =  2:  0a5ce9b95f t4014: s/expected/expect/
>  3:  5c49703aa4 =  3:  5c49703aa4 t4014: move closing sq onto its own line
>  4:  02a11147fd =  4:  02a11147fd t4014: use sq for test case names
>  5:  8d9791c061 =  5:  8d9791c061 t4014: remove spaces after redirect operators
>  6:  90ad0fcf70 =  6:  90ad0fcf70 t4014: use indentable here-docs
>  7:  804b3163f8 =  7:  804b3163f8 t4014: drop redirections to /dev/null
>  8:  7d9a24a979 !  8:  967e624bb4 t4014: let sed open its own files
>     @@ Commit message
>          t4014: let sed open its own files
>      
>          In some cases, we were using a redirection operator to feed input into
>     -    sed. However, since sed is capable of opening its own files and provides
>     -    better error messages on IO failure, make sed open its own files instead
>     -    of redirecting input into it.
>     +    sed. However, since sed is capable of opening its own files, make sed
>     +    open its own files instead of redirecting input into it.
>      
>          Signed-off-by: Denton Liu <liu.denton@gmail.com>
>      
>  9:  d068d42098 =  9:  9a42ec2b7e t4014: use test_line_count() where possible
> 10:  6a9409cee0 = 10:  8acc90f74d t4014: remove confusing pipe in check_threading()
> 11:  c580ce447b = 11:  bc7355485f t4014: stop losing return codes of git commands
> 12:  a97f861e6a ! 12:  fd343b99c5 Doc: add more detail for git-format-patch
>     @@ Commit message
>          In git-format-patch.txt, we were missing some key user information.
>          First of all, document the special value of `--base=auto`.
>      
>     -    Next, while we're at it, surround option arguments with <>.
>     +    Next, while we're at it, surround option arguments with <> and change
>     +    existing names such as "Message-Id" to "message id", which conforms with
>     +    how existing documentation is written.
>      
>          Finally, document the `format.outputDirectory` config and change
>          `format.coverletter` to use camel case.
>     @@ Documentation/git-format-patch.txt: SYNOPSIS
>       		   [-n | --numbered | -N | --no-numbered]
>       		   [--start-number <n>] [--numbered-files]
>      -		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
>     -+		   [--in-reply-to=<Message-Id>] [--suffix=.<sfx>]
>     ++		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
>       		   [--ignore-if-in-upstream]
>      -		   [--rfc] [--subject-prefix=Subject-Prefix]
>     -+		   [--rfc] [--subject-prefix=<Subject-Prefix>]
>     ++		   [--rfc] [--subject-prefix=<subject prefix>]
>       		   [(--reroll-count|-v) <n>]
>       		   [--to=<email>] [--cc=<email>]
>       		   [--[no-]cover-letter] [--quiet]
>     @@ Documentation/git-format-patch.txt: Beware that the default for 'git send-email'
>       will want to ensure that threading is disabled for `git send-email`.
>       
>      ---in-reply-to=Message-Id::
>     -+--in-reply-to=<Message-Id>::
>     ++--in-reply-to=<message id>::
>       	Make the first mail (or all the mails with `--no-thread`) appear as a
>     - 	reply to the given Message-Id, which avoids breaking threads to
>     +-	reply to the given Message-Id, which avoids breaking threads to
>     ++	reply to the given <message id>, which avoids breaking threads to
>       	provide a new patch series.
>     + 
>     + --ignore-if-in-upstream::
>     +@@ Documentation/git-format-patch.txt: will want to ensure that threading is disabled for `git send-email`.
>     + 	patches being generated, and any patch that matches is
>     + 	ignored.
>     + 
>     +---subject-prefix=<Subject-Prefix>::
>     ++--subject-prefix=<subject prefix>::
>     + 	Instead of the standard '[PATCH]' prefix in the subject
>     +-	line, instead use '[<Subject-Prefix>]'. This
>     ++	line, instead use '[<subject prefix>]'. This
>     + 	allows for useful naming of a patch series, and can be
>     + 	combined with the `--numbered` option.
>     + 
>      @@ Documentation/git-format-patch.txt: you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>       --base=<commit>::
>       	Record the base tree information to identify the state the
> 13:  7c8522abf2 <  -:  ---------- config/format.txt: specify default value of format.coverLetter
>  -:  ---------- > 13:  4e429e1989 config/format.txt: specify default value of format.coverLetter
> -- 
> 2.23.0.248.g3a9dd8fb08
> 
