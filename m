Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5804C33CB3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 21:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A371205F4
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 21:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="evyysY8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgBAVTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 16:19:41 -0500
Received: from mout.gmx.net ([212.227.17.21]:59955 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgBAVTl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 16:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580591979;
        bh=PXGSiAMyDbhJwu8yq90m7tZU7Ja3r8BLsDe9KjO1cuA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=evyysY8y2L7l1vrfMmR8wqOz/jWvdTkWcxPaBe6wd57I37dpWLVkPNgBChBuzoY3z
         Nadn6KsRhYf46oKl5qZqfizCURfBCNO5hw+IJSFmxZdtVj2KwFNaitdn/i9Lq/pchX
         VbPb+9AH9+Dwysl6XOqbKjgXql51G3KpBybKz088=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKDU-1jlJ0p0AFI-00ydvS; Sat, 01
 Feb 2020 22:19:39 +0100
Date:   Sat, 1 Feb 2020 22:19:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Markus Klein via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Markus Klein <masmiseim@gmx.de>,
        Markus <masmiseim@gmx.de>
Subject: Re: [PATCH] clone: use submodules.recurse option for automatically
 clone submodules
In-Reply-To: <pull.695.git.git.1580505092071.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002012218410.46@tvgsbejvaqbjf.bet>
References: <pull.695.git.git.1580505092071.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-864764858-1580591979=:46"
X-Provags-ID: V03:K1:WON2jQNz2w2xObBn2He1Fb001uuWZ8XCUgbeWnzUqYt+0KSMWU0
 7AXE4w0ZYF0OEEYb2DCCFWH/zLczXjTMyzevjGBVOiOeH1fm9Rp8Uw2c6rBUanNtqNgMBl5
 npBl7uKRt92+L1cl4l7AmJ0ZrV1HDiNFigYlZ/h5CCAy4QaKisLwXPzsw81zrnGqR4OPe56
 cq9QNFnP9beJeH+zSZn0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ypMLwca8QEQ=:DK0XRT6JVaYGk20Jag1gsR
 lNOZmWZEsSnu7rMD1hROlsLphb4gIMSxil/RwpFjKPAJsr1EhPHGakaSVFgkREskV4sDRJGj2
 mF3c8MM8k4fZAgepB/1nmJ+cSB6DBOnYMSG5oxSIDJrjBVJZzECZ6fbQE3CwKHEg4vQjZ8Dvn
 9ccGjch3C0DxWVZkDfRQF+NKtYwBMOZ7u1ng3Y3lIpncNV+oCmPHJBecyDkQZNsc2eXLNQYsg
 kjwhme0qym9o73pS095SUOQJUKAwPdeD6iRh6yY7PEGmi0u08QWqZMGYlMdNkhQL5sSZdThs0
 qnlNkpH36sO2KJjszIatRZAdn61I0PK92VsqqvFS+kp7Ov5GbWL2wHrkJefLn6eceTMKdPyFD
 af6iauucTG9hENtos8KWO6s1jtLHjkgOaf9A4hJoG4YiqsTjAjPYyUrM+K12jRucwOP9E0t5x
 vHZHWp6MOJ3OuNDG1rHfWMHk3ii8ELQyNQ2XpHn4g/gzNdqKqUZBFzWTkW694p0Snly8CD8ei
 6C0aLAZnJ5eesqVPTZZKOQBWOB5YBPF5daUtt9BVrmWUGQYjKVDxgL4V7yd1LfAINMCQBt2zw
 ob6RJnWnGeuWAIa7uNxfVkNJI8IyW/5oIVF5R/QNgqoTUq3yo1w6n5fTxLQFAvaRZkCqQU+7h
 mVSExp2CTC6Z1CoNHCih+BnvhFv7E5Gdc9GEIQEBrT4no/Ko+H1aNIYcgQCvEhczcY/RWR8a6
 +bz0I46iHqCskWa6JbZ6IG+97hTVZuXRzcFqGkW3cWuxJiFFeF0n2m2pj2W+ronWaOGitVQTz
 ELqwn8pBw3H8ZWN0gXIEN9bZna0tiw5pJnPWdGmAyibcs/ztHDoUWpYn+2I1xf1jgqapwIs75
 gatCzeA6gzEYguyUKIOiHQF/4k0Sy+A7IQISxWyqhXoUsErkklW1m8/j28NLCogJkizO9Wg89
 sa7p5nTHw06QmDeINATnk1JTyRwAYFVDxQkEwyTeCCBWNNq9s4bo97a3TUaAgUfw8TjVLek2p
 apXo+SmSnYfaxwIB2/l7V+dygZrrVQ8F7JzU2wJZ7xYPGbbptiwBUPiljiQro9DdHw0e2D+CQ
 NAJWBwoQ2Y2U3dlnONc5uCyENf1RAj6iI8xV5civh4Hfx2k+sg2LL9YChVn7BA0pnqp/fUXlN
 CAEQ2ztKrLdk3LW050oIH3O1OYNHNEYBi3afNuEtNRs9S5Nuuj+TGA6yV3m2+pfkthZwEBgHl
 8Z5mjUm+scAwAeEI2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-864764858-1580591979=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Markus,


On Fri, 31 Jan 2020, Markus Klein via GitGitGadget wrote:

> From: Markus <masmiseim@gmx.de>

This line should probably match...

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
> Signed-off-by: Markus Klein <masmiseim@gmx.de>

... this line. I.e. you will want to run `git config --global user.name
"Markus Klein"` and then `git commit --amend --reset-author`.

Ciao,
Johannes

> ---
>     Add the usage of the submodules.recurse parameter on clone
>
>     I try to finish the pullrequest #573 from Maddimax. This adds the us=
age
>     of the submodules.recurse parameter on clone
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-69=
5%2FMasmiseim36%2Fdev%2FCloneWithSubmodule-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-695/M=
asmiseim36/dev/CloneWithSubmodule-v1
> Pull-Request: https://github.com/git/git/pull/695
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

--8323328-864764858-1580591979=:46--
