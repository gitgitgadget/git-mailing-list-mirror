Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8EAC2D0A7
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 18:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 576EA2080A
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 18:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fi4uhcuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbgIHSvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:51:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:51505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731351AbgIHSvm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 14:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599591093;
        bh=m1heCHMv5bKtZfVaFLZgzrYcox88VNUzMirjV/MtXMc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fi4uhcuv0wE95cF5NCyy6KttELxKPh4S3olb0eVzdeJX6C70jd0kEM6mYfTI/Oep3
         qMBrT3uUkmRDHQ/74O8sVL410V3MnorHQztqxBMEg4ZMnvT/2EaLwxN8kt4DLXh2ch
         9dFnpRXph6R04rX2LXTWUaxMWZinxvl3OG/Lhilw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.21.2] ([89.1.215.189]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59C8-1kEcmf1ice-001Akn; Tue, 08
 Sep 2020 20:51:33 +0200
Date:   Tue, 8 Sep 2020 20:51:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Tom Hale <tomnott@gmail.com>
Subject: Re: [PATCH 2/2] add--interactive.perl: specify --no-color
 explicitly
In-Reply-To: <20200907081739.GB1263923@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2009082047220.54@tvgsbejvaqbjf.bet>
References: <20200907080632.GA1261825@coredump.intra.peff.net> <20200907081739.GB1263923@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:o5tDtbSQJBNqwswxs3OcZ9xlD5xSFtlfK6qNZxZDgE97RngrPPy
 FeJ4SyctfaH2h/Q16dPIcKL5FCAhANuNAy0N8cpTdbIHc36g/+OZT2Ph/6Ojs0Pej+OgBom
 dYkehtNsmQVp1/mWuSk5gbOhlO5BOYDwXrvio1RR2wkd3ZV6OuWeR4eUGYQc6nPIlSNBCuk
 2TjxZtWxq90GlbEALa04Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FlmyLAIPEb4=:lqqT/UgcPT4B7gU+h1NCu2
 oetwlOo7OWuV/VRAFfew6b3WR91BLzoYIqR5ohlBkXyxqhKBt0SNvL+BH2Va2lEyz/3nOFtBU
 u2oBe+kqhpu43wYUSFEfVLad0i7BRkS+JaYxWfFl7Yj4cwtaRGQrO+nrNmZ2znl5Kx27haB9/
 mCu09Gs2M1/6t9KpgiAxlI/w7/ymMmDs+OGZZ6yjkt7fXzp3IHHp1wpPpl6zDS0iOjktlkuXR
 rWoR/sBfiieLZm4ppXbzCa9zufZLtWP9sn35q33+5xMynoOBVXNmLfhH59cfy3s8cvuw4n9Ex
 djdib3Re/RyEKShAwvhJ0blqmuVXKJPnJneQKBiA4bQ+T9ReHOG3fHxkRzwGKBvMSHdHdD+zY
 4Gt2mZRA0WuLhXE4t3/4goN5ycLNQpMikiiNEkwF2aGuQsqYPBWE26h9xxdUbcAAZdDQszy8+
 8EDboJ8+yxANc3hK4sZ8fKp+9v6l4OL2bl68abO+hI8XVA5lUjOzobhJHCjj0/OSHCGHtsCaP
 eSAOJGQp7ndeAoIGaF9aHJ6hXAa8/smiU1U0XU2rQZm3MC3mjPM5NVux32R8WvcA7e+SWvBbY
 kNepu0xncaAvNjatyh6QG0MQlBBAP/h/UkQORMZeTEoIk1p7RX6HWrgixbH+o2SfGzD/gCwZ9
 MGuVRPRNUe4or/2McUVoH2sfCJOvpHhpSp/Xznm1Z1491QPI5m91OyOEiSKXDTWyDr0ZwzXkD
 nX7OK0kdqka3QjyNPT2lWabOFf881yT/P+gBIYgPfvPOg8X4QeSaJbM04IKEwpPAC1OmubRhs
 QZprvSgj4KH8aiDeOmpGTMUV0gAwhNNunXlmw9J//i6GZFBpZv3x5O7yH/B7HthhTJ9D6xY62
 5vPm2OvEYXeeHGq5fMLwHpZpmH4o9uTC5WsFH8tc2zYBYw/dUftDFd6OnBA+psRUZ1Nc+9lcn
 axVTfXgELSyE5wDKrMdiYpvNfOcQg6CsZsQdH2IqQhbg8aTstlLzkW25LxI+pyzpe+b9J7Njn
 kFa+ngf2gOTWbRyqxwATGfY5+Y8dzpw1kumhkS/Fmmo/u6xPgEPFq+yIclaoqqiD1BMfDZlzd
 hOf1O/w/3c5NQQrmDk0SoD8pwc+so/jtPQA30dK+OORH89dUWdmwZxcFs5yNVm9XDaqPxR0nI
 19PEfF+FKxird0AbVt70qYk7jY20j5Kwt13xg+CEFw94fUDryi0hIH1gGD3DICyqfVO5onvGp
 4Dq8dvDPMHHhsSS4J3RjQjPAxPN1gAVMcjdShRg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

ACK on both patches, just one clarification:

On Mon, 7 Sep 2020, Jeff King wrote:

> [...]
>
> One could argue that the test isn't very realistic; it's setting up this
> "pretend there's a pager" situation to get around the tty restrictions
> of the test environment. So one option would be to move back towards
> using a real tty. [...]

The main reason why we moved away from the "real" TTY is that the TTY we
simulate in `t/test-terminal.perl` is not actually real at all on Windows.
Instead, it is the Cygwin/MSYS2-emulated version of a PTY, and as a
consequence `git.exe` simply has no way of accessing it.

Which means that by moving "back towards using a real tty" we would lose
all test coverage on Windows, which is not a thought I like to entertain.

Ciao,
Dscho
