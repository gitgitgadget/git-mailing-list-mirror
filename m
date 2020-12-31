Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42A3C433E0
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 07:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8576822288
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 07:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgLaHXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 02:23:41 -0500
Received: from mout.web.de ([212.227.15.3]:40969 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgLaHXl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 02:23:41 -0500
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Dec 2020 02:23:40 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1609399309;
        bh=ciGTNggFKFzLO3t9vuP3Wm87vitzLItst3av/41Rggs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=eP/4883/BkRd31+Fo8VwmPrtMI77lpTQsHt6JO+zoY1P9cz2++PtNt/hjMGemfcFQ
         WCum+DOUPJH+2IqB13bRJM5j9bbu29DSHRMwtqQ7OLVsn4lh++UbYN7GCkEe4nmI9T
         WBr3gfNQ0vtJNqPSCxFqOP8H7O2r4YDYrTLhZPrw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LpfJW-1kPeCW1tyw-00fUtc; Thu, 31
 Dec 2020 08:13:58 +0100
Date:   Thu, 31 Dec 2020 08:13:58 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Dan Moseley <Dan.Moseley@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-mv: fix git mv bug with case insensitive fs
Message-ID: <20201231071357.mtcxmoxbg6jrq3gn@tb-raspi4>
References: <BYAPR21MB1158F64E1141453F7D00B46CE0D89@BYAPR21MB1158.namprd21.prod.outlook.com>
 <BYAPR21MB11585FFD46DEE7AD4EEEFEABE0D89@BYAPR21MB1158.namprd21.prod.outlook.com>
 <BYAPR21MB1158D9E88C96D51259A0CC04E0D89@BYAPR21MB1158.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <BYAPR21MB1158D9E88C96D51259A0CC04E0D89@BYAPR21MB1158.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:9JCX/S6RTPfxxXsj8RdRs+OxPaA474isx/cm+eajb/q/HaOddZu
 F5x1MP0BYgEeIHCFEUFilyu0D5HnTXhc4TSmkCUiHhTVHcJis+zp2jSCA0B7amAP1ltEwuK
 vznArIxq542StKfxd6CthJeie2ir2oymBoZDgBqA8i4LXNPVjSHNURLNnPuRHkUhXPpzGdm
 JFs8pm8Vep4BYmLOzMkzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sIixyynIyKQ=:a5BulSbWGWfzFg4ECynA5M
 +VaO0C8ukyEP68Zh4ylst5ZeFcxZKX3OFHwoIg44YXGqQrc0O/vkcnCDSGihZyEgGFqooP1wh
 5OvA949TH2sZ91UaY5mzvj/StIh5dTGhKhU0AcP5HcnOKuLXULWpUbwRmBZwcBgl5gO0cHnWu
 PawNqoKpHcjT7y0ElceBpI3nyGpiO9IPp6R0IUk6rqzgasvyhjCyz1PgYKs6Nb8Sl5z4HaQp0
 BiIFPl73M3FVkwWgX6WM4Ju/7fHrNub3nvcaZb3mwnYOks/RxFgMH0QGxR2eUhjLYQ52Eitdg
 Ps+sz0L/mKVNdNKI997OKotW6aISSYCJZcsiKvxu6Xvc+xn4DTC58NOM5Ua4vjSzj2RA5QbFC
 fadLPboKjRN16XPPXwdQdj9+rYDdzM6/w9KkJrtlc8EgrsO0LSqGfAWiTro7ZV5zcwQ/4/PtA
 ke1sQ+OgNMgj2iUsuXRjahVmEpu9JVJm1fOet1eWzi6iSVf/aI2amJcTmlrf5tH6sPkxVrlUu
 sl2zvN0yuqxd+1YYsSw22QT34NAkeDH9QI1qXdrUXVP08KY9c1tGjJqRpDQR5Nr36TE4ANMne
 ayD/bC08IvoZSJh4oX5TFABIC5ghuxZVTQO/LcBXzUae1+nI6YWeTtTA2Ay4IJMyumnjZ9RH+
 DL9UJEgOi7fgp/kcrQC8ukAAiMFMorHbJVm+LzzRn+Ehakyze1UlmdlCHXQnjGGcxyaAlEoXg
 QTRR3sMnkzl9RobmN5hWjLUl/6vkU6+M4wNyO5iGZvqwSKOhwNSqtz3qiKiDFBu3DGf/HPgo3
 ilZAESUJk4ycw3LmwpVmhKzNvuLnLpSB8+quBRTx21huPYpuOyeWGhPbgVJGfbOPEH/RH5Id1
 pkOAL2SBW6OBffA3L0ug==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 29, 2020 at 02:06:37AM +0000, Dan Moseley wrote:

First of all, thanks for submitting this to git.git.
I take the freedom to add some comments here.

> Fix git mv to not assert when src is already in the index under a
> different casing, core.caseInsensitive=3Dtrue, and the file system
> is case insensitive.
The config variable is named core.ignorecase

Does it make sense to illustrate the use case here, like this:

 git init
 echo foo >foo
 git add foo
 git mv foo FOO
 git mv foo bar

>
> Since 9b906af657 the check that git mv does to ensure the src is in the
> cache respects caseInsensitive. As a result git mv allows a move from a
> file that has a different case in the index than it does on disk.
> After the rename on disk, git mv fails to find the file in the cache
> in order to rename it in the index, and asserts.
> Assertion failed: pos >=3D 0, file builtin/mv.c, line 295
>
> This is the simplest possible fix, suggested by @tboegi. It does leave
> the file renamed on disk, but that is easy to reverse after the error.

We can expand the short-ish "@tboegi" into a "Helped-by" line, please see =
below.
And refrase the paragraf like this:

This is the simplest possible fix, it avoids to leaving a .git/index.lock
behind.  It does leave the file renamed on disk,
but that is easy to reverse after the error.

>
> Another option would be to change the aforementioned check to always
> be case sensitive, but I am not sure whether there is a scenario where
> it is useful to be insensitive.

The intention of 9b906af657
Author: Chris Torek <chris.torek@gmail.com>
Date:   Mon Jul 20 06:17:52 2020 +0000
    git-mv: improve error message for conflicted file

was to give the user better and more helpful error messages.

Some background:
A case-insensitive file system does the same for
lstat("foo") or lstat("FOO"), but Git records only one case,
which is "FOO" after the `git mv foo FOO`

In that sense, replacing
cache_file_exists(src, length, ignore_case)
with
cache_file_exists(src, length, 0)
would be the correct solution (and an even simpler patch).

Doing so would give the error message
"not under version control"
when doing `git mv foo bar` after `git mv foo FOO`
I think, that this is technically correct, the user has just asked
to track "FOO", and "foo" is not in the repo any more.

A (may be) more helpful  message could be achieved by something like this
(white space dmaged) diff. Any thoughts, if this is really helpful ?

 diff --git a/builtin/mv.c b/builtin/mv.c
 index 7dac714af9..8572a5dae0 100644
 --- a/builtin/mv.c
 +++ b/builtin/mv.c
 @@ -221,8 +221,11 @@ int cmd_mv(int argc, const char **argv, const char *=
prefix)
                                 }
                                 argc +=3D last - first;
                         }
 -               } else if (!(ce =3D cache_file_exists(src, length, ignore=
_case))) {
 -                       bad =3D _("not under version control");
 +               } else if (!(ce =3D cache_file_exists(src, length, 0))) {
 +                       if (cache_file_exists(src, length, ignore_case))
 +                               bad =3D _("not under version control (upp=
er/lower mixup)");
 +                       else
 +                               bad =3D _("not under version control");
                 } else if (ce_stage(ce)) {
 	                        bad =3D _("conflicted");
                 } else if (lstat(dst, &st) =3D=3D 0 &&



>
> Signed-off-by: Dan Moseley <danmose@microsoft.com>
If you want, add a
Helped-by Torsten B=F6gershausen <tboegi@web.de>

> ---
> Originally reported in https://github.com/git-for-windows/git/issues/292=
0
> but this is not specific to Windows.
>
>  builtin/mv.c  | 6 ++++--
>  t/t7001-mv.sh | 8 ++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c index 7dac714af9..e1fd8a5e00 10=
0644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -292,8 +292,10 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
>                         continue;
>
>                 pos =3D cache_name_pos(src, strlen(src));
> -               assert(pos >=3D 0);
> -               rename_cache_entry_at(pos, dst);
> +               if (pos >=3D 0)
> +                       rename_cache_entry_at(pos, dst);
> +               else if (!ignore_errors)
> +                       die(_("bad source: source=3D%s, destination=3D%s=
"),
> + src, dst);
>         }
>
>         if (gitmodules_modified)
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh index 63d5f41a12..5c7fee9bd8 =
100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -152,6 +152,14 @@ test_expect_success \
>      'move into "."' \
>      'git mv path1/path2/ .'
>
> +test_expect_success \
> +    'fail to move file already in index under different cased name' \
> +    'echo 1 > foo &&
> +     git add foo &&
> +     git commit -m add_file -- foo &&
> +     git mv foo FOO &&
> +     test_expect_code 128 git mv foo BAR'
As discussed on Github: Is this the right code to test that the
code does not assert(). I dont know.
> +
>  test_expect_success "Michael Cassar's test case" '
>         rm -fr .git papers partA &&
>         git init &&
> --
> 2.25.1
>
