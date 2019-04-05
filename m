Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D29320248
	for <e@80x24.org>; Fri,  5 Apr 2019 10:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfDEKui (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 06:50:38 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40607 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbfDEKui (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 06:50:38 -0400
Received: by mail-wm1-f48.google.com with SMTP id z24so6691395wmi.5
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LdSElWFx2bOVUM86wFGjjEyVjx8NRUL6l4iGwey9hck=;
        b=VHBvh4Khh1DvVuDPzsFDzmzDLzjfv+VLtd+x40WhoaxCbmIR/CF/WGCwlPbC20DU/N
         WM3IFCTR3A6EyIYEbulSluFtxRWmW740kd0NV4DN8NgoCRN78BeK4IO9ZZPF8tax123G
         L/VfDkP6mjF6Wdhaxz/zftfTtS9NIuCkomOO97H2yTW6enS/tRBTOgefNPVsduzJR4JY
         w9NowhKyD8puyMF4Ul9FSUYZPdrbQanThfwVvl0jcRejGqP5JK3uqjMh6fM9nqN5rL43
         qTEk3WLKi0b+mHeJ2HdvmQPbFvtIMOdKlwfQbfGECw9ZbbsxAsrRspUFioYZgw9pK7Na
         orHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LdSElWFx2bOVUM86wFGjjEyVjx8NRUL6l4iGwey9hck=;
        b=YEzZ1H7EZanxd9+Bh+YUJ9zCZvBCG8HmzHpZjZjcDOorIB2fsJaMpbGjM2pip6gNSM
         F97NKJ2mARMjz0o1uLYIpSEfNOX6ipDpdebR1kgtTLm7K+PbvUt6Z04zey1ZIS9iXGKW
         JCOnNiAhg8MLu5y5rjlzZ9fJ03FTHJll7slXYFI2MGIkR8UW6wqguv6vx15plDAxBClN
         bxduyxZd9a23wK/M7UEAATPLyZOQgVL2N4hwVDCpf1zOsr4+8o+zlucTu+DqwCKCV4Pd
         /cNjqHPCssZChN/3fbPvaSJFtgvERxrw02pEpq8rklQFh5Sb+5DX7PYsU4jmO7vJKIW4
         Q8ng==
X-Gm-Message-State: APjAAAUrcFiigV/xdIibS6txDNDdblrZZC1HEBXeyD/JCk9TS1eAEHHk
        QHuQdko3/Hl4PIdO6HrH1L90NhJglIE=
X-Google-Smtp-Source: APXvYqyLN0Twt3xcdQvTpnvDIVAi+sNQaNKbM7r1mx1A3KVL1AHr0PQo8X3wyzr27jZqhbsTQSe8nw==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr7474208wme.4.1554461436402;
        Fri, 05 Apr 2019 03:50:36 -0700 (PDT)
Received: from szeder.dev (x4d0c3c70.dyn.telefonica.de. [77.12.60.112])
        by smtp.gmail.com with ESMTPSA id i28sm61745156wrc.32.2019.04.05.03.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 03:50:35 -0700 (PDT)
Date:   Fri, 5 Apr 2019 12:50:33 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 2/7] t: introduce tests for unexpected object types
Message-ID: <20190405105033.GT32732@szeder.dev>
References: <cover.1554435033.git.me@ttaylorr.com>
 <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef6b4f380435d9743a56f47f68c18123bf0a0933.1554435033.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 04, 2019 at 08:37:44PM -0700, Taylor Blau wrote:
> diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
> new file mode 100755
> index 0000000000..472b08528a
> --- /dev/null
> +++ b/t/t6102-rev-list-unexpected-objects.sh
> @@ -0,0 +1,123 @@
> +#!/bin/sh
> +
> +test_description='git rev-list should handle unexpected object types'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup well-formed objects' '
> +	blob="$(printf "foo" | git hash-object -w --stdin)" &&
> +	tree="$(printf "100644 blob $blob\tfoo" | git mktree)" &&
> +	commit="$(git commit-tree $tree -m "first commit")"
> +'
> +
> +test_expect_success 'setup unexpected non-blob entry' '
> +	printf "100644 foo\0$(echo $tree | hex2oct)" >broken-tree &&
> +	broken_tree="$(git hash-object -w --literally -t tree broken-tree)"
> +'
> +
> +test_expect_failure 'traverse unexpected non-blob entry (lone)' '
> +	test_must_fail git rev-list --objects $broken_tree
> +'
> +
> +test_expect_failure 'traverse unexpected non-blob entry (seen)' '
> +	test_must_fail git rev-list --objects $tree $broken_tree
> +'
> +
> +test_expect_success 'setup unexpected non-tree entry' '
> +	printf "40000 foo\0$(echo $blob | hex2oct)" >broken-tree &&
> +	broken_tree="$(git hash-object -w --literally -t tree broken-tree)"
> +'
> +
> +test_expect_failure 'traverse unexpected non-tree entry (lone)' '
> +	test_must_fail git rev-list --objects $broken_tree
> +'
> +
> +test_expect_failure 'traverse unexpected non-tree entry (seen)' '
> +	test_must_fail git rev-list --objects $blob $broken_tree >output 2>&1

This test saves standard output and error, but doesn't look at them.

> +'
> +
> +test_expect_success 'setup unexpected non-commit parent' '
> +	git cat-file commit $commit |
> +		perl -lpe "/^author/ && print q(parent $blob)" \
> +		>broken-commit &&

Don't run git commands upstream of a pipe, because the pipe hides
their exit code.  This applies to several other tests below as well.

Wouldn't a 'sed' one-liner suffice, so we won't have yet another perl
dependency?

> +	broken_commit="$(git hash-object -w --literally -t commit \
> +		broken-commit)"
> +'
> +
> +test_expect_success 'traverse unexpected non-commit parent (lone)' '
> +	test_must_fail git rev-list --objects $broken_commit >output 2>&1 &&
> +	test_i18ngrep "not a commit" output

Please make sure that this "not a commit" message goes to the file
descriptor it is supposed to, i.e., assuming it's part of an error
message:

  test_must_fail git rev-list .... 2>err &&
  test_i18ngrep "..." err

This applies to several other tests below and in other patches as
well.

> +'
> +
> +test_expect_success 'traverse unexpected non-commit parent (seen)' '
> +	test_must_fail git rev-list --objects $commit $broken_commit \
> +		>output 2>&1 &&
> +	test_i18ngrep "not a commit" output
> +'
> +
> +test_expect_success 'setup unexpected non-tree root' '
> +	git cat-file commit $commit |
> +	sed -e "s/$tree/$blob/" >broken-commit &&
> +	broken_commit="$(git hash-object -w --literally -t commit \
> +		broken-commit)"
> +'
> +
> +test_expect_failure 'traverse unexpected non-tree root (lone)' '
> +	test_must_fail git rev-list --objects $broken_commit
> +'
> +
> +test_expect_failure 'traverse unexpected non-tree root (seen)' '
> +	test_must_fail git rev-list --objects $blob $broken_commit
> +'
> +
> +test_expect_success 'setup unexpected non-commit tag' '
> +	git tag -a -m "tagged commit" tag $commit &&
> +	test_when_finished "git tag -d tag" &&
> +	git cat-file -p tag | sed -e "s/$commit/$blob/" >broken-tag &&
> +	tag=$(git hash-object -w --literally -t tag broken-tag)
> +'
> +
> +test_expect_success 'traverse unexpected non-commit tag (lone)' '
> +	test_must_fail git rev-list --objects $tag
> +'
> +
> +test_expect_success 'traverse unexpected non-commit tag (seen)' '
> +	test_must_fail git rev-list --objects $blob $tag >output 2>&1 &&
> +	test_i18ngrep "not a commit" output
> +'
> +
> +test_expect_success 'setup unexpected non-tree tag' '
> +	git tag -a -m "tagged tree" tag $tree &&
> +	test_when_finished "git tag -d tag" &&
> +	git cat-file -p tag |
> +	sed -e "s/$tree/$blob/" >broken-tag &&
> +	tag=$(git hash-object -w --literally -t tag broken-tag)
> +'
> +
> +test_expect_success 'traverse unexpected non-tree tag (lone)' '
> +	test_must_fail git rev-list --objects $tag
> +'
> +
> +test_expect_success 'traverse unexpected non-tree tag (seen)' '
> +	test_must_fail git rev-list --objects $blob $tag >output 2>&1 &&
> +	test_i18ngrep "not a tree" output
> +'
> +
> +test_expect_success 'setup unexpected non-blob tag' '
> +	git tag -a -m "tagged blob" tag $blob &&
> +	test_when_finished "git tag -d tag" &&
> +	git cat-file -p tag |
> +	sed -e "s/$blob/$commit/" >broken-tag &&
> +	tag=$(git hash-object -w --literally -t tag broken-tag)
> +'
> +
> +test_expect_failure 'traverse unexpected non-blob tag (lone)' '
> +	test_must_fail git rev-list --objects $tag
> +'
> +
> +test_expect_success 'traverse unexpected non-blob tag (seen)' '
> +	test_must_fail git rev-list --objects $commit $tag >output 2>&1 &&
> +	test_i18ngrep "not a blob" output
> +'
> +
> +test_done
> -- 
> 2.21.0.203.g358da99528
> 
