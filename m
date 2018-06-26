Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B041F516
	for <e@80x24.org>; Tue, 26 Jun 2018 18:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeFZSRO (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 14:17:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36819 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbeFZSRD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 14:17:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id u18-v6so2839097wmc.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 11:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wmq1hqpw3rPRx31dr/yoPLrVf20GfqkfUVWFh0zo9pc=;
        b=muRSKx9E0RNtRK8vKUs2iO6/uAgac/KJFgSlCrbxlWZgWgMaFe204Rm+DBbwtv4iZN
         tvi9z0hi077fMOeq3e9D2YYH6uVZL+v7OSPweMGPhIrJYsaGfF/c/e5MgP1c5vSi9cRe
         oKWjJDyrMykDW8IJ2nE5khNb1JRDZIV9TG5+MjuhZ00Ua9yhkUY67k2JnrWYBBU+Rf6o
         2607p7ln+h0eo3BuTfuORhIV0wXo0JQQCdTi68iNOkNZWxBtdlHd+OnSInmrGNxshfP3
         zWBcoFhRxOdPEDw8RSWldK2v91s+i+zbi15meRTlMQ32qoavh+ZyQwrhpNdAhg4mHWlV
         Ncag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wmq1hqpw3rPRx31dr/yoPLrVf20GfqkfUVWFh0zo9pc=;
        b=EoiIHkbnjlzxGkd7fkfsxmM1tvO4PsjaEx8roTn7rIeVI/3flMRnWghOP7uJO3KOXf
         bsbajoJQ+t3eQJc16gdpHWxe8h8cLbfk2GwNkk5MKuMclCGNnCaors74pO42JcOJLkRv
         RCm/Or1E6Wf+6ct7gDe5uF9zH3pVC1t0moiEpjNPZkztLDdGdUwcLP9cH0rP567nDEeB
         9JMyPg1VBYTQM0zhuGLwzwFZ7dR3Z7M5DRmxeDvvZNNS9yPeFtz0azgn0yngyPnUTbfY
         joYXVPjZzO5ynbCJLHLO2yo8xk1wsibdb+3Sy1EUu7wANnseCbvIverhRb2/eIz47p26
         L38Q==
X-Gm-Message-State: APt69E2EFONsXeMd+P50T1gOClBWnJRKhQoea9/C1xArU8f/HDPUKUIm
        3x9xLlnVk1tZzSYiixxu6ps=
X-Google-Smtp-Source: AAOMgpcZdafnRtoVjiOMLGJLQdD+sgfFBHs/c9wxGCSOpteIv6OxVyiNlcLZs358ac0z92v/fl7mnA==
X-Received: by 2002:a1c:d681:: with SMTP id n123-v6mr2374380wmg.158.1530037022378;
        Tue, 26 Jun 2018 11:17:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p5-v6sm2878356wre.83.2018.06.26.11.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 11:17:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v4 3/9] t3422: new testcases for checking when incompatible options passed
References: <20180621150023.23533-1-newren@gmail.com>
        <20180625161300.26060-1-newren@gmail.com>
        <20180625161300.26060-4-newren@gmail.com>
Date:   Tue, 26 Jun 2018 11:17:00 -0700
In-Reply-To: <20180625161300.26060-4-newren@gmail.com> (Elijah Newren's
        message of "Mon, 25 Jun 2018 09:12:54 -0700")
Message-ID: <xmqqk1qll8f7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> +# Rebase has lots of useful options like --whitepsace=fix, which are
> +# actually all built in terms of flags to git-am.  Since neither
> +# --merge nor --interactive (nor any options that imply those two) use
> +# git-am, using them together will result in flags like --whitespace=fix
> +# being ignored.  Make sure rebase warns the user and aborts instead.
> +#
> +
> +test_rebase_am_only () {
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

This line is broken and it is carried over to later patches.  It
needs to be -Xours (or --strategy-option=ours, if we really want ot
be verbose).

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
> +test_rebase_am_only --whitespace=fix
> +test_rebase_am_only --ignore-whitespace
> +test_rebase_am_only --committer-date-is-author-date
> +test_rebase_am_only -C4

I was hesitant to hardcode what I perceive as limitations of non-am
rebase implementations with a test like this, but once somebody
fixes "rebase -i" for example to be capable of --whitespace=fix for
example, then we can just drop one line from the above four (and
write other tests for "rebase -i --whitespace=fix").  The
test_rebase_am_only is to help us make sure what is (still) not
supported by non-am rebases gets diagnosed as an error.

So my worry is totally unfounded, which is good.

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
