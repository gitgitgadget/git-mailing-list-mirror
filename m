Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2614EC4727E
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 20:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFFDC20C09
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 20:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="g5i69HbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgIWUnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 16:43:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:45103 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWUnC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 16:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600893778;
        bh=SbFcomgS8Hel2atouPQECRrgcCfu2BusLiWqHA+inBI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=g5i69HbEZLTqsLgsqWOifA5HJOkoYKA2G76tVULIThqLFUiIeEfOgCwCurgrzqo7G
         CzrZJRL3I2uuIUMkRhqljT1N5UY9tKjTc3xnmuTRQyCi4OADMW+i0SquWKoXWRsYeB
         MsPcZyyVGpljMbU3rYbJAQk+DKbROmS5DSMUI6hQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.22]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1kzSQm3nnB-00f7e7; Wed, 23
 Sep 2020 22:42:57 +0200
Date:   Wed, 23 Sep 2020 22:42:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood123@gmail.com>
cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] commit: add an option the reword HEAD
In-Reply-To: <41dcb8cb-8e43-04ce-2ddd-d69c765ee327@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009232241140.5061@tvgsbejvaqbjf.bet>
References: <pull.736.git.1600695050.gitgitgadget@gmail.com> <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2009231206290.5061@tvgsbejvaqbjf.bet> <41dcb8cb-8e43-04ce-2ddd-d69c765ee327@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F6oQU6yTX+eCVqsje4VjTaw4XiAidGA5f3uP6eY5roe6nJVzYqt
 +ZMfdqqSqO6Cho9E+BRacpVKkIAqKiMYUZQJ1M94BxB6AmmcoUF7gV/VrSmoe9hPNxO+Wp4
 IAAzTWa4Xb71kogO5xAmzG3WrF9qnHZj/+AftdZrpgnqLNXtOpi62xZ4o+suEXjOeZAE81q
 lE3p9GdHHR0ayCYGAXfVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mkW2tD9Dt8Y=:zuP9J3ly7OszoctQuXE5Fp
 GPVVWXpXXDnfr+rsnO4tDHG5jOgQK8mfjt0CZD4uV5RVSeYCd6tWj4Ybm9TVAwfkAokMvJ4CA
 3y+TejfnoModQNkn8TZCon2CGk2e/FmVUSXMtvRNU4EX6ovOw4llGJQw3hfn/GxI7mwpNuaJd
 V5/GO2JuC6MMOpxiIUYF58uJa3O3brA6go4POsw6+GC9EZm7yVhgZQPZUAfnWp6qG0ASrPYDB
 uGEtw+wshTQwmeOvRGn0jCpRuVTpMSfvqEs0meN3aSNSpQo5irkcbIvorFpe7dR7LXwKEsWvV
 68VljMA2OV37sEdIVU6tTGepV2BwyYfthRSrklRngEOs3nZL+UfkYkhObrvuZwWvjnfTf0x1c
 Fm8eReJlfaqulwgoHCbnH0YuQ7nq9O8tWhYoxVPO3aNAhTSjc068d2SE8WVm0e/I94sBU9HAT
 phBxleImVdArT7qi5JetSXk6eliozY9UheHhi12OqkLV7vfjM0Rbp6AzTmk4kPSxUr+HyvoMU
 XdtN2E+ni4ujbkTvU7KP6Hh4SpdW6DsOy5UXWjqBTyk844V41OoLOlIwh+ypypT9MIN4nDkp3
 hXj0A4oTqouiY8q1+rZdM5UIL+wth3AzlwW9ccO53WzErE7fs4CwuyNs5aeL3MxsMWh9v5ffN
 MxS47wMUTXNC1LM1icmxZVHoXIYgN8qY1J60Y/vG9jM3j2QALtvpsKspvFGOly1Ri281i4m7y
 wp6y88tzqOB7U99uaSHQhFZ7MB5RCDFCRIZc6nV2/2/tqZdLpTAj1NV9eK854jlqFr2BpHC3B
 IgrPckuVZf6UDXb8/t+bPTvS6XXaDOLsKQi3BWqAQNRvzKrgREhk5iM50wZ4T9nhoNpbWcBA0
 g43X9GmRBM40EdnHst5vr5SGXLWFmxHzN+1B7lQfe9bsBPKCoh8fbqKCRDTeeGaRRF1x038NF
 7QC9l8V9KWo8tIHvmilNWNcB3rxbfgfS1q0HKWBJSlF73Uo/0jvnDUDy/pHmr5k2tmfTVOTgK
 F+j3wyoHLxX4r3cgXaWD05JQx8NMA1braL3vDLXd61xeif7H9Vc2vQoNGr2Vvabvpdkx6Qyxj
 fbaVEdlOWsFOi1K/NkoNYUU8EdwJkYS7nHYJ3JT/b9Y4tnCI+TuWlqYcI/UrGUqtMyICWFTHu
 Ehs3iJGCYIC+kOY2szSPzxfGblr3rGy2P/MgWcxkSZ1f271l2lLW9JFM5f8a++befC3tR8jeA
 u2m8Sgt22Q+uzOrSCZLYJJ83305AqEZxd+qRWNw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 23 Sep 2020, Phillip Wood wrote:

> On 23/09/2020 11:22, Johannes Schindelin wrote:
> >
> > On Mon, 21 Sep 2020, Phillip Wood via GitGitGadget wrote:
> >
> > > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> > >
> > > If one notices a typo in the last commit after starting to stage
> > > changes for the next commit it is useful to be able to reword the la=
st
> > > commit without changing its contents. Currently the way to do that i=
s
> > > by specifying --amend --only with no pathspec which is not that
> > > obvious to new users (so much so that before beb635ca9c ("commit:
> > > remove 'Clever' message for --only --amend", 2016-12-09) commit
> > > printed a message to congratulate the user on figuring out how to do
> > > it). If the last commit is empty one has to pass --allow-empty as we=
ll
> > > even though the contents are not being changed. This commits adds a
> > > --reword option for commit that rewords the last commit without
> > > changing its contents.
> >
> > I would like to explain the idea I tried to get across when I proposed=
 to
> > implement support for `reword!` (and `--reword`) because I feel that i=
t
> > will change the design of this patch in a rather big way.
> >
> > First of all, let me explain the scenario in which I long for the
> > `--reword` option: I maintain several patch thickets, the most obvious=
 one
> > being Git for Windows' patch thicket that is merge-rebased [*1*] onto
> > every new Git version.
> >
> > At times, I need to adjust a commit message in that patch thicket. It
> > would be quite wasteful to perform a full merge-rebase, therefore I
> > typically call `git commit --squash <commit> -c <commit>`, copy the
> > oneline, paste it after the `squash!` line (surrounded by empty lines)=
, and
> > then reword the commit message. When the next Git version comes out, I=
 do
> > a merging-rebase, and when the editor pops up because of that `squash!=
`
> > oneline, I remove the now-obsolete version(s) of the commit message.
> >
> > Obviously, I have to be careful to either also pass `--only` (which I
> > somehow managed to learn about only today) or I have to make sure that=
 I
> > have no staged changes. In practice, I actually specify a bogus path,
> > which has the same effect as `--only`.
> >
> > What I would actually rather have is the `--reword` option: `git commi=
t
> > --reword <commit>`. In my mind, this would _add_ a new, "empty" commit=
,
> > letting me edit the commit message of the specified commit, and using =
that
> > as commit message, prefixed with the line `reword! <oneline>`.
> >
> > This, in turn, would need to be accompanied by support in the interact=
ive
> > rebase, to perform the desired reword (which is admittedly quite a bit
> > different from what the way the todo command `reword` works).
> >
> > With that in mind, I would like to caution against the design of your
> > current patch, because it would slam the door shut on the way I would =
like
> > `--reword` to work.
>
> I'm keen to have an easy way to reword HEAD and a way to implement your
> reword! idea.
>
> I posted a comment on your gitgitgadget issue about reword! and drop![1]
> pointing to some patches[2] that implement the reword! idea as amend!. I=
 think
> we want to be able to  fixup a commit and reword it at the same time whi=
ch is
> way I chose the name amend! rather than reword! The implementation curre=
ntly
> changes `git commit --amend` to take an optional commit which isn't idea=
l. I
> wonder if calling it revise! would be better then we could have `git com=
mit
> --reword` to reword HEAD and `git commit --revise <commit>` to create a =
commit
> that will reword and fixup <commit> when the user runs `git rebase -i
> --autostash`. fold! is another possibility.
>
> I don't think this patch series stops us implementing something for reba=
se but
> it would mean we couldn't use the name reword! unless we allow `git comm=
it
> --reword` to take an optional commit which I'm not that keen on.
>
> What do you think to an alternative name?

I am really worried that the proliferation of confusingly similar options
will increase Git's reputation for being awfully hard to use.

Ciao,
Dscho
