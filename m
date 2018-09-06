Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066B21F404
	for <e@80x24.org>; Thu,  6 Sep 2018 19:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeIGA1O (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 20:27:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34260 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeIGA1O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 20:27:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id g33-v6so12666458wrd.1
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 12:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=u46ycPRTPcYYegMM7g9ve/HR+Qj5VMwU0lfmYQwwMCg=;
        b=KulM+eVemJT0FnarJ6XMQOM3qr4s/OYjCGLKTJNs40XazAClLEqKMqBmWHSxlNUnpI
         Fs5ChQ177PSVuJ/vSwceKKfHKvfYG/hX+9PGA69fD3kJGrdvIxUv3C5oVtIBDWP2+Ezf
         SrUOYpfFO//aVI31rWnLujXov2XRjsj+k0/bhGawbB5wpjAQahi914MLMGpfaQvlxgqk
         LYZhU44iWVYdrKYdw/41CNz5ySU+d4ijr6GTjBSMlGOgFow8GuY4lUk2yKE6W2gG/w5t
         b5p11Ob0xbGlZauOSs7/oGY2U6L3Yw2LeRX/nFmGYTu+DMPa/ZhlL1EfvXggv2cPAl5M
         C3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=u46ycPRTPcYYegMM7g9ve/HR+Qj5VMwU0lfmYQwwMCg=;
        b=flwbf0Bt5QvZAqakr+QQ5xv3cm5ntvNtqDxi8hTNWFL8cQYJbjEadacn0pGRVITYBC
         H2cTJZHvKslhIIV5P+zWmRwZSdTgjdql8xOGEaLUzxAPzgCNylGPptqjFEYRfJ22JW1R
         Y2izBajkIcWTzuMaBjgAhCbWhXDt+VQYlX1HxmBttY5DMANtN5nt2Ku9XQ+b16w/S8F7
         gGShabzVm7UXddVyZelvPY5EIGpQ/NWTN2jnUarHyy6f72WIUsoezPM7iyXkXqshXcVc
         z3wk9IXZU5fXlrflRXUP0Q17J/X7OJ5c6eB3jdTiuTOX/V9RjDUokYP241tz35KLBFTB
         C5kQ==
X-Gm-Message-State: APzg51CElCw+L6PVzNQY4r2CVPBk0GsKwQOMnVy6N5GViWgOAk9YDBE/
        hgxVShfwUbTdy7Wolu4kHgc=
X-Google-Smtp-Source: ANB0VdZcB0WkZ/F0PKL3MyqdFMYeCeN8CuZxoil+R2KK9SDsRSkb9uC7XGuFUqxG9WND0IzDkxxuaA==
X-Received: by 2002:a5d:4d52:: with SMTP id a18-v6mr3720162wru.40.1536263411565;
        Thu, 06 Sep 2018 12:50:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g17-v6sm4657066wmh.19.2018.09.06.12.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 12:50:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/18] builtin rebase options
References: <20180808152140.14585-1-predatoramigo@gmail.com>
        <pull.33.v2.git.gitgitgadget@gmail.com>
Date:   Thu, 06 Sep 2018 12:50:10 -0700
In-Reply-To: <pull.33.v2.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Tue, 04 Sep 2018 14:59:47 -0700 (PDT)")
Message-ID: <xmqqmusuz9ql.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch series completes the support for all rebase options in the
> builtin rebase, e.g. --signoff, rerere-autoupdate, etc.
>
> It is based on pk/rebase -in-c-3-acts.

... which in turn was based on pk/rebase-in-c-2-basic that just got
rerolled, so I would assume that you want pk/rebase-in-c-3-acts I
have rebased on top of the result of applying the updated 2-basic
series.

I've rebuilt the collection of topics up to pk/rebase-in-c-6-final
with these two updated series twice, once doing it manually, like I
did the last time, and another using "rebase -i -r" on top of the
updated pk/rebase-in-c-4-opts.  The resulting trees match, of
course.

I did it twice to try out how it feels to use "rebase -i -r" because
I wanted to make sure what we are shipping in 'master' behaves
sensibly ;-)

Two things I noticed about the recreation of the merge ...

	Reminder to bystanders.  We need to merge ag/rebase-i-in-c
	topic on top of pk/reabse-in-c-5-test topic before applying
	a patch to adjust rebase to call rebase-i using the latter's
	new calling convention.  The topics look like

	- pk/rebase-in-c has three patches on master
	- pk/rebase-in-c-2-basic builds on it, and being replaced
	- pk/rebase-in-c-3-acts builds on 2-basic (no update this time)
	- pk/rebase-in-c-4-opts builds on 3-acts, and being replaced
	- pk/rebase-in-c-5-test builds on 4-opts (no update this time)
	- js/rebase-in-c-5.5 builds on 5-test and merges ag/rebase-in-c
	  topic before applying one patch on it (no update this time)
	- pk/rebase-in-c-6-final builds on 5.5 (no update this time)

	and we are replacing 2-basic with 11 patches and 4-opts with
	18 patches.

... using "rebase -i -r" are that 

 (1) it rebuilt, or at least offered to rebuild, the entire side
     branch, even though there is absolutely no need to.  Leaving
     "pick"s untouched, based on the correct fork point, resulted in
     all picks fast forwarded, but it was somewhat alarming.

 (2) "merge -C <original merge commit> ag/rebase-i-in-c" appeared as
     the insn to merge in the (possibly rebuilt) side branch.  And
     just like "commit -C", it took the merge message from the
     original merge commit, which means that the summary of the
     merged side branch is kept stale.  In this particular case, I
     did not even want to see ag/rebase-i-in-c topic touched, so I
     knew I want to keep the original merge summary, but if the user
     took the offer to rewrite the side branch (e.g. with a "reword"
     to retitle), using the original merge message would probably
     disappoint the user.

I think (1) actually is a feature.  Not everybody is an integrator
who does not want to touch any commit on the topic branch(es) while
rebuilding a single-strand-of-pearls that has many commits and an
occasional merge of the tip of another topic branch.  It's just that
the feature does not suit the workflow I use when I am playing the
top-level integrator role.

I am not sure what should be the ideal behaviour for (2).  I would
imagine that

 - I do want to keep the original title the merge (e.g. "into
   <target branch>", if left to "git merge" to come up with the
   title during "rebase -i" session, would be lost and become "into
   HEAD", which is not what we want);

 - I do want to keep the original commentary in the merge (e.g. what
   you would see in "git log --first-parent master..next" that gives
   summary of each topic getting merged) so that I can update it as
   needed; but 

 - I do want the topic summary fmt-merge-msg produces to be based on
   the updated side branch.

I am not sure if the last item can reliably be filtered out of the
original and replaced with newly generated summary.  If we can do
so, that would be ideal, I guess.

Another observation was that after rebuiding pk/rebase-in-c-6^0 on
top of the updated pk'/rebase-in-c-4 using "rebase -i -r", I of
course still needed to "branch -f" to update pk/rebase-in-c-5,
js/reabse-in-c-5.5, and pk/rebase-in-c-6 branches to point at
appropriate commits.  I do not think it is a good idea to let
"rebase -i" munge these dependent branches by default, but it might
be worth considering it as an option.  Since I want to be more in
control of what happens to the tips of topic branches, I did not
mind at all having to run "branch -f" and having the chance to run
"diff" before doing so, but at the same time, that means doing these
manually in steps building 5 on 4, 5.5 on 5 and then 6 on 5.5,
instead of building 6 on top of 4 using "rebase -i" and then tagging
the intermediate states, gives me more control without forcing me
more work.

I guess that is the answer to a question you asked earlier, which I
haven't answered so far because I didn't have a good grasp of where
my preference was coming from when it was asked.  Now I know, so...

