Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0539120986
	for <e@80x24.org>; Fri,  7 Oct 2016 17:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964993AbcJGRZr (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 13:25:47 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35501 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941335AbcJGRZF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 13:25:05 -0400
Received: by mail-qk0-f172.google.com with SMTP id z190so36441183qkc.2
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=obFnh2ZeH5PiN+vDk2zMN9yq0Pzjdr6awWibBKp6x90=;
        b=cHBVtTsL4NmIwnNFdYuplH7EUFFc42mqmtjCSZLxp00mPMOIRcBuCSHudG0z058/3A
         NTg51qnr1rKFgGLNftHbb9zrwOHqXGOtDnabTY+CmLxtJIp8vZl1K44ustUEktOldtZq
         T6pWSWvWzfCSi1JaTJswVwdoURXIN57yhuce9Hgf2lYVVpxM1jcgyKiCzJ+xck/t7ye1
         7pupU3I6DOQyuATNDVOQ1b0+T7XCNGwri/Ad8TD6mWgMeG2NTHWEqwxphC9S5kozP8BQ
         Me3Tibp15kwP1KJQC5Nov7I0XZlaBBDxDaJ6h3GS0sMQHnn7+sNIznMByDgbRlV0BpB/
         iL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=obFnh2ZeH5PiN+vDk2zMN9yq0Pzjdr6awWibBKp6x90=;
        b=k3g93HiQnTzJPIp5hSGaPz6O99yQwp8Balc04B0SaI8rncwlBszhbL+eu0rmHYtOxo
         2pTgL7qQOsDd67/P6l5dW+ZhCHaFHLTvwy/UD3h2w0J4qO9QluQJ/66dFAfyDu5ZjgU8
         qYQyxIBwNvYEXSnKvxnqgtf8CzkTce2Bl0gQIiz4BwLGKhKZUtYE2RENvazzWT/SBeVB
         CUSrUHHPaQJ4xRJzq/tF6HN48OvjLqod1GFMZxnEQ6qbIuXbquO5m0aFN3WVNK8foxmE
         ISjsHzT+qv+q4in5QxS/moYanT4ES3c+lqDh2I+AT8gBF8cIayn69Gk55Fa1i34kPYWS
         Csbw==
X-Gm-Message-State: AA6/9RmtIuFavHAIjURWZdd9S56J9L4zjgWw6g/iMQ5OznhbH7ye0kztAkoeflrFWtSFKi4rnmhO6B0/Mss4DqkX
X-Received: by 10.55.36.131 with SMTP id k3mr19513627qkk.86.1475861104516;
 Fri, 07 Oct 2016 10:25:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Fri, 7 Oct 2016 10:25:04 -0700 (PDT)
In-Reply-To: <20161007125239.GB61543@book.hvoigt.net>
References: <20161006193725.31553-1-sbeller@google.com> <20161006193725.31553-2-sbeller@google.com>
 <xmqqshs9i6fr.fsf@gitster.mtv.corp.google.com> <20161007125239.GB61543@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Oct 2016 10:25:04 -0700
Message-ID: <CAGZ79kbg1KaeL14DMcV=ObaZOBpJpxOZAEYY1mmf8eqDUUqYmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] submodule add: extend force flag to add existing repos
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2016 at 5:52 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Thu, Oct 06, 2016 at 01:11:20PM -0700, Junio C Hamano wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>> > Currently the force flag in `git submodule add` takes care of possibly
>> > ignored files or when a name collision occurs.
>> >
>> > However there is another situation where submodule add comes in handy:
>> > When you already have a gitlink recorded, but no configuration was
>> > done (i.e. no .gitmodules file nor any entry in .git/config) and you
>> > want to generate these config entries. For this situation allow
>> > `git submodule add` to proceed if there is already a submodule at the
>> > given path in the index.
>
> Is it important that the submodule is in the index?

If it is not in the index, it already works.

> How about worktree?
> From the index entry alone we can not deduce the values anyway.

Right, but as of now this is the only show stopper, i.e.
* you have an existing repo? -> fine, it works with --force
* you even ignored that repo -> --force knows how to do it.
* you already have a gitlink -> Sorry, you're out of luck.

So that is why I stressed index in this commit message, as it is only about this
case.

>
> [1] http://public-inbox.org/git/%3C20160916141143.GA47240@book.hvoigt.net%3E/

Current situation:

> clone the submodule into a directory
> git submodule add --force
> git commit everything

works fine, but:

> clone the submodule into a directory
> git add <gitlink>
> git commit <gitlink> -m "Add submodule"
> # me: "Oh crap! I did forget the configuration."
> git submodule add --force <url> <gitlink>
> # Git: "It already exists in the index, I am not going to produce the config for you."

The last step is changed with this patch, as
it will just work fine then.
