Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3EA61F424
	for <e@80x24.org>; Thu, 21 Dec 2017 22:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbdLUW5n (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 17:57:43 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:39602 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbdLUW5m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 17:57:42 -0500
Received: by mail-qt0-f171.google.com with SMTP id k19so34342295qtj.6
        for <git@vger.kernel.org>; Thu, 21 Dec 2017 14:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=HokPglpKtsYh2uJsty84QKRcsdndiAooZyr4fbGP0vo=;
        b=bT/Bp0I6KLrEt7p6SzLrrb0ChmlNredl+afJWuKc2jnaFzJ9r4mAN+Yx2oXqY0aQZ4
         YoSJWjfiHJ14HEbvZOCONjygqrDzI4nK7JgN8YMQK0HngzpFHGbNASBAu64r4HoHldds
         GoN6kutBHj+xIE8LEyr3jJrCTXYF9DBKsE+ORDphllKGOeVMbO9e8NN6bQjzIFUpU1df
         B6v4xZ1HX/whB6fC625hUwIA9IpwPPMa5caWXsTlrsFt4ck8st4IgLe1gdJVIU8g9DTD
         CVBl1ynNSYvjOC5HEtx6AVO2AhTmSagWa2I515qh6KmgOc0dCfwx5iZ2kSC0w2hZO5gC
         0UKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=HokPglpKtsYh2uJsty84QKRcsdndiAooZyr4fbGP0vo=;
        b=UIOkaR3UY9A6HN2jMGKkfDapqA4745c0qjjY+dR4O9m00PIXuxZU2fa1uppTDxnkKR
         2BLSSK/lxtfq2bDwx/2ad73hZ7sp7O5j0IONS8Pp0gb7I2lcosMMkbD9Fg2a9aLKyNEp
         Fzwr8uvaI0FznhatgRkk8MZrx4VIZHHfIMFgjbzi7uTK3SNLOLKz16RHkekZiviKFhGF
         ycPyNQNYAPg5wjzkztEaUBV/RrBMTlwIYfBfomd6NXxASkLv3Xmxv29WMXTqPWGm/G/X
         xh8YOGE3L6WCG8RAyvV9eVH/xlL3CFS7srG8E0eymrd8E88I09IeUJFphgJb8C2umQuw
         gN8Q==
X-Gm-Message-State: AKGB3mKfKvmXjXfuaNjY+F+lSQyWSgBf0zHcBQARegZ3HYxAjriDOr4R
        b7EsNcvBcj/gKeYhgbiEuV9gTbiBYb1Nqib9GaVK3g==
X-Google-Smtp-Source: ACJfBov8XIpCm7tHLXNH+LmNinmkhvWRXmDaxkwNn2u8guYdT+QCTBnxCc5SmW24D9u2c6eL/5oEMpCziOGBlXX/xsg=
X-Received: by 10.237.61.181 with SMTP id i50mr18131477qtf.29.1513897061220;
 Thu, 21 Dec 2017 14:57:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 21 Dec 2017 14:57:40 -0800 (PST)
In-Reply-To: <CAPc5daUJXS9DJr7BRuKbNotKA-3kBnzHfn3566su+ZDwa+xc4w@mail.gmail.com>
References: <CAFBGMVPBwxeSXCTcoBdxDbYtJo-38w=tf4T6-rNWuys=3drP+A@mail.gmail.com>
 <20171219180230.254881-1-sbeller@google.com> <xmqqk1xitl6l.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbqntXuYuLGF7zjXfQ5X998QdEba20yy8A0cqS=DaRxFA@mail.gmail.com>
 <CAFBGMVO+P99hJ_nKgCJ4OqhMEdRdc3m8KHNS1pPrrhU_0wS6=A@mail.gmail.com>
 <CAGZ79kZf8GL1DY6Vmc-byEOOy+hrKF8X8qRPM6jNO-La+rD4uw@mail.gmail.com>
 <CAFBGMVMmLX4BjkQ8Xd4bQBCgoYYxWTU-p2pNF=b8JNsUsKXwUA@mail.gmail.com>
 <CAGZ79kauYRLaPKsUKxvsc-T+KzMt2UsyoDLzdyZON_vjp6y28w@mail.gmail.com> <CAPc5daUJXS9DJr7BRuKbNotKA-3kBnzHfn3566su+ZDwa+xc4w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 21 Dec 2017 14:57:40 -0800
Message-ID: <CAGZ79kYRYHdpyXD+VtO-Xhg_BqTkrj4qgbgEFK7opQGXGhNiAw@mail.gmail.com>
Subject: Re: [PATCH] Re: Bug with "git submodule update" + subrepo with
 differing path/name?
To:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Andreas Urke <arurke@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 21, 2017 at 2:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> That sounds like a bit of revisionist history, but you weren't around
> back then, so...
>
> https://public-inbox.org/git/11793556371774-git-send-email-junkio@cox.net/#r
>
> is my summarization of discussions before that time. There is a
> mention of "three-level"
> thing by Steven Grimm in
> https://public-inbox.org/git/464E4C94.5070408@midwinter.com/
> in the thread, and together with messages like
> https://public-inbox.org/git/7vejle6p96.fsf@assigned-by-dhcp.cox.net/
> you can see that we already knew that submodule identity (name), path
> in the superproject (path) and where it
> comes from (url) need to be separate things that need to be tied
> together by .gitmodules.

Taking this private reply back to the list, I hope you don't mind.
I think linking into the archives (hence making the huge unstructured
archive a bit more discoverable by these links) is a good idea.

Yes, I was not around when these discussions happened, hence I came
up with a narrative that I can rationalize best.

This message https://public-inbox.org/git/464CF435.1010405@midwinter.com/
helps (me) most as that states the problem that need to be solved and I agree
with the issues and how to solve it. The "symbolic names", however, are the
crux there. They must not be changed, so as Andreas says, maybe "ID" is
a better notion than "submodule name".

I am of the opinion that we'd even want to go as far as to not expose
this symbolic to the user.

So if we redesign from scratch, I would not have "gitlink entries"
but rather "special blobs"[1], that contain the submodule sha1,
as well as their ID.

A special blob could look like:

  git cat-file "kernel/"
  version <sha1>
  id <another hash value, determined at creation time>

Additionally you'd have slight guidance of id -> URL in
an extra ref, versioned independently of the main history:

  <other hash> -> git://kernel.org/...

(A)
So if linux moves away from kernel.org, you can change that ref
independently of your history at that time, such that even old
versions of your main history can obtain the kernel from the correct
URL. Of course a porcelain command could do the double lookup
such that the user can say "kernel/ -> newURL" without needing
to have knowledge of the internal ID.

(B)
Now if you want to move the submodule locally, you can do so by
having that special blob at a different path in your tree.
git-mv "just works" even for nested submodules. No need to
rewrite the .gitmodules file.

(C)
What if you want to drop linux and use some BSD?
Then you change the ID such that a new submodule repo
is created inside .git/modules/. Of course it is also pinned
to a different sha1. A porcelain command such as
"git submodule replace" would sound like a good porcelain-ish.

I think this so far is a clean design, but it is incompatible with history.

The really big difference is that the ID is the core thing that everything
revolves around (similar to the submodule name), but is tied to the path
and is hidden as much as possible from the user, who can use given
commands for each of the scenarios.

The big flaw of this that the ID is sort of random and not based
on content, which is counter to Gits philosophy as a content
addressable FS. Maybe the ID can be set to
HASH(<first version> +<path>), such that when two people
independently of each other make a submodule pointing at the
same commit at the same path, they'd have the same tree-id.

Thanks,
Stefan

[1] An in office discussion hinted at that "special blobs" are not
that special. git-LFS uses this mechanism, but of course their
design flaw is to keep it out of main-Git. But one could posit
"submodules can be implemented using smudge filters alone".
