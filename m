Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2D651F463
	for <e@80x24.org>; Tue, 17 Sep 2019 12:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfIQMWY (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 08:22:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33746 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfIQMWX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 08:22:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so2978013wrs.0
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 05:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=G1x72+3nEkKOp4QBGqe4DHaSUFCU/9xuNA2Sgp4TOkM=;
        b=tDovnlA/LHVLWycNWoGdKvw8ofum2Kyt1P3Z99hIpsl/oFTYW/+FKBfE7UaOSMM5o4
         2vz0DRXQB4LUoIBEq2Jv9WcbPfbvlSQJocKyC67fign3E4VgsEqJSjd3Bg9ktazmFtOM
         zTSfDGC+a5KNOMnaIUnHHa3aWI/QQC4ifmup1DDfJE49DA5t17RG7xuldxlVtvAAyPgO
         giefxZTVc1CNnFjBJsOfqFPkjluSo2GrajGBK8sK4aCyUvvHo7kl3sqn1L7jwfbJ3zvP
         21zKlfi69pvXT7SH88FH7jZNOtF5i4+Ia/dexoZiKrPeWDPWgdpCmaxx6V5xbIKrn6OX
         UtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=G1x72+3nEkKOp4QBGqe4DHaSUFCU/9xuNA2Sgp4TOkM=;
        b=tM+SIG+iIQ1ArW16IxYvJizdr5isNtSOftnQ0HBizhP+pKl9EUHchBZLL1Le9bj/Sg
         qrQTfpkFGFL8gsxI+ssZla/CRek26Xm+Vg8AEzmPI6gczx6Ni/6ONfns3OYx/wcBNFl4
         S5aA+nFFogxp+eBXbFIe87J+eKia7wRGDZOAVMBMLE/wlDRtJacvVh1fkjJ+CguAl9WW
         6fboNR5U3RwYpsnW1AFpUU/ElOUreLxQsF58HMsUZaN6sNytpEM8yxBugIylTqSpb7b4
         c8mAFqLLlhFliFFm8hjzcIcIZl9JizgelinRraC3l6r3+lG1EiGL64Ch5izrqlvGBogM
         xBlQ==
X-Gm-Message-State: APjAAAU3C4RYfoXE50U9zAsiigtS8/qem2yRuQqi8OA2Z078sFqtcBLh
        WZ+/8D6lAw/ORCHbFAEk/Ws/Q5/e
X-Google-Smtp-Source: APXvYqwR40yQeuGw25Rn5HAO/BFrUV4ouP7oh8iBXXdtSbs2wG8RhhpHgwiwboMJY0GSoyDCq/muuA==
X-Received: by 2002:adf:eccd:: with SMTP id s13mr2856264wro.288.1568722941214;
        Tue, 17 Sep 2019 05:22:21 -0700 (PDT)
Received: from szeder.dev (x4db91871.dyn.telefonica.de. [77.185.24.113])
        by smtp.gmail.com with ESMTPSA id z189sm3513820wmc.25.2019.09.17.05.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 05:22:20 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:22:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 1/1] commit-graph: add --[no-]progress to write and
 verify.
Message-ID: <20190917122215.GA29845@szeder.dev>
References: <pull.315.git.gitgitgadget@gmail.com>
 <pull.315.v2.git.gitgitgadget@gmail.com>
 <47cc99bd151db67fe2ee0f91bb98b3eb7e55786d.1566836997.git.gitgitgadget@gmail.com>
 <20190916223607.GE6190@szeder.dev>
 <7a9581ea-dc90-5ce1-fc3b-578c6dbf6efc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a9581ea-dc90-5ce1-fc3b-578c6dbf6efc@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 17, 2019 at 06:47:38AM -0400, Derrick Stolee wrote:
> 
> On 9/16/2019 6:36 PM, SZEDER Gábor wrote:
> > On Mon, Aug 26, 2019 at 09:29:58AM -0700, Garima Singh via GitGitGadget wrote:
> >> From: Garima Singh <garima.singh@microsoft.com>
> >>
> >> Add --[no-]progress to git commit-graph write and verify.
> >> The progress feature was introduced in 7b0f229
> >> ("commit-graph write: add progress output", 2018-09-17) but
> >> the ability to opt-out was overlooked.
> > 
> >> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> >> index 99f4ef4c19..4fc3fda9d6 100755
> >> --- a/t/t5324-split-commit-graph.sh
> >> +++ b/t/t5324-split-commit-graph.sh
> >> @@ -319,7 +319,7 @@ test_expect_success 'add octopus merge' '
> >>  	git merge commits/3 commits/4 &&
> >>  	git branch merge/octopus &&
> >>  	git commit-graph write --reachable --split &&
> >> -	git commit-graph verify 2>err &&
> >> +	git commit-graph verify --progress 2>err &&
> > 
> > Why is it necessary to use '--progress' here?  It should not be
> > necessary, because the commit message doesn't mention that it changed
> > the default behavior of 'git commit-graph verify'...
> 
> It does change the default when stderr is not a terminal window. If we
> were not redirecting to a file, this change would not be necessary.

OK, yesterday I overlooked that the patch added this line:

  +       opts.progress = isatty(2);

So, the first question is whether that behavior change is desired; I
don't really have an opinion.  But if it is desired, then it should be
changed in a separate patch, explaining why it is desired, I would
think.

> >>  	test_line_count = 3 err &&
> > 
> > Having said that, this test should not check the number of progress
> > lines in the first place; see the recent discussion:
> > 
> > https://public-inbox.org/git/ec14865f-98cb-5e1a-b580-8b6fddaa6217@gmail.com/
> 
> True, this is an old issue. I think it never got corrected because
> your reply sounded like the issue doesn't exist in the normal test
> suite,

Well, the way I see it the root issue is that the test checks things
that it shouldn't.

> only in a private branch where you changed the behavior of
> GIT_TEST_GETTEXT_POISON.
> 
> If we still think that should be fixed, it should not be a part of
> this series, but should be a separate one that focuses on just
> those changes.

Yeah, it should rather go on top of 'ds/commit-graph-octopus-fix'.

