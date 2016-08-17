Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594001FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 13:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbcHQNOn (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 09:14:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35335 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbcHQNOm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 09:14:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so24051490wmg.2
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 06:14:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+hBUDVhtwdRyb/n36J9smfjNHfmrAttavCZx90k7RwE=;
        b=vWHgcHLfLXc+zKjQ2DXvm5H+9z1Hb7EGgbvQRqev/UCnWFWM8el14iA6Uuh9c08H3J
         datHRQjih264o6ifm2JNMwCKq+UktjN5fIEdgsQw3uePPsW1VZ/jS4KzHjpCBbQIJFcl
         iTZNw7ZJPKKXvw3shFZQuGQaD/h0Vp0K2HLVflJnzWp3XSXBzkv+olhPb17KbyV6tbN/
         d/chM5aRyg7+xMdLMA33RutLNVum/N8WucDG3W8zRe2gSsK9a2Qxp9st2JymoqpJf5/C
         M/4ttBpZTSQ604EQTuALWc+FWyRgTw62phMcCKPjIQdqKbDDiY2WP+7oIA83eyaQ77U5
         C3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+hBUDVhtwdRyb/n36J9smfjNHfmrAttavCZx90k7RwE=;
        b=OI10TSr99hUuiWTF1ibdE4AOhOq2VZc4PNQ5fbszcm+J0UgJJXaIqOA+yS/EAQYvVM
         ZExGb06BBPHZ9vVFjla+yIdtZIuhLFYngIRhIykJhhg5kiJCMzYQwcFoXNxVeGDXRnOu
         Dr2rFFUKq1LSAdIY7Eg4GHuuUmn305MTNblruAwGhjSZWj28xeOVzAycnaWvIsmn8q2l
         iLt/09PXXaIek2RCL6YJII9Zl+MuUGflKHYopmszksBudDSI/M15mhaq513gy3yZFZdc
         aRMdCGszt1hiEXBWC1U5Ixm0QyWx2GUcT9GzuASfA8OYEyBfogJgORDuxpRVU+smUqIa
         81UQ==
X-Gm-Message-State: AEkoouuy/yYSEcMlzWJUpqphEaihV9CiQDps4Ol6L7gb7wGGBNan4Sp8ynrKtjPbbxx7WA==
X-Received: by 10.28.198.142 with SMTP id w136mr20063174wmf.30.1471439680975;
        Wed, 17 Aug 2016 06:14:40 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id c8sm31619034wjm.19.2016.08.17.06.14.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Aug 2016 06:14:40 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] mingw: ensure temporary file handles are not inherited by child processes
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de>
Date:	Wed, 17 Aug 2016 15:14:37 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, Ben Wijen <ben@wijen.net>,
	Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4432DA7E-EDBB-4749-88F8-395CC7D9763D@gmail.com>
References: <cover.1471437637.git.johannes.schindelin@gmx.de> <77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 17 Aug 2016, at 14:41, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> From: Ben Wijen <ben@wijen.net>
>=20
> When the index is locked and child processes inherit the handle to
> said lock and the parent process wants to remove the lock before the
> child process exits, on Windows there is a problem: it won't work
> because files cannot be deleted if a process holds a handle on them.
> The symptom:
>=20
>    Rename from 'xxx/.git/index.lock' to 'xxx/.git/index' failed.
>    Should I try again? (y/n)
>=20
> Spawning child processes with bInheritHandles=3D=3DFALSE would not =
work
> because no file handles would be inherited, not even the hStdXxx
> handles in STARTUPINFO (stdin/stdout/stderr).
>=20
> Opening every file with O_NOINHERIT does not work, either, as e.g.
> git-upload-pack expects inherited file handles.
>=20
> This leaves us with the only way out: creating temp files with the
> O_NOINHERIT flag. This flag is Windows-specific, however. For our
> purposes, it is equivalent our purposes) to O_CLOEXEC (which does not
> exist on Windows), so let's just open temporary files with the
> O_CLOEXEC flag and map that flag to O_NOINHERIT on Windows.
>=20
> This fixes the test that we just introduced to demonstrate the =
problem.
>=20
> Signed-off-by: Ben Wijen <ben@wijen.net>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> compat/mingw.h        | 4 ++++
> t/t6026-merge-attr.sh | 2 +-
> tempfile.c            | 2 +-
> 3 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 95e128f..753e641 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -67,6 +67,10 @@ typedef int pid_t;
> #define F_SETFD 2
> #define FD_CLOEXEC 0x1
>=20
> +#if !defined O_CLOEXEC && defined O_NOINHERIT
> +#define O_CLOEXEC	O_NOINHERIT
> +#endif
> +
> #ifndef EAFNOSUPPORT
> #define EAFNOSUPPORT WSAEAFNOSUPPORT
> #endif
> diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
> index 3d28c78..dd8f88d 100755
> --- a/t/t6026-merge-attr.sh
> +++ b/t/t6026-merge-attr.sh
> @@ -181,7 +181,7 @@ test_expect_success 'up-to-date merge without =
common ancestor' '
> 	)
> '
>=20
> -test_expect_success !MINGW 'custom merge does not lock index' '
> +test_expect_success 'custom merge does not lock index' '
> 	git reset --hard anchor &&
> 	write_script sleep-one-second.sh <<-\EOF &&
> 		sleep 1 &
> diff --git a/tempfile.c b/tempfile.c
> index 0af7ebf..db3981d 100644
> --- a/tempfile.c
> +++ b/tempfile.c
> @@ -120,7 +120,7 @@ int create_tempfile(struct tempfile *tempfile, =
const char *path)
> 	prepare_tempfile_object(tempfile);
>=20
> 	strbuf_add_absolute_path(&tempfile->filename, path);
> -	tempfile->fd =3D open(tempfile->filename.buf, O_RDWR | O_CREAT | =
O_EXCL, 0666);
> +	tempfile->fd =3D open(tempfile->filename.buf, O_RDWR | O_CREAT | =
O_EXCL | O_CLOEXEC, 0666);

This solution works great for me. I struggled with a similar problem=20
in my Git filter protocol series:
=
http://public-inbox.org/git/20160810130411.12419-16-larsxschneider@gmail.c=
om/

I also tried selectively disabling inheritance for file handles but it =
looks like
as this is not easily possible right now:=20
https://github.com/git-for-windows/git/issues/770#issuecomment-238816331

- Lars=
