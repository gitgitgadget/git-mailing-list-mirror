Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947AA1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 19:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933014AbdCGT7k (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 14:59:40 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32836 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932984AbdCGT7h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 14:59:37 -0500
Received: by mail-pf0-f175.google.com with SMTP id w189so4608019pfb.0
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 11:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g/pUl8ZCqRA5P5m5Z+a2XPJZPbyoJHQhd783XQMevxs=;
        b=NKCfhAXHqt4QzD30pSg1dbcBiM6kxjlgqKuZxeQ2RbQCgqNzzmcLxSgP2JdyI7X4r2
         E209GuhvVNySXCBaEFzoufAI8217fvKc1rEjQYuwvGR9iHoBm97WWE17Gplifo/ZlZFW
         K0rR/5ACzC2aCJhQp1ejSj/OwpN06rr3tLjQa8bCqVkFus92Ye/oJamam3hvjvw+jdVL
         YDiAOV/R6V0nwrKK8fRmRurZkwrj+NBi1sAX+q4K/7DiRf1LZRL4DLdS8ka4lVVWFZCB
         KtpOQOL+YI2E6ZSIQIsiP4oUTU9kGQSK+izg9nJmfh2RqcvLtxs6A0vmDHhksCFJdrVn
         IRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g/pUl8ZCqRA5P5m5Z+a2XPJZPbyoJHQhd783XQMevxs=;
        b=JAZM+3IYSVwQ4rk555KAp0s7M+DiOkz8Kg0/aqjb73npv04/y92cWRXeISU9iXXwVR
         uKv7E2jPPAdOXlBu23uAMYiYxMU/KwOmd1DKyPhAYQujfjXy5KIdwmKipWemQdsjRmTA
         F5Fla2N6OxWYfxV9S0jEBu4WPZZOuFAf8KBtOAAJOWYD/jUKOBqdur8e+oKMYSY2kONC
         i/+OImUWiVG1ck+yT9Umk6euxJ0scLMep+vItI7UJRhXAstFiTGkx1o6hs0UZphAceRS
         mSi7ACFUsatV8uIQnyS5QG3FpJbjJ0vQeHlZNb0BgN4S/iIcdDiBT7YaCPJgGpNNfD7e
         mrHQ==
X-Gm-Message-State: AMke39knED8fZkPY4S8A+BzMWoRPiWMFX1X2ZwfTa46E50xRu7ujQb99oFgcmwWXGpKuMTdTjsRVS5WN4QZpafD9
X-Received: by 10.99.247.83 with SMTP id f19mr2418845pgk.158.1488916775761;
 Tue, 07 Mar 2017 11:59:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 7 Mar 2017 11:59:35 -0800 (PST)
In-Reply-To: <1488913150.8812.0@smtp.yandex.ru>
References: <1488913150.8812.0@smtp.yandex.ru>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Mar 2017 11:59:35 -0800
Message-ID: <CAGZ79kY+1E-wg0-uzGJmE+haOE+1WCmg0Eux7rWGtkU_aBDQ9g@mail.gmail.com>
Subject: Re: git init --separate-git-dir does not update symbolic .git links
 for submodules
To:     CAGZ79kZbc394rmxYDUxCbysKNbEQCB7aLJkf6MGcCeXKAxiKhA@mail.gmail.com
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Valery Tolstov <me@vtolstov.org>, sven@cs-ware.de
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2017 at 10:59 AM, Valery Tolstov <me@vtolstov.org> wrote:
> I think we can reuse code from module_clone that writes .git link.
> Possibly this code fragment needs to be factored out from module_clone

That fragment already exists, see dir.h:
connect_work_tree_and_git_dir(work_tree, git_dir);
Maybe another good microproject is to use that in module_clone.

>
> Also, to fix all the links, we need to obtain the list of submodules
> and then iterate over them.

Right, but a submodule may have a nested submodule.
So we need to fix each submodule from that list recursively,
i.e. not just the submodule itself, but any potential nested
submodule in that submodule, too.
(the listing doesn't list these nested submodules)

So we would call

    fix_gitlink(sub)
    {
        fix_locally(sub);

        // have a child process that calls
        // this function on any submodule inside sub.
    }

> module_list command iterates
> and prints the result to stdout. Maybe we can reuse this output.
> Or create separate function that returns the list of submodules.

yeah you can make use of module_list_compute to just produce
the list internally.

>
> Can we call these functions from submodule--helper inside init command,
> or run them thorugh internal command interface?

Both sounds fine, though calling internally is preferable for
performance reasons.

>
> In my opinion, make submodule--helper fully responsible for link fixes
> would be a good solution. Then we create two additional function, one
> that fixes all submodules on the current level, and another that
> fixes individual submodule.
> Although it looks good, I'm not quite sure that it's really good.

That sounds good to me.

So "git init --separate-git-dir" calls internally a new function
in the submodule--helper to

>
> So, maybe we can do link fixes like this:
>
>    1. Start fixing from init command using submodule--helper, with
>       subcommand that fixes all submodules on current level

for this step we do not change the repository we are in, so there
is no need to call a new process, but we rather want to
call it internally.

>    2. Each submodule processed with another subcommand/function in
>       submodule--helper individually

sounds good.

>    3. Repeat for current submodule recursively

and this recursive action needs to have its own process in the submodule,
e.g. "git submodule--helper --recursive fix-git-links"

>
> Glad to see your advices.
>
> Regards,
>  Valery Tolstov

Regards,
Stefan
