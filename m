Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EC2C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 11:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEC4246CA
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 11:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eCD1t1ZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgKSLik (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 06:38:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:41155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgKSLij (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 06:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605785908;
        bh=+xqA5h04p1WJic/U4SY2QEmnuC6Dx95ArMxFz5fjUyo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eCD1t1ZUpoOWbCrt3KdIrg9jZ273VyjK7VFa8pKBBcgeKu759csrcpXNFowzyIXRI
         pzxDtzECbhZIbtiSdl+UK37zJhyLI1ziJxqqJISBJlIoJpNIJ6G5YGDM4EyVTQsCb2
         Qq3cBdUB2QEzVs1wZNi055UBk+RJi1xARw/T9eOo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4b1y-1ke4NJ3nHy-001gGY; Thu, 19
 Nov 2020 12:38:28 +0100
Date:   Thu, 19 Nov 2020 12:38:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, tytso@mit.edu,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when
 core.fsyncObjectFiles
In-Reply-To: <87a6xii5gs.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011191232490.56@tvgsbejvaqbjf.bet>
References: <87sgbghdbp.fsf@evledraar.gmail.com> <20200917112830.26606-2-avarab@gmail.com> <64358b70-4fff-5dc8-6e63-2fc916bea6af@kdbg.org> <87a6xii5gs.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1223025787-1605785909=:56"
X-Provags-ID: V03:K1:gOh0H5Gz6G1RkKrYeVDIdBa9rtyFyL5XmnK5NL2kZKhk69VFjdP
 rzF2a6rLkkqoCTVx2JAbnwkSMfQhT5ocWaMPOmML9XshUY4l9a7YMlQIB5lwk2eF1MJlGTS
 wbv6h0PAn03AVOmQ5b2PR5LuJ16CAK1RE8/jMRyoKnvLo4LYs59g3A2hAMCwcZxe66sBTZ1
 re92vdGKzmBOV0CBjZFpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kBk1mPaWx04=:AaTP7xlzDzG4aNhrPKTLak
 zi4s0Nedr/lLtgZWCAVieSGfrXmNLawxBBIpCAhTnJhVkIQs44sEUqqcZt3/JalIFwUZIZO7H
 nrcsdS79e+QFq2jCPSfB/Q0MU5Ej5DrTlSPgAzU45EHhAYhinjffy35aDbzkJLZ3adYL2rlx2
 u/rFmPK7kw98gwSNiWL1uqzA29hYhpAthGeogI0Gp50tlpfcCdCv5zU5JPugVb/Ilc46UuHGL
 cHemKO+XtuJTAjHBTL/0l4Ik72SBVAlaXGnyvp2ha/CH0a/id3au6Wxek4PWpoMR9q3LC+qxX
 Oz2FXF9fLfxT8TSZEKwC4qp8W+ckW8sYnjbqYDR69OALeu4hxdb30r3ikqOJvPLjNuPpdUCpW
 8AQTDnKXrjc3J4f6gI33wNASB3p8WKP59fE0DsOPZ9DugZPClQmpHsR3sVCHGorFsXuN9WACu
 IBCZWr9kMB57xGTj30GdNZlSLI860xoOufuCsoJ0Sg7l0b9NLxKnaUns+0CkQVFS+fz3vBKr4
 IAH1/1WQ/mzg0TveI++j5gv3MrNrey08fh8L2/+9MTWHm6TDMJZwvVVjfVdmOokxsrth6OHpg
 clK6NEkUxQkzdkHMgo4Bz87bO69flHtvPLDuOAxUu99imHPVBs6pUZJuff8Z5c+nIhvJVo4U8
 uMyO/QpIvTN7+1RCCZ5S06T0ApqZ/dOJYVMWVw7Uf7s5ph4hZh62O3o/up5MghKD8+ocFC8Vm
 SutogZym6XBG42uSQRCZbS4dqH3PECuF8TkjGQKxJTaGU4JrlK82DfdI4EEMz8No1RuElSeO6
 lWR/S4lTGr97ZVbyJ7oDt5N7JaLn7UA/vPycjPsWQoYbUx3ZcnLZFnUL/HwLOVDIxuZDGqyd4
 o++EoDm9aBNFma9zWYXxBlLklt3uYKihWkpXDde9U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1223025787-1605785909=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 22 Sep 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Sep 17 2020, Johannes Sixt wrote:
>
> > Am 17.09.20 um 13:28 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> >> Change the behavior of core.fsyncObjectFiles to also sync the
> >> directory entry. I don't have a case where this broke, just going by
> >> paranoia and the fsync(2) manual page's guarantees about its behavior=
.
> >>
> >> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> >> ---
> >>  sha1-file.c | 19 ++++++++++++++-----
> >>  1 file changed, 14 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/sha1-file.c b/sha1-file.c
> >> index dd65bd5c68..d286346921 100644
> >> --- a/sha1-file.c
> >> +++ b/sha1-file.c
> >> @@ -1784,10 +1784,14 @@ int hash_object_file(const struct git_hash_al=
go *algo, const void *buf,
> >>  }
> >>
> >>  /* Finalize a file on disk, and close it. */
> >> -static void close_loose_object(int fd)
> >> +static void close_loose_object(int fd, const struct strbuf *dirname)
> >>  {
> >> -	if (fsync_object_files)
> >> +	int dirfd;
> >> +	if (fsync_object_files) {
> >>  		fsync_or_die(fd, "loose object file");
> >> +		dirfd =3D xopen(dirname->buf, O_RDONLY);
> >> +		fsync_or_die(dirfd, "loose object directory");
> >
> > Did you have the opportunity to verify that this works on Windows?
> > Opening a directory with open(2), I mean: It's disallowed according to
> > the docs:
> > https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/open-=
wopen?view=3Dvs-2019#return-value
>
> I did not, just did a quick hack for an RFC discussion (didn't even
> close() that fd), but if I pursue this I'll do it properly.
>
> Doing some research on it now reveals that we should probably have some
> Windows-specific code here, e.g. browsing GNUlib's source code reveals
> that it uses FlushFileBuffers(), and that code itself is taken from
> sqlite. SQLite also has special-case code for some Unix warts,
> e.g. OSX's and AIX's special fsync behaviors in its src/os_unix.c

If I understand correctly, the idea to `fsync()` directories is to ensure
that metadata updates (such as renames) are flushed, too?

If so (and please note that my understanding of NTFS is not super deep in
this regard), I think that we need not worry on Windows. I have come to
believe that the `rename()` operations are flushed pretty much
immediately, without any `FlushFileBuffers()` (or `_commit()`, as we
actually do in `compat/mingw.h`, to convince yourself see
https://github.com/git/git/blob/v2.29.2/compat/mingw.h#L135-L136).

Directories are not mentioned in `FlushFileBuffers()`'s documentation
(https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-flu=
shfilebuffers)
nor in the documentation of `_commit()`:
https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/commit?vi=
ew=3Dmsvc-160

Therefore, I believe that there is not even a Win32 equivalent of
`fsync()`ing directories.

Ciao,
Dscho

>
> >> +	} if (close(fd) !=3D 0) die_errno(_("error when closing loose objec=
t
> >> file")); }
> >
> > -- Hannes
>
>
>

--8323328-1223025787-1605785909=:56--
