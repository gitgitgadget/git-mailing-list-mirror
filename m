Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B98220248
	for <e@80x24.org>; Thu, 28 Mar 2019 11:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfC1LEk (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 07:04:40 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56029 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1LEk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 07:04:40 -0400
Received: by mail-it1-f195.google.com with SMTP id z126so5257068itd.5
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 04:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSbzsnmb2YH0AzIhxsRd7ECqXezvyG52XDPiP4YtDOc=;
        b=it9ZTMf9hX7uoghd2aECLKvoHg1rCRnF2YjAckOVysv92LQqe0pBYv8zmPa7/dkPsN
         xa9TvNHJpvxr9vS9oF4KcgeXAq/T1vbXce3F5vujRvKJzOsDLfid2yUulMQTVLPCnfO+
         PD/YQkswx6es9HOKy/5aAzRain/Nii7r4lPrTTI6wLH2rfADcoKW255U2gFvEYpkOsXu
         yQHB3LyN6E4PbIG86uJBevPb4rzftHRPYmsojTQ6gPWUtwwD9SxYHuxiHdvWi4ZUSadk
         73nlvgb54UtWCHoI+BVzUHfNbYN1Wmoc70T5qNr/PvjRE9FVrOqzqHEiE4WHfydlt8f9
         gZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSbzsnmb2YH0AzIhxsRd7ECqXezvyG52XDPiP4YtDOc=;
        b=qL457+5hzGrlXkKVygYhA9VsYjfp7ns6ujkckAhHssewJ7GvQjNLWezmWNgnsr+A/1
         0ju3dKMi981x9VNiyoxITeYEF2BiXwYUzphEt9w6i9Frl8HWXOLlzFLZ2dNPPf8dfOyB
         C4gB3UyW+RY4LA1X+jGXRIOrSAGSPSdxbVrAUgC/b/4P6juZes7n6V9Tx7mFcuaO+BVE
         pEn+z7zdUMYQbDQTm311BCwb7EPvpQX3q4uAoe2AC/bke3cwVsU0CUu8aNz9rF83tZEB
         00Qdy7swiueSEw29a8OtQqzdt8QzWwoA3PgVWGx++rr5gtoRT6ofaj0UbEOtGgCYvCOq
         LZbw==
X-Gm-Message-State: APjAAAUBFYmIg3kRFfh16oQrCG6BFAWtxVaTFtIkhetVX+E9eyU4mgap
        KQTtGPj1LgIQxwFcE3hp1BebgYlSgHuTFZ977qVkQw==
X-Google-Smtp-Source: APXvYqyHZWyijK6gRc359zn9CsVEzBkNJsU8xn0jFc6opF/mo6QgS6Z8sUBxmp2asSWdWdnW2InURE49ftAlCSRtf2o=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr7391093itf.123.1553771079565;
 Thu, 28 Mar 2019 04:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com>
 <CABPp-BEksf4SuD57YsUO3YKhU12CAwFTy6pA1tETFrHB1DAz9w@mail.gmail.com>
 <CACsJy8DPDEvNDeE5MpqcGZk9jRmT9g=ix+MOhkv+50J3Egef7A@mail.gmail.com>
 <CABPp-BFTyALWmnJ=dT1xNivjcQhtKak15ydfkYjEsEC-j4BD9w@mail.gmail.com> <0dc8820c-c6b0-c4ca-2107-84061fdc5333@gmail.com>
In-Reply-To: <0dc8820c-c6b0-c4ca-2107-84061fdc5333@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 28 Mar 2019 18:04:12 +0700
Message-ID: <CACsJy8AmgDh1Z4CKTzSAVrywo0q-CFKbpuyqdtRm9m7pkUweSw@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 5:24 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 26/03/2019 15:48, Elijah Newren wrote:
> > On Tue, Mar 26, 2019 at 8:24 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >> On Tue, Mar 26, 2019 at 10:01 PM Elijah Newren <newren@gmail.com> wrote:
> >
> >> Yeah.. --ignore-in-process does not necessarily mean aborting
> >> something when you just want to get out to examine some other commit.
> >> And I agree doing nothing seems like the best (or least
> >> confusing/surprising) option.
> >>
> >> There will be some funny thing. Like if you commit after switching
> >> away and MERGE_HEAD is there, I think you will be creating a merge
> >> commit.
> >
> > Yes, and in the middle of a cherry-pick with a range you've added some
> > commits to one branch and some to another.  In the middle of a revert
> > you're doing similar.  It sounds like crazytown to me (and maybe we
> > shouldn't provide the --ignore-in-process flag unless users clamor for
> > it

I missed this part in my last reading. I think if we could safely
switch away and get back to resume, then --ignore-in-process could
still be useful. I sometimes switch to another commit to check out
stuff then back. For interactive rebase with "edit" command for
example, it's quite safe to do so. (yes the other option is "git
worktree add", but that could be a heavy hammer sometimes)

> I think that could be the way to go for merges and cherry-picks, or

Just so we're clear, what is your "the way" to go? to remove
CHERRY_HEAD_PICK and MERGE_HEAD (and other MERGE_* as well) if
--ignore-in-process is specified? Or to leave MERGE_* and
CHERRY_PICK_HEAD alone and delete other stuff?

> possibly require --discard-changes as well. The only time I use checkout
> like this is during a rebase if I want to rewind it - I edit the todo
> list with the output of 'git log --pretty="pick %h %s" --reverse' and do
> 'git checkout' followed by 'git rebase --continue' Though these days I
> could add a 'reset' line to the todo list and skip the checkout.
-- 
Duy
