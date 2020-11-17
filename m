Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AD5C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 204C824181
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgKQVHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:07:23 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:56892 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKQVHW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:07:22 -0500
X-Greylist: delayed 1112 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 16:07:22 EST
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kf7tx-000D6n-8N; Tue, 17 Nov 2020 13:48:33 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kf7tr-005K0t-QU; Tue, 17 Nov 2020 13:48:32 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 14:48:10 -0600
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 12 Nov 2020 22:43:30
        +0000")
Message-ID: <87r1oraewl.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kf7tr-005K0t-QU;;;mid=<87r1oraewl.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1849PZCZPHXrV7s/DTvl5eeF1uVodgB6Sw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 00/28] Use main as default branch name
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is the big one. This changes the default of init.defaultBranch to main,
> reflecting what many open source projects already did (which was followed by
> GitHub, Azure Repos and others).

Can we please not simply replace one hard coded branch name with
another?

Having a blessed name for the initially created branch continues to
imply the branch has special significance.  As the initially created
branch does not have special significance can we please do
something that does not imply that?

Instead of having a fixed name across all repos for the initially
created branch can we instead use the directory name of the repo for the
branch name?

Advantages:

- The branch name that is somewhat meaningful to the creator of the git
  repo.

  I have at least two repos where I wound up doing this by hand.  So at
  least for me it is something I am doing anyway.

- Tools can not hard code the name of an initially created branch and
  expect it to work.

  This moves us farther from the realm of people assuming incorrectly
  that there is something special about the branch created by default.

- As the name is somewhat meaningful.  This change to the initial branch
  name becomes something that can be argued is a technical improvement
  rather than a simple political statement.

At least for my usage main is a pretty huge misnomer as I barely use the
branch with the master.  Renaming my unused branch main implies that I
am using the tool wrong.


I don't look in on the git list very often so perhaps I am missing a
conversation where all of the details were thought through.  If so
please point me at that conversation.  Otherwise can we please use this
opportunity to come up with something that is actually better than
naming the default branch main, rather than just something just as
awkward whose only advantage is that people don't think it is
politically incorrect this week.

Eric
