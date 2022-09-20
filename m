Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA438C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 17:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiITRnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 13:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiITRm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 13:42:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D664DF33
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 10:42:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n12so5544795wrx.9
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=RtbWjenf8hn5Z8agE0sPgjs82O2sRn6fWkJ3G5cWSxE=;
        b=K4gxaX7MpvX2ZndeC5+Irq+pEufzQLE6jjR29y7QVk1OMvSVrkBIE7E5jh+YdQ2kUh
         SbDlfu/fFzAGDkI+oKCpdoUiNxjU8rxVyaxjwxE+ix45F/M3IM5tOSp59BLDy+Wb/wuK
         83hsThCPgBKFyKLf+nDmTZ63vIeJdsSUtjfPvB9qzX3ZBrRAQoJ943Mj+MtAYbh8HBzT
         kd9chMkXMo7cvHc7+K9XaU/TJRarVKmYTtFaz5U30lSajKzIh6zRiKBQ6kZ2R6yHIpJx
         cJoA8tPisuUpEvOBZYlOfQu9ZUToX/t3WgUBwXdWgsm4+hemPlQGti/1w9GrWjIVzpbc
         tdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=RtbWjenf8hn5Z8agE0sPgjs82O2sRn6fWkJ3G5cWSxE=;
        b=pgD4Z4Cb6huvv8uitHQ2biZ2j2FvZrH5O3wMHYs3CHEVZqTtoWXIOOT2QSQ7bWhl+T
         334Ah/zr09IYKBxq1Mu2q6TP4l6TqfTtf5H8w3kQAn4TVAx0rFyfAbF+53HgXfF/o+L4
         TYQPpH2weecAbP2whZsCpW6v9CfzLPGZkFCSKv6Wyrcv7G/ZQR9yJTg+DPCD3OB3z0at
         gbjSPNgS4dl1qfWGBLL17WZZJY6vFE64uacy6Usd35dzCAe5wBXCpxS0UZQizi5tfHot
         t3otpGdFeEOspMIpf7BsXTB8E0ZFiMs/D8MiYSs7m406TVK8mcLWh+HNRF97YKjRmH0L
         DVvA==
X-Gm-Message-State: ACrzQf0rYGvBdHHTeB3udGAnBIYHW8fhtE1Edrrm1pYuhcfqgRpvICys
        aBt/+K+9QrnMqP6+YOVrKTk=
X-Google-Smtp-Source: AMsMyM5iOXcgQTC/2jtw8uo5rEITNwm3nxVT6e7Gb2ff+6a6hx38sqkjtIjoRNUIvnUB1dtiKlDmGQ==
X-Received: by 2002:a5d:5847:0:b0:22b:377:6786 with SMTP id i7-20020a5d5847000000b0022b03776786mr6162060wrf.568.1663695775535;
        Tue, 20 Sep 2022 10:42:55 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id j11-20020a05600c190b00b003b49bd61b19sm705641wmq.15.2022.09.20.10.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 10:42:55 -0700 (PDT)
Message-ID: <10c27e60-792a-ae19-8af5-bdf9c134f145@gmail.com>
Date:   Tue, 20 Sep 2022 18:42:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/4] t: remove \{m,n\} from BRE grep usage
Content-Language: en-US
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <cover.1663688697.git.congdanhqx@gmail.com>
 <752b12ef1e27d3b69d6aa3734309895082be7886.1663688697.git.congdanhqx@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?UTF-8?Q?szEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
In-Reply-To: <752b12ef1e27d3b69d6aa3734309895082be7886.1663688697.git.congdanhqx@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Đoàn

On 20/09/2022 16:49, Đoàn Trần Công Danh wrote:
> \{m,n\} is a GNU extension to BRE, and it's forbidden by our
> CodingGuidelines.

\{m,n\} is valid in a posix BRE[1]. If we're already using it without 
anyone complaining I think it would be better to update CodingGuidlines 
to allow it.

Best Wishes

Phillip

[1] 
https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html

Section 9.3.6 says
...
5. When a BRE matching a single character, a subexpression, or a 
back-reference is followed by an interval expression of the format 
"\{m\}", "\{m,\}", or "\{m,n\}", together with that interval expression 
it shall match what repeated consecutive occurrences of the BRE would 
match. The values of m and n are decimal integers in the range 0 <= m<= 
n<= {RE_DUP_MAX}, where m specifies the exact or minimum number of 
occurrences and n specifies the maximum number of occurrences. The 
expression "\{m\}" shall match exactly m occurrences of the preceding 
BRE, "\{m,\}" shall match at least m occurrences, and "\{m,n\}" shall 
match any number of occurrences between m and n, inclusive.

For example, in the string "abababccccccd" the BRE "c\{3\}" is matched 
by characters seven to nine, the BRE "\(ab\)\{4,\}" is not matched at 
all, and the BRE "c\{1,3\}d" is matched by characters ten to thirteen.

> Change to fixed strings or ERE.
> 
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>   t/t3200-branch.sh             | 6 ++++--
>   t/t3305-notes-fanout.sh       | 2 +-
>   t/t3404-rebase-interactive.sh | 6 +++---
>   t/t5550-http-fetch-dumb.sh    | 2 +-
>   t/t5702-protocol-v2.sh        | 2 +-
>   5 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 9723c2827c..f05ac1fe0b 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -201,8 +201,10 @@ test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
>   
>   test_expect_success 'git branch -M baz bam should add entries to .git/logs/HEAD' '
>   	msg="Branch: renamed refs/heads/baz to refs/heads/bam" &&
> -	grep " 0\{40\}.*$msg$" .git/logs/HEAD &&
> -	grep "^0\{40\}.*$msg$" .git/logs/HEAD
> +	zero="00000000" &&
> +	zero="$zero$zero$zero$zero$zero" &&
> +	grep " $zero.*$msg$" .git/logs/HEAD &&
> +	grep "^$zero.*$msg$" .git/logs/HEAD
>   '
>   
>   test_expect_success 'git branch -M should leave orphaned HEAD alone' '
> diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
> index 22ffe5bcb9..aa3bb2e308 100755
> --- a/t/t3305-notes-fanout.sh
> +++ b/t/t3305-notes-fanout.sh
> @@ -9,7 +9,7 @@ path_has_fanout() {
>   	path=$1 &&
>   	fanout=$2 &&
>   	after_last_slash=$(($(test_oid hexsz) - $fanout * 2)) &&
> -	echo $path | grep -q "^\([0-9a-f]\{2\}/\)\{$fanout\}[0-9a-f]\{$after_last_slash\}$"
> +	echo $path | grep -q -E "^([0-9a-f][0-9a-f]/){$fanout}[0-9a-f]{$after_last_slash}$"
>   }
>   
>   touched_one_note_with_fanout() {
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 688b01e3eb..4f5abb5ad2 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1244,9 +1244,9 @@ test_expect_success 'short commit ID collide' '
>   		test $colliding_id = "$(git rev-parse HEAD | cut -c 1-4)" &&
>   		grep "^pick $colliding_id " \
>   			.git/rebase-merge/git-rebase-todo.tmp &&
> -		grep "^pick [0-9a-f]\{$hexsz\}" \
> +		grep -E "^pick [0-9a-f]{$hexsz}" \
>   			.git/rebase-merge/git-rebase-todo &&
> -		grep "^pick [0-9a-f]\{$hexsz\}" \
> +		grep -E "^pick [0-9a-f]{$hexsz}" \
>   			.git/rebase-merge/git-rebase-todo.backup &&
>   		git rebase --continue
>   	) &&
> @@ -1261,7 +1261,7 @@ test_expect_success 'respect core.abbrev' '
>   		set_cat_todo_editor &&
>   		test_must_fail git rebase -i HEAD~4 >todo-list
>   	) &&
> -	test 4 = $(grep -c "pick [0-9a-f]\{12,\}" todo-list)
> +	test 4 = $(grep -c -E "pick [0-9a-f]{12,}" todo-list)
>   '
>   
>   test_expect_success 'todo count' '
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index d7cf85ffea..8f182a3cbf 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -234,7 +234,7 @@ test_expect_success 'http-fetch --packfile' '
>   		--index-pack-arg=--keep \
>   		"$HTTPD_URL"/dumb/repo_pack.git/$p >out &&
>   
> -	grep "^keep.[0-9a-f]\{16,\}$" out &&
> +	grep -E "^keep.[0-9a-f]{16,}$" out &&
>   	cut -c6- out >packhash &&
>   
>   	# Ensure that the expected files are generated
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 5d42a355a8..b33cd4afca 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -1001,7 +1001,7 @@ test_expect_success 'part of packfile response provided as URI' '
>   	do
>   		git verify-pack --object-format=$(test_oid algo) --verbose $idx >out &&
>   		{
> -			grep "^[0-9a-f]\{16,\} " out || :
> +			grep -E "^[0-9a-f]{16,} " out || :
>   		} >out.objectlist &&
>   		if test_line_count = 1 out.objectlist
>   		then

