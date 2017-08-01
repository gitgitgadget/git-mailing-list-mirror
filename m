Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E3AB2047F
	for <e@80x24.org>; Tue,  1 Aug 2017 18:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbdHASX5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 14:23:57 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33573 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbdHASX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 14:23:56 -0400
Received: by mail-lf0-f66.google.com with SMTP id 65so2166514lfa.0
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=2TzwtRDQJO732tj0BsjaC8cQdrm4aW/y3Za2LfWr20c=;
        b=po4cNcGJgYZ2yXCYlKueav/KJ8EyhkWUjOXU8HyeWcoQl29k2LAzqI2TdgsJWAexVE
         Cg3gOcwa6i8OfX8FT52ju3q6rgmREF1JBgPuRkanyo8OA1ok8sxoO99+u24gdv9jqDvj
         gMPRWptUr7Xbkaq+W+hKUoBZY+vYlxLa9XCjH2XT6zaRXOoXkJeg+/IQNv7j6vl9CkTY
         gPHM5qnX2Zx7W/PR/kp06H/PL1TCLE7Y8vORXkX74hZ0YSlGx2iX49aHjAXoEnhDECYm
         mGzlPSkstd75P1+BW5SuGIZF8Ysjq3NVF2wPxTCggP9Yh6KUBCcnLAXAwwi0d8oP/k0d
         4I9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=2TzwtRDQJO732tj0BsjaC8cQdrm4aW/y3Za2LfWr20c=;
        b=foSu18aOSdGYJDRyNcKvzYf+QFK1g3RpYmzDdRhMfUA5Rp7ncO2ABVMK3nwhGvBmyh
         f7v95DSQ+b3K4AioZyNTPK3wAOjB19gtT/YfvbW/r/EPMCRSB2IEUJy8jiEPqtY8idmD
         IqvaRvV6MuVIb6TGcRRKLfkxUFD2d4Suw3Us9YfHKN0/RD20yEW+aBN9i2+5IneYgjr3
         kxB1RW+5DxKsHfEdtuxuDHXPyHg1wwEaw2HxoXr5f9pC6mjQOY2PeEIkxP3JV7T1d8Zx
         k9v8KmWXiJ4qJ5mdugjQLGdoK4T5iLSlt2d11NrFhFREukfoXM13MDQXkBswYBq/5W0U
         jvwA==
X-Gm-Message-State: AIVw113ajYT5swbywmtd0NeOqfTx6Diovbna8jDUOkoLoO5GLCT3jMk1
        2sEkpINr/9GE5cUFFW6v99xDLu3khQ==
X-Received: by 10.46.22.79 with SMTP id 15mr8043057ljw.125.1501611835562; Tue,
 01 Aug 2017 11:23:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.0.131 with HTTP; Tue, 1 Aug 2017 11:23:55 -0700 (PDT)
In-Reply-To: <20160625075433.4608-9-pclouds@gmail.com>
References: <20160625075433.4608-1-pclouds@gmail.com> <20160625075433.4608-9-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 1 Aug 2017 14:23:55 -0400
X-Google-Sender-Auth: pBRRjPRPQETy6CdWhvgP7jXuZuY
Message-ID: <CAPig+cRqgzB4tiTb=fHuFBTqo3QEGM3m378PvOse06KdreKo2Q@mail.gmail.com>
Subject: Re: [PATCH 08/10] worktree: add "move" commmand
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 25, 2016 at 3:54 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> +static int move_worktree(int ac, const char **av, const char *prefix)
> +{
> + [...]
> +       if (file_exists(dst.buf))
> +               die(_("target '%s' already exists"), av[1]);
> +
> +       worktrees =3D get_worktrees();

'worktrees' is being leaked at each 'return'. Probably need to call
free_worktrees().

> +       wt =3D find_worktree(worktrees, prefix, av[0]);
> +       if (!wt)
> +               die(_("'%s' is not a working directory"), av[0]);
> +       if (is_main_worktree(wt))
> +               die(_("'%s' is a main working directory"), av[0]);
> +       if ((reason =3D is_worktree_locked(wt))) {
> +               if (*reason)
> +                       die(_("already locked, reason: %s"), reason);
> +               die(_("already locked, no reason"));

Saying "already locked" makes sense for the 'worktree locked' command,
however, for 'worktree move', a simple "locked" would be less
confusing.

> +       }
> +       if (validate_worktree(wt, 0))
> +               return -1;
> diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
> @@ -59,4 +59,34 @@ test_expect_success 'unlock worktree twice' '
> +test_expect_success 'move non-worktree' '
> +       mkdir abc &&
> +       test_must_fail git worktree move abc def
> +'
> +
> +test_expect_success 'move locked worktree' '
> +       git worktree lock source &&
> +       test_must_fail git worktree move source destination &&
> +       git worktree unlock source
> +'

Should the unlock be wrapped in a test_when_finished()?
