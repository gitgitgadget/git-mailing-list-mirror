Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16061F597
	for <e@80x24.org>; Tue, 17 Jul 2018 17:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbeGQSTA (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 14:19:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38727 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeGQSTA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 14:19:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so214339wmf.3
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DDjioKacl3HO1jkXORAy20kxeL1te3WxEGXYAhNzIlg=;
        b=vFmjHBgxmrhy/vv4RVOCYUQW0Qwem+EQme+toRgR2pbTcUemMf/N5rsu0fS1MCRq+6
         luqtHrVIylewyVq+TDT8TMMM5+HXXAa3oqypy3zuCea5Vtd1ocehY0IaVlscJ+YV/MBJ
         0gSMRVYz17jsXsTI2v28hCmLLTFqLsuQSELYCEAwfZwee7EKe2WHObuMTIfcpt30trRT
         yxbqyjAqZisZUGjjbBV5tpEJ5ZQZLEcNmIzX3Asp6WBTbUbfLQQeuKOkIDIX4lxlq8UJ
         essSrD8P62s/Ttp/gCyumbdrXAbN8NOKvWKDFiBykAq2c/DEaaxZFm/c4dKWp4TE+g6w
         yR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DDjioKacl3HO1jkXORAy20kxeL1te3WxEGXYAhNzIlg=;
        b=p1PVj9BV2AeNLJJId14URzBH61PLYsReZIt2Mlfj2/G0Wr76OnrmNAAoyWg1G5OUDi
         wWi71dJJ4OK8VIdclk6TKoUqm0ZufbGqgWP5r4FlvBqWMXxyOlGiwdOE96lBzfj5O7s9
         zZ9L+vUhl2E+GU4b3ii440vdgIe0eY4nDhmNCBr2lv0j3X1gobu2uZJ5Nq6aHQx9Cnxh
         aXCMApU3msOugVgU1NhHD+JXzH4yLcWKWLgesMfxJvFmu+DHRxPrP5CNcD6E0iA8wccR
         AKLHX6ylb82ioXl67+wfjonALYOWF2w89EaI2gYYpi8fZtbpByUVhbtPYyR0sRBqu5Vl
         0f5Q==
X-Gm-Message-State: AOUpUlGk4fOdSdLtrkK+cXZLB61XNwbdVMmflsrDhvXpEUf1dxydfVvO
        zcV3eKPvSWl/bBJ8XAXnZEAUJHQE
X-Google-Smtp-Source: AAOMgpeDcklZtf6NLejiP3tJ0mbQDWe9pst6QSAIMixLycZzvhZSdy0TLl8YteWBYAMtKBV1Fo78cQ==
X-Received: by 2002:a1c:7c0c:: with SMTP id x12-v6mr2014910wmc.58.1531849515086;
        Tue, 17 Jul 2018 10:45:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2580660wrv.2.2018.07.17.10.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 10:45:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] t7501: add merge conflict tests for dry run
References: <20180426092524.25264-1-sxlijin@gmail.com>
        <20180715110807.25544-2-sxlijin@gmail.com>
        <xmqq1sc1rdvz.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 17 Jul 2018 10:45:13 -0700
In-Reply-To: <xmqq1sc1rdvz.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 17 Jul 2018 10:05:52 -0700")
Message-ID: <xmqqd0vlpxhy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But by splitting these into separate tests, the patch makes such a
> potential failure with "git commit --short" break the later steps.
>
> Not very nice.
>
> It may be a better change to just do in the original one
>
> 	git add test-file &&
> 	git commit --dry-run &&
> +	git commit --short &&
> +	git commit --long &&
> +	git commit --porcelain &&
> 	git commit -m "conflicts fixed from merge."
>
> without adding these new and separate tests, and then mark that one
> to expect a failure (because it would pass up to the --dry-run
> commit, but the --short commit would fail) at this step, perhaps?

Of course, if you want to be more thorough, anticipating that other
people in their future updates may break --short but not --long or
--porcelain, testing each option in separate test_expect_success is
a necessary way to do so, but then you'd need to actually be more
thorough, by not merely running each of them in separate
test_expect_success block but also arranging that each of them start
in an expected state to try the thing we want it to try.  That is

	for opt in --dry-run --short --long --porcelain
	do
		test_expect_success "commit $opt" '
			set up the conflicted state after merge &&
			git commit $opt
		'
	done

where the "set up the state" part makes sure it can tolerate
potential mistakes of previous run of "git commit $opt" (e.g. it
by mistake made a commit, making the index identical to HEAD and
taking us out of "merge in progress" state).

But from your 1/3 I did not get the impression that you particularly
want to be more thorough, and from your 3/3 I did not get the
impression that you anticipate --short/--long/--porcelain may get
broken independently.  And if that is the case, then chaining all of
them together like the above is a more honest way to express that we
are only doing a minimum set of testing.

Thanks.
