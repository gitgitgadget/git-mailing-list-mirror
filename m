Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD31FC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDC7206E0
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gOOa5kJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfLITtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:49:05 -0500
Received: from mout.gmx.net ([212.227.17.22]:40739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfLITtE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 14:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575920942;
        bh=wWc2RTvdgHGPUSBtuY5qUqOkg8JgOPlp6X8km/tFKB8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gOOa5kJzm8/nCeJZ1kRyc8IaeWbbPxmoOiXwEMpLeblt930d2O1r+Pc67c35Dq6Tk
         8yiYe1H/+piM2Uk4WNVrpeyMdfZivFXOG59c166e9xMYmZrKH//7HAWttZEXGATLsl
         TKn8DqcWsFvRpvnyw44vATsWfAuga7WOdfxdzCuA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1hcEsP0fLn-012pJA; Mon, 09
 Dec 2019 20:49:02 +0100
Date:   Mon, 9 Dec 2019 20:48:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ben Keene <seraphire@gmail.com>
cc:     Yang Zhao <yang.zhao@skyboxlabs.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/13] git-p4: python3 compatibility
In-Reply-To: <ec301179-f9dc-4148-8634-2abc9263af5f@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1912092043470.31080@tvgsbejvaqbjf.bet>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com> <20191207010938.GA75094@generichostname> <CABvFv3+viMXJO0z5HAQbCya7MU9tWd7P_LxUhu66T74XGN99yA@mail.gmail.com> <b21d153a-02f9-b9a1-7388-59b5a882d4f2@gmail.com> <CABvFv3Jf9i06OmBqOC2zfS+7Sm88PRYa19_rB8rELtMoN2E8CQ@mail.gmail.com>
 <afa761cf-9c0e-cdcc-9c32-be88c5507042@gmail.com> <ec301179-f9dc-4148-8634-2abc9263af5f@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:X8AvYc4iGz5Vv50Nr3JkZqs4p9tPh5dEK9KCwyYfr7+4eMAq0Jr
 qc0Z9ZjAcPREUqjsvXY7agob4ZM0Mus17RkTH6/c1IKHfKb1TuRnGG+Ps0sNcYVn4Ls4IQ+
 6RIUupqpl5hdV2sP1qayv5viwjZLBPRQc9GK3fS6ZkeaJP3ssOvoXTl21iThKexSHChyOBC
 rXXwnB5pjmUJtssQejqVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9MMxQ2taoxQ=:wl7Gim9BEuB6lYzR1h+EcN
 4RI2bNoXFVIXix0XNsBf4Oi5wf3tysqoBqwAuQHHdNUX1ecn4ekBWOaP+wJty2T9SagX7FYaq
 iBueLQ7ahHQfNWTZSWI6E9Q+MEnoAIXpBnbGNPYtT6sy4mY4YGg6106G0vNeuBiAFGKqePFX1
 jNOyHz23LcU/EqdaUZ+rJjmJZqmWb864PK03h3AgG/kTj8klrGdioZW62gS6lBSJnENTKgiYl
 CDfvm09Rc+wZ3QtDvYT2bQWmVJD+nmQfGHFJGOli24C/p1ft4GHWlUCVGOr2Sv0K0ncPjWZ3n
 cQrOmhUlzMr8P6kWHI/bHZJ18PhM2IXmj8O44p0EME+o0zMP+ZNxl8p7W00D6ZG6d2RiECfhr
 zbCAiB9cy40liTovcgs/zy5l4GQb0n7trFYX3zTR8LN3ffnNsQCEQYSBlqtB8uNGyJ2aWusrx
 gRrwjhQDHyLA53wU1qg2j22bsxKpU2ZjibHmRZfH3Up4o1V9OXvY5Fm7Yb8AABowAj4O3KrF2
 fYGOp1PJjii1TXnLgt82UkFXVacG2jALLvhuLCjF+XLtNVHzIuMMVJeFAYz/ePyfzDrWEQdgQ
 tIXZ8LhH2gjXRIx7zEMTCdq7CmEzw/cawUDjg5btO7UrxQkRCVqDx1mOmTU4/28UJLpK9FoQW
 kdsw0HQVtWp/0pii5R8R9mUM0LqU5W16HiP7QSxArdVYuX2VG+1ekBKyBN6/PZNN8ZtNl7TQV
 BhNSHWSg/uAgqdXZyYWs4sPWwbVr2TJUu63faMjuAI3AR07MuO85lpyXTgx25YRluTfMDoNBP
 4sdR+GMftrL2VIF/8ICqyLNyYhgazxmhteEDfeaZPKZzUSoAFZfoL+bW00V68UGWVuzYd1ozH
 PY7D3A6Ha5nwqceXcs/9duVKx6id14yy+oCT8z+lwTQwG2rgG2j0rx3qJN1/f1+tZO7yZZlhX
 UqRh5spCpsLEFRH4/ryioEQSt4nFpRS2I8RqLHtCrtvG96V3jicdWvwVwyn2HPqfEVMq1T4rd
 k2CnJEH5rxbf7JdpqQcAVKhheX+9E+rESthT3ZjC3SypGlFwShDEy+3VA9F+3rp9hTIoaZ1HH
 iON/9rE36Xbgb8+JjNM5gOGPNK/zVkeSri+faZF0BEf/TjI8DyWemwCDPkgjLkrydt20tuqOx
 tcStLC1matNO0tar2Xvj/ldIJ2VcpZURyrchm1iHVONqI2vHpzSqir8e70Qcv5ELL6nDKijpV
 DQ02HBr9a1et6Bi/nCQEbmEdH5UWe32yed4yhiV1i4RGjxVsPQ2Ly1znr9k4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Mon, 9 Dec 2019, Ben Keene wrote:

> So, I just attempted to run a base case on windows: git p4 clone //depot=
 and
> I'm getting an error:
>
> Depot paths must start with "//": /depot

You started this in a Bash, right?

The Git Bash has the very specific problem that many of Git's shell
scripts assume that forward slashes are directory separators, not
backslashes, and that absolute paths start with a single forward slash. In
other words, they expect Unix paths.

But we're on Windows! So the MSYS2 runtime (which is the POSIX emulation
layer derived from Cygwin which allows us to build and run Bash on
Windows) "translates" between the paths. For example, if you pass `/depot`
as a parameter to a Git command, the MSYS2 runtime notices that `git.exe`
is not an MSYS2 program (i.e. it does not understand pseudo-Unix paths),
and translates the path to `C:/Program Files/Git/depot`.

However, your call has _two_ slashes, right? That is unfortunately MSYS2's
trick to say "oh BTW keep the slash, this is not a Unix path".

To avoid this, just set `MSYS_NO_PATHCONV`, like so:

	MSYS_NO_PATHCONV=3D1 git p4 clone //depot

This behavior is documented in our release notes, by the way:
https://github.com/git-for-windows/build-extra/blob/master/ReleaseNotes.md=
#known-issues

Ciao,
Johannes
