Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06BF71F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 20:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJJER6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 00:17:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44017 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeJJER6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 00:17:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so3305475wrt.10
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fYnjw0rFj4X3/SZxi/Xm24FzKeRs3FTPStkgNdna2R8=;
        b=LOFXLvGj3DpEznEHTu1eNEm1l2sR+UhhRk+ujSthf7dyA+3BWXUInWlzF0wqxIOAUj
         0uFx4g4ItYcWeTHDGP1G0HJ6PjNqkgD6vqev2O0RdublO4z8WBrOpbWHXawDSFuXTCY4
         ifsP1mCqM7qRbK901EHj+TDHYUe8M/p0qcezbVAs5BIrg+aqxBDLLRekUhnYkTglPu22
         GJAheimogucDgdpmNqhb7X7/pU/A/d5fPppa8Sctj93WG3EeLTqBISf/M55RWTAZpkON
         boEKBZZIsgmFGHIiqipCPvz1aEaehCAirbI+dbwhwBe/wad/Gl4SwoHy+HyGkV3Bgubg
         hjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fYnjw0rFj4X3/SZxi/Xm24FzKeRs3FTPStkgNdna2R8=;
        b=tRTXe0TCsLUw0TuenrUck/8A+T+iUjmoLE7aKdyENGuSKUqNuDByh8cZOx14badH6U
         5Mb4eD+gdb1E7/nkTOeijQlKsWkgh+T0hxzXi9TnCMEDHSTYu4ksDP6C5IRyjH31h0Az
         UAMd4nz0ffrGLIr8ePNJe6HOhh2bDiJiBxxLvb1fwStVn9CkSm28zxcji1jvzG8qsPC3
         Fm9vPyZjHeSBx33zHhAc0b/gI9K3FzfmpwlkOaNqt4TKl2hpgwmjFLBl+Tn7L39qgOs2
         TDSTHE+SxzMGFrq4MDocFWusS1qFp49+LDNSYUHw2kL3WM+Tky+FdpxkXo2B8OsSBxia
         dsCw==
X-Gm-Message-State: ABuFfogo2sByFkP5B0mOYTgcOoTM6dtL9mSyJaTXUF9+/Oz4yllVSK5c
        SmPMT9jtojEb2TBKwLma2AU=
X-Google-Smtp-Source: ACcGV61kuoYODQgMZAKuLbeL93Almg5S7Bfve7jVgvVryLEycWRhUhxDWGTzlG/lo3aeZpm0uNgipQ==
X-Received: by 2002:a5d:4cc3:: with SMTP id c3-v6mr2565113wrt.75.1539118748144;
        Tue, 09 Oct 2018 13:59:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z184-v6sm17082725wmz.0.2018.10.09.13.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 13:59:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] branch: introduce --current display option
References: <20181009182006.9446-1-daniels@umanovskis.se>
Date:   Wed, 10 Oct 2018 05:59:05 +0900
In-Reply-To: <20181009182006.9446-1-daniels@umanovskis.se> (Daniels
        Umanovskis's message of "Tue, 9 Oct 2018 20:20:04 +0200")
Message-ID: <xmqq8t36q1k6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniels Umanovskis <daniels@umanovskis.se> writes:

> I often find myself needing the current branch name, for which
> currently there's git rev-parse --abrev-ref HEAD. I would expect
> `git branch` to have an option to output the branch name instead.

[jc:  wrapped an overlong line]

If "git branch" had many operations that work on multiple branches
by default, and we were adding an option to work on a single branch
that is currently checked out, then I would find "--current" is a
very good name for an option that turns all these operations to work
only on the one that is currently checked out.

But I do not think that is what is going on.  There is "--list" that
lists branches whose name match given patterns, and at the end-user
level (I haven't seen the implementation) this is another mode of
that operation that limits itself to the one that is currently
checked out, and you do not even allowed to give the "--list" option
explicitly so that in the future when "git branch" learns to perform
an operation other than "list" (let's call it 'distim') to bunch of
branches by default, you cannot say "git --distim --current" to
limit the distimming to the branch that you are currently on.

I do not offhand know if we want "show the current one only" option
that is "command mode" sitting next to "list", "delete", "rename"
etc., or "limit the operation to the one that is currently cheked
out".  If we want the former, the name of the option must *NOT* be
just "current".  Have a verb in its name to avoid it from getting
mistaken as a botched attempt to do the latter.  Somethng like
"--show-current", "--list-current", "--display-current", etc.

Even if we were doing the latter (i.e. focused "this is only for
listing/showing"), if we do not want to close the door to later
extend the concept of "current" to the former (i.e. "--show-current"
becomes a convenience synonym for "--list --current-only") we also
need to think about what to do with the detached HEAD state.  When
the concept of "current" is extended to become "usually an operation
can work on multiple branches but we are limiting it to the current
one", detached HEAD state is conceptually "not having any current
branch".  We could fail the operation (i.e. you told me to distim
the branch but there is no such branch) or make it a silent no-op
(i.e. you told me to distim no branch, so nothing happened and there
is no error).

My inclination is to recommend to:

 (1) name the "show the current one" not "--current" but with some
     verb

 (2) display nothing when there is no current branch (i.e. detached
     HEAD) and without any error.





