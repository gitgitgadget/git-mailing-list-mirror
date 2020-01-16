Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02425C32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 00:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D852465A
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 00:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YnWAsaPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgAPA2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 19:28:43 -0500
Received: from mout.gmx.net ([212.227.15.19]:42799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgAPA2n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 19:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579134512;
        bh=GM3bm6C8YoeFXvQtAY+5a2Sjc3MDStQzuYjscHstqRM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YnWAsaPq1xxvguPa0foiyCrJocp+AFKWyWCKlMEPmV6AGACWWrWLPk+kj6hFVjJMB
         WH3XhVuSS3Z+irXqx0p4wfRzVdqvSe5TGzST/86whyguGGV1IbVYdUtNuZncS+1V9e
         3dgC/a3vjIc8dZ0rJBvNFHtrPp/C4bZw4DlyQDVE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3He-1iu3oF3t1s-00FQWS; Thu, 16
 Jan 2020 01:28:32 +0100
Date:   Thu, 16 Jan 2020 01:28:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/24] SHA-256 test fixes, part 8
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2001151524170.46@tvgsbejvaqbjf.bet>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rSGOIb2HcyaGoMWjPe3zmFKbKNP7kMaIH6+hbhwQqY9Q/yvirM/
 W3Ecdl8hbegEh7wxGgSSWN6+rkeKciP/04cJ1SA30zS/LfIKJSSrJKObBcuD5J83hrI1AJk
 QzzfYrQPyp66WzgveNJSf8KjKYBrSWhdZl9PkL/7NVKzSzYdSt/451GWA1meST0qHURJ08t
 Cw5AE1YImAn/U/YYxpE+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IJIf+48nZSo=:YeFLHM9nritdLB7Wgu94Yo
 rQarrMVNci75hWcWYBy7ljUL8LSz0O6KkJZe/dBuqZN/dktIW0jZHTMBAoZVKJg9LvziiCHd/
 ioaluekLRoYznew/2xiJz9D9q94NHrNsgOhlJt7s/Oa13/HDmFdQ6h1wD9ejoEdjRMiwlugiD
 /nZ0bZJgw1A/B/VwJnwW8Q0jWBtYmPTC159MrRC7kJesRBd1F6uBxkcShyvUFCu6Xvl1l52Pe
 wnlK52Hm42nQEmBpXyLs63ZBGgxZUJg9E+5H4m6YYlY6wfpjQvvO8fDs8iaSXtOQHhMwF2ocZ
 2Meln46X46Eu2Ln0Aryxmth817FIASEiJPNvC0DffjYZi69KaqpAmRjLEGzDw2KxbxLSuKIKZ
 IAkJhWNUTXjtngwhCbHdWuEYbKgBJDKRbpja9f7OpGo/ztzaYNvFVXbmj1vWUhZDH40iMbbHv
 skFYCFR3JJgyOf5fNBDeOpC9PwsmPab3/I4yr8sGfitetA6f3zc+4lf9Rx0n1kJqay10t2yHd
 tbhZcBu2UJIwHXYy7RSnD2SAe+ZnfQggj+sRDNkOEV3+pE64ZwG2BZMGTJjDi/MJfr9FM6f5k
 evY9Dn5zkfZidRRDZpVyaVx1F7C2CnMdU/qINTpMypMM0Zo2pAI4GOYQWg6ah64rquf7CngX7
 Z8EuHKtBWxzqXtQPWcgRHavMWCem6Jpg18ppzgDQ47AGA5y+1t3v+LBwqw2nuU4dR5eSmkqKi
 5iv4IFB2sK20AhBASkWxs93+zvDubfIj5j9T2xH3DfHiLHAX6JvZ6EWTr/d0kNPjhGZ9ojxDV
 ehghwy44QnHvtTf72STAbLyxNIV+1uh0T4F6x3LGoyU2OT39BfOywzj9zPHBfsnua0G3FdcGe
 l/x1a+3g9raC/fsxK3Q/40xiNTYKn+n2u1ADzA21+iNhlSLNVAGilYsH+FT207GzaC1IcgHn1
 hwJtk1HPdvdUSYwtSDRkSd0IJJZznFnHB1zywD22pJFD5N4Ct2wKc1frqSOpc3oWSwXfu0IyV
 FaQccT0KzMmPva1K+GIKlRXuq00Ga6MFkc99bmnWpDt/aGUd1l9yARHe5dqc3h+GiwIPLgxJ0
 fasgaUycGDxolSKxX2UWpgGHUt8wz2YMFBtFT5SmneJ947fWiZ+nf7Gs0PnKhybTjZAD+bOuq
 qA4Cae71H7kn+v6pXnApCpDJicEqmPb1kRKDh7xTV12+fw/q+6guxqxbKaIXzHZPjo1+uddqw
 dBCEggoDXpj9oTunxu1RJsRjX/5EYz54dj6YAfngZ0FxONiiNUt0OtwTb00I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Mon, 13 Jan 2020, brian m. carlson wrote:

> I suspect that t3404 also has a bug, since the object IDs that are
> supposed to collide do not, according to my instrumentation of the test.
> I'm unsure what the intended collision was and consequently haven't
> fixed it.  However, it does work with SHA-256 as it stands and is no
> more or less functional than with SHA-1, so I've removed the
> prerequisite.

This test was first introduced in 66ae9a57b88 (t3404: rebase -i:
demonstrate short SHA-1 collision, 2013-08-23). This commit does, however,
not give the full history of events. The most interesting tidbit is in
this mail:
https://public-inbox.org/git/1377112378-45511-4-git-send-email-sunshine@sunshineco.com/

Sadly, I could not make the indicated revision compile in a quick and
dirty way, so I cannot hope to bisect this down. But I can do better and
try to fix it properly.

On the other hand, I can do _even better_ than that and demonstrate that
the test case is both incomplete _and_ still has the proper collision. Let
me first explain the idea behind it: we want to run an interactive rebase
on

	collide1 - collide2 - collide3

Forget about collide1, this will be the base commit for the rebase. Now,
the idea is that collide2 is reworded during the rebase so that it has the
same short SHA-1 as collide3. Which means that a `pick <collide3>` will
fail if the short name is used because it is ambiguous, it could both
refer to collide3 and to the reworded collide2.

And this is indeed the case: if I insert a `break` after the `reword` to
force the rebase to be interrupted and the execute manually the command
`git rebase --edit-todo`, I see this:

	$ git rebase --edit-todo
	error: short SHA1 6bcda37 is ambiguous
	hint: The candidates are:
	hint:   6bcda372 commit 2005-04-07 - collide3
	hint:   6bcda37f commit 2005-04-07 - collide2 ac4f2ee
	error: could not parse 'collide3
	'
	error: invalid line 1: pick 6bcda37 collide3

But wait! This should not happen. That is exactly what this regression
test wanted to safeguard against: the `git-rebase-todo` file should have
been written with full SHA-1s, even if `git rebase --edit-todo` should
shorten them before opening the editor, and expanding them after the
editor was closed.

Uh oh.

*clicketyclick for some hours* Aha! A recent change in the interactive
rebase avoids re-reading the todo list all the time, and unfortunately we
now _also_ do not re-read the todo list right after expanding the SHA-1s
in `todo_list_write_to_file()`.

*clicketyclick for another few hours* Okay, I think I understand the
issue, and why the test passed (even if it should not have passed). I
opened https://github.com/gitgitgadget/git/pull/529 and will continue with
this project tomorrow.

Ciao,
Dscho
