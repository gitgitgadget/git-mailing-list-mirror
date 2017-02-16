Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9FF1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 20:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbdBPUjw (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 15:39:52 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34328 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933086AbdBPUjv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 15:39:51 -0500
Received: by mail-pg0-f68.google.com with SMTP id v184so2863709pgv.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 12:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zkzXsN/djBVR2OtFGnY6+y8f/hhe+TEj6Dhayc0gFIE=;
        b=gfnbK6IrBS26W7PyTeXTx3nI9Cg+9IdfbtpIV9Dz0e5nXxvjO9/M4Wr9Fyp9lEQvKK
         b6THwssmRW9FkPjVxyFCfGIb94Fefu5eLk/drWpvwANwm3YbFAELH2AbErj1e9UpSChN
         Zk6CviiOQ1RbW1Y5eRtN/o0gsRZCr+AOKToS+HkswSFQhiWFfW/4rQN7ik7faJzy1+Gr
         z0YkiPCvwSjIZXpn/qbWGdWrnretU+dKlICYRxju+ZwXlNGySS14CcWwkar8zafg/2sm
         08QZ7CYCG4Y35O0pYzrM+MFiMzFT2nSzkXr/cO/y2XFX2pM5VeAIWnjYpMZyoEmXt5fV
         GmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zkzXsN/djBVR2OtFGnY6+y8f/hhe+TEj6Dhayc0gFIE=;
        b=qZdWuYB3heTQ6QvqQCtcQluLl30UHkM5wwpcLkCf8ALLQjWoekd1IH7y1zRI5yyAMx
         nwljJgjE/OGaU5m8MQhc1FUu/DEtvgMvL6s4Sn4RIvsM64qWAvJ8R2CuKTOf3aFNhJec
         76VrBkQjPOcj2iQj7kJekRrKeZxCWZNTy3qMHiLoP/5N2BsK/TlxPboBQW4nwBpXYAx5
         pjiuN0OmF9yCEESyCv4rfzQVM5jXLXJv/AMms1Z4gWVHMbXLDclK1APFhqhzutaW3Tlj
         dmjL9euwh9FZfbph+VNc2jprVhg1iYPoI/HssEII+3ui+9BPt/ymUW3W75GWZVcMTH0K
         kEpw==
X-Gm-Message-State: AMke39ljrHdUg/YJvZ56Qaa76UdFqkz1fsuT1iXdEkfmibhbXZ3zSKDEYQshcE2Tux9fbg==
X-Received: by 10.84.231.205 with SMTP id g13mr5952221pln.30.1487277590515;
        Thu, 16 Feb 2017 12:39:50 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id q19sm15281679pfl.21.2017.02.16.12.39.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 12:39:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     unlisted-recipients:; (no To-header on input) git@vger.kernel.org,
        sandals@crustytoothpaste.net, jrnieder@gmail.com, bmwill@google.com
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)git@vger.kernel.org
                                                                     ^-missing end of address
Subject: Re: [PATCH 03/15] lib-submodule-update.sh: define tests for recursing into submodules
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
        <20170216003811.18273-1-sbeller@google.com>
        <20170216003811.18273-4-sbeller@google.com>
Date:   Thu, 16 Feb 2017 12:39:47 -0800
In-Reply-To: <20170216003811.18273-4-sbeller@google.com> (Stefan Beller's
        message of "Wed, 15 Feb 2017 16:37:59 -0800")
Message-ID: <xmqqlgt5x430.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Currently lib-submodule-update.sh provides 2 functions
> test_submodule_switch and test_submodule_forced_switch that are used by a
> variety of tests to ensure that submodules behave as expected. The current
> expected behavior is that submodules are not touched at all (see
> 42639d2317a for the exact setup).
>
> In the future we want to teach all these commands to properly recurse
> into submodules. To do that, we'll add two testing functions to
> submodule-update-lib.sh test_submodule_switch_recursing and
> test_submodule_forced_switch_recursing.

I'd remove "properly" and insert a colon after "add two ... to
submodule-update-lib.sh" before the names of two functions.

> +reset_work_tree_to_interested () {
> +	reset_work_tree_to $1 &&
> +	# indicate we are interested in the submodule:
> +	git -C submodule_update config submodule.sub1.url "bogus" &&
> +	# also have it available:
> +	if ! test -d submodule_update/.git/modules/sub1
> +	then
> +		mkdir submodule_update/.git/modules &&

Would we want "mkdir -p" here to be safe?

> +		cp -r submodule_update_repo/.git/modules/sub1 submodule_update/.git/modules/sub1

... ahh, wouldn't matter that much, we checked that modules/sub1
does not exist, and as long as nobody creates modules/ or modules/somethingelse
we are OK.

> +	fi
> +}
> +

> @@ -695,3 +736,443 @@ test_submodule_forced_switch () {
>  		)
>  	'
>  }
> +
> +# Test that submodule contents are correctly updated when switching
> +# between commits that change a submodule.
> +# Test that the following transitions are correctly handled:
> +# (These tests are also above in the case where we expect no change
> +#  in the submodule)
> +# - Updated submodule
> +# - New submodule
> +# - Removed submodule
> +# - Directory containing tracked files replaced by submodule
> +# - Submodule replaced by tracked files in directory
> +# - Submodule replaced by tracked file with the same name
> +# - tracked file replaced by submodule

These should work without trouble only when the paths involved in
the operation in the working tree are clean, right?  Just double
checking.  If they are dirty we should expect a failure, instead of
silent loss of information.

> +# New test cases
> +# - Removing a submodule with a git directory absorbs the submodules
> +#   git directory first into the superproject.
> +
> +test_submodule_switch_recursing () {
> +	command="$1"

The dq-pair is not strictly needed on the RHS of the assignment, but
it is a good way to signal that we considered that we might receive
an argument with $IFS in it...

> +	######################### Appearing submodule #########################
> +	# Switching to a commit letting a submodule appear checks it out ...
> +	test_expect_success "$command: added submodule is checked out" '
> +		prolog &&
> +		reset_work_tree_to_interested no_submodule &&
> +		(
> +			cd submodule_update &&
> +			git branch -t add_sub1 origin/add_sub1 &&
> +			$command add_sub1 &&

... and after doing so, not quoting $command here signals that we
expect command line splitting to happen.  Am I reading it correctly?
Without an actual caller appearing in this step, it is rather hard
to judge.

> +			test_superproject_content origin/add_sub1 &&
> +			test_submodule_content sub1 origin/add_sub1
> +		)
> ...
> +	# ... but an ignored file is fine.
> +	test_expect_success "$command: added submodule removes an untracked ignored file" '
> +		test_when_finished "rm submodule_update/.git/info/exclude" &&
> +		prolog &&
> +		reset_work_tree_to_interested no_submodule &&
> +		(
> +			cd submodule_update &&
> +			git branch -t add_sub1 origin/add_sub1 &&
> +			: >sub1 &&
> +			echo sub1 > .git/info/exclude

    ">.git/info/exclude"

> +			$command add_sub1 &&
> +			test_superproject_content origin/add_sub1 &&
> +			test_submodule_content sub1 origin/add_sub1
> +		)
> +	'

