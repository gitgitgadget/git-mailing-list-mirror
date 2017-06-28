Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773D91FCCA
	for <e@80x24.org>; Wed, 28 Jun 2017 19:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbdF1Txw (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 15:53:52 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35841 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbdF1Txn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 15:53:43 -0400
Received: by mail-pg0-f52.google.com with SMTP id u62so36575052pgb.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 12:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SHGUvp6Af0CYCOh3i/AoG4AqISMF0wORR5ytghAGgsQ=;
        b=P3U91wKiDiGfCT41qahf+P20O+oLLS9eR44xNQw2g91F+xuNKW843AlVZ3Il+W/t1l
         h35vvw6BWOEF5LqCS1bSQDE5SR0EM5pwfRbYecTUfldXoWosjus33iLnSqtQHmj17quA
         j4b2WzJ/L9/K8GNZ5x/FHMn/v6/H6vfwBpmPZYVqNL5joTc7tgIZiFK9ji48MAKF3IYd
         Zegn4hAgIXcHwR4YinG0lgqJxlAq4bXwZ9TzpvN0W9M8UqnAR1Prsavb9SA23NlWk/ex
         wt/0Ig74NazzjAGFj7j0rTpJOQ0PAS43lJQsBaWFRQiHBDraXBweRPW2Wf/MC0Tw1nXk
         mzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SHGUvp6Af0CYCOh3i/AoG4AqISMF0wORR5ytghAGgsQ=;
        b=imVl3BC5H2ydpPiRUomjgXnNaNlcxgqn/W+/1iQZCedNx+aX/T2YRKScG4mVF9kInN
         gFfGIlbqjGUr+FrTJ0vyKLz9zotJLN+BZUaQ1TX91vTl5VmYUgVPu5K1DqJ78t+hIjp9
         SnFltwKrdIVKaAnLoKm2pi0pBXMsCBt7uzqsi5fPrGrbsxO4B4H9orzwulr6AgGxG3mU
         UiFcGsC5MRQ4itlHrvxpbp+q9Ky5D3H03ERAjfta+USJWVAc7gKfgqf6kV/PHCh4ST1A
         xoKEaHlEeQ68XS2fUFvJEr4QzRJHF/sSmtXWoNb5l4/n+n0YjpSSCjGK2eiktWP+SFse
         99bg==
X-Gm-Message-State: AKS2vOxNjdY9j0dMSzFVf9E2uIEGWSUOZgw8RRX8x6V9uCDu2hTCvg4w
        dzAODOGpdkJVxw==
X-Received: by 10.84.176.3 with SMTP id u3mr13735857plb.134.1498679617454;
        Wed, 28 Jun 2017 12:53:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88a2:2d61:9b86:f64d])
        by smtp.gmail.com with ESMTPSA id u9sm5978617pfd.56.2017.06.28.12.53.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Jun 2017 12:53:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, sbeller@google.com
Subject: Re: [GSoC][PATCH 1/6 v2] submodule--helper: introduce for_each_submodule_list
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
        <20170626231108.23640-1-pc44800@gmail.com>
Date:   Wed, 28 Jun 2017 12:53:34 -0700
In-Reply-To: <20170626231108.23640-1-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Tue, 27 Jun 2017 04:41:03 +0530")
Message-ID: <xmqq60ffx51d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> Introduce function for_each_submodule_list for using it
> in the later patches, related to porting submodule
> subcommands from shell to C.
> This new function is also used in ported submodule subcommand
> init.

The patch text looks sensible.  It would be easier for "git log"
readers to understand, if the change is explained like so:

	Introduce function for_each_submodule_list() and
	replace a loop in module_init() with a call to it.

	The new function will also be used in other parts of the
	system in later patches.

That way, readers do not have to judge the merit of this change
based on a vague promise "it will help world better with future
patches", but can instead judge on its immediate benefit that it
refactors a useful bit out of an existing code.

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> This series of patches is based on the 'next' branch. 

The reason not to base on 'master' is...?

The thing is that a topic built on 'next' cannot be merged down to
'master' until _all_ other topics in 'next' graduate to 'master',
which may never happen.  If you are depending on one or more topics,
please make sure to name them.  Then we can

 (1) create a branch from the tip of 'master';
 (2) merge these topics you depend on into that branch; and then
 (3) apply these patches.

The topic still needs to wait until these other topis graduate, but
at least you would not be blocked by unrelated topics that way.

You _might_ be building on 'next' because you want to make sure that
your topic works not just with master but also want to make sure
that there won't be any unexpected breakage when used with topics in
'next', even though your topic does not depend on anything in 'next'
in particular.  It is a good development discipline to pay attention
to other topics in flight and I applaud you for it if that is why
you based it on 'next'.  But the right way to do it would be to
build your topic on 'master', and then in addition to testing the
topic by itself, also make a trial merge of your topic into 'next'
and test the result as well.

Thanks.
