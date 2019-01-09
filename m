Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1104A1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 12:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfAIM4e (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 07:56:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55042 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbfAIM4e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 07:56:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so7524523wmh.4
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 04:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1hvNYFWstmlHl6Ba38FXJUYBQ/XqjqZJbh6GLANeMLY=;
        b=EYFF9/qel7qdVbFdoIWivjNlYK62QSheTbpplK/ejtSN54B7215FyZXIHsWU4tFvyV
         s3VlhgtmZBqsLIzA1ECe+t75U4ByCywabIDCAXRbxcvcXb/JipDg0Sx8NB39NIMolkgk
         HthhmjRBH0pPTaU0i2TqZGfN6ofs++wF5A77thShan9qdXgKPDETfBYt3jlyaUttxNtZ
         FDDArYPYfPVCovIDWuWAcU/Rp8v9B7Mh7JX7cX+sv9pMPNBtBdUUUOkBEf5APKsVvTOK
         8EWsJbrG5cis4/AaWNgl6xlPQuaRNKxNQzc4gr18hLRaXu3lAuw1MM9NqCpC8+bvwbgy
         +oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1hvNYFWstmlHl6Ba38FXJUYBQ/XqjqZJbh6GLANeMLY=;
        b=Du0WNwlbFpngEpVDqA0rxU/0n0Oz9/KaZ02YP+IiDdV31JAG0jxEmiJpd/G5d81g7m
         JqdHJebHWQQ8xsYfRfP7G7i8Ct8Iam2qpm5ihGHds2Ztnq+ntmoBH+g/BddGu4/mkD1f
         oM2DG65zNSL1ZQoZdNuZ/ei/wAZVOTeIA7fHcfrJ4wKWtPPkrIae8L2DK1bkrfCyeALb
         i+n9ViARqH7jnCIl3x9r5C3K5GXBRiLqNtiNe4xOkz7f11AQjq6IifaCrGvKBKkQmqrw
         Pf0iHldNrkx+yeWkkaJ8rNXkCkcT5+5g3LYbMXK5rlgVXzpQCCtSxpVkjb/n9Cktd3Sg
         wZcw==
X-Gm-Message-State: AJcUukfML6evYv18tl8QkrfXsmZtgThXAOpApl7W7L34dmxuVgwpCj/N
        A/AyGxmaLtw8DWVjNAb8abA=
X-Google-Smtp-Source: ALg8bN75nOaD3DC67ltPg3rtK42yD69kE6NdAGpRimKzw6DrhrcywS9TygjeaHdlWMcM8HKz6hvuXQ==
X-Received: by 2002:a1c:d1cd:: with SMTP id i196mr5446264wmg.107.1547038591394;
        Wed, 09 Jan 2019 04:56:31 -0800 (PST)
Received: from szeder.dev (x4db906b6.dyn.telefonica.de. [77.185.6.182])
        by smtp.gmail.com with ESMTPSA id j33sm86031359wre.91.2019.01.09.04.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 04:56:30 -0800 (PST)
Date:   Wed, 9 Jan 2019 13:56:28 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Sun Chao <sunchao9@huawei.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 1/3] t5323: test cases for git-pack-redundant
Message-ID: <20190109125628.GG4673@szeder.dev>
References: <20181219121451.21697-1-worldhello.net@gmail.com>
 <20190102043456.15652-2-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190102043456.15652-2-worldhello.net@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 02, 2019 at 12:34:54PM +0800, Jiang Xin wrote:
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> 
> Add test cases for git pack-redundant to validate new algorithm for git
> pack-redundant.
> 
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  t/t5323-pack-redundant.sh | 84 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100755 t/t5323-pack-redundant.sh
> 
> diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
> new file mode 100755
> index 0000000000..ef6076f065
> --- /dev/null
> +++ b/t/t5323-pack-redundant.sh
> @@ -0,0 +1,84 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2018 Jiang Xin
> +#
> +
> +test_description='git redundant test'

s/redundant/pack-redundant/ ?

> +
> +. ./test-lib.sh
> +
> +create_commits()
> +{
> +	set -e
> +	parent=
> +	for name in A B C D E F G H I J K L M
> +	do
> +		test_tick
> +		T=$(git write-tree)
> +		if test -z "$parent"
> +		then
> +			sha1=$(echo $name | git commit-tree $T)

There is a considerable effort going on to switch from SHA-1 to a
different hash function, so please don't add any new $sha1 variable;
call it $oid or $commit instead.

> +		else
> +			sha1=$(echo $name | git commit-tree -p $parent $T)
> +		fi
> +		eval $name=$sha1
> +		parent=$sha1
> +	done
> +	git update-ref refs/heads/master $M
> +}
> +
> +create_redundant_packs()
> +{
> +	set -e
> +	cd .git/objects/pack
> +	P1=$(printf "$T\n$A\n" | git pack-objects pack 2>/dev/null)
> +	P2=$(printf "$T\n$A\n$B\n$C\n$D\n$E\n" | git pack-objects pack 2>/dev/null)
> +	P3=$(printf "$C\n$D\n$F\n$G\n$I\n$J\n" | git pack-objects pack 2>/dev/null)
> +	P4=$(printf "$D\n$E\n$G\n$H\n$J\n$K\n" | git pack-objects pack 2>/dev/null)
> +	P5=$(printf "$F\n$G\n$H\n" | git pack-objects pack 2>/dev/null)
> +	P6=$(printf "$F\n$I\n$L\n" | git pack-objects pack 2>/dev/null)
> +	P7=$(printf "$H\n$K\n$M\n" | git pack-objects pack 2>/dev/null)
> +	P8=$(printf "$L\n$M\n" | git pack-objects pack 2>/dev/null)
> +	cd -
> +	eval P$P1=P1:$P1
> +	eval P$P2=P2:$P2
> +	eval P$P3=P3:$P3
> +	eval P$P4=P4:$P4
> +	eval P$P5=P5:$P5
> +	eval P$P6=P6:$P6
> +	eval P$P7=P7:$P7
> +	eval P$P8=P8:$P8
> +}
> +
> +# Create commits and packs
> +create_commits
> +create_redundant_packs

Please perform all setup tasks in a test_expect_success block, so we
get verbose and trace output about what's going on.

Don't use 'set -e', use an &&-chain instead.  To fail the test if a
command in the for loop were to fail you could do something like this:

  for ....
  do
    do-this &&
    do-that ||
    return 1
  done

> +
> +test_expect_success 'clear loose objects' '
> +	git prune-packed &&
> +	test $(find .git/objects -type f | grep -v pack | wc -l) -eq 0

Use something like

  find .git/objects -type f | grep -v pack >out &&
  test_must_be_empty out

instead, so we get an informative error message on failure.

> +'
> +
> +cat >expected <<EOF
> +P1:$P1
> +P4:$P4
> +P5:$P5
> +P6:$P6
> +EOF
> +
> +test_expect_success 'git pack-redundant --all' '
> +	git pack-redundant --all | \

Don't run a git command (especially the particular command the test
script focuses on) upstream of a pipe, because it hides the command's
exit code.  Use an intermediate file instead.

> +		sed -e "s#^.*/pack-\(.*\)\.\(idx\|pack\)#\1#g" | \

This sed command doesn't seem to work on macOS (on Travis CI), and
causes the test to fail with:

  ++git pack-redundant --all
  ++sed -e 's#^.*/pack-\(.*\)\.\(idx\|pack\)#\1#g'
  ++sort -u
  ++read p
  ++sort
  ++eval echo '${P.git/objects/pack/pack-0cf5cb6afaa1bae36b8e61ca398dbe29a15bc74e.idx}'
  ./test-lib.sh: line 697: ${P.git/objects/pack/pack-0cf5cb6afaa1bae36b8e61ca398dbe29a15bc74e.idx}: bad substitution
  ++test_cmp expected actual
  ++diff -u expected actual
  --- expected    2019-01-09 01:53:45.000000000 +0000
  +++ actual      2019-01-09 01:53:45.000000000 +0000
  @@ -1,4 +0,0 @@
  -P1:24ee080366509364d04a138cd4e168dc4ff33354
  -P4:139d8b0cfe7e8970a8f3533835f90278d88de474
  -P5:23e0f02d822fa4bfe5ee63337ba5632cd7be208e
  -P6:deeb289f1749972f1cd57c3b9f359ece2361f60a
  error: last command exited with $?=1
  not ok 2 - git pack-redundant --all

I'm not sure what's wrong with it, though.

Minor nit: 'git pack-redundant' prints one filename per line, so the
'g' at the end of the 's###g' is not necessary.

> +		sort -u | \
> +		while read p; do eval echo "\${P$p}"; done | \
> +		sort > actual && \

Style nit: no space between redirection operator and filename

> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'remove redundant packs' '
> +	git pack-redundant --all | xargs rm &&
> +	git fsck &&
> +	test $(git pack-redundant --all | wc -l) -eq 0
> +'
> +
> +test_done
> -- 
> 2.14.5.agit.2
> 
