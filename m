Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8D01FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 20:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753084AbdLHU0c (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 15:26:32 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:31853 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbdLHU0b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 15:26:31 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id NPE5evoYtAp17NPE5elN35; Fri, 08 Dec 2017 20:26:30 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=5rxgeBVgAAAA:8
 a=xtxXYLxNAAAA:8 a=ybZZDoGAAAAA:8 a=f0J4QF_wgYAcVRAD5vYA:9 a=wPNLvfGTeEIA:10
 a=0XOFGUN2hUcA:10 a=PwKx63F5tFurRwaNxrlG:22 a=xts0dhWdiJbonKbuqhAr:22
 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <582105F8768F4DA6AF4EC82888F0BFBE@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git List" <git@vger.kernel.org>
References:  <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de><5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de><xmqqtvxd6gu9.fsf@gitster.mtv.corp.google.com><5A1E70AA020000A100029175@gwsmtp1.uni-regensburg.de><7973FF5C21C64E6492828DD0B91F5AF7@PhilipOakley> <xmqq1skcleo7.fsf@gitster.mtv.corp.google.com> <AB9C836772CD4391A8866DC71103CCFE@PhilipOakley> <5A25705C020000A1000292B0@gwsmtp1.uni-regensburg.de>
Subject: Re: Re: bug deleting "unmerged" branch (2.12.3)
Date:   Fri, 8 Dec 2017 20:26:27 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171208-2, 08/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfLpaPoTRMbfmzlnyCcJ5KP3HNv1zN479Ya5MBdHh+GzY6/H/aTlcnGH9+ULjvSMZAawYpfbUjDiTExPRnaMb/y0Xe+B2osCFdh5WOUd4kbJJoU1iDzBB
 E3hm36uGoCsFoZEKS7BTcvTTbQN/yHXyUlOeAdWfbl2SnuSYajKsRX9yfQrkmnZx9JMWATaJ9P/mtZOad6+hEiDHruZC9d3VwQCq1DQRwg6J0RT/CuGLgiNG
 UX3qWAidHLy01x/n3mllSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
> Hi Philip!
>
> I'm unsure what you are asking for...
>
> Ulrich

Hi Ulrich,

I was doing a retrospective follow up (of the second kind [1]).

In your initial email
https://public-inbox.org/git/5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de/
you said

"I wanted to delete the temporary branch (which is of no use now), I got a
message that the branch is unmerged.
I think if more than one branches are pointing to the same commit, one
should be allowed to delete all but the last one without warning."

My retrospectives question was to find what what part of the documentation
could be improved to assist fellow coders and Git users in gaining a better
understanding here. I think it's an easy mistake [2] to make and that we
should try to make the man pages more assistive.

I suspect that the description for the `git branch -d` needs a few more
words to clarify the 'merged/unmerged' issue for those who recieve the
warning message. Or maybe the git-glossary, etc. I tend to believe that most
users will read some of the man pages, and would continue to do so if they
are useful.

I'd welcome any feedback or suggestions you could provide.
--
Philip

> >>> "Philip Oakley" <philipoakley@iee.org> 04.12.17 0.30 Uhr >>>
> From: "Junio C Hamano" <gitster@pobox.com>
> > "Philip Oakley" <philipoakley@iee.org> writes:
> >
> >> I think it was that currently you are on M, and neither A nor B are
> >> ancestors (i.e. merged) of M.
> >>
> >> As Junio said:- "branch -d" protects branches that are yet to be
> >> merged to the **current branch**.
> >
> > Actually, I think people loosened this over time and removal of
> > branch X is not rejected even if the range HEAD..X is not empty, as
> > long as X is marked to integrate with/build on something else with
> > branch.X.{remote,merge} and the range X@{upstream}..X is empty.
> >
> > So the stress of "current branch" above you added is a bit of a
> > white lie.
>
> Ah, thanks. [I haven't had chance to check the code]
>
> The man page does say:
> .    -d
> .    Delete a branch. The branch must be fully merged in its upstream
> .    branch, or in HEAD if no upstream was set with --track
> .    or --set-upstream.
>
> It's whether or not Ulrich had joined the two aspects together, and if the
> doc was sufficient to help recognise the 'unmerged' issue. Ulrich?
> --
> Philip
>
>

[1] Retrospective Second Directive, section 3.4.2 of (15th Ed) Agile
Processes in software engineering and extreme programming. ISBN 1628251042
(for the perspective of the retrospective..)
[2] 'mistake' colloquial part of the error categories of slips lapses and
mistakes : Human Error, by Reason (James, prof) ISBN 0521314194 (worthwhile)

