Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4091E1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 02:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfA1CJT (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 21:09:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41884 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfA1CJS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 21:09:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so16275025wrs.8
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 18:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=dqqFojw/NsI5Rv4nAXtPVXNnsDEcOIEihsNDjruveok=;
        b=qi5E2v4UdH5o6g8pnSsMdz7ZTgNuMOiO+HUd+eH2yJtfY8dOYPO7aVtlTIpQh3y5+5
         pcYns1NbONcbqBjdVgCPaOKJyP20r7gVZ5Ib1Iu9Q8t93kbc9pA4wYohvA79e8tP2Seo
         +1IB8zy1lSGPkreMCoqwmdZnKbHATGeYNxOCRBOzyEykoNCYplemZad03t5+qusYcqMW
         e3ZHNGlJCATaSngyxB+CMIaVXesfRGo62sp/PJT+3SOKbG9UNahsxY+w6SCGFfkXlPb9
         wzw7yZzS1rOGMsibN5YII4017ezm4HNlMJvvvHo15yUSHPAqT1TDzOyZI4Ktk6xY84bH
         pGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=dqqFojw/NsI5Rv4nAXtPVXNnsDEcOIEihsNDjruveok=;
        b=Vf78Y/KLH3QwnNDcJIulu//sU7G7CWN/JCzdLNxU+YSfYAheyHH7qwWC/v5sanL9NS
         BNOLBgowRWSvbx/CutRt8LE9x3HWXp8svQZV5p1RAPEb5hjouQP+C6XxiiaQ+EuzChLJ
         KSCmdrCttDNavcs3Ob+R2n/nEOGwQog01mQ02q8AtHTZ1HJ59srwNq/eUAgRLvNaCbiF
         RnmTVnKqNmVmrPbLltiC+nt43Ki9mI+TlB70d+ZHPkanRdd06PYhGn5K4ii71QAq4C5z
         new7x/kbHJ2h1h1Ys7NJvqyUzXOLXO/g85N4mupJ19LCT86wozDRRBkr9oU8kSHPh9cv
         Owqg==
X-Gm-Message-State: AJcUukc1g8ZXugNYBYoD9YkY95LDGZmAm69tp5BWOJOpokOXIppZgLQ/
        EEqp7WWBTRU1CWu+0KvAees=
X-Google-Smtp-Source: ALg8bN73e0/ArSsC0NdEbjU49smua1IPbGdwq8IW0E54Kkq10O3VJ+/5fk5AqlMzI/b9LT6OWtQvjg==
X-Received: by 2002:adf:8342:: with SMTP id 60mr18181071wrd.212.1548641356523;
        Sun, 27 Jan 2019 18:09:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n124sm4114315wmd.15.2019.01.27.18.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 18:09:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 18/21] t0061: fix with --with-dashes and RUNTIME_PREFIX
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <d613c79aff9c65ab9c3723a876c99e6f35a2f133.1548254412.git.gitgitgadget@gmail.com>
Date:   Sun, 27 Jan 2019 18:09:15 -0800
Message-ID: <xmqq36pdcz3o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When building Git with RUNTIME_PREFIX and starting a test helper from
> t/helper/, it fails to detect the system prefix correctly.
>
> This is the reason that the warning
>
> 	RUNTIME_PREFIX requested, but prefix computation failed. [...]
>
> to be printed.
>
> In t0061, we did not expect that to happen, and it actually did not
> happen in the normal case, because bin-wrappers/test-tool specifically
> sets GIT_TEXTDOMAINDIR (and as a consequence, nothing in test-tool wants
> to know about the runtime prefix).
>
> However, with --with-dashes, bin-wrappers/test-tool is no longer called,
> but t/helper/test-tool is called directly.
>
> So let's just ignore the RUNTIME_PREFIX warning.

Two questions that would come to the readers' minds are

 - Why "it fails to detect the system prefix correctly"?  Is that a
   bug waiting to hurt end users?

 - Why is it better not to bother fixing that failure?  Is it
   because this happens only in the test helper and won't hurt end
   users?

I do not mind this particular "sweeping it under the rug" if the
rationale is "it only is the strange set-up of test-tool that causes
it, and we shouldn't burden the code shared with the actual runtime
to compute runtime prefix just to fix this bug".  I do think it is
not productive to bend backwards if it is only done in order to work
around unusual setup in the test helper binary and I do agree that
ignoring the warning is the right solution.

I just do not like to see that our commits do not explain why we
chose to ignore, instead of "fix", the issue.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t0061-run-command.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> index 99a614bc7c..5a2d087bf0 100755
> --- a/t/t0061-run-command.sh
> +++ b/t/t0061-run-command.sh
> @@ -166,7 +166,8 @@ test_trace () {
>  	expect="$1"
>  	shift
>  	GIT_TRACE=1 test-tool run-command "$@" run-command true 2>&1 >/dev/null | \
> -		sed -e 's/.* run_command: //' -e '/trace: .*/d' >actual &&
> +		sed -e 's/.* run_command: //' -e '/trace: .*/d' \
> +			-e '/RUNTIME_PREFIX requested/d' >actual &&
>  	echo "$expect true" >expect &&
>  	test_cmp expect actual
>  }
