Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81C3B1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 22:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754478AbdKJW1P (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 17:27:15 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:4476 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754215AbdKJW1O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 17:27:14 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id DHlZeuj6wbjdZDHlZe32px; Fri, 10 Nov 2017 22:27:13 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=tkCzZDENlpICL8MLVJEA:9 a=wPNLvfGTeEIA:10
Message-ID: <3076EE0E678D43B286F86E622CB9F06E@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Elijah Newren" <newren@gmail.com>, <git@vger.kernel.org>
Cc:     "Elijah Newren" <newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com>
Subject: Re: [PATCH 00/30] Add directory rename detection to git
Date:   Fri, 10 Nov 2017 22:27:11 -0000
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
X-Antivirus: AVG (VPS 171110-0, 10/11/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfMMUB1TCjJtJSCN4T/2cqrDPPC3XmD51DHOm60WigTYlISI+HR5WF2qVGA+4iK3s+o7Em1lK1pkEWi/TseN1xurB864+uOITXuDWeq+97xbFlZe8HM8w
 N2rUC2m+jTQIwma8yBCCIMvOKBq6Kbb2CPazJhylGVQVvstGA6Ekun6LbZpXRwHMfbSLDRIAm+PwdPjB9xEO0herhm6DWnffGI98MvkJmqAAfsGuQ1BHwGX2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Elijah Newren" <newren@gmail.com>
> [This series is entirely independent of my rename detection limits series.
> However, I have a separate rename detection performance series that 
> depends
> on both this series and the rename detection limits series.]
>
> In this patchset, I introduce directory rename detection to 
> merge-recursive,
> predominantly so that when files are added to directories on one side of
> history and those directories are renamed on the other side of history, 
> the
> files will end up in the proper location after a merge or cherry-pick.
>
> However, this isn't limited to that simplistic case.  More interesting
> possibilities exist, such as:
>
>  * a file being renamed into a directory which is renamed on the other
>    side of history, causing the need for a transitive rename.
>

How does this cope with the case insensitive case preserving file systems on 
Mac and Windows, esp when core.ignorecase is true. If it's a bigger problem 
that the series already covers, would the likely changes be reasonably 
localised?

This came up recently on GfW for `git checkout` of a branch where the case 
changed ("Test" <-> "test"), but git didn't notice that it needed to rename 
the directories on such an file system. 
https://github.com/git-for-windows/git/issues/1333

<snip>

--
Philip 

