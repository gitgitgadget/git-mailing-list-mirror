Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD83D1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 23:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932619AbdC1XY4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 19:24:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34769 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbdC1XYz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 19:24:55 -0400
Received: by mail-pg0-f66.google.com with SMTP id o123so21942609pga.1
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 16:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZBLxkdIb9m/1mjDwgrsqx2QD/lTuJRhW4THxOCVzSvs=;
        b=kOui0e0HhlUl0F2JjwbUtDwgVbg9ObpIZONFrVSgaR8j+fIBQ0qY35u6MH5eTl+uLC
         Kmu3HocoQw72d8ON3XtBLXl5Mtzx4WhRkbQtnuUY+4ebeEaMEifBbXZH2yfogEJw3RTZ
         du/+WXx5C5M3UL+iTJjxey7pM8hnttP1DBYi8jRTc+PwdyAqXcqCltSnHBnhU2iOUo8k
         tRdnz1nMH8r+DJq7B8ie2FOkSThtHhN58vip2UVLoPtECoLdXqj5D6+dMcibPdIM3UqR
         QINzWcyuwrw6xjZl9HZGYGvyC6Dh2lcYJ+QUehYQcPwi+H7CW0WfKl4o5T2zel+/l1fz
         kzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZBLxkdIb9m/1mjDwgrsqx2QD/lTuJRhW4THxOCVzSvs=;
        b=TwMWmM43T/t6rfJx8hf+7boKiK0vCj2liVNCt2q+q9T2xtwjoejUCHthZU04oLvWD/
         ZYfaNSgq982V4loEoGEj6eoqErVxQT3y812g+7TmJYxd3oN4idcP4ZPMTFAOpC9XU+YD
         G6310m4PPdSSouA49n9OrrWyC2QGlD7Z4nCGaWxYU5k4N/O44hCSvhXkbdXRamkQ5RdW
         /prXQTG34jj+ZTBRxeVufGw+e9cpNtd+qOvu3Doa/ZTzHcMWC6CGcJO0FaRWNIksaP33
         i+Te9r7ycFsQ8VI+oFmdHSgQ+g+7mKgT85xG5PGu+A76R/s7PSebWkqUqQBxn1+31LJ9
         9RfA==
X-Gm-Message-State: AFeK/H1IHgXLc9gfSmL4cca1pQnYEr2F6rFAWA3LRAtB6WGuoqwD8W4rgbdYleKFxe4pCQ==
X-Received: by 10.84.225.18 with SMTP id t18mr25229668plj.14.1490743488594;
        Tue, 28 Mar 2017 16:24:48 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:6c52:4b14:15fb:ecda])
        by smtp.gmail.com with ESMTPSA id w189sm9323761pfw.82.2017.03.28.16.24.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Mar 2017 16:24:47 -0700 (PDT)
Date:   Tue, 28 Mar 2017 16:24:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 1/2] short status: improve reporting for submodule changes
Message-ID: <20170328232446.GT31294@aiede.mtv.corp.google.com>
References: <20170325003610.15282-1-sbeller@google.com>
 <20170328230938.9887-1-sbeller@google.com>
 <20170328230938.9887-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170328230938.9887-2-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

[...]
> +++ b/t/t7506-status-submodule.sh
[...]
> @@ -287,4 +311,82 @@ test_expect_success 'diff --submodule with merge conflict in .gitmodules' '
>  	test_cmp diff_submodule_actual diff_submodule_expect
>  '
>  
> +test_expect_success 'setup superproject with untracked file in nested submodule' '
> +	(
> +		cd super &&
> +		git clean -dfx &&
> +		rm .gitmodules &&
> +		git submodule add -f ./sub1 &&
> +		git submodule add -f ./sub2 &&
> +		git commit -a -m "messy merge in superproject" &&
> +		(
> +			cd sub1 &&
> +			git submodule add ../sub2 &&
> +			git commit -a -m "add sub2 to sub1"
> +		) &&
> +		git add sub1 &&
> +		git commit -a -m "update sub1 to contain nested sub"
> +	) &&
> +	echo "{ \$7=\"HASH\"; \$8=\"HASH\"; print }" >suppress_hashes.awk &&
> +	echo "suppress_hashes.awk" >>.git/info/exclude &&

I had some trouble following what suppress_hashes.awk does at first.

Some other examples that could be worth imitating:

- diff-lib.sh has some sanitize_diff functions using 'sed'
- t4202 has a sanitize_output functino, also using 'sed'
- grepping for $_x40 finds some other examples (these will be fun to
  change when the hash function changes, but at least they're easy to
  find).

The main general idea I have in mind is that providing a function at the
top of the file for the test to use instead of a script that interacts
with what git is tracking can make things easier to understand.

Also, could there be a comment with a diagram describing the setup
(sub1 vs sub2, etc)?

[...]
> +test_expect_success 'status with untracked file in nested submodule (porcelain)' '
> +	git -C super status --porcelain >output &&
> +	diff output - <<-\EOF
> +	 M sub1
> +	 M sub2
> +	EOF
> +'
> +
> +test_expect_success 'status with untracked file in nested submodule (porcelain=2)' '
> +	git -C super status --porcelain=2 >output &&
> +	awk -f suppress_hashes.awk output >output2 &&
> +	diff output2 - <<-\EOF
> +	1 .M S.M. 160000 160000 160000 HASH HASH sub1
> +	1 .M S..U 160000 160000 160000 HASH HASH sub2
> +	EOF
> +'
> +
> +test_expect_success 'status with untracked file in nested submodule (short)' '
> +	git -C super status --short >output &&
> +	diff output - <<-\EOF
> +	 m sub1
> +	 ? sub2
> +	EOF
> +'
> +
> +test_expect_success 'setup superproject with modified file in nested submodule' '
> +	git -C super/sub1/sub2 add file &&
> +	git -C super/sub2 add file
> +'
> +
> +test_expect_success 'status with added file in nested submodule (porcelain)' '
> +	git -C super status --porcelain >output &&
> +	diff output - <<-\EOF
> +	 M sub1
> +	 M sub2
> +	EOF
> +'
> +
> +test_expect_success 'status with added file in nested submodule (porcelain=2)' '
> +	git -C super status --porcelain=2 >output &&
> +	awk -f suppress_hashes.awk output >output2 &&
> +	diff output2 - <<-\EOF
> +	1 .M S.M. 160000 160000 160000 HASH HASH sub1
> +	1 .M S.M. 160000 160000 160000 HASH HASH sub2
> +	EOF
> +'
> +
> +test_expect_success 'status with added file in nested submodule (short)' '
> +	git -C super status --short >output &&
> +	diff output - <<-\EOF
> +	 m sub1
> +	 m sub2
> +	EOF

How does ordinary non --short "git status" handle these cases?

What should happen when there is a new untracked repository within a
submodule?

What should happen if there is both a modified tracked file and an
untracked file in a sub-submodule?


> +'
> +
>  test_done

Very nice.  Thanks --- this was exactly what I was looking for.

The rest looks good.

Sincerely,
Jonathan
