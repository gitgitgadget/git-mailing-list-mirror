Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0982BC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 13:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiAKNr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 08:47:56 -0500
Received: from mout.gmx.net ([212.227.17.20]:38065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241007AbiAKNrz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 08:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641908870;
        bh=3/MNNASQRqeLIWa/SMj+nl0ZmK++100XzkOcIDK/Cr4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BOIfhzojlmErGXvTskECCXIoLSnOPyfS/XDxLyHBF0QuAzaYSFjUJqSZfS1mXiJWI
         qlaRsLleARz54vDnfbmj1gKeqgxqn0cgB4AzIeslpceKxLkzhFoSexU/8gFP2PQgSr
         CITAz0ZZyi1xA2jvJBtp6C6JpZn+2YeBvuTXhavc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.82.111] ([89.1.215.56]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyuc-1mBU9b3nsM-00x02S; Tue, 11
 Jan 2022 14:47:49 +0100
Date:   Tue, 11 Jan 2022 14:47:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
In-Reply-To: <xmqq8rvn1nkw.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201111439190.1081@tvgsbejvaqbjf.bet>
References: <20220105163324.73369-1-chriscool@tuxfamily.org> <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com> <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com> <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet> <xmqq8rvn1nkw.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KreNn7QU53KlS/CQY8pRYlXlrDXP8sDhiQExPIhu8osdgjGYAAX
 DRHqU6PlkXHBYGoTM/Q5w5zCjIQMKLf5c7HLCtKs+MM9qkZ6t+mkA7Ij+izxkjoEexnYKH6
 Bo5LCGLrI8Yueu+h2WDhgdGEJ+uAZ1qGqDr3IhMRqVN2Ae8YB+Ci8DZx2rYn4fXiN1jswWH
 iI+irmPBnF0KntL/ztWJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8atxeFsEhn4=:pBBq6gq7rp5KP0Il8v7OTP
 5V5JQFk+jy45vEEL8cQLjQ7IHkn9Bb643+ZV1MkrSjepzQv0NDqfDOh4PqLP9cKT2Tqa1zKlU
 7dTtdCjKWEGPcMH5uHioQO0jjs4zDr/erkfx5AE1bc88y03dKR7S7iDwSHyS8d7B+4DmsGLyL
 +NNdPYjJ24hPBzbOUHYRrBo5y2zv4xuoByOvlGhvEYWXHuR+eU6lQ/i5M7wzecfiJ0JqOhmE9
 3K0gAcU0eNIswZZjpbhSuGiJAeD/Tfxbaf6SJb7w6ADIhbK8Q+rnIfqMXPldL8ciiCXynNRQH
 oA2Y60tSgSM3iGLD/WBt8xakS8+hHz8wcw5MURp4DbThNBrqItCu6a9ol4UO+hcgYyCPMijtG
 K6r2puNHoVyxrKoFKpl2Zh5GWTPjYEslr+GT7NX2EioQQ5+5qNGbjILs9Dx9uq4Sesi8RcmUe
 Erz+VbrKrsxL4WTHMG/raPlThlkI6BGEvhEHls5m6v+CQdQPvapw6V3kLEojppYeaTI8aSBfi
 imhTfTlwN6xNiA2yzGX838ZEvevCIe5tfLS+Fo1m7Mn6aaNewRxRkvHGzfY1dAF3BFH9BJtQw
 vwZvuHQdZYJ7njkyiYeYbZEjScvS3IeT7ZITEm0XypQHMoXyN32skcv7ylhQpwXMTrw2xJcJW
 P4JRucewucPgWGIcpfjrO5jOuxoE2qSmCb2Fjwtfr61U9CMO+EWMfG5USdbeG8+nL8DF4hsWQ
 753tg99T/Oxz0+BpbOyOn+3RgA6FmlWWM1ZfBeRTdrQrX4xMTj6It4p2POV39yPy4TQ1323g6
 S+uuwR7RnBE0g8n6jOukTU4w/nTTgj/QdcmGBDYjP2g5mAx7o75UDOy2gQ5SOiMferntLW6PD
 CBmF0h1/IzzvPpRczXPjxAbuCDlEXIVArP7KhzaE7nTSfVPyvg/UpG93J47/JeBoIHERP9gFh
 2OL0pIiG9okfMb0SZSWG/jkHl+NuCTMUqSKY8I2nNydGV5ebOWGgSt4+Rj+eK4bRrNxy8hKPI
 3SriCVq4WlGOLaNsppjBPdNs8e9hF84997lY2OBV5CXoVV/yNdaJW4CfhWGkNAcYFx9K0zWX4
 Kke+tb3qYTBmEE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 10 Jan 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I am against a new command for what essentially serves the original
> > purpose of `merge-tree`.
> >
> > The fact that `merge-tree` has not seen any work in almost 12 years is
> > testament not only to how hard it was to disentangle the work-tree
> > requirement from the recursive merge (it is one of my favorite
> > counterexamples when anybody claims that you can easily prototype code=
 in
> > a script and then convert it to C), but the fact that there is no user
> > within Git itself (apart from t/t4300-merge-tree.sh, which does not co=
unt)
> > speaks volumes about the design of that `merge-tree` tool.
> >
> > So it's only fair to breathe life into it by letting it do what it was
> > meant to do all along.
>
> My "Yup" would not weigh as much as one that Linus (whose original
> merge-tree survived this long without seeing much enhancements)
> might give us, but he is busy elsewhere so you guys have to live
> with mine ;-)
>
> As to its output, I do agree that "we give a tree when it is already
> usable to record in a new commit" is a valuable option to have.  The
> original behaviour should be made available somehow, for those who
> built their workflow (including scripts) around it, though.

No, I don't think it is a good idea to keep the original behavior around
indefinitely, when it is totally unclear whether there actually _is_ any
user of this feature out there.

We intentionally broke any existing users of `git-parse-remote.sh` by
removing it, when that feature was much more likely to be used in scripts
than `git merge-tree`. We cannot say on the one hand that we will get rid
of some useful script just because we don't want the maintenance burden
when on the other hand trying to keep support for an operation that is
unlikely to have any users. That does not compute. (And don't get hung up
on the specific example of `git-parse-remote.sh`, you know there we
shuffled around _many_ more things recently that had a good chance of
breaking existing users.)

Besides, the original `git remote-tree` behavior will be very easy to
recreate using the better UI, the one that outputs tree OIDs.

Ciao,
Dscho
