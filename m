Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F141F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 00:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeJGHP5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 03:15:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38950 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeJGHP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 03:15:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id 61-v6so16281545wrb.6
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 17:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cRzrDl2syh1g8ihaeb4sBRylPow9yTiO7jUkg8WSd5E=;
        b=Kqx1t2bKc8USN2Mi/EGom8XKROqUAIFCGhtapXhVZkOC8JI4+GDy+zMrMiNfTKosMf
         6JW7oD3zUf6Eg/4YwZpN8DimlvPG6eKpniJ1ifHSlGU/PmN0p+zBHbGvglBNPdT90ktS
         v46/WD/cZquEJ94+3mgnFTesIHLsYY/aY0ysltAsP3EfZ0QWnZRU9JlaaRG4QbjVIeQP
         e/okd4jtiVEXNqWVprc1K2EBZ+iT4cBTZaGu4GfKdG7FWSWqAUq/i/5uiRf4B6UasQaO
         HSD6wvMB+jnTRm+mzUJ4Pv9Wj0/BjLfJ+Ki2YI+m6H117jEvxVj0Mzzmh+xT5EOZ6vW2
         K82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cRzrDl2syh1g8ihaeb4sBRylPow9yTiO7jUkg8WSd5E=;
        b=OS95PlH3J7Tu6abxVYG2GzjFCNUVf5QPpfpeJ7vYCJXzxYwDtCzgOVZXO/X5QlydyF
         XC6ZGehMBB+R5TEgFuLDo0XWkPRHU70aHDkwTMo6pIGMPCos7lB7nj2ZljmUhUQHqsl0
         F3or5aLnbqfLT6DTxKAa+wuCDJvhLQvQirWOonK6jo8aQxxJeGozYtKebvlbdDnLuTpc
         rwUOKeGU3ao9FzCqiympSCy7jx15+P6BuqAINgmOOZaBQSOzdmnAM7OP7bB0TLsrxjBX
         1Plu2dGdY6P4br3Jz03jRnFWoZxhMkcwtDYeTHV6H+unSeWnfFm1gFIPptToPGaFDvfu
         mhAA==
X-Gm-Message-State: ABuFfoj9zGe1NTJiQzAyIYssAYIAuZ4U8+dSZdksQOBJ4aiTPUPMZaOj
        iDSwMnlOa3tfF9ctYVBgmhA=
X-Google-Smtp-Source: ACcGV62p73poRowdoTTaTlkpXwD6iSsb5eJkMONDMel4mSiGT8AiZGbzAFVbqfh3EUJsjydUtG3sdw==
X-Received: by 2002:adf:f84e:: with SMTP id d14-v6mr12298553wrq.174.1538871041752;
        Sat, 06 Oct 2018 17:10:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b8-v6sm1714186wme.1.2018.10.06.17.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 17:10:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: Re: [PATCH v11 8/8] list-objects-filter: implement filter tree:0
References: <cover.1533854545.git.matvore@google.com>
        <cover.1538774738.git.matvore@google.com>
        <6ca50a28e292f32127ea706a2aef39f834ac7702.1538774738.git.matvore@google.com>
Date:   Sun, 07 Oct 2018 09:10:39 +0900
In-Reply-To: <6ca50a28e292f32127ea706a2aef39f834ac7702.1538774738.git.matvore@google.com>
        (Matthew DeVore's message of "Fri, 5 Oct 2018 14:31:27 -0700")
Message-ID: <xmqqpnwmvcow.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> The name "tree:0" allows later filtering based on depth, i.e. "tree:1"
> would filter out all but the root tree and blobs. In order to avoid
> confusion between 0 and capital O, the documentation was worded in a
> somewhat round-about way that also hints at this future improvement to
> the feature.
>
> Signed-off-by: Matthew DeVore <matvore@google.com>

Thanks.

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 7b273635d..5f1672913 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -731,6 +731,11 @@ the requested refs.
>  +
>  The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
>  specification contained in <path>.
> ++
> +The form '--filter=tree:<depth>' omits all blobs and trees whose depth
> +from the root tree is >= <depth> (minimum depth if an object is located
> +at multiple depths in the commits traversed). Currently, only <depth>=0
> +is supported, which omits all blobs and trees.

OK.

> diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
> index 9839b48c1..510d3537f 100755
> --- a/t/t5317-pack-objects-filter-objects.sh
> +++ b/t/t5317-pack-objects-filter-objects.sh
> @@ -72,6 +72,34 @@ test_expect_success 'get an error for missing tree object' '
>  	grep -q "bad tree object" bad_tree
>  '

As output made inside test_expect_{succcess,failure} are discarded
by default and shown while debugging tests, there is no strong
reason to use "grep -q" in our tests.  I saw a few instances of
"grep -q" added in this series including this one

	test_must_fail grep -q "$file_4" observed

that should probably be

	! grep "$file_4" observed

> +	printf "blob\ncommit\ntree\n" >unique_types.expected &&
> ...
> +	printf "blob\ntree\n" >expected &&

Using test_write_lines is probably easier to read.

Other than these two minor classes of nits, the series look quite
well cooked to me.

Thanks.
