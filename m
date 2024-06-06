Received: from mail187-37.suw11.mandrillapp.com (mail187-37.suw11.mandrillapp.com [198.2.187.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88EFC02
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.187.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680999; cv=none; b=pxOxXTnjIj08ydoglcAt9u2YKzxf4ctWs2G3DUESSeEFEXe3kf2Nuo7ctux9KQICPYkbRKgJWX6aFvebdmn6MYEph+5p+SQArbi0Tfh1h1+iVfdKKE2GmG7Aguw+79fnLeLDnU9B44K5misHGMW9Ofw95J3+xuLE4oMEtfU8GmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680999; c=relaxed/simple;
	bh=zV/8Vney9EGbHGIrIgFw41AMRbQK9VLiJj7c8u0/Vho=;
	h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type; b=L0nHK86AiChrryGZgv+jFqW/1Sn6nNgsqPTE6DLPajRDkuU7Zbs1c+Y9EOfCPNwVKufHPJAiZtWnVeF9BmOMyZSuiR/8vBSmYnHdotQIDmpaOHsYHFzHexSY13UmuoCpHDlsJLWolsPPPEZfezGJaFbMbOnmBb0391bOpPDxv4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexedi.com; spf=pass smtp.mailfrom=mandrillapp.mail.nexedi.com; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=LzCiiQw/; dkim=pass (2048-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b=Al57xGme; arc=none smtp.client-ip=198.2.187.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexedi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandrillapp.mail.nexedi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="LzCiiQw/";
	dkim=pass (2048-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="Al57xGme"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1717680996; x=1717941496;
	bh=OyvJLzNPWCnTnCmovniTINyXLsxQyZLosP/UnLUdelU=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=LzCiiQw//rSkaQrhOXjcBjN8v31w7B/kkp+43d3pin2B6P/bdVphS01/xEFRt9Y0y
	 JjFhuQtx4vUhAVmf+kI78sbeIYx1lOS+KRfeMEG7mE1O0LXlG4WoHgAdBYJy9iBQMc
	 S/hXzVHctPkqLLEjbk6nIwwrR2K0Wa3flnMApK4JqmJZRUobFKOf2GgF1kRqnXGT3k
	 sWjQHW/3CFTF4V53doF9X9WS+HEJm9FcPyuqjCJhA4sX6puQtb3pKKdKQcKIC1PIpr
	 /w2j7AWC2C8BrEts3It+gbBrERTRMs2yNwijNeWMtTK/ASyFvDIscEqOeex+5ibSeB
	 2ePKdLY4PU6mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexedi.com; s=mte1;
	t=1717680996; x=1717941496; i=kirr@nexedi.com;
	bh=OyvJLzNPWCnTnCmovniTINyXLsxQyZLosP/UnLUdelU=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=Al57xGmee1o61y2u/ZrIQsIIycJnTjvx/WDL8DNJ6kykeKZkGg7muRBUnlMvsiwv6
	 MF36Ul86y51gQq9xKvshCO+ABbaeZIjjpnoGH7HNNBGF6dGLYs5smk6JjoG4GMBqGt
	 NMBGdM6EyAQv8dp/fScpZiq+YfOnbPCPxbWjjOFYuI8qyFcomdi0aNvPyC2vVbN0aX
	 0oCKRViQXg2tUvmS6wtmZlK/BkZdHJ93KG79Qe/w2HI4C37gDYEakmErgStGvESSq5
	 4OnD6RqIijw8rV+7lAAT1q6BH5YeTU6v40yraoWbfbcMMN7iThx3cQnbSC8sIs3gaJ
	 RGOIsB33I43OA==
Received: from pmta09.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail187-37.suw11.mandrillapp.com (Mailchimp) with ESMTP id 4Vw52q70HPzG0CpTK
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 13:36:35 +0000 (GMT)
From: Kirill Smelkov <kirr@nexedi.com>
Subject: =?utf-8?Q?[PATCH]=20fetch-pack:=20test:=20demonstrate=20segmentation=20fault=20when=20run=20with=20fsckObjects=20but=20without=20--lock-pack?=
Received: from [87.98.221.171] by mandrillapp.com id 26d5846df54047c794c24ab00d4e23e6; Thu, 06 Jun 2024 13:36:35 +0000
X-Mailer: git-send-email 2.39.2
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@nexedi.com>, Jonathan Tan <jonathantanmy@google.com>, Alain Takoudjou <alain.takoudjou@nexedi.com>, =?utf-8?Q?J=C3=A9rome=20Perrin?= <jerome@nexedi.com>
Message-Id: <20240606133605.602276-1-kirr@nexedi.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D31050260.26d5846df54047c794c24ab00d4e23e6?=
X-Mandrill-User: md_31050260
Feedback-ID: 31050260:31050260.20240606:md
Date: Thu, 06 Jun 2024 13:36:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

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

