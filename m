Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CC3C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 12:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245369AbiDGMop (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 08:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbiDGMon (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 08:44:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902B39BB99
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 05:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649335361;
        bh=lFmHBLY0WtFbzK12LBnzE7pDIZuaQWpzxq+6PNCyBWs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DYaM8Mdrf2gtXFrXxDkWLfDJ0MgAhvkYJLODB8voqD+ndYww91MOQX+BnIj5TpVWB
         RJ/JgjBhh7q0xToo9QOlz5rp6MIMnjg1PuXDtUwnKryRBbW4hhhCn9Bk3aIgOTTzNS
         0gIc8tF7jJBtUhcrtEEU9XXQ6TTr/eXrwrByCM5M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.255.204] ([89.1.214.127]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUnz-1nwHkG0dgH-00xuLx; Thu, 07
 Apr 2022 14:42:41 +0200
Date:   Thu, 7 Apr 2022 14:42:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Glen Choo <chooglen@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] fsck: detect bare repos in trees and warn
In-Reply-To: <20220406232231.47714-1-chooglen@google.com>
Message-ID: <nycvar.QRO.7.76.6.2204071440520.347@tvgsbejvaqbjf.bet>
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com> <20220406232231.47714-1-chooglen@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cro/TS4fBT17VAxaPEVqrdp25oWqFQkPpq6zDxoxaOkGaAozLmz
 DersZfZc+hvoHZUxvx0IgQb9v8Rh/NcXGh+mENHowcFDiUaKpqscEWgmolvMUEYCIWKblNB
 TBs/SgA2P+Mabw6vH1/GNxmUeVXds0RwnzrWsBVpuMGv8rTVUmif4VrHltLOpzf3Tt19LX+
 Ha4mMtYiHEQnCaLxifnZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mrumNNu0ypE=:hh2zSw1KwNTOCHL4vzBtj9
 pjHGktBq2x4NF4ziBR1z+MAZquqZS9EQYdcWT9pDGqA5ea0aBcWr0/ebEGqK/ERBnEOpsI3/G
 VhAI/ChB0f7Zr5ULCQcSyJNJcnY1BXjT3+kCJMfbyHevZCbSA8fClFMNTHVBCLR3DgPhNj8ft
 5JmrvV7caYr3BOKFn1L2to84awFAc0LIp2o8hOPW6yttGtRDysqJ5zj1D7lfWrFor1ibZPyCL
 YvnD+gHpo3dCSscW0U7/owm2eO9qXgxnRhSfHpkXB8WPhJMtP5FQsqu4Ua4aj1zLlaqQt7tDn
 zTDz/jIUWCLD5usoK3xninKy8ZMTJ1FvhGvhHOZNyGQMTJdDPhcXEa4nnlbBAVT3yWb7PV/fQ
 lyqYSgSVccyIZ5EjoBEocfB7FFTtUXq3k6oTdwE3e8ENfmITziNN/+vhNOHuWIu8B5IIg4e+R
 LIqQSBiIgRk5VFSH8sNSGizcMCsvfzolj04+ggZWw8QqTgvQKbigEhUIfA15fWynqK0oNU9rj
 8a8G4vltcWqU1uuFhBzQtAlueOXLhes0B8/TI5X9tWecff7x0qzVDBGIrUuKyZ2HT4nizMTzl
 h2WR6pDt/0aO6sZGumGeZ7QD7htv+LpJhmpyuOFC9fAiHFimotlXz3w2vXCsnQ4wjV9EHFayE
 ykzi3vGhRZQ57aKckthGSciSkeqdxcavnPqwDZ1QnqnwA00d1ulxrkfbdLnqKx6ddAHz8hR94
 RPrstrnYK5GuklKR4VLcYOi2ILg5IJMOr5XF6GFzDuy4m24yq0I21/prJAvZmePjwApRktGLY
 LawduUlxh8DAl0xlsjPWYHoicau+Hz5Co+d7Kxk3fovO8GUqyt05lBuBZj7VYUCfjdJjGhyYT
 3arhbqDMLSTCPCGP9lIhIDPo1ZPOWGRWNWLt2XcdahuRWE9bDZUZn/YPDBpZbug/eFx3CWnzs
 6F+CfpXCdLRMJ2x1fag3oZlE/h+AolSYUdOnQLDPbYDDLOD7g2hty+KJaBNU+6bzFaFXPEnZ6
 nPv1rO6z8iZKph/Bs3YMjo0rg09Mm2j/DpqcsvxgZ5oIFBsLHrB08ZHhpmUrF+Br/Zb5JZia4
 0BlcB2shn/dF6o=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

On Wed, 6 Apr 2022, Glen Choo wrote:

> Git tries not to distribute configs in-repo because they are a security
> risk. However, an attacker can do exactly this if they embed a bare
> repo inside of another repo.
>
> Teach fsck to detect whether a tree object contains a bare repo (as
> determined by setup.c) and warn. This will help hosting sites detect and
> prevent transmission of such malicious repos.
>
> See [1] for a more in-depth discussion, including future steps and
> alternatives.
>
> [1] https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roa=
m.corp.google.com/

Out of curiosity: does this new check trigger with
https://github.com/libgit2/libgit2? AFAIR it has embedded repositories
that are used in its test suite. In other words, libgit2 has a legitimate
use case for embedded bare repositories, I believe.

Thank you,
Johannes

>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  fsck.c          | 19 +++++++++++++++++++
>  fsck.h          |  1 +
>  setup.c         |  4 ++++
>  t/t1450-fsck.sh | 36 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+)
>
> diff --git a/fsck.c b/fsck.c
> index 3ec500d707..11c11c348a 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -573,6 +573,9 @@ static int fsck_tree(const struct object_id *tree_oi=
d,
>  	int has_bad_modes =3D 0;
>  	int has_dup_entries =3D 0;
>  	int not_properly_sorted =3D 0;
> +	int has_head =3D 0;
> +	int has_refs_entry =3D 0;
> +	int has_objects_entry =3D 0;
>  	struct tree_desc desc;
>  	unsigned o_mode;
>  	const char *o_name;
> @@ -602,6 +605,12 @@ static int fsck_tree(const struct object_id *tree_o=
id,
>  		has_dotdot |=3D !strcmp(name, "..");
>  		has_dotgit |=3D is_hfs_dotgit(name) || is_ntfs_dotgit(name);
>  		has_zero_pad |=3D *(char *)desc.buffer =3D=3D '0';
> +		has_head |=3D !strcasecmp(name, "HEAD")
> +			&& (S_ISLNK(mode) || S_ISREG(mode));
> +		has_refs_entry |=3D !strcasecmp(name, "refs")
> +			&& (S_ISLNK(mode) || S_ISDIR(mode));
> +		has_objects_entry |=3D !strcasecmp(name, "objects")
> +			&& (S_ISLNK(mode) || S_ISDIR(mode));
>
>  		if (is_hfs_dotgitmodules(name) || is_ntfs_dotgitmodules(name)) {
>  			if (!S_ISLNK(mode))
> @@ -739,6 +748,16 @@ static int fsck_tree(const struct object_id *tree_o=
id,
>  		retval +=3D report(options, tree_oid, OBJ_TREE,
>  				 FSCK_MSG_TREE_NOT_SORTED,
>  				 "not properly sorted");
> +	/*
> +	 * Determine if this tree looks like a bare repository according
> +	 * to the rules of setup.c. If those are changed, this should be
> +	 * changed too.
> +	 */
> +	if (has_head && has_refs_entry && has_objects_entry)
> +		retval +=3D report(options, tree_oid, OBJ_TREE,
> +				 FSCK_MSG_EMBEDDED_BARE_REPO,
> +				 "contains bare repository");
> +
>  	return retval;
>  }
>
> diff --git a/fsck.h b/fsck.h
> index d07f7a2459..3f0f73b0f3 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -65,6 +65,7 @@ enum fsck_msg_type {
>  	FUNC(NULL_SHA1, WARN) \
>  	FUNC(ZERO_PADDED_FILEMODE, WARN) \
>  	FUNC(NUL_IN_COMMIT, WARN) \
> +	FUNC(EMBEDDED_BARE_REPO, WARN) \
>  	/* infos (reported as warnings, but ignored by default) */ \
>  	FUNC(GITMODULES_PARSE, INFO) \
>  	FUNC(GITIGNORE_SYMLINK, INFO) \
> diff --git a/setup.c b/setup.c
> index 04ce33cdcd..2600548776 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -336,6 +336,10 @@ int get_common_dir_noenv(struct strbuf *sb, const c=
har *gitdir)
>   *  - either a HEAD symlink or a HEAD file that is formatted as
>   *    a proper "ref:", or a regular file HEAD that has a properly
>   *    formatted sha1 object name.
> + *
> + * fsck.c checks for bare repositories in trees using similar rules, bu=
t a
> + * duplicated implementation. If these are changed, the correspnding co=
de in
> + * fsck.c should change too.
>   */
>  int is_git_directory(const char *suspect)
>  {
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index de50c0ea01..a65827bc03 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -563,6 +563,42 @@ dot-backslash-case .\\\\.GIT\\\\foobar
>  dotgit-case-backslash .git\\\\foobar
>  EOF
>
> +test_expect_success "fsck notices bare repo" '
> +(
> +	mkdir -p embedded-bare-repo/bare &&
> +	git init embedded-bare-repo &&
> +	(
> +		cd embedded-bare-repo/bare &&
> +		echo content >HEAD &&
> +		mkdir refs/ objects/ &&
> +		echo content >refs/foo &&
> +		echo content >objects/foo &&
> +		git add . &&
> +		git commit -m base &&
> +		bad_tree=3D$(git rev-parse HEAD:bare) &&
> +		git fsck 2>out &&
> +		test_i18ngrep "warning.*tree $bad_tree: embeddedBareRepo: contains ba=
re repository" out
> +	)
> +)'
> +
> +test_expect_success "fsck notices bare repo with odd casing" '
> +(
> +	mkdir -p embedded-bare-repo-case/bare &&
> +	git init embedded-bare-repo-case &&
> +	(
> +		cd embedded-bare-repo-case/bare &&
> +		echo content >heAD &&
> +		mkdir Refs/ objectS/ &&
> +		echo content >Refs/foo &&
> +		echo content >objectS/foo &&
> +		git add . &&
> +		git commit -m base &&
> +		bad_tree=3D$(git rev-parse HEAD:bare) &&
> +		git fsck 2>out &&
> +		test_i18ngrep "warning.*tree $bad_tree: embeddedBareRepo: contains ba=
re repository" out
> +	)
> +)'
> +
>  test_expect_success 'fsck allows .??it' '
>  	(
>  		git init not-dotgit &&
>
> base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b
> --
> 2.33.GIT
>
>
