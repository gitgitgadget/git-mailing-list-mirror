Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8EAC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E486069E
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhG2TXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:23:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:35841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhG2TXV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 15:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627586596;
        bh=7UHHUthtJfQulJbQLFah/xOR3NbCApiudlTq2vz+eXg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RS7H0Bl2RYiGO8mLlrP2mBuS3OdTU4oltkzWtt6hnKVwl3z7YQ3Oy1aIAxhQoZoMW
         SGQrfpIoXsW+ZsWtyEmL9dRIfGKmGCad4BSPw/7zaQJw983Qm5zBnAQpuupuPs9XnV
         VYxRvBZYSIz73pl59V7DUiPhOlth2wBR8CIN36Bo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.102.245] ([89.1.212.168]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2aD-1mrddz0hKZ-00k4Fg; Thu, 29
 Jul 2021 21:23:16 +0200
Date:   Thu, 29 Jul 2021 21:23:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] mingw: align symlinks-related rmdir() behavior with
 Linux
In-Reply-To: <pull.1008.git.1627586493659.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107292122480.55@tvgsbejvaqbjf.bet>
References: <pull.1008.git.1627586493659.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1724417173-1627586602=:55"
X-Provags-ID: V03:K1:ZqDRtKNGoVycQjJ7aV5HPxRh+PZjQLGVg9tLGbUIPJGSIrppno3
 0KAoFyponZxXwiRR/eMIYUVKkK2Xa2mM04xFI+0RtxsHEPweFfYxaS2WzCnBDSO1LIn3ENh
 OCTKXfBw5g4wf4RKrCsLlAgdDfMhDtSphGJyTttpznOIbCOwuHf3N9HsWJlp4CY/95W5T3q
 VmOzRAnF3WD8cH05vwwrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3hEIfpxolq8=:YsvMTFDgSUvSuW4QToQwUG
 Q5Py/wxN3Sh3izKx1/WVP8eJlyXhI6/jvFq0oeOOgdg6XPOfP4VpLCw824OFTSUYNA7TBMd3k
 3bxICQI3xNmobEPQPgtWUJD4JVlkox0NM864zIOFRzphl+7qQWnaKWsfYbYji7YAvzVrm24G3
 Yf4rJRWjMk/Up6vvmg8kAFQyXdiRHOMb+kvfIyrUlD7MPYZt815k0EjX8cT2bFundnp5bGif5
 YH565oay4bFQItmFJ0ymO3yMZG5AqrpUeeQ02KWYfLb9byMfkhj59Qo2KHywTDhqK0dAqzoT9
 zu7IckPjW9Ee8B8H+I6N7rzRX1O5YAmFJYgSU4dZcY5tyfcVLdrWSg4oB1LPkGVuJH9hgLeou
 2zI4UjnGaPfUaziRUV6yEyE0mAa3uE93IqCS5Gl8mV+CeMQLKPcLm+TRapChzrzpyR5mPZFdz
 ORkOw1aP0BAXVjp+XnJdviBz845IkJPOvx3gxICZXWfXiGD6EJCwP3gYS0PXZ/OGcenvBkIaZ
 rujjyfk8WB2tB2efE/ch53scKkMCEd8UaC3/CQT8+QMDSYPOwDPxUihtpcG9ttWDjIU0lmVx2
 WEtab9DVlhh7Z1v7nTJMGsTLluPcUF1NNoLoueFPE1whyCttjrTEy5q8uj7ia1vL/mZwe3CMV
 7JFUUeCFV9+WCl5uEnMsSkOnMiaqu2yp4w6Y66cBenbpFaKE2XihC/qYXiHCeDdSeMb6nnRc2
 d82GuPVeo1OS4Iv/80nqG4AkPhmIHh1P2//19xjBNmIsWQrcu2ceop6FrZKT4TJFSo3tZxaqy
 kyGUwi9zLah3/ttDEDfpHIdM8E8XaepgyZwCa6lb3hBSOcKfCA8RWpydcwgM8GtAg5fEzGmhA
 eXEhLLLBICIBodEOUQ3aSPnXXEx2ZkvyMi/whW7cOHWLc4W99q5945jEckJRbU6z0Mr6N6wIi
 0MP+HQA10zBIRRsIA5Pcm9cDcE2xIYlQyJI1T64+7Kw9YSN+TyN7c+tfA34TA30LSWhGQHmml
 pvYvrapWpjUs6ONmsSlPaxHd7GfcKmV3Wr+fF1xsl8soYfRxz6PCgFdAtRnc3MsZkdj31bfkb
 bKifb8oiMo+OHco5DZblS1e4yzy9ZSkg5vrar5TVh/YHvg49Iunpz4wxQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1724417173-1627586602=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 29 Jul 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>

Sorry for missing this, this line should have read

	From: Thomas B=C3=A9tous <tomspycell@gmail.com>

Ciao,
Dscho

>
> When performing a rebase, rmdir() is called on the folder .git/logs. On
> Unix rmdir() exits without deleting anything in case .git/logs is a
> symbolic link but the equivalent functions on Windows (_rmdir, _wrmdir
> and RemoveDirectoryW) do not behave the same and remove the folder if it
> is symlinked even if it is not empty.
>
> This creates issues when folders in .git/ are symlinks which is
> especially the case when git-repo[1] is used.
>
> This commit updates mingw_rmdir() so that its behavior is the same as
> Linux rmdir() in case of symbolic links.
>
> This fixes https://github.com/git-for-windows/git/issues/2967
>
> [1]: git-repo is a python tool built on top of Git which helps manage
> many Git repositories. It stores all the .git/ folders in a central
> place by taking advantage of symbolic links.
> More information: https://gerrit.googlesource.com/git-repo/
>
> Signed-off-by: Thomas B=C3=A9tous <tomspycell@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     mingw: support the git-repo tool better
>
>     This addresses an issue, originally reported at
>     https://github.com/git-for-windows/git/issues/2967, where the git-re=
po
>     tool [https://gerrit.googlesource.com/git-repo/] replaces folders in
>     .git/ with symlinks and mingw_rmdir() erroneously removes the symlin=
k
>     target directory's contents.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1008%2=
Fdscho%2Ffix-rmdir-with-symlinks-on-windows-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1008/dsch=
o/fix-rmdir-with-symlinks-on-windows-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1008
>
>  compat/mingw.c    | 15 +++++++++++++++
>  t/t3400-rebase.sh | 10 ++++++++++
>  t/test-lib.sh     |  6 ++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index aa647b367b0..685d3efa3c0 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -341,6 +341,21 @@ int mingw_rmdir(const char *pathname)
>  {
>  	int ret, tries =3D 0;
>  	wchar_t wpathname[MAX_PATH];
> +	struct stat st;
> +
> +	/*
> +	* Contrary to Linux rmdir(), Windows' _wrmdir() and _rmdir()
> +	* will remove the directory at the path if it is a symbolic link
> +	* which leads to issues when symlinks are used in the .git folder
> +	* (in the context of git-repo for instance). So before calling _wrmdir=
()
> +	* we first check if the path is a symbolic link. If it is, we exit
> +	* and return the same error as Linux rmdir() in this case (ENOTDIR).
> +	*/
> +	if (!mingw_lstat(pathname, &st) && S_ISLNK(st.st_mode)) {
> +		errno =3D ENOTDIR;
> +		return -1;
> +	}
> +
>  	if (xutftowcs_path(wpathname, pathname) < 0)
>  		return -1;
>
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 0bb88aa982b..23dbd3c82ed 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -406,4 +406,14 @@ test_expect_success 'refuse to switch to branch che=
cked out elsewhere' '
>  	test_i18ngrep "already checked out" err
>  '
>
> +test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a =
symlink' '
> +	git checkout main &&
> +	mv .git/logs actual_logs &&
> +	cmd //c "mklink /D .git\logs ..\actual_logs" &&
> +	git rebase -f HEAD^ &&
> +	test -L .git/logs &&
> +	rm .git/logs &&
> +	mv actual_logs .git/logs
> +'
> +
>  test_done
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index adaf03543e8..73f6d645b66 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1513,6 +1513,12 @@ test_lazy_prereq SYMLINKS '
>  	ln -s x y && test -h y
>  '
>
> +test_lazy_prereq SYMLINKS_WINDOWS '
> +	# test whether symbolic links are enabled on Windows
> +	test_have_prereq MINGW &&
> +	cmd //c "mklink y x" &> /dev/null && test -h y
> +'
> +
>  test_lazy_prereq FILEMODE '
>  	test "$(git config --bool core.filemode)" =3D true
>  '
>
> base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
> --
> gitgitgadget
>
>

--8323328-1724417173-1627586602=:55--
