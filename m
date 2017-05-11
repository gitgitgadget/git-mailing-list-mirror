Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053D3201A0
	for <e@80x24.org>; Thu, 11 May 2017 21:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755815AbdEKVcv (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 17:32:51 -0400
Received: from smtp74.iad3a.emailsrvr.com ([173.203.187.74]:49473 "EHLO
        smtp74.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755796AbdEKVcu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 May 2017 17:32:50 -0400
Received: from smtp10.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp10.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id C674A65A1;
        Thu, 11 May 2017 17:32:49 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp10.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C74266542;
        Thu, 11 May 2017 17:31:45 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 11 May 2017 17:31:45 -0400
Subject: Re: What's cooking in git.git (May 2017, #03; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <ac2f1563-735e-9a07-e762-5dda0630304e@xiplink.com>
Date:   Thu, 11 May 2017 17:31:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-05-10 01:18 AM, Junio C Hamano wrote:
>
> * mb/diff-default-to-indent-heuristics (2017-05-09) 4 commits
>  - add--interactive: drop diff.indentHeuristic handling
>  - diff: enable indent heuristic by default
>  - diff: have the diff-* builtins configure diff before initializing revisions
>  - diff: make the indent heuristic part of diff's basic configuration
>
>  Make the "indent" heuristics the default in "diff" and diff.indentHeuristics
>  configuration variable an escape hatch for those who do no want it.

Typo fixes:
	s/heuristics/heuristic/  (both places)
	s/do no want/do not want/

>  Kicked out of next; it seems it is still getting review suggestions?

I believe v4 of this one is ready to cook.

The most salient aspect of the review discussion was about where to go 
after this topic is applied.  We also concluded that the topic deserves 
a release note about breaking patch ID backwards-compatibility.  I think 
such a note should mention rerere, so I would suggest the following:

The diff "indent" heuristic is now enabled by default.  This changes the 
patch IDs calculated by git-patch-id (and used by git-rerere and 
git-cherry), which could affect workflows that rely on 
previously-computed patch IDs.  The heuristic can be disabled by setting 
diff.indentHeuristic to false.

		M.

