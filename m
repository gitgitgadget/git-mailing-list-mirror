Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 802BB1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 11:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfAWLiL (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 06:38:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:56333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbfAWLiL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 06:38:11 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgvEY-1haTW91Jxe-00oGTL; Wed, 23
 Jan 2019 12:38:03 +0100
Date:   Wed, 23 Jan 2019 12:38:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matthew Kraai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH 1/1] stash: fix segmentation fault when files were added
 with intent
In-Reply-To: <xmqqd0ooh79n.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901231236060.45@tvgsbejvaqbjf.bet>
References: <pull.110.git.gitgitgadget@gmail.com>        <b5bbc7793c50991c7cb5a5188f53ccc3a14b23f6.1547805015.git.gitgitgadget@gmail.com>        <xmqq5zulk88e.fsf@gitster-ct.c.googlers.com>        <nycvar.QRO.7.76.6.1901211556150.41@tvgsbejvaqbjf.bet>
 <xmqqd0ooh79n.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Q4KtP4N99/anxJAHwODhg9MlVxG/JueHBbW+VU/vjemsR0HWAom
 /cgsdCU+fITh+1qdbEpktgG+PI68KdC0lLV6eVfQ6kkAWy7bmX3zq5mfp5bchFikw8I69hc
 guTteK2Q90P8HReH8R73NpFEf1Vl+m4IdEi4bXF2V4kbNXdU2pM5cvV1WwMu9LF183uEZld
 qgdqi7UfJ1iPl99tdxtVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O5JiwZuQTWs=:JZL1LWVpJ8WHGoECmBkKnj
 ARme93Cq3EngNLbFy48mCBoMR489yMM28v+SZbWBPv0GeFzskFs1ErvWkxoLXgDujQmlHKHR2
 r2VioNYe0zXCLdOhcU2b6e7MChtSTa5cgLvKwSOD4G+rWwqWPKnAhQ5RT8TTsHZKutfIiHGFH
 7rHwE1QaiSKDThrXiYjDeoXntYAGhr+o78+H46PipdyVLm9wfp4alhLUyjdEYjV5c/xLlLdM7
 OULeJhL+dpPaqGOXAigUwIJKMfV03I+/NAWviJduhtx6NOWOg+x/YSG5X2H87HwVpUPtaWpyj
 9mT5uodXuuhGA1r9dWVXtqbi5DuYLtI+PC9VJmAQtKwJchjbLd0aydHPFBnMahEzNWoHDwlu0
 fGtTgpi+io9je/fNlllwK2yDKIhz+ZrIgq0coxoRHCHYhUgrtk1+2cXqpZOns6quXbPIc8Rpx
 DcsfYSPRdmma0uzFIfM9Ds5af7LPQJy9cq/vKO7CJ4RJ4LSku2fA7CWdx/VNyFF9kgaVQaWZQ
 CkKnvw+Xj2sNdouJR2QFQGZws1X23fct7rQLHlrKED1n+cGngJ+WUvVmxuAG8xfslhiF9OyR/
 uh7S5spXoOj3JMyGok+GjTQSzXwApC5ih/n522RGZSxC5a+OGfatnZ6P4t8c1UVnB5Uh9uFAq
 MD2coEyXK6kCnPnGMfafKgYIOK26In/E4FC6lawsJRK+HDOuc6tH3osW6g+rCPJNaDJNYdIlh
 ZINAoixAtSZKKyO++wrYlx2vvui8kgFRCAku2dCbJ+5RVvfTlitAlCT7n5HfAR7PNCN/aLEp6
 y2L54pKqSuMuLWj24ZA7b8mdvGMmvkds1qJpI2pt78/I7y+mCJ+rWpQSiHiuqsS82QyVptnRV
 XP/9mO11tBhCI/yEo0UpaO3rRNPdIvJt38dG7CQAAA6xT2GhhV3w2o3w/fQYUp66kMuPbw7KZ
 3khFwxrg3pQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 22 Jan 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > when I want to see whether a given branch is buggy and when I cannot
> > simply `git cherry-pick <commit-demonstrating-a-bug>`:
> >
> > 	git cherry-pick <commit-fixing-the-bug-and-adding-a-test>
> > 	git checkout HEAD^ -- :^/t/
> 
> Yup.  It is easy to just apply the t/ part to grab the test update
> to see breakage (which I already said when I told you to have a fix
> and test protecting the future breakage of the fix in a single patch
> long time ago).

Sorry, that was not my point.

My point is that

	git cherry-pick <commit-fixing-the-bug-and-adding-a-test>
	git checkout HEAD^ -- :^/t/

is *ridiculously* less intuitive than

	git cherry-pick <commit-demonstrating-a-bug>

and I would rather you stop promoting the former over the latter. After
all, Git's purpose in life is to make things easier and quicker and less
error-prone, rathern than slower, more complicated and unintuitive.

And I am sure you agree with me on that goal, so I do not understand why
you promote that a bit more.

Ciao,
Dscho
