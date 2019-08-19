Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE6F1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 10:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfHSKwB (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 06:52:01 -0400
Received: from elephants.elehost.com ([216.66.27.132]:36468 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfHSKwA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 06:52:00 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x7JApt7K084766
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Aug 2019 06:51:56 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Ed Avis'" <eda@waniasset.com>, <git@vger.kernel.org>
References: <a3a66e58b1e44e88b9c11655c7c77e87@WCL-EX13MBX.wcl.local>
In-Reply-To: <a3a66e58b1e44e88b9c11655c7c77e87@WCL-EX13MBX.wcl.local>
Subject: RE: git switch and restore user interface
Date:   Mon, 19 Aug 2019 06:51:48 -0400
Message-ID: <00f701d5567c$1d9fe810$58dfb830$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIjSyI5ouj6m/Z5LvLjuC9XQng/+qZmYTig
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 19, 2019 5:41 AM, Ed Avis wrote:
> To: git@vger.kernel.org
> Subject: git switch and restore user interface
> 
> I think it would be helpful for git switch to print a reminder of the old
and
> new branches.
> 
> Hi, a couple of suggestions for these experimental new commands.  Git
> switch should print the branch you are leaving:
> 
> % git switch foo
> You were previously on branch bar (abcdef).
> You are now on branch foo (bcdef0).
> 
> Sometimes I forget what branch I was on before and having it in the
terminal
> history would help a lot.
> 
> 
> For git restore, it might be worth splitting the command further, into
'safe
> restore' and 'destructive restore'.  The safe command would always stop
> rather than lose data:
> 
> % git safe-restore .
> The following local changes would be overwritten:
>    Fee.c
>    Foe.c
> Stash them first, or (etc etc).
> 
> The command that unconditionally overwrites working copy changes should
> be given a different and more dangerous-sounding name.
> 
> The reason I suggest this is to make sure of a sensible answer to the
> newcomer's question: "I just deleted a file by mistake in my working copy,
> how do I get it back from git?".  Too often at the moment the answer is
"git
> checkout ." which while correct is also much too dangerous to be a first
> resort.  There should be an obvious and safe command for restoring missing
> files without losing local changes.
> 
> In fact, I'd be quite happy for it to be like git clean, which in the
default
> configuration requires some flag like -f to make it lose any local
changes,
> even though the very purpose of git clean is to delete files.

I would be happier to have git restore --stash or some configuration option,
like restore.stash=auto that has git automatically stash on a restore. But
would the stash include everything or just the paths you are restoring? It
might be nice to teach git clean the same option.

Cheers,
Randall

