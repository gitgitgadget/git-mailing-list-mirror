Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B8220188
	for <e@80x24.org>; Tue,  9 May 2017 07:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753282AbdEIH6v (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 03:58:51 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35953 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753278AbdEIH6u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 03:58:50 -0400
Received: by mail-it0-f42.google.com with SMTP id o5so627249ith.1
        for <git@vger.kernel.org>; Tue, 09 May 2017 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wf78hbXxGIJGEF1g8hfTv8HSZN1NyTeUjbEK+IZq+rA=;
        b=WmfKkxnwv3rgoaf/cXhVWL42DmhuZybobEiFpYq+pdIJF09mo+rZgLZcfXo3UkX6eC
         mMHCEoqyjUpN1uw4QmFTZqUWmOicCHJ06YVA3i20/URQ6hlU81ltPFcail3cB/ovUdfs
         5sExXjhHWA8TCkt3yZ8WLwzKpugbunI6RcGEex0xav7bM/mgMCciDjL7AcgVoyOcHU+Y
         I/sK/38CgcGdx9Id4KIdQWUmdoPazAxLzC/WZsDDUhhWv762KvKEJOp5vn+CzuK1Vcua
         3QBoo/cKy2dntm0RCQNWlyIQJLaAiZGrP3Oy68nTj81pUoCkTcNkGph/hLH5g9/6i1/R
         flWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wf78hbXxGIJGEF1g8hfTv8HSZN1NyTeUjbEK+IZq+rA=;
        b=IxwYVi+gpsbrKB6hTBhfPR6sqzAR0pH94BKEb5AMDDtPwTKVCDKiVzC3xtUFFvQgVG
         8ijFQqQszFjJx4mVWKCZZDN1JNq+2Us+6zF5yMMon5Wxj09yDEejOb1Y1cV1jGzk8D4n
         Hi4ctHQW1QC8BIFEb20U7v4qn20Drc2q0pBdLwzNe8ptA9ZNeNpq30oBAE7HWXqECVCA
         ZxFGuEFBAjve/lrxLtJRjY9qy67Zd2gJivzATsVfsLByQzjYI01JsXqjPy7inNwOAi8F
         ITVj5cIkS2Po/Hb5+INiM5003rUWJKFqIfjcqjpT6+xKQuQGEka8V+YZl3aUDEDxoDPD
         p6iw==
X-Gm-Message-State: AN3rC/7HKJIYYtbGJh8WAdRy+c7zK5tp6urcbGg665tPabkBY082zxVm
        TfKoIsNf0sU8QdGQtKHgkwQ8yKT7FQ==
X-Received: by 10.36.83.144 with SMTP id n138mr22944425itb.71.1494316729219;
 Tue, 09 May 2017 00:58:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 9 May 2017 00:58:28 -0700 (PDT)
In-Reply-To: <20170509031653.7hc36pil3vzrobsz@sigill.intra.peff.net>
References: <19607a03-71e0-440b-7213-64d25f6fa8da@xiplink.com>
 <20170427205037.1787-1-marcnarc@xiplink.com> <CAGZ79kbUqVfz+6Y0XkTL7FCZfaD+2YRMZ_v0vP8-DOFhWc+ELw@mail.gmail.com>
 <20170428220450.olqitnuwhrxzg3pv@sigill.intra.peff.net> <CACBZZX5f81HKCjRjTDyXzNMVuef9Z_ECS+0SVk2xpbwXudgxCw@mail.gmail.com>
 <20170509031653.7hc36pil3vzrobsz@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 9 May 2017 09:58:28 +0200
Message-ID: <CACBZZX5yHRDU6R3F8=qnqEGu6UCYNOj3rqMDbP1G7cJnvG7R=g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Make diff plumbing commands respect the indentHeuristic.
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2017 at 5:16 AM, Jeff King <peff@peff.net> wrote:
> On Mon, May 01, 2017 at 12:34:38PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > I don't know if we would want to be extra paranoid about patch-ids.
>> > There is no helping:
>> >
>> >   git rev-list HEAD | git diff-tree --stdin -p | git patch-id --stable
>> >
>> > because diff-tree doesn't know that it's trying for "--stable" output.
>> > But the diffs we compute internally for patch-id could disable the
>> > heuristics. I'm not sure if those matter, though. AFAIK those are used
>> > only for internal comparisons within a single program. I.e., we never
>> > compare them against input from the user, nor do we output them to the
>> > user. So they'll change, but I don't think anybody would care.
>>
>> I have a few-million row table with commit_id as one column & patch_id
>> as another. I.e. a commit -> patch_id mapping.
>
> Thanks for this data point. It's always interesting to hear about
> unforeseen uses of the tools.
>
> Out of curiosity, how do you generate the patch-ids? Is it with
> something like diff-tree piped to patch-id?

This:

    my $cmd =3D qq[git --git-dir=3D"$repository_path" log --since=3D"$since=
"
--until=3D"$until" --all --pretty=3Dformat:%H --binary | git patch-id];
    open my $patch_id_fh, " $cmd |";

Which is part of a loop that generates since/until for continuous
pull/insertion. Also, a few lines later there's a workaround for the
git.git bug of patch-id being ^0+$ (fixed in 2485eab55c
("git-patch-id: do not trip over "no newline" markers", 2011-02-17)),
which gives you a sense of how long it's been since anyone's touched
this.

> I do feel a bit sad about breaking this case (or at the very least
> forcing you to set an option to retain cross-version compatibility). But
> my gut says that we don't want to lock ourselves into never changing the
> diff algorithm (and I'm sure we've done it inadvertently a few times
> over the years; even the recent switch to turning on renames would have
> had that impact).

As noted I think it's completely fine to change the patch-ids by
changing the diff algorithm.

I'm about to give some more detail on this in the other thread, but I
find that on our repos the indent heuristic changes the patch-id for
around 2% of patches, which seems fairly typical for non-changelog-y
code. You *then* need to be using topic branches you didn't delete as
well as having authored such a patch for this change to kick in, so
the impact is really minimal.

Even if it somehow changed 100% of the ids that would be fine too. It
would auto-heal as the same git version started reading & inserting
the ids, which are only relevant in a moving window.
