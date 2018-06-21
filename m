Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B8971F516
	for <e@80x24.org>; Thu, 21 Jun 2018 20:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754162AbeFUUE5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 16:04:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36818 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbeFUUE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 16:04:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id v131-v6so8299351wma.1
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=d8xC6bCXKUJ57BgSjtNZO32VxGZ3KHAzl1ue+XlnyAM=;
        b=R9U85pEyhJZIIF9dN04maStlSPcpG6V7pSkrN7rmTy7USuFaqQSSuSJfIuAgMfuHlL
         o3PdvzbklCXmMX+7Qx+SQF35kM6vcQ1p97hMht8S1LtS6TdXw4se+CqDWGYPHrU9UsTl
         afeEI23n+UNy7JjLMeYgCn1nFMnt4uKLa1YfF88LcD2W9NvlXuwPsj11HK8yW3p8s8g4
         iMuCwGr/UActdCW1ayT/VnfENbprBCS8G9iMSFFiG/NFcQH/N6EVynsRqzOFMaKB8pQ2
         06kPL0SMlFjZkx6uO0Kg8LSe6y1x6ZHe7HRggu64fBmGWebJK98BckQ4fVRl6fK7ev7D
         fH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=d8xC6bCXKUJ57BgSjtNZO32VxGZ3KHAzl1ue+XlnyAM=;
        b=gsLnzKCV3iffVNcgq7NU5QBy9ONN5AsuOujKgZQDa78XOvelBOtzxEaYYZz3J79Dhi
         DrtrXrJDH80lCf2h7BAYgY2ZVCwlQimPmJY1K+G+4T5yNO2+F6sn1Jr0u+gzMFVJBjUR
         hxGV+sHfBmd5LEa5B7UlQHYinBK+9spg74ncaCl8d7ex+kdrWQETJI0WN01mKQ1/V1LQ
         kHj9SmmzXsI5xzyv2fH849LhisJDfinYeStuATHUy7MzwDCulh0I8kjKyTW8wVK6GnRd
         nW0h0MFwHkCbE+49UoYtn3pFT9MjusvxaaHb/QDGfmdLxrxPzlJNoLXRnr9Ni6+NOsuC
         Ke0A==
X-Gm-Message-State: APt69E2khZ5i3kD24+l5FB39iZyN7R8iGiSz/DTUVHBN/aO+tpkRtNHE
        KFk6y0bYMiwXYQBkLD9leiY=
X-Google-Smtp-Source: ADUXVKKcV6gPmrVfVsYou0HHTnCytVhz14JaLtXeU0zYKimIzqtbmNT0yDOdrRvbEvrrXzyRueRfsg==
X-Received: by 2002:a1c:903:: with SMTP id 3-v6mr6329181wmj.130.1529611494796;
        Thu, 21 Jun 2018 13:04:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 63-v6sm8271057wmv.48.2018.06.21.13.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 13:04:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com
Subject: Re: [PATCH v3 3/7] t3422: new testcases for checking when incompatible options passed
References: <20180617055856.22838-1-newren@gmail.com>
        <20180621150023.23533-1-newren@gmail.com>
        <20180621150023.23533-4-newren@gmail.com>
Date:   Thu, 21 Jun 2018 13:04:53 -0700
In-Reply-To: <20180621150023.23533-4-newren@gmail.com> (Elijah Newren's
        message of "Thu, 21 Jun 2018 08:00:19 -0700")
Message-ID: <xmqqvaabsy6y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> +	git checkout B &&
> +	# This is indented with HT SP HT.
> +	echo "	 	foo();" >>foo &&

I often wonder, whenever I see a need for a comment like this, if
saying the same thing in code to make it visible is cleaner and less
error prone way to do so, i.e. e.g.

	echo "_ _foo();" | tr "_" "\011" >>foo &&

> +# Rebase has lots of useful options like --whitepsace=fix, which are
> +# actually all built in terms of flags to git-am.  Since neither
> +# --merge nor --interactive (nor any options that imply those two) use
> +# git-am, using them together will result in flags like --whitespace=fix
> +# being ignored.  Make sure rebase warns the user and aborts instead.
> +#
> +
> +test_run_rebase () {
> +	opt=$1
> +	shift
> +	test_expect_failure "$opt incompatible with --merge" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --merge A
> +	"
> +
> +	test_expect_failure "$opt incompatible with --strategy=ours" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --strategy=ours A
> +	"
> +
> +	test_expect_failure "$opt incompatible with --strategy-option=ours" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --strategy=ours A
> +	"
> +
> +	test_expect_failure "$opt incompatible with --interactive" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --interactive A
> +	"
> +
> +	test_expect_failure "$opt incompatible with --exec" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --exec 'true' A
> +	"
> +
> +}
> +
> +test_run_rebase --whitespace=fix
> +test_run_rebase --ignore-whitespace
> +test_run_rebase --committer-date-is-author-date
> +test_run_rebase -C4

I happen to be from old school and "rebase" primarily means
"format-patch piped to am" in my mind, so from that point of view,
"test_run_rebase --OPT" that says "--OPT which is a valid option for
the primary operating mode of rebase does not work with the other
exotic modes of the command" is not all that bad, but I do not think
that worldview holds for many people in general.  Perhaps calling it
something like "test_rebase_am_only" makes the intent clearer?

> +test_expect_success '--preserve-merges incompatible with --signoff' '
> +	git checkout B^0 &&
> +	test_must_fail git rebase --preserve-merges --signoff A
> +'
> +
> +test_expect_failure '--preserve-merges incompatible with --rebase-merges' '
> +	git checkout B^0 &&
> +	test_must_fail git rebase --preserve-merges --rebase-merges A
> +'
> +
> +test_expect_failure '--rebase-merges incompatible with --strategy' '
> +	git checkout B^0 &&
> +	test_must_fail git rebase --rebase-merges -s resolve A
> +'
> +
> +test_expect_failure '--rebase-merges incompatible with --strategy-option' '
> +	git checkout B^0 &&
> +	test_must_fail git rebase --rebase-merges -Xignore-space-change A
> +'
> +
> +test_done
