Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B979C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 15:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJRPWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 11:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJRPWH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 11:22:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8894832DB5
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666106522;
        bh=N9CStKkqMRXRrNWVio0lvoJW+1NNPPtG+LAzd8vMtDA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ABThse9Yc0C7UesloMssjoC3Kwt09PYEg2iGW+Aq521w45EhykN+j32zg9e2pKSHL
         GyV1H0wk5hSsQFD5shdFO6OM2FzwSHlUFRxWPMAUAcNbWwMGafloJBkHmJlraPQphg
         2VU99r5u1q2Qpli++E6gs8f2IJjWM02UGLAAcXcY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.67.214] ([213.196.212.100]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1p1emG2Gpu-00rcRG; Tue, 18
 Oct 2022 17:22:02 +0200
Date:   Tue, 18 Oct 2022 16:36:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] config: respect includes in protected config
In-Reply-To: <pull.1360.v2.git.git.1665683027912.gitgitgadget@gmail.com>
Message-ID: <s3q2n244-r05n-07n8-6902-16q098331421@tzk.qr>
References: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com> <pull.1360.v2.git.git.1665683027912.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1401193278-1666103802=:174"
X-Provags-ID: V03:K1:wlhJiH8K9bnNZvrV6m4eSeyTWGncknv406NcS4u5FXQ0oKdffAY
 k8pXZ0VYYgQGaQNuNP238jZ0CIK9JowLVdW6TbLI64C5ru+4ro8FGO+4ukJOTHS6OSo2RsC
 CMRXTT4GJFjh0K/L7kXxqW2o1sA2D7yzNyBFYKelClbsGFULvErUxK7Qr8d6r07NEqN82Vh
 vqRJblSKD0/6EaIAtRzkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YXCeE9xQYao=:ASYEr4xPqYQLBKqQmJJ5qL
 KgZty4g2HPatTChzyFQAC1ckZNmG7HxZqAptnkHySXhfJY7lZmTKVOHDX71ZlXuVeFqCXhweG
 W3WKyzpDkjJE0X4t+ZOpZssVoiTLYo+2ImRJk8nfHclbqGidiiPxuoriHwFCyKG66JAfe5u/x
 RW7/6wzJZfisP1nRHhnuXgJZKzAZ9aZgHXwnUwkRLJxyuAj0iBb1OreF0YP8xIuJqOe9cv/hw
 LYbMLntOoqtmB29voRRfjFmQNeWtS3tPaleXxWotT6jHrfl7RKFXns7BqIv9SxGd1zJE5jYQI
 CXtbN0RC1hXFmpfUrJdQoIJcePehkNzJjw6FSBRzwgkGn70p9oNIwAKBIcfqgEuqpK0qGwJmR
 1ZVYOiuQr6pIqgDm0cV+TYzEFijw+X2jTWo2FDcrz+IlaCNhKw301OMi6IY1mVTsh7QFkEFa5
 8JwcLpShSRXhssvKwwlA+1kLO8nkaeiqy8mzlc0hbP7c/UNGDcTnyiL/t561QSD0qIpmpM9zi
 T1FkI2TGRyMA7pTgH3cj9hXOwDCe3kG9KVjz4S1l06MxCD26XIn5BiIT4k4Z4nMoLpaDl7lU/
 l+nbL5A8XJlQsDQ6h/NlNfFfJepBbf5T55+XZ0Czci+zH2OSOySmDTWRpw8ZIVfeSGEUcWUZQ
 02AVlgUt0aU04cyCX+Ghe+WE9gxClC7asetfcrunOrGeffF4JHE6Yz4hAbkrISHu7UhPyNciM
 8B1Y81guO8td5QnwbHd4RL5H6sunvXq36OR+2neH2hL4K2MEBvUh8JhaHiK7C4VnyBj3mibyz
 L3CICgV3e+HXcphJI2NwCLX3C21G+nGzBeCaoaMd05epjy+3fQgCCsbIxih/ChBa/yiM/Twa+
 O/igZYSdh9R5f0kjb1WAyIIzepIptLD8hIy48jDGMXZmgZoJkZ4pm0BaosXeQkoXBSA7PAzBZ
 UHWRRkWcqu9Gy9Y74e8pdp6BMKOa0UfhIfgoqiddVcJYJjApdjEJuLvXxbBAtq+pNr8+IhO2h
 7beg0/eKFU1mPmRT8tWcBvoWceBWQdSUtzQ985e2mQd1jTLJ243jcxobr02vFUe/E+ZOP7ZA3
 WYcKP1LklzdXQ6B3B3DVZ7PvspkCKTyeNXfUZ3GaKC1Ge1Wzva2HvJ/XvzjkoAAEYSNsRkQRJ
 HVQfOmkNvQdhu/fwQLg5VOjgsODOG9akdQHd3YuwvRoQ6P954NmW01f6Kngg8tB/1IplPNFfN
 j/CxXKFWQ00ptCCOqAXCGHonQ4XV2UwHf8bzJGPk8FVHLF67ZkqAKxXjvTsPJnr3QGH0QIOVS
 MtkapGGS/x+csL6H3/ySsvvCecpZYCg6AUpf66HoUd/kWFKAP1ghPMwBaz6uwrXnHh7FQa+FE
 7/jdaSDM8yb827z9CgNTdXruYRxZCYIVg0Vi7Ex3ykGEhvXd/5YCgmdtKYmmNntRJmtdpJ9W/
 OdQMGExzhCdrrMrHNix+SrKvL/sjtTI0K4GL5cE4NTrVxObMSJh/UvpALMyEHUMZlrMWrPcAc
 qRwY6YoDuGQmZw9nijUWVXVPWaMUxY2vNd7W8Napkkuv6TjcVscQIy8HbBIFKaK/4wA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1401193278-1666103802=:174
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Glen,

On Thu, 13 Oct 2022, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>
>
> Protected config is implemented by reading a fixed set of paths,
> which ignores config [include]-s. Replace this implementation with a
> call to config_with_options(), which handles [include]-s and saves us
> from duplicating the logic of 1) identifying which paths to read and 2)
> reading command line config.

After reading the patch, I agree that this is the right thing to do.

Thank you,
Dscho

>
> As a result, git_configset_add_parameters() is unused, so remove it. It
> was introduced alongside protected config in 5b3c650777 (config: learn
> `git_protected_config()`, 2022-07-14) as a way to handle command line
> config.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>     [2.38 regression] config: respect includes in protected config
>
>     Thanks for the quick response, all :)
>
>     Changes in v2:
>
>      * Squash patches together (per Junio's comments)
>      * Use <<-\EOF (per =C3=86var's comments)
>
>     Cc: Derrick Stolee derrickstolee@github.com Cc: Taylor Blau
>     me@ttaylorr.com Cc: Johannes Schindelin Johannes.Schindelin@gmx.de C=
c:
>     Junio C Hamano gitster@pobox.com Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason
>     avarab@gmail.com
>
>     [1]
>     https://lore.kernel.org/git/CAPWNY8W_Tr-WoD-GXBddD5Y8w5Y4w+gDNYQdOAJ=
1uBwVHuRrsQ@mail.gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-13=
60%2Fchooglen%2Fprotected-config%2Frespect-includes-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1360/=
chooglen/protected-config/respect-includes-v2
> Pull-Request: https://github.com/git/git/pull/1360
>
> Range-diff vs v1:
>
>  1:  8c0f40aed7e < -:  ----------- t0033, t0035: test for included confi=
g
>  2:  0ff5b5741a5 ! 1:  5c398a7f72a config: respect includes in protected=
 config
>      @@ t/t0033-safe-directory.sh: test_expect_success 'safe.directory=
=3D*, but is reset'
>        	expect_rejected_dir
>        '
>
>      --test_expect_failure 'safe.directory in included file' '
>       +test_expect_success 'safe.directory in included file' '
>      - 	cat >gitconfig-include <<-EOF &&
>      - 	[safe]
>      - 		directory =3D "$(pwd)"
>      ++	cat >gitconfig-include <<-EOF &&
>      ++	[safe]
>      ++		directory =3D "$(pwd)"
>      ++	EOF
>      ++	git config --global --add include.path "$(pwd)/gitconfig-include=
" &&
>      ++	git status
>      ++'
>      ++
>      + test_done
>
>        ## t/t0035-safe-bare-repository.sh ##
>       @@ t/t0035-safe-bare-repository.sh: test_expect_success 'safe.bare=
Repository on the command line' '
>        		-c safe.bareRepository=3Dall
>        '
>
>      --test_expect_failure 'safe.bareRepository in included file' '
>       +test_expect_success 'safe.bareRepository in included file' '
>      - 	cat >gitconfig-include <<-EOF &&
>      - 	[safe]
>      - 		bareRepository =3D explicit
>      ++	cat >gitconfig-include <<-\EOF &&
>      ++	[safe]
>      ++		bareRepository =3D explicit
>      ++	EOF
>      ++	git config --global --add include.path "$(pwd)/gitconfig-include=
" &&
>      ++	expect_rejected -C outer-repo/bare-repo
>      ++'
>      ++
>      + test_done
>
>
>  config.c                        | 30 ++++++++----------------------
>  t/t0033-safe-directory.sh       |  9 +++++++++
>  t/t0035-safe-bare-repository.sh |  9 +++++++++
>  3 files changed, 26 insertions(+), 22 deletions(-)
>
> diff --git a/config.c b/config.c
> index cbb5a3bab74..c157fb5ae3f 100644
> --- a/config.c
> +++ b/config.c
> @@ -2392,11 +2392,6 @@ int git_configset_add_file(struct config_set *cs,=
 const char *filename)
>  	return git_config_from_file(config_set_callback, filename, cs);
>  }
>
> -int git_configset_add_parameters(struct config_set *cs)
> -{
> -	return git_config_from_parameters(config_set_callback, cs);
> -}
> -
>  int git_configset_get_value(struct config_set *cs, const char *key, con=
st char **value)
>  {
>  	const struct string_list *values =3D NULL;
> @@ -2641,24 +2636,15 @@ int repo_config_get_pathname(struct repository *=
repo,
>  /* Read values into protected_config. */
>  static void read_protected_config(void)
>  {
> -	char *xdg_config =3D NULL, *user_config =3D NULL, *system_config =3D N=
ULL;
> -
> +	struct config_options opts =3D {
> +		.respect_includes =3D 1,
> +		.ignore_repo =3D 1,
> +		.ignore_worktree =3D 1,
> +		.system_gently =3D 1,
> +	};
>  	git_configset_init(&protected_config);
> -
> -	system_config =3D git_system_config();
> -	git_global_config(&user_config, &xdg_config);
> -
> -	if (system_config)
> -		git_configset_add_file(&protected_config, system_config);
> -	if (xdg_config)
> -		git_configset_add_file(&protected_config, xdg_config);
> -	if (user_config)
> -		git_configset_add_file(&protected_config, user_config);
> -	git_configset_add_parameters(&protected_config);
> -
> -	free(system_config);
> -	free(xdg_config);
> -	free(user_config);
> +	config_with_options(config_set_callback, &protected_config,
> +			    NULL, &opts);
>  }
>
>  void git_protected_config(config_fn_t fn, void *data)
> diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
> index aecb308cf66..dc3496897ab 100755
> --- a/t/t0033-safe-directory.sh
> +++ b/t/t0033-safe-directory.sh
> @@ -71,4 +71,13 @@ test_expect_success 'safe.directory=3D*, but is reset=
' '
>  	expect_rejected_dir
>  '
>
> +test_expect_success 'safe.directory in included file' '
> +	cat >gitconfig-include <<-EOF &&
> +	[safe]
> +		directory =3D "$(pwd)"
> +	EOF
> +	git config --global --add include.path "$(pwd)/gitconfig-include" &&
> +	git status
> +'
> +
>  test_done
> diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-reposit=
ory.sh
> index ecbdc8238db..11c15a48aab 100755
> --- a/t/t0035-safe-bare-repository.sh
> +++ b/t/t0035-safe-bare-repository.sh
> @@ -51,4 +51,13 @@ test_expect_success 'safe.bareRepository on the comma=
nd line' '
>  		-c safe.bareRepository=3Dall
>  '
>
> +test_expect_success 'safe.bareRepository in included file' '
> +	cat >gitconfig-include <<-\EOF &&
> +	[safe]
> +		bareRepository =3D explicit
> +	EOF
> +	git config --global --add include.path "$(pwd)/gitconfig-include" &&
> +	expect_rejected -C outer-repo/bare-repo
> +'
> +
>  test_done
>
> base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
> --
> gitgitgadget
>

--8323328-1401193278-1666103802=:174--
