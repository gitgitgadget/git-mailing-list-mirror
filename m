Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAD37203C1
	for <e@80x24.org>; Sat, 23 Jul 2016 16:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbcGWQME (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 12:12:04 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36614 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbcGWQMC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 12:12:02 -0400
Received: by mail-wm0-f43.google.com with SMTP id q128so88546200wma.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2016 09:12:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wcHWeSJKcvmNehqo/7b5jS5WVI2s+W3gGTTXUCJ+ooI=;
        b=Si474q464iy72UhHchPtBKhb8SZa4o/LiIlgDBS0c3jLyfNbRC67rWU1AvdZjnkqOm
         gm+3d1kbvUrUXQ3SRcUqSRn2YT1MBfpW/hTo84ya6dtq0cotcwyo2KWATru14dC6BCn9
         KIJzxNh5Od72wY5yJvsrIXov1B6eKCsjOFyCfMfR1Ta23KLW7NrHSt+rqxc/v3hPWqE4
         RVGPQdbZX1EqDeuJXIo8F4UWy/kevAoWs++AjqKr9Ynah1JlgSjkbTh8te3NE0QMk8fA
         OPYqx5bn75Bjb/x9+2FtlBaPFcRtTaR8GMM41xMVOJW+q8+LSTZZC+wMCFeaUCRk05Me
         8hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wcHWeSJKcvmNehqo/7b5jS5WVI2s+W3gGTTXUCJ+ooI=;
        b=G47XG5KmkyY9Dqr/3IjqV5CpydxcyuMbIf3zsZsDpJ+mjLxFD8+Alo0YLI1UIvulnL
         lYZ0yRVkDoyll0omSsHiA9ePBpmbWdi5h+PvS+qZ25FOq2QRVufRggxJoRVfH/cPV+Fm
         o8NtIktf2GJ5KjRD4HMHijLrJtLvypbO6zIqpKkqR/G7KF5hyqW2HCJDdloRBfX2JW7J
         J4eZ9e9s7PSDsUsyuzVBdIAfoOHP52RmYg6uF8e6gGkEaf+kYf2fYn4T0lr2b6VxnFLD
         pKd/7JXdc9JiVpf7TZAqW2wQkv2PJ8+jdUCuu+eWf6Yr7BZkMFNAa/Z1dkNuU1Pgn8tg
         Xm5Q==
X-Gm-Message-State: ALyK8tKDESUZM4PRBwRRPWGWoZx6D8jjwYdZWpAzqnyVCCFLDm1nWvVdfpwH2GRhC0MhAVWI1vL6STBYxFWdIw==
X-Received: by 10.28.167.80 with SMTP id q77mr32825200wme.62.1469290320316;
 Sat, 23 Jul 2016 09:12:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Sat, 23 Jul 2016 09:11:59 -0700 (PDT)
In-Reply-To: <CACsJy8ApNJ+EBOVNC0GoPUaO898QRqHUZ2yQ39Qg5uGq4sHHGg@mail.gmail.com>
References: <20160711172254.13439-1-chriscool@tuxfamily.org> <CACsJy8ApNJ+EBOVNC0GoPUaO898QRqHUZ2yQ39Qg5uGq4sHHGg@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Sat, 23 Jul 2016 18:11:59 +0200
Message-ID: <CAP8UFD20WtCPLb3VzCJnYZSreUM7Q8GOC_VBG3h1j3wjOcR=_w@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/8] Add configuration options for split-index
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 6:01 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Jul 11, 2016 at 7:22 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Future work
>> ~~~~~~~~~~~
>>
>> One thing that is probably missing is a mechanism to avoid having too
>> many changes accumulating in the (split) index while in split index
>> mode. The git-update-index documentation says:
>>
>>         If split-index mode is already enabled and `--split-index` is
>>         given again, all changes in $GIT_DIR/index are pushed back to
>>         the shared index file.
>>
>> but it is probably better to not expect the user to think about it and
>> to have a mechanism that pushes back all changes to the shared index
>> file automatically when some threshold is reached. The threshold could
>> be for example when $GIT_DIR/index size is larger than 25% of the
>> shared index size. Opinions, test results or test ideas are welcome on
>> this.
>
> Oh yes I would like something like this. I stuck to the basics because
> as you see you need to define some criteria to re-split again, but
> without experimenting on real repos, I could just have gone the wrong
> way. Index file size or the percentage of entries in linked/shared
> indexes are two good candidates.

Ok, I started working on automatically pushing back all changes to the
shared index when the percentage of entries in linked vs shared
indexes is greater than 25% (maybe I will make it configurable later).
It is very basic and doesn't work well for now (for one thing it is
missing added entries), see:

https://github.com/chriscool/git/commits/config-split-index8

Basically I would like a way to count then entries that are only in
the linked index without modifying them to be safe, but I have a hard
time seeing how I could modify prepare_to_write_split_index() to get
that.

> You can also just re-split on
> commands that likely lead to increasing linked index size a lot (maybe
> git-reset), or run long enough that some extra processing won't get
> noticed. For example git-gc should definitely re-split if this feature
> is on, but I can't say if it's often enough.

I'd like to avoid re-split only on some specific commands as I feel it
could lead to bad behavior when none of these specific commands are
called but the linked index is growing because of other commands.
