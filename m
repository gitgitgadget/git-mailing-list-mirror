Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF17C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 12:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbiEXMOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 08:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiEXMOr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 08:14:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B3B6F492
        for <git@vger.kernel.org>; Tue, 24 May 2022 05:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653394455;
        bh=IfkXdgglWQJXU+FRtnl8hm36hODjYayalzwM32CQsas=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=boyndb3djmEYydhi88ywwUyCRWAHWaBSYEB5nGdBGyDCPgxEqSuPxZ0ulF5R1aivs
         StconF4Lh3C6ZQBZTwDvKq36/s+Kx1wtBIPPajItSNuXBn4yso8JMq1qJ+bXrLfcbp
         AF2k73b2+LCcQ+KmaU+3LYk1V40v7G2NwICopn5w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6mE-1nPezj16NA-00lZ3J; Tue, 24
 May 2022 14:14:15 +0200
Date:   Tue, 24 May 2022 14:14:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 27/30] t/lib-unicode-nfc-nfd: helper prereqs for
 testing unicode nfc/nfd
In-Reply-To: <xmqq5ylworwy.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205241400200.352@tvgsbejvaqbjf.bet>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com> <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com> <6a8308699543faaea760d4605babe50a0e478f41.1653336765.git.gitgitgadget@gmail.com> <xmqq5ylworwy.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ITs5l3cmC6dKEnJFff7WkQ/fTJAto77Y1pfd/iyhy1WaKYCptc7
 gaUfIgsO9BtOIT7xPaUSOvuKw8Zvzo9ZXbrY7JUBFR69CV4YZx4yviF+PpuZjkPjbSoW+my
 kp5QpubNNuJGOVterKMAnUHgcY13SbhcvbrZLh3ure+EzhnHovhTN2yNrsa/rdUgfjecXKU
 jvlmYzK9v2SI5pFjv9Png==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D057zApB824=:WP1Q3AZ3E9rBW2IcG8qtdk
 NthIOa7crnKL4Wuf+cH4EMN3wpvqlND1rCJDPs7tpaPhBARjhw8SmD2cKBWWy4Kxu9RsZyg60
 vCDIS5rvi1K3Wqnx6Y/ZoB2EGQkjuc0P6RwOOyUDKhVZNLJhW/9+W+uHv/1XD514BrSz82UY+
 PiYa5mJKY0oWsWLDIj8NXr4+i89DgrKaWRvcjET1P3ye3/1GIvjPnzyCPY3Id5tgVJT7RDlMt
 cREukeExWR2hikLKB3nvchoJS/HqyJD2iclRQMr9UE6HL/sP/CTJaORO0oXah4CoRgSHQbDjJ
 iEe3oVq9vl9Fo3NgUdUDvNc+CDG+9O4hQnzxrWL9Tyk5kOgLGLSlXgq5jGAN4ijACwRR1wehO
 PCQgYeo907fOvFufVz8S+F1gtFXK3sdIWAm4Xj5xC2+buPcNMDjJLveZJ0LP1SCZsrYLUWDws
 Sw6zIlbxzZMWggL7b52bWfwbRHa7j5pEU6DlzXSlBG34dY0Mem9lNOKBWC/I26dAlkSZz21JW
 +j0pwaYRTDc3NdAbS8yu8+iW8iZUpBuQFublnK4NNlt8V4LzoCO7foYRhowQuhXcvlGX32slM
 U16MfwvnEqt+DErjZtj1q2xA6lDyJGfVrON+DZYmzmxkuAI07XSGW5GVDkpRFsfKr2RfPle6i
 dJ075tgsEwACpKTks5XWIoYcZcGUAM9TBeUQEID2KqXuoZVDA7BGAZB1T3mGn+xrc0+goQbg5
 93DAXYWyRn8iNeMlzlE6avGvAUePmSF461wvZAkAzF5GzAbNXHn9SogvH+uGrZvd2RkV+Lpzl
 2N37J+EQ/RFL8xThJyb7StHcypkxkJCzN+tTtIRk742HBJaVpKhhfoLD6hlTaOSOTD/auDV3K
 10dGAvJjZVKU3poN5rAQlH/37QfJzvspMkkCx21RAJBRpLDF6i8B+7JvbmNKFxt79oQu6M/Mc
 EWt0aaBl2Jbdts19btb3OJGSZtNLqJF09+v70vDIV0qKe21xm28w4Ub4hlGbehE/TlyaRcxFd
 gmYsJcn8wYFPviv2kYaPfMlz6VDavQnSLH9t9DJwaBr0Tytf1gzpIsHVG+wfTZ6cWrrDQgbdh
 /OjzX/D2q+lWH1Z6GsY+R3aVhBfqW9CmHQhlu5heqrALV5IAsU5dXpdow==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 23 May 2022, Junio C Hamano wrote:

> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> A devil's advocate suggestion is to go in the completely opposite
> side of the spectrum.  Perhaps if we are willing to limit the tool's
> utility to the tests done in this script file, it might be a good
> idea to combine the latter two elements in the pipeline, i.e.
>
> 	ls | test-tool hexgrep 63 5f c3 a9
>
> that exits with 0 when the output from "ls" has the 4-byte sequence,
> exits with 1 when it does not, and exits with 139 when it segfauls ;-)

I like the idea, but from what I recall of the Knuth-Pratt algorithm
[*1*], the implementation might get a bit more involved than the current
`test-hexdump.c`. With non-repetitive patterns like you wrote above, you
can simply re-set the needle's offset to 0 if a mismatch was seen. It's
partially-repetitive patterns such as `01 02 01 02 01 ff` that make things
tricker: After encountering a `01 02 01 02 01`, if the next character is a
`02`, we must not reset the needle's offset completely, as the next two
characters might be `01 ff`, i.e. a match.

Since the purpose of this already-long, already well-iterated patch series
is not necessarily to improve the test suite in such an involved manner,
it should be left as an excercise for another patch series whose purpose
_is_ to improve Git's test framework.

Don't get me wrong, I am very much in favor of that `hexgrep` idea. Just
in its own, dedicated patch series.

Ciao,
Dscho

Footnote *1*: I actually had to look at Wikipedia page at
https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm
to realize that I did unjustice to James Morris by forgetting that they
had discovered the algorithm independently.
