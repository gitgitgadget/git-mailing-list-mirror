Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857BDC433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB672086A
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="B2cYuQjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgH1MzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:55:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:51581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbgH1MzK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598619306;
        bh=QCLP81bexoAQjiDLZ/BWVisu9EftHe+IS1+nlCT26gw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=B2cYuQjN4v9oLqop0Zo8iz56qBK0Vtz35Jr5nHZkXQAigVS0gYJlFecPIAlssOt1/
         eXJRo5h73ZJF6VZRj1OIpVJWT+1DmZRT63Hko+RqXoMmlyb9i8/0+/B4DD0UEext7P
         zifFY7WEmlpD9LgCrrvNFjw5mZ705P64yId0bPwY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.215.189]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V4J-1kbVkD0Txn-013uJ4; Fri, 28
 Aug 2020 14:55:06 +0200
Date:   Fri, 28 Aug 2020 04:15:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Henr=C3=A9_Botha?= <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] worktree: teach "repair" to fix outgoing links to
 worktrees
In-Reply-To: <20200827082129.56149-4-sunshine@sunshineco.com>
Message-ID: <nycvar.QRO.7.76.6.2008280413450.56@tvgsbejvaqbjf.bet>
References: <20200827082129.56149-1-sunshine@sunshineco.com> <20200827082129.56149-4-sunshine@sunshineco.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-50879584-1598580914=:56"
X-Provags-ID: V03:K1:dR4rSBFsLuLZyO/8x07yPJDtQF+cUayeVJtVS3o/aibu3ch89+J
 RzsGt2Bc3FmRephGaZhnoNH2nbysMVmW9l6Pj6WcCQ42PCUSHl703zq8/0aW/ekwbo17Lmk
 g2W+sE/KUbBqJcHvjPmu9ytY3o2+/S5BlJ1EY6ivFgtF8P3Hs55OzdNdlD8Gr7FDxM4GjlP
 6XliqreiTLxbtLnaLoU9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GEssbSMAZJE=:DSVA4TtRJDQTb18e0G8yv+
 h7a0Ftajc5/rlTInGZCRky+7m01WsKi2ff2GVV5cVC0VaXFTD/Nun1uJcN73XSQqO80+QXIcv
 VWbI/7kqfHbuZul31j7qbRkRjQaFYp2QNA7c98MOCmpuMF7YtNPKi9fqzJbsYrw83GX66zaBT
 TdT7GRd7dvgozMxAWvWi9fp9NFj5rRJPK37R8aqCQ8SKGd3IhV9o/04t0C8xZtLL0JDs6rxcp
 oZWX24DlyxU3NRkk0/Z6CIf4lQoXREYoJ1BG5gX0VzIFvOVvRdMS7dFWvl2/g8jAtbP2Qz4GZ
 p0Ie2B09djXBhQe6sBPs5ndrEjNU/rtVxew/odYDHQHEUZ8gyoQ3gCM7nfSAqyFzMRdOh+JCl
 olajSRx0rCIvxR2XICErPzShxY9aPcW7TCMfD35RRy5DJdYl0ScM1haVl4rpBK0Yk8hf6C8Ss
 wPp73upokwt5P8amxCahP5Wkd49QyCkfMzHutCj7XdWyRwRBb9NfkbCxs76w7rlWtaCRdznSG
 TnIyGsHiwGVrCIu4xVLlDJGCiDegtZFps3Cyf3gIaI0J1B2XyPXIM4BFllsrupYvfeunB8KRz
 XVqJnCrCMHbCGn9zdklJ9ch7pGWbUWIyaKfWgvwg1wJWVkCmo8uiL/VCfq05vTpIk8ucWfpUf
 JgNebpZq7OCiZfKJ7n9RGHHtP6OMibEkQTElQXvD8SyH/Sqoul+ujH3H160p5Wj7Yiav0cGG3
 ryiOl4cJNi2noSTOeQ8W+UOgM+lxa62N3SVrtHutECqHJVEgAEajw/ATh0w8tFyTRJF9SjMi7
 McvkC+ZA42OQwZKm9UPJzJp9kD8rm55aJPipp7VFzfBTMZ4Eq0EIh3DtCExnsAj6F43mHsb33
 vE5d8wkHJaVHWQ97rxQKPTJgk7uK1uJbgcl9c5+tptPrDu9nTaZfuDhCQYpFMOqotnEikDULa
 jxUJf4b01/cLz1+tc2XrbLMTOZF88qSC83OCf4X3sgr5VNOnRpnwynSpMRTZk7oys7bGRBd5m
 gj2jnT3CMRPE3VgiK3cwPUM135ebJZwfMjXV8cQ1KfIBTX/z96tvnyuVT61xURqwBch6C/W1r
 8yYxDgRH6GOTE7Rwo+DYHm4dS0gzRDHbp2mwasEoxRnWRXHjYZ0jQFdaqcAu8fEjZKP8n3WkU
 gnxkn2AshMFnA4DEGzhnBUfvud9A6FoemebwCxC44LsmwVe/CFXOOeB8OA+CvvB2nAgyIMZ0W
 PhN0N+U8i6hIMT2W7gt9CixxDKWt3nFYhVXIkow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-50879584-1598580914=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Thu, 27 Aug 2020, Eric Sunshine wrote:

> diff --git a/worktree.c b/worktree.c
> index 029ce91fdf..6ade4f0d8b 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -624,3 +624,77 @@ void repair_worktrees(worktree_repair_cb *cb, void =
*cb_data)
>  		repair_dotgit(*wt, cb, cb_data);
>  	free_worktrees(worktrees);
>  }
> +
> +static int is_main_worktree_path(const char *path)
> +{
> +	struct strbuf target =3D STRBUF_INIT;
> +	struct strbuf main =3D STRBUF_INIT;
> +	int cmp;
> +
> +	strbuf_add_real_path(&target, path);
> +	strbuf_strip_suffix(&target, "/.git");
> +	strbuf_add_real_path(&main, get_git_common_dir());
> +	strbuf_strip_suffix(&main, "/.git");
> +	cmp =3D fspathcmp(main.buf, target.buf);
> +
> +	strbuf_release(&main);
> +	strbuf_release(&target);
> +	return !cmp;
> +}

This breaks our `linux-gcc` job, and I need this on top, to make it even
build:

=2D- snipsnap --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] fixup??? worktree: teach "repair" to fix outgoing links t=
o worktrees

This is needed to shut up GCC's "=E2=80=98main=E2=80=99 is usually a funct=
ion
[-Werror=3Dmain]" error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 worktree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/worktree.c b/worktree.c
index 6ade4f0d8b2b..5471915d4680 100644
=2D-- a/worktree.c
+++ b/worktree.c
@@ -628,16 +628,16 @@ void repair_worktrees(worktree_repair_cb *cb, void *=
cb_data)
 static int is_main_worktree_path(const char *path)
 {
 	struct strbuf target =3D STRBUF_INIT;
-	struct strbuf main =3D STRBUF_INIT;
+	struct strbuf main_worktree =3D STRBUF_INIT;
 	int cmp;

 	strbuf_add_real_path(&target, path);
 	strbuf_strip_suffix(&target, "/.git");
-	strbuf_add_real_path(&main, get_git_common_dir());
-	strbuf_strip_suffix(&main, "/.git");
-	cmp =3D fspathcmp(main.buf, target.buf);
+	strbuf_add_real_path(&main_worktree, get_git_common_dir());
+	strbuf_strip_suffix(&main_worktree, "/.git");
+	cmp =3D fspathcmp(main_worktree.buf, target.buf);

-	strbuf_release(&main);
+	strbuf_release(&main_worktree);
 	strbuf_release(&target);
 	return !cmp;
 }
=2D-
2.28.0.windows.1

--8323328-50879584-1598580914=:56--
