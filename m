Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0F9C33CA1
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 10:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775E02072B
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 10:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bWeQwLEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgBEKhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 05:37:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:49525 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbgBEKhk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 05:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580899057;
        bh=A7/kN1pUAzSNeiF29+0/NbD5wzLuqxb42FuP6CsRXGs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bWeQwLEIuH2HEwELYpyZL0xeiOzkfHMDVmBOlrKI+azBbIlvmqPTBcoHgbLmmSbQu
         hZDhUX8KecHlgU/GwTI5UvO4sZmtcOoYEePEhQpvViDm/y9OAGp3vqemLdzFDwQyIc
         YHmh5PlKlPdFucn+Q2WJOrAQEG4SsCzJoxBnm1Ug=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42nY-1izI3t1ioy-0006NW; Wed, 05
 Feb 2020 11:37:37 +0100
Date:   Wed, 5 Feb 2020 11:37:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Markus Klein via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Markus Klein <masmiseim@gmx.de>,
        Markus Klein <masmiseim@gmx.de>
Subject: Re: [PATCH v2] clone: use submodules.recurse option for automatically
 clone submodules
In-Reply-To: <pull.695.v2.git.git.1580851963616.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002051136310.46@tvgsbejvaqbjf.bet>
References: <pull.695.git.git.1580505092071.gitgitgadget@gmail.com> <pull.695.v2.git.git.1580851963616.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1982473641-1580899056=:46"
X-Provags-ID: V03:K1:ibIx9IDtzCdSnKK9ovRsqfj/QSINFUITvEuIypmCq3/jyOkBvZj
 nb3qZykwEqQ87uSzQetfk+fMyrCV1R28kvOTNXzVG1u1T2qLt5ZMCZqKKkt9z24G81dj20j
 SgaRfau0w/XqyeyqIrddoGZHN6ainWH1vF+0TqkjQ7mydyy1+RgFNVRDdahdR8R89ijKHU/
 YEObdJ57+Jt1Z4Ok7MVuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6V2tf81+LYI=:puyjBIHXKPlp4VBqsI+uMh
 lJ5bwRYCRmBXxEhHFWzWlYMg/DyOkNkDZKvp1iHAycCyWBw0RZVlydb2qYX7xUwe9WCOPXRbZ
 OG7iZDVyOi/P6aRPIvojUFrGSwpqwQchX1TJFezvt3eD9seeAD8eIJd4aFaDwWkXRInfLKN+V
 V2FyII5lHHCmxHCIHcCbZjTNVWATio9U9CJP52YsAZIU+0CQlDt1Aorg1Dli1CitAYlVBZuJJ
 dS1+q1qBIRakglDWbpSms117/Wofg16vjqedqeA8kmqCimXC7k3ekUAEPUzeqp/Od1IHOVf75
 k3OXQ1aDvfepmx6KD03sIuX5N7nXtZ9N2YMjjgtyLZ8tSGHkEPJSobpdeZntNAC05oZe3M/ma
 Hi2x2/nS9M9aZWFX95Us+NtvmOYFw0wdADqj6OJRscl0S5hr51S4N3LA+9R5Y5GLGTDKx/idW
 lbsoceSGtjLxHPvfiNNcNw+9fB+uILqk63Uhl8kUGwN2P36r3XuZGr1P5yJtJuvVNzEow566T
 PJsEXwZ4t/+bVVbFaXAfTC0jP3rNBS3S2WoGcJk2QW2w1+ZkBGmJkqu59PSehUW6hfy1Dku8P
 uQlzaCY8bgUdTo624Ey09v63oMCP3VCTRiHdPMOY41Gxxoo3erFXZ98CmciOxx5Sp1SIXFsn7
 TDbFPYl5fPpKeTzoj45JB/6EHaU5MrJpvIoV7WL/cNjNqzpdwwNw02EEnVQpVhESIRmd4JXUx
 ZmyOXvbN9eZDOhyyjjikenNRetpGXDLHm9UfFhsdFLCgD8QWEDIe7Qht0QZBmrw0bYl8PCnkD
 asUmeLaB2NwhEQWbDcv6iVfwN8CH/38bB8kTVmi4EA9LbP2VFrex7ZfvvWxL09brwfcw8InnP
 dyoNfnw0xH8Hgv0YkFZLvhBokjFj+S5FWIJe7HyY3keoY4YXCIZ/UCHdDSYRj36s581B37FbX
 51UrwEHN/druMwfnM0B5H5uCvRJ2LS/ZPVN8lAJR1kQXnFMvLHGI8TRnzK4ad732oynznxLLc
 ron8XIpNjT4+RlbfTmXGcErt8zMrhycr3sy2E+Fdvcoqb/Qmm8IXDLuOsstNsExXOKfKmwVXd
 f5S2HLCP0F4JCoXVusj1DGgo5ZTGkB45EwZMPqC5JUewXLWLjDFVAOHFOp/Bt8RWN/QYthrYd
 NZBuk3jSfwWBtAEcsSbU6mJBT6BvNi1u+qv8xA5t+Nf2zGAvgAIBbiMHf91NvBJAgXsDpVpdw
 kY52lbYg+bwkwN4C3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1982473641-1580899056=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Tue, 4 Feb 2020, Markus Klein via GitGitGadget wrote:

> From: Markus Klein <masmiseim@gmx.de>
>
> Simplify cloning repositories with submodules when the option
> submodules.recurse is set by the user. This makes it transparent to the
> user if submodules are used. The user doesn=E2=80=99t have to know if he=
 has to add
> an extra parameter to get the full project including the used submodules=
.
> This makes clone behave identical to other commands like fetch, pull,
> checkout, ... which include the submodules automatically if this option =
is
> set.
>
> It is implemented analog to the pull command by using an own config
> function instead of using just the default config. In contrast to the pu=
ll
> command, the submodule.recurse state is saved as an array of strings as =
it
> can take an optionally pathspec argument which describes which submodule=
s
> should be recursively initialized and cloned. To recursively initialize =
and
> clone all submodules a pathspec of "." has to be used.
> The regression test is simplified compared to the test for "git clone
> --recursive" as the general functionality is already checked there.
>
> Changes since v1:
> * Fixed the commit author to match the Signed-off-by line

This changelog should go...

>
> Signed-off-by: Markus Klein <masmiseim@gmx.de>
> ---

... after the `---`. I.e. it should go into the PR description (which is
the first comment on the PR) instead of the commit message.

Ciao,
Johannes

>     Add the usage of the submodules.recurse parameter on clone
>
>     I try to finish the pullrequest #573 from Maddimax. This adds the us=
age
>     of the submodules.recurse parameter on clone
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-69=
5%2FMasmiseim36%2Fdev%2FCloneWithSubmodule-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-695/M=
asmiseim36/dev/CloneWithSubmodule-v2
> Pull-Request: https://github.com/git/git/pull/695
>
> Range-diff vs v1:
>
>  1:  7fa8d19faf ! 1:  c75835268a clone: use submodules.recurse option fo=
r automatically clone submodules
>      @@ -1,4 +1,4 @@
>      -Author: Markus <masmiseim@gmx.de>
>      +Author: Markus Klein <masmiseim@gmx.de>
>
>           clone: use submodules.recurse option for automatically clone s=
ubmodules
>
>      @@ -19,6 +19,9 @@
>           The regression test is simplified compared to the test for "gi=
t clone
>           --recursive" as the general functionality is already checked t=
here.
>
>      +    Changes since v1:
>      +    * Fixed the commit author to match the Signed-off-by line
>      +
>           Signed-off-by: Markus Klein <masmiseim@gmx.de>
>
>        diff --git a/builtin/clone.c b/builtin/clone.c
>
>
>  builtin/clone.c              | 16 +++++++++++++++-
>  t/t7407-submodule-foreach.sh | 11 +++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 0fc89ae2b9..21b9d927a2 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -26,6 +26,8 @@
>  #include "dir-iterator.h"
>  #include "iterator.h"
>  #include "sigchain.h"
> +#include "submodule-config.h"
> +#include "submodule.h"
>  #include "branch.h"
>  #include "remote.h"
>  #include "run-command.h"
> @@ -929,6 +931,18 @@ static int path_exists(const char *path)
>  	return !stat(path, &sb);
>  }
>
> +/**
> + * Read config variables.
> + */
> +static int git_clone_config(const char *var, const char *value, void *c=
b)
> +{
> +	if (!strcmp(var, "submodule.recurse") && git_config_bool(var, value)) =
{
> +		string_list_append(&option_recurse_submodules, "true");
> +		return 0;
> +	}
> +	return git_default_config(var, value, cb);
> +}
> +
>  int cmd_clone(int argc, const char **argv, const char *prefix)
>  {
>  	int is_bundle =3D 0, is_local;
> @@ -1103,7 +1117,7 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
>
>  	write_config(&option_config);
>
> -	git_config(git_default_config, NULL);
> +	git_config(git_clone_config, NULL);
>
>  	if (option_bare) {
>  		if (option_mirror)
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 6b2aa917e1..44b32f7b27 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -383,6 +383,17 @@ test_expect_success 'use "update --recursive nested=
1" to checkout all submodules
>  		git rev-parse --resolve-git-dir nested1/nested2/nested3/submodule/.gi=
t
>  	)
>  '
> +test_expect_success 'use "git clone" with submodule.recurse=3Dtrue to c=
heckout all submodules' '
> +	git clone -c submodule.recurse=3Dtrue super clone7 &&
> +	(
> +		git -C clone7 rev-parse --resolve-git-dir .git --resolve-git-dir nest=
ed1/nested2/nested3/submodule/.git >actual &&
> +		cat >expect <<-EOF &&
> +		.git
> +		$(pwd)/clone7/.git/modules/nested1/modules/nested2/modules/nested3/mo=
dules/submodule
> +		EOF
> +		test_cmp expect actual
> +	)
> +'
>
>  test_expect_success 'command passed to foreach retains notion of stdin'=
 '
>  	(
>
> base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
> --
> gitgitgadget
>

--8323328-1982473641-1580899056=:46--
