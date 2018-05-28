Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6401F42D
	for <e@80x24.org>; Mon, 28 May 2018 17:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755685AbeE1R4Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 13:56:16 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:52383 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755681AbeE1R4P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 13:56:15 -0400
Received: by mail-wm0-f44.google.com with SMTP id 18-v6so28432246wml.2
        for <git@vger.kernel.org>; Mon, 28 May 2018 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lwhiB+gTMeNe9OlHIiNSRy6yTJnJVM4iw0/Sz1XUxjA=;
        b=ikdHBqFM+E45+o49LBKXb4HLU0Q0l39Lb2G4drXD0XZMsl+U7beiWo/Pwg7k/mPSZ+
         xAJ+4pYT4fuwBAeoX7aDf8z9OltrqU++XylVQwEq9KizbJUqfgubt6sebHLvGnrg9CWy
         45E6LT2Dqk75s0ishSxM+8PJXr4GhMWyePbMSbNQTACOLnBQcf0ts/wU6x6zWu1b3DBQ
         LqOmRiTdayyg21AAZwUONjfvfE8MwrVRxPevfF4j7080llFurfJ4xa9zyZfPr0FRLExZ
         OmrT0zFbGbBq/1HaOUXEYisWUCddB37utOHJvCLctAxyXITSNm/GcEt8pMkw6BI3XTE+
         N/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=lwhiB+gTMeNe9OlHIiNSRy6yTJnJVM4iw0/Sz1XUxjA=;
        b=WKvDhPWot8ELubIFF8m/5da69g8dP5BnWZ7GDvCJiPxGGO2YYTujTycub0orupXXJg
         cgH9cW61Fi0Hq8ida4CsSIc+7f/89zxjtOOrEiuZ0hrhxe2M5dWVnvUa2JsyYoI4Umct
         12afYKBiwtrIizNyO4NLZet82vjXGt/vcuq1QTy0u30wgsrRUPBW6+wUCgIyiD/ovDR+
         LQphbLHuxKQR81Y60t80oF9KH1EswjkuMvSaNB8b+ZJMwCVvIQPWphMaAX6OmIs2DgTA
         sA953QBgZmwWgLGJrZetoSvYGE66d7CpNMywZYX06xGX3EVP/6ACjuNAAPqSUGQi9V4/
         wTbA==
X-Gm-Message-State: ALKqPwf1aTHNjkj/lfJp6G3x5Hvkz2aF4hLfyd5tZVbALb6Ia4a6OkZa
        4A/6m2qAMFQJj7AFUxi08LyXOUzP
X-Google-Smtp-Source: ADUXVKJNcGDFlCLAlAsFEzKiJ/HrGeiqEdzFxsKpt1PtJMvvYmZezYQWqW1gbz574jMolPXdTTKTNw==
X-Received: by 2002:a50:aec8:: with SMTP id f8-v6mr7200614edd.72.1527530174070;
        Mon, 28 May 2018 10:56:14 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id z44-v6sm2798056edb.72.2018.05.28.10.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 10:56:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: does a new repo actually *need* default template content?
References: <alpine.LFD.2.21.1805280836140.10191@localhost.localdomain>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <alpine.LFD.2.21.1805280836140.10191@localhost.localdomain>
Date:   Mon, 28 May 2018 19:56:12 +0200
Message-ID: <87h8mr7jgj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 28 2018, Robert P. J. Day wrote:

>   (apologies for more pedantic nitpickery, just little things i'm
> running across in my travels. aside: i actually teach git courses, so
> it's a bit embarrassing that i don't know some of this stuff. *sigh*.)

Aside from maybe the empty branches/ directory (see c8a58ac5a5 ("Revert
"Don't create the $GIT_DIR/branches directory on init"", 2009-10-31)),
none of this is needed.

I wish we didn't create any of this stuff, but have never been inclined
to make that my hill to die on.

I think we're much better off just shipping e.g. a single README file in
hooks/, or just nothing at all.

We should at least do something different on "git init --bare than" a
plain "git clone". By a quick check I have 20MB worth of 4 thousand
copies of 36 unique variations .git/hooks versions in my local area
where I clone random stuff to, none of which uses any hooks.

I think we shouldn't do anything on --bare either, except maybe a small
README_GIT_REPOSITORY_FORMAT which would refer to
gitrepository-layout(5) and a system-wide template directory.

This might have been more useful back in the early days at a time where
it was common for git users to host their own repositories, but almost
nobody does that anymore, and if they do they're expert level users who
can just get these hooks with a "cp -R".



>   running on fully-updated fedora 28 system:
>
>   $ git --version
>   git version 2.17.0
>   $
>
>   is there anything in /usr/share/git-core/templates/ that is actually
> *essential* when initializing a new repo? this is what's in my
> directory by that name:
>
>   ├── branches
>   ├── description
>   ├── hooks
>   │ ├── applypatch-msg.sample
>   │ ├── commit-msg.sample
>   │ ├── fsmonitor-watchman.sample
>   │ ├── post-update.sample
>   │ ├── pre-applypatch.sample
>   │ ├── pre-commit.sample
>   │ ├── prepare-commit-msg.sample
>   │ ├── pre-push.sample
>   │ ├── pre-rebase.sample
>   │ ├── pre-receive.sample
>   │ └── update.sample
>   └── info
>       └── exclude
>
> but none of that above looks critically important.
>
>   "man gitrepository-layout" describes the "branches" directory as
> "slightly deprecated", the default description file has a generic
> "Unnamed repository" message but, hey, so does the git source code
> repo itself, the hooks are all "commented out", and the info/exclude
> file effectively has no content, so i'm guessing that nothing there
> actually needs to be used to populate a new repo via "git init",
> correct?
>
>   under the circumstances, then, should it be a viable option to
> initialize a new repo while specifying you want *no* initial template
> content? it appears you can do that just by specifying a bogus
> template directory (or even /dev/null) with "--template=", but that
> generates a "warning" -- does a selection like that even merit a
> "warning" if it's clear that's what i'm trying to do?
>
> rday
