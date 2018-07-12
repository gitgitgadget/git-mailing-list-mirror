Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 209021F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 20:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbeGLUYS (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 16:24:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38249 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeGLUYS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 16:24:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id m1-v6so10191843wrg.5
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LIpS/N+dEUpgVTrEouzZ4yJOl+KEXeBnF0I7aUjXUi4=;
        b=id5wDEgANTE/xc4vpGdWbckDyqvHKuoCpIAkP6xEjO9gCmrSOHL8SU+jbi9aWCA2UP
         fa8NgIQ+uaUrovouimiIjEORRrHekNV6p5HnD8brk6Okq6LDjfOJFdS+kTGg7vcx0Nzi
         LJaLURKovg3Lab1apkBP+s3D7MaBFMki8XxBoiW3kOcMxzKmxskfx0Ee5j7MM4ZCFgbJ
         RGWcPdY7J49SLE2l615Fr0DRXv5IXxHTnJhWhFwKkfQfyEEeMzpQokYxOMvsfAJgNiVM
         /OlWaKrcUulQGqj6Z+ZiDaqU99hOChjGyKWbFfVnx/Kz6mQdTiOTBp6dHC4Wvh/F5VD0
         c/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LIpS/N+dEUpgVTrEouzZ4yJOl+KEXeBnF0I7aUjXUi4=;
        b=TRnk+GrdjegRyNZGyoNFTYEre4E+HA8NHYTHAhzMJGDVjyU6MKmld24uef1iM1cEeD
         sgEgUMPeEkkfJLpmx8KSFV0dIYaSy0TGh1bvPgvIO6GCux0R8UAjpVEgejDT+MWla7v/
         aa8vT0eWcd5FaWewHhel0w8bDzHHOQr+D6kFsrcSqeibsdB9yezyb1XnsgwR4f8jDDUN
         IuXIGnY8BL/vkTvkv8NFtwgAt8IucxpsAL877ud7RKuAhSsYHXcWKlzQyqXpXrFSIKq7
         GKtUJ1A+kMuQoKG5PPcsa4fOy+RS8hA9O3/xpqdqHaQpxz1iFyxfUq+G1qgA6Ht4lwOc
         1Nyg==
X-Gm-Message-State: AOUpUlGEwwnjN1LBLew5dFRF48zV/lPS43ttN+wLplTo1v5v79H+nAGE
        BsvU63SqjHco1tSWoyMr8x2WYTZx
X-Google-Smtp-Source: AAOMgpcjPtsYqjlBY3vR74rIIPdqZxDmFS3sbOAKS3ZoJBoi0TP1a3YRSSkHafxPN1iADC++E8+aqg==
X-Received: by 2002:adf:81a3:: with SMTP id 32-v6mr2993972wra.9.1531426389432;
        Thu, 12 Jul 2018 13:13:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s124-v6sm6690785wmf.47.2018.07.12.13.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 13:13:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Akinori MUSHA" <knu@iDaemons.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script properly
References: <86a7qwpt9g.knu@iDaemons.org>
Date:   Thu, 12 Jul 2018 13:13:07 -0700
In-Reply-To: <86a7qwpt9g.knu@iDaemons.org> (Akinori MUSHA's message of "Thu,
        12 Jul 2018 20:18:52 +0900")
Message-ID: <xmqqa7qww6uk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Akinori MUSHA" <knu@iDaemons.org> writes:

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 352a52e59..345b103eb 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -75,6 +75,19 @@ test_expect_success 'rebase --keep-empty' '
>  	test_line_count = 6 actual
>  '
>  
> +test_expect_success 'rebase -i writes out .git/rebase-merge/author-script in "edit" that sh(1) can parse' '
> +	test_when_finished "git rebase --abort ||:" &&
> +	git checkout master &&
> +	set_fake_editor &&
> +	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
> +	test -f .git/rebase-merge/author-script &&
> +	unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&

Is this "unset" safe?  Some POSIX compliant shells barf if you unset
a variable that is not set, so the answer to my question is yes only
if we know these three variables are always set.

> +	eval "$(cat .git/rebase-merge/author-script)" &&
> +	test "$(git show --quiet --pretty=format:%an)" = "$GIT_AUTHOR_NAME" &&
> +	test "$(git show --quiet --pretty=format:%ae)" = "$GIT_AUTHOR_EMAIL" &&
> +	test "$(git show --quiet --date=raw --pretty=format:@%ad)" = "$GIT_AUTHOR_DATE"

Oh, actually it is even worse than that.  What if author-script is
bogus, like in the version before your patch fixes the code?  We do
not restore the AUTHOR_NAME/EMAIL/DATE after this test_expect_success
fails.  How does that, i.e. missing some variable, affect execution
of later steps in this same test script?

I _think_ the right and safe way to fix taht is to do something like
this:

	test -f .git/rebase-merge/author-script &&
	(
		safe_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL ... &&
		eval "$(cat .git/rebase-merge/author-script)" &&
		test ... &&
		test ... &&
		test ...
	)

That way, we won't have to worry about GIT_AUTHOR_* variables
getting modified and affecting the tests that come later in the
script.

> +'
> +
>  test_expect_success 'rebase -i with the exec command' '
>  	git checkout master &&
>  	(
> -- 
> 2.18.0
