Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547FCC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 12:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiGOM6E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 08:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiGOM6B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 08:58:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E27481FB
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657889861;
        bh=GY640r95F8rKYthEujkbZGRatMFGd/c1eXozGPBkK20=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ik5cu0QIrYdOHL3IdIVULZlJFrihTHsw250gaJHxtbGy9oqU5sXvupHXugn+uan0o
         uYy145/NZETMzXk1q2M8f1+h5bfmzaNL1F2xsoXk3AhDIiN6Q0u3V+P53cZtWeQWXi
         sTjZgH45kjRgjb3WE9eR3z/wZTn8wmy2C4TLlR3A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.23.67] ([89.1.215.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDXz-1nOdeC1FVN-00uVcr; Fri, 15
 Jul 2022 14:57:41 +0200
Date:   Fri, 15 Jul 2022 14:57:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Calvin Wan <calvinwan@google.com>
cc:     git@vger.kernel.org, chooglen@google.com, gitster@pobox.com,
        newren@gmail.com, levraiphilippeblain@gmail.com
Subject: Re: [PATCH v4] submodule merge: update conflict error message
In-Reply-To: <20220712231935.2979727-1-calvinwan@google.com>
Message-ID: <7roq6p2s-17rn-477p-7n60-5p10926on785@tzk.qr>
References: <20220629224059.1016645-1-calvinwan@google.com> <20220712231935.2979727-1-calvinwan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7iYE3KMk0aVgqlhcr+Ps17926EG0RbcxPW5poq03n5Ye0TUWHnE
 v4dPWfR9OChTqdWWoasrc7V4+W7/fyKQAWqbe4gIpCShpUEekdc0PqA6ZB0ELtDIMkckBvE
 X7Me5DrPtJfSzBADocDo3CkQMQpIm9fz/ZjDT4FF60Kf9btM/bAa7o7HhNGa8urG42hK1O8
 jna6V2ckx/rTplKaxaSkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UnVcc3q59B4=:eDeqaNBNTgqQpNrROkeHie
 Qz/AEpU3x2NbZGmPh/VDk8oDepKHTxbhjp0LLrATwjOlGepj4c6WgHtVO+fDK0RWlAB1FDZsU
 x8ov/BOPm0fG7hRbWGIYGu/5eWQJbjqrHFAV2jDIHVpi1xhHKGfGBOc1atdEXXhQCf3yREfV8
 ho7aAEMx+LzSTenpOJOOXJ8F8wPNZiaktxZcPmIBA9i6UcAtBAzfKkKfjPY8BnRj4EXJEH2a4
 2EgjYUUsqryr/dRkjNoKOtAHk8buvdKvL4stEOcwDR6aMxBwrxONOF5n2VZv8JseaciidKO1i
 IAGIbU7bzIadaEKj3IOINlW27U9c28Cym+445k2zHgba2FzmpwECMlTDgE5iXWo/n4F1UbS4z
 jIkeZcWWOsGYWiYgEcLznqnEfcNMJR6Z6drwkvvK0JrDaO1DVa+xzntHoNfUkTl2mkSKF+T/t
 5B9Im28ANsUTNj0ZqmgMXYSl+62s1MWIMyTJDmtlJhhwWwdQXahl/cgqZJVCux4Zf+FK/p02C
 pU+bZDAclCAAsPQvhnyf6q6SKA5+tudHUb16K3d98qKdAFxamT4X2TGH0yB26ZWjeSXPpDs5A
 bu6YZxVlJfyTEy54lfrngn9PlzgmUexm8pwemVe7SW4tZj1wVme/rI2989sdHDd71MkUKEvlP
 cFjIz0qubxV+ayne5/9CrbQZantsmXXf85hJ+dsQleEa9dCVUatW8WfW7o1xoY5V0/GtRm2Zc
 YrNfQVxcQ9fJyQ2SmP4f98gFPmey9oRlGz50bx2JtiVx67cwdU8gq/WtEcNTNaZ805fq31mcr
 7tXnd2+5preXbDAWhH2wAmxesNXclDIc3XuY2FjjN8SFAnhl/G+imxIUowyPpmbKW+wJzSLB9
 oDtPeR+z0+357PU32dt+C6mbeQ2I1KX7HB4Fg6Rtxqt9Td+ulsN74jV195OowJzI+I0KSpxYk
 yoEzaJvLXyeoAzKXEoOQaPJT9/wmIgJxUSQWP6q+DTMo7YpsIUmEhKu7pAcgzv3PHgQ9glw2W
 eFuL6fDc5OyiZfCmn4A4+1R3xpbV+BYq8g9fF2PWbl+MxhhuKM4FDZSNbc6bsquE+0Fh04b8c
 VdJadHLI16ulzvb8HrnmXAi0L6nuuUdfMkkZA/qbCERIQ+Q8rnCJB/h2w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin,

On Tue, 12 Jul 2022, Calvin Wan wrote:

> diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
> index 178413c22f..cc1a312661 100755
> --- a/t/t6437-submodule-merge.sh
> +++ b/t/t6437-submodule-merge.sh
> @@ -103,8 +103,25 @@ test_expect_success 'setup for merge search' '
>  	 echo "file-c" > file-c &&
>  	 git add file-c &&
>  	 git commit -m "sub-c") &&
> -	git commit -a -m "c" &&
> +	git commit -a -m "c")
> +'
> +
> +test_expect_success 'merging should conflict for non fast-forward' '
> +	(cd merge-search &&
> +	 git checkout -b test-nonforward-a b &&
> +	  if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
> +	  then
> +		test_must_fail git merge c >actual
> +	  else
> +		test_must_fail git merge c 2> actual
> +	  fi &&
> +	 sub_expect=3D"go to submodule (sub), and either merge commit $(git -C=
 sub rev-parse --short sub-c)" &&
> +	 grep "$sub_expect" actual &&

No matter how hard I tried to stare at the code, no matter whether I
looked at `cw/submodule-merge-messages` or `seen`, I cannot see how this
`grep` could ever succeed when `GIT_TEST_MERGE_ALGORITHM=3Drecursive`: onl=
y
the `ort` code has been taught this new trick.

In fact, when I run this locally with
`GIT_TEST_MERGE_ALGORITHM=3Drecursive`, it not only fails (as shown here:
https://github.com/gitgitgadget/git/runs/7349612861?check_suite_focus=3Dtr=
ue#step:4:1833
and here:
https://github.com/gitgitgadget/git/runs/7326925485?check_suite_focus=3Dtr=
ue#step:4:1820),
it also leaves no error message in `actual`.

So you probably want to move the `sub_expect` assignment and the `grep`
into the `ort` clause of the conditional above.

With this fixup, things seem to work over here:

=2D- snip --
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index cc1a3126619..3892d0bf742 100755
=2D-- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -111,12 +111,12 @@ test_expect_success 'merging should conflict for non=
 fast-forward' '
 	 git checkout -b test-nonforward-a b &&
 	  if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 	  then
-		test_must_fail git merge c >actual
+		test_must_fail git merge c >actual &&
+		sub_expect=3D"go to submodule (sub), and either merge commit $(git -C s=
ub rev-parse --short sub-c)" &&
+		grep "$sub_expect" actual
 	  else
 		test_must_fail git merge c 2> actual
 	  fi &&
-	 sub_expect=3D"go to submodule (sub), and either merge commit $(git -C s=
ub rev-parse --short sub-c)" &&
-	 grep "$sub_expect" actual &&
 	 git reset --hard)
 '

@@ -153,13 +153,13 @@ test_expect_success 'merging should conflict for non=
 fast-forward (resolution ex
 	  git rev-parse sub-d > ../expect) &&
 	  if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 	  then
-		test_must_fail git merge c >actual
+		test_must_fail git merge c >actual &&
+		sub_expect=3D"go to submodule (sub), and either merge commit $(git -C s=
ub rev-parse --short sub-c)" &&
+		grep "$sub_expect" actual
 	  else
 		test_must_fail git merge c 2> actual
 	  fi &&
 	 grep $(cat expect) actual > /dev/null &&
-	 sub_expect=3D"go to submodule (sub), and either merge commit $(git -C s=
ub rev-parse --short sub-c)" &&
-	 grep "$sub_expect" actual &&
 	 git reset --hard)
 '

@@ -180,14 +180,14 @@ test_expect_success 'merging should fail for ambiguo=
us common parent' '
 	 ) &&
 	 if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 	 then
-		test_must_fail git merge c >actual
+		test_must_fail git merge c >actual &&
+		sub_expect=3D"go to submodule (sub), and either merge commit $(git -C s=
ub rev-parse --short sub-c)" &&
+		grep "$sub_expect" actual
 	 else
 		test_must_fail git merge c 2> actual
 	 fi &&
 	grep $(cat expect1) actual > /dev/null &&
 	grep $(cat expect2) actual > /dev/null &&
-	sub_expect=3D"go to submodule (sub), and either merge commit $(git -C su=
b rev-parse --short sub-c)" &&
-	grep "$sub_expect" actual &&
 	git reset --hard)
 '

@@ -227,8 +227,11 @@ test_expect_success 'merging should fail for changes =
that are backwards' '

 	git checkout -b test-backward e &&
 	test_must_fail git merge f >actual &&
-	sub_expect=3D"go to submodule (sub), and either merge commit $(git -C su=
b rev-parse --short sub-d)" &&
-	grep "$sub_expect" actual)
+	if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
+	then
+		sub_expect=3D"go to submodule (sub), and either merge commit $(git -C s=
ub rev-parse --short sub-d)" &&
+		grep "$sub_expect" actual
+	fi)
 '

=2D- snap --

> +	 git reset --hard)

It would be better to move this before the subshell like this:

	test_when_finished "git -C merge-search reset --hard" &&

Ciao,
Dscho

> +'
>
> +test_expect_success 'finish setup for merge-search' '
> +	(cd merge-search &&
>  	git checkout -b d a &&
>  	(cd sub &&
>  	 git checkout -b sub-d sub-b &&
> @@ -129,9 +146,9 @@ test_expect_success 'merge with one side as a fast-f=
orward of the other' '
>  	 test_cmp expect actual)
>  '
>
> -test_expect_success 'merging should conflict for non fast-forward' '
> +test_expect_success 'merging should conflict for non fast-forward (reso=
lution exists)' '
>  	(cd merge-search &&
> -	 git checkout -b test-nonforward b &&
> +	 git checkout -b test-nonforward-b b &&
>  	 (cd sub &&
>  	  git rev-parse sub-d > ../expect) &&
>  	  if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
> @@ -141,6 +158,8 @@ test_expect_success 'merging should conflict for non=
 fast-forward' '
>  		test_must_fail git merge c 2> actual
>  	  fi &&
>  	 grep $(cat expect) actual > /dev/null &&
> +	 sub_expect=3D"go to submodule (sub), and either merge commit $(git -C=
 sub rev-parse --short sub-c)" &&
> +	 grep "$sub_expect" actual &&
>  	 git reset --hard)
>  '
>
> @@ -167,6 +186,8 @@ test_expect_success 'merging should fail for ambiguo=
us common parent' '
>  	 fi &&
>  	grep $(cat expect1) actual > /dev/null &&
>  	grep $(cat expect2) actual > /dev/null &&
> +	sub_expect=3D"go to submodule (sub), and either merge commit $(git -C =
sub rev-parse --short sub-c)" &&
> +	grep "$sub_expect" actual &&
>  	git reset --hard)
>  '
>
> @@ -205,7 +226,9 @@ test_expect_success 'merging should fail for changes=
 that are backwards' '
>  	git commit -a -m "f" &&
>
>  	git checkout -b test-backward e &&
> -	test_must_fail git merge f)
> +	test_must_fail git merge f >actual &&
> +	sub_expect=3D"go to submodule (sub), and either merge commit $(git -C =
sub rev-parse --short sub-d)" &&
> +	grep "$sub_expect" actual)
>  '
>
>
> diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
> index 8e32f19007..f1bb29681f 100755
> --- a/t/t7402-submodule-rebase.sh
> +++ b/t/t7402-submodule-rebase.sh
> @@ -104,7 +104,7 @@ test_expect_success 'rebasing submodule that should =
conflict' '
>  	test_tick &&
>  	git commit -m fourth &&
>
> -	test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 &&
> +	test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 >actual_output &&
>  	git ls-files -s submodule >actual &&
>  	(
>  		cd submodule &&
> @@ -112,7 +112,9 @@ test_expect_success 'rebasing submodule that should =
conflict' '
>  		echo "160000 $(git rev-parse HEAD^^) 2	submodule" &&
>  		echo "160000 $(git rev-parse HEAD) 3	submodule"
>  	) >expect &&
> -	test_cmp expect actual
> +	test_cmp expect actual &&
> +	sub_expect=3D"go to submodule (submodule), and either merge commit $(g=
it -C submodule rev-parse --short HEAD^0)" &&
> +	grep "$sub_expect" actual_output
>  '
>
>  test_done
>
> base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
> --
> 2.37.0.144.g8ac04bfd2-goog
>
>
>
