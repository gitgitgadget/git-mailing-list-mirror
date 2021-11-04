Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFE2C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 00:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD7860724
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 00:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhKDAMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 20:12:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:37645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhKDAMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 20:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635984568;
        bh=TgaXAkiR0/XEjKQVwH/C/HbfouADDAbNbqojXLSwJWg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aoDppJXwflTj4fZX9T9TWTe4/GRiEdp6odpdRRmreZhYSmm9LtrSXLMMynjoHmyy2
         Q+PYCer679wtHHIqxT116L5nguOzhD8FF9iEDFfgY2/PICN6LfpR0zageguT2ep0EN
         txt0j6GaCZohop6rmTLPaUsy9ThL8fxlXZOg9UGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1mom6T2ml7-006xPB; Thu, 04
 Nov 2021 01:09:28 +0100
Date:   Thu, 4 Nov 2021 01:09:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v4 5/8] odb: teach read_blob_entry to use size_t
In-Reply-To: <20211102204040.nnndsqrzu7ozpva7@tb-raspi4>
Message-ID: <nycvar.QRO.7.76.6.2111040102560.56@tvgsbejvaqbjf.bet>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com> <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com> <308a8f2a3ade63ef21feb945e45866f2a83ae101.1635867971.git.gitgitgadget@gmail.com> <20211102204040.nnndsqrzu7ozpva7@tb-raspi4>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-466323625-1635984568=:56"
X-Provags-ID: V03:K1:S2KjT5nu2Koae6Ucj4wGjvIySxd+qsM1tf9CYclQQNPuykAP/gE
 PoY4u6FI1zWbLJx+praW1Fh9xbhTCIoFiHTHGlCwpAmozioXnBGIo/BplpfXDM8zqQXDSNu
 3u9k+ctNQH6ajBhIXA+LjcCfYjRM+4Nz5lpz/5nmKv2SBH8O5VsAuC0514UtJf/J2eFHWVP
 JEXIIuleYTWCH6QhLrWxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t3OBetRxHfc=:ujyfyhcDhvL1fFJjIGLYw3
 gMCQvjpA3+VbnQOHFtZOVYx7WU9tg0HvtSLm8YicVFRHvd71eG52hNDE7GXMCbruwJfij9SAp
 nm8p/+vMAi1Mvo1ekmI+q0LIT76Z/+dLS/MC4tOlqTpNxo+jaFfVzzYu2+ojTQMFLvZJyUnW6
 CQVAuH3TH+m2NUhV2awwTn1Pe9lPmUTOJtVozSmHPXfnputHhu7yFETLF3w8FhSstEK53X/b1
 xDcM6l5/qUS96iF2IxRp8RsNHqjR8dh38iFE+Lk787ug3EFG0fEMr3/HHzWFiYuRw/uSxaJOI
 vsKdPSkbJZDsnidIamR1xDEhUzf+i1YT1KKXBpnwzVQq5pgMdU7X5MGUYyki5g1l/eofNhokl
 h4eimozSHZFCpagyCfGXvGTaBN0Pssv9Ly8gUi8+wywuDtqgbrJCTBuZuwJ3e6xPA7YltSk5n
 i4hTVpgY3b7a8KVmGNYI2i/EQofg6VJE7piN0CiRcZDkEYIiFzpE1bXROHDrYpDChvOLoq6bz
 nzwTmzbkGoHG8kOV+RgXwBY8T2dIk6rGAjmQVjijo+Ff+muEaCg1gMQkpLXgI/ldTYA+7LPmR
 5Y4CCOcVJ29/x7Iuw24esf8zui1RIieR86Kbf52yNp7QIw56a0/hbNTEQpIgFaPldZ+dDAz0w
 IgfCBb2CTV8G816CTHvhPsrhPg8vPvyjWLB2uJ/kguEgNlLB9liqYAvWvRLhjJYem+iROQBcn
 PIJT0O2BppCkUoaxppIgUgtnsMunkDKDEK5oYrYIZIGgrNFwu5cEpfWkvQCUXIiQEG6ktdftZ
 fEGX43sFx/U7KVKIn62wEM0fatY8BNAw5FsDiEtB+CbeFPhTfYtzPcOjMACIOQ5Y6J2qtwuZ3
 NQ7giN0Cw5xpHn/5HKDmm910tHxjGnVBFBPypoHUSn9NZWJ//ZWm9QR37vNNKnjPXqoV2J7oC
 25fmX1BMsudyLwvt7goQM8junX9H3qJLHgGMcTVq6y0NnMEKGxeJz64VX9+4m1H2g+8iyMJB0
 XYMu7FrOOTfTw5Y+y/bTd2rLzGadl4CbDRnt/ajK69WHXqwR8Cxdi09Ezp9ntgKSFfrUJo1ud
 q35EnxNS5GLOd4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-466323625-1635984568=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Torsten,

On Tue, 2 Nov 2021, Torsten B=C3=B6gershausen wrote:

> On Tue, Nov 02, 2021 at 03:46:08PM +0000, Matt Cooper via GitGitGadget w=
rote:
> > From: Matt Cooper <vtbassmatt@gmail.com>
> >
> > There is mixed use of size_t and unsigned long to deal with sizes in t=
he
> > codebase. Recall that Windows defines unsigned long as 32 bits even on
> > 64-bit platforms, meaning that converting size_t to unsigned long narr=
ows
> > the range. This mostly doesn't cause a problem since Git rarely deals
> > with files larger than 2^32 bytes.
>
> What does this mean ?

I found the explanation to be quite clear (otherwise I would have changed
it before submitting, obviously).

Git is rarely used with large files, as it was meant to track source code
files, and it is pretty rare that a source code file is larger than 4GB.
Therefore, the described issues are edge cases rather than common ones.

> > ... This mostly doesn't cause a problem since Git rarely deals
> > with files larger than 2^32 bytes.
>
> Is "mostly" is a good wording here ?

I do think so.

> May be

s/May be/Maybe/ since you're nitpicking wording ;-)

> This doesn't cause a problem when files smaller than 2^32 bytes are hand=
led by Git.

That would lose the rather important fact that it is common to encounter
only tracked files that are much smaller than 4GB.

> > But adjunct systems such as Git LFS, which use smudge/clean filters to
> > keep huge files out of the repository, may have huge file contents pas=
sed
> > through some of the functions in entry.c and convert.c. On Windows, th=
is
> > results in a truncated file being written to the workdir. I traced thi=
s to
> > one specific use of unsigned long in write_entry (and a similar instan=
ce
> > in write_pc_item_to_fd for parallel checkout). That appeared to be for
> > the call to read_blob_entry, which expects a pointer to unsigned long.
> >
> > By altering the signature of read_blob_entry to expect a size_t,
>
> "expect" -> "use"

I would say that in the context of talking about a signature, "expect" is
a better verb than "use".

But then, just like you I am not a native speaker, so I think we should
maybe stop telling a native speaker like Matt how to use his native
tongue...

> (I am not a native English speaker, would "changing" be better than "alt=
ering" ?)
>  By changing the signature of read_blob_entry to use size_t,

As I said, I am not a native English speaker, either. So I believe that
Matt knows better than the two of us together how to phrase things in
English.

Since you had nothing to say about the patch itself, may I assume that
you're fine with it?

Ciao,
Dscho

--8323328-466323625-1635984568=:56--
