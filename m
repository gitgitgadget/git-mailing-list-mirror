Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96CDE1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 19:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760869AbdACTVq (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 14:21:46 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34182 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760864AbdACTVo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 14:21:44 -0500
Received: by mail-qk0-f174.google.com with SMTP id h201so245600372qke.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 11:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xO8DP97J8z4ufFhMU54FDe7hBcBgk1bLKzycXPzCaJI=;
        b=dFWfOnMGru9aYaa8ZnqOr6wMXsY9NHjG62oMqXpMHV+PB3UN7kgkkRGg7D6TzuPCRS
         GAcKHdSFc9UBmmj5NVKyimG/abcUeqwK4nP7bm9tD0LSygBVaAana49H3GE7LtBrE6+X
         NbLq6FrWYHHR/SDl2kUL/TNfEKPxHCE+ZTjgX58ryiIvgG6q8WyZtL/BvOwZwcf0X+0p
         xQZd70uogQakAYsAalbi/uBm1VibnuRmgJlzGkhC8ce0dpDtFp/fxzDJDcgoJe2Ll75D
         00JXmk5LKaDeMQjNDSCXi1RjLlyz77ByeEacP/5ReT4JxMF08WJ/S5x6z1peZi9O0K/T
         CpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xO8DP97J8z4ufFhMU54FDe7hBcBgk1bLKzycXPzCaJI=;
        b=rnObp/zbxkO61ViqORUoO3QB9lYtMY0DNnNH5B1lGDy8clzvKU0jgChSvKuIUGUGiI
         yJ8fBvMSv/HXJCQiXWZoQe7QxfZtjyPmII8FVGX/ORKnrG5FhLX/8Z97Wtf8g3JB1I+j
         CIi7PxlqqzyQEu3KHXIlS8LEgJgfWp5D23RFEG8y9Yymw0CjeYjQwAvO1j/0zr7gjiSf
         XTn8YQPO+mkRxCFWnfdta9WPnyIbL+RvklaBgX/EnGvP0uLPZKUDUjDjZBXwMDx2OqV+
         28BnJQgvaMqEZ19gw4jjiLKVtJqhPj0Rij02rdK4/3CW5Q6h0puph+vq/zZ3U73cF1a4
         pdgQ==
X-Gm-Message-State: AIkVDXL715TBqJheLNlXQwcyf1p6HC+5pCTw8m219e93GZ598XzHWJZ6M7bMGmx9ZdY9Oz+IecVC/dAMfzwaxX3W
X-Received: by 10.55.90.68 with SMTP id o65mr29232759qkb.47.1483471303347;
 Tue, 03 Jan 2017 11:21:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Tue, 3 Jan 2017 11:21:42 -0800 (PST)
In-Reply-To: <CAAmwXB=M8yZY2sFLwavrrQSEW9bipFhNZyLduwYXtZNK6-Ppxg@mail.gmail.com>
References: <CAAmwXB=M8yZY2sFLwavrrQSEW9bipFhNZyLduwYXtZNK6-Ppxg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Jan 2017 11:21:42 -0800
Message-ID: <CAGZ79kYZwSM78FoytDm9VhFY0D=Z1tzoq=tW7h65kSCYSr0grQ@mail.gmail.com>
Subject: Re: Wanted: shallow submodule clones with --no-single-branch.
To:     Tor Andersson <tor@ccxvii.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 30, 2016 at 2:50 AM, Tor Andersson <tor@ccxvii.net> wrote:
> Hi,
>
> When adding submodules with --depth=1 only the master branch is
> cloned. This often leaves the submodule pointing to a non-existing
> commit.

You can also use the "--branch=not_master" flag to track another branch.
This however doesn't clone the correct branch. I would have expected that
it cloned the correct branch instead.

>
> It would be useful if I could pass the --no-single-branch argument to
> the submodule clone process, since then a submodule can point to any
> tag or branch without ending up in this situation.


Adding --no-single-branch sounds like a good idea for general use,
but it seems like a clunky workaround when looking for a specific branch,
i.e. fixing the --branch flag sounds like the right approach for this
issue here?

> I've got a local
> patch to hardwire the --no-single-branch argument in the
> builtin/submodule--helper.c clone_submodule function, but I'm not sure
> if this will have any other adverse effects?

Well, when asking for depth=1, the user usually actually wants to have the
least amount of data, which is why --depth implies --single-branch
in clone.

So adding it unconditionally is a bad idea IMHO, we'd need to have a flag
for that propagated from git-submodule.sh (function cmd_add) to the
submodule--helpers module_clone.

>
> Better yet would be for the shallow submodule clone to automatically
> retrieve and graft the actual commit the submodule points to, but
> that's probably wishing for too much.

I think fixing the branch option comes a bit closer, but still doesn't
fix this root problem. "submodule update" tries to fetch by sha1
directly in the hope that the server has uploadpack.\
allowReachableSHA1InWant configured.

In "submodule add" I think it is sufficient to take the current remotes
$branch and record that, so I do not see the need in the add code
to support direct sha1s unlike the update command?

Thanks,
Stefan
