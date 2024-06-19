Received: from mail180-6.suw31.mandrillapp.com (mail180-6.suw31.mandrillapp.com [198.2.180.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C5145977
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 05:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.180.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718774065; cv=none; b=th0lpdi2jPrUTYI/E0fPNaco1hlanzl32IuQZH0opFs+SZUv9Nxz530CqsYvsqL3aq1D8Fjw5oS1Sy2+Teo43t88qrOCqrLIks79p8guvrnJX+ClTJRgP95dpUPipmJTtN+HYJqxF+dKUnlZp4oy23jCpBwmX3/AGJnilsJEfF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718774065; c=relaxed/simple;
	bh=PUB5l0gYDRxoPZGcitGVHJ2o/8+F5DJo1EhqOu4wxmY=;
	h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=DzMt7uCcy8N0fMTvK/j8tpAFAV76R/F5YZQqMP0SyRVbFMWUyzBDlbhnyTYxFtr51nD70kshMziGbAOpjZY3lb81aI7tXWmIXHeAJYRdr47nGbGrPvReyj2NH9AIykHyctpexB3TqiqsKOUPxUKa2B3KhR8zCBiv5PuIJ+nwGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nexedi.com; spf=pass smtp.mailfrom=mandrillapp.mail.nexedi.com; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=OExzLBBN; dkim=pass (2048-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b=jdbrWEWN; arc=none smtp.client-ip=198.2.180.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nexedi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandrillapp.mail.nexedi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="OExzLBBN";
	dkim=pass (2048-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="jdbrWEWN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1718774061; x=1719034561;
	bh=hcwuenlOugxejhElA3v6zk9yEskT+H2LwEeQKvLtMng=;
	h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=OExzLBBNLtBarDFpZ+O/8qDOSzUFRPHaRO5PuBt7zxCMAL0ldeH60eiyOfD4LKxRH
	 jYQGjePAGu5POAa0082wzkkIEqHnXRraVzTdlDuiNMvrP9Nmtxzfmtl29yv6AKYLyn
	 P0Ly9CHnmX2l0e70PGlbDS6+U0XGIowkkPDCGEOI5BPJU1pIzi1xnm9YOBhZYvkeHS
	 qXr8acGWFGmDN//KZGi/HHGaktLOfhiDWlj5VRODyRc6JaBvLYjbh2/WCwqlwBpZsN
	 4aObCXdQTDcOTI4S1sOyRuEDo8nuXXXta5mWqFc5kpQxyuiWa25tf0mKXUErvsW9Et
	 lH+ao3LyxqmOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexedi.com; s=mte1;
	t=1718774061; x=1719034561; i=kirr@nexedi.com;
	bh=hcwuenlOugxejhElA3v6zk9yEskT+H2LwEeQKvLtMng=;
	h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=jdbrWEWNcBCIlQARoUa8WorEKfL8kJ8dsggg8f4Hp1lkSkL9paCQZkpwUVZVXpGn0
	 bymmlan42zYoUo0mdKw+oyrsmxV/axCfbps7hch8t84RUA++LVvn/hQasx0vMP7fHr
	 /gCmugW+9TpKz1JeIpgZLOiAWt9GrrwToY0rNkckGw9YghPb18IHBnUteZsf7xGBy0
	 UunIIRl+pjkrsoyN8C6a3TV2WIhAD4q1gMPV1H7JX7YQHKo/j/ge10RCutoLkJVi7A
	 rT2i/DuGabrnZjG1dddiGlaBk9HYQ1b6GfP0lBuAAFbJZxNv3Eaum02Byg9+zPiAlL
	 sn/zNOT4/2Egg==
Received: from pmta11.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail180-6.suw31.mandrillapp.com (Mailchimp) with ESMTP id 4W3sHK63Sqz2K22Yr
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 05:14:21 +0000 (GMT)
From: Kirill Smelkov <kirr@nexedi.com>
Subject: =?utf-8?Q?[RESEND,=20BUG,=20SIGSEGV=20CRASH]=20(Re:=20[PATCH]=20fetch-pack:=20test:=20demonstrate=20segmentation=20fault=20when=20run=20with=20fsckObjects=20but=20without=20--lock-pack)?=
Received: from [87.98.221.171] by mandrillapp.com id 0e8c3e57282b4dc09f72896411dabfef; Wed, 19 Jun 2024 05:14:21 +0000
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>, Alain Takoudjou <alain.takoudjou@nexedi.com>, =?utf-8?Q?J=C3=A9rome=20Perrin?= <jerome@nexedi.com>, Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>, =?utf-8?Q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Message-Id: <ZnJpJyLPAKlu82s8@deca.navytux.spb.ru>
References: <20240606133605.602276-1-kirr@nexedi.com>
In-Reply-To: <20240606133605.602276-1-kirr@nexedi.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D31050260.0e8c3e57282b4dc09f72896411dabfef?=
X-Mandrill-User: md_31050260
Feedback-ID: 31050260:31050260.20240619:md
Date: Wed, 19 Jun 2024 05:14:21 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

+ newren, peff, calvinwan, ps, avarab

Hello everyone. This patch demonstrates *segmentation fault* crash of Git
with, hopefully, properly written test. It was originally posted two
weeks ago without getting any replies nor any traces in seen/todo:

https://lore.kernel.org/git/20240606133605.602276-1-kirr@nexedi.com/T/#m9d4=
54aadc8857b84f17d1a331739f7399cf1bbf8

I understand that there might be something wrong with my test, but could
you please at least provide some feedback and acknowledge the problem?

Resending the patch and adding more people to Cc who touched fetch-pack.c r=
ecently.

Thanks beforehand for feedback,
Kirill

---- 8< ----
From: Kirill Smelkov <kirr@nexedi.com>
Date: Thu, 6 Jun 2024 16:03:44 +0300
Subject: [PATCH] fetch-pack: test: demonstrate segmentation fault when run
 with fsckObjects but without --lock-pack
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

When running git-backup[1] over lab.nexedi.com archive we noticed that
Git started to crash on fetch-pack operation[2] after Git upgrade. We
tracked this down to be a regression introduced by Git 2.31, more
specifically by commit 5476e1efded5 (fetch-pack: print and use dangling
.gitmodules), which started to index and lock packfiles on do_keep=3Dy &&
fsck_objects=3Dy even if pack_lockfiles=3DNULL, which leads to
NULL-dereference when trying to append an entry to that pack_lockfiles
stringlist.

Please find attached a test that demonstrates this problem.

When run with test_expect_failure changed to test_expect_success the test
crashes with

    ./test-lib.sh: line 1063: 599675 Segmentation fault      (core dumped) =
git -c fetch.fsckObjects=3Dtrue -c fetch.unpackLimit=3D1 -C client fetch-pa=
ck ../server $(git -C server rev-parse refs/heads/main)

and the backtrace is

    Program terminated with signal SIGSEGV, Segmentation fault.
    #0  0x0000558032c7ef3b in string_list_append_nodup (list=3D0x0,
        string=3D0x558033b695f0 ".git/objects/pack/pack-c1b2455a361bb50a0db=
087e7202db73d62938fa1.keep") at string-list.c:218
    218             ALLOC_GROW(list->items, list->nr + 1, list->alloc);
    (gdb) bt
    #0  0x0000558032c7ef3b in string_list_append_nodup (list=3D0x0,
        string=3D0x558033b695f0 ".git/objects/pack/pack-c1b2455a361bb50a0db=
087e7202db73d62938fa1.keep") at string-list.c:218
    #1  0x0000558032b5b83f in get_pack (args=3D0x7ffe680f3fa0, xd=3D0x7ffe6=
80f4058, pack_lockfiles=3D0x0, index_pack_args=3D0x0,
        sought=3D0x558033b65e90, nr_sought=3D1, gitmodules_oids=3D0x558032e=
17b88 <fsck_options+72>) at fetch-pack.c:1042
    #2  0x0000558032b5e0b3 in do_fetch_pack_v2 (args=3D0x7ffe680f3fa0, fd=
=3D0x7ffe680f4058, orig_ref=3D0x558033b67b90, sought=3D0x558033b65e90,
        nr_sought=3D1, shallows=3D0x7ffe680f3df0, si=3D0x7ffe680f3e10, pack=
_lockfiles=3D0x0) at fetch-pack.c:1781
    #3  0x0000558032b5ef3c in fetch_pack (args=3D0x7ffe680f3fa0, fd=3D0x7ff=
e680f4058, ref=3D0x558033b67b90, sought=3D0x558033b65e90, nr_sought=3D1,
        shallow=3D0x7ffe680f3f80, pack_lockfiles=3D0x0, version=3Dprotocol_=
v2) at fetch-pack.c:2073
    #4  0x0000558032a08851 in cmd_fetch_pack (argc=3D3, argv=3D0x7ffe680f45=
00, prefix=3D0x0) at builtin/fetch-pack.c:242
    #5  0x00005580329b2be3 in run_builtin (p=3D0x558032e0bb30 <commands+100=
8>, argc=3D3, argv=3D0x7ffe680f4500) at git.c:474
    #6  0x00005580329b2ffe in handle_builtin (argc=3D3, argv=3D0x7ffe680f45=
00) at git.c:729
    #7  0x00005580329b3222 in run_argv (argcp=3D0x7ffe680f433c, argv=3D0x7f=
fe680f4330) at git.c:793
    #8  0x00005580329b3796 in cmd_main (argc=3D3, argv=3D0x7ffe680f4500) at=
 git.c:928
    #9  0x0000558032ab9002 in main (argc=3D10, argv=3D0x7ffe680f44c8) at co=
mmon-main.c:62

A simple debug patch below

    --- a/fetch-pack.c
    +++ b/fetch-pack.c
    @@ -1032,7 +1032,7 @@ static int get_pack(struct fetch_pack_args *args,
            cmd.git_cmd =3D 1;
            if (start_command(&cmd))
                    die(_("fetch-pack: unable to fork off %s"), cmd_name);
    -       if (do_keep && (pack_lockfiles || fsck_objects)) {
    +       if (do_keep && (pack_lockfiles /*|| fsck_objects*/)) {
                    int is_well_formed;
                    char *pack_lockfile =3D index_pack_lockfile(cmd.out, &i=
s_well_formed);

makes the crash go away, but I did not investigated what should be the
proper logic.

Thanks beforehand for fixing this NULL-pointer dereference.

Kirill

[1] https://lab.nexedi.com/kirr/git-backup
[2] https://lab.nexedi.com/kirr/git-backup/-/blob/3230197c/git-backup.go#L7=
17-739

Cc: Jonathan Tan <jonathantanmy@google.com>
Cc: Elijah Newren <newren@gmail.com>
Cc: Jeff King <peff@peff.net>
Cc: Calvin Wan <calvinwan@google.com>
Cc: Patrick Steinhardt <ps@pks.im>
Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Cc: Alain Takoudjou <alain.takoudjou@nexedi.com>
Cc: J=C3=A9rome Perrin <jerome@nexedi.com>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 t/t5500-fetch-pack.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 1bc15a3f08..e3dbe79613 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -1056,6 +1056,20 @@ test_expect_success 'fetch with --filter=3Dblob:limi=
t=3D0' '
 =09fetch_filter_blob_limit_zero server server
 '
 
+test_expect_failure 'fetch with fsckObjects but without --lock-pack does n=
ot segfault' '
+=09rm -rf server client &&
+=09git init server &&
+=09test_commit -C server 1 &&
+
+=09git init client &&
+=09# unpackLimit=3D1 forces to keep received pack as pack instead of
+=09# unpacking it to loose objects. The code is currently segfaulting when
+=09# trying to index that kept pack.
+=09git -c fetch.fsckObjects=3Dtrue -c fetch.unpackLimit=3D1 \
+=09    -C client fetch-pack ../server \
+=09=09$(git -C server rev-parse refs/heads/main)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.39.2

---- 8< ----


On Thu, Jun 06, 2024 at 04:36:05PM +0300, Kirill Smelkov wrote:
> When running git-backup[1] over lab.nexedi.com archive we noticed that
> Git started to crash on fetch-pack operation[2] after Git upgrade. We
> tracked this down to be a regression introduced by Git 2.31, more
> specifically by commit 5476e1efded5 (fetch-pack: print and use dangling
> .gitmodules), which started to index and lock packfiles on do_keep=3Dy &&
> fsck_objects=3Dy even if pack_lockfiles=3DNULL, which leads to
> NULL-dereference when trying to append an entry to that pack_lockfiles
> stringlist.
> 
> Please find attached a test that demonstrates this problem.
> 
> When run with test_expect_failure changed to test_expect_success the test
> crashes with
> 
>     ./test-lib.sh: line 1063: 599675 Segmentation fault      (core dumped=
) git -c fetch.fsckObjects=3Dtrue -c fetch.unpackLimit=3D1 -C client fetch-=
pack ../server $(git -C server rev-parse refs/heads/main)
> 
> and the backtrace is
> 
>     Program terminated with signal SIGSEGV, Segmentation fault.
>     #0  0x0000558032c7ef3b in string_list_append_nodup (list=3D0x0,
>         string=3D0x558033b695f0 ".git/objects/pack/pack-c1b2455a361bb50a0=
db087e7202db73d62938fa1.keep") at string-list.c:218
>     218             ALLOC_GROW(list->items, list->nr + 1, list->alloc);
>     (gdb) bt
>     #0  0x0000558032c7ef3b in string_list_append_nodup (list=3D0x0,
>         string=3D0x558033b695f0 ".git/objects/pack/pack-c1b2455a361bb50a0=
db087e7202db73d62938fa1.keep") at string-list.c:218
>     #1  0x0000558032b5b83f in get_pack (args=3D0x7ffe680f3fa0, xd=3D0x7ff=
e680f4058, pack_lockfiles=3D0x0, index_pack_args=3D0x0,
>         sought=3D0x558033b65e90, nr_sought=3D1, gitmodules_oids=3D0x55803=
2e17b88 <fsck_options+72>) at fetch-pack.c:1042
>     #2  0x0000558032b5e0b3 in do_fetch_pack_v2 (args=3D0x7ffe680f3fa0, fd=
=3D0x7ffe680f4058, orig_ref=3D0x558033b67b90, sought=3D0x558033b65e90,
>         nr_sought=3D1, shallows=3D0x7ffe680f3df0, si=3D0x7ffe680f3e10, pa=
ck_lockfiles=3D0x0) at fetch-pack.c:1781
>     #3  0x0000558032b5ef3c in fetch_pack (args=3D0x7ffe680f3fa0, fd=3D0x7=
ffe680f4058, ref=3D0x558033b67b90, sought=3D0x558033b65e90, nr_sought=3D1,
>         shallow=3D0x7ffe680f3f80, pack_lockfiles=3D0x0, version=3Dprotoco=
l_v2) at fetch-pack.c:2073
>     #4  0x0000558032a08851 in cmd_fetch_pack (argc=3D3, argv=3D0x7ffe680f=
4500, prefix=3D0x0) at builtin/fetch-pack.c:242
>     #5  0x00005580329b2be3 in run_builtin (p=3D0x558032e0bb30 <commands+1=
008>, argc=3D3, argv=3D0x7ffe680f4500) at git.c:474
>     #6  0x00005580329b2ffe in handle_builtin (argc=3D3, argv=3D0x7ffe680f=
4500) at git.c:729
>     #7  0x00005580329b3222 in run_argv (argcp=3D0x7ffe680f433c, argv=3D0x=
7ffe680f4330) at git.c:793
>     #8  0x00005580329b3796 in cmd_main (argc=3D3, argv=3D0x7ffe680f4500) =
at git.c:928
>     #9  0x0000558032ab9002 in main (argc=3D10, argv=3D0x7ffe680f44c8) at =
common-main.c:62
> 
> A simple debug patch below
> 
>     --- a/fetch-pack.c
>     +++ b/fetch-pack.c
>     @@ -1032,7 +1032,7 @@ static int get_pack(struct fetch_pack_args *arg=
s,
>             cmd.git_cmd =3D 1;
>             if (start_command(&cmd))
>                     die(_("fetch-pack: unable to fork off %s"), cmd_name)=
;
>     -       if (do_keep && (pack_lockfiles || fsck_objects)) {
>     +       if (do_keep && (pack_lockfiles /*|| fsck_objects*/)) {
>                     int is_well_formed;
>                     char *pack_lockfile =3D index_pack_lockfile(cmd.out, =
&is_well_formed);
> 
> makes the crash go away, but I did not investigated what should be the
> proper logic.
> 
> Thanks beforehand for fixing this NULL-pointer dereference.
> 
> Kirill
> 
> [1] https://lab.nexedi.com/kirr/git-backup
> [2] https://lab.nexedi.com/kirr/git-backup/-/blob/3230197c/git-backup.go#=
L717-739
> 
> Cc: Jonathan Tan <jonathantanmy@google.com>
> Cc: Alain Takoudjou <alain.takoudjou@nexedi.com>
> Cc: J=C3=A9rome Perrin <jerome@nexedi.com>
> Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
> ---
>  t/t5500-fetch-pack.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 1bc15a3f08..e3dbe79613 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -1056,6 +1056,20 @@ test_expect_success 'fetch with --filter=3Dblob:li=
mit=3D0' '
>  =09fetch_filter_blob_limit_zero server server
>  '
>  
> +test_expect_failure 'fetch with fsckObjects but without --lock-pack does=
 not segfault' '
> +=09rm -rf server client &&
> +=09git init server &&
> +=09test_commit -C server 1 &&
> +
> +=09git init client &&
> +=09# unpackLimit=3D1 forces to keep received pack as pack instead of
> +=09# unpacking it to loose objects. The code is currently segfaulting wh=
en
> +=09# trying to index that kept pack.
> +=09git -c fetch.fsckObjects=3Dtrue -c fetch.unpackLimit=3D1 \
> +=09    -C client fetch-pack ../server \
> +=09=09$(git -C server rev-parse refs/heads/main)
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
>  
> -- 
> 2.39.2

