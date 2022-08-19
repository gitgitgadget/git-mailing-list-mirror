Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD4BC25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 09:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347874AbiHSJWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347426AbiHSJWo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 05:22:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF01BF47C4
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660900960;
        bh=ENV7pRWEQNRwistx/mbOnxQ3VMrmgteR888pM4Cm/7U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hbdWvzy8J2aQwr+qNSBGsTzefmRtDdQvAw9wAWrf7RMq+p2eI9EkyynxtQ2BGw5bE
         fr6/fcWR/59wG2k72V+vx3QKK0vpqa+e0FPsTXtWC6BSZj2SbPt/V+BB9PEfauoVxh
         cUvbTedmETYHlVgHfclS+9kQiwwO+MGzdsEHnVPU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBlxM-1oCuS41LrA-00C9I9; Fri, 19
 Aug 2022 11:22:40 +0200
Date:   Fri, 19 Aug 2022 11:22:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-ort: remove code obsoleted by other changes
In-Reply-To: <pull.1302.git.git.1660884355643.gitgitgadget@gmail.com>
Message-ID: <596s400n-s6qs-0s08-s31s-99rq4o016647@tzk.qr>
References: <pull.1302.git.git.1660884355643.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Mh/jaARN8cBOVpmrXvVMqlbCyqfPP5M1fO18KxYQnRF+oNwHVeZ
 N20EWBFPnNBwlYfcS4ChGFtLoPaBux5gBzc9Om5Z9EbAwE8gt2rea6d/eKADTnbaV3OmWNT
 2UHbzJTisiCrpaBX94KWwzPSm9kjYIhl04U6RpeLmUCHNocoOpJcHzwkdvltSsGXwY9dtCO
 ZI8D9tuwkWG/2fETKpauA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jlrtyCNLA1w=:GnPcEXFMgR1IPtIwdN0zy9
 d0T982MthwWmvjzvAUxeCKQclo3Bl3xhq/mHhSJdVUE+vVIctTlRKfSTdlW0sRRiwhZymtQKI
 lEGLmtQddwo73WPhwBiCp3o27qzVQKtoCcGQlStknwglZyNn1lqzzsWW7bhIx6i9UdNlZA6Dq
 2HXlRh+MgWrjBks/M/IXe7mw+BvWyoBqAPmgKAMPziKo/F8bJZjLEZrlTU6U7j/q4X2yd6NLN
 uXI34tlVTWdjJctDX0CBwgHK2n0se8wOBz9VROMtDdzJyUsnfr2v/fyVnRZW0XjZoERkhnAAB
 bxqRX3L9H5Ju36Gb4BQzJbHm5z9tv8/U19ooIvs+gBSyVujK+6R2zH2BosNxZu8KtuVifzIlo
 eDhffkv/wxseFl+QJj2ZRfZ68FzzPqFbP1IT4fYP/s9lR4GOmMPCMHw6xMa9skjVl8aKOWuLK
 lGv19C3g4+F+ugy8JIZuOc8K/jrMOLWQOzinCkKscwXKQCkojtnmqW2zCrVuTLihDhN9ySB+r
 Dc7ttV9R/xtOw3NEw4e7oKG8fKn7CzvhDs2OO1ojluGvw+GIRqx3qVJ27mek3qXVUhQ2v1hl2
 63aTVnKmsq/OS5yli6ReuCXbRVaxiIWYZmO35SMeNYGpEJi4jATz07ZgVE/CWT7xg2JS7KRHj
 NN9Y3d6w9jnc2Ayu1WSjqrqSTrWa12DGZSKOtbhkyJNxPLqHIaNxzd39Ga3zM4RRLW4I1kYyx
 ab+3+xDhEY/XHCTJ+oCxqRFrvzCv+coHiBaPpj00L8/c7YahfnKA3G6txCF+fCnt11gUsppfi
 OPDI0MMoy7Avl9mOyjJ9vs0Wiwk+DTTMn7XGuSqABH7zan8f1fgrj6M9oX/naAbvhlHODX8rn
 xWk5XNc2dzjrl8RCoj7SpzZIjeGgerwmoEkimz5jRXENqxtfY5k8jCXPAnBr3yA9CZ8G45xnI
 /uW4LZLdb0q14EjdkQtGVrxED4nN/0CPWQiUxJEiuWPQSNEZfmGXmL6klw/wZU/F0bnqacznY
 KCznm9plMmlgvOPanHWtUrowWHiQMslgPDgNHsFDH2K3ys7azaguxeshls2R0ejFVgutliGoW
 gzlhTK1Y+2yFOcMcDnXXFYkCbRVnXOy6zzjX56LPKfeZn/7cZUH++blIQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 19 Aug 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Commit 66b209b86a ("merge-ort: implement CE_SKIP_WORKTREE handling with
> conflicted entries", 2021-03-20) added some code for merge-ort to handle
> conflicted and skip_worktree entries in general.  Included in this was
> an ugly hack for dealing with present-despite-skipped entries and a
> testcase (t6428.2) specific to that hack, since at that time users could
> accidentally get files into that state when using a sparse checkout.
>
> However, with the merging of 82386b4496 ("Merge branch
> 'en/present-despite-skipped'", 2022-03-09), that class of problems was
> addressed globally and in a much cleaner way.  As such, the
> present-despite-skipped hack in merge-ort is no longer needed and can
> simply be removed.
>
> No additional testcase is needed here; t6428.2 was written to test the
> necessary functionality and is being kept.  The fact that this test
> continues to pass despite the code being removed shows that the extra
> code is no longer necessary.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     merge-ort: remove code obsoleted by other changes
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-13=
02%2Fnewren%2Fnuke-present-despite-skipped-hack-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1302/=
newren/nuke-present-despite-skipped-hack-v1
> Pull-Request: https://github.com/git/git/pull/1302
>
>  merge-ort.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)

Nice!

Since I have been in the `merge-ort` code quite a bit as of late, I deem
myself familiar enough with the code to dare offering my ACK.

What is _particularly_ nice is that this patch removes an `lstat()` call
that was a bit of a concern for me when using `merge-ort` in a
worktree-less scenario. After some reasoning about the code, it turned out
that it is not hit in that use case, nevertheless it is much easier to
reason about `lstat()` calls that simply are not in the code.

Thank you!
Dscho

>
> diff --git a/merge-ort.c b/merge-ort.c
> index 8b7de0fbd8e..a6a3ab839a0 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -491,7 +491,6 @@ enum conflict_and_info_types {
>  	CONFLICT_FILE_DIRECTORY,
>  	CONFLICT_DISTINCT_MODES,
>  	CONFLICT_MODIFY_DELETE,
> -	CONFLICT_PRESENT_DESPITE_SKIPPED,
>
>  	/* Regular rename */
>  	CONFLICT_RENAME_RENAME,   /* same file renamed differently */
> @@ -536,8 +535,6 @@ static const char *type_short_descriptions[] =3D {
>  	[CONFLICT_FILE_DIRECTORY] =3D "CONFLICT (file/directory)",
>  	[CONFLICT_DISTINCT_MODES] =3D "CONFLICT (distinct modes)",
>  	[CONFLICT_MODIFY_DELETE] =3D "CONFLICT (modify/delete)",
> -	[CONFLICT_PRESENT_DESPITE_SKIPPED] =3D
> -		"CONFLICT (upgrade your version of git)",
>
>  	/*** Regular rename ***/
>  	[CONFLICT_RENAME_RENAME] =3D "CONFLICT (rename/rename)",
> @@ -748,8 +745,7 @@ static void path_msg(struct merge_options *opt,
>  	/* Sanity checks */
>  	assert(omittable_hint =3D=3D
>  	       !starts_with(type_short_descriptions[type], "CONFLICT") ||
> -	       type =3D=3D CONFLICT_DIR_RENAME_SUGGESTED ||
> -	       type =3D=3D CONFLICT_PRESENT_DESPITE_SKIPPED);
> +	       type =3D=3D CONFLICT_DIR_RENAME_SUGGESTED);
>  	if (opt->record_conflict_msgs_as_headers && omittable_hint)
>  		return; /* Do not record mere hints in headers */
>  	if (opt->priv->call_depth && opt->verbosity < 5)
> @@ -4377,22 +4373,8 @@ static int record_conflicted_index_entries(struct=
 merge_options *opt)
>  			 * the CE_SKIP_WORKTREE bit and manually write those
>  			 * files to the working disk here.
>  			 */
> -			if (ce_skip_worktree(ce)) {
> -				struct stat st;
> -
> -				if (!lstat(path, &st)) {
> -					char *new_name =3D unique_path(opt,
> -								     path,
> -								     "cruft");
> -
> -					path_msg(opt, CONFLICT_PRESENT_DESPITE_SKIPPED, 1,
> -						 path, NULL, NULL, NULL,
> -						 _("Note: %s not up to date and in way of checking out conflicted=
 version; old copy renamed to %s"),
> -						 path, new_name);
> -					errs |=3D rename(path, new_name);
> -				}
> +			if (ce_skip_worktree(ce))
>  				errs |=3D checkout_entry(ce, &state, NULL, NULL);
> -			}
>
>  			/*
>  			 * Mark this cache entry for removal and instead add
>
> base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
> --
> gitgitgadget
>
