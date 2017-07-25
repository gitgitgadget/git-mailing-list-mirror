Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20B85203F3
	for <e@80x24.org>; Tue, 25 Jul 2017 00:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755494AbdGYANo (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 20:13:44 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:32825 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753987AbdGYANn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 20:13:43 -0400
Received: by mail-pf0-f171.google.com with SMTP id s70so52715147pfs.0
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 17:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uTyaNj7b2ztyWj7d0sOZfPHB8s634LTUTW3pSDch5iY=;
        b=A8ko3GiUmeeAnkNXpotXipQBYWEPAujnTKqMw8iuWRHzREusiHGWg57g8jnfWmJtlT
         qVgPKYwPNyBJf45IaxygGqgnoLcI27IiX3hbCyqi6KTaV55D6e6iEen0KMhn24toI0V8
         xt/eveZSuNa/YOCszsRW98bsnnKguaRzCZ8UJ5OtVn8is5dM7JsVKNpEso1ud/Q5b5q9
         3p1HIlyXKgV/4swC0RryvC8m6GcOMKLKnCiLXVv96PV2znt1IVhUWs51oXnlwzPrUaxS
         A1/H4vy1KIIa/AP7oQVUzKIlFgOEVV0td0mqDZqgs0hjAYVHK1JZ/JTyyw0kdqrS81bW
         oTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uTyaNj7b2ztyWj7d0sOZfPHB8s634LTUTW3pSDch5iY=;
        b=cwAVTSK2wjkWmwL31qRJuzTar0M4bhgdChU78A/J+b68QxKYSku3+aoaI1j2kUZY+X
         q1ls2857jm7vlIDlhaOBbIGF2uuZ8dUIhkwxjkL2RTr8kUt7SBBfMV3BsdqwhXCcKdDx
         /2HtjIxZeQx2v90YU8xIusF2u+NrPTK0Xk8R2IpQd26iNjCMyMkRaG1AWsxuvR8YbbqT
         3GbkPHx98XNjqE/nD+PvE+tFvvPBK4MJmMObHyKMoHS7HmvQMYcOfdMj9wuIlMU+MsnH
         dD7XNAIChanIxhR1qCD5S4t77yhPqfd3uC6OBzz+wrUWa1drLkylmsJbiPnxZr9WSyZC
         o8pg==
X-Gm-Message-State: AIVw1118/3u8NIMoBICmpLJh/0wXGEyOAaCw+4c6liH7tJB4oa66Pxa+
        SRWJmVy02O2FKnsy
X-Received: by 10.98.149.132 with SMTP id c4mr17712868pfk.134.1500941622473;
        Mon, 24 Jul 2017 17:13:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c4bc:947:66f8:1cfe])
        by smtp.gmail.com with ESMTPSA id r207sm23728699pfr.106.2017.07.24.17.13.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 17:13:41 -0700 (PDT)
Date:   Mon, 24 Jul 2017 17:13:40 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 09/13] submodule foreach: correct '$path' in nested
 submodules from a subdirectory
Message-ID: <20170725001340.GF92874@google.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170724203454.13947-10-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170724203454.13947-10-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/25, Prathamesh Chavan wrote:
> When running 'git submodule foreach' from a subdirectory of your
> repository, nested submodules get a bogus value for $sm_path:
> For a submodule 'sub' that contains a nested submodule 'nested',
> running 'git -C dir submodule foreach echo $path' would report
> path='../nested' for the nested submodule. The first part '../' is
> derived from the logic computing the relative path from $pwd to the
> root of the superproject. The second part is the submodule path inside
> the submodule. This value is of little use and is hard to document.
> 
> There are two different possible solutions that have more value:
> (a) The path value is documented as the path from the toplevel of the
>     superproject to the mount point of the submodule.
>     In this case we would want to have path='sub/nested'.
> 
> (b) As Ramsay noticed the documented value is wrong. For the non-nested
>     case the path is equal to the relative path from $pwd to the
>     submodules working directory. When following this model,
>     the expected value would be path='../sub/nested'.
> 
> The behavior for (b) was introduced in 091a6eb0fe (submodule: drop the
> top-level requirement, 2013-06-16) the intent for $path seemed to be
> relative to $cwd to the submodule worktree, but that did not work for
> nested submodules, as the intermittent submodules were not included in
> the path.
> 
> If we were to fix the meaning of the $path using (a) such that "path"
> is "the path from the toplevel of the superproject to the mount point
> of the submodule", we would break any existing submodule user that runs
> foreach from non-root of the superproject as the non-nested submodule
> '../sub' would change its path to 'sub'.
> 
> If we would fix the meaning of the $path using (b), such that "path"
> is "the relative path from $pwd to the submodule", then we would break
> any user that uses nested submodules (even from the root directory) as
> the 'nested' would become 'sub/nested'.
> 
> Both groups can be found in the wild.  The author has no data if one group
> outweighs the other by large margin, and offending each one seems equally
> bad at first.  However in the authors imagination it is better to go with
> (a) as running from a sub directory sounds like it is carried out
> by a human rather than by some automation task.  With a human on
> the keyboard the feedback loop is short and the changed behavior can be
> adapted to quickly unlike some automation that can break silently.

Great explanation, and I agree with going with choice (a).

> 
> Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh             |  1 -
>  t/t7407-submodule-foreach.sh | 36 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index a427ddafd..493a64372 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -320,7 +320,6 @@ cmd_foreach()
>  				prefix="$prefix$sm_path/"
>  				sanitize_submodule_env
>  				cd "$sm_path" &&
> -				sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
>  				# we make $path available to scripts ...
>  				path=$sm_path &&
>  				if test $# -eq 1
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 6ba5daf42..0663622a4 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -82,9 +82,9 @@ test_expect_success 'test basic "submodule foreach" usage' '
>  
>  cat >expect <<EOF
>  Entering '../sub1'
> -$pwd/clone-foo1-../sub1-$sub1sha1
> +$pwd/clone-foo1-sub1-$sub1sha1
>  Entering '../sub3'
> -$pwd/clone-foo3-../sub3-$sub3sha1
> +$pwd/clone-foo3-sub3-$sub3sha1
>  EOF
>  
>  test_expect_success 'test "submodule foreach" from subdirectory' '
> @@ -196,6 +196,38 @@ test_expect_success 'test messages from "foreach --recursive" from subdirectory'
>  	) &&
>  	test_i18ncmp expect actual
>  '
> +sub1sha1=$(cd clone2/sub1 && git rev-parse HEAD)
> +sub2sha1=$(cd clone2/sub2 && git rev-parse HEAD)
> +sub3sha1=$(cd clone2/sub3 && git rev-parse HEAD)
> +nested1sha1=$(cd clone2/nested1 && git rev-parse HEAD)
> +nested2sha1=$(cd clone2/nested1/nested2 && git rev-parse HEAD)
> +nested3sha1=$(cd clone2/nested1/nested2/nested3 && git rev-parse HEAD)
> +submodulesha1=$(cd clone2/nested1/nested2/nested3/submodule && git rev-parse HEAD)
> +
> +cat >expect <<EOF
> +Entering '../nested1'
> +$pwd/clone2-nested1-nested1-$nested1sha1
> +Entering '../nested1/nested2'
> +$pwd/clone2/nested1-nested2-nested2-$nested2sha1
> +Entering '../nested1/nested2/nested3'
> +$pwd/clone2/nested1/nested2-nested3-nested3-$nested3sha1
> +Entering '../nested1/nested2/nested3/submodule'
> +$pwd/clone2/nested1/nested2/nested3-submodule-submodule-$submodulesha1
> +Entering '../sub1'
> +$pwd/clone2-foo1-sub1-$sub1sha1
> +Entering '../sub2'
> +$pwd/clone2-foo2-sub2-$sub2sha1
> +Entering '../sub3'
> +$pwd/clone2-foo3-sub3-$sub3sha1
> +EOF
> +
> +test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
> +	(
> +		cd clone2/untracked &&
> +		git submodule foreach --recursive "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
> +	) &&
> +	test_i18ncmp expect actual
> +'
>  
>  cat > expect <<EOF
>  nested1-nested1
> -- 
> 2.13.0
> 

-- 
Brandon Williams
