Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9B8C203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 18:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756879AbcG0SH7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 14:07:59 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:33290 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbcG0SH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 14:07:59 -0400
Received: by mail-io0-f174.google.com with SMTP id 38so77755981iol.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 11:07:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I1Q3TGpU9YJDTk7StC7sBcxqllnWonmyxPTsASq6jes=;
        b=dBih3FhI5JyB93zgrPPCEOE0oETYjKSHwt0E7E8j4/djC5de3fRZ8LK+BxIiPUqjSa
         j/It5j2yAo0Y0LJ2hLWsq+uzwwAUR0N/d6JvdYOQIdbGdFCzcy1l6eMVozbwdxr1yIw0
         AcsuQ5L8yKIJQBLJdiY9nPve8b3uss5kx8XcSt4/RTYWExMlfG2TfWQN63t0c0AwRwG4
         gl+KlnwLep3gHecy0gns/gYTFgNAA+YbIqxTuBnH2s77YBQTqaLZ/93rOi8Wry9ygX9k
         NOZFZJXQhBoxJ9Pm06lZU5RIJf6qrziGLmFLkcQ7XDDZJ8PxvuXNPM7zYI5uMmkx5re1
         ZfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I1Q3TGpU9YJDTk7StC7sBcxqllnWonmyxPTsASq6jes=;
        b=lfnNSmeixqUavquHYTjZpZbhj5XBbfaH2ll2t9cT0eAxOaB9Al5JZetnHEt4UU94nd
         qm6QqPZvL2I9rVteVKZKXcZY7WtfCKqOgAblsoc6zzrtJkO4NqdSY9I+jLlKIr7g/guW
         8FLRHr0KKBQJpO7I50asufptFZJhXW78zcUkLp8pjU5XZ/a9Fkc7eL+0Rx8HWxnUEP0O
         uvYnuUCMR6ZZDLVDvr0VStMm3nkcUCdsgUarFWwOB5fwdKeMvadVW8hh8m/D7lOGjAsE
         0ohyHqot3zrXUL333mYRFFMvhDhlqQumDXcRsrToskSuspXC5iB5zjjNoSYc2QFWetK7
         LvRQ==
X-Gm-Message-State: AEkoouseffyF9J/VpSqhDTXP1oJm3Fe9cdeJdVpqYBSuLCTKffMv59SrCLPYQoYVQbyb/ZxhUx5ZQLMlpNffIw==
X-Received: by 10.107.8.140 with SMTP id h12mr35243875ioi.95.1469642878555;
 Wed, 27 Jul 2016 11:07:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 27 Jul 2016 11:07:29 -0700 (PDT)
In-Reply-To: <CAGZ79kYNFoAUu+5Y0oh221UeyAB3zan_36RgrhZnSi19Oe2vcA@mail.gmail.com>
References: <CACsJy8CMnywB8AdmLxB8LnsznHrMTieoezhaQS=2r1pnM8ONZA@mail.gmail.com>
 <CAGZ79kY5UrjSj8xbjB+MvTE2xUyt+te1RKN6Bf0WiEA23iZ7wg@mail.gmail.com> <CAGZ79kYNFoAUu+5Y0oh221UeyAB3zan_36RgrhZnSi19Oe2vcA@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 27 Jul 2016 20:07:29 +0200
Message-ID: <CACsJy8AuP-E1qHM_sJ4ZPpZDSk3s1KkuQOLB9B38+OUkobO11g@mail.gmail.com>
Subject: Re: Find a topic branch containing a commit
To:	Stefan Beller <sbeller@google.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 8:02 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Jul 27, 2016 at 10:50 AM, Stefan Beller <sbeller@google.com> wrote:
>>>
>>> PS. Sometimes I wish we could optionally save cover letter in the
>>> merge commit. Sometimes the "big plan" is hard to see by reading
>>> individual commit messages.
>>> --
>
> I had this wish, too. That makes a lot of sense for merge commits,
> although it doesn't work well with our current workflow I would presume,
> because the merge commit happens at a different time than when Junio
> picks up a patch series. And in the mean time, where would we
> store the cover letter information to not get lost?

We have config branch.xxx.description for that. If we teach git-am to
pick up (a selected portion of) the cover letter and save it in
branch.xxx.description (or even a new key like branch.xxx.mergeMsg)
then nothing is lost.
-- 
Duy
