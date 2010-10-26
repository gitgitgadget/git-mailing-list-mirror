From: "Rado Dr." <radodr@gmail.com>
Subject: Re: git status & seg.fault
Date: Tue, 26 Oct 2010 11:45:33 +0200
Message-ID: <AANLkTimRBmJkXh9LjgL51bwFD=AGBJRc2d1R0g=z0v2t@mail.gmail.com>
References: <AANLkTinymMtDKt1V9xb+adJiSoOKT8YSy1qHuHc_=yVq@mail.gmail.com>
	<AANLkTinghepgdMRjEBhpAMz-Mr0g7szKyYEDfE=ttstS@mail.gmail.com>
	<AANLkTikhU+hBwsh24JYGmwHoNFGMseAx_+rUMYH4XGkT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 26 11:45:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAg6M-000062-9D
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 11:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758857Ab0JZJpg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Oct 2010 05:45:36 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50254 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758816Ab0JZJpe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Oct 2010 05:45:34 -0400
Received: by gxk23 with SMTP id 23so2484842gxk.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5DpSZhMMtjoGktR+2gZ2VjK9q6QrtNKvwJnnvQ78Ul8=;
        b=EwZhBU5t++SxYzzuqLGawAwj9RFOUSq4gTF4DmmKQnwxknonn2MqIKT8xyxSbLtU6k
         a3g1Xio/5lx0HsTxgVLHA328qLyzXxsASzI92kwf6ntuUvg33GOgfAlGIsMfU7JsU/uk
         Q3ZkW63fe7CRD6coscm10uqX7PPSg36GCr5zU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=owSPziS/ytOXBJGc/cCcLmlzQwXDCOaY+RMLB+l1zJQiR0q/n1avCleaAyBPXLX2Zu
         U4yBkCloFx5qqtRimO3sxZuisjtqAXw4ru0EsAoUUjcoLrfqiJHGwHvOTV3Mh2HBWwwr
         g7GLLgVUkVNJLC7u0r8pW3AnaVQcRVWJqwG/g=
Received: by 10.151.113.12 with SMTP id q12mr3087134ybm.111.1288086333703;
 Tue, 26 Oct 2010 02:45:33 -0700 (PDT)
Received: by 10.151.49.3 with HTTP; Tue, 26 Oct 2010 02:45:33 -0700 (PDT)
In-Reply-To: <AANLkTikhU+hBwsh24JYGmwHoNFGMseAx_+rUMYH4XGkT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159985>

there is output:
Reading symbols from /usr/local/bin/git...done.
(gdb) run
Starting program: /usr/local/bin/git status
[Thread debugging using libthread_db enabled]

Program received signal SIGSEGV, Segmentation fault.
hash_index_entry (istate=3D<value optimized out>, ce=3D0xb7c00c90) at n=
ame-hash.c:44
44		hash =3D hash_name(ce->name, ce_namelen(ce));
(gdb) bt full
#0  hash_index_entry (istate=3D<value optimized out>, ce=3D0xb7c00c90) =
at
name-hash.c:44
        pos =3D <value optimized out>
        hash =3D 3198509075
#1  0x080dde47 in lazy_init_name_hash (istate=3D0x8194180,
name=3D0xbfffb34b "src/FotoPlusServer/build.xml", namelen=3D28, icase=3D=
0)
    at name-hash.c:59
        nr =3D 16273
#2  index_name_exists (istate=3D0x8194180, name=3D0xbfffb34b
"src/FotoPlusServer/build.xml", namelen=3D28, icase=3D0) at
name-hash.c:108
        hash =3D <value optimized out>
        ce =3D <value optimized out>
#3  0x080cf190 in dir_add_name (dir=3D<value optimized out>, base=3D<va=
lue
optimized out>, baselen=3D<value optimized out>, check_only=3D0,
    simplify=3D0x0) at dir.c:449
No locals.
#4  read_directory_recursive (dir=3D<value optimized out>, base=3D<valu=
e
optimized out>, baselen=3D<value optimized out>, check_only=3D0,
    simplify=3D0x0) at dir.c:809
        len =3D 28
        de =3D <value optimized out>
        path =3D "src/FotoPlusServer/build.xml", '\000' <repeats 305
times>, "s\232\352\267", '\000' <repeats 12 times>,
"s\232\352\267\v\000\000\000
\273\377\277\v\000\000\000\364_\371\267\214\272\377\277
\273\377\277X\272\377\277\036\315=E7=B7=8C\272\377\277\200I\024\b\v\000=
\000\000\"\322=E7=B7=9C\272\377\277\331[\023\b",
'\000' <repeats 92 times>"\377, \377\377\377", '\000' <repeats 28
times>, " ", '\000' <repeats 31 times>"\300,
\271\377\277\000\000\000\000v\373\377\377", '\000' <repeats 16
times>"\352, \377\377\377\000\000\000\000\000\000\000\000\202\357\347\2=
67
\273\377\277\002\000\000\000\213I\024\b\000\000\000\000=D4=BB\377\277\2=
00I\024\b\v\000\000\000\000\000\000\000\020\274\377\277\327[\023\b\026"=
,
'\000' <repeats 947 times>, "s\232\352\267", '\000' <repeats 12
times>, "s\232\352\267\v\000\000\000\020\300\377\277\v\000\000\000\364_=
\371\267|\277\377\277\020\300\377\277H\277\377\277\036\315\347\267|\277=
\377\277\200I\024\b\v"...
        fdir =3D 0x8488b30
        contents =3D 1
#5  0x080cf24f in read_directory_recursive (dir=3D<value optimized out>=
,
base=3D<value optimized out>, baselen=3D<value optimized out>,
    check_only=3D0, simplify=3D0x0) at dir.c:797
        len =3D 19
        de =3D <value optimized out>
        path =3D "src/FotoPlusServer/", '\000' <repeats 746 times>,
"s\232\352\267", '\000' <repeats 16 times>,
"\005\000\000\000@\315\377\277\005\000\000\000\364_\371\267\254\314\377=
\277\370\032\024\bx\314\377\277\"\322=E7=B7=AC\314\377\277\363\032\024\=
b\005",
'\000' <repeats 23 times>, "\005", '\000' <repeats 67 times>"\377,
\377\377\377", '\000' <repeats 28 times>, " ", '\000' <repeats 31
times>"\320, \313\377\277\000\000\000\000v\373\377\377\000\000\000\000\=
362\032\024\b\000\000\000\000\000\000\000\000\374\377\377\377\000\000\0=
00\000\000\000\000\000\202\357\347\267\000\000\000\000\363\032\024\b\34=
0V\371\267\370\032\024\b@\315\377\277\002\000\000\000\357\032\024\b\000=
\000\000\000\344\315\377\277\342\032\024\b\026",
'\000' <repeats 555 times>, "q\a\347\267", '\000' <repeats 40
times>"\377, \377\377\377\000\000\000\000\005\000\000\000\260\312\377\2=
77",
'\000' <repeats 12 times>"\231, \231\231\031\024\274<"...
        fdir =3D 0x84140b8
        contents =3D 0
#6  0x080cf24f in read_directory_recursive (dir=3D<value optimized out>=
,
base=3D<value optimized out>, baselen=3D<value optimized out>,
    check_only=3D0, simplify=3D0x0) at dir.c:797
        len =3D 4
        de =3D <value optimized out>
        path =3D "src/\000\001\000\000\000\204\324\377\277\250\324\377\=
277+5\f\b\001\000\000\000\000\000\000\000\204\324\377\277\250\363\377\2=
77\000\000\000\000\244\000\000\000\363-\217\343\300s\371\267\240\000\00=
0\000\350\263E\b\030,\000\000\244\201\000\000Ll\276\267\250\363\377\277=
`\361\377\277\360\263E\b4\264E\b\000\000\000\000Ll\276\267\244\201\000\=
000\250\324\377\277\315\376=EA=B7=A8\324\377\277(\360\377\277(\360\377\=
277<\316D\bH\326\377\277\070/\021\b\354\325\377\277(\360\377\277\060\31=
6D\b\222\063\020\b@\331\032\b\250\236\255\003\000\000\000\000T\326\377\=
277U\000\000\000\314\325\377\277\310\325\377\277\354\325\377\277L\325\3=
77\277@\331\032\bX\326\377\277\000\000\000\000[\000\000\000(\360\377\27=
7\244\201\000\000\000\200\000\000(\360\377\277\000\000\000\000\001\000\=
000\000\000
\000\000P\326\377\277\034\264E\b\360\263E\b\001\000\000\000\300s\371\26=
7\364_\371\267\030\020#\b-\020#\b\037\020#\b\244\201\000\000O\000\000\0=
00\373%\021\b\346i\276\267\066\000\000\000\000\200\000\000\250\236\255\=
003\000\000\000\000\022\064\273^\031\253@\360J\276'yp1\366\002c_\016u@\=
331\032\b\000\065YF\256\331\352\267\034\340\377\277\000\000\000\000P\32=
6\377\277T\326\377\277X\326\377\277\330\325\377\277\333-\020\b\b"...
        fdir =3D 0x840c098
        contents =3D 0
#7  0x080cf7ef in read_directory (dir=3D0xbfffe514, path=3D0x8128050 ""=
,
len=3D0, pathspec=3D0x0) at dir.c:916
        simplify =3D 0x0
#8  0x080cf951 in fill_directory (dir=3D0xbfffe514, pathspec=3D0x0) at =
dir.c:70
        path =3D <value optimized out>
        len =3D 0
#9  0x081196c5 in wt_status_collect_untracked (s=3D0xbffff5ac) at wt-st=
atus.c:390
        i =3D <value optimized out>
        dir =3D {nr =3D 0, alloc =3D 0, ignored_nr =3D 0, ignored_alloc=
 =3D 0,
flags =3D 6, entries =3D 0x0, ignored =3D 0x0,
          exclude_per_dir =3D 0x8128031 ".gitignore", exclude_list =3D
{{nr =3D 0, alloc =3D 0, excludes =3D 0x0}, {nr =3D 11, alloc =3D 24,
              excludes =3D 0x82a8a98}, {nr =3D 0, alloc =3D 0, excludes=
 =3D
0x0}}, exclude_stack =3D 0x83f0d80,
          basebuf =3D "src/FotoPlusServer/\000gitignore", '\000'
<repeats 4066 times>}
#10 0x08062384 in cmd_status (argc=3D1, argv=3D0xbffff968, prefix=3D0x0=
) at
builtin/commit.c:1104
        s =3D {is_initial =3D 0, branch =3D 0x81952a0
"refs/heads/uploadFiles", reference =3D 0x81268be "HEAD", pathspec =3D
0x0, verbose =3D 0,
          amend =3D 0, in_merge =3D 0, nowarn =3D 0, use_color =3D -1,
relative_paths =3D 1, submodule_summary =3D 0, show_ignored_files =3D 0=
,
          show_untracked_files =3D SHOW_NORMAL_UNTRACKED_FILES,
ignore_submodule_arg =3D 0x0, color_palette =3D {'\000' <repeats 39
times>,
            "\033[33m", '\000' <repeats 34 times>, "\033[32m", '\000'
<repeats 34 times>, "\033[36m", '\000' <repeats 34 times>,
            "\033[31m", '\000' <repeats 34 times>, "\033[31m", '\000'
<repeats 34 times>, "\033[32m", '\000' <repeats 34 times>,
            "\033[31m", '\000' <repeats 34 times>}, commitable =3D 0,
workdir_dirty =3D 1, index_file =3D 0x81951a0 ".git/index",
          fp =3D 0xb7f964e0, prefix =3D 0x0, change =3D {items =3D 0x84=
77190,
nr =3D 430, alloc =3D 448, strdup_strings =3D 1}, untracked =3D {
            items =3D 0x0, nr =3D 0, alloc =3D 0, strdup_strings =3D 1}=
,
ignored =3D {items =3D 0x0, nr =3D 0, alloc =3D 0, strdup_strings =3D 1=
}}
        fd =3D <value optimized out>
        sha1 =3D "j\201\033YO;}d\323\v\313\062\372\205\264{A\353Hh"
        builtin_status_options =3D {{type =3D OPTION_BOOLEAN, short_nam=
e =3D
118, long_name =3D 0x8124a8d "verbose", value =3D 0x8158074,
            argh =3D 0x0, help =3D 0x8124a8a "be verbose", flags =3D 2,
callback =3D 0, defval =3D 0}, {type =3D OPTION_SET_INT, short_name =3D=
 115,
            long_name =3D 0x81376d5 "short", value =3D 0x8155f60, argh =
=3D
0x0, help =3D 0x812984a "show status concisely", flags =3D 2,
            callback =3D 0, defval =3D 1}, {type =3D OPTION_BOOLEAN,
short_name =3D 98, long_name =3D 0x8136139 "branch", value =3D 0x81580c=
4,
            argh =3D 0x0, help =3D 0x8129860 "show branch information",
flags =3D 2, callback =3D 0, defval =3D 0}, {type =3D OPTION_SET_INT,
            short_name =3D 0, long_name =3D 0x814434e "porcelain", valu=
e =3D
0x8155f60, argh =3D 0x0,
            help =3D 0x8129878 "show porcelain output format", flags =3D
2, callback =3D 0, defval =3D 2}, {type =3D OPTION_BOOLEAN,
            short_name =3D 122, long_name =3D 0x813e113 "null", value =3D
0x81580c0, argh =3D 0x0, help =3D 0x8129895 "terminate entries with NUL=
",
            flags =3D 2, callback =3D 0, defval =3D 0}, {type =3D
OPTION_STRING, short_name =3D 117, long_name =3D 0x81298ef
"untracked-files",
            value =3D 0x8158090, argh =3D 0x812e1e0 "mode",
            help =3D 0x812a1ec "show untracked files, optional modes:
all, normal, no. (Default: all)", flags =3D 1, callback =3D 0,
            defval =3D 135440244}, {type =3D OPTION_BOOLEAN, short_name=
 =3D
0, long_name =3D 0x8138e1e "ignored", value =3D 0x81580ac, argh =3D 0x0=
,
            help =3D 0x812993c "show ignored files", flags =3D 2, callb=
ack
=3D 0, defval =3D 0}, {type =3D OPTION_STRING, short_name =3D 0,
            long_name =3D 0x8139d7b "ignore-submodules", value =3D
0x8158098, argh =3D 0x8126ec1 "when",
            help =3D 0x812a234 "ignore changes to submodules, optional
when: all, dirty, untracked. (Default: all)", flags =3D 1,
            callback =3D 0, defval =3D 135440244}, {type =3D OPTION_END=
,
short_name =3D 0, long_name =3D 0x0, value =3D 0x0, argh =3D 0x0, help =
=3D 0x0,
            flags =3D 0, callback =3D 0, defval =3D 0}}
#11 0x0804b868 in run_builtin (argc=3D<value optimized out>, argv=3D<va=
lue
optimized out>) at git.c:275
        status =3D <value optimized out>
        st =3D {st_dev =3D 13256754246612680856, __pad1 =3D 24564, __st=
_ino
=3D 3086578624, st_mode =3D 0, st_nlink =3D 3221223416,
          st_uid =3D 3085631181, st_gid =3D 136, st_rdev =3D
13835049485613071968, __pad2 =3D 64776, st_size =3D 581093732451874840,
          st_blksize =3D -1073743820, st_blocks =3D 0, st_atim =3D {tv_=
sec =3D
1, tv_nsec =3D -1073743820}, st_mtim =3D {tv_sec =3D -1073743820,
            tv_nsec =3D -1073743800}, st_ctim =3D {tv_sec =3D 135073352=
,
tv_nsec =3D -1073743820}, st_ino =3D 4430843936}
        prefix =3D 0x0
#12 handle_internal_command (argc=3D<value optimized out>, argv=3D<valu=
e
optimized out>) at git.c:431
        p =3D 0x8149760
        cmd =3D <value optimized out>
        commands =3D {{cmd =3D 0x8135f74 "add", fn =3D 0x804c400 <cmd_a=
dd>,
option =3D 9}, {cmd =3D 0x8124034 "stage", fn =3D 0x804c400 <cmd_add>,
            option =3D 9}, {cmd =3D 0x812403a "annotate", fn =3D 0x804c=
f20
<cmd_annotate>, option =3D 1}, {cmd =3D 0x8124ad9 "apply",
            fn =3D 0x8053c70 <cmd_apply>, option =3D 2}, {cmd =3D 0x812=
6142
"archive", fn =3D 0x8054b50 <cmd_archive>, option =3D 0}, {
            cmd =3D 0x8124043 "bisect--helper", fn =3D 0x8054d90
<cmd_bisect__helper>, option =3D 9}, {cmd =3D 0x8124052 "blame",
            fn =3D 0x80571a0 <cmd_blame>, option =3D 1}, {cmd =3D 0x813=
6139
"branch", fn =3D 0x805a0c0 <cmd_branch>, option =3D 1}, {
            cmd =3D 0x8128b6a "bundle", fn =3D 0x805b260 <cmd_bundle>,
option =3D 2}, {cmd =3D 0x8124058 "cat-file",
            fn =3D 0x805ba80 <cmd_cat_file>, option =3D 1}, {cmd =3D
0x8128cb6 "checkout", fn =3D 0x805e100 <cmd_checkout>, option =3D 9}, {
            cmd =3D 0x8124061 "checkout-index", fn =3D 0x805c9e0
<cmd_checkout_index>, option =3D 9}, {cmd =3D 0x8124070
"check-ref-format",
            fn =3D 0x805c3f0 <cmd_check_ref_format>, option =3D 0}, {cm=
d =3D
0x8124081 "check-attr", fn =3D 0x805c090 <cmd_check_attr>,
           option =3D 1}, {cmd =3D 0x812408c "cherry", fn =3D 0x807b630
<cmd_cherry>, option =3D 1}, {cmd =3D 0x814277b "cherry-pick",
            fn =3D 0x80a2420 <cmd_cherry_pick>, option =3D 9}, {cmd =3D
0x8124093 "clone", fn =3D 0x8060630 <cmd_clone>, option =3D 0}, {
            cmd =3D 0x8124099 "clean", fn =3D 0x805f960 <cmd_clean>,
option =3D 9}, {cmd =3D 0x81294a3 "commit", fn =3D 0x8063ef0 <cmd_commi=
t>,
            option =3D 9}, {cmd =3D 0x812409f "commit-tree", fn =3D
0x8061b50 <cmd_commit_tree>, option =3D 1}, {cmd =3D 0x8124264 "config"=
,
            fn =3D 0x8065c80 <cmd_config>, option =3D 2}, {cmd =3D 0x81=
240ab
"count-objects", fn =3D 0x80665b0 <cmd_count_objects>, option =3D 1}, {
            cmd =3D 0x81240b9 "describe", fn =3D 0x8067540 <cmd_describ=
e>,
option =3D 1}, {cmd =3D 0x813dac6 "diff", fn =3D 0x80687f0 <cmd_diff>,
            option =3D 0}, {cmd =3D 0x81240c2 "diff-files", fn =3D 0x80=
67cf0
<cmd_diff_files>, option =3D 9}, {cmd =3D 0x81240cd "diff-index",
            fn =3D 0x8067f70 <cmd_diff_index>, option =3D 1}, {cmd =3D
0x81240d8 "diff-tree", fn =3D 0x8068130 <cmd_diff_tree>, option =3D 1},=
 {
            cmd =3D 0x8144e9d "fast-export", fn =3D 0x8069a00
<cmd_fast_export>, option =3D 1}, {cmd =3D 0x8128bfb "fetch",
            fn =3D 0x806ee10 <cmd_fetch>, option =3D 1}, {cmd =3D 0x812=
40e2
"fetch-pack", fn =3D 0x806c8c0 <cmd_fetch_pack>, option =3D 1}, {
            cmd =3D 0x81240ed "fmt-merge-msg", fn =3D 0x806fde0
<cmd_fmt_merge_msg>, option =3D 1}, {cmd =3D 0x81240fb "for-each-ref",
            fn =3D 0x8071960 <cmd_for_each_ref>, option =3D 1}, {cmd =3D
0x8124108 "format-patch", fn =3D 0x807d350 <cmd_format_patch>,
            option =3D 1}, {cmd =3D 0x813e95e "fsck", fn =3D 0x8072a40
<cmd_fsck>, option =3D 1}, {cmd =3D 0x8124115 "fsck-objects",
            fn =3D 0x8072a40 <cmd_fsck>, option =3D 1}, {cmd =3D 0x812e=
20c
"gc", fn =3D 0x80736f0 <cmd_gc>, option =3D 1}, {
            cmd =3D 0x8124122 "get-tar-commit-id", fn =3D 0x80a8e60
<cmd_get_tar_commit_id>, option =3D 0}, {cmd =3D 0x812e5d7 "grep",
            fn =3D 0x8074da0 <cmd_grep>, option =3D 2}, {cmd =3D 0x8124=
134
"hash-object", fn =3D 0x80766a0 <cmd_hash_object>, option =3D 0}, {
            cmd =3D 0x8123e78 "help", fn =3D 0x80773f0 <cmd_help>, opti=
on
=3D 0}, {cmd =3D 0x8124140 "index-pack",
            fn =3D 0x8078a20 <cmd_index_pack>, option =3D 2}, {cmd =3D
0x8128d4a "init", fn =3D 0x807ae70 <cmd_init_db>, option =3D 0}, {
            cmd =3D 0x812414b "init-db", fn =3D 0x807ae70 <cmd_init_db>=
,
option =3D 0}, {cmd =3D 0x81419a8 "log", fn =3D 0x807cb50 <cmd_log>,
            option =3D 1}, {cmd =3D 0x8124153 "ls-files", fn =3D 0x807f=
0c0
<cmd_ls_files>, option =3D 1}, {cmd =3D 0x812415c "ls-tree",
            fn =3D 0x8080770 <cmd_ls_tree>, option =3D 1}, {cmd =3D
0x8124164 "ls-remote", fn =3D 0x8080360 <cmd_ls_remote>, option =3D 2},=
 {
            cmd =3D 0x812416e "mailinfo", fn =3D 0x80823a0 <cmd_mailinf=
o>,
option =3D 0}, {cmd =3D 0x8124177 "mailsplit",
            fn =3D 0x8083960 <cmd_mailsplit>, option =3D 0}, {cmd =3D
0x8132243 "merge", fn =3D 0x8085700 <cmd_merge>, option =3D 9}, {
            cmd =3D 0x8124181 "merge-base", fn =3D 0x8087450
<cmd_merge_base>, option =3D 1}, {cmd =3D 0x812418c "merge-file",
            fn =3D 0x8087800 <cmd_merge_file>, option =3D 2}, {cmd =3D
0x8124197 "merge-index", fn =3D 0x8087ec0 <cmd_merge_index>, option =3D
1}, {
            cmd =3D 0x81241a3 "merge-ours", fn =3D 0x80880f0
<cmd_merge_ours>, option =3D 1}, {cmd =3D 0x81241ae "merge-recursive",
            fn =3D 0x80881e0 <cmd_merge_recursive>, option =3D 9}, {cmd=
 =3D
0x81241be "merge-recursive-ours",
            fn =3D 0x80881e0 <cmd_merge_recursive>, option =3D 9}, {cmd=
 =3D
0x81241d3 "merge-recursive-theirs",
            fn =3D 0x80881e0 <cmd_merge_recursive>, option =3D 9}, {cmd=
 =3D
0x81241ea "merge-subtree", fn =3D 0x80881e0 <cmd_merge_recursive>,
            option =3D 9}, {cmd =3D 0x81241f8 "merge-tree", fn =3D 0x80=
88a30
<cmd_merge_tree>, option =3D 1}, {cmd =3D 0x8124203 "mktag",
            fn =3D 0x8088de0 <cmd_mktag>, option =3D 1}, {cmd =3D 0x812=
4209
"mktree", fn =3D 0x8089350 <cmd_mktree>, option =3D 1}, {
            cmd =3D 0x8124210 "mv", fn =3D 0x8089b60 <cmd_mv>, option =3D
9}, {cmd =3D 0x8124213 "name-rev", fn =3D 0x808a600 <cmd_name_rev>,
            option =3D 1}, {cmd =3D 0x8133035 "notes", fn =3D 0x808c0b0
<cmd_notes>, option =3D 1}, {cmd =3D 0x813b98c "pack-objects",
            fn =3D 0x80905e0 <cmd_pack_objects>, option =3D 1}, {cmd =3D
0x812421c "pack-redundant", fn =3D 0x8091fd0 <cmd_pack_redundant>,
            option =3D 1}, {cmd =3D 0x812422b "patch-id", fn =3D 0x8093=
4b0
<cmd_patch_id>, option =3D 0}, {cmd =3D 0x8124234 "peek-remote",
            fn =3D 0x8080360 <cmd_ls_remote>, option =3D 2}, {cmd =3D
0x8124240 "pickaxe", fn =3D 0x80571a0 <cmd_blame>, option =3D 1}, {
            cmd =3D 0x81362fb "prune", fn =3D 0x8093b10 <cmd_prune>,
option =3D 1}, {cmd =3D 0x8124248 "prune-packed",
            fn =3D 0x8093900 <cmd_prune_packed>, option =3D 1}, {cmd =3D
0x81448f6 "push", fn =3D 0x8094250 <cmd_push>, option =3D 1}, {
            cmd =3D 0x8124255 "read-tree", fn =3D 0x8094ce0
<cmd_read_tree>, option =3D 1}, {cmd =3D 0x813833b "receive-pack",
            fn =3D 0x8096040 <cmd_receive_pack>, option =3D 0}, {cmd =3D
0x8126f2e "reflog", fn =3D 0x80987b0 <cmd_reflog>, option =3D 1}, {
            cmd =3D 0x8135e0e "remote", fn =3D 0x809b140 <cmd_remote>,
option =3D 1}, {cmd =3D 0x8139d95 "replace", fn =3D 0x809cf90 <cmd_repl=
ace>,
            option =3D 1}, {cmd =3D 0x812425f "repo-config", fn =3D
0x8065c80 <cmd_config>, option =3D 2}, {cmd =3D 0x812426b "rerere",
            fn =3D 0x809d320 <cmd_rerere>, option =3D 1}, {cmd =3D 0x81=
27fb4
"reset", fn =3D 0x809dd30 <cmd_reset>, option =3D 1}, {
            cmd =3D 0x812d009 "rev-list", fn =3D 0x809ee30 <cmd_rev_lis=
t>,
option =3D 1}, {cmd =3D 0x8124272 "rev-parse",
            fn =3D 0x809f9f0 <cmd_rev_parse>, option =3D 0}, {cmd =3D
0x812427c "revert", fn =3D 0x80a2440 <cmd_revert>, option =3D 9}, {
            cmd =3D 0x8124283 "rm", fn =3D 0x80a2490 <cmd_rm>, option =3D
1}, {cmd =3D 0x8124286 "send-pack", fn =3D 0x80a3710 <cmd_send_pack>,
            option =3D 1}, {cmd =3D 0x8124290 "shortlog", fn =3D 0x80a4=
9f0
<cmd_shortlog>, option =3D 6}, {cmd =3D 0x8124299 "show-branch",
            fn =3D 0x80a5640 <cmd_show_branch>, option =3D 1}, {cmd =3D
0x81242a5 "show", fn =3D 0x807cdf0 <cmd_show>, option =3D 1}, {
            cmd =3D 0x81382b0 "status", fn =3D 0x8062200 <cmd_status>,
option =3D 9}, {cmd =3D 0x81242aa "stripspace",
            fn =3D 0x80a7670 <cmd_stripspace>, option =3D 0}, {cmd =3D
0x81242b5 "symbolic-ref", fn =3D 0x80a7760 <cmd_symbolic_ref>,
            option =3D 1}, {cmd =3D 0x81446b1 "tag", fn =3D 0x80a7ef0
<cmd_tag>, option =3D 1}, {cmd =3D 0x81242c2 "tar-tree",
            fn =3D 0x80a8f40 <cmd_tar_tree>, option =3D 0}, {cmd =3D
0x81242cb "unpack-file", fn =3D 0x80a90d0 <cmd_unpack_file>, option =3D
1}, {
            cmd =3D 0x81242d7 "unpack-objects", fn =3D 0x80a9a90
<cmd_unpack_objects>, option =3D 1}, {cmd =3D 0x81242e6 "update-index",
            fn =3D 0x80ab010 <cmd_update_index>, option =3D 1}, {cmd =3D
0x81242f3 "update-ref", fn =3D 0x80ac150 <cmd_update_ref>, option =3D 1=
},
{
            cmd =3D 0x81242fe "update-server-info", fn =3D 0x80ac3d0
<cmd_update_server_info>, option =3D 1}, {
            cmd =3D 0x812613b "upload-archive", fn =3D 0x80ac780
<cmd_upload_archive>, option =3D 0}, {cmd =3D 0x8124311 "var",
            fn =3D 0x80aca40 <cmd_var>, option =3D 2}, {cmd =3D 0x81243=
15
"verify-tag", fn =3D 0x80ad540 <cmd_verify_tag>, option =3D 1}, {
            cmd =3D 0x814696b "version", fn =3D 0x80d5510 <cmd_version>=
,
option =3D 0}, {cmd =3D 0x8124320 "whatchanged",
            fn =3D 0x807cc10 <cmd_whatchanged>, option =3D 1}, {cmd =3D
0x813a9a9 "write-tree", fn =3D 0x80ad760 <cmd_write_tree>, option =3D 1=
},
{
            cmd =3D 0x812432c "verify-pack", fn =3D 0x80ad1b0
<cmd_verify_pack>, option =3D 0}, {cmd =3D 0x8124338 "show-ref",
            fn =3D 0x80a6fb0 <cmd_show_ref>, option =3D 1}, {cmd =3D
0x8124341 "pack-refs", fn =3D 0x80930b0 <cmd_pack_refs>, option =3D 1}}
        i =3D 88
#13 0x0804ba63 in run_argv (argc=3D1, argv=3D0xbffff968) at git.c:475
        done_alias =3D 0
#14 main (argc=3D1, argv=3D0xbffff968) at git.c:548
        done_help =3D 0
        was_alias =3D 0
        cmd =3D <value optimized out>
(gdb)


2010/10/26 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>:
> On Tue, Oct 26, 2010 at 08:44, Rado Dr. <radodr@gmail.com> wrote:
>> I have "Segmentation fault" error after "git status" command in one =
of
>> my local repos. Just i one repo, other repos are OK. I can't find an=
y
>> clue how to fix it, and as usually I need work with that repo ;-)
>>
>> I tried this:
>> =C2=A0- git gc =C2=A0-> OK
>> =C2=A0- git fsck ->
>> missing blob 0000000000000000000000000000000000000000
>> dangling blob 2f1f0144f786ca887c4911a064bbb28a047f1f77
>> dangling blob 7ffb0f4e430cd60261661138df61ecb50cf1d0a4
>>
>> Is this the reason of fault? If yes, how can=C2=A0I fix it.
>>
>> My system info:
>> Linux 32bit,=C2=A0Ubuntu 10.04 LTS - Lucid Lynx,
>> git version 1.7.0.4
>
> Can you reproduce it on the latest version of git built from git.git?
>
> Can you run it under gdb and provide a "bt full" backtrace?
>



--=20
Rado Dr.
