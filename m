Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48AC31F803
	for <e@80x24.org>; Thu, 10 Jan 2019 21:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbfAJVLd (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 16:11:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39893 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfAJVLc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 16:11:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so12979749wra.6
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 13:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+MHlfzcEdpImPTfUWCcUlHiYBYUGjMAJwTQx/CZnj70=;
        b=DJGVi7R9/hNH77vntd4CzRO4D2Gn2EcXpe8KdtQylXbT9kZlNKH3EEv9wnawmB7m2m
         E3+mOyQbiItJRIlrGPIEWowosel61+EKZeApIvH2jRxrlKMw8srZyw9nkSEOiSGgfgVX
         ym7B2MsrUSQQzRatYL8iTwd7Vyayl7/kywum0ukx5qx2kmf+1Sk4lmHrMAIqr3v9LQ7u
         14iqihDCdsWkkhwe9/YxF5/rMqpmG9PThun0Ko1YOltXZV7BIhGB3OaVCl34AHfsA4oG
         NeE2x98vJ/3Y6aO7fB84cgJdCVVzUz3c+zUcWyAcj0xMG8AGGhxq0MHbk6TK+/UcLcq+
         iiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=+MHlfzcEdpImPTfUWCcUlHiYBYUGjMAJwTQx/CZnj70=;
        b=V7GM5fkpcof8yE9cyE7noQVTMhdmWaA61jYOV+miPExnNB4QR1yf8UlVQXD26fcDd2
         68lb1lZXADvqYYvlhpw9HtGbH7Sy+psLAIrdaezu5DlN3rUzPeoHymL3kTCRNPl37pZZ
         UQj5aj6Y3Yoi0cCYS5zQIrGtd3pdjeOXeAHzCGPfuaN/XnEu+2IVC9bVHhejmgOqdIbj
         pVA0Y16eFzA4fBJ02zKDOt8wFuOCMmW51xekO4Ah6q2tk7WdkMivYEdvfDuz1c/qflN3
         h3lAyEPCp+49IoH6Kqu42oPMOI5gaS3i5iRlbRKO/SDDXP5tXsxgpI/B+Vz/lgamJLQc
         LcQw==
X-Gm-Message-State: AJcUukde2HzR923SoCwKbc5waX1WhU4CLbjlhbgsyb7CKPgqwPYc8ZTo
        NzNscjX6pwy9WyzEHNlFo0c=
X-Google-Smtp-Source: ALg8bN7gU2R3Y+BDxNETpbJVamGn+vrjde/PJoZC/EMjUtvMCKzBAW0sAPZ7bRoey8cST4hiiRMukg==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr10161659wrq.108.1547154688925;
        Thu, 10 Jan 2019 13:11:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 3sm20128999wmw.46.2019.01.10.13.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 13:11:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 1/5] t5323: test cases for git-pack-redundant
References: <20190109164731.GJ4673@szeder.dev>
        <20190110120142.22271-2-worldhello.net@gmail.com>
Date:   Thu, 10 Jan 2019 13:11:27 -0800
In-Reply-To: <20190110120142.22271-2-worldhello.net@gmail.com> (Jiang Xin's
        message of "Thu, 10 Jan 2019 20:01:38 +0800")
Message-ID: <xmqqimyw1am8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Add test cases for git pack-redundant to validate new algorithm for git
> pack-redundant.
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Reviewed-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  t/t5323-pack-redundant.sh | 157 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 157 insertions(+)
>  create mode 100755 t/t5323-pack-redundant.sh
>
> diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
> new file mode 100755
> index 0000000000..7410426dee
> --- /dev/null
> +++ b/t/t5323-pack-redundant.sh
> @@ -0,0 +1,157 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2018 Jiang Xin
> +#
> +
> +test_description='git pack-redundant test'
> +
> +. ./test-lib.sh
> +
> +create_commits()
> +{

Style (see Documentation/CodingGuidelines).

> +	parent=
> +	for name in A B C D E F G H I J K L M N O P Q R
> +	do
> +		test_tick &&
> +		T=$(git write-tree) &&
> +		if test -z "$parent"
> +		then
> +			oid=$(echo $name | git commit-tree $T)
> +		else
> +			oid=$(echo $name | git commit-tree -p $parent $T)
> +		fi &&
> +		eval $name=$oid &&
> +		parent=$oid ||
> +		return 1
> +	done
> +	git update-ref refs/heads/master $M
> +}
> +
> +create_pack_1()
> +{
> +	P1=$(cd .git/objects/pack; printf "$T\n$A\n$B\n$C\n$D\n$E\n$F\n$R\n" | git pack-objects pack 2>/dev/null) &&

Yikes.  Can't "git pack-objects" get the input directly without
overlong printf, something along the lines of...

	P1=$(git -C .git/objects/pack pack-objects pack <<-EOF
		$A
		$B
		$C
		...
		$R
		EOF
	)

> +	eval P$P1=P1:$P1
> +}
> ...
> +test_expect_success 'setup' '
> +	create_commits
> +'
> +
> +test_expect_success 'no redundant packs' '
> +	create_pack_1 && create_pack_2 && create_pack_3 &&
> +	git pack-redundant --all >out &&
> +	test_must_be_empty out
> +'
> +
> +test_expect_success 'create pack 4, 5' '
> +	create_pack_4 && create_pack_5
> +'
> +
> +cat >expected <<EOF
> +P2:$P2
> +EOF

Move this to the next "expect success" block?

> +test_expect_success 'one of pack-2/pack-3 is redundant' '
> +	git pack-redundant --all >out &&
> +	sed -E -e "s#.*/pack-(.*)\.(idx|pack)#\1#" out | \

How portable is "sed -E" (it is not even in POSIX.1)?  Wouldn't it
be easier to work with to have two "-e" fed to a single sed
invocation instead?
