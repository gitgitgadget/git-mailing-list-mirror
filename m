Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95BCE1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 21:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfAaVod (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 16:44:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43791 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfAaVod (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 16:44:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so4918597wrs.10
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 13:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=bgIWZ0ILUcff+fpVuVKR3YA9iPMgUGqehoMZJH7KJCs=;
        b=mgTqm/c2SSWrMu+WSPcUaBbFn5bIAq2TuBtk5ro4dPkw7ZhvIKq/X2L3+62uhh0FB+
         TbgXvM+WvbTwF/nyuu6B5QmTgbuHgEPrk0iWBYW0ZJTZhJPtjbI0JcqmkvoyQQkdZtVa
         CAPyV5+bLoN+kmVWt2HMFK9btEVnTZwgm7pxxK57q31Fr0eXGwYYVqFK4+5ZDgcss4mh
         uS5IXkoIgxNXamPs7s3kLnaq4GWbwVObWcr5o6Mc2VCVteXLC+K1BUdkFqEFFitV7Pc3
         KFMp1F1694ziq0+asoJ+kv63/q6wIFAQcLpKsAVp95VWF4p7sLmyfJ129fFCpiHaRIwS
         gTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=bgIWZ0ILUcff+fpVuVKR3YA9iPMgUGqehoMZJH7KJCs=;
        b=BRwCYGBfUFe5zev/IoB5b84wIIH5s3qU6xnzgiuH6rRxEZzsA9z6tnhoCmNC8Dzazv
         Oo4v4l3VfIr7EoTGlVq3Rw66r9rULcbWvYjRFNr4EEneSIiKZrs9glpWQSSxLBt88YfB
         29Rbd1PKVdHRYmCsXJ024NmDdY86/c7A0hbQCb8/WYFoF2CI9qBJlhk5h6Kp6kZWx2ad
         1jbAu3neM60zRa/ZTcAlS0ode0dwtPVQXwMbtitPTGFSnFPOi69wxLTYb+2y0COYarEV
         0pSAf0/1mdbEfXIpQt4oFMS3Olzd177J9a9Lz5IWoZOXVfC29oDWOaITFQkagKVoUKMP
         iabA==
X-Gm-Message-State: AJcUukf7R59GkTPO/t2DYvfsoqZN3Z0Bp2cjWRU9KG0FEAX6lHpPqDFl
        PCD4Yihs70We/rc981kPyYA=
X-Google-Smtp-Source: ALg8bN6B/lZJBFoqcUrVrM/9C2AOcvGoWRIZeD8UVJOWK87VVdtSSz+NbYeTHcgBFicEZknCv9/G9g==
X-Received: by 2002:a05:6000:12c4:: with SMTP id l4mr35341705wrx.134.1548971070701;
        Thu, 31 Jan 2019 13:44:30 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 198sm645553wmt.36.2019.01.31.13.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 13:44:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v7 1/6] t5323: test cases for git-pack-redundant
References: <20190112091754.30985-1-worldhello.net@gmail.com>
        <20190130114736.30357-2-worldhello.net@gmail.com>
Date:   Thu, 31 Jan 2019 13:44:29 -0800
Message-ID: <xmqq7eek1ozm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
> new file mode 100755
> index 0000000000..710fe9884c
> --- /dev/null
> +++ b/t/t5323-pack-redundant.sh
> @@ -0,0 +1,322 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2018 Jiang Xin
> +#
> +
> +test_description='git pack-redundant test'
> +
> +. ./test-lib.sh
> +
> +create_commits () {
> +	parent=
> +	for name in A B C D E F G H I J K L M N O P Q R
> +	do
> +		test_tick &&
> +		T=$(git write-tree) &&

Move this outside loop, not for efficiency but for clarity. This
helper function creates a single empty tree and bunch of commits
that hold the same empty tree, arranged as a single strand of
pearls.

By the way, I had to draw a table like this to figure out ...

     T A B C D E F G H I J K L M N O P Q R
1    x x x x x x x                       x
2        x x x x   x x x
3                x     x x x x x
4                        x x x x     x
5                  x x           x x
6                                x x   x
7                                    x x
8      x

... what is going on.  Perhaps something like this would help other
readers near the top of the file (or in test_description)?


> +format_packfiles () {
> +	sed \
> +		-e "s#.*/pack-\(.*\)\.idx#\1#" \
> +		-e "s#.*/pack-\(.*\)\.pack#\1#" |
> +	sort -u |
> +	while read p
> +	do
> +		if test -z "$(eval echo \${P$p})"
> +		then
> +			echo $p

All the "expected output" below will expect P$n:${P$n} prepared by
various create_pack_$n helpers we saw earlier, so an unknown
packfile would be detected as a line that this emits.  Is that the
idea?

> +		else
> +			eval echo "\${P$p}"
> +		fi
> +	done |
> +	sort
> +}
> +
> +test_expect_success 'setup master.git' '
> +	git init --bare master.git &&
> +	cd master.git &&
> +	create_commits
> +'

Everything below will be done inside master.git?  Avoid cd'ing
around in random places in the test script, as a failure in any of
the steps that does cd would start later tests in an unexpected
place, if you can.

> +test_expect_success 'no redundant for pack 1, 2, 3' '
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
> +
> +test_expect_success 'one of pack-2/pack-3 is redundant' '
> +	git pack-redundant --all >out &&
> +	format_packfiles <out >actual &&
> +	test_cmp expected actual
> +'

Do the preparation of file "expect" (most of the tests compare
'expect' vs 'actual', not 'expected') _inside_ the next test that
uses it.  i.e.

	test_expect_success 'with 1 4 and 5, either 2 or 3 can be omitted' '
		cat >expect <<-EOF &&
		P2:$P2
		EOF
		git pack-redundant --all >out &&
		format ... >actual &&
		test_cmp expect actual
	'

Again, I needed to draw this to see if the "one of ... is redundant"
in the title is a valid claim.  Something like it would help future
readers.

     T A B C D E F G H I J K L M N O P Q R
1245 x x x x x x x x x x x x x x x x     x
3                x     x x x x x

     T A B C D E F G H I J K L M N O P Q R
1345 x x x x x x x x x x x x x x x x     x
2        x x x x   x x x

I won't repeat the same for tests that appear later in this file,
but they share the same issue.

> +test_expect_success 'setup shared.git' '
> +	cd "$TRASH_DIRECTORY" &&
> +	git clone -q --mirror master.git shared.git &&

Why "-q"?

> +	cd shared.git &&
> +	printf "../../master.git/objects" >objects/info/alternates
> +'

Why not echo?  I recall designing the alternates file to be a plain
text file.  Is it necessary to leave the line incomplete?

> +test_expect_success 'remove redundant packs by alt-odb, no packs left' '
> +	git pack-redundant --all --alt-odb | xargs rm &&
> +	git fsck --no-progress &&

Why "--no-progress"?

> +	test_must_fail git pack-redundant --all --alt-odb >actual 2>&1 &&
> +	test_cmp expected actual
> +'
> +
> +create_commits_others () {
> +	parent=$(git rev-parse HEAD)

If this fails, you'd still go ahead and enter the loop, which is not
what you want.

> +	for name in X Y Z
> +	do
> +		test_tick &&
> +		T=$(git write-tree) &&

Lift this outside the loop.

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
> +	git update-ref refs/heads/master $Z
> +}
