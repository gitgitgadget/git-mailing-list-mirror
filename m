Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B977C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 11:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348670AbiHSL3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 07:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348831AbiHSL3A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 07:29:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22529D83FD
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 04:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660908536;
        bh=6ouzJmrCzVfJP1ZaxkQXiKalDZVKwUk3mgURK0WyOnY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=areih8Jv+ieW+PhOaF7YdLpYOE345igJva3Ca+rNSzqFitgatyg7hwXoFKSN8JFCS
         a33xjKuTbTDERpbUp5rL7E1uvnv4Dz35hvTcOAIWAlJDf6wZuTTL4TScwMuQGBOe2E
         +5FUnNavZcIPsh9sPmGiWj4uT9pmt9L44LsARlvs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXUD-1o5PUm2xxX-00JZPB; Fri, 19
 Aug 2022 13:28:55 +0200
Date:   Fri, 19 Aug 2022 13:29:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v3] git-prompt: show presence of unresolved conflicts at
 command prompt
In-Reply-To: <pull.1302.v3.git.1660695492382.gitgitgadget@gmail.com>
Message-ID: <ps2p6366-7r7o-944q-o7s7-4rqp846721o9@tzk.qr>
References: <pull.1302.v2.git.1659132518935.gitgitgadget@gmail.com> <pull.1302.v3.git.1660695492382.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:g8HAF1Tbe1ZMNTezRA10bkF/mEbTcI1hZzg6UnjHjFPhB82pOXR
 5R+Qzuy92K+DEFHo5LBRO5NLS8BQENCISVPuWnG5FuHtpUVhEU2iEgi27x9UZciFVYBqz2t
 i3PuKhkmhhR962LuN5R/x2oNnko70UBbCuusmSnQYH3vavBxfyZ312WZk6G0iNRP9LpmPrX
 NkuEnjlCO1P5R0EDw3nbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EyAvzOyV9EA=:AQ93oJWcwGqY73SWxucIuW
 g6/KfHh7M0a7zNuqfOsThcxz9Qzy7u2loVG26Bc1nngGI+xM3U1OhMVmqM2JaglgRbiRVWvWr
 sFBhFuB7g1DeRibXJbxA/hwLgiH5Cuk9DbXqvyYCGjbzg3CDXBhM4AV1XcvuhIHrRo5wZGGpk
 FPM2wwa09W/iY6dIJzuAq+eRiqBjBTWcSbizLlAVgA5YMIgz8XFEcYpxy7h3EeZaoduK4tGim
 meRC2k9wZTMVI40uyCkQjF2MO3Da8QiI9gAO+ooTWxKsjN63uH2BqmjMo6mqEdTlOlboVYAtA
 c5N4A8jKQVIzzb/JVPsb68suu4dIOayivPBesUzdI2ue6yE6fiPO+zukJ9IGQyhmihv+85Xlh
 gDT4jjNCn5pnviHHt4+OcR+2aSgizeQgcjrzMV1r4muKf5robdHawAAQLt1CXIOv/YOqA48z7
 lfO41rgrGztqIHdbRAptDM9+c/kvsIWhP9hTnNuTIhUuLDpdNAiY9l5A+uNgX29CtYesOR3b0
 w8G/Q+TTsoiacn+g2KihZboETLV4nrKhLQ8h4C4zOY07/1Ntf/vdHDrdFDogm2UY4xXhqtG8D
 gHI2C7KEoSPOFbsUsQFkZxi5qaMbPmrijrFsHxfvPTuLPZiFjy/f1WbAPXOFVb/7nZlWr7v94
 ufDVCIEyhKVRjjNWQYUdQUT2nLjRvmvT9Fy0FjIIt9OUygwEhiZbcQCaEh6m7S1d3woXgeS76
 Ub1pQRmR5N0ePnaZccXgkNw73onI9ui2sO4kfZYMre37qwmSmF7qb4u0yoCnG/tRY+a7vlOVp
 Djf3kBbg66RkIzGdPFgAUqSMezGBFTlBPJOBraO4WVkJSlNDhEBKQY1YqMagrxsHLjP2/fvf7
 QSBW5YxIUdANhGI1iDEH5ieDnfYJwilInXJZcA2yI88WDOGe0rCN9qbH2ZsmXqUx3+gNFZV36
 e/dRAS1OmJJBZQA4aeP7ZSe4pNZaXEwV8kN7kO6/gVHm0cxtjcfS8KUVkC2dJWrVBUn9POetT
 ROxk1ufjwKpsj17OA9GnWO8pqy5qPhf1pD0zwX0sYLn5yaEReHMya+a18ZR6oD+Q0cDs7RBhG
 +632SyThIaN4xOQKBgRwFAtpYl91Qh0RlJBoSVFSNofU5r4XyNthI9f8g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Justin,

On Wed, 17 Aug 2022, Justin Donnelly via GitGitGadget wrote:

> From: Justin Donnelly <justinrdonnelly@gmail.com>
>
> If GIT_PS1_SHOWCONFLICTSTATE is set to "yes", show the word "CONFLICT"
> on the command prompt when there are unresolved conflicts.
>
> Example prompt: (main|CONFLICT)
>
> Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
> ---
>     Show 'CONFLICT' indicator at command prompt
>
>     This patch adds functionality for bash/zsh to show "CONFLICT" on the
>     prompt in cases where there are unresolved conflicts. The feature is
>     only enabled after setting an environment variable.
>
>     The conflict state is determined by running git ls-files --unmerged.=
 In
>     my testing, the performance was very good. It took around 0.01 secon=
ds
>     to run git ls-files --unmerged regardless of the number of conflicts=
, or
>     their depth, even on very large projects (Linux kernel). I got simil=
ar
>     performance running git diff --cached --quiet --diff-filter=3DU.
>
>     --------------------------------------------------------------------=
----
>
>     Changes since v2:
>
>      * There is now a single new test focused explicitly on this feature
>        instead of making copies of existing tests and modifying them.
>
>     Changes since v1:
>
>      * This feature is now disabled by default.
>      * Created new tests for conflict state (instead of modifying existi=
ng
>        tests).

This iteration looks good to me.

Thanks!
Dscho

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1302%2=
Fjustinrdonnelly%2Fconflict-indicator-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1302/just=
inrdonnelly/conflict-indicator-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1302
>
> Range-diff vs v2:
>
>  1:  7154d695426 ! 1:  2ea5c403924 git-prompt: show presence of unresolv=
ed conflicts at command prompt
>      @@ contrib/completion/git-prompt.sh: __git_ps1 ()
>        		if [ "${__git_printf_supports_v-}" !=3D yes ]; then
>
>        ## t/t9903-bash-prompt.sh ##
>      -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - rebase me=
rge' '
>      - 	test_when_finished "git checkout main" &&
>      - 	test_must_fail git rebase --merge b1 b2 &&
>      - 	test_when_finished "git rebase --abort" &&
>      --	__git_ps1 >"$actual" &&
>      -+	(
>      -+		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
>      -+		__git_ps1 >"$actual"
>      -+	) &&
>      -+	test_cmp expected "$actual"
>      -+'
>      -+
>      -+test_expect_success 'prompt - rebase merge conflict' '
>      -+	printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
>      -+	git checkout b2 &&
>      -+	test_when_finished "git checkout main" &&
>      -+	test_must_fail git rebase --merge b1 b2 &&
>      -+	test_when_finished "git rebase --abort" &&
>      -+	(
>      -+		GIT_PS1_SHOWCONFLICTSTATE=3D"yes" &&
>      -+		__git_ps1 >"$actual"
>      -+	) &&
>      - 	test_cmp expected "$actual"
>      - '
>      -
>      -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - rebase am=
' '
>      - 	test_when_finished "git checkout main" &&
>      - 	test_must_fail git rebase --apply b1 b2 &&
>      - 	test_when_finished "git rebase --abort" &&
>      --	__git_ps1 >"$actual" &&
>      -+	(
>      -+		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
>      -+		__git_ps1 >"$actual"
>      -+	) &&
>      -+	test_cmp expected "$actual"
>      -+'
>      -+
>      -+test_expect_success 'prompt - rebase am conflict' '
>      -+	printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
>      -+	git checkout b2 &&
>      -+	test_when_finished "git checkout main" &&
>      -+	test_must_fail git rebase --apply b1 b2 &&
>      -+	test_when_finished "git rebase --abort" &&
>      -+	(
>      -+		GIT_PS1_SHOWCONFLICTSTATE=3D"yes" &&
>      -+		__git_ps1 >"$actual"
>      -+	) &&
>      - 	test_cmp expected "$actual"
>      - '
>      -
>      -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - merge' '
>      - 	test_when_finished "git checkout main" &&
>      - 	test_must_fail git merge b2 &&
>      - 	test_when_finished "git reset --hard" &&
>      --	__git_ps1 >"$actual" &&
>      -+	(
>      -+		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
>      -+		__git_ps1 >"$actual"
>      -+	) &&
>      -+	test_cmp expected "$actual"
>      -+'
>      -+
>      -+test_expect_success 'prompt - merge conflict' '
>      -+	printf " (b1|MERGING|CONFLICT)" >expected &&
>      -+	git checkout b1 &&
>      -+	test_when_finished "git checkout main" &&
>      -+	test_must_fail git merge b2 &&
>      -+	test_when_finished "git reset --hard" &&
>      -+	(
>      -+		GIT_PS1_SHOWCONFLICTSTATE=3D"yes" &&
>      -+		__git_ps1 >"$actual"
>      -+	) &&
>      - 	test_cmp expected "$actual"
>      - '
>      -
>      -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - cherry-pi=
ck' '
>      - 	printf " (main|CHERRY-PICKING)" >expected &&
>      - 	test_must_fail git cherry-pick b1 b1^ &&
>      - 	test_when_finished "git cherry-pick --abort" &&
>      --	__git_ps1 >"$actual" &&
>      -+	(
>      -+		sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
>      -+		__git_ps1 >"$actual"
>      -+	) &&
>      - 	test_cmp expected "$actual" &&
>      - 	git reset --merge &&
>      - 	test_must_fail git rev-parse CHERRY_PICK_HEAD &&
>      -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - cherry-pi=
ck' '
>      +@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - hide if p=
wd ignored - inside gitdir' '
>        	test_cmp expected "$actual"
>        '
>
>      -+test_expect_success 'prompt - cherry-pick conflict' '
>      -+	printf " (main|CHERRY-PICKING|CONFLICT)" >expected &&
>      -+	test_must_fail git cherry-pick b1 b1^ &&
>      -+	test_when_finished "git cherry-pick --abort" &&
>      ++test_expect_success 'prompt - conflict indicator' '
>      ++	printf " (main|CONFLICT)" >expected &&
>      ++	echo "stash" >file &&
>      ++	git stash &&
>      ++	test_when_finished "git stash drop" &&
>      ++	echo "commit" >file &&
>      ++	git commit -m "commit" file &&
>      ++	test_when_finished "git reset --hard HEAD~" &&
>      ++	test_must_fail git stash apply &&
>       +	(
>       +		GIT_PS1_SHOWCONFLICTSTATE=3D"yes" &&
>       +		__git_ps1 >"$actual"
>      @@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - cherry-pic=
k' '
>       +	test_cmp expected "$actual"
>       +'
>       +
>      - test_expect_success 'prompt - revert' '
>      - 	printf " (main|REVERTING)" >expected &&
>      - 	test_must_fail git revert b1^ b1 &&
>      + test_done
>
>
>  contrib/completion/git-prompt.sh | 12 +++++++++++-
>  t/t9903-bash-prompt.sh           | 16 ++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-p=
rompt.sh
> index 1435548e004..57972c2845c 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -84,6 +84,10 @@
>  # single '?' character by setting GIT_PS1_COMPRESSSPARSESTATE, or omitt=
ed
>  # by setting GIT_PS1_OMITSPARSESTATE.
>  #
> +# If you would like to see a notification on the prompt when there are
> +# unresolved conflicts, set GIT_PS1_SHOWCONFLICTSTATE to "yes". The
> +# prompt will include "|CONFLICT".
> +#
>  # If you would like to see more information about the identity of
>  # commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
>  # to one of these values:
> @@ -508,6 +512,12 @@ __git_ps1 ()
>  		r=3D"$r $step/$total"
>  	fi
>
> +	local conflict=3D"" # state indicator for unresolved conflicts
> +	if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" =3D=3D "yes" ]] &&
> +	   [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
> +		conflict=3D"|CONFLICT"
> +	fi
> +
>  	local w=3D""
>  	local i=3D""
>  	local s=3D""
> @@ -572,7 +582,7 @@ __git_ps1 ()
>  	fi
>
>  	local f=3D"$h$w$i$s$u$p"
> -	local gitstring=3D"$c$b${f:+$z$f}${sparse}$r${upstream}"
> +	local gitstring=3D"$c$b${f:+$z$f}${sparse}$r${upstream}${conflict}"
>
>  	if [ $pcmode =3D yes ]; then
>  		if [ "${__git_printf_supports_v-}" !=3D yes ]; then
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index 6a30f5719c3..d459fae6551 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -759,4 +759,20 @@ test_expect_success 'prompt - hide if pwd ignored -=
 inside gitdir' '
>  	test_cmp expected "$actual"
>  '
>
> +test_expect_success 'prompt - conflict indicator' '
> +	printf " (main|CONFLICT)" >expected &&
> +	echo "stash" >file &&
> +	git stash &&
> +	test_when_finished "git stash drop" &&
> +	echo "commit" >file &&
> +	git commit -m "commit" file &&
> +	test_when_finished "git reset --hard HEAD~" &&
> +	test_must_fail git stash apply &&
> +	(
> +		GIT_PS1_SHOWCONFLICTSTATE=3D"yes" &&
> +		__git_ps1 >"$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
>  test_done
>
> base-commit: 9bf691b78cf906751e65d65ba0c6ffdcd9a5a12c
> --
> gitgitgadget
>
