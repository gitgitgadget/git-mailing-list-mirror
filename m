Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A4AC433ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 07:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16FB61244
	for <git@archiver.kernel.org>; Sun,  2 May 2021 07:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhEBIAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 04:00:17 -0400
Received: from mout.web.de ([212.227.15.4]:53475 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhEBIAR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 04:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1619942361;
        bh=zmKbRptdTCS+obttzv0nqgtTJJ4/DvREOCJ6JKkIlio=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MIhd7O011m7C8MZgBuQsfcpax8SzUKoYV+aZmUR3WVfGly6U7af/ngVqp7RnF/IIz
         Bw90Xj0w1Oa1eHzFdkv1PK0uvV+uyWpqOicxoy4djIcPTaHNl+UUDKnTYehN6Fvlq9
         Xl/7mmyzgE9eDkeZsK1EDJ/ZkzytO9GPAge/tWzQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ma2hT-1lr3l02vIV-00Lq4O; Sun, 02
 May 2021 09:59:21 +0200
Date:   Sun, 2 May 2021 09:59:20 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        git@jeffhostetler.com, stolee@gmail.com
Subject: Re: [PATCH v2 5/8] parallel-checkout: add tests related to path
 collisions
Message-ID: <20210502075920.d2rdmuix7r34sas2@tb-raspi4>
References: <cover.1619818517.git.matheus.bernardino@usp.br>
 <eae6d3a1c16e440f18fd60d69b061d15ffbfe8e7.1619818517.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae6d3a1c16e440f18fd60d69b061d15ffbfe8e7.1619818517.git.matheus.bernardino@usp.br>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:0nrBAXrjG1cGOLMHlsBwDxhZWAHKpD26OaLBqb3sZIlAJeqePxq
 qhD1xrG+GEQnpklDyxhSKDtf53T195+Q1fnAdhm1q5QV7bjUQLZGdQk5wFlegfs5zhPKAxK
 X4MPBMULuABoBQWWhlaH6HnTpip2/dp26zOq+C/Ju9IgdB+qs3g4+hTMlbmxEbiy/ptS7sb
 3sqQoY6EDIabdtfZTyT9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dN3nTrFSWEA=:iqzo2O21CZCqqceVntrtqL
 huYlUOpVUSivAFBJ5NrTlBENtmor2b968824umIqCqfFzbDVZfR7FA5JzG3aJMNHAfK/EBjEY
 bWZ1/8q+ryDLO6REfnjuBL7Xwdn9EUPecpH6QeVtLRMo8Boqlit0ABOnnK9wvZsR+P5TYcXER
 AgYaF3ck6rxdvw1lsMxXoqt3P2l0VFUVFi5QE63qUFH4HTMxomXOdY7w+4NEIJSezb6DDIo6f
 g1wKg2mJlsOH7/CeZUdJjqjo60coVS33GT+hPKUsTWQaGJq1dHAgfMyVrQ6bG+xtoYNGDY0xp
 hEXFcEu5W3g6X44f1TL/lhZ00xqFNx4WabAjyvWbqGKxwOvR45ei6pD3eDZ368mB7TF5Lvr+c
 lkvXKEUMPNVx/ELG5j47Zq3Ut8aYot9YAT2YZRGmmdbNmCd2B43S0TZgXD3QCcpviNz7MFsdo
 hoMP9Bqtuo6GOcRjGYxraoQwJPGONo6tkNuAGeP3YPc6zB6QtlRxqZfGZkJZfXK2r40lDi5nk
 XA+nNFN6ynGSG01+0sc4lZdccEoTnPD89g//lyCL6IDA236dv9VO+93VAfqcDk6pdyoeGayj7
 dTKj+IkYgThEeCeghRHhm5c7jsO/cjt0oFtyrFNkF5qx/q+qQLqKy7QfHbC4np81C/NM19flP
 eu3xD1VB9FCm+FO+w767+eRrzY6oAcRX7aqdZdmURVwGvhqxVLzRi/ChAvDtCQ97VuMOvtA0d
 gRaLTPF9PfN60XehBHJDH+OlWVJ1O3uL01aVE+Gw+euCNtCLVpAnXWgWJZh6LQ54VgH5lMUGT
 eoZKFe91vvGpTUZ5rwPcv1MHpaleeGCzvHluuSt14m4I0RtV+sj/I/A55l9twWHqIAhJ+4C6i
 YCiJyvqi32zGS/EKd9rKQjwrw9wiRQUTF1MZHRDoUH1e+6S2rQ8UH3cKCewFJMKtzJiQaxpjR
 fPlhhcOOmHdkg1N4TkOFRPaJhdAvu6Ndh6UA61YS78qtiTLDaYxyUTDrikWxIo1pXjZXUDCud
 uZHN8/HjZ0I0GTd+o8fyhCklyNRS2C7gDkRVZHqM4XGU1LWD8BH/s4j59UsFDvGPq884z1b5i
 5f1sjE5d/IrwowUgrJZBWOtQvx/HAV7fmEMH4upC5Y/ofq+eMyxBjNuYJUtlMO4GFhE3ZpAP4
 EzlOALJV6xgGTOy/9n9VmUEKIgVKCMhg8iw0viCnDuAv2ZlYo38eUsKG+6ve+ru/Ph3RI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 06:40:32PM -0300, Matheus Tavares wrote:
> Add tests to confirm that path collisions are properly detected by
> checkout workers, both to avoid race conditions and to report colliding
> entries on clone.
>
> Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  parallel-checkout.c                     |   4 +
>  t/lib-parallel-checkout.sh              |   4 +-
>  t/t2081-parallel-checkout-collisions.sh | 162 ++++++++++++++++++++++++
>  3 files changed, 168 insertions(+), 2 deletions(-)
>  create mode 100755 t/t2081-parallel-checkout-collisions.sh
>
> diff --git a/parallel-checkout.c b/parallel-checkout.c
> index 09e8b10a35..6fb3f1e6c9 100644
> --- a/parallel-checkout.c
> +++ b/parallel-checkout.c
> @@ -8,6 +8,7 @@
>  #include "sigchain.h"
>  #include "streaming.h"
>  #include "thread-utils.h"
> +#include "trace2.h"
>
>  struct pc_worker {
>  	struct child_process cp;
> @@ -326,6 +327,7 @@ void write_pc_item(struct parallel_checkout_item *pc=
_item,
>  	if (dir_sep && !has_dirs_only_path(path.buf, dir_sep - path.buf,
>  					   state->base_dir_len)) {
>  		pc_item->status =3D PC_ITEM_COLLIDED;
> +		trace2_data_string("pcheckout", NULL, "collision/dirname", path.buf);
>  		goto out;
>  	}
>
> @@ -341,6 +343,8 @@ void write_pc_item(struct parallel_checkout_item *pc=
_item,
>  			 * call should have already caught these cases.
>  			 */
>  			pc_item->status =3D PC_ITEM_COLLIDED;
> +			trace2_data_string("pcheckout", NULL,
> +					   "collision/basename", path.buf);
>  		} else {
>  			error_errno("failed to open file '%s'", path.buf);
>  			pc_item->status =3D PC_ITEM_FAILED;
> diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
> index f60b22ef34..d6740425b1 100644
> --- a/t/lib-parallel-checkout.sh
> +++ b/t/lib-parallel-checkout.sh
> @@ -22,12 +22,12 @@ test_checkout_workers () {
>
>  	local trace_file=3Dtrace-test-checkout-workers &&
>  	rm -f "$trace_file" &&
> -	GIT_TRACE2=3D"$(pwd)/$trace_file" "$@" &&
> +	GIT_TRACE2=3D"$(pwd)/$trace_file" "$@" 2>&8 &&
>
>  	local workers=3D$(grep "child_start\[..*\] git checkout--worker" "$tra=
ce_file" | wc -l) &&
>  	test $workers -eq $expected_workers &&
>  	rm "$trace_file"
> -}
> +} 8>&2 2>&4
>
>  # Verify that both the working tree and the index were created correctl=
y
>  verify_checkout () {
> diff --git a/t/t2081-parallel-checkout-collisions.sh b/t/t2081-parallel-=
checkout-collisions.sh
> new file mode 100755
> index 0000000000..f6fcfc0c1e
> --- /dev/null
> +++ b/t/t2081-parallel-checkout-collisions.sh
> @@ -0,0 +1,162 @@
> +#!/bin/sh
> +
> +test_description=3D"path collisions during parallel checkout
> +
> +Parallel checkout must detect path collisions to:
> +
> +1) Avoid racily writing to different paths that represent the same file=
 on disk.
> +2) Report the colliding entries on clone.
> +
> +The tests in this file exercise parallel checkout's collision detection=
 code in
> +both these mechanics.
> +"
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-parallel-checkout.sh"

Why this $TEST_DIRECTORY ?
Aren't all files under the t/ directory, where test-lib.sh is as well ?
(The $TEST_DIRECTORY macro is used at different places, so I may have miss=
ed
something)

> +
> +TEST_ROOT=3D"$PWD"
> +
> +test_expect_success CASE_INSENSITIVE_FS 'setup' '
> +	empty_oid=3D$(git hash-object -w --stdin </dev/null) &&
> +	cat >objs <<-EOF &&
> +	100644 $empty_oid	FILE_X
> +	100644 $empty_oid	FILE_x
> +	100644 $empty_oid	file_X
> +	100644 $empty_oid	file_x
> +	EOF
> +	git update-index --index-info <objs &&
> +	git commit -m "colliding files" &&
> +	git tag basename_collision &&
> +
> +	write_script "$TEST_ROOT"/logger_script <<-\EOF
> +	echo "$@" >>filter.log
> +	EOF
> +'
> +
> +test_workers_in_event_trace ()
> +{
> +	test $1 -eq $(grep ".event.:.child_start..*checkout--worker" $2 | wc -=
l)
> +}
> +
> +test_expect_success CASE_INSENSITIVE_FS 'worker detects basename collis=
ion' '
> +	GIT_TRACE2_EVENT=3D"$(pwd)/trace" git \
> +		-c checkout.workers=3D2 -c checkout.thresholdForParallelism=3D0 \
> +		checkout . &&
> +
> +	test_workers_in_event_trace 2 trace &&
> +	collisions=3D$(grep -i "category.:.pcheckout.,.key.:.collision/basenam=
e.,.value.:.file_x.}" trace | wc -l) &&
> +	test $collisions -eq 3
> +'
> +
> +test_expect_success CASE_INSENSITIVE_FS 'worker detects dirname collisi=
on' '
> +	test_config filter.logger.smudge "\"$TEST_ROOT/logger_script\" %f" &&
> +	empty_oid=3D$(git hash-object -w --stdin </dev/null) &&
> +
> +	# By setting a filter command to "a", we make it ineligible for parall=
el
> +	# checkout, and thus it is checked out *first*. This way we can ensure
> +	# that "A/B" and "A/C" will both collide with the regular file "a".
> +	#
> +	attr_oid=3D$(echo "a filter=3Dlogger" | git hash-object -w --stdin) &&
> +
> +	cat >objs <<-EOF &&
> +	100644 $empty_oid	A/B
> +	100644 $empty_oid	A/C
> +	100644 $empty_oid	a
> +	100644 $attr_oid	.gitattributes
> +	EOF
> +	git rm -rf . &&
> +	git update-index --index-info <objs &&
> +
> +	rm -f trace filter.log &&
> +	GIT_TRACE2_EVENT=3D"$(pwd)/trace" git \
> +		-c checkout.workers=3D2 -c checkout.thresholdForParallelism=3D0 \
> +		checkout . &&
> +
> +	# Check that "a" (and only "a") was filtered
> +	echo a >expected.log &&
> +	test_cmp filter.log expected.log &&
> +
> +	# Check that it used the right number of workers and detected the coll=
isions
> +	test_workers_in_event_trace 2 trace &&
> +	grep "category.:.pcheckout.,.key.:.collision/dirname.,.value.:.A/B.}" =
trace &&
> +	grep "category.:.pcheckout.,.key.:.collision/dirname.,.value.:.A/C.}" =
trace
> +'
> +
> +test_expect_success SYMLINKS,CASE_INSENSITIVE_FS 'do not follow symlink=
s colliding with leading dir' '
> +	empty_oid=3D$(git hash-object -w --stdin </dev/null) &&
> +	symlink_oid=3D$(echo "./e" | git hash-object -w --stdin) &&
> +	mkdir e &&
> +
> +	cat >objs <<-EOF &&
> +	120000 $symlink_oid	D
> +	100644 $empty_oid	d/x
> +	100644 $empty_oid	e/y
> +	EOF
> +	git rm -rf . &&
> +	git update-index --index-info <objs &&
> +
> +	set_checkout_config 2 0 &&
> +	test_checkout_workers 2 git checkout . &&
> +	test_path_is_dir e &&
> +	test_path_is_missing e/x
> +'
> +
> +# The two following tests check that parallel checkout correctly report=
s
> +# colliding entries on clone. The sequential code detects a collision b=
y
> +# calling lstat() before trying to open(O_CREAT) a file. (Note that thi=
s only
> +# works for clone.) Then, to find the pair of a colliding item k, it se=
arches
> +# cache_entry[0, k-1]. This is not sufficient in parallel checkout beca=
use:
> +#
> +# - A colliding file may be created between the lstat() and open() call=
s;
> +# - A colliding entry might appear in the second half of the cache_entr=
y array.
> +#
> +test_expect_success CASE_INSENSITIVE_FS 'collision report on clone (w/ =
racy file creation)' '
> +	git reset --hard basename_collision &&
> +	set_checkout_config 2 0 &&
> +	test_checkout_workers 2 git clone . clone-repo 2>stderr &&
> +
> +	grep FILE_X stderr &&
> +	grep FILE_x stderr &&
> +	grep file_X stderr &&
> +	grep file_x stderr &&
> +	grep "the following paths have collided" stderr
> +'
> +
> +# This test ensures that the collision report code is correctly looking=
 for
> +# colliding peers in the second half of the cache_entry array. This is =
done by
> +# defining a smudge command for the *last* array entry, which makes it
> +# non-eligible for parallel-checkout. Thus, it is checked out *first*, =
before
> +# spawning the workers.
> +#
> +# Note: this test doesn't work on Windows because, on this system, the
> +# collision report code uses strcmp() to find the colliding pairs when
> +# core.ignoreCase is false. And we need this setting for this test so t=
hat only
> +# 'file_x' matches the pattern of the filter attribute. But the test wo=
rks on
> +# OSX, where the colliding pairs are found using inode.
> +#
> +test_expect_success CASE_INSENSITIVE_FS,!MINGW,!CYGWIN \
> +	'collision report on clone (w/ colliding peer after the detected entry=
)' '
> +
> +	test_config_global filter.logger.smudge "\"$TEST_ROOT/logger_script\" =
%f" &&
> +	git reset --hard basename_collision &&
> +	echo "file_x filter=3Dlogger" >.gitattributes &&
> +	git add .gitattributes &&
> +	git commit -m "filter for file_x" &&
> +
> +	rm -rf clone-repo &&
> +	set_checkout_config 2 0 &&
> +	test_checkout_workers 2 \
> +		git -c core.ignoreCase=3Dfalse clone . clone-repo 2>stderr &&
> +
> +	grep FILE_X stderr &&
> +	grep FILE_x stderr &&
> +	grep file_X stderr &&
> +	grep file_x stderr &&
> +	grep "the following paths have collided" stderr &&
> +
> +	# Check that only "file_x" was filtered
> +	echo file_x >expected.log &&
> +	test_cmp clone-repo/filter.log expected.log
> +'
> +
> +test_done
> --
> 2.30.1
>
