Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AAD41F404
	for <e@80x24.org>; Mon, 19 Mar 2018 00:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754776AbeCSA1b (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 20:27:31 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:39382 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754531AbeCSA1a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 20:27:30 -0400
Received: by mail-qt0-f173.google.com with SMTP id v11so8414930qtj.6
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 17:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=bofJywg7Po6X9rENIpAK0IDp879NPjy9xVljdVc0jSw=;
        b=sKLWnL13EFK6ZXVynfWxm1Rtaw1EeHOHcLD7PF35Chcx1sHJyuw+DSdflc9F+q+lxA
         KhWn7KKxfMXQFMzTvIWF+nciEcjE0D4YWSd6uo+QxEZFm/9BEMhYC4d4Kn34cozIrGq5
         LMStEpIruGjprNpW1NS1w8rkDjEuyK/AsIkN+DVMQMgvNZn1hP2WRJ9CdxKP+KxeADrJ
         p51IvI/8rSUsxGa7tCCzqo08IeWyMs+JK3xoK7BHcmWcFc06q4tg524qgkXvRDfYKV5m
         aY8ODH3e0NxbR+mdpR2df3yzhUrPFxsxjsrE4Gcd5cXck9iLMFOx7MLpmj5qn1ERS99t
         Ywtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=bofJywg7Po6X9rENIpAK0IDp879NPjy9xVljdVc0jSw=;
        b=bjFcl2UD66q8cxW6HzFOdVUapEn9UT+zgE/Nnx1b4KShwWCa4XMTchpTdKoKnxuIO4
         aDIcIbukBtQ52mLg4V2Ce8YLiCjzUIizvG4QxtcXToCY+p6eHCBVZUx8mC8cmkLyvKI2
         +EEXzyyB4mDsiXyRvpAB9b2NaeeNSkhH4EAeDtUhM0l9uYUDtNLPXORRlw0sRA08wsFv
         ilxA9FTHpt8NYrUj4/dWoxnUbGPOxtNpzxaHZBhy+k2luowRIqKlfqcXusG2YNPQUy8+
         S5E4cuz35a7AvHcZISjWvOWtQH66v00OTjDzoQAG/8yt05D9H9/ys/7CBgoCc8rNJTBv
         mtPA==
X-Gm-Message-State: AElRT7EUeZVtEyGUYPNTI54GoV1eooV95otNYPV79v8G+CwXW07Xedqj
        CKSkFCPapfwARZnPujdIGpMhI7RoibGIQvVwJxb/7A==
X-Google-Smtp-Source: AG47ELsJ7xvdjShhcW5qSqXdsVYxaePXPsNiEYPjWbxppHDa3cPQmYCBuEgKmnMewkwXC1SLYX2mmimzZiLDWr3aP2A=
X-Received: by 10.200.42.15 with SMTP id k15mr15707932qtk.101.1521419249530;
 Sun, 18 Mar 2018 17:27:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Sun, 18 Mar 2018 17:27:28 -0700 (PDT)
In-Reply-To: <16afd6f7-110f-18c0-f7f4-9cadf0b69db9@projektwerkstatt.de>
References: <3166da20-14f8-50bf-3913-03b18673203d@projektwerkstatt.de> <16afd6f7-110f-18c0-f7f4-9cadf0b69db9@projektwerkstatt.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Mar 2018 20:27:28 -0400
X-Google-Sender-Auth: IDu8-gWe7RTg_Fcjb2KnHYtMXRI
Message-ID: <CAPig+cTxgnUUrdCD3fUeM=90mLNhOTHOwtL=_Gd6AH8owiyV7A@mail.gmail.com>
Subject: Re: user-manual: patch proposals and questions
To:     kalle <kalle@projektwerkstatt.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 7:49 PM, kalle <kalle@projektwerkstatt.de> wrote:
> 1.I wonder, why the "user-manual" is so hidden on the (official?) site
> git-scm.com [it is accessible at git-scm.com/docs/user-manual ,but is
> not viewable in /docs ]

The git-scm.com website is maintained as a distinct project[1] at
Github; it is not directly related to the Git project itself. A good
way to voice your concern about the website is either to open an issue
ticket[2] or submit a pull request[3] if you have a specific change in
mind.

[1]: https://github.com/git/git-scm.com
[2]: https://github.com/git/git-scm.com/issues
[3]: https://github.com/git/git-scm.com/pulls

> 2.I did not receive an answer to my mail. Maybe it could have to do with
> a possible stopped maintainment of the 'user-manual'

More likely it was because your email was not composed in a way for
people to digest and respond to it easily. There are some things you
can do to help make it easier for people to respond:

* Send patches inline rather than attachments since it is much easier
for people to respond to them directly when inline. When they are
attachments, people are forced to open the attachment, then copy/paste
parts of the patch back into the email for response, and most people
won't bother with such effort. Also, make each patch a separate email
with a meaningful commit message ("git format-patch" and "git
send-email" can help with this).

* For your questions about documentation, quote the section of
documentation you want to talk about directly in your email, then ask
a question about it. This saves people the effort of manually having
to open the file and locate the line or paragraph in question. Also,
line numbers change as changes are made to files, so the line number
you cite might not match the line number in a version of the file
someone else is looking at.

> 3.it would be for non-graphics-users to have the Git-Pro-book in
> text-format.

Like the website, the Pro Git book is a distinct project[4], not
directly related to the Git project. To suggest making the book
available as plain text, you can open an issue ticket[5] or submit a
pull request[6] if you implement it yourself.

[4]: https://github.com/progit/progit2
[5]: https://github.com/progit/progit2/issues
[6]: https://github.com/progit/progit2/pulls


> -------- Weitergeleitete Nachricht --------
> Betreff: user-manual: patch proposals and questions
> Datum: Tue, 6 Mar 2018 00:08:55 +0100
> Von: kalle <kalle@projektwerkstatt.de>
> An: git@vger.kernel.org
>
> The patches are attached.
> Further some questions:
>
> -see the explanations of the branch command, ca. line 280: wouldn't it
> be better to use other words than 'references'?
> -sentence "it shows all commits reachable from the parent commit": it
> seems wrong to me. The last commit is also shown.
> - chapter "Browsing revisions": it seems counterintuitive to me to have
> two different logics for the meaning of "branch1..branch2" and
> "branch1...branch2", according to whether it's the argument of `git log'
> or `git diff'
> -section "Check whether two branches point at the same history": 'git
> diff origin..master' -> shouldn't it be rather 'git diff
> branch1..branch2'? =E2=80=A6 or rewrite the example with branch1=3Dorigin=
 and
> branch2=3Dmaster.
>
> greetings,
> kalle
