Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7401D20951
	for <e@80x24.org>; Fri, 17 Mar 2017 22:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbdCQWWL (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 18:22:11 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33356 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbdCQWWK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 18:22:10 -0400
Received: by mail-pf0-f169.google.com with SMTP id e129so4224242pfh.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 15:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VzrXDlAKyRU/vEuU///kb0vuaGY1DTbaFzluKDsgrTg=;
        b=BvQPKHOX3KWY3HkrwKQx2puso201a83jbY41ZkI3d1ek7JKbldsVzXMRTzI1xxfmcN
         l2F0o/QYHSaJXE//b9I7HDtUBMkfQPZCRy8FZnzn9ApsiL2pqpDuc44jx1zErI9mABWr
         jmzFzLfPKJF6vVjX2yRZ/XMygODSvghpfRaoiiu2SbKqoHEpttAtJfIw36EwZ6FEY0Ez
         0Bc4oi5Qf9C+4AiqiiolsuDUyqY/4yeXK+Y+p3crNScT+ge2bSSaiUKRcdGIbllS7LMA
         wlPgBiwF/leduuG2MUTQCWD8lwVQFUUHXnYD+61k7+oAEyQuwj68qzoqftspntaJ8q29
         7f+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VzrXDlAKyRU/vEuU///kb0vuaGY1DTbaFzluKDsgrTg=;
        b=MUQQ9MMOL9IHtteVuibfCttiYxDXi4KoXJfZ9FfmH6mCLmAgzRSL9EJudb20mlvUVO
         QSNpZOuQjEcOU7DZzTyxMhKj9wIIimZL53GYkbCd7rytxsz7cP3uThJVEIYCkRmkdhrU
         mDHV7yAEWHXYKfp+KTzgjj8jBRgjl8uodAgiKQ0w/fzZ6O0Fnt2E8NJ0hg4mhm2Vxb3y
         4R93wVev0EONN6T9FtwhjxpRXpbprH4pYG6jUz9J41o1ErYaqjWVlT37MjuNyLKisvzN
         exBcKRlYSqD1SvgxT+klZW+hIuKOrQoJYD8+c30wA3KtgpjrJsHMwrEOYuYX2j17RyFJ
         Y4wA==
X-Gm-Message-State: AFeK/H0TuFRzPeRos3MRqJfJQ49IelfYuTWy0DW0wCW7sg3XovaPu6RNhEMQTG3MAx+9/PbW9VEFPfbhj8CB1r+1
X-Received: by 10.99.119.139 with SMTP id s133mr7351656pgc.194.1489787929075;
 Fri, 17 Mar 2017 14:58:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Fri, 17 Mar 2017 14:58:48 -0700 (PDT)
In-Reply-To: <xmqqmvcj61j2.fsf@gitster.mtv.corp.google.com>
References: <CAPUVn2u0Uos2mT5+4ejj8m0okNK6XwerL6ce2miHfhtuEs-ZnQ@mail.gmail.com>
 <xmqqmvcj61j2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Mar 2017 14:58:48 -0700
Message-ID: <CAGZ79kZQsauBfoTjyqm+-+LjyyEc2Ykj5exUY5KdErEzFH0GMA@mail.gmail.com>
Subject: Re: Bug with .gitignore and branch switching
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nevada Sanchez <sanchez.nevada@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 2:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> We've discussed the lack of "untracked but precious" class a few
> times on the list in the past, but I do not recall the topic came up
> in the recent past.  It perhaps is because nobody found that class
> useful enough so far.

My gut reaction on reading the bug report was that the root cause is
git-checkout doing the wrong thing by default. (cf. Git-Merge-2017,
"What=E2=80=99s Wrong With Git?", I am not sure if the video is yet availab=
le)

One argument in that talk was that Git promises to do "work on multiple
branches in parallel (context-switched, single threaded)", and git-checkout
is the apparent command to switch to another context (branch).
However by putting away only tracked content, we miss
doing a proper context switch for untracked and ignored files.

That partial switch has advantages in the typical use case, e.g.
* compiled objects in the worktree may not need to be recompiled.
* no need to do work for the untracked files (e.g. move to a special
  location).

Both these reasons argue for performance, instead of "correctness"
in the sense of "easy-to-understand commands for top level principles".

And in that talk the presenter concluded that git-stash was only invented
to circumvent these "correctness" problems, such that if git-checkout
were to also (de)populate the untracked and ignored files on branch
switch we would not need git-stash, because git-checkout did it for you
already. And by the omission of git-stash and an apparent
easier-to-understand git-checkout the whole git suite would become
easier for users.

I further conclude that when git-checkout were to behave "correct" as
outlined above, then this class of bug reports would not occur.

Just food for thought.

Thanks,
Stefan
