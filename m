Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3BAC43461
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 18:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B2A62145D
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 18:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LNCtK4E1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgIGStY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:49:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:49935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIGStV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 14:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599504554;
        bh=W/GPB/H+ifhDBV3QgWp9KrloXo+tKpnqqlQ4KGxg1d4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LNCtK4E1gPTEMLvGTiOieuj50ZoUdJeNFBNDITNtlLKU9qK2fFMQG8KwlywoLkl25
         Qr6nfovlaGxjkNAdXKN67dxJ+pUuKcPf6k/oasqpfol0qGDX8c5kfO7aqhRqBvlxxR
         K4eujrWOJeECsiwENZbtSXqjy9Acxqa0ZBZfdTwg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.215.223]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MORAU-1ju0fM2PKo-00Pwzm; Mon, 07
 Sep 2020 20:49:14 +0200
Date:   Mon, 7 Sep 2020 20:49:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Git in Outreachy?
In-Reply-To: <a3613b9d-730a-7a4b-c84b-c833490fcea6@iee.email>
Message-ID: <nycvar.QRO.7.76.6.2009060933480.56@tvgsbejvaqbjf.bet>
References: <20200828065609.GA2105118@coredump.intra.peff.net> <CAP8UFD2rpNhDhyHdQNxS-KJZgcumsCpK_JQ5koCqXJd70s-+_w@mail.gmail.com> <20200903060041.GH4035286@google.com> <a3613b9d-730a-7a4b-c84b-c833490fcea6@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NXuH7aP/+ljwCwCRo1aHt4+jH7BMRi4+JKawHvaCYZ/RHNn/HLL
 f9yH7830VeR4sM8w3TKmhxJI1GX82dZ2mjmrsZWBtWnUh7xnXVc0lHqIMNOCMaJZ8BwF69i
 Cfepz0E53yE+3kCBl+XcBMomhKwgn57BwAl2NuWiuPqKdyuJCc9wX8/+aVnSZLsT5TOgIYh
 4BwR93wPz5+4WxaWtEPOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:48+ubT3G2l4=:TdMRtyIjSem6juk62k2UwY
 4sPA82QdFRHxqRj00gF+gyOt3KQgv5yU07nPpNB9HW6L2Z7Dgzg4QY2izzzZ1LZwlWzKy91tO
 6JsPYETWYqMfx6vwKjn8iE562ioV0VNVcXxCNo/2loXmkrZ+FGk6LnWTMZdUnqdkJBU1tifOy
 ekwcuUGq/cwg9zLWkjUSuHygTfL0m7BR9juLEQ08ORHJPF4uhTISIfTIPG7inZI3t1Y5C0i58
 P9MqHtiwjlBE9TaerWPQMmo7jP/eopYTr1LvRx+ma0XctuErAQIC16PHXyUTa5abpNvp1G/id
 SyvycIq5B7+d+mVGo7ZpJAAH0eTE67pBagdX5G0dfJHnidpffwcLC5Pn833evQi37dULN7hke
 PzV+SjW0vRgLzAiRcNVdWD9wnPDnMfv3bmjwUz3nDpFvWQYeekuk0klThV87tjd7J/+8cO3Ao
 BA75PY5OC1Rb68mUKEgn8cShjxGsc7H+r6TcO28Bti71FOLi5ADfw33BpoOEP+1GUYijVCUmA
 fj8TF0kAg2zKEEFSoLBNwgdTfDW87gMSXhV5Ak8+eRr+zSdDxQc9d6HXBzCdrKQLKhRtVKB8F
 AAlqONK3OZQa7ICfBIk+rEXxOjygMxcfDasdhCromTZ09c5QDa86YfQzPOeMqybJADIWK8ZcN
 UF6oVSZTCHBdUFgarfktR3k+6oETSCtDyU+x3v00Rsupw7QR9YON3d/tpEqZqVVlnR/eUsRZj
 WwII2+xY6zk34hpZzWJOelKw9QtP4hA3TVHZslTk2DDyfRx1RHaoprT9QpTNU6g8SoQ77/Stk
 CY9v6D6SZTWN4SpUe5rCDHU9Uy6XBsCSZrp9OAV+s7ny9yPc/hU5VXtumTLPAVSejyrA8K2p7
 EpuWeNsGlOURJYbt+V9PAKa5jwke43cvZiQcld//m1g0m/tVMNrrmtmljNEgkK4MzJx83895I
 jqvqJ1rkM6jMNEEe1njGtnCntzmV5m8BqOlsq/HgBgiCaZY8G5KLAJYVP2zf8zcj38M2512ho
 Q09g8NhQnrPFfVDbwM5AGxApWCP0Qfn1viUsgH4rI457J/u7VIhzvxvPzn5hGQg9s4QScQP9R
 r5Q496+D79Bvyut3ltNTpJQjm2Jc1kg9T8FsrUn8JlFf8oStOa51ZHFKwL1vmQly7LH1nMmFC
 MNyzsHhEjidHZqdlTo2q9H7IfUENdXIMjKqlu3Uj5ibp/uBGdTFz+g7UITMAcCZuvITK9wgyt
 fPbHeBhc5xaRn4xz8ExRO4CenOI1ulCOfqiQjcw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Fri, 4 Sep 2020, Philip Oakley wrote:

> On 03/09/2020 07:00, Jonathan Nieder wrote:
> >
> > Christian Couder wrote:
> >
> >> I would appreciate help to find project ideas though. Are there still
> >> scripts that are worth converting to C (excluding git-bisect.sh and
> >> git-submodule.sh that are still worked on)? Are there worthy
> >> refactorings or improvements that we could propose as projects?
> > I think setting up something like snowpatch[*] to run CI on patches
> > that have hit the mailing list but not yet hit "seen" might be a good
> > project for an interested applicant (and I'd be interested in
> > co-mentoring if we find a taker).
> >
> > Some other topics that could be interesting:
> > - better support for handling people's name changing
> > - making signing features such as signed push easier to use (for
> >   example by allowing signing with SSH keys to simplify PKI) and more
> >   useful (for example by standardizing a way to publish signed push
> >   logs in Git)
> > - protocol: sharing notes and branch descriptions
> > - formats: on-disk reverse idx
> > - obliterate
> > - cache server to take advantage of multiple promisors+packfile URIs
> >
> > Jonathan
> >
> > [*] https://github.com/ruscur/snowpatch
> A suggestion with high value for the Windows community
> - mechanism to map file names between the index and the local FS, should
> a repos file/path name already be taken, or invalid. [1]

This suggestion keeps coming up, but I cannot help but highly doubt that
it will prove useful in practice: if your source code contains a file
called `aux.c`, chances are that your build system lists this file
specifically, and it won't do at all to "magically" rename it to, say,
`aux_.c` during checkout.

In contrast, I think a much more useful project would be to relax the
`core.protectNTFS` protections to cover only the files that will be
written to disk, and not bother even checking the files excluded from a
sparse-checkout for invalid file names on NTFS.

This is trickier, of course, than meets the eye: we would still want to be
_very_ careful to ensure that the unchecked file names will _never_ make
it to the disk. And, slightly related, the question whether checking for
`.git` (or `GIT~1`) would be likewise weakened, or whether that is too
dangerous to allow even in `skip-worktree` entries.

Not necessarily decisions you would want to burden a first-time
contributor with.

Ciao,
Dscho

>
> Philip
>
> [1]
> https://github.com/git-for-windows/git/issues/2803#issuecomment-68716148=
3
>
