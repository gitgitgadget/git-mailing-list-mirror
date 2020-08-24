Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33472C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 13:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10DAC207CD
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 13:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HfNTkN2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgHXNxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:53:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:45921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHXNw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 09:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598277151;
        bh=AgrDBbEW6qzztRQNReWCMqbmK17Ncsd11GhDkti2JR4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HfNTkN2RPJODz70yPE8sptdXQAN7FBYaMCoIJmLwy0iGUcbdd6r8HnCGYeQXSJAWU
         fiK7b+M3XuW/uSLqhLSc1S8713ZoqeTzD6Z1KqZhJ6MDzXvNJnSew94hSKOgHg3jPV
         B7RSJ4pHtkKrDUwOJptBjlFk74ouUwh2qDteBqpQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.214.173]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V0H-1kcudF3MFD-013s3u; Mon, 24
 Aug 2020 15:52:30 +0200
Date:   Mon, 24 Aug 2020 15:52:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Lukas Straub <lukasstraub2@web.de>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
In-Reply-To: <20200822211250.59a8b351@luklap>
Message-ID: <nycvar.QRO.7.76.6.2008241547070.56@tvgsbejvaqbjf.bet>
References: <04aa01d67659$2dc217b0$89464710$@nexbridge.com> <xmqqimdetpuw.fsf@gitster.c.googlers.com> <20200819201736.GA2511157@coredump.intra.peff.net> <xmqqa6yqtm03.fsf@gitster.c.googlers.com> <20200819203825.GA2511902@coredump.intra.peff.net>
 <20200820133445.2bd162a3@luklap> <20200820130125.GB2522289@coredump.intra.peff.net> <20200821143941.28f71287@luklap> <20200821225237.GW8085@camp.crustytoothpaste.net> <20200822162152.2be1d024@luklap> <20200822185307.GZ8085@camp.crustytoothpaste.net>
 <20200822211250.59a8b351@luklap>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:v6ksgcOh4i4Qc/pDFnHBes6r1Pg832jgDrwjLZA5ginD0AMiFm/
 KoS2+aFU9pQ44ow5NMvk3g3Mgcf8WSGs0TGnn4Tgbj8tLaplmewUtn0aVGwiMfUsyJws0Z+
 RH1gWDswZFR2Imo/MgEvqqEDx+imkBiCU0xjCG/qwdIyEgrfzIqQta7JzFjCCku74FZG3I+
 q3uJWUQhdurxyVvZG2EKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F8mTFU/X5jA=:V8bWImu53Q+/F42yb0S+vY
 9oG6iBvX/eOzSjRdXYvQ7/UX/0u469KqEFkjOee0hvU4OGC9548sKlcImj9QsTkLLbM24FtME
 O3xjGPezEuhoXLMEe7uEs6mh8qZ/ZnJXF/OPn6ZdGogux2QVvSvRcEz8dEtKhQUUTlQlI79Hx
 k5CSVLc+H4V9F9/DnTnnz64V2ezL0O87vm+tAfi5pNCbJnbyFBEUd8/eeXKk4Jc8EBmR/ZYMG
 38uuzt/c7cVNWvRNFq5W017S/zWxuHPZBsFNDlPisxQ7V7GrjNNi/L3EBRFOR3wQkWyWfBz4n
 Qfzdk0BNWQSrto2tSvjlHKj+aDsOrw+a95VuLBeqSUhyoqxCVSPVkJoN/4uFfuLRzKtriuIKu
 8oLG/lwkJgvSISBrDYBRzebVuvLXIRxotBg2aEbO4Lx4CeaEe66PrHLKwhtC8I2By03gjUaJU
 reZQ3g7JgjfrDt3T6roRF5S/dhphQC67TkM95lJC8mg2LIjNK1isFZ1QHxG7Je2fMIRgLl3SB
 qngLm8aQAzja0BItICAGsL1FwgdLgTmM6j59h8q+mcLqh1L/oDtUuNIwwtdlkukL9vMdK88dG
 H4ql24RNpNHy2E7ay7EYy/E4WpevAYCmwNxWQViA5SsHVK3BeUXwSeixQk9aYS5HwKnGKd98T
 5Vps4kC91G1RiPveinBkX1WMSrzpgWZQZMjl+VAXXkO3RRGyIVQ1rSwp97cjZzSr7T3//Z68E
 Ax3uNqQpZVe+bZqdJwU+7Y+N8+ivkcd75UFOKmHQ71Dzc2tAD1wcVaGnROKM/A36AFjtw+YkE
 6sE6X37rXaNM9N+tkcT7W43QKwdjPgYQ54JvSRu4L92IZ24EKFHK64DunaXjpM6I9JMBbcJ4O
 6Bv6EGQ+VrNlRLSlnyK8lCO4YiIoTECcZcscgZXCedBWJ+O/Vcdi31e6RMmA0TjtWZn3Uhhf8
 mwO6tnbsGKeueuLspOpJ/T1Yi7rkCEuItbTx4AzRSTK9mK36cUDcNeohSFK9j9hi6SWLNYwDv
 aU6Eo2ZOpYXT6ZlDZ405gLf50WXhIWrRXqBN81UDW+sr0aOJw22yc6s3p3TJnGBHj2AaUmI8T
 vZz/uiHGRTfRNXngmTO2i/fQ7mqs7tXSWa628d5MX9PZ9hu19Dm3ShBSY9wwuFxyMy6eCoUur
 Dug5/hJOJ+0ViJwy6WobJ4V9woT2k7kNw41CqNt4FFT7LL7FEiTWHHMP4GOOBIZBjV2iD2+U8
 GY+xUG7WyIOCMgyfiKYVSjhnUCjL5CW8vFLrdb0Ut5QRYHgEAS7HvE1euq8g=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lukas,

On Sat, 22 Aug 2020, Lukas Straub wrote:

> On Sat, 22 Aug 2020 18:53:07 +0000
> "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
>
> > On 2020-08-22 at 14:21:52, Lukas Straub wrote:
> > > On Fri, 21 Aug 2020 22:52:37 +0000
> > > "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> > >
> > > > On 2020-08-21 at 12:39:41, Lukas Straub wrote:
> > > > > The downsides we discussed don't apply in this usecase. These ar=
e mostly
> > > > > personal files, so I wont upload them to any hosting site (not e=
ven private
> > > > > ones). There is no security impact as I only sync with trusted d=
evices.
> > > >
> > > > I realize this works for you, but in general Git's security model =
does
> > > > not permit untrusted configuration files or hooks.  Configuration =
can
> > > > have numerous different commands that Git may execute and it is no=
t, in
> > > > general, safe to share across users.  This is why Git does not pro=
vide a
> > > > way to sync whole repositories, only the objects within them.
> > > >
> > > > Adding the ability to transport configuration through a repository=
 is a
> > > > security problem because it allows an attacker to potentially exec=
ute
> > > > arbitrary code on the user's machine, and I can tell you that many=
, many
> > > > people do clone untrusted repositories.  Just because you are awar=
e of
> > > > the risks, are comfortable with them, and are the only user in thi=
s
> > > > scenario does not mean that this feature is a prudent one to add t=
o Git.
> > > > It violates our own security model, and as such, isn't a feature w=
e're
> > > > going to want to add.
> > >
> > > I don't understand. If the attacker gets the user to set git config =
options,
> > > then all hope is lost anyways, no?
> >
> > When you can embed repositories in other repositories like you're
> > proposing, those embedded repositories can have configuration files in
> > them (e.g., .git/config), which leads to the security problem.
>
> Yes, I understand that, but the user has to actively allow this via the
> allowDotGit config option, which I'll implement in the next patch versio=
n.
> So the attacker has to get the user to set the option. If the user does =
this,
> the attacker could get the user to set any other option (like core.gitPr=
oxy)
> anyway and gain remote execution regardless of this patch.

Even if your patches were perfect, and even if unrelated patches in the
future would never weaken this via an unintended consequence, it is
_still_ too easy for users to get this wrong, or to forget about a config
option they set.

Having addressed my share of CVEs in Git, I am pretty firmly against
weakening Git's security model in the way you propose.

Ciao,
Johannes

P.S.: Besides, your patch would violate a the principle that unchanged
entities do not cause changes in the objects' hashes. And if you even so
much as `git repack` in one of those repositories you want to check in,
the hashes will change, even if there are no actual changes. It's much
like checking in gzipped files which then delta super badly. And in any
case, the proposed functionality is definitely in conflict with Git's
design.
