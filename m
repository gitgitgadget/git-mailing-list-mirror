Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03E2C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF7521941
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gYXpct6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgIPU2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:28:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:49917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbgIPU1v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 16:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600288059;
        bh=WJgzeBCxJ1gzocNvMUc+qrC+iOcmBKWDCdzKK+ieKYM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gYXpct6s9thMSoBe9d7ytR0ruURc7jS4GuLyGDvrvfMayEX4a3L0h1JVACgsCRYna
         PDg4a7QaR4yqdeL+7/A2zXuB6NpIp1qRi25vZIxikCnFDxeEQcYapL+jU+vpTY7uWy
         tt+Zv1LMJ+FH/U1id4zU8N8RR56WkNMzI18AUhs4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.239.213] ([213.196.213.124]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEV3C-1kFqzZ0UFW-00FyeP; Wed, 16
 Sep 2020 22:27:39 +0200
Date:   Wed, 16 Sep 2020 22:27:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Git in Outreachy?
In-Reply-To: <CAP8UFD0_75zR3xoBzbVZjgTY2+KvORLFNMZ36s8+m6KZyNTXPg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009162206580.56@tvgsbejvaqbjf.bet>
References: <20200828065609.GA2105118@coredump.intra.peff.net> <441bd08b-ca7d-5977-a455-c4c2a4bd4bc9@gmail.com> <nycvar.QRO.7.76.6.2009072051470.56@tvgsbejvaqbjf.bet> <CAP8UFD0_75zR3xoBzbVZjgTY2+KvORLFNMZ36s8+m6KZyNTXPg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eCOg6GNYW5hEPnp7rRbJ5wRgKJPjyGL4rWYzch7IXeaWgL8A0i8
 Zt4zJQqjfcj7M08s9zlbGd4Z5LU2SNkDJD+VAJmGU7b4/0+xEf3AcuthfVdZ0DstmqQaD+e
 Z8Ey3a5znKApk6q2JNaBwQslbsWS4J3udNMpaI9UEadxfmcgF9py5VJN30H5h8I6xmrIo/7
 1ZWv7bcxipLsGIsjUy/Xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ka6Fih9yLfM=:nc9fQlXrGqYH0gZGIGvdwi
 1hn47lQBhHxuJoQPzaRQwCLP8Q81pqMvaT/fbDRFlTnCDeFKx/LlG2ys3SxBFyI6/BAn8NZxp
 Sz385eDCTQql+rx+cncPkWs2qei/VqKviG9YtYI0NT1CkS5sa9jNfLKT8FV9TNeyLxvwnG+6I
 ea7rmVMdytNM+Q8ebB+XYBQnR8dE3pfFoCd+w4cyMhmzeLzJKtGdEN98Vac64+FSpoj00I+7C
 zMFD7L6LA7R79occcXUqzzixIY3ioE16VN7j+0eBWW0WPdH0FeNeKkttFy3SMCn2EFB/bP7vi
 2uEuYMf91EWIXaH+nZuCPQJrtPswA7HvSCKtHhnV6YhNdtLnUdQ9vBntGjhzFHpa2CL9gYbUR
 Vi95UArHBZtLlG+5bkx2BA6zHfDuqcrqv8Pq6hErDB7tDcLfrYCmzEIuTR7plNK+DuS00ofOp
 RWwgFViB6KwJZ+uJ0uHefHx0/OkNq7m+QCYtuTx+wcKUdqerHe4qeuXK1JQLYCg35HwOYa/r6
 vGiGFVi+pK92yCwQkhe0AYh4TE+NxosArsvDJ9Y8WILm/TDGxMQGwhJMYYqKm/jelBZHGUGg9
 P3bJdfJR1qtVY4WjB6pA5J7FLxH8zHgI1QrZ+oeGyJVGh9n1RnetigasnohHlzFGVSL7fkuDG
 TsCcftkPb3kYDyJbPyKQQfEbu150yZfVUAa3dbJneEWYGLE0d0ElPF1yT3qbQJOuqmhe/OI2s
 I9E38t2yuLVXrTxfoxqn+agnYlh05UtD3O+HTY0kOfwfB3CN2FrZFMT3bKo0lmhc+3Zhkda7q
 CXEYcL8dUIVXBD/WFkpptXhJh/30dglKem/6HrPOH8FOJS0rvh9thH9guKCUPHz8cGXxW62vM
 j+ZbfSEzR3ViE/sseiYu/lqX8GEfU/8vZn3MxP6DO7J7oVyQICIYl4+maV5+mO94kr82SBgFT
 KEYkniGiDr8VtuafGvxc2G54yMgsSOHuOr/XvJf4so6Yo2JORDK/B7/fua27NjktmjMdybJVl
 6wB7JixPbVeeL4kl8ZdPxIBHPO/M4lcn+KuufEuE6wrIRKC5aqkpIlUF1taeUhI+Fqh2IOok8
 a7TgdS6iW3dQjSP8FMkw4/tD8/LudYbLWnExSesnsQa2832oeS8yGpfaaNeO+cECe2QQzy3IZ
 6WA/T+rGkN3Fx4G/Cs/Mmh3BtBX3C9qTP4ZNm+FuMZz5/Pynf1rmT1S8wYmPlFpS7GGPzB5Yz
 HZU8qisPpPp6J6RFSoYlHxQ89rxionubgazKKIQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Wed, 16 Sep 2020, Christian Couder wrote:

> On Mon, Sep 7, 2020 at 8:55 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Mon, 7 Sep 2020, Kaartic Sivaraam wrote:
> >
> > > On 28-08-2020 12:26, Jeff King wrote:
> > >
> > > > I would appreciate help to find project ideas though. Are there
> > > > still scripts that are worth converting to C (excluding
> > > > git-bisect.sh and git-submodule.sh that are still worked on)?
> > >
> > > I think Dscho's e-mail linked below gives a nice overview of the
> > > various scripts and their likely status as of Jan2020:
> > >
> > > https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001301154170.46@tvgsb=
ejvaqbjf.bet/
> > >
> > > I'm guessing only the status of submodule has changed as it's being
> > > worked on now.
> >
> > No, not quite. The `git-merge-*.sh` ones I called "trivial" are alread=
y
> > being worked on by Alban Gruin:
> > https://lore.kernel.org/git/20200901105705.6059-1-alban.gruin@gmail.co=
m/
> >
> > And `git-legacy-stash.sh` is no more, as of v2.27.0~180^2.
> >
> > But yes, other than that, my summary still holds.
>
> To summarize more, it seems to me that only the following scripts
> could be worth converting:
>
> git-difftool--helper.sh
> git-mergetool--lib.sh
> git-mergetool.sh
>
> I wonder if they are really worth converting though, as they should
> probably all be converted together and we would likely also need to
> convert the scripts in mergetools/ at the same time. And then there
> should be a way to still easily configure things for users. So perhaps
> a better way to approach this would be first to convert the scripts in
> mergetools/ into config files.

The biggest problem is that they're all entangled.
`git-difftool--helper.sh` sources `git-mergetool--lib.sh` and uses quite a
bit of its machinery.

As to converting the scripts to config files, I'd rather have them
hard-coded in the source code. Something along those lines:

struct mergetool {
	const char *can_merge;
	const char *can_diff;
	const char *diff_cmd
	const char *merge_cmd;
	const char *translate_merge_tool_path;
	const char *list_tool_variants;
	const char *exit_code_trustable;
} araxis =3D {
	.diff_cmd =3D "\"$merge_tool_path"\ -wait -2 \"$LOCAL\" \"$REMOTE\" >/dev=
/null 2>&1",
	.merge_cmd =3D "if $base_present\n"
		"then\n"
		" \"$merge_tool_path\" -wait -merge -3 -a1"
		"  \"$BASE\" \"$LOCAL\" \"$REMOTE\" \"$MERGED\" >/dev/null 2>&1\n"
		"else\n"
                " \"$merge_tool_path\" -wait -2"
		"  \"$LOCAL\" \"$REMOTE\" \"$MERGED\" >/dev/null 2>&1\n"
		"fi",
	.translate_merge_tool_path =3D "echo compare"
}, [...]

I would then probably try to implement the bare minimum for the
`difftool--helper` command to work (re-implementing in C only the parts of
`mergetool--lib` that are necessary), and only in a next patch series work
on `mergetool`.

Ciao,
Dscho
