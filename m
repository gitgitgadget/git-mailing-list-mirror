Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EA96207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 12:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1039208AbdDUM26 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 08:28:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33182 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1038113AbdDUM24 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 08:28:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id o81so4615615wmb.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 05:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=QStWdIbWJkAWVCP2D+veGWWF4FWMncFkzX2au6zUS/o=;
        b=E6gIsoQBim50JUZRZKjaGgu4CSEQvYKtJumg++5BNMXdAnsKo1bpzs1RxXgaiPzPZv
         ZA2g+63DCSO+zZb+t65F8+TKQYuWV+e7JHKRIEcFwQE3fUqebcdPf1F20jbvmzGPYMNx
         vYovdoZTAFZ+42MC8vLYZONI5kZXdw3gsxKorJNXR2VFvrASqK6bNbfnVAM2uwMV1FbK
         alHj3G25D5ezDs9WRjF2rhmzCEx9FP7E1n2P4Uy9NtvznRClbryqHoyL2JsfsCMPOTqL
         HpN6tyKsP8oRzW1/4kY0kTBM8IsAm4l+wcKjBAJiPhkgWxPCCQUxhBdN5lLIiffMa511
         /0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=QStWdIbWJkAWVCP2D+veGWWF4FWMncFkzX2au6zUS/o=;
        b=hTS6/slJY+JoRqKFnU5VP1YMiEBRy/Ti/ZGTS84EhAxfc0IvVZF6KdmJ70CIhjC2jc
         oxpk+0Whsn55Rl+M0w24AKScWt957HUaZ9FjAUnKVQc6pRMYnN/nwJjhdP62EAhpts23
         Sn1TNsvEINWPVx2AA5rNFACrdhS4be20XjyanUU6M9N8+L9ljL8zJ5H9LV19a9S+75eY
         a9grVHtozErP5HN46Hc3zqJm8r4T0B6sKwigAmXyv68vH2X7oTifJZtVD+bqd74d4oT+
         6ggaF8lkqCcwzOeN9We4MC20bzeJALHgizfRFnvy1BrzuVIeQrVI+kfby/jNyYFM5PU0
         Zr2g==
X-Gm-Message-State: AN3rC/6BDDpmBnMNn+QYL41Yj6YoKj0sugwsBp3yevT/eJtDd23EYsSK
        e0gXHJFl54PQJ01u
X-Received: by 10.80.145.61 with SMTP id e58mr57184eda.111.1492777734561;
        Fri, 21 Apr 2017 05:28:54 -0700 (PDT)
Received: from localhost.localdomain (x590d5664.dyn.telefonica.de. [89.13.86.100])
        by smtp.gmail.com with ESMTPSA id a45sm387563eda.3.2017.04.21.05.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Apr 2017 05:28:53 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] completion: expand "push --delete <remote> <ref>" for refs on that <remote>
Date:   Fri, 21 Apr 2017 14:28:32 +0200
Message-Id: <20170421122832.24617-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.2.613.g9c5b79913
In-Reply-To: <20170418133152.3262-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 18, 2017 at 3:31 PM, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Change the completion of "push --delete <remote> <ref>" to complete
> refs on that <remote>, not all refs.

Good.

> Before this e.g. cloning git.git
> and doing "git push --delete origin p<TAB>" will complete nothing,

Well, it will complete all local branches starting with 'p', but
perhaps you don't happen to have any.

> whereas origin/p<TAB> will uselessly complete origin/pu.
> 
> Now p<TAB> will complete as "pu". The completion of giving --delete
> later, e.g. "git push origin --delete p<TAB>" remains unchanged, this
> is a bug, but is a general existing limitation of the bash completion,
> and not how git-push is documented, so I'm not fixing that case.
> 
> I looked over t9902-completion.sh but couldn't quickly find out how to
> add a test for this,

Yeah, this helper function has to look at the whole command line to do
its thing, and we don't have other unit test-like tests doing
something like that.

One option would be something like this:

@@ -1162,6 +1162,19 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 	test_cmp expected out
 '
 
+test_expect_success '__git_complete_remote_or_refspec - push -d' '
+	sed -e "s/Z$//" >expected <<-EOF &&
+	master-in-other Z
+	EOF
+	(
+		words=(git push -d other ma) &&
+		cword=${#words[@]} cur=${words[cword-1]} &&
+		__git_complete_remote_or_refspec &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&

This is chatty, no question about that, but it only excercises
__git_complete_remote_or_refspec() (and __git_refs() behind its back),
and thus fits right in there with other refs completion tests.


The other option would be something like this:

@@ -1348,6 +1361,10 @@ test_expect_success 'complete tree filename with metacharacters' '
 	EOF
 '
 
+test_expect_success 'complete remote refs for git push -d' '
+	test_completion "git push -d other ma" "master-in-other "
+'
+
 test_expect_success 'send-email' '
 	test_completion "git send-email --cov" "--cover-letter " &&
 	test_completion "git send-email ma" "master "

While this is much more compact, it does excercise the whole shebang,
therefore it has to go to the integration tests.  However, at that
point in the test script there aren't any remote refs in the
repository (and, consequently this test will fail as it is), so you
would need to add a few, which in turn would most likely require
adjustments in other tests.

I'm partial to the former, even if it's more lines of code, because if
it were to fail, then it already narrowed down the scope where we'd
need to look for the cause of the failure.

Take your pick :)

> but all the existing tests pass, and all my
> manual testing of "git push --delete <remote> ..." does the right
> thing now.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 1150164d5c..2e5b3ed776 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -701,7 +701,7 @@ __git_complete_revlist ()
>  __git_complete_remote_or_refspec ()
>  {
>  	local cur_="$cur" cmd="${words[1]}"
> -	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
> +	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0 delete=0
>  	if [ "$cmd" = "remote" ]; then
>  		((c++))
>  	fi
> @@ -709,6 +709,7 @@ __git_complete_remote_or_refspec ()
>  		i="${words[c]}"
>  		case "$i" in
>  		--mirror) [ "$cmd" = "push" ] && no_complete_refspec=1 ;;
> +		--delete) delete=1 ;;

I noticed the two identical __git_complete_refs() calls in the hunk
below.  How about:

  -d|--delete) [ "$cmd" = "push" ] && lhs=0 ;;

First, it recognizes the short option, too.
Second, with 'push -d' any ref is interpreted as the right hand side
of a refspec whose left hand side is empty (i.e. '-d pu' means ':pu').
That 'lhs=0' tells the rest of the function to complete the right hand
side of a refspec, i.e. in case of 'push' to list remote refs, which
is exactly what you want.  And you won't need the extra if branch in
the hunk below, or the new local variable.
In this case, however, we should check that the command is 'push' as
well, just in case the other commands whose completion is driven by
this helper function get these options in the future.

>  		--all)
>  			case "$cmd" in
>  			push) no_complete_refspec=1 ;;
> @@ -761,7 +762,9 @@ __git_complete_remote_or_refspec ()
>  		fi
>  		;;
>  	push)
> -		if [ $lhs = 1 ]; then
> +		if [ $delete = 1 ]; then
> +			__git_complete_refs --remote="$remote" --pfx="$pfx" --cur="$cur_"
> +		elif [ $lhs = 1 ]; then
>  			__git_complete_refs --pfx="$pfx" --cur="$cur_"
>  		else
>  			__git_complete_refs --remote="$remote" --pfx="$pfx" --cur="$cur_"
> -- 
> 2.11.0
