Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C6EC433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 16:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B0120671
	for <git@archiver.kernel.org>; Wed, 13 May 2020 16:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YOCzJERP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbgEMQwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 12:52:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56054 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgEMQwA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 12:52:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BDF6531BE;
        Wed, 13 May 2020 12:51:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wrzn65hv3apc
        QiDKR7ugjkUvYKw=; b=YOCzJERPBtTjidr9PSyzsPr80xlfkM+lYSWr9aVmSJKx
        bxMtCUPMsyygTg5Q0YDRjxkAmzymFO3QRlCWw3IjMhcuWte+g3CDsPZXj0+dF7Ys
        RMiM+KEBZbiizmO9+wD/ffgVXeQCcKTXaSUc77IBgTglGsRt/2/cw7ATm6cU840=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=BGNkgv
        OWKNYovWlDzEjNVY/TSYqFjwonaSUDAH+gch6twKG5sMBvUaX9K/tzXUxtStdcCZ
        k7q29ifLdlCEKofRLTqeWYuCBfcdqfgNRl/bZIV8Zc7nKNZFBVhcy2YxgdtuOwmb
        f6mnhyJZKLnbMvkEwBV7snzERbv41fanSxD5A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90F29531BD;
        Wed, 13 May 2020 12:51:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BD75531BA;
        Wed, 13 May 2020 12:51:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] CI: enable t1509 in Travis and GitHub Actions
References: <cover.1589375923.git.congdanhqx@gmail.com>
        <fa2e1f7b44262eac1fa26161fc5d3f3b9b6bdb47.1589375923.git.congdanhqx@gmail.com>
Date:   Wed, 13 May 2020 09:51:56 -0700
In-Reply-To: <fa2e1f7b44262eac1fa26161fc5d3f3b9b6bdb47.1589375923.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Wed, 13 May
 2020 20:23:07 +0700")
Message-ID: <xmqq8shvvkur.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0E69298A-953A-11EA-8489-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>  ci/lib.sh              | 13 +++++++++++++
>  ci/run-docker-build.sh |  3 +++
>  2 files changed, 16 insertions(+)
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index dac36886e3..e9c22ae718 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -113,6 +113,7 @@ then
>  	export GIT_PROVE_OPTS=3D"--timer --jobs 3 --state=3Dfailed,slow,save"
>  	export GIT_TEST_OPTS=3D"--verbose-log -x --immediate"
>  	MAKEFLAGS=3D"$MAKEFLAGS --jobs=3D2"
> +	t1509_allowed=3DYES
>  elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIO=
NSURI"
>  then
>  	CI_TYPE=3Dazure-pipelines
> @@ -162,6 +163,7 @@ then
>  	echo "::add-matcher::ci/git-problem-matcher.json"
>  	test linux-musl =3D "$jobname" ||
>  	MAKEFLAGS=3D"$MAKEFLAGS TEST_SHELL_PATH=3D/bin/sh"
> +	t1509_allowed=3DYES
>  else
>  	echo "Could not identify CI type" >&2
>  	env >&2
> @@ -184,6 +186,17 @@ export DEVELOPER=3D1
>  export DEFAULT_TEST_TARGET=3Dprove
>  export GIT_TEST_CLONE_2GB=3Dtrue
> =20
> +if test "$t1509_allowed" =3D YES
> +then
> +	case "$jobname" in
> +	osx-*) ;;
> +	*)
> +		chmod a+w / || sudo chmod a+w / || true
> +		export IKNOWWHATIAMDOING=3DYES

Eeeww ;-)  This makes readers wonder where we did not enable the
test and why.  Perhaps throw in a matching

	t1509_allowed=3DNO

in the azure thing for completeness?

Also, do we want to give a more descriptive name than t1509 to the
variable, say, ROOT_WORK_TREE_TEST_ALLOWED?

> diff --git a/ci/run-docker-build.sh b/ci/run-docker-build.sh
> index 8d47a5fda3..026afe275a 100755
> --- a/ci/run-docker-build.sh
> +++ b/ci/run-docker-build.sh
> @@ -58,6 +58,8 @@ else
>  	test -n "$cache_dir" && chown -R $HOST_UID:$HOST_UID "$cache_dir"
>  fi
> =20
> +chmod a+w /
> +
>  # Build and test
>  command $switch_cmd su -m -l $CI_USER -c "
>  	set -ex
> @@ -68,6 +70,7 @@ command $switch_cmd su -m -l $CI_USER -c "
>  	export GIT_TEST_CLONE_2GB=3D'$GIT_TEST_CLONE_2GB'
>  	export MAKEFLAGS=3D'$MAKEFLAGS'
>  	export cache_dir=3D'$cache_dir'
> +	export IKNOWWHATIAMDOING=3DYES
>  	cd /usr/src/git
>  	test -n '$cache_dir' && ln -s '$cache_dir/.prove' t/.prove
>  	make

Big EWWWWWWwwww.  Do we need to do this for _all_ tests, not
selectively only while running t1509?  This makes me worried as a
test by mistake can easily corrupt the VM and invalidating the
tests; I know we get a fresh one every time, so there is no
permanent harm done by corrupting it, but having one fewer thing we
have to worry about is always better than having one more thing.
