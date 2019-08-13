Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACFAF1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 18:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfHMSIO (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 14:08:14 -0400
Received: from mout.web.de ([212.227.15.3]:33605 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfHMSIO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 14:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565719691;
        bh=oSFq2TVjH90hoRGX/sTgkOjIL+xm/A+M/6W2IFP5gVg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EiOVEPq4hfehZhhBVgFDV0jktOrsPjSSWscoTuZWq2RQhPwl/CAmvJ4n78fvRnTQw
         TDGNAlfrM7426ewG47qFzuzxvZbIMoOQndSjOV7nh7TFQFxRLIuaM8SL8NmacsOKX5
         1NtFq/3EWu1TkpFR1PhjRYDSWwV+cgal3aE9RoR0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MK233-1hyyGE16vd-001R8d; Tue, 13
 Aug 2019 20:08:11 +0200
Subject: Re: [RFC PATCH] unpack-trees.c: handle empty deleted ita files
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20190813160353.50018-1-vcnaik94@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b7f4b745-8942-6d90-dbc5-7f79f2cc323e@web.de>
Date:   Tue, 13 Aug 2019 20:08:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813160353.50018-1-vcnaik94@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:51QwzlL2s6SuAFLq32JU4RVERFb0fwRxz/38wmKoCO+Ib3Xb/5p
 IL2OG7cSVzB+50Iv5Owhf1Uo7qVDR8KvGr+nTiCeQgQeJf14BjxZ6WA1BrvjdB++saiK0N9
 qzHfvn/ZKQxZqL9jbThiRQ9j548SfVdaE1t6AofOI/CcL7GaaDw2DbLHDmA4PHKyoAX+4oD
 ovjUUvFSmaM24PX6CpoVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S02RfWc0OYc=:6DemPvM3rRuQYm4M9x1lKw
 sYbX9VCkM+h8Thnqd6zBzpYRPBO96vcM9R3aY3Z8cHXuFoXzT/aqKHDpmR1EHDdPh9fLzF/EG
 1KwTrwdJjQQpc/dgbNoLAlGhgvbKDkokNVN6nScVfu/0t2y9MxJcAsL/B//ex27KDJRWXtz7Q
 K7kODnpomDg8T00MMYmOkmQtoZqiQAZE8Bj2+cEngC3w+EexOy5Bpry+N/B63dUfgKG34743i
 NDL9b6YffezHfVDKB/S4QGXEOT0BqmQ7RZph+PPVIL+Nd5OOo0ziJY3I07/dhIKaxJshQRMdH
 z5oOFPuPMCD3Q3bXYmCBQnTilejApifprYTxS1vzXwpPnCM+y592IhRtw573OeUC7YvvZBOBI
 Rxjgdt8QBbxpSke8CmK4TtOpqU7TkxxfwJDHl6zX6FCJMS2OYqNjfhwcuFCfOWUxYN80IbRUE
 YBGIIVZgHvP67dkjJPtK3YsEnBRQMyeFgvbFIpxMyR6rF6f8ZImnve9l/eO9SB9EYA/C1X7Wv
 VXW+/8nmQuCK2eEFpzrNAgrkBuiZxN3Bw3SBDz5givudyqT0h6jcrjlkzA+ump7l5EmhNujlW
 twA2qNiYt9YYdgj3aqGhR0fRTFxgRU9SPnt05qod4ev96OEwlV7hfqcwLyKcJFZpA7C600jg/
 V2pR124sykA1GRgsAwSScubEUjOLBX+79j2fMqtGWHnApt8vSRIgeRxIW7CH4bfNwpjMelfOS
 riv3Op1wwtBh54/CduAU/1XEAqEtPbk06BX848UMLuPgcHM4i5wKmv8RhBrRZiVbZxdCHj+Dn
 9HI3jsl+WiwE7wUuY0Aw/Xz2TqyRsxBWw2A+k1UWsmQbpCbeyeXuekpeXkc2OyYfowWiuyMJM
 fXIxEdcw4U5lJS4iKKw2rz+o/Ct4YVY+kusP5qkrN4HD5PfyIzFnSP9fP+HAimKPJ7OnphvSA
 6105UOnWCtO0Smcw0CbeOiUEuy08LTjwmx+Siuz9UgvZ5F4YExBXFTkpKGyE+sYuW21uzhsCg
 +1WyYPVI8WjhCclVLo07R4ulV6s9dmgyuZy3wPvgrHlCldsy+5kdAFtVUJojKiqDL2nB7/UBD
 xeb5BSeCFFBQwoW4lq3pLBabeGCsz5H94gxFYI74yPXNUKYheHhhl6/c4CbaaNeBPsk1BfWT6
 Uo14Wy6bMvbiFJW6EZfaiG0R+ljtvRy7fCThMvUVR0NvLcpA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.08.19 um 18:03 schrieb Varun Naik:
> It is possible to delete a committed file from the index and then add it
> as intent-to-add. Several variations of "reset" and "checkout" should
> resurrect the file in the index from HEAD. "merge", "cherry-pick", and
> "revert" should all fail with an error message. This patch provides the
> desired behavior even when the file is empty in HEAD.
>
> The affected commands all compare two cache entries by calling
> unpack-trees.c:same(). A cache entry for an ita file and a cache entry
> for an empty file have the same oid. So, the cache entry for an empty
> deleted ita file was previously considered the "same" as the cache entry
> for an empty file. This fix adds a comparison of the intent-to-add bits
> so that the two cache entries are no longer considered the "same".
>
> Signed-off-by: Varun Naik <vcnaik94@gmail.com>
> ---
> I am marking this patch as RFC because it is changing code deep in
> unpack-trees.c, and I'm sure it will generate some controversy :)

Lacking experience with intent-to-add I don't see why this would be
controversial.  Copying Duy and quoting in full, as he might have more
to say on that topic.

I have just one silly question below.

>
> The affected "reset" and "checkout" commands call
> unpack-trees.c:oneway_merge(), which calls same(). The affected "merge",
> "cherry-pick", and "revert" commands call
> unpack-trees.c:threeway_merge(), which calls same(). "stash" also calls
> oneway_merge(), and "rebase" also calls threeway_merge(), but they are
> not included in the test cases because their behaviors have not changed.
>
> The new tests are not comprehensive. In particular, they don't call
> plumbing commands, such as "read-tree". But hopefully they provide
> enough coverage to prevent most regressions.
>
> The new test cases for "cherry-pick" and "revert" grep for the single
> word "overwritten" rather than a more precise error message because the
> error message for an empty deleted ita file changes slightly if the
> patch in [0] is also applied. In retrospect, the commands affected by
> [0], [1], and this patch were all intertwined, and it would have been
> better to create a single large patch instead of three smaller patches.
>
> [0]: https://public-inbox.org/git/20190801161558.12838-1-vcnaik94@gmail.=
com/
> [1]: https://public-inbox.org/git/20190802162852.14498-1-vcnaik94@gmail.=
com/
>
>  t/t3030-merge-recursive.sh    | 25 +++++++++++++++---
>  t/t3501-revert-cherry-pick.sh | 49 ++++++++++++++++++++++++++++++++++-
>  t/t7104-reset-hard.sh         | 11 ++++++++
>  t/t7110-reset-merge.sh        | 31 ++++++++++++++++++++++
>  t/t7201-co.sh                 | 12 +++++++++
>  unpack-trees.c                |  1 +
>  6 files changed, 125 insertions(+), 4 deletions(-)
>
> diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
> index ff641b348a..8aebb829a6 100755
> --- a/t/t3030-merge-recursive.sh
> +++ b/t/t3030-merge-recursive.sh
> @@ -303,13 +303,32 @@ test_expect_success 'fail if the index has unresol=
ved entries' '
>  	git checkout -f "$c1" &&
>
>  	test_must_fail git merge "$c5" &&
> -	test_must_fail git merge "$c5" 2> out &&
> +	test_must_fail git merge "$c5" 2>out &&
>  	test_i18ngrep "not possible because you have unmerged files" out &&
>  	git add -u &&
> -	test_must_fail git merge "$c5" 2> out &&
> +	test_must_fail git merge "$c5" 2>out &&
>  	test_i18ngrep "You have not concluded your merge" out &&
>  	rm -f .git/MERGE_HEAD &&
> -	test_must_fail git merge "$c5" 2> out &&
> +	test_must_fail git merge "$c5" 2>out &&
> +	test_i18ngrep "Your local changes to the following files would be over=
written by merge:" out
> +'
> +
> +test_expect_success 'fail if a deleted intent-to-add file exists in the=
 index' '
> +	git checkout -f "$c1" &&
> +	echo "nonempty" >nonempty &&
> +	git add nonempty &&
> +	git commit -m "create file to be deleted" &&
> +	git rm --cached nonempty &&
> +	git add -N nonempty &&
> +	test_must_fail git merge "$c5" 2>out &&
> +	test_i18ngrep "Your local changes to the following files would be over=
written by merge:" out &&
> +	git checkout -f "$c1" &&
> +	>empty &&
> +	git add empty &&
> +	git commit -m "create file to be deleted" &&
> +	git rm --cached empty &&
> +	git add -N empty &&
> +	test_must_fail git merge "$c5" 2>out &&
>  	test_i18ngrep "Your local changes to the following files would be over=
written by merge:" out
>  '
>
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.=
sh
> index d1c68af8c5..45d816fc0c 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -91,16 +91,63 @@ test_expect_success 'cherry-pick on stat-dirty worki=
ng tree' '
>  	)
>  '
>
> -test_expect_success 'revert forbidden on dirty working tree' '
> +test_expect_success 'cherry-pick forbidden on dirty working tree' '
>
> +	git checkout -b temp &&
>  	echo content >extra_file &&
>  	git add extra_file &&
> +	test_must_fail git cherry-pick rename2 2>errors &&
> +	test_i18ngrep "your local changes would be overwritten by " errors
> +
> +'
> +
> +test_expect_success 'revert forbidden on dirty working tree' '
> +
>  	test_must_fail git revert HEAD 2>errors &&
>  	test_i18ngrep "your local changes would be overwritten by " errors
>
>  '
>
> +test_expect_success 'cherry-pick fails if a deleted intent-to-add file =
exists in the index' '
> +	git reset --hard rename1 &&
> +	echo "nonempty" >nonempty &&
> +	git add nonempty &&
> +	git commit -m "create file to be deleted" &&
> +	git rm --cached nonempty &&
> +	git add -N nonempty &&
> +	test_must_fail git cherry-pick rename2 2>errors &&
> +	test_i18ngrep "overwritten" errors &&
> +	git reset --hard rename1 &&
> +	>empty &&
> +	git add empty &&
> +	git commit -m "create file to be deleted" &&
> +	git rm --cached empty &&
> +	git add -N empty &&
> +	test_must_fail git cherry-pick rename2 2>errors &&
> +	test_i18ngrep "overwritten" errors
> +'
> +
> +test_expect_success 'revert fails if a deleted intent-to-add file exist=
s in the index' '
> +	git reset --hard rename1 &&
> +	echo "nonempty" >nonempty &&
> +	git add nonempty &&
> +	git commit -m "create file to be deleted" &&
> +	git rm --cached nonempty &&
> +	git add -N nonempty &&
> +	test_must_fail git revert rename2 2>errors &&
> +	test_i18ngrep "overwritten" errors &&
> +	git reset --hard rename1 &&
> +	>empty &&
> +	git add empty &&
> +	git commit -m "create file to be deleted" &&
> +	git rm --cached empty &&
> +	git add -N empty &&
> +	test_must_fail git revert rename2 2>errors &&
> +	test_i18ngrep "overwritten" errors
> +'
> +
>  test_expect_success 'cherry-pick on unborn branch' '
> +	git checkout -f rename1 &&
>  	git checkout --orphan unborn &&
>  	git rm --cached -r . &&
>  	rm -rf * &&
> diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
> index 16faa07813..96a0b779e7 100755
> --- a/t/t7104-reset-hard.sh
> +++ b/t/t7104-reset-hard.sh
> @@ -43,4 +43,15 @@ test_expect_success 'reset --hard did not corrupt ind=
ex or cached-tree' '
>
>  '
>
> +test_expect_success 'reset --hard adds deleted intent-to-add file back =
to index' '
> +	echo "nonempty" >nonempty &&
> +	>empty &&
> +	git add nonempty empty &&
> +	git commit -m "create files to be deleted" &&
> +	git rm --cached nonempty empty &&
> +	git add -N nonempty empty &&
> +	git reset --hard &&
> +	git diff --cached --exit-code nonempty empty
> +'
> +
>  test_done
> diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
> index a82a07a04a..3346759375 100755
> --- a/t/t7110-reset-merge.sh
> +++ b/t/t7110-reset-merge.sh
> @@ -292,4 +292,35 @@ test_expect_success '--keep fails with added/delete=
d merge' '
>      test_i18ngrep "middle of a merge" err.log
>  '
>
> +test_expect_success 'reset --merge adds deleted intent-to-add file back=
 to index' '
> +    git reset --hard initial &&
> +    echo "nonempty" >nonempty &&
> +    git add nonempty &&
> +    git commit -m "create file to be deleted" &&
> +    git rm --cached nonempty &&
> +    git add -N nonempty &&
> +    test_must_fail git reset --merge HEAD 2>err.log &&
> +    grep nonempty err.log | grep "not uptodate" &&
> +    git reset --hard initial &&
> +    >empty &&
> +    git add empty &&
> +    git commit -m "create file to be deleted" &&
> +    git rm --cached empty &&
> +    git add -N empty &&
> +    test_must_fail git reset --merge HEAD 2>err.log &&
> +    grep empty err.log | grep "not uptodate"
> +'
> +
> +test_expect_success 'reset --keep adds deleted intent-to-add file back =
to index' '
> +    git reset --hard initial &&
> +    echo "nonempty" >nonempty &&
> +    >empty &&
> +    git add nonempty empty &&
> +    git commit -m "create files to be deleted" &&
> +    git rm --cached nonempty empty &&
> +    git add -N nonempty empty &&
> +    git reset --keep HEAD &&
> +    git diff --cached --exit-code nonempty empty
> +'
> +
>  test_done
> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 5990299fc9..4c0c33ce33 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -674,4 +674,16 @@ test_expect_success 'custom merge driver with check=
out -m' '
>  	test_cmp expect arm
>  '
>
> +test_expect_success 'checkout -f HEAD adds deleted intent-to-add file b=
ack to index' '
> +	git reset --hard master &&
> +	echo "nonempty" >nonempty &&
> +	>empty &&
> +	git add nonempty empty &&
> +	git commit -m "create files to be deleted" &&
> +	git rm --cached nonempty empty &&
> +	git add -N nonempty empty &&
> +	git checkout -f HEAD &&
> +	git diff --cached --exit-code nonempty empty
> +'
> +
>  test_done
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 50189909b8..9b7e6b01c4 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1661,6 +1661,7 @@ static int same(const struct cache_entry *a, const=
 struct cache_entry *b)
>  	if ((a->ce_flags | b->ce_flags) & CE_CONFLICTED)
>  		return 0;
>  	return a->ce_mode =3D=3D b->ce_mode &&
> +	       !ce_intent_to_add(a) =3D=3D !ce_intent_to_add(b) &&

Why the bangs?  This would work just as well and be slightly easier to
read without negating both sides, wouldn't it?

>  	       oideq(&a->oid, &b->oid);
>  }
>
>

