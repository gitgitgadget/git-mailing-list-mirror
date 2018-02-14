Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D126D1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 00:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966303AbeBNA5i (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 19:57:38 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36523 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966220AbeBNA5h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 19:57:37 -0500
Received: by mail-oi0-f42.google.com with SMTP id 24so15330190oij.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 16:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6aJLSw2uD/M4GfXEVs8hRhEJNfWofKVmJngfU+8CF5c=;
        b=XifG0/UcfClYBW08/w8l+YqbxmYyffsSiQtr6j0dQqUPYU32O3K6tirygVPOhvOpnv
         ffjqTP46G9OCLR4edKNGsfeCwLItHUVApkQ8cWTlRp3QRUgMc5Z3IrdP3qMrNg+GYTcq
         2+oFmaFNq98wbTtyRcjApA5bKrFXIUH2Ie430IkjxOofeXquj0OiBhT6F4oRSJfzrlxO
         1t+TOa7lI4zZhKiExShsWEjcx5kwfTHCneuQTD537OjpvMltxe6zV9h43NStV8fSrcC+
         VlkbF2gNVGFumxcKRibCMFMXYQ4Yrc/zd5VsBhaorGZ5aYBl9AONkaqpMdUG0Mqj+XQi
         eKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6aJLSw2uD/M4GfXEVs8hRhEJNfWofKVmJngfU+8CF5c=;
        b=F3mm2/jZTgm3rXQLLhtL0VFiHqxdjXELecTdRPm8mtVkgi6e5X0lLI/8+tFqRx0ne9
         h6yVbL04k5Gp7yGEtq3/NTDYrI1xGenxLQes8IR6QN3wf2dMJtj8ObegiVFFywca+Cso
         jSKh6AUm4lL/STpwv58TdwHJwgmdDxImYYirItWELg7ldHH5zOp79TrNBws3WwFSqLTk
         PTmpmEm94D1xTssRQSjbhMcWQMHYjBj9CyfFagcirz4O/GVtDxJYcps0ZA6b/7aMzj8H
         i2axcVkVdTIqWs1hiyUCQtoZnMS7/qNNzCPrHzEFnzDFJoaEDdNYCc+lDzM5UyC2CqC8
         pocQ==
X-Gm-Message-State: APf1xPBdr7bcAHAAnnjFeMpsu4sQISkdeD9qtP6Daw2jWgZLvWfMK7iE
        bS2V1rZvJeWzP3eDQqRnnXXVSlHTdFVDMPTHe6Q=
X-Google-Smtp-Source: AH8x225Cd7s0+aP5kwo8RlEdRe57Jzx2BVTp0iV+BV+IDVPXyC8OaPiyfBKv0Yz1glilsW6oiQy2VPdmbfghSrXUKJ0=
X-Received: by 10.202.107.194 with SMTP id g185mr2225800oic.268.1518569856949;
 Tue, 13 Feb 2018 16:57:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Tue, 13 Feb 2018 16:57:06 -0800 (PST)
In-Reply-To: <20180213192621.GC42272@aiede.svl.corp.google.com>
References: <20180213012241.187007-1-sbeller@google.com> <20180213192621.GC42272@aiede.svl.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 14 Feb 2018 07:57:06 +0700
Message-ID: <CACsJy8CPKESE8atc_eWdNVknQYp9T6ebwKwCdzLHyaFKH2BnZA@mail.gmail.com>
Subject: Re: [PATCH 00/26] Moving global state into the repository object
 (part 1)
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 2:26 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Duy suggested that we shall not use the repository blindly, but should carefully
>> examine whether to pass on an object store or the refstore or such[4], which
>> I agree with if it makes sense. This series unfortunately has an issue with that
>> as I would not want to pass down the `ignore_env` flag separately from the object
>> store, so I made all functions that only take the object store to have the raw
>> object store as the first parameter, and others using the full repository.
>
> I think I want to push back on this a little.
>
> The advantage of a function taking e.g. an object_store as an argument
> instead of a repository is that it increases its flexibility, since it
> allows callers that do not have access to a repository to call it.  The
> disadvantage is also that it increases the flexibility without any
> callers benefitting from that:
>
>  1. It ties us to assumptions from today.  If e.g. an object access in
>     the future starts relying on some other information from the
>     repository (e.g. its config) then we'd have to either add a
>     back-pointer from the object store to its repository or add
>     additional arguments for that additional data at that point.
>
>     If all callers already have a repository, it is simpler to pass
>     that repository as context so that we have the flexibility to make
>     more use of it later.

It's essentially putting all global variables in the same place again.
Only this time it's not global namespace, but "struct repository".
It's no worse than the current state though.

>
>  2. It complicates the caller.  Instead of consistently passing the
>     same repository argument as context to functions that access that
>     repository, the caller would have to pull out relevant fields like
>     the object store from it.

Well, I see that as a good point :)

>
>  3. It prevents us from making opportunistic use of other information
>     from the repository, such as its name for use in error messages.

It does not exactly prevent us. It's just more effort to pass this
around. The repository name for example, there's no reason we can't
have object store name (which could be initialized the same as repo
name).

> In lower-level funcitons that need to be usable by callers without a
> repository (e.g. to find packfiles in an alternate) it makes sense to
> not pass a repository, but without such a use case in mind

I do agree with your benefit argument. But I'd like to point out
though that having all input to object store visible from something
like "struct raw_object_store" makes it easier to reason about the
code. I know how object store works, but occasionally I'm still
surprised when it getenv (or read $GIT_DIR/index, but not in object
store code) behind the scene. Imagine how hard it is for newcomers.

I would count that as benefit, even though it's not a use case per se.
Another potential benefit is writing unit tests will be much easier
(you can configure object store through struct repository too, but
setting one piece here, one piece there to control object store
behavior is not a nice experience). It's a nice thing to have, but not
a deciding factor.

> I don't think it needs to be a general goal.

My stand is a bit more aggressive. We should try to achieve better
abstraction if possible. But if it makes Stefan's life hell, it's not
worth doing. Converting to 'struct repository' is already a step
forward. Actually if it discourages him from finishing this work, it's
already not worth doing.
-- 
Duy
