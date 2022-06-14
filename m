Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666AFC43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 11:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiFNL3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 07:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243749AbiFNL2c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 07:28:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4861C3ED34
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 04:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655206089;
        bh=UvpwTkRdsEPJQb9lSNZNbtm6rFRiTjclD8TRj3gC6FM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jWqjKm/HIvJZ5nm1xD12xebN2ZM5auKQ7K/ImW7kSljillJokFp6HtxVaxP+gwPYp
         ynMDQLZCQ/NpefFyQLVnMCkpyg4zT3OJEudvfrukuptw3lSz4cLBAwIH3pDW0mQJCU
         3h9ncWWWMuJMb6s+gsKJpnWKc97txk2GUubzi818=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.123.239] ([89.1.215.185]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Hdq-1nzR5P0aEM-002nfI; Tue, 14
 Jun 2022 13:28:09 +0200
Date:   Tue, 14 Jun 2022 13:28:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/5] Avoid spawning gzip in git archive
In-Reply-To: <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
Message-ID: <nycvar.QRO.7.76.6.2206141043150.353@tvgsbejvaqbjf.bet>
References: <pull.145.git.gitgitgadget@gmail.com> <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1630632126-1655196258=:353"
Content-ID: <nycvar.QRO.7.76.6.2206141044490.353@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:RzKFU+8IFOS5Ymmt0q/bjl0pLo31sbEq/I37k1UyW4F2z12xS3/
 UKl3sSvRwVtKbPnvao5RkHPW5JW4k1zhOCDAUuFNDT2jXCIPGWn1DB8Uaz98GJbes4ShdtU
 9T38aBRABOtaZeZAK1iUkxBmcj4v0seX7kPgB2y0tGQ1HYTA1jSuW7iFC679YAlpqdu1qHz
 7qqIh7KRYJWLzHE7yuLNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yN+Ph4Q1mQI=:u4UD3450x3+Ff9TxPlVOHl
 Lu2OQhgDNORC3cHltNIByInS2wMxae5LzwVrLUxSUhfYMi7uds1bzLiUvkQ8xVXErJ5wLUjk5
 OHjA9lGK6DCTDjkQpupYiT8VGMMuhvvbbULJ6iW0uikT9D2GVQ+ln9DcGjTDR2Xal+1SEvoCq
 5ZwY1fVDhW2hA4Flkv2bkokG4TY0GIro7gR/3vbyoiROtXN1Z2KkUmKQ4E7czNMfcLUMrNVlx
 1Ko122NmLaM5nW/yEEKCRydexqSRIIRtqvyBIDUCfRcUvzjIh3uOXO6jMtjKQgxAtt5beQyXN
 9fVU7Z0vbzE011dKyB/KNi/MaIPNQoqON5aYVK78quxWFd9kJLo4rFxfB3z3Iw00VDG0lt96h
 BILLdpw0RmC3Wv1EYkeukd33NPdt6aI1C/rEwTwjYPbXFw4eALlBmKgct/JpSlZO0kgPM+sK+
 uSiTqjcagIt/7Zrj7WEyeM194UH/Yk/cd6KI53BAnaES/+eMlh/Km5A4zNOYbS9iD3BZ1KXew
 K5xkMemrldUkAalUtADcv9JjpkdtbyAPWAjybLnjqdJcQwxmUUv7PkvTJp8S7k/wAEkRe0jO2
 2zkcW/nocESnIKvO/IcMLS9bTC9azbVcRg9X51Gm6unh9+/FCHqPvl4rhsmd7O0T6e8LBJVlP
 OqnCDC9Ih6EO5eHt5sE+9DrAL5TNDCSXZeu5/K0DYK6X5czrgyjpLUrpCRa8me6367Xe0/LrL
 Vedzmy3tWH2yAINPO9zZyMTokQXl9X4+bcrzHkMnEEHO6nV8kwIZvpgZGHlo2UWj72gG36epn
 mNOBHFR6knlYTcF8WjISJR4cJV6ffgBbraMYb1FJNINPq6dPtsNwsuIJFQ7ao4AKZUQ0Em3PJ
 N9+MsBuThgNVmOvKoHloWU4cMXoZRBmOrNn14Ax3x90Wl5AIFfNg4DjDhj7nuetvNgw9AOI5C
 Q5f/Ka22/UwknCfaflEqBreqIuPdchqiUfHJaPLuiTBIcpUYPDJJIjCcMsbDRR2YUFwJd2rgh
 JAtdK+UnD5Gw/MwJIZZjI+TGkjBnyTvW7fHwk3HbpncZzIthVAOiyaAGKE9ZzWR6WL2gMJFCb
 MqGV/o23CCZ6ROBFSUA33gt0RxDUud+5iY6o/18cumrErPHjEtw2AR/sQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1630632126-1655196258=:353
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2206141044491.353@tvgsbejvaqbjf.bet>

Hi Ren=C3=A9,

On Sun, 12 Jun 2022, Ren=C3=A9 Scharfe wrote:

> It's been a while, let's try again.

Thank you for picking this up again!

> Changes:
> - Use our own zlib helpers instead of the gz* functions of zlib,
> - ... which allows us to set the OS_CODE header consistently.
> - Pseudo-command "git archive gzip" to select the internal
>   implementation in config.
> - Use a function pointer to plug in the internal gzip.
> - Tests.
> - Discuss performance in commit message.

Makes sense. Here is the range-diff:

=2D- snip --
-:  ----------- > 1:  9847267888e archive: rename archiver data field to f=
ilter_command
1:  7d50f52e490 ! 2:  a98ef655af9 archive: factor out writing blocks into =
a separate function
    @@
      ## Metadata ##
    -Author: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
    +Author: Ren=C3=A9 Scharfe <l.s.r@web.de>

      ## Commit message ##
    -    archive: factor out writing blocks into a separate function
    +    archive-tar: factor out write_block()

    -    The `git archive --format=3Dtgz` command spawns `gzip` to perform=
 the
    -    actual compression. However, the MinGit flavor of Git for Windows
    -    comes without `gzip` bundled inside.
    +    All tar archive writes have the same size and are done to the sam=
e file
    +    descriptor.  Move them to a common function, write_block(), to re=
duce
    +    code duplication and make it easy to change the destination.

    -    To help with that, we will teach `git archive` to let zlib perfor=
m the
    -    actual compression.
    -
    -    In preparation for this, we consolidate all the block writes into=
 the
    -    function `write_block_or_die()`.
    -
    -    Note: .tar files have a well-defined, fixed block size. For that =
reason,
    -    it does not make any sense to pass anything but a fully-populated=
,
    -    full-length block to the `write_block_or_die()` function, and we =
can
    -    save ourselves some future trouble by not even allowing to pass a=
n
    -    incorrect `size` parameter to it.
    -
    -    Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
    -    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
    +    Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>

      ## archive-tar.c ##
     @@ archive-tar.c: static int write_tar_filter_archive(const struct ar=
chiver *ar,
      #define USTAR_MAX_MTIME 077777777777ULL
      #endif

    -+/* writes out the whole block, or dies if fails */
    -+static void write_block_or_die(const char *block) {
    -+	write_or_die(1, block, BLOCKSIZE);
    ++static void write_block(const void *buf)
    ++{
    ++	write_or_die(1, buf, BLOCKSIZE);
     +}
     +
      /* writes out the whole block, but only if it is full */
    @@ archive-tar.c: static int write_tar_filter_archive(const struct arc=
hiver *ar,
      {
      	if (offset =3D=3D BLOCKSIZE) {
     -		write_or_die(1, block, BLOCKSIZE);
    -+		write_block_or_die(block);
    ++		write_block(block);
      		offset =3D 0;
      	}
      }
    @@ archive-tar.c: static void do_write_blocked(const void *data, unsig=
ned long size
      	}
      	while (size >=3D BLOCKSIZE) {
     -		write_or_die(1, buf, BLOCKSIZE);
    -+		write_block_or_die(buf);
    ++		write_block(buf);
      		size -=3D BLOCKSIZE;
      		buf +=3D BLOCKSIZE;
      	}
    @@ archive-tar.c: static void write_trailer(void)
      	int tail =3D BLOCKSIZE - offset;
      	memset(block + offset, 0, tail);
     -	write_or_die(1, block, BLOCKSIZE);
    -+	write_block_or_die(block);
    ++	write_block(block);
      	if (tail < 2 * RECORDSIZE) {
      		memset(block, 0, offset);
     -		write_or_die(1, block, BLOCKSIZE);
    -+		write_block_or_die(block);
    ++		write_block(block);
      	}
      }

2:  ac2b2488a1b < -:  ----------- archive-tar: mark RECORDSIZE/BLOCKSIZE a=
s unsigned
3:  4ea94a87848 ! 3:  5e3c0d79589 archive: optionally use zlib directly fo=
r gzip compression
    @@
      ## Metadata ##
    -Author: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
    +Author: Ren=C3=A9 Scharfe <l.s.r@web.de>

      ## Commit message ##
    -    archive: optionally use zlib directly for gzip compression
    +    archive-tar: add internal gzip implementation

    -    As we already link to the zlib library, we can perform the compre=
ssion
    -    without even requiring gzip on the host machine.
    +    Git uses zlib for its own object store, but calls gzip when creat=
ing tgz
    +    archives.  Add an option to perform the gzip compression for the =
latter
    +    using zlib, without depending on the external gzip binary.

    -    Note: the `-n` flag that `git archive` passed to `gzip` wants to =
ensure
    -    that a reproducible file is written, i.e. no filename or mtime wi=
ll be
    -    recorded in the compressed output. This is already the default fo=
r
    -    zlib's `gzopen()` function (if the file name or mtime should be
    -    recorded, the `deflateSetHeader()` function would have to be call=
ed
    -    instead).
    +    Plug it in by making write_block a function pointer and switching=
 to a
    +    compressing variant if the filter command has the magic value "gi=
t
    +    archive gzip".  Does that indirection slow down tar creation?  No=
t
    +    really, at least not in this test:

    -    Note also that the `gzFile` datatype is defined as a pointer in
    -    `zlib.h`, i.e. we can rely on the fact that it can be `NULL`.
    +    $ hyperfine -w3 -L rev HEAD,origin/main -p 'git checkout {rev} &&=
 make' \
    +    './git -C ../linux archive --format=3Dtar HEAD # {rev}'
    +    Benchmark #1: ./git -C ../linux archive --format=3Dtar HEAD # HEA=
D
    +      Time (mean =C2=B1 =CF=83):      4.044 s =C2=B1  0.007 s    [Use=
r: 3.901 s, System: 0.137 s]
    +      Range (min =E2=80=A6 max):    4.038 s =E2=80=A6  4.059 s    10 =
runs

    -    At this point, this new mode is hidden behind the pseudo command
    -    `:zlib`: assign this magic string to the `archive.tgz.command` co=
nfig
    -    setting to enable it.
    +    Benchmark #2: ./git -C ../linux archive --format=3Dtar HEAD # ori=
gin/main
    +      Time (mean =C2=B1 =CF=83):      4.047 s =C2=B1  0.009 s    [Use=
r: 3.903 s, System: 0.138 s]
    +      Range (min =E2=80=A6 max):    4.038 s =E2=80=A6  4.066 s    10 =
runs

    -    Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
    -    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    How does tgz creation perform?

    - ## archive-tar.c ##
    -@@ archive-tar.c: static unsigned long offset;
    -
    - static int tar_umask =3D 002;
    -
    -+static gzFile gzip;
    -+
    - static int write_tar_filter_archive(const struct archiver *ar,
    - 				    struct archiver_args *args);
    +    $ hyperfine -w3 -L command 'gzip -cn','git archive gzip' \
    +    './git -c tar.tgz.command=3D"{command}" -C ../linux archive --for=
mat=3Dtgz HEAD'
    +    Benchmark #1: ./git -c tar.tgz.command=3D"gzip -cn" -C ../linux a=
rchive --format=3Dtgz HEAD
    +      Time (mean =C2=B1 =CF=83):     20.404 s =C2=B1  0.006 s    [Use=
r: 23.943 s, System: 0.401 s]
    +      Range (min =E2=80=A6 max):   20.395 s =E2=80=A6 20.414 s    10 =
runs
    +
    +    Benchmark #2: ./git -c tar.tgz.command=3D"git archive gzip" -C ..=
/linux archive --format=3Dtgz HEAD
    +      Time (mean =C2=B1 =CF=83):     23.807 s =C2=B1  0.023 s    [Use=
r: 23.655 s, System: 0.145 s]
    +      Range (min =E2=80=A6 max):   23.782 s =E2=80=A6 23.857 s    10 =
runs
    +
    +    Summary
    +      './git -c tar.tgz.command=3D"gzip -cn" -C ../linux archive --fo=
rmat=3Dtgz HEAD' ran
    +        1.17 =C2=B1 0.00 times faster than './git -c tar.tgz.command=
=3D"git archive gzip" -C ../linux archive --format=3Dtgz HEAD'
    +
    +    So the internal implementation takes 17% longer on the Linux repo=
, but
    +    uses 2% less CPU time.  That's because the external gzip can run =
in
    +    parallel on its own processor, while the internal one works seque=
ntially
    +    and avoids the inter-process communication overhead.
    +
    +    What are the benefits?  Only an internal sequential implementatio=
n can
    +    offer this eco mode, and it allows avoiding the gzip(1) requireme=
nt.
    +
    +    This implementation uses the helper functions from our zlib.c ins=
tead of
    +    the convenient gz* functions from zlib, because the latter doesn'=
t give
    +    the control over the generated gzip header that the next patch re=
quires.
    +
    +    Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
    +    Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +
    + ## Documentation/git-archive.txt ##
    +@@ Documentation/git-archive.txt: tar.<format>.command::
    + 	format is given.
    + +
    + The "tar.gz" and "tgz" formats are defined automatically and default=
 to
    +-`gzip -cn`. You may override them with custom commands.
    ++`gzip -cn`. You may override them with custom commands. An internal =
gzip
    ++implementation can be used by specifying the value `git archive gzip=
`.

    + tar.<format>.remote::
    + 	If true, enable `<format>` for use by remote clients via
    +
    + ## archive-tar.c ##
     @@ archive-tar.c: static int write_tar_filter_archive(const struct ar=
chiver *ar,
    + #define USTAR_MAX_MTIME 077777777777ULL
    + #endif

    - /* writes out the whole block, or dies if fails */
    - static void write_block_or_die(const char *block) {
    --	write_or_die(1, block, BLOCKSIZE);
    -+	if (!gzip)
    -+		write_or_die(1, block, BLOCKSIZE);
    -+	else if (gzwrite(gzip, block, (unsigned) BLOCKSIZE) !=3D BLOCKSIZE)
    -+		die(_("gzwrite failed"));
    +-static void write_block(const void *buf)
    ++static void tar_write_block(const void *buf)
    + {
    + 	write_or_die(1, buf, BLOCKSIZE);
      }

    ++static void (*write_block)(const void *) =3D tar_write_block;
    ++
      /* writes out the whole block, but only if it is full */
    -@@ archive-tar.c: static int write_tar_filter_archive(const struct ar=
chiver *ar,
    - 	filter.use_shell =3D 1;
    - 	filter.in =3D -1;
    + static void write_if_needed(void)
    + {
    +@@ archive-tar.c: static int write_tar_archive(const struct archiver =
*ar,
    + 	return err;
    + }

    --	if (start_command(&filter) < 0)
    --		die_errno(_("unable to start '%s' filter"), argv[0]);
    --	close(1);
    --	if (dup2(filter.in, 1) < 0)
    --		die_errno(_("unable to redirect descriptor"));
    --	close(filter.in);
    -+	if (!strcmp(":zlib", ar->data)) {
    -+		struct strbuf mode =3D STRBUF_INIT;
    ++static git_zstream gzstream;
    ++static unsigned char outbuf[16384];
     +
    -+		strbuf_addstr(&mode, "wb");
    ++static void tgz_deflate(int flush)
    ++{
    ++	while (gzstream.avail_in || flush =3D=3D Z_FINISH) {
    ++		int status =3D git_deflate(&gzstream, flush);
    ++		if (!gzstream.avail_out || status =3D=3D Z_STREAM_END) {
    ++			write_or_die(1, outbuf, gzstream.next_out - outbuf);
    ++			gzstream.next_out =3D outbuf;
    ++			gzstream.avail_out =3D sizeof(outbuf);
    ++			if (status =3D=3D Z_STREAM_END)
    ++				break;
    ++		}
    ++		if (status !=3D Z_OK && status !=3D Z_BUF_ERROR)
    ++			die(_("deflate error (%d)"), status);
    ++	}
    ++}
     +
    -+		if (args->compression_level >=3D 0 && args->compression_level <=3D=
 9)
    -+			strbuf_addf(&mode, "%d", args->compression_level);
    ++static void tgz_write_block(const void *data)
    ++{
    ++	gzstream.next_in =3D (void *)data;
    ++	gzstream.avail_in =3D BLOCKSIZE;
    ++	tgz_deflate(Z_NO_FLUSH);
    ++}
     +
    -+		gzip =3D gzdopen(fileno(stdout), mode.buf);
    -+		if (!gzip)
    -+			die(_("Could not gzdopen stdout"));
    -+		strbuf_release(&mode);
    -+	} else {
    -+		if (start_command(&filter) < 0)
    -+			die_errno(_("unable to start '%s' filter"), argv[0]);
    -+		close(1);
    -+		if (dup2(filter.in, 1) < 0)
    -+			die_errno(_("unable to redirect descriptor"));
    -+		close(filter.in);
    -+	}
    -
    - 	r =3D write_tar_archive(ar, args);
    ++static const char internal_gzip_command[] =3D "git archive gzip";
    ++
    + static int write_tar_filter_archive(const struct archiver *ar,
    + 				    struct archiver_args *args)
    + {
    +@@ archive-tar.c: static int write_tar_filter_archive(const struct ar=
chiver *ar,
    + 	if (!ar->filter_command)
    + 		BUG("tar-filter archiver called with no filter defined");

    --	close(1);
    --	if (finish_command(&filter) !=3D 0)
    --		die(_("'%s' filter reported error"), argv[0]);
    -+	if (gzip) {
    -+		int ret =3D gzclose(gzip);
    -+		if (ret =3D=3D Z_ERRNO)
    -+			die_errno(_("gzclose failed"));
    -+		else if (ret !=3D Z_OK)
    -+			die(_("gzclose failed (%d)"), ret);
    -+	} else {
    -+		close(1);
    -+		if (finish_command(&filter) !=3D 0)
    -+			die(_("'%s' filter reported error"), argv[0]);
    ++	if (!strcmp(ar->filter_command, internal_gzip_command)) {
    ++		write_block =3D tgz_write_block;
    ++		git_deflate_init_gzip(&gzstream, args->compression_level);
    ++		gzstream.next_out =3D outbuf;
    ++		gzstream.avail_out =3D sizeof(outbuf);
    ++
    ++		r =3D write_tar_archive(ar, args);
    ++
    ++		tgz_deflate(Z_FINISH);
    ++		git_deflate_end(&gzstream);
    ++		return r;
     +	}
    ++
    + 	strbuf_addstr(&cmd, ar->filter_command);
    + 	if (args->compression_level >=3D 0)
    + 		strbuf_addf(&cmd, " -%d", args->compression_level);
    +
    + ## t/t5000-tar-tree.sh ##
    +@@ t/t5000-tar-tree.sh: test_expect_success GZIP 'remote tar.gz can b=
e disabled' '
    + 		>remote.tar.gz
    + '

    - 	strbuf_release(&cmd);
    - 	return r;
    ++test_expect_success 'git archive --format=3Dtgz (internal gzip)' '
    ++	test_config tar.tgz.command "git archive gzip" &&
    ++	git archive --format=3Dtgz HEAD >internal_gzip.tgz
    ++'
    ++
    ++test_expect_success 'git archive --format=3Dtar.gz (internal gzip)' =
'
    ++	test_config tar.tar.gz.command "git archive gzip" &&
    ++	git archive --format=3Dtar.gz HEAD >internal_gzip.tar.gz &&
    ++	test_cmp_bin internal_gzip.tgz internal_gzip.tar.gz
    ++'
    ++
    ++test_expect_success GZIP 'extract tgz file (internal gzip)' '
    ++	gzip -d -c <internal_gzip.tgz >internal_gzip.tar &&
    ++	test_cmp_bin b.tar internal_gzip.tar
    ++'
    ++
    + test_expect_success 'archive and :(glob)' '
    + 	git archive -v HEAD -- ":(glob)**/sh" >/dev/null 2>actual &&
    + 	cat >expect <<EOF &&
-:  ----------- > 4:  af27bea4fc3 archive-tar: use OS_CODE 3 (Unix) for in=
ternal gzip
4:  0e5826e3f25 ! 5:  62038b8e911 archive: use the internal zlib-based gzi=
p compression by default
    @@
      ## Metadata ##
    -Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    +Author: Ren=C3=A9 Scharfe <l.s.r@web.de>

      ## Commit message ##
    -    archive: use the internal zlib-based gzip compression by default
    +    archive-tar: use internal gzip by default

    -    We just introduced support for compressing `.tar.gz` archives in =
the
    -    `git archive` process itself, using zlib directly instead of spaw=
ning
    -    `gzip`.
    +    Drop the dependency on gzip(1) and use our internal implementatio=
n to
    +    create tar.gz and tgz files.

    -    While this takes less CPU time overall, on multi-core machines, t=
his is
    -    slightly slower in terms of wall clock time (it seems to be in th=
e
    -    ballpark of 15%).
    -
    -    It does reduce the number of dependencies by one, though, which m=
akes it
    -    desirable to turn that mode on by default.
    -
    -    Changing the default benefits most notably the MinGit flavor of G=
it for
    -    Windows (which intends to support 3rd-party applications that wan=
t to
    -    use Git and want to bundle a minimal set of files for that purpos=
e, i.e.
    -    stripping out all non-essential files such as interactive command=
s,
    -    Perl, and yes, also `gzip`).
    -
    -    We also can now remove the `GZIP` prerequisite from quite a numbe=
r of
    -    test cases in `t/t5000-tar-tree.sh`.
    -
    -    This closes https://github.com/git-for-windows/git/issues/1970
    -
    -    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>

      ## Documentation/git-archive.txt ##
     @@ Documentation/git-archive.txt: tar.<format>.command::
      	format is given.
      +
      The "tar.gz" and "tgz" formats are defined automatically and default=
 to
    --`gzip -cn`. You may override them with custom commands.
    -+`:zlib`, triggering an in-process gzip compression. You may override
    -+them with custom commands, e.g. `gzip -cn` or `pigz -cn`.
    +-`gzip -cn`. You may override them with custom commands. An internal =
gzip
    +-implementation can be used by specifying the value `git archive gzip=
`.
    ++the magic value `git archive gzip`, which invokes an internal
    ++implementation of gzip. You may override them with custom commands.

      tar.<format>.remote::
      	If true, enable `<format>` for use by remote clients via
    @@ archive-tar.c: void init_tar_archiver(void)
      	register_archiver(&tar_archiver);

     -	tar_filter_config("tar.tgz.command", "gzip -cn", NULL);
    -+	tar_filter_config("tar.tgz.command", ":zlib", NULL);
    ++	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
      	tar_filter_config("tar.tgz.remote", "true", NULL);
     -	tar_filter_config("tar.tar.gz.command", "gzip -cn", NULL);
    -+	tar_filter_config("tar.tar.gz.command", ":zlib", NULL);
    ++	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL=
);
      	tar_filter_config("tar.tar.gz.remote", "true", NULL);
      	git_config(git_tar_config, NULL);
      	for (i =3D 0; i < nr_tar_filters; i++) {
    @@ t/t5000-tar-tree.sh: test_expect_success 'only enabled filters are =
available rem
      	git archive --output=3Dj3.tar.gz HEAD &&
      	test_cmp_bin j.tgz j3.tar.gz
      '
    -
    -+test_expect_success 'use `archive.tgz.command=3D:zlib` explicitly' '
    -+	git -c archive.tgz.command=3D:zlib archive --output=3Dj4.tgz HEAD &=
&
    -+	test_cmp_bin j.tgz j4.tgz
    -+'
    -+
    - test_expect_success GZIP 'extract tgz file' '
    - 	gzip -d -c <j.tgz >j.tar &&
    +@@ t/t5000-tar-tree.sh: test_expect_success GZIP 'extract tgz file' '
      	test_cmp_bin b.tar j.tar
      '

    @@ t/t5000-tar-tree.sh: test_expect_success 'only enabled filters are =
available rem
      	git config tar.tar.gz.remote false &&
      	test_must_fail git archive --remote=3D. --format=3Dtar.gz HEAD \
      		>remote.tar.gz
    + '
    +
    +-test_expect_success 'git archive --format=3Dtgz (internal gzip)' '
    +-	test_config tar.tgz.command "git archive gzip" &&
    +-	git archive --format=3Dtgz HEAD >internal_gzip.tgz
    ++test_expect_success GZIP 'git archive --format=3Dtgz (external gzip)=
' '
    ++	test_config tar.tgz.command "gzip -cn" &&
    ++	git archive --format=3Dtgz HEAD >external_gzip.tgz
    + '
    +
    +-test_expect_success 'git archive --format=3Dtar.gz (internal gzip)' =
'
    +-	test_config tar.tar.gz.command "git archive gzip" &&
    +-	git archive --format=3Dtar.gz HEAD >internal_gzip.tar.gz &&
    +-	test_cmp_bin internal_gzip.tgz internal_gzip.tar.gz
    ++test_expect_success GZIP 'git archive --format=3Dtar.gz (external gz=
ip)' '
    ++	test_config tar.tar.gz.command "gzip -cn" &&
    ++	git archive --format=3Dtar.gz HEAD >external_gzip.tar.gz &&
    ++	test_cmp_bin external_gzip.tgz external_gzip.tar.gz
    + '
    +
    +-test_expect_success GZIP 'extract tgz file (internal gzip)' '
    +-	gzip -d -c <internal_gzip.tgz >internal_gzip.tar &&
    +-	test_cmp_bin b.tar internal_gzip.tar
    ++test_expect_success GZIP 'extract tgz file (external gzip)' '
    ++	gzip -d -c <external_gzip.tgz >external_gzip.tar &&
    ++	test_cmp_bin b.tar external_gzip.tar
    + '
    +
    + test_expect_success 'archive and :(glob)' '
=2D- snap --

All of these changes look sensible to me, and the performance
implications, while at first glance unfavorable because wallclock time
increases even as CPU time decreases, are actually quite good. As Peff
said in
https://lore.kernel.org/git/20190501181807.GC4109@sigill.intra.peff.net/t/=
#u

> [...] whatever has the lowest overall CPU time is generally preferable
> [...]

By the way, the main reason why I did not work more is that in
http://madler.net/pipermail/zlib-devel_madler.net/2019-December/003308.htm=
l,
Mark Adler (the zlib maintainer) announced that...

> [...] There are many well-tested performance improvements in zlib
> waiting in the wings that will be incorporated over the next several
> months. [...]

This was in December 2019. And now it's June 2022 and I kind of wonder
whether those promised improvements will still come.

In the meantime, however, a viable alternative seems to have cropped up:
https://github.com/zlib-ng/zlib-ng. Essentially, it looks as if it is what
zlib should have become after above-quoted announcement.

In particular the CPU intrinsics support (think MMX, SSE2/3, etc) seem to
be very interesting and I would not be completely surprised if building
Git with your patches and linking against zlib-ng would paint a very
favorable picture not only in terms of CPU time but also in terms of
wallclock time. Sadly, I have not been able to set aside time to look into
that angle, but maybe I can peak your interest?

Thanks,
Dscho

--8323328-1630632126-1655196258=:353--
