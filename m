From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Sun, 29 Aug 2010 07:36:31 +0000
Message-ID: <AANLkTimKQO1MQASvQCz=gpz8FTs3h6FSvm12oFUe7WFD@mail.gmail.com>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
	<AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
	<20100828214641.GA5515@burratino>
	<20100828215956.GB5515@burratino>
	<alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
	<20100828221655.GB5777@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marcin Cieslak <saper@saper.info>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 09:36:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpcRS-0006Dt-0j
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 09:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280Ab0H2Hgc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 03:36:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46779 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab0H2Hgb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 03:36:31 -0400
Received: by iwn5 with SMTP id 5so3915831iwn.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 00:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BRTHVKuPvUqeBtJJekipj3G7kirBse/YMj19w6K947s=;
        b=UliQyFwK4tHVvp78miJbNVW5ofGhfkrpYwJBZOn/l10mNDxtImarxIkjtT9cMBTjWP
         XAImyPxaIUztjNuo0jD974yoSet/l1pgADSXBz5e/7Lu98Gb2DmGfWJmHx6KGdCxjhCH
         o+HuVkLAh1sVxP0M6/yPVbyZPFdtDi1tojpdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wyAGeNHDChvdqZhILDfqFC/mvv3fGL/FrYGV0JP5ceYete4gMCKsjfTXKT+QitMSGZ
         9sBmzLNpprLKq7t6MI7NkiYDxhKQINd4sDfvmRq6PGSkVCBF+dpZE8TYRz2SOd3om36y
         YR+olSLNuNjd1Bow/IcMQJXL0RsuCr4oWs4PE=
Received: by 10.231.30.68 with SMTP id t4mr3481012ibc.129.1283067391209; Sun,
 29 Aug 2010 00:36:31 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 29 Aug 2010 00:36:31 -0700 (PDT)
In-Reply-To: <20100828221655.GB5777@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154683>

On Sat, Aug 28, 2010 at 22:16, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Marcin Cieslak wrote:
>
>> What's wrong?
>
> $ /lib/libc.so.6 =C2=A0|head -1
> GNU C Library (Debian EGLIBC 2.11.2-2) stable release version 2.11.2,=
 by Roland McGrath et al.
> $ cat test.c
> #include <stdio.h>
> #include <locale.h>
>
> int main(void)
> {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int n;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0setlocale(LC_CTYPE, "");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D printf("%.11s\n", "Author: \277");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0perror("printf");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "return value: %d\n", n);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> }
> $ make test
> cc =C2=A0 =C2=A0 test.c =C2=A0 -o test
> $ ./test
> printf: Invalid or incomplete multibyte or wide character
> return value: -1
>
> glibc bug?

It would appear so. It seems my monkeypatch in 107880a was the wrong
way to do it. We should be setting LC_CTYPE, and providing a fallback
for GNU's buggy sprintf().

We also have another bug, compiling git with
SNPRINTF_RETURNS_BOGUS=3DYesGNuIsBuggy and running "git show v0.99.6~1"
on our own repository causes a segfault, presumably due to the same
bug, but I didn't track it down further than this:

    (gdb) run show v0.99.6~1
    Starting program: /home/avar/g/git/git show v0.99.6~1
    [Thread debugging using libthread_db enabled]

    Program received signal SIGSEGV, Segmentation fault.
    __strnlen (str=3D0x8f <Address 0x8f out of bounds>, maxlen=3D<value
optimized out>) at strnlen.c:47
    47      strnlen.c: No such file or directory.
            in strnlen.c
    (gdb) bt
    #0  __strnlen (str=3D0x8f <Address 0x8f out of bounds>,
maxlen=3D<value optimized out>) at strnlen.c:47
    #1  0x00007ffff73318cd in __mbsnrtowcs (dst=3D0x7fffffffb960
L"\xffffb9a0=E7=BF=BF\x404500", src=3D0x7fffffffcf78, nmc=3D8557680, le=
n=3D<value
optimized out>,
        ps=3D0x7fffffffcfb0) at mbsnrtowcs.c:66
    #2  0x00007ffff72ef932 in _IO_vfprintf_internal (s=3D0x7fffffffd010=
,
format=3D<value optimized out>, ap=3D0x7fffffffd330) at vfprintf.c:1614
    #3  0x00007ffff7311432 in _IO_vsnprintf (
        string=3D0x829510
"H\215C\020H\213\\$\bH\213l$\020L\213d$\030L\213l$
L\213t$(L\213|$0H\203\304\070\303f\017\037D: \177", maxlen=3D<value
optimized out>,
        format=3D0x58aa28 "%s: %.*s%.*s\n", args=3D0x7fffffffd330) at
vsnprintf.c:120
    #4  0x00000000005569c6 in git_vsnprintf (
        str=3D0x829510
"H\215C\020H\213\\$\bH\213l$\020L\213d$\030L\213l$
L\213t$(L\213|$0H\203\304\070\303f\017\037D: \177", maxsize=3D572,
        format=3D0x58aa28 "%s: %.*s%.*s\n", ap=3D0x7fffffffd330) at snp=
rintf.c:45
    #5  0x000000000053877f in strbuf_addf (sb=3D0x7fffffffd640,
fmt=3D0x58aa28 "%s: %.*s%.*s\n") at strbuf.c:203
    #6  0x000000000050267d in pp_user_info (what=3D0x58aa4e "Author",
fmt=3DCMIT_FMT_MEDIUM, sb=3D0x7fffffffd640,
        line=3D0x830675 "David_K\345gedal <davidk@lysator.liu.se>
1126078160 +0200\ncommitter Junio C Hamano <junkio@cox.net> 1126128590
-0700\n\n[PATCH] Simplify git script\n\nThe code for listing the
available subcommands was unnec"..., dmode=3DDATE_NORMAL,
encoding=3D0x57025d "UTF-8") at pretty.c:283
    #7  0x0000000000503be9 in pp_header (fmt=3DCMIT_FMT_MEDIUM,
abbrev=3D7, dmode=3DDATE_NORMAL, encoding=3D0x57025d "UTF-8",
commit=3D0x832cf8, msg_p=3D0x7fffffffd558,
        sb=3D0x7fffffffd640) at pretty.c:1077
    #8  0x0000000000503865 in pretty_print_commit
(fmt=3DCMIT_FMT_MEDIUM, commit=3D0x832cf8, sb=3D0x7fffffffd640,
context=3D0x7fffffffd5e8) at pretty.c:1219
    #9  0x00000000004ead8b in show_log (opt=3D0x7fffffffd858) at log-tr=
ee.c:508
    #10 0x00000000004eb1b2 in log_tree_diff_flush (opt=3D0x7fffffffd858=
)
at log-tree.c:557
    #11 0x00000000004eb5e9 in log_tree_diff (opt=3D0x7fffffffd858,
commit=3D0x832cf8, log=3D0x7fffffffd728) at log-tree.c:635
    #12 0x00000000004eb322 in log_tree_commit (opt=3D0x7fffffffd858,
commit=3D0x832cf8) at log-tree.c:658
    #13 0x000000000044ff0b in cmd_log_walk (rev=3D0x7fffffffd858) at lo=
g.c:372
    #14 0x0000000000450555 in cmd_show (argc=3D2, argv=3D0x7fffffffe070=
,
prefix=3D0x0) at log.c:561
    #15 0x00000000004058a7 in run_builtin (p=3D0x7bf708, argc=3D2,
argv=3D0x7fffffffe070) at git.c:278
    #16 0x0000000000404a54 in handle_internal_command (argc=3D2,
argv=3D0x7fffffffe070) at git.c:434
    #17 0x000000000040513e in run_argv (argcp=3D0x7fffffffdf78,
argv=3D0x7fffffffdf70) at git.c:478
    #18 0x0000000000404875 in main (argc=3D2, argv=3D0x7fffffffe070) at=
 git.c:553
    (gdb) frame 4
    #4  0x00000000005569c6 in git_vsnprintf (
        str=3D0x829510
"H\215C\020H\213\\$\bH\213l$\020L\213d$\030L\213l$
L\213t$(L\213|$0H\203\304\070\303f\017\037D: \177", maxsize=3D572,
        format=3D0x58aa28 "%s: %.*s%.*s\n", ap=3D0x7fffffffd330) at snp=
rintf.c:45
    45                      ret =3D vsnprintf(str,
maxsize-SNPRINTF_SIZE_CORR, format, ap);
    (gdb) p str
    $1 =3D 0x829510 "H\215C\020H\213\\$\bH\213l$\020L\213d$\030L\213l$
L\213t$(L\213|$0H\203\304\070\303f\017\037D: \177"
    (gdb) p maxsize
    $2 =3D 572
    (gdb) p SNPRINTF_SIZE_CORR
    No symbol "SNPRINTF_SIZE_CORR" in current context.
    (gdb) p format
    $3 =3D 0x58aa28 "%s: %.*s%.*s\n"
    (gdb) p ap
    $4 =3D (__va_list_tag *) 0x7fffffffd330
    (gdb) frame 6
    #6  0x000000000050267d in pp_user_info (what=3D0x58aa4e "Author",
fmt=3DCMIT_FMT_MEDIUM, sb=3D0x7fffffffd640,
        line=3D0x830675 "David_K\345gedal <davidk@lysator.liu.se>
1126078160 +0200\ncommitter Junio C Hamano <junkio@cox.net> 1126128590
-0700\n\n[PATCH] Simplify git script\n\nThe code for listing the
available subcommands was unnec"..., dmode=3DDATE_NORMAL,
encoding=3D0x57025d "UTF-8") at pretty.c:283
    283                     strbuf_addf(sb, "%s: %.*s%.*s\n", what,
