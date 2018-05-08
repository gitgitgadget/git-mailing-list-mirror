Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3FCB200B9
	for <e@80x24.org>; Tue,  8 May 2018 02:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeEHCgF (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 22:36:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53956 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753526AbeEHCf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 22:35:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id a67so16229127wmf.3
        for <git@vger.kernel.org>; Mon, 07 May 2018 19:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=z2EnrUvSOG51FvGiN30XuBn2UGfnymzQFk4sgGkzpiU=;
        b=LDEoK3X2zyJrmPrfSMAoOQL2B8/m/50Dm62d52/lFPaQV7SbvXhAIIadJdfUFf8PQ5
         UVkj0Y6Xv7jq7dXGLNVXZ8LLL9lVRORhSiPtZMGddSL1hD2V4ryGbfTld5GCcl7HDvhh
         9FiGJ65yrsxrZdnznTtVPKKrWIlGpp+ZcHlEvXHvwKjuRmfVLkq4P2JtTjaE2WSAMwgL
         67hmqcfcWbsMNexKFhqIBHGSqX8uv7U6zKRjDAha2HGVu1/9j2L/MAXC0KW6Hk69Hrbv
         3945kx5/9YsvAxRHNJBpxapTvMAN/s4k8NggW6GouS0ZUfuY7z6kBD40MSUD0hPuSGhx
         1Ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=z2EnrUvSOG51FvGiN30XuBn2UGfnymzQFk4sgGkzpiU=;
        b=HfA4lvy7veYr8vrDm3LWlvUGoqT/MUjmH+qvWykr8cU3J7q4EeyRrlogV/JKqfCw+K
         XigKbnyenPp9aPODRHBCmefkUzN/W2OOSICZr2K9e2ls6cRbfgQkBGoGcizbFV6OFwS7
         n0rpLZ+s4oPG+sSqwxVk2R5Jr+Pp3hw6p8ipLc/cA2TidOzujmR0Bs5CDIIBOzXY+wib
         zg8gl7yAoFjCjIyzPdZRmCgOpe61cd/1E1G8nh96rC7aGqhqwbzp0ZllvgD09wuiQQlg
         joISJ8/dNDRnyGOk0IxsOpnq/KztD1gCb6t0HZBrIYi3aZ+KS6E4OrYHTMkU9Clh8dio
         jMhA==
X-Gm-Message-State: ALKqPwe8WXlHtwcINmO44XK4+0ZCF+0BiYJfvz4TKKhUcPB+i/cJho+4
        egbqLXBrQkoaJkYPOdAcV2U=
X-Google-Smtp-Source: AB8JxZplqMK7z9lJdXCFE+ZmqCGduzeR0YC/PktgnP+xFq0+sEj0G7Xf5bi60Udi3BS9xmRrNi+npg==
X-Received: by 2002:a1c:4249:: with SMTP id p70-v6mr2091834wma.17.1525746957781;
        Mon, 07 May 2018 19:35:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 33-v6sm18061255wrs.5.2018.05.07.19.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 19:35:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/8] push tests: add more testing for forced tag pushing
References: <20180429202100.32353-1-avarab@gmail.com>
        <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
        <20180429202100.32353-4-avarab@gmail.com>
Date:   Tue, 08 May 2018 11:35:56 +0900
In-Reply-To: <20180429202100.32353-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 29 Apr 2018 20:20:55 +0000")
Message-ID: <xmqq8t8uoovn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Improve the tests added in dbfeddb12e ("push: require force for refs
> under refs/tags/", 2012-11-29) to assert that the same behavior
> applies various forms other refspecs, and that "+" in a refspec will
> override the "--no-force" option (but not the other way around).

For some reason this fell out of my radar; sorry about that.

I like the general idea to ensure non-ff pushes are rejected, unless
forced, to update a light-weight tag with another.  I am unsure what
should happen when trying to update a light-weight tag with an
object with different type (or vice versa), and haven't read in this
series what your opinion is yet.  Let's read on and see how it goes.

I have a moderately strong preference that

	$ git push --no-force child2

with a configured refspec

	[remote "child2"]
		url = ../child2
		push = +refs/tags/*:refs/tags/*

should behave as a non-forced push (regardless of the refs hierarchy
involved, not limited to tags/).  I have a mild preference against

	$ git push --no-force ../child2 +refs/tags/*:refs/tags/*

that forces, just because command line options look a lot more
explicit than the prefix '+', and choosing it not to force would
make it consistent with the desired behaviour for configured forcing
refspec.

I couldn't quite get what you meant by "(but not the other way
around)".  Did you mean

	$ git push --force ../child2 refs/tags/*:refs/tags/*

should not become non-forcing version because of the (lack of)
prefix on the refspec does not trump the --force command line
option?  If so, making

	$ git push --no-force ../child2 +refs/tags/*:refs/tags/*

not to force would make things more consistent, I suspect, i.e. we
can simply declare that presence or absense of '+' prefix in the
refspec determines the forced-ness of the push/fetch when there is
no command line option to decide it, but an explicit command line
option will always override it.  

Am I missing something obvious?

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t5516-fetch-push.sh | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 15c8d5a734..c9a2011915 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -981,7 +981,17 @@ test_expect_success 'push requires --force to update lightweight tag' '
>  		git push --force ../child2 Tag &&
>  		git tag -f Tag HEAD~ &&
>  		test_must_fail git push ../child2 Tag &&
> -		git push --force ../child2 Tag
> +		git push --force ../child2 Tag &&
> +		git tag -f Tag &&
> +		test_must_fail git push ../child2 "refs/tags/*:refs/tags/*" &&
> +		git push --force ../child2 "refs/tags/*:refs/tags/*" &&
> +		git tag -f Tag HEAD~ &&
> +		git push ../child2 "+refs/tags/*:refs/tags/*" &&
> +		git tag -f Tag &&
> +		git push --no-force ../child2 "+refs/tags/*:refs/tags/*" &&
> +		git tag -f Tag HEAD~ &&
> +		test_must_fail git push ../child2 tag Tag &&
> +		git push --force ../child2 tag Tag
>  	)
>  '
