Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3611F744
	for <e@80x24.org>; Wed, 20 Jul 2016 17:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbcGTRKH (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 13:10:07 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35892 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbcGTRKE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 13:10:04 -0400
Received: by mail-io0-f171.google.com with SMTP id b62so53253066iod.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 10:10:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3akGe9gCPUMR3j8x+Pbx5KLy7WE4tjxYy4tu/IonIJ0=;
        b=WhFt96AAUUf8Aw0SybJQz2dhG7+sFf7wf6ZtpOHCS2LLUtnP2x2aY/2B9gWf9vQTyK
         1GBRmsXvQCX5XT5jBbG8DveEhrXFcOrt+P4HzLomKnm2ewkiH2QRnqA6U0Bb6Mt1kGkw
         hH1Xp7M4YOz0fDqs1ncLV3slz9L3ldi6lTqtM8wD4ODGEiTUKENYap/DrCGAiWtbjx8G
         xMrbiXSIc5H5aSpUtetJ4BENy6RQ1ClchF52EYZcP67sR8jp4Od+yy5uf8ZNLGJxkv8b
         GPImm07HJM8UtnFt7r7CX5r8XrqiIZ60/L31ZrAQXITRT1fKN8zOvc+3/cD3c77TFC3b
         1ZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3akGe9gCPUMR3j8x+Pbx5KLy7WE4tjxYy4tu/IonIJ0=;
        b=f/v9kUpDzokJ37bGVN9l7wA94vCUBDH1PPycybES0XiDYaRPKguYNTB7z5vC3LGrd5
         0iRmREbsFwHrNxEd94K9uDTMARDAnMsUnoBke8xt/Dw4aoS6yEPjSry2+uXxZF+VUHtk
         s+WgN0vlPrr/iVj1tQKVOpvbH2eKKfkV+FH7LiQfLVNczGginZ5mdhvt0tA4qzuahYyL
         VpmiyrXj3hf8J7gpBmGMOaQfLNPGzSMDmTnv2fXapaHaCyMjb9OimcUe31kPPMnTHtE7
         Toh1JeLMDzkIXkjaG9rNhM63lJKUd1YSs6OugZZ8QWNJEi+4yLlhJxbN5E8NYofUXj0H
         9zdQ==
X-Gm-Message-State: ALyK8tKMZB0jZyMtA7gGqjvkiKs1O4/MTa2GZRiZYdNU83L1Lutq1axCvJse5JfzjbgaNim016m7IOFlaAgnEq22
X-Received: by 10.107.178.129 with SMTP id b123mr46280505iof.83.1469034603087;
 Wed, 20 Jul 2016 10:10:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 20 Jul 2016 10:10:02 -0700 (PDT)
In-Reply-To: <CACsJy8A3ZTfRRNuYXYD-nzXm6KXHu8cHU6fzfysJxfW0EggKNA@mail.gmail.com>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net> <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org>
 <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
 <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com>
 <alpine.DEB.2.20.1607181750470.3472@virtualbox> <CACsJy8Ba=c+-WV2TsY768_fTDO2KesS1b6BK7kdykNY6gkh=UQ@mail.gmail.com>
 <alpine.DEB.2.20.1607190910370.3472@virtualbox> <CACsJy8CSUu=AemQ-7uxth_2M=ko_KDGsdObwYdiE=L4OMKcVZw@mail.gmail.com>
 <alpine.DEB.2.02.1607191032270.25425@nftneq.ynat.uz> <CACsJy8Bvqt9r2dRtRfx1C-3Fp16z3SJ=hp0i7-itwFwfEfZwTw@mail.gmail.com>
 <alpine.DEB.2.02.1607191057170.25425@nftneq.ynat.uz> <CACsJy8D1RtwVF4ZtRHV2Z=huTqRBp8Du5GMZq9qxwXDZezBF2g@mail.gmail.com>
 <alpine.DEB.2.20.1607201428030.14111@virtualbox> <CACsJy8A3ZTfRRNuYXYD-nzXm6KXHu8cHU6fzfysJxfW0EggKNA@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 20 Jul 2016 10:10:02 -0700
Message-ID: <CAGZ79kYzhPayXKq5LrddKTuO7d5=7_AZVvr7rJ4ztAzBFv-7eg@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Lang <david@lang.hm>, Herczeg Zsolt <zsolt94@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 7:44 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jul 20, 2016 at 2:28 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> But that strategy *still* ignores the distributed nature of Git. Just
>> because *you* make that merge at a certain point does not necessarily mean
>> that I make it at that point, too.
>>
>> Any approach that tries to have one single point of conversion will most
>> likely fall short of a solution.
>
> OK I see the difference in our views now. To me an sha256 repo would
> see an sha1 repo as a _foreign_ DVCS, pretty much like git sees
> mercurial now. So a transition from sha1 to sha256 is not that
> different from cvs -> svn -> a dvcs bubble -> git.
>
>> To be honest, I am less concerned about the GPG-signed commits (after all,
>> after switching to a more secure hash algorithm, a maintainer could
>> cross-sign all signed commits, or only the branch tips or tags, as new
>> tags, to reinstitute trust).
>>
>> I am much more concerned about references to commits, both inside and
>> outside the repository. That is, if I read anywhere on the internet about
>> Git having added support for `git add --chmod=+x <file>` in 4e55ed3 (add:
>> add --chmod=+x / --chmod=-x options, 2016-05-31), I want to find that
>> commit by that reference.
>>
>> And I am of course concerned what should happen if a user wants to fetch
>> from, or push to, a SHA-1-hashed remote repository into, or from, a
>> SHA-256-hashed local one.
>
> to follow the above, in my view, interaction with sha1 repos go
> through some conversion bridges like what we have with hg and svn. I
> don't know if we are going this route. It's certainly simpler and
> people already have experiences (from previous migration) to prepare
> for it.

When treating the SHA1 version as a foreign dvcs and the SHA256
as the real deal, we could introduce "pointer objects", and during the
conversion
create a 4e55ed3 pointer that points to the SHA256 commit of (add:
add --chmod=+x / --chmod=-x options, 2016-05-31). Ideally we would
not even expose this sort of object a lot, e.g. git show <pointer> would just
redirect automatically. Instead of a new class of "pointer objects" we could
also solve this via a lot of refs. (refs/old-sha1/4e55ed3 pointing to
the converted
commit; Though we would need to accept partial refs names then :/)

> --
> Duy
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
