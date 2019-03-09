Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94ECC20248
	for <e@80x24.org>; Sat,  9 Mar 2019 16:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCIQxt (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 11:53:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50641 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCIQxt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 11:53:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so564654wmj.0
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 08:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7xxhJ3JtPeeM+5bAvYh3iT/I4q2TPm8SJ6rhn4pzaMw=;
        b=PDdmDgllEB5c4l+MWtARzX7U89qIKcOdenkWZat4MnN5PMpeM490UzjE3dG6COXFuo
         Lw1wDQgHdVtlpctTf0/ObltLvPyK5kpl2ojhhf1UcFSYc10O6VCg8zQy0t5LV5oH1psg
         +NG9TuRnPmk/yCWds2VZjfkCnvA2i2Qf4L5u66hJItqJQHnprpFYHi5T8p2zLwsBLKW/
         Lmp9DRjI3tfxMG077dPOn9qxtlzZWEJdH09VDpJrUKvyFQP0wcZcxrqn728np/07LQOW
         SWQHhChNKN3bun/EKYhwwzRQgm77bT9Dy9szYmXcYgDgnlRlCXA2PJ0Ga6UZ05Q5sbsm
         1Hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7xxhJ3JtPeeM+5bAvYh3iT/I4q2TPm8SJ6rhn4pzaMw=;
        b=btkusn/PW1H8LMkr0MW11X/sYOI7v1RhEu5VoOnYjQlKUcsTJK86zP3kxjpXljF4ro
         CwXicvBXHeJDPUfSHtMtGmkiJGMu8UVc50tjLuAwvytV3RS9Fsa8T/BZzYCo1UtuJf5q
         q3uoYGchTUBT4uXChk5T1H1bbN4VlKbSLdxJ9rr5CtN7L/Z13Lye8tyFU1JnyyTMp1aV
         NA9DnKMcJKoS6lfUUHs1q+tk0KPztwIAq+O+DbF5Z3sMqv/d6v5t1JyAcs4n328N27/I
         opUcm8kXhEy4LtJBvH07fYhJZwhgupYMT9yStIqmH3QXcLwq7tm37V2ItbioLWgICWDb
         EEdg==
X-Gm-Message-State: APjAAAVn0SZif7jT+rdw1hxEyCbwPPpXn3mLrJinKv2yoQbfdQLunFLb
        p4M+qvFYI6tONC4RJwpxCpg=
X-Google-Smtp-Source: APXvYqzFCoOgn9PYLv0a6/+OFFlOENNtxpU220d2imvCEsltul2T/hQV422LXO3ZAJILi3oSukFi9A==
X-Received: by 2002:a1c:2ec4:: with SMTP id u187mr11809838wmu.29.1552150427171;
        Sat, 09 Mar 2019 08:53:47 -0800 (PST)
Received: from [10.33.1.6] ([185.230.127.241])
        by smtp.gmail.com with ESMTPSA id p6sm3549150wre.63.2019.03.09.08.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 08:53:46 -0800 (PST)
Subject: Re: [PATCH v1 09/11] t: add tests for restore
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190308101655.9767-10-pclouds@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <053a95ba-3063-b1bd-579c-a0c37f24e51a@gmail.com>
Date:   Sat, 9 Mar 2019 17:53:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308101655.9767-10-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/19 11:16 AM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  t/lib-patch-mode.sh               |  12 ++++
>  t/t2070-restore.sh (new +x)       |  77 ++++++++++++++++++++++
>  t/t2071-restore-patch.sh (new +x) | 105 ++++++++++++++++++++++++++++++
>  3 files changed, 194 insertions(+)
> 
> diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
> new file mode 100755
> index 0000000000..df91bf54bc
> --- /dev/null
> +++ b/t/t2070-restore.sh
> @@ -0,0 +1,77 @@
> +#!/bin/sh
> +
> +test_description='restore basic functionality'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit first &&
> +	echo first-and-a-half >>first.t &&
> +	git add first.t &&
> +	test_commit second &&
> +	echo one >one &&
> +	echo two >two &&
> +	echo untracked >untracked &&
> +	echo ignored >ignored &&
> +	echo /ignored >.gitignore &&
> +	git add one two .gitignore &&
> +	git update-ref refs/heads/one master
> +'
> +

[snip]

> +
> +test_expect_success 'restore a file, ignoring branch of same name' '
> +	cat one >expected &&
> +	echo dirty >>one &&
> +	git restore one &&
> +	test_cmp expected one
> +'
> +

Branch 'one' has been created by update-ref invocation in the setup, OK.

> +test_expect_success 'restore a file on worktree from another branch' '
> +	test_when_finished git reset --hard &&
> +	git cat-file blob first:./first.t >expected &&
> +	git restore --source=first first.t &&
> +	test_cmp expected first.t &&
> +	git cat-file blob HEAD:./first.t >expected &&
> +	git show :first.t >actual &&
> +	test_cmp expected actual
> +'

Test description reads "from another branch". However "first", created by
test_commit invocation is a tag. Maybe description should read "from another
ref"? Same applies to other tests which utilize "first".

> +
> +test_expect_success 'restore a file in the index from another branch' '
> +	test_when_finished git reset --hard &&
> +	git cat-file blob first:./first.t >expected &&
> +	git restore --source=first --index first.t &&
> +	git show :first.t >actual &&
> +	test_cmp expected actual &&
> +	git cat-file blob HEAD:./first.t >expected &&
> +	test_cmp expected first.t
> +'
> +
> +test_expect_success 'restore a file in both the index and worktree from another branch' '
> +	test_when_finished git reset --hard &&
> +	git cat-file blob first:./first.t >expected &&
> +	git restore --source=first --index --worktree first.t &&
> +	git show :first.t >actual &&
> +	test_cmp expected actual &&
> +	test_cmp expected first.t
> +'
> +
> +test_expect_success 'restore --index uses HEAD as source' '
> +	test_when_finished git reset --hard &&
> +	git cat-file blob :./first.t >expected &&
> +	echo index-dirty >>first.t &&
> +	git add first.t &&
> +	git restore --index first.t &&
> +	git cat-file blob :./first.t >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_done


--
Best regards, Andrei R.
