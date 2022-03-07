Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FCDC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244368AbiCGQ50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbiCGQ5X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:57:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6251C7E0A1
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646672184;
        bh=AOp/1DDU634Ktgia2Rmpg2o3N3Kx8vO3bm1XVwkTze0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ist+CCo2aEcPLgxG62EqNf0iTVS1RvKYdJ7QUSWDXLAP3Zn9bzT2+7Ds4YKcnDeqI
         BU2geWUDQbl0t9vQidXVLlQ3+e9b9YQ4Ijoq+qYZGf2kOhASBaF5/0LRi4x5wx/rqp
         UJnPRFyAOvG6bwUCtrhYqjPTRTOoZnZ4WM74t6Ck=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZkpR-1nd7AF11Ut-00Wpow; Mon, 07
 Mar 2022 17:56:24 +0100
Date:   Mon, 7 Mar 2022 17:56:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Erik Cervin Edin <erik@cervined.in>
cc:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: rewinding interactive rebases
In-Reply-To: <CA+JQ7M-+kq1MTh+DG+HCmXkpsF5Esm_0V=4=2_DS2_ZYdjP2+g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203071745590.11118@tvgsbejvaqbjf.bet>
References: <YhPiqlM81XCjNWpk@ugly> <CA+JQ7M-+kq1MTh+DG+HCmXkpsF5Esm_0V=4=2_DS2_ZYdjP2+g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7mtmrXfI5ozHF0GHAuBqkNeqH51b6Rl1WNKYqTA4ta7UMLHjJJw
 bkwSg9weFvPkCSC4NBDYawuMHbvu2oQYU0AK7yxGNrLcfYS/MQQtgN2SkH2KufWFxlKPr39
 9XIwJFj9AU0ACb3FKAF3bL6Go5Y1v+kh6djhdxRrKvjcuYyqHcZuJlVKgKIfEy57HtQqTXl
 Y47vt1YOMsExXBCPOW3eA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xlW83a+tWCQ=:PPOPfANR0gv+/lBbALrIsl
 t/poukNDP/AeWgyktTyvijtbImULVbU5e4RXBxSmpNmAKlxxV5B66lypHYQ/7YTFuvoLzegVH
 0ZwPiZUaX0n5wtz/nrZX26I/LsUZUD5cIOWUmbGCSIU4otvhxAsZCoGGp0p2RXjELx/5Nd3ei
 xz8EcBJvZ1nP/CvtXwzU3Aig6IFOmZlUCEotJniDRfAmFDYklpmsTbqc+t5U2rz114gVw0Pv9
 QED1RZMXcUSP0n4TJXRkkZaXRyHpgqHPZjF2+p7eQwg+f1fh1U4nSmX3d17tSQa2R3Towl2RQ
 s/0kyDREOlegdPhjqWU+DEyhDNz6XKFoAUkZOz3ufMxfaFm1zxDg8jda5o8zKp8DzafvcWcUa
 WCdkn8tLhG6HHXriVAkTDqmErpbN7ZgJsO9tquPfVEc4UGleUFu9zyVca8kBszjbEFJaxlBAf
 AoDblyF0XagEpVASLLT2vYSc4UeQ93Dyyo9BbiPgmLwzRGz3bDlY7mLtHqnUgqe5PnVklMYYU
 B99kPNCCjphvxlBGGh+OyDPvKncs776Fn1BgE5HCSz0wmjwuljPm877YjyhRXGz+WyecAlNXS
 7JPngaDxlIt9WrmkO44On7F9KqebHVmFRmAmRLJSfGuenYngImZughgVu3w+6cMxjV+0ODocS
 Ddefe02EcYWJsdRJh+CenykjGFnJ1G9OozkZbAwnmF86+jFnYPu9yK8BNTJ1MMtdo/cmjVczc
 ZzhJxOkR0HtKAZV6zjcQQ3N2PZXc7GNr9utTtPDDfEnKewlpOfb0JEubUVO0AxqnUORdGwi1y
 xA66fOJWQoex1iHQveP33yalsLW+F0ZQwO/YpaafY+o1UYdKsaa3bKZJmIG9lvFuT7nB5uL6Q
 qxLa1aIXRzH9FprcWqMT0Oj0PEUu9U+qmlJCHPY9ShnzgQjlQ6o6mHLcNqTwFW2FXD/VLv+Tl
 KVk2/vhDo+Lf0KMxR2t9gynIh/tVUq0FLdE9IseBlri92SVezv3bSjAPqUwh0Xa7fA2+ZbfK1
 dkPFR/PjoyzrXJhp6PedLqYGBxZHgAU3bqOa7qPQcUJKdxNr9MGWSnfP2Yt+ewl+OvpMvWhZ2
 C9qZZMiM5QkxUo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Erik & Oswald,

it's not really obvious from the text quoted below what is being discussed
here, so let me simply top-post some thoughts:

Problem statement: in the middle of an interactive rebase, the user would
like to choose a different rebase target, without having to abort the
rebase.

Suggested approach: implement support for `git rebase -i --nested --onto
<commit> <base-commit>`, i.e. a `--nested` option.

The idea here is to generate a todo list (just like a fresh `git rebase -i
=2D-onto <commit> <base-commit>` would have done) and _prepend_ it to the
current todo list.

To support a nested `git rebase --abort`, we would probably want to insert
some marker after the newly-generated todo list (maybe a
specially-formatted comment such as `## END NESTED ##`).

To support nested `git rebase --rebase-merges`, we would need to populate
`state.labels` by reading `$GIT_DIR/rebase-merge/refs-to-delete` first
thing when generating the todo list.

For good measure, we should probably populate `state.commit2label` with
this list, too, looking up the respective OIDs via
`refs/rewritten/<label>`.

I realize that this is quite dense information for anybody unfamiliar with
the `sequencer.c` code, and that the idea is _not_ fully fleshed out, but
I lack the time to implement it and wanted to get even just a
half-finished idea out there.

Ciao,
Johannes

On Tue, 1 Mar 2022, Erik Cervin Edin wrote:

> On Tue, Mar 1, 2022 at 1:21 AM Oswald Buddenhagen
> <oswald.buddenhagen@gmx.de> wrote:
>
> > On Mon, Feb 28, 2022 at 10:32:16PM +0100, Erik Cervin Edin wrote:
> > >What's the connection to the original thread [...]?
> > >
> > that depends on what you want to interpret into the original thread,
> > given that a bunch of use cases and solutions were mentioned. my
> > solution is actually functionally identical to one of the later
> > subthreads, as i found after the fact.
>
> Sorry but it's a long thread and at least I am unsure which parts you
> are referring to and how your script fits into that.
>
> > >Maybe you could explain it a bit in the context of the problem.
> > >
> > there really isn't much to it. the git log + git reset are the essence=
.
> > just run it in the middle of an interactive rebase to see yourself.
>
> Could you elaborate on the intended/usual flow here?
> Rebase =3D> Get conflict =3D> Fix conflict =3D> run the script =3D> ..??
>
