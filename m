Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F07C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhLGUho (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhLGUhn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:37:43 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A70C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:34:12 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v1so803748edx.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n7qlVnGPtUvpBcIRgpWGKgilSl7yz/ClnZax5EjT/V8=;
        b=MWqAjGOBqoG/sdeJcC7IPoN46ULAHhvHtNGGYk4igNgvtOrrGGNPS/NN4MG+RD47Av
         8BNAEkQ4Tu4IPLJoo7e1JqWDKqIR4mLN/nHP4v2rPJ20VJQ0ri1xiYYKWPD2qc/gLBc5
         8w/icWdoAtXwJc/OTj1/d3cna4DcBnXRGXiOSTtB8Hmw7QwW5WT3cdLjamNlRrruiGB5
         THn8lBp0oq2hcD0iST3Do7Txx099iGfZ8rxXsPbAOeLFlzAbZAcQhwgCGbOC19BNxnji
         RIg9tpfvmy2Eh6Q03lr8Qr5ja8xzQcuItE1r+6RY/CP5x00EjGofwanyXHL+WOJorD8D
         8xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n7qlVnGPtUvpBcIRgpWGKgilSl7yz/ClnZax5EjT/V8=;
        b=uePFcncNQDynZi7wGQB3ZMcS8MUvfmRBxV4BXYkv5FWD8dDq+1YNKnL8toPdi/5VFa
         ZXuCswto0ZOaYN5Q0Q5tYDfJWn/J67Sl/VUZUTQkRkjd1xGhD8FxCBBAryXYOcknB9YW
         xG259jEokpjwx9QNKkWyU1HF1dX+xGcU1cGUM0CPBAde3eu2S8yfQj9zgBBv+ulTFf3P
         2cE/9sN66MO8joIA963GDd7NxezU9xLZvXLvyH3AUYZc31GFhKhRn00oI3962rkDrYpY
         zG8OiRNIeWRfE++ECm3fIkpzJNFQ4x+XHUAlIs60sK5N0Gaszya5f5RFKhMUTBn0axMG
         F5+w==
X-Gm-Message-State: AOAM5310JxioXj6K3BLkqSoBaCV2RO4jxrgvwiX11dPcnTJ7r9ZFR/wi
        IE4FHNYaPOjTaF54UdM0cMVMh2DA1CFRWPboEjM=
X-Google-Smtp-Source: ABdhPJyAWNDJ3MSgzLzJCIpOrgokM6+aTgkAV6iOeTpfmJH8/S9uxE89dswTV/M28CotlQMjGPi7pVz3cexQkEDv64A=
X-Received: by 2002:a17:906:3ce9:: with SMTP id d9mr1958334ejh.172.1638909251162;
 Tue, 07 Dec 2021 12:34:11 -0800 (PST)
MIME-Version: 1.0
References: <xmqqh7bpqhf0.fsf@gitster.g> <CABPp-BGdvOhy_g8vtRogqL2vPkZEtP4+N_5x0rhAWrX9x43WWA@mail.gmail.com>
 <211207.86ee6opy0f.gmgdl@evledraar.gmail.com>
In-Reply-To: <211207.86ee6opy0f.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Dec 2021 12:33:59 -0800
Message-ID: <CABPp-BHhtZzq3rqbaHm62LOkA6cnzRC6cKokGP7s2ZsQzqjJrw@mail.gmail.com>
Subject: Re: en/keep-cwd (Was: Re: What's cooking in git.git (Dec 2021, #01;
 Fri, 3))
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 1:25 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Mon, Dec 06 2021, Elijah Newren wrote:
>
> > On Mon, Dec 6, 2021 at 5:57 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> >>
> >> * en/keep-cwd (2021-12-01) 11 commits
> >>  - t2501: simplify the tests since we can now assume desired behavior
> >>  - dir: new flag to remove_dir_recurse() to spare the original_cwd
> >>  - dir: avoid incidentally removing the original_cwd in remove_path()
> >>  - stash: do not attempt to remove startup_info->original_cwd
> >>  - rebase: do not attempt to remove startup_info->original_cwd
> >>  - clean: do not attempt to remove startup_info->original_cwd
> >>  - symlinks: do not include startup_info->original_cwd in dir removal
> >>  - unpack-trees: add special cwd handling
> >>  - unpack-trees: refuse to remove startup_info->original_cwd
> >>  - setup: introduce startup_info->original_cwd
> >>  - t2501: add various tests for removing the current working directory
> >>
> >>  Many git commands that deal with working tree files try to remove a
> >>  directory that becomes empty (i.e. "git switch" from a branch that
> >>  has the directory to another branch that does not would attempt
> >>  remove all files in the directory and the directory itself).  This
> >>  drops users into an unfamiliar situation if the command was run in
> >>  a subdirectory that becomes subject to removal due to the command.
> >>  The commands have been taught to keep an empty directory if it is
> >>  the directory they were started in to avoid surprising users.
> >
> > Very nicely written summary.
> >
> >>
> >>  Needs review.
> >>  There are some comments on earlier rounds; the latest one needs a
> >>  serious review or at least Acks from past commentors.
> >>  source: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
> >
> > If it helps, there are two parts to the review:
> > - Do we want this feature?
> > - Does this patch series implement the feature correctly?
...
> So I've got no objections to these changes going in as they stand.

Thanks.

> If
> anyone is interested in pulling at the "let's not make it die" thread
> that can always be done later, or we can make it configurable or
> whatever.
>
> I don't think this needs to be part of your initial series, but just a
> question:
>
> Isn't a logical follow-up after it to change the various things like
> "git bisect that refuse to run in subdirectories to happily do so?
> I.e. the reason for those is specifically this "cwd goes away". Both
> because of our bad handling of it, and due to any user confusion that'll
> be addressed by that cwd sticking around".

Both sound like potentially relevant logical follow-ups.
