From: "Rado Dr." <radodr@gmail.com>
Subject: Re: git status & seg.fault
Date: Tue, 26 Oct 2010 11:54:48 +0200
Message-ID: <AANLkTi=7ZHmN5NU4RGY+xH2=w=5B-0JDbniwn03zCfcO@mail.gmail.com>
References: <AANLkTinymMtDKt1V9xb+adJiSoOKT8YSy1qHuHc_=yVq@mail.gmail.com>
	<AANLkTinghepgdMRjEBhpAMz-Mr0g7szKyYEDfE=ttstS@mail.gmail.com>
	<AANLkTikhU+hBwsh24JYGmwHoNFGMseAx_+rUMYH4XGkT@mail.gmail.com>
	<AANLkTimRBmJkXh9LjgL51bwFD=AGBJRc2d1R0g=z0v2t@mail.gmail.com>
	<AANLkTinpUKP8XaLR6d530BW8DuFqUzettuivin88xwuE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 26 11:55:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAgF6-00049y-4L
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 11:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758450Ab0JZJyu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Oct 2010 05:54:50 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47793 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188Ab0JZJyt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Oct 2010 05:54:49 -0400
Received: by yxn35 with SMTP id 35so2718295yxn.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OBU0IB8JCjOZKCbY174QvGz746IXI/PHIzVbgl0hfqE=;
        b=X+OrSZDR9kZ8enDZGvsw43S9B1MK80ip6T42pB6RZNJ8L2Tp1Vx+BtTqZ8Mr0DOHdu
         v8YozCGPyASwZIDLmcwvanYu0psVuC7X0gJd48hwdbz+eWtlEC2IhbGwvFezhKdHFz8I
         FPMYT8HvVEIH/zxsWqgYUprXaHdP8mPT1Aojw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Wx23w1cl5qG2aR+coTbc8RndZtdUZS4iSEftWvmDMbS+HFJHHIQNLpZa9wTLpKgIQ1
         bixc4kE10Uu0GSqw+2/IZu0rTKwKfAyMIdoCa0qWizTJLOfFEO6FOFXzTrRkWPsakXC4
         fEGIS9uGnD/RUJe/Av5EWBdKqbvq5P+dzaEZo=
Received: by 10.151.43.16 with SMTP id v16mr1707862ybj.228.1288086888951; Tue,
 26 Oct 2010 02:54:48 -0700 (PDT)
Received: by 10.151.49.3 with HTTP; Tue, 26 Oct 2010 02:54:48 -0700 (PDT)
In-Reply-To: <AANLkTinpUKP8XaLR6d530BW8DuFqUzettuivin88xwuE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159987>

Here we are:

(gdb) run
Starting program: /usr/local/bin/git status
[Thread debugging using libthread_db enabled]

Program received signal SIGSEGV, Segmentation fault.
0x080ed94d in hash_name (name=3D0xb7c09000 <Address 0xb7c09000 out of
bounds>, namelen=3D-33580) at name-hash.c:28
28			unsigned char c =3D *name++;
(gdb) bt full
#0  0x080ed94d in hash_name (name=3D0xb7c09000 <Address 0xb7c09000 out
of bounds>, namelen=3D-33580) at name-hash.c:28
        c =3D 0 '\000'
        hash =3D 3198509075
#1  0x080ed9d5 in hash_index_entry (istate=3D0x81b5600, ce=3D0xb7c00c90=
)
at name-hash.c:44
        pos =3D 0x0
        hash =3D 1031650602
#2  0x080eda52 in lazy_init_name_hash (istate=3D0x81b5600) at name-hash=
=2Ec:59
        nr =3D 16272
#3  0x080edbe3 in index_name_exists (istate=3D0x81b5600, name=3D0xbfffb=
36b
"src/FotoPlusServer/build.xml", namelen=3D28, icase=3D0) at
name-hash.c:108
        hash =3D 842511099
        ce =3D 0xbfffb358
#4  0x080dbea1 in dir_add_name (dir=3D0xbfffe4f4, pathname=3D0xbfffb36b
"src/FotoPlusServer/build.xml", len=3D28) at dir.c:449
No locals.
#5  0x080dc916 in read_directory_recursive (dir=3D0xbfffe4f4,
base=3D0xbfffc3cb "src/FotoPlusServer/", baselen=3D19, check_only=3D0,
simplify=3D0x0) at dir.c:809
        len =3D 28
        de =3D 0x84a9bf0
        path =3D "src/FotoPlusServer/build.xml", '\000' <repeats 481
times>, "s\232\352\267Q\275\377\277\250\316\377\277\026\000\000\000\\\2=
73\377\277\v\000\000\000\360\273\377\277\v\000\000\000\364_\371\267\\\2=
73\377\277\360\273\377\277(\273\377\277\036\315\347\267\\\273\377\277Z\=
031\026\b\v",
'\000' <repeats 91 times>"\377, \377\377\377", '\000' <repeats 28
times>, " ", '\000' <repeats 31 times>"\200,
\272\377\277\000\000\000\000v\373\377\377", '\000' <repeats 16
times>"\352, \377\377\377\000\000\000\000\000\000\000\000\202\357\347\2=
67\000\000\000\000j\031\026\b\340V\371\267j\031\026\b\360\273\377\277\0=
02\000\000\000e\031\026\b\000\000\000\000\204\274\377\277Z\031\026\b\v"=
,
'\000' <repeats 963 times>,
"s\232\352\267A\302\377\277\230\323\377\277\026\000\000\000L\300\377\27=
7\v\000\000\000\340\300\377\277\v\000\000\000\364_\371\267L\300\377\277=
\340\300\377\277\030\300\377\277\036\315\347\267L\300\377\277Z\031\026\=
b\v",
'\000' <repeats 91 times>"\377,
\377\377\377\000\000\000\000\000\000\000\000\364"...
        fdir =3D 0x84a9bd8
        contents =3D 1
#6  0x080dc8df in read_directory_recursive (dir=3D0xbfffe4f4,
base=3D0xbfffd42b "src/", baselen=3D4, check_only=3D0, simplify=3D0x0) =
at
dir.c:797
        len =3D 19
        de =3D 0x8435168
        path =3D "src/FotoPlusServer/", '\000' <repeats 874 times>,
"s\232\352\267", '\000' <repeats 16 times>,
"\005\000\000\000\320\315\377\277\005\000\000\000\364_\371\267<\315\377=
\277;\032\026\b\b\315\377\277\"\322\347\267<\315\377\277\066\032\026\b\=
005",
'\000' <repeats 23 times>, "\005", '\000' <repeats 67 times>"\377,
\377\377\377", '\000' <repeats 28 times>, " ", '\000' <repeats 31
times>, "`\314\377\277\000\000\000\000v\373\377\377\000\000\000\000\065=
\032\026\b\000\000\000\000\000\000\000\000\374\377\377\377\000\000\000\=
000\000\000\000\000\202\357\347\267\000\000\000\000\066\032\026\b\340V\=
371\267;\032\026\b\320\315\377\277\002\000\000\000\062\032\026\b\000\00=
0\000\000t\316\377\277%\032\026\b\026",
'\000' <repeats 395 times>, "q\a\347\267", '\000' <repeats 40
times>"\377, \377\377\377\000\000\000\000\005\000\000\000\240\312\377\2=
77",
'\000' <repeats 12 times>"\231"...
        fdir =3D 0x8435150
        contents =3D 0
#7  0x080dc8df in read_directory_recursive (dir=3D0xbfffe4f4,
base=3D0x815dbde "", baselen=3D0, check_only=3D0, simplify=3D0x0) at di=
r.c:797
        len =3D 4
        de =3D 0x842d148
        path =3D "src/\000vl\276\267I\000\000\000\000\200\000\000=DC=BB=
2\b\307E\353\267\000\000\000\000\244\327\377\277\022\322\017\b~l\276\26=
7\267\314A\b\a\000\000\000\000\000\000\000vl\276\267\000\000\000\000\a\=
000\000\000[\000//dk\276\267\026\000\000\000\310\324\377\277\224\237\02=
2\b~l\276\267A\000\000\000\000\200\000\000\267\314A\b\307E\353\267\000\=
000\000\000\244\327\377\277\022\322\017\b\206l\276\267~GD\b\a\000\000\0=
00\000\000\000\000~l\276\267\000\000\000\000\a\000\000\000[\000//\001\0=
00\000\000\000\000\000\000\030\325\377\277\224\237\022\b\206l\276\267\0=
71\000\000\000\000\200\000\000~GD\b\307E\353\267\000\000\000\000\244\32=
7\377\277\022\322\017\b\216l\276\267\024\362D\b\b\000\000\000\000\000\0=
00\000\206l\276\267\000\000\000\000\b\000\000\000[\000//#\227\067\b\270=
\325\377\277h\325\377\277\224\237\022\b\216l\276\267\061\000\000\000\00=
0\200\000\000\024\362D\b\307E\353\267\000\000\000\000\244\327\377\277\0=
22\322\017\b\227l\276\267d\t%\b\b\000\000\000\000\000\000\000\216l\276"=
=2E..
        fdir =3D 0x842d130
        contents =3D 0
#8  0x080dcd3b in read_directory (dir=3D0xbfffe4f4, path=3D0x815dbde ""=
,
len=3D0, pathspec=3D0x0) at dir.c:916
        simplify =3D 0x0
#9  0x080db157 in fill_directory (dir=3D0xbfffe4f4, pathspec=3D0x0) at =
dir.c:70
        path =3D 0x815dbde ""
          basebuf =3D "src/FotoPlusServer/\000gitignore", '\000'
<repeats 4066 times>}
#11 0x081307a2 in wt_status_collect (s=3D0xbffff5a8) at wt-status.c:423
No locals.
#12 0x0806632d in cmd_status (argc=3D0, argv=3D0xbffff968, prefix=3D0x0=
) at
builtin/commit.c:1104
        s =3D {is_initial =3D 0, branch =3D 0x81b62a0
"refs/heads/uploadFiles", reference =3D 0x8167a22 "HEAD", pathspec =3D
0x0, verbose =3D 0, amend =3D 0, in_merge =3D 0, nowarn =3D 0, use_colo=
r =3D -1,
          relative_paths =3D 1, submodule_summary =3D 0,
show_ignored_files =3D 0, show_untracked_files =3D
SHOW_NORMAL_UNTRACKED_FILES, ignore_submodule_arg =3D 0x0, color_palett=
e
=3D {'\000' <repeats 39 times>,
            "\033[33m", '\000' <repeats 34 times>, "\033[32m", '\000'
<repeats 34 times>, "\033[36m", '\000' <repeats 34 times>, "\033[31m",
'\000' <repeats 34 times>,
            "\033[31m", '\000' <repeats 34 times>, "\033[32m", '\000'
<repeats 34 times>, "\033[31m", '\000' <repeats 34 times>}, commitable
=3D 0, workdir_dirty =3D 1,
          index_file =3D 0x81b61a0 ".git/index", fp =3D 0xb7f964e0, pre=
fix
=3D 0x0, change =3D {items =3D 0x8498228, nr =3D 430, alloc =3D 448,
strdup_strings =3D 1}, untracked =3D {items =3D 0x0, nr =3D 0, alloc =3D=
 0,
            strdup_strings =3D 1}, ignored =3D {items =3D 0x0, nr =3D 0=
, alloc
=3D 0, strdup_strings =3D 1}}
        fd =3D 5
        sha1 =3D "j\201\033YO;}d\323\v\313\062\372\205\264{A\353Hh"
        builtin_status_options =3D {{type =3D OPTION_BOOLEAN, short_nam=
e =3D
118, long_name =3D 0x8145c5d "verbose", value =3D 0x8179434, argh =3D 0=
x0,
help =3D 0x8145c65 "be verbose", flags =3D 2, callback =3D 0,
            defval =3D 0}, {type =3D OPTION_SET_INT, short_name =3D 115=
,
long_name =3D 0x8145f97 "short", value =3D 0x8179484, argh =3D 0x0, hel=
p =3D
0x8145f9d "show status concisely", flags =3D 2, callback =3D 0,
            defval =3D 1}, {type =3D OPTION_BOOLEAN, short_name =3D 98,
long_name =3D 0x8145fb3 "branch", value =3D 0x8179488, argh =3D 0x0, he=
lp =3D
0x8145fba "show branch information", flags =3D 2, callback =3D 0,
            defval =3D 0}, {type =3D OPTION_SET_INT, short_name =3D 0,
long_name =3D 0x8145fd2 "porcelain", value =3D 0x8179484, argh =3D 0x0,=
 help
=3D 0x8145fdc "show porcelain output format", flags =3D 2,
            callback =3D 0, defval =3D 2}, {type =3D OPTION_BOOLEAN,
short_name =3D 122, long_name =3D 0x8145ff9 "null", value =3D 0x8179480=
,
argh =3D 0x0, help =3D 0x8145ffe "terminate entries with NUL", flags =3D=
 2,
            callback =3D 0, defval =3D 0}, {type =3D OPTION_STRING,
short_name =3D 117, long_name =3D 0x814605e "untracked-files", value =3D
0x8179450, argh =3D 0x814606e "mode",
            help =3D 0x8146d78 "show untracked files, optional modes:
all, normal, no. (Default: all)", flags =3D 1, callback =3D 0, defval =3D
135552702}, {type =3D OPTION_BOOLEAN, short_name =3D 0,
            long_name =3D 0x8146dbe "ignored", value =3D 0x817946c, arg=
h =3D
0x0, help =3D 0x8146dc6 "show ignored files", flags =3D 2, callback =3D=
 0,
defval =3D 0}, {type =3D OPTION_STRING, short_name =3D 0,
            long_name =3D 0x8146dd9 "ignore-submodules", value =3D
0x8179458, argh =3D 0x8146deb "when",
            help =3D 0x8146df0 "ignore changes to submodules, optional
when: all, dirty, untracked. (Default: all)", flags =3D 1, callback =3D=
 0,
defval =3D 135552702}, {type =3D OPTION_END, short_name =3D 0,
            long_name =3D 0x0, value =3D 0x0, argh =3D 0x0, help =3D 0x=
0,
flags =3D 0, callback =3D 0, defval =3D 0}}
#13 0x0804bbb4 in run_builtin (p=3D0x816a760, argc=3D1, argv=3D0xbffff9=
68)
at git.c:275
        status =3D -1209323120
        help =3D 0
        st =3D {st_dev =3D 7165064483209180463, __pad1 =3D 50624, __st_=
ino =3D
3086589952, st_mode =3D 1920169263, st_nlink =3D 4294967295, st_uid =3D
3087003636, st_gid =3D 134519560, st_rdev =3D 13258579662338732358,
          __pad2 =3D 1699, st_size =3D -5189937631567283536, st_blksize=
 =3D
1, st_blocks =3D 1, st_atim =3D {tv_sec =3D 1, tv_nsec =3D 134517876}, =
st_mtim
=3D {tv_sec =3D 135701220, tv_nsec =3D 0}, st_ctim =3D {
            tv_sec =3D -1209743936, tv_nsec =3D -1208393740}, st_ino =3D=
 0}
        prefix =3D 0x0
#14 0x0804bd12 in handle_internal_command (argc=3D1, argv=3D0xbffff968)=
 at git.c:431
        p =3D 0x816a760
        cmd =3D 0xbffffae4 "status"
        commands =3D {{cmd =3D 0x8140240 "add", fn =3D 0x804cc5c <cmd_a=
dd>,
option =3D 9}, {cmd =3D 0x8140244 "stage", fn =3D 0x804cc5c <cmd_add>,
option =3D 9}, {cmd =3D 0x814024a "annotate",
            fn =3D 0x804d210 <cmd_annotate>, option =3D 1}, {cmd =3D
0x8140253 "apply", fn =3D 0x805501a <cmd_apply>, option =3D 2}, {cmd =3D
0x8140259 "archive", fn =3D 0x8055cc9 <cmd_archive>, option =3D 0}, {
            cmd =3D 0x8140261 "bisect--helper", fn =3D 0x8055ea4
<cmd_bisect__helper>, option =3D 9}, {cmd =3D 0x8140270 "blame", fn =3D
0x805a3d8 <cmd_blame>, option =3D 1}, {cmd =3D 0x8140276 "branch",
            fn =3D 0x805c4d1 <cmd_branch>, option =3D 1}, {cmd =3D 0x81=
4027d
"bundle", fn =3D 0x805cc64 <cmd_bundle>, option =3D 2}, {cmd =3D 0x8140=
284
"cat-file", fn =3D 0x805d798 <cmd_cat_file>, option =3D 1}, {
            cmd =3D 0x814028d "checkout", fn =3D 0x8060b0d <cmd_checkou=
t>,
option =3D 9}, {cmd =3D 0x8140296 "checkout-index", fn =3D 0x805e849
<cmd_checkout_index>, option =3D 9}, {
            cmd =3D 0x81402a5 "check-ref-format", fn =3D 0x805e06b
<cmd_check_ref_format>, option =3D 0}, {cmd =3D 0x81402b6 "check-attr",=
 fn
=3D 0x805dd3a <cmd_check_attr>, option =3D 1}, {
            cmd =3D 0x81402c1 "cherry", fn =3D 0x80830c9 <cmd_cherry>,
option =3D 1}, {cmd =3D 0x81402c8 "cherry-pick", fn =3D 0x80a96f2
<cmd_cherry_pick>, option =3D 9}, {cmd =3D 0x81402d4 "clone",
            fn =3D 0x8062aa5 <cmd_clone>, option =3D 0}, {cmd =3D 0x814=
02da
"clean", fn =3D 0x80616a4 <cmd_clean>, option =3D 9}, {cmd =3D 0x81402e=
0
"commit", fn =3D 0x80669b5 <cmd_commit>, option =3D 9}, {
            cmd =3D 0x81402e7 "commit-tree", fn =3D 0x80637c4
<cmd_commit_tree>, option =3D 1}, {cmd =3D 0x81402f3 "config", fn =3D
0x8067d09 <cmd_config>, option =3D 2}, {cmd =3D 0x81402fa "count-object=
s",
            fn =3D 0x80688b2 <cmd_count_objects>, option =3D 1}, {cmd =3D
0x8140308 "describe", fn =3D 0x80699da <cmd_describe>, option =3D 1}, {=
cmd
=3D 0x8140311 "diff", fn =3D 0x806b3ab <cmd_diff>, option =3D 0}, {
            cmd =3D 0x8140316 "diff-files", fn =3D 0x8069ed4
<cmd_diff_files>, option =3D 9}, {cmd =3D 0x8140321 "diff-index", fn =3D
0x806a170 <cmd_diff_index>, option =3D 1}, {cmd =3D 0x814032c "diff-tre=
e",
            fn =3D 0x806a735 <cmd_diff_tree>, option =3D 1}, {cmd =3D
0x8140336 "fast-export", fn =3D 0x806d187 <cmd_fast_export>, option =3D
1}, {cmd =3D 0x8140342 "fetch", fn =3D 0x8071ee4 <cmd_fetch>,
            option =3D 1}, {cmd =3D 0x8140348 "fetch-pack", fn =3D 0x80=
6f4e8
<cmd_fetch_pack>, option =3D 1}, {cmd =3D 0x8140353 "fmt-merge-msg", fn=
 =3D
0x8072f63 <cmd_fmt_merge_msg>, option =3D 1}, {
            cmd =3D 0x8140361 "for-each-ref", fn =3D 0x8075280
<cmd_for_each_ref>, option =3D 1}, {cmd =3D 0x814036e "format-patch", f=
n =3D
0x8081df4 <cmd_format_patch>, option =3D 1}, {cmd =3D 0x814037b "fsck",
            fn =3D 0x8076899 <cmd_fsck>, option =3D 1}, {cmd =3D 0x8140=
380
"fsck-objects", fn =3D 0x8076899 <cmd_fsck>, option =3D 1}, {cmd =3D
0x814038d "gc", fn =3D 0x807711f <cmd_gc>, option =3D 1}, {
            cmd =3D 0x8140390 "get-tar-commit-id", fn =3D 0x80b0e11
<cmd_get_tar_commit_id>, option =3D 0}, {cmd =3D 0x81403a2 "grep", fn =3D
0x80790a3 <cmd_grep>, option =3D 2}, {cmd =3D 0x81403a7 "hash-object",
            fn =3D 0x807a6ce <cmd_hash_object>, option =3D 0}, {cmd =3D
0x814018c "help", fn =3D 0x807b78f <cmd_help>, option =3D 0}, {cmd =3D
0x81403b3 "index-pack", fn =3D 0x807db0d <cmd_index_pack>, option =3D 2=
},
          {cmd =3D 0x81403be "init", fn =3D 0x807f55a <cmd_init_db>,
option =3D 0}, {cmd =3D 0x81403c3 "init-db", fn =3D 0x807f55a <cmd_init=
_db>,
option =3D 0}, {cmd =3D 0x81403cb "log", fn =3D 0x8080ce2 <cmd_log>,
            option =3D 1}, {cmd =3D 0x81403cf "ls-files", fn =3D 0x8084=
6ce
<cmd_ls_files>, option =3D 1}, {cmd =3D 0x81403d8 "ls-tree", fn =3D
0x80857c5 <cmd_ls_tree>, option =3D 1}, {cmd =3D 0x81403e0 "ls-remote",
            fn =3D 0x80850df <cmd_ls_remote>, option =3D 2}, {cmd =3D
0x81403ea "mailinfo", fn =3D 0x8087f61 <cmd_mailinfo>, option =3D 0}, {=
cmd
=3D 0x81403f3 "mailsplit", fn =3D 0x8088b19 <cmd_mailsplit>,

            option =3D 0}, {cmd =3D 0x81403fd "merge", fn =3D 0x808b8cb
<cmd_merge>, option =3D 9}, {cmd =3D 0x8140403 "merge-base", fn =3D
0x808ca8d <cmd_merge_base>, option =3D 1}, {cmd =3D 0x814040e
"merge-file",
            fn =3D 0x808ccc0 <cmd_merge_file>, option =3D 2}, {cmd =3D
0x8140419 "merge-index", fn =3D 0x808d48f <cmd_merge_index>, option =3D
1}, {cmd =3D 0x8140425 "merge-ours", fn =3D 0x808d5f4 <cmd_merge_ours>,
            option =3D 1}, {cmd =3D 0x8140430 "merge-recursive", fn =3D
0x808d6b6 <cmd_merge_recursive>, option =3D 9}, {cmd =3D 0x8140440
"merge-recursive-ours", fn =3D 0x808d6b6 <cmd_merge_recursive>,
            option =3D 9}, {cmd =3D 0x8140455 "merge-recursive-theirs",=
 fn
=3D 0x808d6b6 <cmd_merge_recursive>, option =3D 9}, {cmd =3D 0x814046c
"merge-subtree", fn =3D 0x808d6b6 <cmd_merge_recursive>,
            option =3D 9}, {cmd =3D 0x814047a "merge-tree", fn =3D 0x80=
8e43a
<cmd_merge_tree>, option =3D 1}, {cmd =3D 0x8140485 "mktag", fn =3D
0x808e9f9 <cmd_mktag>, option =3D 1}, {cmd =3D 0x814048b "mktree",
            fn =3D 0x808f046 <cmd_mktree>, option =3D 1}, {cmd =3D 0x81=
40492
"mv", fn =3D 0x808f3e4 <cmd_mv>, option =3D 9}, {cmd =3D 0x8140495
"name-rev", fn =3D 0x809040f <cmd_name_rev>, option =3D 1}, {
            cmd =3D 0x814049e "notes", fn =3D 0x8092d45 <cmd_notes>,
option =3D 1}, {cmd =3D 0x81404a4 "pack-objects", fn =3D 0x809779e
<cmd_pack_objects>, option =3D 1}, {cmd =3D 0x81404b1 "pack-redundant",
            fn =3D 0x8099044 <cmd_pack_redundant>, option =3D 1}, {cmd =
=3D
0x81404c0 "patch-id", fn =3D 0x8099aa7 <cmd_patch_id>, option =3D 0}, {=
cmd
=3D 0x81404c9 "peek-remote", fn =3D 0x80850df <cmd_ls_remote>,
            option =3D 2}, {cmd =3D 0x81404d5 "pickaxe", fn =3D 0x805a3=
d8
<cmd_blame>, option =3D 1}, {cmd =3D 0x81404dd "prune", fn =3D 0x809a2d=
9
<cmd_prune>, option =3D 1}, {cmd =3D 0x81404e3 "prune-packed",
            fn =3D 0x8099d63 <cmd_prune_packed>, option =3D 1}, {cmd =3D
0x81404f0 "push", fn =3D 0x809ac29 <cmd_push>, option =3D 1}, {cmd =3D
0x81404f5 "read-tree", fn =3D 0x809b2e0 <cmd_read_tree>, option =3D 1},=
 {
            cmd =3D 0x81404ff "receive-pack", fn =3D 0x809d6a6
<cmd_receive_pack>, option =3D 0}, {cmd =3D 0x814050c "reflog", fn =3D
0x809f614 <cmd_reflog>, option =3D 1}, {cmd =3D 0x8140513 "remote",
            fn =3D 0x80a3710 <cmd_remote>, option =3D 1}, {cmd =3D 0x81=
4051a
"replace", fn =3D 0x80a3d9e <cmd_replace>, option =3D 1}, {cmd =3D 0x81=
40522
"repo-config", fn =3D 0x8067d09 <cmd_config>, option =3D 2}, {
            cmd =3D 0x814052e "rerere", fn =3D 0x80a442a <cmd_rerere>,
option =3D 1}, {cmd =3D 0x8140535 "reset", fn =3D 0x80a4f5e <cmd_reset>=
,
option =3D 1}, {cmd =3D 0x814053b "rev-list",
            fn =3D 0x80a60c1 <cmd_rev_list>, option =3D 1}, {cmd =3D
0x8140544 "rev-parse", fn =3D 0x80a744a <cmd_rev_parse>, option =3D 0},
{cmd =3D 0x814054e "revert", fn =3D 0x80a96b4 <cmd_revert>, option =3D =
9}, {
            cmd =3D 0x8140555 "rm", fn =3D 0x80a9ae5 <cmd_rm>, option =3D
1}, {cmd =3D 0x8140558 "send-pack", fn =3D 0x80aac7e <cmd_send_pack>,
option =3D 1}, {cmd =3D 0x8140562 "shortlog",
            fn =3D 0x80abe10 <cmd_shortlog>, option =3D 6}, {cmd =3D
0x814056b "show-branch", fn =3D 0x80ad6ae <cmd_show_branch>, option =3D
1}, {cmd =3D 0x8140577 "show", fn =3D 0x80806fa <cmd_show>, option =3D =
1}, {
            cmd =3D 0x814057c "status", fn =3D 0x8066142 <cmd_status>,
option =3D 9}, {cmd =3D 0x8140583 "stripspace", fn =3D 0x80af2f3
<cmd_stripspace>, option =3D 0}, {cmd =3D 0x814058e "symbolic-ref",
            fn =3D 0x80af479 <cmd_symbolic_ref>, option =3D 1}, {cmd =3D
0x814059b "tag", fn =3D 0x80b0330 <cmd_tag>, option =3D 1}, {cmd =3D
0x814059f "tar-tree", fn =3D 0x80b0c44 <cmd_tar_tree>, option =3D 0}, {
            cmd =3D 0x81405a8 "unpack-file", fn =3D 0x80b1018
<cmd_unpack_file>, option =3D 1}, {cmd =3D 0x81405b4 "unpack-objects", =
fn
=3D 0x80b2366 <cmd_unpack_objects>, option =3D 1}, {
            cmd =3D 0x81405c3 "update-index", fn =3D 0x80b3c1b
<cmd_update_index>, option =3D 1}, {cmd =3D 0x81405d0 "update-ref", fn =
=3D
0x80b45af <cmd_update_ref>, option =3D 1}, {
            cmd =3D 0x81405db "update-server-info", fn =3D 0x80b4894
<cmd_update_server_info>, option =3D 1}, {cmd =3D 0x81405ee
"upload-archive", fn =3D 0x80b4d42 <cmd_upload_archive>, option =3D 0},=
 {
            cmd =3D 0x81405fd "var", fn =3D 0x80b513a <cmd_var>, option=
 =3D
2}, {cmd =3D 0x8140601 "verify-tag", fn =3D 0x80b5cc0 <cmd_verify_tag>,
option =3D 1}, {cmd =3D 0x814060c "version",
            fn =3D 0x80e475f <cmd_version>, option =3D 0}, {cmd =3D
0x8140614 "whatchanged", fn =3D 0x808037e <cmd_whatchanged>, option =3D
1}, {cmd =3D 0x8140620 "write-tree", fn =3D 0x80b5dcc <cmd_write_tree>,
            option =3D 1}, {cmd =3D 0x814062b "verify-pack", fn =3D
0x80b57ac <cmd_verify_pack>, option =3D 0}, {cmd =3D 0x8140637 "show-re=
f",
fn =3D 0x80aeeda <cmd_show_ref>, option =3D 1}, {
            cmd =3D 0x8140640 "pack-refs", fn =3D 0x8099468
<cmd_pack_refs>, option =3D 1}}
        i =3D 88
        ext =3D ""
#15 0x0804bdee in run_argv (argcp=3D0xbffff8c0, argv=3D0xbffff8c4) at g=
it.c:475
        done_alias =3D 0
#16 0x0804bf60 in main (argc=3D1, argv=3D0xbffff968) at git.c:548
        done_help =3D 0
        was_alias =3D 0
        cmd =3D 0xbffffae4 "status"
(gdb)



2010/10/26 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>:
> On Tue, Oct 26, 2010 at 11:45, Rado Dr. <radodr@gmail.com> wrote:
>> there is output:
>> Reading symbols from /usr/local/bin/git...done.
>> (gdb) run
>> Starting program: /usr/local/bin/git status
>> [Thread debugging using libthread_db enabled]
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> hash_index_entry (istate=3D<value optimized out>, ce=3D0xb7c00c90) a=
t name-hash.c:44
>> 44 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hash =3D hash_nam=
e(ce->name, ce_namelen(ce));
>> (gdb) bt full
>> #0 =C2=A0hash_index_entry (istate=3D<value optimized out>, ce=3D0xb7=
c00c90) at
>> name-hash.c:44
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0pos =3D <value optimized out>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0hash =3D 3198509075
>> #1 =C2=A00x080dde47 in lazy_init_name_hash (istate=3D0x8194180,
>> name=3D0xbfffb34b "src/FotoPlusServer/build.xml", namelen=3D28, icas=
e=3D0)
>> =C2=A0 =C2=A0at name-hash.c:59
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0nr =3D 16273
>> #2 =C2=A0index_name_exists (istate=3D0x8194180, name=3D0xbfffb34b
>> "src/FotoPlusServer/build.xml", namelen=3D28, icase=3D0) at
>> name-hash.c:108
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0hash =3D <value optimized out>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ce =3D <value optimized out>
>> #3 =C2=A00x080cf190 in dir_add_name (dir=3D<value optimized out>, ba=
se=3D<value
>> optimized out>, baselen=3D<value optimized out>, check_only=3D0,
>> =C2=A0 =C2=A0simplify=3D0x0) at dir.c:449
>> No locals.
>
> I haven't tried to grok all that, but you'd get a better backtrace if
> you compiled git with debug flags, e.g.:
>
> =C2=A0 =C2=A0make CFLAGS=3D"-O0 -ggdb3"
>
> And then did gdb ./git .... Sorry for not mentioning it to begin with=
=2E
>



--=20
Rado Dr.
