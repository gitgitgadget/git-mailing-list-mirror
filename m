Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C421F770
	for <e@80x24.org>; Wed,  2 Jan 2019 18:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfABSPH (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 13:15:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35430 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfABSPG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 13:15:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so16398691wmt.0
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 10:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=H7WXsaRdi3+dajEwFVpsA6INPFjC5X1x+dYQZwunadU=;
        b=Ag3bVvUbA8W+ZxvxxferqZ8cShG4SWQl7R4+lA7VlOsjLQ/PPwZkjRUGpCTiG05wuw
         HGwim7j8URA08UAcg7HkBKblHwGjspURfGytWiW70aurcNi6A/owYxYCszH+hmi9/4cl
         iO52Ob0QQ58S+yn+f4ppBmI+Sld4Sh8tud/OK0rpgRMOskNv+8N+XLdYXg8+xhirMynO
         jsFtUwLPZ05kLOa6NGti5xo+m4zOhsPsWkC/BM6cPBrWPgK7viYCjsO7OdRwoekwmsm0
         qaQPmYtB0WunilLd+4iN+pXeRB+G4fvsbaH5XqOyB1LUMEKKo+C8nyjwMLSkv6YQGXIB
         UA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=H7WXsaRdi3+dajEwFVpsA6INPFjC5X1x+dYQZwunadU=;
        b=ImcJyLSrEJsp/48ctUinJa66FoXoTiGPxVYkk2+3vtG5J2JbDT+DBeGYz0LByVO2dX
         5ixqQKqLm/KbEeXr+D1Mwd+l4DW+zFgWdbWXOXHP+3wnKDUv5FX2RxLi3DHT99l7bzi1
         MiWFht3alT7MmMZc5aTfLSm6KN7QXhCWV+jFaLnQFgI2CvonRe/4yd6KNL/7rIzaEcJS
         OVGdCfLm7qnVoHlIzriETAkbD2r/1YLNM3m/umbQ2+RWGdkytR1xIXhlJfUBJlseXYuU
         qHDt/+PqHIgx+CerFaqirLxM5SyF0OZyshyvY1TkZ42UdkQ5TS+uNe6eBPU+yhUALXm3
         3aGA==
X-Gm-Message-State: AA+aEWanAGlRL7dINp1eqkeya3KW6ItaPAih8r6+/q5+YutQb2t1XV3L
        VjlephxqHKPxcZ+snIPyJnM=
X-Google-Smtp-Source: ALg8bN654/1wexl4wWxYcLC0DgR2Zvwg313o6oDxhMQDOe2WbNwz+gDyL/rx8uNnvUoHCmzJHnZN8w==
X-Received: by 2002:a1c:5dd1:: with SMTP id r200mr37607408wmb.93.1546452903810;
        Wed, 02 Jan 2019 10:15:03 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n82sm42776850wma.42.2019.01.02.10.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 10:15:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/3] t0006-date.sh: add `human` date format tests.
References: <20181231003150.8031-1-ischis2@cox.net>
        <20181231003150.8031-4-ischis2@cox.net>
Date:   Wed, 02 Jan 2019 10:15:02 -0800
In-Reply-To: <20181231003150.8031-4-ischis2@cox.net> (Stephen P. Smith's
        message of "Sun, 30 Dec 2018 17:31:50 -0700")
Message-ID: <xmqqva37j595.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stephen P. Smith" <ischis2@cox.net> writes:

> +# Subtract some known constant time and look for expected field format
> +TODAY_REGEX='5 hours ago'
> +THIS_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [012][0-9]:[0-6][0-9]'
> +MORE_THAN_A_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [0-9][0-9][0-9][0-9]'
> +check_human_date "$(($(date +%s)-18000)) +0200" $TODAY_REGEX # 5 hours ago
> +check_human_date "$(($(date +%s)-432000)) +0200" $THIS_YEAR_REGEX  # 5 days ago

'date +%s' is used everywhere in this patch but has never been used
in our test suite before.  It is not portable.

We perhaps can use "test-tool date timestamp", like so

	check_human_date $(test-tool date timestamp "18000 seconds ago") ...

or moving the part that munges 18000 into the above form inside
check_human_date helper function, e.g.

	check_human_date () {
		commit_date=$(test-tool date timestamp "$1 seconds ago")
		commit_date="$commit_date +0200"
                expect=$2
		...
	}

which would let us write

	check_human_date 432000" $THIS_YEAR_REGEX  # 5 days ago

> +check_human_date() {
> +	commit_date=$1
> +	expect=$2
> +	test_expect_success "$commit_date" "
> +		echo $expect $commit_date >dates && 
> +		git add dates &&
> +		git commit -m 'Expect String' --date=\"$commit_date\" dates &&
> +		git log -1 --date=human | grep \"^Date:\" >actual &&
> +		grep \"$expect\" actual
> +"

As the body of the test_expect_success helper is eval'ed, variables
$commit_date and $expect should be visible to it, without turning
them into values before executing test_expect_success function,
i.e.

	test_expect_success "$commit_date" '
		echo "$expect $commit_date" >dates &&
		...
		git commit -m "Expect String" --date="$commit_date" dates &&
		git show -s --date=human | grep '^Date:" >actual &&
		grep "$expect" actual
	'

which would reduce the need for unreadable backslashes.

Instead of duplicating, perhaps move this to a more common place?
Would it make sense to make it "check_date_format ()" helper by
passing another argument to parameterize --date=human part

> +check_human_date() {
> +	commit_date=$1
> +	expect=$2
> +	test_expect_success "$commit_date" "
> +		echo $expect $commit_date >dates && 
> +		git add dates &&
> +		git commit -m 'Expect String' --date=\"$commit_date\" dates &&
> +		git show --date=human | grep \"^Date:\" >actual &&

Using "show" here is much better than "log -1" above; using "show
-s" would be even better.

> +		grep \"$expect\" actual
> +"
> +}
> +
> +TODAY_REGEX='[A-Z][a-z][a-z] [012][0-9]:[0-6][0-9] .0200'
> +THIS_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [012][0-9]:[0-6][0-9]'
> +MORE_THAN_A_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [0-9][0-9][0-9][0-9]'
> +check_human_date "$(($(date +%s)-18000)) +0200" $TODAY_REGEX # 5 hours ago
> +check_human_date "$(($(date +%s)-432000)) +0200" $THIS_YEAR_REGEX  # 5 days ago
> +check_human_date "$(($(date +%s)-1728000)) +0200" $THIS_YEAR_REGEX # 3 weeks ago
> +check_human_date "$(($(date +%s)-13000000)) +0200" $THIS_YEAR_REGEX # 5 months ago
> +check_human_date "$(($(date +%s)-31449600)) +0200" $THIS_YEAR_REGEX # 12 months ago
> +check_human_date "$(($(date +%s)-37500000)) +0200" $MORE_THAN_A_YEAR_REGEX # 1 year, 2 months ago
> +check_human_date "$(($(date +%s)-55188000)) +0200" $MORE_THAN_A_YEAR_REGEX # 1 year, 9 months ago
> +check_human_date "$(($(date +%s)-630000000)) +0200" $MORE_THAN_A_YEAR_REGEX # 20 years ago
> +
> +
>  test_done
