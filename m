Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5817CC844F2
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C3C20855
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="l0Tx60dE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgKPMMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 07:12:40 -0500
Received: from mout.gmx.net ([212.227.15.19]:55249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbgKPMMj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 07:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605528752;
        bh=eoeFWYQLfvSDVTGMrNlgG7myROfUTo7KdQjdl/HVJcQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=l0Tx60dE4fO0J91Hu2eRAx+wwOQ8ovmoJG+mXSu6Uy1w28ryrln/Je2y3sq1KbXHF
         MlOhvww1Hb3DCEgAsZ+i2XnylZYUxMBa+DJfOraPSThE8PxFH6W+aenRE0N8NhRJwE
         i5TkPT7w/aDS8SmI7zYXcNYxWQPZHYrpNdYNhyKw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.61]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1kWckC3jMt-00Aqr1; Mon, 16
 Nov 2020 13:12:31 +0100
Date:   Mon, 16 Nov 2020 00:55:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 07/11] add -p (built-in): do not color the progress
 indicator separately
In-Reply-To: <d0603db3-a6d8-d71b-1ee0-4c5c51b00da2@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011160054460.18437@tvgsbejvaqbjf.bet>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com> <pull.785.v2.git.1605097704.gitgitgadget@gmail.com> <73b6d60a801766605cde9403d7a9e8451ef99e11.1605097704.git.gitgitgadget@gmail.com> <918a0a1d-6384-5615-c343-1f03046770f7@gmail.com>
 <nycvar.QRO.7.76.6.2011131455460.18437@tvgsbejvaqbjf.bet> <d0603db3-a6d8-d71b-1ee0-4c5c51b00da2@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8x0wiXCNahykRo0DVObHZuzzYPGZi4ARWmQU56lIVNA7lq1OFTq
 4rPwvtT8H+m6N7fPwu3dQ7+zVF/V8kOW7koK8zB95RJS0X4kdYWeqyep1aW/DbLXu4oq/PP
 0SbMBgT1iUMfgr9ufuuDmLCf6MbwW7Fv9XTAeE/8JqCGRLadZzZ4BCG3Pg+LOh/qb8A6/QQ
 biBkk2sAscNl+f6LIhVPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vw+tJY99W5Y=:Gdo4/mnzHI7DEgqaeWc1Cz
 CFKAtkNeCUk5rMFXY8twml2Pn+DytTuQ4AwyHt/c2TEChEMb/h507ahueQonotA75bskOGKBE
 8fy6xVL8pBAYm9vl6EPSh5ayarrw6pjPmpFzzW2opC0jYxTXR1IwIatjVdz61ipwJo9x9uh+A
 x3Njvr7Vn+ZZ3AdatgtFqErmoB/KmASA45PqadTEnXlYPG/DzzfuEBzErBwtU+jz4nEucbkd7
 Ip1MkoOCveWZD6eNaVZmymFbrPyj3axsr6JLeKolVkl35Gd88azKuuw34jEKRCMY4AZzW7Gt1
 L2IydAVCiEy56fkhrA7VUp/IPQoFZCjwDLoeIaQ+9wtjbf2ydupxAdjlXDtBAw07jHIyuHFCC
 fb3dmSJRfct3LcX9ZrxqsOz5cI11u0o74iaiEq7K7fMqGZ6frdaJ9DVCxTwdiST2IWpuOcE8i
 4JaQNFOsU8RvS9HA4oDD5mMVzlC361kMpD2vnhUaysKbzjjFa4EMa4JeZd80aeVbj5YBdZwx+
 mIyPUvjBRwYYM1cEcVtBDtYch2virfs442u1Vz+sWd5rnb23dRVEYPM8BNnT4RhciGdpXWXzx
 UGqwoaGA0NILPEMukTJfq9QBqV0rxhm45olWtzCZdg7Me2cPLi/8UVuovF4RKOjsj0s4E61DR
 O/puCipRtbLlOkq1XqXzTBDBpzGzm6rsiyUJfgIOQISdTR2qzMlLBkmmw0H6GR4mU4AXiYrfv
 TWO6kdhS8fTF7QIE71rk74lGuyr8n6UMff53drx0BWE98PNQDUAxNt7Xbo3EPF+1BU+VofY/8
 YftyoRLwNJBj7QxGFvf4EB6vAmcVrXcewFCSmt3R4cjjgvBrTrwuaQVSCt8qqNqiNTw9+5FMj
 6nk56Eap5VP1F3uBIs4v6PucS6rUa79shr6LXE5W4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 13 Nov 2020, Phillip Wood wrote:

> On 13/11/2020 13:57, Johannes Schindelin wrote:
> >
> > On Fri, 13 Nov 2020, Phillip Wood wrote:
> >
> > > On 11/11/2020 12:28, Johannes Schindelin via GitGitGadget wrote:
> > > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > >
> > > > The Perl version of this command colors the progress indicator and=
 the
> > > > prompt message in one go, let's do the same in the built-in versio=
n.
> > >
> > > Why? the C version has access to an api that means we don't have to
> > > remember to print the reset string each time so why move away from
> > > that? I don't think it matters to the user that there are some extra
> > > escape codes in the prompt of the C version. The answer is probably
> > > "so we can use the same test as the perl version" which might be a
> > > good reason - if it is I think it would be helpful to say so in the
> > > commit message.
> >
> > Honestly, the number one reason is so that the _same_ test passes usin=
g
> > the Perl version as well as with the built-in version, something that =
is
> > required by the `linux-clang` job in our CI build.
>
> That's what I assumed - it would be good to document that in the commit
> message.

I did that:

    add -p (built-in): do not color the progress indicator separately

    The Perl version of this command colors the progress indicator and the
    prompt message in one go.

    Let's do the same in the built-in version so that the same upcoming te=
st
    (which will compare the output of `git add -p` against a known-good
    version) will pass both for the Perl version as well as for the built-=
in
    version.

> > I am not really willing to change this, unless I hear a goooood reason=
 to
> > complicate the test.
>
> I guess we could change the perl version to match the C version as it is=
 the
> perl version that will be retired but I'm not that fussed

Well, since we want to supersede the Perl version by the built-in version,
the latter needs to imitate the former, no?

Ciao,
Dscho
