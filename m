Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E3AC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 11:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD4B613F1
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 11:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhFQLpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 07:45:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:56559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231386AbhFQLpq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 07:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623930214;
        bh=z5NMhbHtH5Ld4ttT7otE64qMw3yc6WXdxUgPA8MhU+Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hUOjUjRbwBUmVtX/nYZ4iv7ZPWZyVE5tAWew+31PirkifAby0VqJRm+6zg5xRen/W
         qJFkbj8W5tUyDrAfKhmRdbL0ChgFioSAqAjvqEJSSd+sMKbsqK0COC2hJL/Nxk670x
         IdVVZW093EFFjRD3HI2DTDid9JI6DgGz7DydsXwI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.214.113]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGRA-1lcrVg1n2E-00JLOL; Thu, 17
 Jun 2021 13:43:34 +0200
Date:   Thu, 17 Jun 2021 13:43:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] pager: do not unnecessarily set COLUMNS on Windows
In-Reply-To: <xmqqv96dmduh.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2106171342270.57@tvgsbejvaqbjf.bet>
References: <pull.982.git.1623701952823.gitgitgadget@gmail.com> <pull.982.v2.git.1623847092299.gitgitgadget@gmail.com> <xmqqv96dmduh.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZcGPl/IKb5Bc6CG1SU/xcvjLCdevtW/rNb/MlgRffr5z9Nv2lOS
 JWxOLfn5+hQnxcuampwTEQ+fbxMDQUknLjzmZxog9/udUl4Qif9PUd+SbHefMZkUyIRa2fF
 N4qUu6T5vnkqVtvlJn2sJO/K38pq1VcBS+qpXwcTrmMR89ZonBTgwvd5KH4C45i6ov/FazQ
 bI9BFXxkX105Lam/o9ptA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tblm5F23epg=:+3Vr7ralKNz0MeSxcNEXl2
 XVbiaglC6N50Ixg5owk1EA8Rbq5J0XPFm18CtiAhT6kHznUOxivjoIDls48Ubc+rUA5UL4SuB
 PK8Pz/RdSesPmYaYkI4hGleQMgLrLSP26NZdIs3tZ8Bbm1Oz+FkTTTdplmnAN+/0hxpzbI35L
 h8+h3CHML1GmCVaozRdTDIi4WFp+/vb+omDow7aC3kZ/F4WDl4Au/sbMRPt6KUrVV2aQy/kq9
 qrB01uy4b33TDxc0zi+gf7oJpInGp8LP4fN/YfgMIv2oEVqaCPFCOjnPiQf2i1A9Qggmi2B9G
 fMiKRdwn2sNVBVa1JGXyzZ4v1CSYgTLB0KusUhKdvLcDuF369k4clYmEa3BHy/ugzBHpEgFUb
 N7p4mwTsOtquQwBAACvjBLAaoBzFofjsIIpD6vPKAeNWhHL9L6NUDaQcaNqnjVJU/aasI/Hsb
 xRKvMOYxOXlz3yoqw1XildcU0qbt+lRIKmLtfOl9lIZo9qLtQXqVZTEIiPTs/GBSBMC1goBe/
 aZ2b7sFXK1tnU+YURqPizY2ZomvPMUMucpcHChK4ArT+lZHY/N+XbWOFynAjiO6PDqBqo6N92
 Wsj43nq403v9OcVjyK2EYpA8csz8AIS1pEKXMYfDQpluVEEEk7cEBlsOSintT63De7mmgaiC/
 KTIGMux4ekHIhgrqLyDBoLnKzC8KLKIoO9DMVIo/WbrlG+vZVfxJKJd/mabh1Z2ZVxnzfHlcd
 aAwNbYaovOswyhVQp16ylb7LFh3V/IzYiCAf3hDNgA32n+y/ENmagXSemQvezKS8IKFBOEjYd
 j+MnwTUY9VoA/Ahg966Y5IDGtSeL4sIw0/Xwizwlp+qZpqFz0wNzYzpVls52hT4dAfL41GftB
 GPqUxj2th5jXmxBKDo5oVBbZvyQBndYZfVzDMx1kggdcdvPEjm5a5M+fk9OnkPFISwcP2oCU6
 d7cCZQD6ivWhRdU/CoBpd9vWsdT/edJrJXDeCEH2iY/b3S6MhMRc+0zQeth7VjiogiO+ZI3IT
 5CJAEcSCaY4LkvH1Rlu+eFhgL92y/ajTd1wAdNFpKZUsMHDjnLjGL+wrsrulo3HNy8h/rYnJP
 x13ZpsWV1p5hRBF6h4GHZ12XmzDVqcXe+Xxp0urlZZHx6Vcmvbq4Dszug==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 17 Jun 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Since https://github.com/gwsw/less/commit/bb0ee4e76c2, `less` prefers
> > the `COLUMNS` variable over asking ncurses itself.
> >
> > This is typically not a problem because we ask `TIOCGWINSZ` in Git, to
> > determine the correct value for `COLUMNS`, and then set that environme=
nt
> > variable.
> >
> > However, on Windows it _is_ a problem. The reason is that Git for
> > Windows uses a version of `less` that relies on the MSYS2 runtime to
> > interact with the pseudo terminal (typically inside a MinTTY window,
> > which is also aware of the MSYS2 runtime). Both MinTTY and `less.exe`
> > interact with that pseudo terminal via `ioctl()` calls (which the MSYS=
2
> > runtime emulates even if there is no such thing on Windows).
> >
> > But `git.exe` itself is _not_ aware of the MSYS2 runtime, or for that
> > matter of that pseudo terminal, and has no way to call `ioctl()` or
> > `TIOCGWINSZ`.
> >
> > Therefore, `git.exe` will fall back to hard-coding 80 columns, no matt=
er
> > what the actual terminal size is.
> >
> > But `less.exe` is totally able to interact with the MSYS2 runtime and
> > would not actually require Git's help (which actually makes things
> > worse here). So let's not override `COLUMNS` on Windows.
> >
> > Note: we do this _only_ on Windows, and _only_ if `TIOCGWINSZ` is not
> > defined, to reduce any potential undesired fall-out from this patch.
> >
> > This fixes https://github.com/git-for-windows/git/issues/3235
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     pager: do not unnecessarily set COLUMNS on Windows
> >
> >     A recent upgrade of the "less" package in Git for Windows causes
> >     problems. Here is a work-around.
> >
> >     Changes since v1:
> >
> >      * The commit message was reworded to clarify the underlying issue
> >        better.
>
> Thanks for an updated log message to clarify the problem
> description.
>
> I think treating this as "less" specific band-aid is OK, but I do
> not think tying this to Windows is a good design choice.
>
> The guiding principle for this change is more like "if we do not
> know and cannot learn the true value, internally assuming 80-columns
> as a last resort fallback may be OK, but do not export it for
> consumption for other people---they cannot tell if COLUMNS=3D80 they
> see us export is because we actually measured the terminal width and
> know it to be 80, or we just punted and used a fallback default", I
> think, and there is nothing Windows-specific in there, no?
>
> In other words, if we use something like the attached as a "less
> specific band-aid" for now (i.e. direct replacement of your patch to
> fix the specific 'less' problem), and then later clean it up by
> actually returning -1 (or -80) from term_columns() as "we do not
> know" (or "we do not know---use the negation of this value as
> default"), we can help not just this paticular caller you touched,
> but all other callers of term_columns(), to make a more intelligent
> decision in the future if they wanted to.  The root of the issue I
> think is because term_columns() does not give callers to tell if its
> returned value is merely a guess.

That approach should also work. Do you want me to take custody of your
patch and issue a v3? If yes, I will mark you as co-author because the
patch is not really only mine any longer.

Ciao,
Dscho

>
>  pager.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git c/pager.c w/pager.c
> index 3d37dd7ada..52f27a6765 100644
> --- c/pager.c
> +++ w/pager.c
> @@ -11,6 +11,10 @@
>  static struct child_process pager_process =3D CHILD_PROCESS_INIT;
>  static const char *pager_program;
>
> +/* Is the value coming back from term_columns() just a guess? */
> +static int term_columns_guessed;
> +
> +
>  static void close_pager_fds(void)
>  {
>  	/* signal EOF to pager */
> @@ -114,7 +118,8 @@ void setup_pager(void)
>  	{
>  		char buf[64];
>  		xsnprintf(buf, sizeof(buf), "%d", term_columns());
> -		setenv("COLUMNS", buf, 0);
> +		if (!term_columns_guessed)
> +			setenv("COLUMNS", buf, 0);
>  	}
>
>  	setenv("GIT_PAGER_IN_USE", "true", 1);
> @@ -158,15 +163,20 @@ int term_columns(void)
>  		return term_columns_at_startup;
>
>  	term_columns_at_startup =3D 80;
> +	term_columns_guessed =3D 1;
>
>  	col_string =3D getenv("COLUMNS");
> -	if (col_string && (n_cols =3D atoi(col_string)) > 0)
> +	if (col_string && (n_cols =3D atoi(col_string)) > 0) {
>  		term_columns_at_startup =3D n_cols;
> +		term_columns_guessed =3D 0;
> +	}
>  #ifdef TIOCGWINSZ
>  	else {
>  		struct winsize ws;
> -		if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col)
> +		if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col) {
>  			term_columns_at_startup =3D ws.ws_col;
> +			term_columns_guessed =3D 0;
> +		}
>  	}
>  #endif
>
>
