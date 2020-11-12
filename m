Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A158EC2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 20:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4168D216C4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 20:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oximhHKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgKLUcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 15:32:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55646 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgKLUcN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 15:32:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A66DF1B6C;
        Thu, 12 Nov 2020 15:32:07 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fbp2XQOzapSv
        wxh/fx8TSad4Ogo=; b=oximhHKiT2iGeakswCaTNg59sdpGYsnffzWOFfZZzxaq
        lxCLfLpYAvPyJedhVr8ndim0SDm+NuxMvRmO1BUQfBuykTK2FWV915JFE9sdEEgA
        vXGvSBdUsrygKAeMQDImrVTp/IlgPSNnZfot5A4KOROhgkpZ0iXGJejF+tzQBeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=urnaKR
        gxVVElJeN/p5ECnpo+7Anh8xsWuPoFcp919pZOcuYZF/NpNS7frkDQhtQT11jw3e
        Aq3gWnmfDQPgnAP61u5vP7JCu6ejqH3Kg9pihIqqEXnNmy7RgTy+l36B566K+7Cf
        GJPfylP2zpHuC1kjHWUwakxkTsDA51aBuGEng=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12E3AF1B6B;
        Thu, 12 Nov 2020 15:32:07 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 008A1F1B68;
        Thu, 12 Nov 2020 15:32:03 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] parse-remote: remove this now-unused library
Date:   Thu, 12 Nov 2020 12:31:55 -0800
Message-Id: <20201112203155.3342586-3-gitster@pobox.com>
X-Mailer: git-send-email 2.29.2-442-ga30192deef
In-Reply-To: <20201112203155.3342586-1-gitster@pobox.com>
References: <xmqqwnyr4zv8.fsf@gitster.c.googlers.com>
 <20201112203155.3342586-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 1FF67BCC-2526-11EB-9C75-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Since the previous step stopped dot-sourcing it from
git-submodule.sh, nothing uses git-parse-remote, which
still has two unused functions.  Remove the dead code
together with the file itself and documentation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore                         |  1 -
 Documentation/git-parse-remote.txt | 23 --------
 Makefile                           |  2 -
 command-list.txt                   |  1 -
 git-parse-remote.sh                | 94 ------------------------------
 5 files changed, 121 deletions(-)
 delete mode 100644 Documentation/git-parse-remote.txt
 delete mode 100644 git-parse-remote.sh

diff --git a/.gitignore b/.gitignore
index 6232d33924..9da275e4e8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -114,7 +114,6 @@
 /git-pack-redundant
 /git-pack-objects
 /git-pack-refs
-/git-parse-remote
 /git-patch-id
 /git-prune
 /git-prune-packed
diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse=
-remote.txt
deleted file mode 100644
index a45ea1ece8..0000000000
--- a/Documentation/git-parse-remote.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-git-parse-remote(1)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-NAME
-----
-git-parse-remote - Routines to help parsing remote repository access par=
ameters
-
-
-SYNOPSIS
---------
-[verse]
-'. "$(git --exec-path)/git-parse-remote"'
-
-DESCRIPTION
------------
-This script is included in various scripts to supply
-routines to parse files under $GIT_DIR/remotes/ and
-$GIT_DIR/branches/ and configuration variables that are related
-to fetching, pulling and pushing.
-
-GIT
----
-Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 1fb0ec1705..9c154a2666 100644
--- a/Makefile
+++ b/Makefile
@@ -613,7 +613,6 @@ SCRIPT_SH +=3D git-submodule.sh
 SCRIPT_SH +=3D git-web--browse.sh
=20
 SCRIPT_LIB +=3D git-mergetool--lib
-SCRIPT_LIB +=3D git-parse-remote
 SCRIPT_LIB +=3D git-rebase--preserve-merges
 SCRIPT_LIB +=3D git-sh-i18n
 SCRIPT_LIB +=3D git-sh-setup
@@ -2577,7 +2576,6 @@ XGETTEXT_FLAGS_PERL =3D $(XGETTEXT_FLAGS) --languag=
e=3DPerl \
 	--keyword=3D__ --keyword=3DN__ --keyword=3D"__n:1,2"
 LOCALIZED_C =3D $(C_OBJ:o=3Dc) $(LIB_H) $(GENERATED_H)
 LOCALIZED_SH =3D $(SCRIPT_SH)
-LOCALIZED_SH +=3D git-parse-remote.sh
 LOCALIZED_SH +=3D git-rebase--preserve-merges.sh
 LOCALIZED_SH +=3D git-sh-setup.sh
 LOCALIZED_PERL =3D $(SCRIPT_PERL)
diff --git a/command-list.txt b/command-list.txt
index 0e3204e7d1..c19c8a94fe 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -135,7 +135,6 @@ git-p4                                  foreignscmint=
erface
 git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
 git-pack-refs                           ancillarymanipulators
-git-parse-remote                        synchelpers
 git-patch-id                            purehelpers
 git-prune                               ancillarymanipulators   complete
 git-prune-packed                        plumbingmanipulators
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
deleted file mode 100644
index 0c2a5ef6c4..0000000000
--- a/git-parse-remote.sh
+++ /dev/null
@@ -1,94 +0,0 @@
-# This is a shell library to calculate the remote repository and
-# upstream branch that should be pulled by "git pull" from the current
-# branch.
-
-# git-ls-remote could be called from outside a git managed repository;
-# this would fail in that case and would issue an error message.
-GIT_DIR=3D$(git rev-parse -q --git-dir) || :;
-
-get_remote_merge_branch () {
-	case "$#" in
-	0|1)
-	    origin=3D"$1"
-	    default=3D$(get_default_remote)
-	    test -z "$origin" && origin=3D$default
-	    curr_branch=3D$(git symbolic-ref -q HEAD) &&
-	    [ "$origin" =3D "$default" ] &&
-	    echo $(git for-each-ref --format=3D'%(upstream)' $curr_branch)
-	    ;;
-	*)
-	    repo=3D$1
-	    shift
-	    ref=3D$1
-	    # FIXME: It should return the tracking branch
-	    #        Currently only works with the default mapping
-	    case "$ref" in
-	    +*)
-		ref=3D$(expr "z$ref" : 'z+\(.*\)')
-		;;
-	    esac
-	    expr "z$ref" : 'z.*:' >/dev/null || ref=3D"${ref}:"
-	    remote=3D$(expr "z$ref" : 'z\([^:]*\):')
-	    case "$remote" in
-	    '' | HEAD ) remote=3DHEAD ;;
-	    heads/*) remote=3D${remote#heads/} ;;
-	    refs/heads/*) remote=3D${remote#refs/heads/} ;;
-	    refs/* | tags/* | remotes/* ) remote=3D
-	    esac
-	    [ -n "$remote" ] && case "$repo" in
-		.)
-		    echo "refs/heads/$remote"
-		    ;;
-		*)
-		    echo "refs/remotes/$repo/$remote"
-		    ;;
-	    esac
-	esac
-}
-
-error_on_missing_default_upstream () {
-	cmd=3D"$1"
-	op_type=3D"$2"
-	op_prep=3D"$3" # FIXME: op_prep is no longer used
-	example=3D"$4"
-	branch_name=3D$(git symbolic-ref -q HEAD)
-	display_branch_name=3D"${branch_name#refs/heads/}"
-	# If there's only one remote, use that in the suggestion
-	remote=3D"$(gettext "<remote>")"
-	branch=3D"$(gettext "<branch>")"
-	if test $(git remote | wc -l) =3D 1
-	then
-		remote=3D$(git remote)
-	fi
-
-	if test -z "$branch_name"
-	then
-		gettextln "You are not currently on a branch."
-	else
-		gettextln "There is no tracking information for the current branch."
-	fi
-	case "$op_type" in
-	rebase)
-		gettextln "Please specify which branch you want to rebase against."
-		;;
-	merge)
-		gettextln "Please specify which branch you want to merge with."
-		;;
-	*)
-		echo >&2 "BUG: unknown operation type: $op_type"
-		exit 1
-		;;
-	esac
-	eval_gettextln "See git-\${cmd}(1) for details."
-	echo
-	echo "    $example"
-	echo
-	if test -n "$branch_name"
-	then
-		gettextln "If you wish to set tracking information for this branch you=
 can do so with:"
-		echo
-		echo "    git branch --set-upstream-to=3D$remote/$branch $display_bran=
ch_name"
-		echo
-	fi
-	exit 1
-}
--=20
2.29.2-442-ga30192deef

