Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA3D1F462
	for <e@80x24.org>; Mon, 20 May 2019 16:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390044AbfETQtN (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 12:49:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:33365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390019AbfETQtN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 12:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558370944;
        bh=oGJVysiKqDqaN1Bg5M9YwCPMPjCngM2KUYylWQI2lg0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GSgUTTAXgv0J1JUSUtdhymGmEX/1jcdZuWctxjoPAy1SlrHcWGyvyliSDO6PPZ5NM
         DwbOYqLTyXmDlHJ+dL80huqQoKd5+ZKtG3ksn1UCpi/EEHS0kVd6jJMIhp/Haxysh5
         dNjR0rQNud2p/KbYxvLL+NkJOLiwSl0PUYuSHp2M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1hKYG13RSA-00AYP6; Mon, 20
 May 2019 18:49:03 +0200
Date:   Mon, 20 May 2019 18:48:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] clone: auto-enable git-credential-store when
 necessary
In-Reply-To: <20190520123110.GE11212@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1905201845550.46@tvgsbejvaqbjf.bet>
References: <20190519050724.GA26179@sigill.intra.peff.net> <20190519051604.GC19434@sigill.intra.peff.net> <CAPig+cTkjJjuyrDOUh92B16an+wy9OnZgyKY0-bihWnzyWsoKg@mail.gmail.com> <20190520123110.GE11212@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:28fFIEzEOv2Ht0Mc8ePPUaaw0lvJPLl/t2VDtHEb+j24r5R2PCQ
 bf1Ny5lK4+kcIWcMWOwcUKcXexl8/LrKuc0eHdWK8iiX8TkghuAxqRedu/6MVZE73yW8FFn
 fZF3WAfEMu/xpWw9CTsxARJL5CXS73tIjluODwYJblwCyaIy8spcRik7Xb5YZ95FqaZUwY8
 lOtnWke4JRovsoDferIKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s1Mnxv3aLnY=:9K8BDNcNTo8oenHU78gw9M
 QYjtWGtgNEYmnaWbcu0rCVwQVNNO72jkFHXiGJWIa0P0Y+a5CiLhI/Jd8ljb7L+OwpIn8QZDW
 fnauuCdivNYfoYOQmlwzLjwlfZwTKIuTdP30phONuETNj/L65ZUO+P3i/ex/48KAH7NR3CwNL
 hYduHYU9h708TJUU00TBb0SSFPfwOQOqjOzuSIxCG9UIfRR6O/S0RJ1VqEIiAFi3ORhOajJVy
 rQ9rRddpVWOrrMrlG7TECYwgkTq7jrSI27k1fWHuqNLErThbZjUwX1mVd1kOBAfTjKpHX0AVz
 2fYImlxWdCRxrhy7K43hbgLyy4/7i9Eu6+RNHKuLpRkUwFps99CCN5RK04YdSukIJOtigl//d
 jrkDsIe3uI/uu7DtMS5L388kbX4+XCWEuW9g8mHEH/Kv1m47oPIpJcs4eLaFRSOVk29RyjhZe
 hlig8L18T+JPPG4nBIu24KQMUjjfAoGI6yjmrj1qRWLj63KkUVhhRl1VrmObYNAwva6Pq6k78
 noXD4TSR2gX+EBD4Bztom6IsUc9eMEJf/4c4XOPnK8u5UI4aKE4Qi//OBHrZ0RTcq/kmEBSIU
 gyPmUEPYOxmF7+SFK02fFsPgZPDjosKcaUM6MA3CZ1SplYBpVEqGH8zcnqBdACjmWzsM1L4fe
 CKe5H0HIfS+B2ibUQMegYYxZaTyBj8VpQmWLp9N6N1mkE7ff3+XD2XxxrS+OyvEobHzb6zhcY
 DpdDJT2fMj6DSPVgG9jjxSknwkA3RrLXLSoQ7Z/4ekpkxHo/N+L3XjXX1l1Wm7T9GGV/UMttz
 2mlahxVhDBrpkX3ZYXS2IJNuPIcbbscHX75I2uy7cBH0VreSpAGfeziq+iY3aDmJf6QKikML/
 2hrUGmeWghydMUuC1UWqRE2dIbgnmt5TeFdOAynnxcUMgSLu7G0rWpoh4IltW0g7WNGKKxAp7
 e4Jyn2P6Ri67cd6eb2GJWcArDiTbS8/NiwkTUu2p3HIQr4xk0VZm8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 20 May 2019, Jeff King wrote:

> On Mon, May 20, 2019 at 07:28:08AM -0400, Eric Sunshine wrote:
>
> > > The biggest downside is that it's a bit magical from the user's
> > > perspective, because now the password is off in some other file
> > > (usually ~/.git-credentials, but sometimes in $XDG_CONFIG_HOME).
> > > Which complicates things if they want to purge the repo and
> > > password, for example, because now they can't just delete the
> > > repository directory.
> > >
> > > The file location is documented, though, and we point people to the
> > > documentation. So perhaps it will be enough (and better still, may
> > > lead to them configuring a more secure helper).
> >
> > I'm trying to decide how I feel about this based upon my own
> > experience recently of having my password magically stored by Git for
> > Windows without warning or consent on a computer which was not my own
> > but on which I needed to access a private GitHub repository. Although
> > the situation is not perfectly analogous, the concern of having one's
> > password magically squirreled-away _somewhere_ unexpectedly is the
> > same. Being unfamiliar with Git for Windows's credential helper or
> > Windows credential management in general, I experienced more than a
> > few minutes of consternation and alarm before finally figuring out
> > where Git for Windows had stored my password and how to remove it. The
> > sense of alarm and discomfort likely would have not arisen had the
> > credential helper given me the opportunity to approve or deny the
> > action.
>
> Thanks, that's a good elaboration of the uneasiness I was feeling. This
> patch is better than the status quo in that your password was already
> being squirreled away in plaintext, and now it's at least locked down
> with filesystem permissions. But it's clearly not as far as we could go.
> I was mostly just afraid to break existing workflows, but maybe we
> should be more opinionated.
>
> Or maybe we just need to give more specific details about how to back
> out the change.

I think that would make the most sense. "If you did not mean for this
password to be stored, call [...]".

> > > +"Note that the password is still stored in plaintext in the filesys=
tem;\n"
> > > +"consider configuring a more secure helper. See \"git help gitcrede=
ntials\"\n"
> > > +"and \"git help git-credential-store\" for details.\n"
> > >  );
> >
> > Give the above experience, one way to mitigate such feelings of alarm
> > might, at a minimum, be for this message to say where the password is
> > being stored (and, possibly, how to remove it) so the user can do so
> > immediately if desired. Prompting the user to approve or deny the
> > action might also go a long way toward making this more palatable
> > (assuming the session is interactive).
>
> I actually thought about pointing to the file, but it's non-trivial to
> do so (there's a bunch of internal logic in credential-store to decide
> between $HOME and XDG locations).
>
> I think what we really need are better commands to manage credentials
> independent of helpers, and then we could recommend a simple command to
> clear a credential that you don't want to have stored. Right now I think
> the best you can do is:
>
>   echo url=3Dhttps://example.com | git credential reject
>
> but:
>
>   - "reject" is a funny term; this comes from the C code, which thinks
>     of it in terms of the server approving/rejecting (and that makes
>     sense for scripts calling this command). But at the helper level,
>     the operations are really store/erase. We probably ought to support
>     those names, too.
>
>   - piping the credential protocol is slightly awkward; we probably
>     ought to allow a url on the command line, and avoid reading stdin if
>     we get one.
>
> That would give us:
>
>   git credential erase https://example.com
>
> which is really quite readable. :)
>
> Likewise, if we choose not to auto-enable the store helper, we'd
> probably want to give advice on seeding your password. Right now that
> is:
>
>   echo url=3Dhttps://example.com | git credential fill | git credential =
approve
>
> which is...not intuitive. It would make sense to me to have a "seed"
> operation which does a fill/approve together. Maybe that should just be
> what "store" does, which would allow:
>
>   $ git credential store https://example.com
>   Username for 'https://example.com':
>   Password for 'https://user@example.com':
>
> (Of course you can also just "git fetch" to get prompted, but it seems
> like this shouldn't require a network operation if you don't want it
> to).

There is nothing stopping us from adding a new command to `git
credential`: `git credential forget <url>` where the URL may contain the
user name for further differentiation (and maybe even a password that will
be ignored, for copy/pasting convenience).

Ciao,
Dscho
