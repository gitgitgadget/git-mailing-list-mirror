Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5B11F405
	for <e@80x24.org>; Thu, 20 Dec 2018 10:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbeLTKEN (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 05:04:13 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42735 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbeLTKEN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 05:04:13 -0500
Received: by mail-vs1-f68.google.com with SMTP id b74so682216vsd.9
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 02:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=anep95/OOU3GjDDxzEWruEQ+TXU/kXoqlJ1fhShcNUI=;
        b=Fee0/UoIfsiTeuqyqJODW1mik12wDkIdenUtuAOE5P5JdvX2G5gSQQZDH3iZSStKn9
         u2QkF/06NTLmTcF5cGcSaUmGf2Yd5e4nmkGuwMM6oLFHP08GvipJN5Q15Teqct/e+XC2
         gsXQGz4AJ0u6vcXyfbbPK5L85nUEr4xlOhqlrag9Ka5HTSFKXJtRzgP7iZg3wnZdU/XY
         ntwXBCdy3nNTs18K2N4jfBUFXelRmnlA7VvrLIGjslNdUTc9FkIBd3lbw38Dw9o4MMJP
         jmkekkJAZxXCB1B+5XtT9H1dWDNvQLF2n4x7s9jY08Ca8ML4JjCqm/kM0C3eWqkE9TFu
         hmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=anep95/OOU3GjDDxzEWruEQ+TXU/kXoqlJ1fhShcNUI=;
        b=AOU+AJprEpM/dGayYSxxXmTfvN88N4h0kuw19hXRVRA1UhlEUubk1sl49WeSipCpLv
         9Vi9UxPS3hw9TrK/VzZSEqTayh0CWWZcBirhLoqcyK9gczFqnsigY9oagne5K0OgA8AY
         6lkyGRCxxN4zYzRWgG3Q4fdvsWPtupeL/TIvwZ4eHk2Y/rmTXBr/ofMmaKlxOtkWRs4v
         EwITuJXptVMIK3+YQK8OLgBo+xUF/iCNIv2/uJ20XvGslRAS0DaGL8quzUowx7qz2uVm
         emtB1Q2fcMq4fQWZYC7upHwFNWNmqMw47yhZMCgXOovsTr4yCjC+R2myeZ8IF9Jz9hRx
         78lw==
X-Gm-Message-State: AA+aEWawDzYmiT6Y4xqB2HocsB9WY/HJjR94Mq1YM/uV0jJhqAWCu0CT
        8dkCWxFTT7kRagSlGwKppyHE0WWUx08VCPp9l1Yi4tO+
X-Google-Smtp-Source: AFSGD/VR89A6779j+Exgm7eGoxoO8zWgRLL9RzIMyUf01V8U47TI64HOJHfasY7Ct1vsOd1Js5bi/cWRxBrH/ArQVdY=
X-Received: by 2002:a67:4850:: with SMTP id v77mr12100038vsa.59.1545300251027;
 Thu, 20 Dec 2018 02:04:11 -0800 (PST)
MIME-Version: 1.0
References: <CALjAwxiB1uDfg4iPFjh2dNibEZa5mJ0RwhCzt0R2b87NTVqWfA@mail.gmail.com>
 <20181219232200.GB21283@sigill.intra.peff.net>
In-Reply-To: <20181219232200.GB21283@sigill.intra.peff.net>
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Thu, 20 Dec 2018 10:03:45 +0000
Message-ID: <CALjAwxg2E_48kQYt1GHkcXvVmaFyPY3PGG9rHZNMp+++UqKfow@mail.gmail.com>
Subject: Re: Periodic hang during git index-pack
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 19 Dec 2018 at 23:22, Jeff King <peff@peff.net> wrote:
>
> On Wed, Dec 19, 2018 at 10:59:30PM +0000, Sitsofe Wheeler wrote:
>
> > While using trying to use git to clone a remote repository git
> > index-pack occasionally goes on to hang:
> > [...]
> > Looking at where it is stuck, git is doing read of a pipe:
> >
> > #0  0x00007fd1b845034e in __libc_read (fd=3Dfd@entry=3D0,
> > buf=3Dbuf@entry=3D0x55ab81e19d40 <input_buffer>, nbytes=3Dnbytes@entry=
=3D4096)
> >     at ../sysdeps/unix/sysv/linux/read.c:27
> > #1  0x000055ab81b51b23 in read (__nbytes=3D4096, __buf=3D0x55ab81e19d40
> > <input_buffer>, __fd=3D0)
> >     at /usr/include/x86_64-linux-gnu/bits/unistd.h:44
>
> Index-pack is reading the pack on stdin, so it's expecting more bytes.
> Those bytes should be coming from the git-clone process, which is
> relaying the bytes from the other side.
>
> Check the backtrace of git-clone to see why it isn't feeding more data
> (but note that it will generally have two threads -- one processing the
> data from the remote, and one wait()ing for index-pack to finish).
>
> My guess, though, is that you'll find that git-clone is simply waiting
> on another pipe: the one from ssh.

Ok here are backtraces from another run (with SSH multiplexing disabled):

(gdb) thread apply all bt

Thread 2 (Thread 0x7faafbf1c700 (LWP 36586)):
#0  0x00007faafc805384 in __libc_read (fd=3Dfd@entry=3D5,
    buf=3Dbuf@entry=3D0x7faafbf0ddec, nbytes=3Dnbytes@entry=3D5)
    at ../sysdeps/unix/sysv/linux/read.c:27
#1  0x000055c8ca2f5b23 in read (__nbytes=3D5, __buf=3D0x7faafbf0ddec, __fd=
=3D5)
    at /usr/include/x86_64-linux-gnu/bits/unistd.h:44
#2  xread (fd=3Dfd@entry=3D5, buf=3Dbuf@entry=3D0x7faafbf0ddec, len=3Dlen@e=
ntry=3D5)
    at wrapper.c:260
#3  0x000055c8ca2f5cdb in read_in_full (fd=3D5, buf=3Dbuf@entry=3D0x7faafbf=
0bdf0,
    count=3D5, count@entry=3D8193) at wrapper.c:318
#4  0x000055c8ca27222b in get_packet_data (fd=3Dfd@entry=3D5,
    src_buf=3Dsrc_buf@entry=3D0x0, src_size=3Dsrc_size@entry=3D0x0,
    dst=3Ddst@entry=3D0x7faafbf0bdf0, size=3Dsize@entry=3D8193,
    options=3Doptions@entry=3D0) at pkt-line.c:289
#5  0x000055c8ca272ed8 in packet_read_with_status (fd=3Dfd@entry=3D5,
    src_buffer=3Dsrc_buffer@entry=3D0x0, src_len=3Dsrc_len@entry=3D0x0,
    buffer=3Dbuffer@entry=3D0x7faafbf0bdf0
"\001\344\305\066JJj\341q@\243\225=D5=AA\350\026M\fkM9:-=C6=80\253\206\336\=
001\275\070\325\372\250\204\232aM\221\213(\320B%\a\275\233\261g\321A\245\n
\247\374\326\b'\v\252\277rA\211\312l\212j\352\177\260\317j\aT\252&t2\256\25=
4\360\002\217V\024\061k\201=DA=B2;;\017`\361\020:*b\n5\222\036i\272\067}\36=
0,\323\345Y\314ir\311\034b\232F\267\364\016]",
size=3Dsize@entry=3D65520,
    pktlen=3Dpktlen@entry=3D0x7faafbf0bd94, options=3D0) at pkt-line.c:344
#6  0x000055c8ca273078 in packet_read (fd=3Dfd@entry=3D5,
    src_buffer=3Dsrc_buffer@entry=3D0x0, src_len=3Dsrc_len@entry=3D0x0,
    buffer=3Dbuffer@entry=3D0x7faafbf0bdf0
"\001\344\305\066JJj\341q@\243\225=D5=AA\350\026M\fkM9:-=C6=80\253\206\336\=
001\275\070\325\372\250\204\232aM\221\213(\320B%\a\275\233\261g\321A\245\n
\247\374\326\b'\v\252\277rA\211\312l\212j\352\177\260\317j\aT\252&t2\256\25=
4\360\002\217V\024\061k\201=DA=B2;;\017`\361\020:*b\n5\222\036i\272\067}\36=
0,\323\345Y\314ir\311\034b\232F\267\364\016]",
size=3Dsize@entry=3D65520,
    options=3Doptions@entry=3D0) at pkt-line.c:364
#7  0x000055c8ca2cbf73 in recv_sideband (
    me=3Dme@entry=3D0x55c8ca3466ed "fetch-pack", in_stream=3D5, out=3Dout@e=
ntry=3D6)
    at sideband.c:143
#8  0x000055c8ca22d6cb in sideband_demux (in=3D<optimised out>, out=3D6,
    data=3D<optimised out>) at fetch-pack.c:776
#9  0x000055c8ca2a8458 in run_thread (data=3D0x7ffda489ef90)
    at run-command.c:1032
#10 0x00007faafc7fb6db in start_thread (arg=3D0x7faafbf1c700)
    at pthread_create.c:463
#11 0x00007faafc31c88f in clone ()
    at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 1 (Thread 0x7faafce3bb80 (LWP 36584)):
#0  0x00007faafc805384 in __libc_read (fd=3Dfd@entry=3D7,
    buf=3Dbuf@entry=3D0x7ffda489ef10, nbytes=3Dnbytes@entry=3D46)
    at ../sysdeps/unix/sysv/linux/read.c:27
#1  0x000055c8ca2f5b23 in read (__nbytes=3D46, __buf=3D0x7ffda489ef10, __fd=
=3D7)
    at /usr/include/x86_64-linux-gnu/bits/unistd.h:44
#2  xread (fd=3Dfd@entry=3D7, buf=3Dbuf@entry=3D0x7ffda489ef10, len=3Dlen@e=
ntry=3D46)
    at wrapper.c:260
#3  0x000055c8ca2f5cdb in read_in_full (fd=3D7, buf=3Dbuf@entry=3D0x7ffda48=
9ef10,
    count=3Dcount@entry=3D46) at wrapper.c:318
#4  0x000055c8ca26a54f in index_pack_lockfile (ip_out=3D<optimised out>)
    at pack-write.c:297
#5  0x000055c8ca22e18c in get_pack (args=3Dargs@entry=3D0x7ffda489f2e0,
    xd=3Dxd@entry=3D0x55c8cb4966f8,
    pack_lockfile=3Dpack_lockfile@entry=3D0x55c8cb496660) at fetch-pack.c:8=
81
#6  0x000055c8ca22fbfb in do_fetch_pack (pack_lockfile=3D<optimised out>,
    si=3D0x7ffda489f1f0, nr_sought=3D<optimised out>, sought=3D<optimised o=
ut>,
    orig_ref=3D<optimised out>, fd=3D<optimised out>, args=3D0x7ffda489f2e0=
)
    at fetch-pack.c:1019
#7  fetch_pack (args=3Dargs@entry=3D0x7ffda489f2e0, fd=3D<optimised out>,
    conn=3D<optimised out>, ref=3D<optimised out>,
    dest=3Ddest@entry=3D0x55c8cb498820
"remotehost:diffusion/LIBEDIT/libedit",
sought=3Dsought@entry=3D0x55c8cb498580,
    nr_sought=3D<optimised out>, shallow=3D<optimised out>,
    pack_lockfile=3D<optimised out>, version=3D<optimised out>)
    at fetch-pack.c:1649
#8  0x000055c8ca2dddf8 in fetch_refs_via_pack (transport=3D0x55c8cb496620,
    nr_heads=3D2, to_fetch=3D0x55c8cb498580) at transport.c:365
#9  0x000055c8ca2df246 in transport_fetch_refs (
    transport=3Dtransport@entry=3D0x55c8cb496620, refs=3Drefs@entry=3D0x55c=
8cb4959e0)
    at transport.c:1295
#10 0x000055c8ca1529ab in cmd_clone (argc=3D<optimised out>,
    argv=3D<optimised out>, prefix=3D<optimised out>) at builtin/clone.c:12=
12
#11 0x000055c8ca1374e1 in run_builtin (argv=3D<optimised out>,
    argc=3D<optimised out>, p=3D<optimised out>) at git.c:421
#12 handle_builtin (argc=3D<optimised out>, argv=3D<optimised out>) at git.=
c:647
#13 0x000055c8ca138515 in run_argv (argv=3D0x7ffda489fa00, argcp=3D0x7ffda4=
89fa0c)
    at git.c:701
#14 cmd_main (argc=3D<optimised out>, argv=3D<optimised out>) at git.c:798
#15 0x000055c8ca13718f in main (argc=3D4, argv=3D0x7ffda489fc78)
    at common-main.c:45

(gdb) thread apply all bt

Thread 1 (Thread 0x7ff8a03dab80 (LWP 36587)):
#0  0x00007ff89fda434e in __libc_read (fd=3Dfd@entry=3D0,
    buf=3Dbuf@entry=3D0x5604bea43d40 <input_buffer>, nbytes=3Dnbytes@entry=
=3D4096)
    at ../sysdeps/unix/sysv/linux/read.c:27
#1  0x00005604be77bb23 in read (__nbytes=3D4096,
    __buf=3D0x5604bea43d40 <input_buffer>, __fd=3D0)
    at /usr/include/x86_64-linux-gnu/bits/unistd.h:44
#2  xread (fd=3D0, buf=3D0x5604bea43d40 <input_buffer>, len=3D4096) at wrap=
per.c:260
#3  0x00005604be5fb069 in fill (min=3Dmin@entry=3D1) at builtin/index-pack.=
c:255
#4  0x00005604be5fb23a in unpack_entry_data (offset=3D528312,
    size=3Dsize@entry=3D19448, type=3D<optimised out>, oid=3Doid@entry=3D0x=
5604c0605ea0)
    at builtin/index-pack.c:445
#5  0x00005604be5fbbc7 in unpack_raw_entry (oid=3D0x5604c0605ea0,
    ref_oid=3D0x7ffc74cd73f0, ofs_offset=3D0x5604c0603580, obj=3D0x5604c060=
5ea0)
    at builtin/index-pack.c:526
#6  parse_pack_objects (hash=3D0x7ffc74cd74a0 "\001")
    at builtin/index-pack.c:1113
#7  cmd_index_pack (argc=3D<optimised out>, argv=3D<optimised out>,
    prefix=3D<optimised out>) at builtin/index-pack.c:1775
#8  0x00005604be5bd4e1 in run_builtin (argv=3D<optimised out>,
    argc=3D<optimised out>, p=3D<optimised out>) at git.c:421
#9  handle_builtin (argc=3D<optimised out>, argv=3D<optimised out>) at git.=
c:647
#10 0x00005604be5be515 in run_argv (argv=3D0x7ffc74cd7640, argcp=3D0x7ffc74=
cd764c)
    at git.c:701
#11 cmd_main (argc=3D<optimised out>, argv=3D<optimised out>) at git.c:798
#12 0x00005604be5bd18f in main (argc=3D7, argv=3D0x7ffc74cd78b8)
    at common-main.c:45

As before, any hints on how to debug this gratefully accepted!

--=20
Sitsofe | http://sucs.org/~sits/
