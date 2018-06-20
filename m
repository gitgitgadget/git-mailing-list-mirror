Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED8E1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 16:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbeFTQ15 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 12:27:57 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41998 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753960AbeFTQ14 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 12:27:56 -0400
Received: by mail-ua0-f195.google.com with SMTP id x18-v6so96818uaj.9
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g+0E8BPq/3s5+3q/Q/UNNpp3qlvZZq+Z426b1WvbCfQ=;
        b=UCIlANTL2WZlAhxBqAbOnyZs2UNYsDshJLg6P637ZVsRzyN8wDkCyRwjhBYV9ky0Aj
         OtgVZWf88F6ZxfcVJ2g/CVqZD3XZTkMZhojZ6mymr5Q6h691ZL7UeAVO262DnWGEE603
         iHb5NEZ+2vRgP/BcLGR+J9u80104qj720cfMQHNrk+QMyIYh+WpfWWhJd1UhZ+2RsQc7
         bz9tcknWnQa2eH1dRf61LKIWihlKsRkaVyRT0cVyfr3BUxr4ryLRs82CHK8dFvVaQ6/f
         uj5YxQxBXCi0UEAL9ehghUI76LYSsemS5j4EwwR88oTnhk6ZxbFLE1FUvbfDL5MTq9oN
         tgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g+0E8BPq/3s5+3q/Q/UNNpp3qlvZZq+Z426b1WvbCfQ=;
        b=Um3k/IFd/BwUwFBYxHddXT58jy4nyFfKRb0Q2TASUQF0tmipWgiJqh60cQZQySLV/Q
         ft9u3uMQ4pqEDpQf7o2B7znv5wwBde61QFuYkbkDPRAAEFDSGL6PY9gTGjJOe3oKo7jK
         sItDIYVW7edV0Nmmpqa5kk+OVbBt+ffLlxCGHSNXERZKY21sa0JHWYHqRswB6VfdoBI1
         1+vReJvxLUapTMJgGVMlh/wyvPYcUQjoDewqLW8uZXPtTpNqp/EywWXuVRazvlREUnP7
         cCmBUsTBNXvFcwI5Zx6zRxMWm5NhcVwOzjIUrOcpFOeIUqrIcdeFkIxRxB0DKAw9lH8v
         5CUg==
X-Gm-Message-State: APt69E00OnbcGtIBhujsb6vJsPqEIkxMPEvMvx+r5CJv2yo36rCAIBAR
        edmkKNo9wsaHSV+QZPWXL9J2++n0r/8icHmrfjU=
X-Google-Smtp-Source: ADUXVKK50R61X7FHBSI2EOgAa2p36QPqPW3/Io7HA67/OtizcvzJY9BWqp2Yt/wLjb/2YicbwexbdIZjwyeAo+ZytLc=
X-Received: by 2002:ab0:84b:: with SMTP id b11-v6mr13939051uaf.79.1529512075259;
 Wed, 20 Jun 2018 09:27:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 09:27:54
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1806172337340.77@tvgsbejvaqbjf.bet>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607171344.23331-1-newren@gmail.com> <20180607171344.23331-4-newren@gmail.com>
 <nycvar.QRO.7.76.6.1806100006000.77@tvgsbejvaqbjf.bet> <CABPp-BHa+sxuFBa3EmSyio28ytF_ORn950Keh1P=L-VxXtOwMw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1806172337340.77@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jun 2018 09:27:54 -0700
Message-ID: <CABPp-BEnJ4q9WGi4BgikpLJ9Aty5-3MR4VozjBk7ie4rGMc-ng@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] git-rebase.sh: make git-rebase--interactive the default
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Sun, Jun 17, 2018 at 2:44 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> I was really referring to speed. But I have to admit that I do not have
> any current numbers.
>
> Another issue just hit me, though: rebase --am does not need to look at as
> many Git objects as rebase --merge or rebase -i. Therefore, GVFS users
> will still want to use --am wherever possible, to avoid "hydrating"
> many objects during their rebase.

What is it that makes rebase --am need fewer Git objects than rebase
--merge or rebase -i?  I have one idea which isn't intrinsic to the
algorithm, so I'm curious if there's something else I'm unaware of.

My guess at what objects are needed by each type:

At a high level, rebase --am for each commit will need to compare the
commit to its parent to generate a diff (which thus involves walking
over the objects in both the commit and its parent, though it should
be able to skip over subtrees that are equal), and then will need to
look at all the objects in the target commit on which it needs to
apply the patch (in order to properly fill the index for a starting
point, and used later when creating a new commit).  If the application
of the diff fails, it falls back to a three-way merge, though the
three-way merge shouldn't need any additional objects.  So, to
summarize, rebase--am needs objects from the commit being rebased, its
parent, and the target commit onto which it is applying, though it can
short circuit some objects when the commit and its parent have
matching subtree(s).

rebase -i, if I understand correctly, does a three-way merge between
the commit, its parent, and the target commit.  Thus, we again walk
over objects in those three commits; I think unpack_trees() does not
take advantage of matching trees to avoid descending into subtrees,
but if so that's an optimization that we may be able to implement
(though it would require diving into unpack_trees() code, which is
never easy...).

(Side notes: (1) rebase --merge is basically the same as rebase -i
here; it's path to reaching the recursive merge machinery is a bit
different but the resulting arguments are the same; (2) a real merge
between branches would require more objects because it would have to
do some revision walking to find a merge base, and a real merge base
is likely to differ more than just the parent commit.  But finding
merge bases isn't relevant to rebase -m or rebase -i)

Is there something else I'm missing that fundamentally makes rebase -i
need more objects?

> As to speed: that might be harder. But then, the performance might already
> be good enough. I do not have numbers (nor the time to generate them) to
> back up my hunch that --am is substantially faster than --merge.

I too have a hunch that --am is faster than --merge, on big enough
repos or repos with enough renames.  I can partially back it up with
an indirect number: at [1], it was reported that cherry-picks could be
sped up by a factor of 20-30 on some repos with lots of renames.  I
believe there are other performance improvements possible too, for the
--merge or -i cases.

I'm also curious now whether your comment on hydrating objects might
uncover additional areas where performance improvements could be made
for non-am-based rebases of large-enough repos.

Elijah

[1] https://public-inbox.org/git/CABPp-BH4LLzeJjE5cvwWQJ8xTj3m9oC-41Tu8BM8c7R0gQTjWw@mail.gmail.com/
(see also Peter's last reply in that thread, and compare to his first
post)
