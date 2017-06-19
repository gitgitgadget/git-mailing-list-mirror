Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AD7920401
	for <e@80x24.org>; Mon, 19 Jun 2017 04:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750882AbdFSE3U (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 00:29:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36833 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbdFSE3T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 00:29:19 -0400
Received: by mail-pf0-f193.google.com with SMTP id y7so14868192pfd.3
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 21:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=exWwKVoI0FUTq/gHP3KmEKqMO8qQNNZa9Kjhng8s+00=;
        b=YnzwfqrmG7cSfpY4l5M8Y02Srv0TowbNzuMRBIlw6artHCDCqeUDGlU3OvwxNzNvCa
         mZkfrDOj9McO/2B5dMI2xN/4g5r1WmS+M6T1sXbnapmvgTvypOmJK2WBwB9hrbR74okc
         j3aT86Fo+O22VmHK6rCJPUHvXlxcMqVb2/W9jlJCSJHqz4k5dlvhyyA8Aba769WUoIkO
         91USCCudN/FoIfbKfn0juLaTHgFhbaAFW7uOZ56L2N7KSGKF8tgNo4Ncb2UIvy4/sQ6i
         s3N33IfhZRA8LNSFLILSITrl6auwu9Qgk4WAzMLDzSI09HOuRw/UdxiCxHwTZul/Ds9V
         pR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=exWwKVoI0FUTq/gHP3KmEKqMO8qQNNZa9Kjhng8s+00=;
        b=ADPFFmogr5gwgkKVSDACRkk9RgfPXOqHlhQL42bBBehwNeXaMU3ajoolW+u6SQl67K
         PHBitXB3/IsPtXWtiQ4iqf5lP4mAcXZBxUoPWYJwMInDh/I03QsvUbNReAZRq8YLy+R1
         +XIOXhe1FubtvGydTHnDfwLsMmJq6e/c/1RLpRYzZkA5Poe/nLXsLoL1HsEqycSWbAJb
         VK2qLE9bZiGmxosL/RLOt7MbSNosTR90pvEI5sZN2DS7NoxtE/53wH391sop15BYLz/9
         HQi79Bg5vbEo6AxDJx2kjis+vj3FP9f+Ohimtt3u3si2qJvV5OqDpGxgqYL9bdb7o0Ce
         Br9A==
X-Gm-Message-State: AKS2vOxdmAX8AKzfcWA7RMl0z4EbByIVx3ByGUmh+yiQ1ct30g59HtW5
        6FQiA/HPsfPwdA==
X-Received: by 10.84.217.152 with SMTP id p24mr3082886pli.276.1497846558629;
        Sun, 18 Jun 2017 21:29:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec96:eb20:667b:9e2b])
        by smtp.gmail.com with ESMTPSA id x3sm23831280pgx.29.2017.06.18.21.29.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 18 Jun 2017 21:29:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     avarab@gmail.com, peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH 1/2] Contextually notify user about an initial commit
References: <87shix8zik.fsf@gmail.com>
        <20170619024123.5438-1-kaarticsivaraam91196@gmail.com>
Date:   Sun, 18 Jun 2017 21:29:17 -0700
In-Reply-To: <20170619024123.5438-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 19 Jun 2017 08:11:23 +0530")
Message-ID: <xmqqlgoovbvm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> A few alternatives considered were,
>
> * Waiting for initial commit
> * Your current branch does not have any commits
> * Current branch waiting for initial commit
>

... "Decided to take the most succinct one." or something to
conclude what happend to these alternatives would be nice to spell
out as a conclusion here.

> Patch-derived-from: Junio C Hamano <gitster@pobox.com>

That's just "Helped-by:".

> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>   Hope this would be final :)
>
>  builtin/commit.c | 1 +
>  wt-status.c      | 5 ++++-
>  wt-status.h      | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)


Thanks.  
Have you run the full test suite after applying this patch?

Adjustment to existing tests to update their expectation would be a
good thing to have in this patch that would easily illustaret what
will change and how.

At least this would be needed; there may be other breakages.


diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 0b6da7ae1f..fa61b1a4ee 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -18,7 +18,7 @@ test_expect_success 'initial status' '
 	echo bongo bongo >file &&
 	git add file &&
 	git status >actual &&
-	test_i18ngrep "Initial commit" actual
+	test_i18ngrep "No commits yet" actual
 '
 
 test_expect_success 'fail initial amend' '
