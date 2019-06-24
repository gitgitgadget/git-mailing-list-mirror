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
	by dcvr.yhbt.net (Postfix) with ESMTP id 179531F461
	for <e@80x24.org>; Mon, 24 Jun 2019 20:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbfFXU2L (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 16:28:11 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:40166 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfFXU2L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 16:28:11 -0400
Received: by mail-wm1-f49.google.com with SMTP id v19so617449wmj.5
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 13:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=StVsrU2ssncbwawQpmLKK0FW3Pg2AAzcj56XqFpo73g=;
        b=sew2g1M/jKbyMab+T947wHQl+Q6TSUJ23CgnQAHLt468A9qrkIdiX9p5O3ydPLw0WX
         oJjEuIy3ZKyPS64k3gZU6he80/uk8PjR8V/V72CdymBA4+ImVoQHp/XMCYqlshVbefPe
         cglZ/76PjQz4kqtADYvRdH/MhNoMfl1+ZepSi6DtiiHUCctdMciyD/KJUD+5nBTutf7y
         yYpenQLWYRU8bl6AK4LI5pDiLS2iBSGBGid8/ZNogN1WoKbHPlrHQHMDZhMJ17hAjtCN
         rRMsQk9gBOLHv+2d2oLkDmaYV8dmh8ydwQ1CUziHTDGjUZrAUlIU2OWYCTiA8vqpNMIp
         BVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=StVsrU2ssncbwawQpmLKK0FW3Pg2AAzcj56XqFpo73g=;
        b=AoCE2u83r9/hAP9OMpWkdFgvE/KOHpm7gZZ+L1k7+YvNqo6HJCPDnu3UsHUYmpv6u8
         eog2bDQk5mjpojp14WPJSeMnMID6J4dQtfwZcouHRPssbEID7mooAoL85g/mz8OhmLvO
         H3VcPx3J/7182g6+lpgAQo5MZkklRkZo7iP55gNTlwsoqYLcJ3taBUCSFeoKaiWZCTIc
         RmZiAiouksk7WFav4M1hLmJNrYeQCi36DKEY9nB2yudfhAB2rliBl57OmhRhEAv7R6C8
         p6A8VY6YmHZUshzJdNt7j8Uo1bDpIrtf5PdsboQoj3eoidrk4SKmyf20kG3tPAcE5a2/
         HsHQ==
X-Gm-Message-State: APjAAAX+cDEK2ro8KSTumF7A7q8JFSVkv+M5yKELzxJcDFwBRFIvms+R
        G0xzQzOjoUBGBgVG/1K44Zg=
X-Google-Smtp-Source: APXvYqxMRHFCch7QUwUWqU55RPOX/O0rSx21JRs1RNjkJMLaqo5A8xl8cexay8qqI+bC7FNFSZs2vQ==
X-Received: by 2002:a1c:4184:: with SMTP id o126mr16934797wma.68.1561408087989;
        Mon, 24 Jun 2019 13:28:07 -0700 (PDT)
Received: from linux-16.fritz.box (2a0a-a542-2a07-0-a793-8424-e1d1-435c.ipv6dyn.netcologne.de. [2a0a:a542:2a07:0:a793:8424:e1d1:435c])
        by smtp.gmail.com with ESMTPSA id y16sm8530362wru.28.2019.06.24.13.28.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 13:28:07 -0700 (PDT)
From:   Morian Sonnet <moriansonnet@gmail.com>
X-Google-Original-From: Morian Sonnet <MorianSonnet@googlemail.com>
Received: from linux-16.fritz.box (localhost [127.0.0.1])
        by linux-16.fritz.box (8.15.2/8.15.2) with ESMTPS id x5OKS5wJ014137
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 22:28:05 +0200
Received: (from momo@localhost)
        by linux-16.fritz.box (8.15.2/8.15.2/Submit) id x5OKS5Qx014136;
        Mon, 24 Jun 2019 22:28:05 +0200
To:     gitster@pobox.com
Cc:     MorianSonnet@googlemail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, johannes.schindelin@gmx.de,
        moriansonnet@gmail.com, sunshine@sunshineco.us
Subject: submodule foreach: fix recursion of options
Date:   Mon, 24 Jun 2019 22:26:53 +0200
Message-Id: <20190624202653.13810-1-MorianSonnet@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <xmqqsgryhmqt.fsf@gitster-ct.c.googlers.com>
References: <xmqqsgryhmqt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

thanks for your comments.

I fixed the type in the commit message and adapted my test case to the
required shell script style.

Best regards,
   Morian


Junio C Hamano <gitser@pobox.com> writes:

> > Calling
> >
> >     git submodule foreach --recursive <subcommand> --<option>
> >
> > leads to an error stating that the option --<option> is unknown to
> > submodule--helper. That is of course only, when <option> is not a valid
> > option for git submodule foreach.
> >
> > The reason for this is, that above call is internally translated into a
> > call to submodule--helper:
> >
> >     git submodule--helper foreach --recursive \
> >         -- <subcommand> --<option>
> >
> > This call starts by executing the subcommand with its option inside the
> > first first level submodule and continues by calling the next iteration
> 
> first first???
> 
> > of the submodule foreach call
> >
> >     git --super-prefix <submodulepath> submodule--helper \
> >       foreach --recursive <subcommand> --<option>
> >
> > inside the first level submodule. Note that the double dash in front of
> > the subcommand is missing.
> >
> > This problem starts to arise only recently, as the
> > PARSE_OPT_KEEP_UNKNOWN flag for the argument parsing of git submodule
> > foreach was removed in commit a282f5a906. Hence, the unknown option is
> > complained about now, as the argument parsing is not properly ended by
> > the double dash.
> >
> > This commit fixes the problem by adding the double dash in front of the
> > subcommand during the recursion.
> >
> > Signed-off-by: Morian Sonnet <moriansonnet@googlemail.com>
> > ---
> >  builtin/submodule--helper.c  | 1 +
> >  t/t7407-submodule-foreach.sh | 7 +++++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index 0bf4aa088e..afaf0819c9 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -540,6 +540,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
> >  		if (info->quiet)
> >  			argv_array_push(&cpr.args, "--quiet");
> >  
> > +		argv_array_push(&cpr.args, "--");
> >  		argv_array_pushv(&cpr.args, info->argv);
> >  
> >  		if (run_command(&cpr))
> > diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> > index 706ae762e0..43da184d40 100755
> > --- a/t/t7407-submodule-foreach.sh
> > +++ b/t/t7407-submodule-foreach.sh
> > @@ -421,4 +421,11 @@ test_expect_success 'option-like arguments passed to foreach commands are not lo
> >  	test_cmp expected actual
> >  '
> >  
> > +test_expect_success 'option-like arguments passed to foreach recurse correctly' '
> > +  git -C clone2 submodule foreach --recursive "echo be --an-option" > expected &&
> > +  git -C clone2 submodule foreach --recursive echo be --an-option > actual &&
> > +  grep -e "--an-option" expected &&
> > +  test_cmp expected actual
> > +'
> 
> Some shell style nits.
> 
>  - our shell scripts use HT for indentation, not two SPs.
> 
>  - there is one SP before a redirection operator (you did it
>    correctly), and no SP after a redirection operator before the
>    target filename.
> 
>  - mostly we prepare the right answer in 'expect' and take the
>    output from tested command in 'actual' to compare.  There are a
>    few 'expected' in this test file already, so you are not
>    introducing a new inconsistency, but you are making things
>    worse.  Don't.
> 
> Other than that, your fix looks quite nicely described and executed.
> 
> Thanks.


