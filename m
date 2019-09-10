Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C641F463
	for <e@80x24.org>; Tue, 10 Sep 2019 19:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfIJTVN (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 15:21:13 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53447 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfIJTVN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 15:21:13 -0400
X-Originating-IP: 1.186.12.58
Received: from localhost (unknown [1.186.12.58])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 8E98BE0006;
        Tue, 10 Sep 2019 19:21:09 +0000 (UTC)
Date:   Wed, 11 Sep 2019 00:51:07 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v3 0/4] git-gui: Add ability to revert selected hunks and
 lines
Message-ID: <20190910192107.umew74b4mj2vyrd4@yadavpratyush.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190828215725.13376-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828215725.13376-1-me@yadavpratyush.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes, Bert, All,

If there are no further objections with the series, I will merge it in.

On 29/08/19 03:27AM, Pratyush Yadav wrote:
> Hi,
> 
> This series adds the ability to revert selected lines and hunks in
> git-gui. Partially based on the patch by Bert Wesarg [0].
> 
> The commits can be found in the topic branch 'py/revert-hunks-lines'
> at https://github.com/prati0100/git-gui/tree/py/revert-hunks-lines
> 
> Changes in v3:
> - Drop the confirmation dialog on partial reverts. It is still there for
>   full file reverts (which was the original behaviour).
> - Allow undoing the last revert.
> - Update the context menu button layout. In v2, the layout was:
>    Stage Hunk
>    Revert Hunk
>    Stage Lines
>    Revert Lines
> 
>   Now it is:
>    Stage Hunk
>    Stage Lines
>    -----------
>    Revert Hunk
>    Revert Lines
>    Undo Last Revert
> - Return early when applying a patch fails. This is useful for this
>   series because in that case we don't save a faulty patch in
>   last_revert, causing the same error to pop up when reverting the patch
>   that failed to apply in the first place.
> 
> Changes in v2:
> - Add an option to disable the revert confirmation prompt as suggested
>   by Johannes Sixt.
> - Base the patches on Pat's git-gui tree instead of git.git.
> 
> [0]
> https://public-inbox.org/git/a9ba4550a29d7f3c653561e7029f0920bf8eb008.1326116492.git.bert.wesarg@googlemail.com/
> 
> Pratyush Yadav (4):
>   git-gui: allow reverting selected lines
>   git-gui: allow reverting selected hunk
>   git-gui: return early when patch fails to apply
>   git-gui: allow undoing last revert
> 
>  git-gui.sh   | 57 +++++++++++++++++++++++++++++--
>  lib/diff.tcl | 96 ++++++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 135 insertions(+), 18 deletions(-)
> 
> --
> 2.21.0
> 

-- 
Regards,
Pratyush Yadav
