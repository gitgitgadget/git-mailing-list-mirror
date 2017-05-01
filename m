Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E55861F78F
	for <e@80x24.org>; Mon,  1 May 2017 22:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbdEAWNr (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 18:13:47 -0400
Received: from [192.252.130.194] ([192.252.130.194]:63023 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750822AbdEAWNr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 18:13:47 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id C1D4260190;
        Mon,  1 May 2017 18:13:44 -0400 (EDT)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     Git <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/4] Make diff plumbing commands respect the indentHeuristic.
Date:   Mon,  1 May 2017 18:13:41 -0400
Message-Id: <20170501221345.4025-1-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.13.0.rc1.15.gf67d331ad
In-Reply-To: <20170429131439.ohgren3i7xr4tjex@sigill.intra.peff.net>
References: <20170429131439.ohgren3i7xr4tjex@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-29 09:14 AM, Jeff King wrote:
> On Sat, Apr 29, 2017 at 08:40:52AM -0400, Jeff King wrote:
> 
>> On Fri, Apr 28, 2017 at 06:33:12PM -0400, Marc Branchaud wrote:
>>
>>> v2: Fixed up the commit messages and added tests.
>>>
>>> Marc Branchaud (2):
>>>   diff: make the indent heuristic part of diff's basic configuration
>>>   diff: have the diff-* builtins configure diff before initializing
>>>     revisions
>>>
>>> Stefan Beller (1):
>>>   diff: enable indent heuristic by default
>>
>> Thanks, these look fine to me. I'd like to get an ACK from Michael, in
>> case he had some other reason for omitting them from git_diff_ui_config
>> (from my recollection, it's probably just a mix of conservatism and
>> following what the compaction heuristic had done).
> 
> Sorry, I spoke too soon. The third one needs a few test adjustments
> squashed in to pass the tests.

Doh!  That'll teach me to try to do this stuff at the end of a Friday...

One more try, then:

Changes since v2:

  Patch 1/4 : Unchanged.

  Patch 2/4 : Mentioned how the new behaviour matches the diff Porcelain.

  Patch 3/4 : Updated the tests.

  Patch 4/4 : (New) Jeff's add--interactive patch.

Thanks for all the help, Jeff!

		M.


Jeff King (1):
  add--interactive: drop diff.indentHeuristic handling

Marc Branchaud (2):
  diff: make the indent heuristic part of diff's basic configuration
  diff: have the diff-* builtins configure diff before initializing
    revisions

Stefan Beller (1):
  diff: enable indent heuristic by default

 builtin/diff-files.c             |  2 +-
 builtin/diff-index.c             |  2 +-
 builtin/diff-tree.c              |  2 +-
 diff.c                           |  8 ++---
 git-add--interactive.perl        |  4 ---
 t/t4051-diff-function-context.sh |  3 +-
 t/t4061-diff-indent.sh           | 72 ++++++++++++++++++++++++++++++++++++++--
 7 files changed, 78 insertions(+), 15 deletions(-)

-- 
2.13.0.rc1.15.gf67d331ad

