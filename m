Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3311620248
	for <e@80x24.org>; Fri,  5 Apr 2019 14:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbfDEORg (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 10:17:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:52541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729833AbfDEORf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 10:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554473846;
        bh=zSiEaMVs+yhpJ73YOTpz4ZfL9NLUG5XBqzlXJ+2xzG8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DVtyCEw6LvJSf183RacOAYURvEJTsRQGmJIm3GXNcYytrJ3H7aoP+1ZVSo3aTpO8J
         htaNd1o7PuX189yLzLgx0iy2ch+qN/ieA2hBwTOD/myl4gniP0lXlLrdXRWNiS29yq
         IBe86wqrrq2IkECf53IxPXbkokoRqKZ1YcfFJwrA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaqeA-1hVbCe0Zys-00KTQF; Fri, 05
 Apr 2019 16:17:26 +0200
Date:   Fri, 5 Apr 2019 16:17:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org, peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH v2 2/2] diff: batch fetching of missing blobs
In-Reply-To: <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.1904051615480.41@tvgsbejvaqbjf.bet>
References: <20190326220906.111879-1-jonathantanmy@google.com> <cover.1553895166.git.jonathantanmy@google.com> <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:b1V8fUYGguT+/r8HiFNTyVYuHzx4nnBJlZytk7Xr+GtE5VXkGRy
 wVGgBmhoQfyXCIyZEVpvgfUY+Xur017XjGu6A1ez/UM3gGF2S+BjmXKYAPo9j8kS5Iaoifb
 4rNa+L7gq0mWDNLdC+RQAfKci0hI/yRhhA3QdJNHoIoP9qyN+Qb2IFfPe6cLBT/fs5mecqc
 MQpLuU9MU0BaPqrs6VwCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L4UYNqdt2mU=:fXOiylVpKpjAiQDK0B+CJ3
 yoHT92A3CTEmnax6dMEYWwDmTEjA90ag3b7J67TWW0BRDVMfeEZDpFrVCV489gNL656N+6q2k
 8D4BkMDM799qwsvn0QJPDG2rIGx01+HFJh3zNGkNZnoZMEjBqxcX8spTMLypXEgQ1b1nFrqRM
 hz/HSleZ5si5SzcGej/CIr391C9KyBpqGvF5ez8hs0WMYbccMaC+nWC8l5c0uWYmxw/eaQHnG
 fhc4m1KLa2T5id+ubT/1HI8pqY4umaI9jJYZxBd2zXTZa04kfiqSLX5t2RuC/f9YkVxmikjkd
 grQLIy0aR5BHekcOQvt9Jo8DFrnjVKOyMp/cU9mP/5W+s1YCJgLpj55sGbKKzWAVRKikD8eX7
 gegr3o5/E/+GP/KN5tjoSNQw6vHwItBmJghf7yHbUKz4uZfbHfQtWQvkr+v1BpjEzNi+ckvqe
 zew+Y08AHw71chQuG+/Gv8SJMyeipM/HQ7aFMoPDSJ94OQUmLWy/npQULGbb2R7X6oYHfe/RH
 xANp8aLj3NmWvgoPpUyDE57Qg5fvoe1iGGGpSJKbiFgOAqyrK/zQWjhl5DNdhatTP5vX7IAHi
 SvnbFAC0eo+lvLbs24/nJp1NVb4xY7P4HSFNLnm3TsfQbcAg7YuAwk5KmtuIg1Omt9RJ8+dAm
 Z9LeBEpSM/RN51CM6zfzBGi/hEs0CPVp5Ttc6RWOnnLupVwjX/yr3fNdOQpi4nUrSjQuHWFTu
 wQIPNn8o9DDrza3KkPW1qDLwvqB4BG8rPWJdNryPavNnLM3D9ewnbYMB2z1VTKROewNkHOBJq
 Kj2UdQKD6Q7PerQUx74fwgfL9xACMzj7q2EQNKpwcRwUDJ+jc6v67LWy2HRxlgaOczKmwqFCx
 MHyyZmElIBgsawl/DwUoouqBHT73H/sk6ytNkUID8+Ze2qt2viNyi3cGsIw7bOeks40MIjVjL
 /koKWu8BAbw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Fri, 29 Mar 2019, Jonathan Tan wrote:

> When running a command like "git show" or "git diff" in a partial clone,
> batch all missing blobs to be fetched as one request.
>
> This is similar to c0c578b33c ("unpack-trees: batch fetching of missing
> blobs", 2017-12-08), but for another command.

Still makes sense ;-)

> diff --git a/diff.c b/diff.c
> index ec5c095199..1eccefb4ef 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -25,6 +25,7 @@
>  #include "packfile.h"
>  #include "parse-options.h"
>  #include "help.h"
> +#include "fetch-object.h"
>
>  #ifdef NO_FAST_WORKING_DIRECTORY
>  #define FAST_WORKING_DIRECTORY 0
> @@ -6366,8 +6367,39 @@ void diffcore_fix_diff_index(void)
>  	QSORT(q->queue, q->nr, diffnamecmp);
>  }
>
> +static void add_if_missing(struct oid_array *to_fetch,
> +			   const struct diff_filespec *filespec)
> +{
> +	if (filespec && filespec->oid_valid &&
> +	    oid_object_info_extended(the_repository, &filespec->oid, NULL,
> +				     OBJECT_INFO_FOR_PREFETCH))
> +		oid_array_append(to_fetch, &filespec->oid);
> +}

Thank you for introducing this, in looks more elegant to my eyes than the
previous iteration.

> +
>  void diffcore_std(struct diff_options *options)
>  {
> +	if (repository_format_partial_clone) {
> +		/*
> +		 * Prefetch the diff pairs that are about to be flushed.
> +		 */
> +		int i;
> +		struct diff_queue_struct *q =3D &diff_queued_diff;
> +		struct oid_array to_fetch =3D OID_ARRAY_INIT;
> +
> +		for (i =3D 0; i < q->nr; i++) {
> +			struct diff_filepair *p =3D q->queue[i];
> +			add_if_missing(&to_fetch, p->one);
> +			add_if_missing(&to_fetch, p->two);
> +		}
> +		if (to_fetch.nr)
> +			/*
> +			 * NEEDSWORK: Consider deduplicating the OIDs sent.
> +			 */
> +			fetch_objects(repository_format_partial_clone,
> +				      to_fetch.oid, to_fetch.nr);
> +		oid_array_clear(&to_fetch);
> +	}
> +
>  	/* NOTE please keep the following in sync with diff_tree_combined() */
>  	if (options->skip_stat_unmatch)
>  		diffcore_skip_stat_unmatch(options);
> diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.=
sh
> new file mode 100755

Also: thank you very much for introducing this test script, to make sure
that things work as expected. Without it, we would not have detected any
regression wrt multi-promisor.

This iteration looks good to me, thank you so much!
Dscho

> index 0000000000..349851be7d
> --- /dev/null
> +++ b/t/t4067-diff-partial-clone.sh
> @@ -0,0 +1,103 @@
> +#!/bin/sh
> +
> +test_description=3D'behavior of diff when reading objects in a partial =
clone'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'git show batches blobs' '
> +	test_when_finished "rm -rf server client trace" &&
> +
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	echo b >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=3Dblob:limit=3D0 "file://$(pwd)/server" clie=
nt &&
> +
> +	# Ensure that there is exactly 1 negotiation by checking that there is
> +	# only 1 "done" line sent. ("done" marks the end of negotiation.)
> +	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client show HEAD &&
> +	grep "git> done" trace >done_lines &&
> +	test_line_count =3D 1 done_lines
> +'
> +
> +test_expect_success 'diff batches blobs' '
> +	test_when_finished "rm -rf server client trace" &&
> +
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	echo b >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +	echo c >server/c &&
> +	echo d >server/d &&
> +	git -C server add c d &&
> +	git -C server commit -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=3Dblob:limit=3D0 "file://$(pwd)/server" clie=
nt &&
> +
> +	# Ensure that there is exactly 1 negotiation by checking that there is
> +	# only 1 "done" line sent. ("done" marks the end of negotiation.)
> +	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client diff HEAD^ HEAD &&
> +	grep "git> done" trace >done_lines &&
> +	test_line_count =3D 1 done_lines
> +'
> +
> +test_expect_success 'diff skips same-OID blobs' '
> +	test_when_finished "rm -rf server client trace" &&
> +
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	echo b >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +	echo another-a >server/a &&
> +	git -C server add a &&
> +	git -C server commit -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=3Dblob:limit=3D0 "file://$(pwd)/server" clie=
nt &&
> +
> +	echo a | git hash-object --stdin >hash-old-a &&
> +	echo another-a | git hash-object --stdin >hash-new-a &&
> +	echo b | git hash-object --stdin >hash-b &&
> +
> +	# Ensure that only a and another-a are fetched.
> +	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client diff HEAD^ HEAD &&
> +	grep "want $(cat hash-old-a)" trace &&
> +	grep "want $(cat hash-new-a)" trace &&
> +	! grep "want $(cat hash-b)" trace
> +'
> +
> +test_expect_success 'diff with rename detection batches blobs' '
> +	test_when_finished "rm -rf server client trace" &&
> +
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	printf "b\nb\nb\nb\nb\n" >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +	rm server/b &&
> +	printf "b\nb\nb\nb\nbX\n" >server/c &&
> +	git -C server add c &&
> +	git -C server commit -a -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=3Dblob:limit=3D0 "file://$(pwd)/server" clie=
nt &&
> +
> +	# Ensure that there is exactly 1 negotiation by checking that there is
> +	# only 1 "done" line sent. ("done" marks the end of negotiation.)
> +	GIT_TRACE_PACKET=3D"$(pwd)/trace" git -C client diff -M HEAD^ HEAD >ou=
t &&
> +	grep "similarity index" out &&
> +	grep "git> done" trace >done_lines &&
> +	test_line_count =3D 1 done_lines
> +'
> +
> +test_done
> --
> 2.21.0.197.gd478713db0
>
>
