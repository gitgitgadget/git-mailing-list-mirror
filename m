Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 218FA20C11
	for <e@80x24.org>; Sun,  3 Dec 2017 23:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbdLCXaX (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 18:30:23 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:16870 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbdLCXaW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 18:30:22 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id LdiGepB9ImITaLdiGeW38y; Sun, 03 Dec 2017 23:30:21 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=8--EbI3eyC7TKSN5xwwA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <AB9C836772CD4391A8866DC71103CCFE@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>,
        "Git List" <git@vger.kernel.org>
References: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de><5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de><xmqqtvxd6gu9.fsf@gitster.mtv.corp.google.com><5A1E70AA020000A100029175@gwsmtp1.uni-regensburg.de><7973FF5C21C64E6492828DD0B91F5AF7@PhilipOakley> <xmqq1skcleo7.fsf@gitster.mtv.corp.google.com>
Subject: Re: bug deleting "unmerged" branch (2.12.3)
Date:   Sun, 3 Dec 2017 23:30:21 -0000
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
X-Antivirus: AVG (VPS 171203-0, 03/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfOsGmNxF+D4Ivo7l5jJ5xMyKcCBkwDcoof4kPyF/4QXGx8LzNLzpRqzLnJkonnZZHN4KmJj1HMRx3CXg5/ZsPJmdgm0cWGjnl2pyPt14vs8ODZj/vHhf
 rbyhy1YgrnA0Y9pCmUVlIHaqvvAFsI57mO1UlJS9IbRqGOkyj92PXMcchuUPXS5+sJW82uIC0jnupGUXrpG/dEGCODLyOLP2xok4y9N0skNOPjny7vGIvSPv
 y0h4l7K9HizhKyW+hQNK2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> I think it was that currently you are on M, and neither A nor B are
>> ancestors (i.e. merged) of M.
>>
>> As Junio said:- "branch -d" protects branches that are yet to be
>> merged to the **current branch**.
>
> Actually, I think people loosened this over time and removal of
> branch X is not rejected even if the range HEAD..X is not empty, as
> long as X is marked to integrate with/build on something else with
> branch.X.{remote,merge} and the range X@{upstream}..X is empty.
>
> So the stress of "current branch" above you added is a bit of a
> white lie.

Ah, thanks. [I haven't had chance to check the code]

The man page does say:
.    -d
.    Delete a branch. The branch must be fully merged in its upstream
.    branch, or in HEAD if no upstream was set with --track 
.    or --set-upstream.

It's whether or not Ulrich had joined the two aspects together, and if the
doc was sufficient to help recognise the 'unmerged' issue. Ulrich?
--
Philip

