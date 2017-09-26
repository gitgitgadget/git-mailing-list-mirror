Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D4532047F
	for <e@80x24.org>; Tue, 26 Sep 2017 09:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968454AbdIZJYv (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 05:24:51 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:52849 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967742AbdIZJYs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 05:24:48 -0400
Received: by mail-pf0-f178.google.com with SMTP id p87so5261844pfj.9
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MWyNDIDoQaF7CJmPR+U7uq39Qq3FkPWC+OQwNMHxjEk=;
        b=uZ2NimU04zGrV0TCs5/sufWiwvWyEWBXL6xEBt1ZtCrZFPoIwChCNlkq3sY4ZJC1BG
         a3c0VlhxbIPqux/f07Q4Pdji6k+PQ2KWHwhpniP36iQAdO8o+OWJrGhuMv4GIFIL4Z06
         +ufO0EDp4qn24/84XtxdmlTuFHCNZvxJa1hG/ZJZU4Uikw/76Mce/A3/NvP+zsgx/o27
         IMDdUdJ44Ufh6CwQjgB16yblKJZywzBd+PA7HBQLqcNDkBVWC4S8NffD5a3X4oYyLj0i
         QIYnFUuyDPEZ0UYulA7c0IcOKtm4C7N3M4/Jsd8nJytfUTFW2RUF0r5Sb+6VnrtrZgn6
         K65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MWyNDIDoQaF7CJmPR+U7uq39Qq3FkPWC+OQwNMHxjEk=;
        b=ry+Gla0aV4rHdTV0sxzFJtzhKtSHA3gL9MuEB6xexfgw/aYfa+P0E2vfAwtxS+oD+K
         ipIcgcwEJV4RPb4Ght/1jZf0tHQtsdNp9wP3p8hdlutER4l4YNy0wXYmE/eVEAJj48Eo
         hv6MeFVFlcqN1yR7icwjKUKzniqruwmDWNplr6ow8LqLhJ4AbjPbKtn7DqJCF5mw9Mpf
         GojLSqhUbikwT3OgWgK479tNOakM7gZ4zv6iDcXWei2wvrvMoGeahx8eRWvM0AZeNNEP
         OU6jBe+l1a04neO0dVgzwULf7yPWCwl+eEsZE+cL14kd29zNEDDgjM28KPiSO7ErKoy+
         mjnw==
X-Gm-Message-State: AHPjjUjTUEUcD4YADeS8mFAv/Oa8HyfmsqvSgvz0T3NDtEPUJb6FShVg
        HiHvM7cWotK1Lk/mvTaLy6w=
X-Google-Smtp-Source: AOwi7QD6lKl9CKg80SO1nZNaeZlgKD1aS7BK0Xx0dinE5gohmxyLPNEks3k1+u1mSqJjw1vaGxVd9A==
X-Received: by 10.84.131.74 with SMTP id 68mr10314749pld.227.1506417887702;
        Tue, 26 Sep 2017 02:24:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8cad:f525:a0b8:9738])
        by smtp.gmail.com with ESMTPSA id 65sm14727842pgh.31.2017.09.26.02.24.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 02:24:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com
Subject: Re: [PATCH v2 1/5] test-list-objects: List a subset of object ids
References: <20170925095452.66833-1-dstolee@microsoft.com>
        <20170925095452.66833-2-dstolee@microsoft.com>
Date:   Tue, 26 Sep 2017 18:24:43 +0900
In-Reply-To: <20170925095452.66833-2-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 25 Sep 2017 05:54:48 -0400")
Message-ID: <xmqqd16dak2s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> diff --git a/t/helper/test-list-objects.c b/t/helper/test-list-objects.c
> new file mode 100644
> index 000000000..83b1250fe
> --- /dev/null
> +++ b/t/helper/test-list-objects.c
> @@ -0,0 +1,85 @@
> +#include "cache.h"
> +#include "packfile.h"
> +#include <stdio.h>

If you include "cache.h", like the ordinary "git" program, you
should not have to include any system headers like stdio.h
yourself.  The whole point of "git-compat-util.h must be the first
to be included (indirectly including it via cache.h and friends is
also OK)" rule is to make sure that system headers are included at
the right place in the include sequence (e.g. defining feature
macros before including certain headers, etc.).

> +int cmd_main(int ac, const char **av)
> +{
> +	unsigned int hash_delt = 0xFDB97531;
> +	unsigned int hash_base = 0x01020304;
> +...
> +	const int u_per_oid = sizeof(struct object_id) / sizeof(unsigned int);

Because the above will not work as you expect, unless your uint is
32-bit, you would probably want to make hash_delt and hash_base
explicitly uint32_t, I think.

Alternatively, because you assume that uint is at least 8-hex-digit
wide in the output loop, you can keep "unsigned int" above, but
change the divisor from sizeof(unsigned int) to a hardcoded 4.

Either would fix the issue.

> +	c.total = 0;
> +	if (ac > 1)
> +		n = atoi(av[1]);

Otherwise n will stay 0 as initialized.  Not checking the result of
atoi() is probably permissible, as this is merely a test helper and
we can assume that the caller will not do anything silly, like
passing "-3" in av[1].  But it certainly would be a good discipline
to make sure av[1] is a reasonable number.

I am afraid that I may be misreading the code, but the following
code seems to require that the caller must know roughly how many
objects there are (so that a large-enough value can be passed to
av[1] to force c.select_mod to 1) when it wants to show everything,
as the "missing" loop will run 0 times showing nothing, and
"listing" case will divide by zero.

"Not passing anything will show everything" the proposed log message
promises is a better design than what the code actually seems to be
doing.

> +
> +	if (ac > 2 && !strcmp(av[2], "--missing")) {
> +		while (c.total++ < n) {

When n==0, this does nothing.  I am not sure what the desired
behaviour should be for "When no count is given, we show everything"
in this codepath, though.

Also, doesn't "test-list-objects 5 --missing" look very wrong?
Shouldn't it be more like "test-list-objects --missing 5"?

> +			for (i = 0; i < u_per_oid; i++) {
> +				printf("%08x", hash_base);
> +				hash_base += hash_delt;
> +			}
> +			printf("\n");
> +		}
> +	} else {
> +		setup_git_directory();
> +
> +		for_each_loose_object(count_loose, &c, 0);
> +		for_each_packed_object(count_packed, &c, 0);
> +
> +		c.select_mod = 1 + c.total / n;

When n==0, this would divide by zero.
Perhaps

		c.select_mod = n ? (1 + c.total / n) : 1;

or something to keep the promise of showing everything?

> +		for_each_loose_object(output_loose, &c, 0);
> +		for_each_packed_object(output_packed, &c, 0);
> +	}
> +
> +	exit(0);
> +}

Thanks.
