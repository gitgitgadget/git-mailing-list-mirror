Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4660CC433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiKNWUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237795AbiKNWUj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:20:39 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D231B7B2
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:20:20 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id a6-20020a170902ecc600b00186f035ed74so9918018plh.12
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+a+hsqKKaSCHLbBICHW4Ggq23huUfGSKHGubPNYwbYI=;
        b=U/GWKYeNMp29iycmvvT/ggNOlOk1WLPJKpms5M8lpyi8LsC/szih1j2W3ci+2qp1tb
         r0Rvy4cOIoll64BQEQWtW05YNgrFqURUoaTAYMUyGzRyXq88oEIfftgKaSA60OnF3vXT
         8J5shODLnzrCGx4vXQTYT01SvO/HFLSzWArhFbrGREuQeu11sKqFTZ6DLhFzCkO9pEfR
         my/doE7Dh7cfhem40e3IjDQVo/0EQwmfDiCuIASoVl7N13q78YUCTzv1kHH5vgLlQlh4
         +8kaNjmo3LEl0UBk4B55WnDlRN9Hf0vV5Dhdo5MnKWRDfdfQZUoqx+w90aKNoByq/MVV
         Z8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+a+hsqKKaSCHLbBICHW4Ggq23huUfGSKHGubPNYwbYI=;
        b=0yfAU1CcCOn9InRz+tPjvmtF4omrJ4aM8VXE9Uxmb/QwUqrJdL2mdTwkfpdu0XqmWd
         Xrrh34T9JX4R1WTa3LwVb1tH0CrgKu8XIz9895TOvxZmN1hxWqcaZ+38H4/VtdiCRs7e
         X19dKPhPJ6HsGqya3WHvB/hpU70l7l8SLjC1YLDgATpaiBU/SfGp46ONXK20TY2yuVXl
         a97cnGs/FxAO04W4Djd44txBneaeCcHUx91MstFSU7+KWEkp++eHtucO9mClXYqwpGPK
         s3hiOzeGlQvc1AHSEHUBr5x6BoVRtG40QWW1r1cNqbCYJ86T72w/pvZPK9ci6OBOuhno
         TEMA==
X-Gm-Message-State: ANoB5pmbRkMwQyVA4YIv1n6B0M3GQs3RK9G1ccn03D4qkZ6YFV/j+eSr
        U9kO6kws085v+7TaS6FTxVuviYQExwAvkQ==
X-Google-Smtp-Source: AA0mqf55oFm2z+btvq3Fe3AKChWK1SJ4H6RNfWPdqeMY9ZKzcpdO0BIde42WRV3fQOnCEB6KP6i8w23wom2QOg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:a10:b0:20a:eab5:cf39 with SMTP id
 gg16-20020a17090b0a1000b0020aeab5cf39mr10637pjb.1.1668464419919; Mon, 14 Nov
 2022 14:20:19 -0800 (PST)
Date:   Mon, 14 Nov 2022 14:20:18 -0800
In-Reply-To: <patch-v2-08.10-172b5865811-20221114T100803Z-avarab@gmail.com>
Mime-Version: 1.0
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com> <patch-v2-08.10-172b5865811-20221114T100803Z-avarab@gmail.com>
Message-ID: <kl6ly1sdnpp9.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 08/10] submodule tests: test "git branch -t" output and stderr
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Robert Coup <robert@coup.net.nz>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The "git branch" command will currently make use of the
> "--super-prefix", as it will indirectly call submodule_move_head(),
> which will have access to the "--super-prefix".

I couldn't figure out how "git branch" ends up calling
submodule_move_head(), could you include the call chain?

I find it very odd because AFAICT we only call submodule_move_head()
when we are modifying the working tree (or checking if it is safe to
modify), and "git branch" shouldn't touch the working tree.

> The output could thus be affected by the "--super-prefix". Right now
> it isn't in this case, but let's exhaustively assert that that's the
> case by testing the output of all of these "git branch -t" commands.

It's reasonable to be worried if the output contained paths to the
working tree, but...

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/lib-submodule-update.sh | 98 ++++++++++++++++++++++-----------------
>  1 file changed, 55 insertions(+), 43 deletions(-)
>
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 2d31fcfda1f..302d095ad9b 100644
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -245,6 +245,17 @@ reset_work_tree_to_interested () {
>  	git -C submodule_update/.git/modules/sub1 config submodule.sub2.url "bo=
gus"
>  }
> =20
> +test_branch_t_output () {
> +	local branchname=3D"$1" &&
> +	local start_point=3D"$2" &&
> +	cat >expect <<-EOF &&
> +	branch '$branchname' set up to track '$start_point'.
> +	EOF
> +	git branch -t "$branchname" "$start_point" >actual 2>err &&
> +	test_must_be_empty err &&
> +	test_cmp expect actual
> +}
> +

it looks like the output is based entirely on the ref store, which has
no reason to use the super prefix. Based on the commit message in
74866d7579 (git: make super-prefix option, 2016-10-07):

  When such a super-prefix is specified, the paths reported by Git
  are prefixed with it to make them relative to that directory "above".
  The paths given by the user on the command line
  (e.g. "git subcmd --output-file=3Dpath/to/a/file" and pathspecs) are take=
n
  relative to the directory "above" to match.

and the fact that the super prefix has never been used for anything
other than the working tree, I don't think this level of paranoia is
necessary.

>  # Test that the superproject contains the content according to commit "$=
1"
>  # (the work tree must match the index for everything but submodules but =
the
>  # index must exactly match the given commit including any submodule SHA-=
1s).
> @@ -323,7 +334,7 @@ test_submodule_switch_common () {
>  		reset_work_tree_to no_submodule &&
>  		(
>  			cd submodule_update &&
> -			git branch -t add_sub1 origin/add_sub1 &&
> +			test_branch_t_output add_sub1 origin/add_sub1 &&
>  			$command add_sub1 &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_dir_is_empty sub1 &&
> @@ -345,7 +356,7 @@ test_submodule_switch_common () {
>  		(
>  			cd submodule_update &&
>  			mkdir sub1 &&
> -			git branch -t add_sub1 origin/add_sub1 &&
> +			test_branch_t_output add_sub1 origin/add_sub1 &&
>  			$command add_sub1 &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_dir_is_empty sub1 &&
> @@ -360,7 +371,7 @@ test_submodule_switch_common () {
>  		reset_work_tree_to replace_sub1_with_file &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
> +			test_branch_t_output replace_file_with_sub1 origin/replace_file_with_=
sub1 &&
>  			$command replace_file_with_sub1 &&
>  			test_superproject_content origin/replace_file_with_sub1 &&
>  			test_dir_is_empty sub1 &&
> @@ -384,7 +395,7 @@ test_submodule_switch_common () {
>  		reset_work_tree_to replace_sub1_with_directory &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_directory_with_sub1 origin/replace_directory_wi=
th_sub1 &&
> +			test_branch_t_output replace_directory_with_sub1 origin/replace_direc=
tory_with_sub1 &&
>  			$command replace_directory_with_sub1 &&
>  			test_superproject_content origin/replace_directory_with_sub1 &&
>  			test_dir_is_empty sub1 &&
> @@ -406,7 +417,7 @@ test_submodule_switch_common () {
>  		reset_work_tree_to add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t remove_sub1 origin/remove_sub1 &&
> +			test_branch_t_output remove_sub1 origin/remove_sub1 &&
>  			$command remove_sub1 &&
>  			test_superproject_content origin/remove_sub1 &&
>  			test_submodule_content sub1 origin/add_sub1
> @@ -418,7 +429,7 @@ test_submodule_switch_common () {
>  		reset_work_tree_to add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t remove_sub1 origin/remove_sub1 &&
> +			test_branch_t_output remove_sub1 origin/remove_sub1 &&
>  			replace_gitfile_with_git_dir sub1 &&
>  			$command remove_sub1 &&
>  			test_superproject_content origin/remove_sub1 &&
> @@ -447,7 +458,7 @@ test_submodule_switch_common () {
>  		reset_work_tree_to add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_sub1_with_directory origin/replace_sub1_with_di=
rectory &&
> +			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_=
with_directory &&
>  			$command replace_sub1_with_directory test_must_fail &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_submodule_content sub1 origin/add_sub1
> @@ -459,7 +470,7 @@ test_submodule_switch_common () {
>  		reset_work_tree_to add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_sub1_with_directory origin/replace_sub1_with_di=
rectory &&
> +			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_=
with_directory &&
>  			replace_gitfile_with_git_dir sub1 &&
>  			$command replace_sub1_with_directory test_must_fail &&
>  			test_superproject_content origin/add_sub1 &&
> @@ -474,7 +485,7 @@ test_submodule_switch_common () {
>  		reset_work_tree_to add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
> +			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_=
file &&
>  			$command replace_sub1_with_file test_must_fail &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_submodule_content sub1 origin/add_sub1
> @@ -487,7 +498,7 @@ test_submodule_switch_common () {
>  		reset_work_tree_to add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
> +			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_=
file &&
>  			replace_gitfile_with_git_dir sub1 &&
>  			$command replace_sub1_with_file test_must_fail &&
>  			test_superproject_content origin/add_sub1 &&
> @@ -512,7 +523,7 @@ test_submodule_switch_common () {
>  		reset_work_tree_to add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t modify_sub1 origin/modify_sub1 &&
> +			test_branch_t_output modify_sub1 origin/modify_sub1 &&
>  			$command modify_sub1 &&
>  			test_superproject_content origin/modify_sub1 &&
>  			test_submodule_content sub1 origin/add_sub1 &&
> @@ -527,7 +538,7 @@ test_submodule_switch_common () {
>  		reset_work_tree_to add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t invalid_sub1 origin/invalid_sub1 &&
> +			test_branch_t_output invalid_sub1 origin/invalid_sub1 &&
>  			$command invalid_sub1 &&
>  			test_superproject_content origin/invalid_sub1 &&
>  			test_submodule_content sub1 origin/add_sub1 &&
> @@ -542,7 +553,7 @@ test_submodule_switch_common () {
>  		reset_work_tree_to invalid_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t valid_sub1 origin/valid_sub1 &&
> +			test_branch_t_output valid_sub1 origin/valid_sub1 &&
>  			$command valid_sub1 &&
>  			test_superproject_content origin/valid_sub1 &&
>  			test_dir_is_empty sub1 &&
> @@ -596,7 +607,7 @@ test_submodule_switch_func () {
>  		reset_work_tree_to no_submodule &&
>  		(
>  			cd submodule_update &&
> -			git branch -t add_sub1 origin/add_sub1 &&
> +			test_branch_t_output add_sub1 origin/add_sub1 &&
>  			>sub1 &&
>  			$command add_sub1 test_must_fail &&
>  			test_superproject_content origin/no_submodule &&
> @@ -635,7 +646,7 @@ test_submodule_forced_switch () {
>  		reset_work_tree_to no_submodule &&
>  		(
>  			cd submodule_update &&
> -			git branch -t add_sub1 origin/add_sub1 &&
> +			test_branch_t_output add_sub1 origin/add_sub1 &&
>  			>sub1 &&
>  			$command add_sub1 &&
>  			test_superproject_content origin/add_sub1 &&
> @@ -675,7 +686,7 @@ test_submodule_recursing_with_args_common () {
>  		reset_work_tree_to_interested no_submodule &&
>  		(
>  			cd submodule_update &&
> -			git branch -t add_sub1 origin/add_sub1 &&
> +			test_branch_t_output add_sub1 origin/add_sub1 &&
>  			$command add_sub1 &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_submodule_content sub1 origin/add_sub1
> @@ -688,7 +699,7 @@ test_submodule_recursing_with_args_common () {
>  		(
>  			cd submodule_update &&
>  			mkdir sub1 &&
> -			git branch -t add_sub1 origin/add_sub1 &&
> +			test_branch_t_output add_sub1 origin/add_sub1 &&
>  			$command add_sub1 &&
>  			test_superproject_content origin/add_sub1 &&
>  			test_submodule_content sub1 origin/add_sub1
> @@ -701,7 +712,7 @@ test_submodule_recursing_with_args_common () {
>  		reset_work_tree_to_interested replace_sub1_with_file &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
> +			test_branch_t_output replace_file_with_sub1 origin/replace_file_with_=
sub1 &&
>  			$command replace_file_with_sub1 &&
>  			test_superproject_content origin/replace_file_with_sub1 &&
>  			test_submodule_content sub1 origin/replace_file_with_sub1
> @@ -713,19 +724,20 @@ test_submodule_recursing_with_args_common () {
>  		reset_work_tree_to_interested replace_sub1_with_directory &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_directory_with_sub1 origin/replace_directory_wi=
th_sub1 &&
> +			test_branch_t_output replace_directory_with_sub1 origin/replace_direc=
tory_with_sub1 &&
>  			$command replace_directory_with_sub1 &&
>  			test_superproject_content origin/replace_directory_with_sub1 &&
>  			test_submodule_content sub1 origin/replace_directory_with_sub1
>  		)
>  	'
> +
>  	# Switching to a commit with nested submodules recursively checks them =
out
>  	test_expect_success "$command: nested submodules are checked out" '
>  		prolog &&
>  		reset_work_tree_to_interested no_submodule &&
>  		(
>  			cd submodule_update &&
> -			git branch -t modify_sub1_recursively origin/modify_sub1_recursively =
&&
> +			test_branch_t_output modify_sub1_recursively origin/modify_sub1_recur=
sively &&
>  			$command modify_sub1_recursively &&
>  			test_superproject_content origin/modify_sub1_recursively &&
>  			test_submodule_content sub1 origin/modify_sub1_recursively &&
> @@ -740,7 +752,7 @@ test_submodule_recursing_with_args_common () {
>  		reset_work_tree_to_interested add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t remove_sub1 origin/remove_sub1 &&
> +			test_branch_t_output remove_sub1 origin/remove_sub1 &&
>  			$command remove_sub1 &&
>  			test_superproject_content origin/remove_sub1 &&
>  			! test -e sub1 &&
> @@ -753,7 +765,7 @@ test_submodule_recursing_with_args_common () {
>  		reset_work_tree_to_interested add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t remove_sub1 origin/remove_sub1 &&
> +			test_branch_t_output remove_sub1 origin/remove_sub1 &&
>  			replace_gitfile_with_git_dir sub1 &&
>  			rm -rf .git/modules &&
>  			$command remove_sub1 &&
> @@ -769,7 +781,7 @@ test_submodule_recursing_with_args_common () {
>  		reset_work_tree_to_interested add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
> +			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_=
file &&
>  			$command replace_sub1_with_file &&
>  			test_superproject_content origin/replace_sub1_with_file &&
>  			test -f sub1
> @@ -786,7 +798,7 @@ test_submodule_recursing_with_args_common () {
>  		reset_work_tree_to_interested add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
> +			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_=
file &&
>  			: >sub1/untrackedfile &&
>  			test_must_fail $command replace_sub1_with_file &&
>  			test_superproject_content origin/add_sub1 &&
> @@ -801,7 +813,7 @@ test_submodule_recursing_with_args_common () {
>  		reset_work_tree_to_interested add_nested_sub &&
>  		(
>  			cd submodule_update &&
> -			git branch -t no_submodule origin/no_submodule &&
> +			test_branch_t_output no_submodule origin/no_submodule &&
>  			$command no_submodule &&
>  			test_superproject_content origin/no_submodule &&
>  			! test_path_is_dir sub1 &&
> @@ -817,7 +829,7 @@ test_submodule_recursing_with_args_common () {
>  		reset_work_tree_to_interested add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t modify_sub1 origin/modify_sub1 &&
> +			test_branch_t_output modify_sub1 origin/modify_sub1 &&
>  			$command modify_sub1 &&
>  			test_superproject_content origin/modify_sub1 &&
>  			test_submodule_content sub1 origin/modify_sub1
> @@ -830,7 +842,7 @@ test_submodule_recursing_with_args_common () {
>  		reset_work_tree_to_interested add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t invalid_sub1 origin/invalid_sub1 &&
> +			test_branch_t_output invalid_sub1 origin/invalid_sub1 &&
>  			test_must_fail $command invalid_sub1 2>err &&
>  			test_i18ngrep sub1 err &&
>  			test_superproject_content origin/add_sub1 &&
> @@ -844,13 +856,13 @@ test_submodule_recursing_with_args_common () {
>  		(
>  			cd submodule_update &&
>  			git -C sub1 checkout -b keep_branch &&
> -			git -C sub1 rev-parse HEAD >expect &&
> -			git branch -t modify_sub1 origin/modify_sub1 &&
> +			git -C sub1 rev-parse HEAD >expect.rev-parse &&
> +			test_branch_t_output modify_sub1 origin/modify_sub1 &&
>  			$command modify_sub1 &&
>  			test_superproject_content origin/modify_sub1 &&
>  			test_submodule_content sub1 origin/modify_sub1 &&
>  			git -C sub1 rev-parse keep_branch >actual &&
> -			test_cmp expect actual &&
> +			test_cmp expect.rev-parse actual &&
>  			test_must_fail git -C sub1 symbolic-ref HEAD
>  		)
>  	'
> @@ -894,7 +906,7 @@ test_submodule_switch_recursing_with_args () {
>  		reset_work_tree_to_interested no_submodule &&
>  		(
>  			cd submodule_update &&
> -			git branch -t add_sub1 origin/add_sub1 &&
> +			test_branch_t_output add_sub1 origin/add_sub1 &&
>  			: >sub1 &&
>  			test_must_fail $command add_sub1 &&
>  			test_superproject_content origin/no_submodule &&
> @@ -908,7 +920,7 @@ test_submodule_switch_recursing_with_args () {
>  		reset_work_tree_to_interested no_submodule &&
>  		(
>  			cd submodule_update &&
> -			git branch -t add_sub1 origin/add_sub1 &&
> +			test_branch_t_output add_sub1 origin/add_sub1 &&
>  			: >sub1 &&
>  			mkdir .git/info &&
>  			echo sub1 >.git/info/exclude &&
> @@ -925,7 +937,7 @@ test_submodule_switch_recursing_with_args () {
>  		reset_work_tree_to_interested add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_sub1_with_directory origin/replace_sub1_with_di=
rectory &&
> +			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_=
with_directory &&
>  			$command replace_sub1_with_directory &&
>  			test_superproject_content origin/replace_sub1_with_directory &&
>  			test_submodule_content sub1 origin/replace_sub1_with_directory
> @@ -937,7 +949,7 @@ test_submodule_switch_recursing_with_args () {
>  		reset_work_tree_to_interested add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_sub1_with_directory origin/replace_sub1_with_di=
rectory &&
> +			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_=
with_directory &&
>  			replace_gitfile_with_git_dir sub1 &&
>  			rm -rf .git/modules &&
>  			$command replace_sub1_with_directory &&
> @@ -954,7 +966,7 @@ test_submodule_switch_recursing_with_args () {
>  		(
>  			cd submodule_update &&
>  			rm -rf .git/modules/sub1/info &&
> -			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
> +			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_=
file &&
>  			mkdir .git/modules/sub1/info &&
>  			echo ignored >.git/modules/sub1/info/exclude &&
>  			: >sub1/ignored &&
> @@ -969,7 +981,7 @@ test_submodule_switch_recursing_with_args () {
>  		reset_work_tree_to_interested add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t modify_sub1 origin/modify_sub1 &&
> +			test_branch_t_output modify_sub1 origin/modify_sub1 &&
>  			git -c submodule.recurse=3Dtrue $cmd_args modify_sub1 &&
>  			test_superproject_content origin/modify_sub1 &&
>  			test_submodule_content sub1 origin/modify_sub1
> @@ -981,7 +993,7 @@ test_submodule_switch_recursing_with_args () {
>  		reset_work_tree_to_interested add_nested_sub &&
>  		(
>  			cd submodule_update &&
> -			git branch -t modify_sub1_recursively origin/modify_sub1_recursively =
&&
> +			test_branch_t_output modify_sub1_recursively origin/modify_sub1_recur=
sively &&
>  			$command modify_sub1_recursively &&
>  			test_superproject_content origin/modify_sub1_recursively &&
>  			test_submodule_content sub1 origin/modify_sub1_recursively &&
> @@ -1009,7 +1021,7 @@ test_submodule_forced_switch_recursing_with_args ()=
 {
>  		reset_work_tree_to_interested no_submodule &&
>  		(
>  			cd submodule_update &&
> -			git branch -t add_sub1 origin/add_sub1 &&
> +			test_branch_t_output add_sub1 origin/add_sub1 &&
>  			>sub1 &&
>  			$command add_sub1 &&
>  			test_superproject_content origin/add_sub1 &&
> @@ -1023,7 +1035,7 @@ test_submodule_forced_switch_recursing_with_args ()=
 {
>  		reset_work_tree_to_interested add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_sub1_with_directory origin/replace_sub1_with_di=
rectory &&
> +			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_=
with_directory &&
>  			$command replace_sub1_with_directory &&
>  			test_superproject_content origin/replace_sub1_with_directory
>  		)
> @@ -1034,7 +1046,7 @@ test_submodule_forced_switch_recursing_with_args ()=
 {
>  		reset_work_tree_to_interested add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_sub1_with_directory origin/replace_sub1_with_di=
rectory &&
> +			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_=
with_directory &&
>  			replace_gitfile_with_git_dir sub1 &&
>  			rm -rf .git/modules/sub1 &&
>  			$command replace_sub1_with_directory &&
> @@ -1049,7 +1061,7 @@ test_submodule_forced_switch_recursing_with_args ()=
 {
>  		reset_work_tree_to_interested add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
> +			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_=
file &&
>  			: >sub1/expect &&
>  			$command replace_sub1_with_file &&
>  			test_superproject_content origin/replace_sub1_with_file
> @@ -1062,7 +1074,7 @@ test_submodule_forced_switch_recursing_with_args ()=
 {
>  		reset_work_tree_to_interested invalid_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t valid_sub1 origin/valid_sub1 &&
> +			test_branch_t_output valid_sub1 origin/valid_sub1 &&
>  			$command valid_sub1 &&
>  			test_superproject_content origin/valid_sub1 &&
>  			test_submodule_content sub1 origin/valid_sub1
> @@ -1077,7 +1089,7 @@ test_submodule_forced_switch_recursing_with_args ()=
 {
>  		reset_work_tree_to_interested add_sub1 &&
>  		(
>  			cd submodule_update &&
> -			git branch -t modify_sub1 origin/modify_sub1 &&
> +			test_branch_t_output modify_sub1 origin/modify_sub1 &&
>  			echo "gitdir: bogus/path" >sub1/.git &&
>  			$command modify_sub1 &&
>  			test_superproject_content origin/modify_sub1 &&
> --=20
> 2.38.0.1471.ge4d8947e7aa
