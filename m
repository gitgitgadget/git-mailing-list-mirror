Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F6ED20254
	for <e@80x24.org>; Mon, 27 Feb 2017 19:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbdB0Td1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 14:33:27 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33266 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbdB0Td0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 14:33:26 -0500
Received: by mail-pf0-f195.google.com with SMTP id p185so1052505pfb.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 11:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Xe/cl6rRtOkB7jxwy08Y/J8Ly/46MEA5YF+gQLcZ1Bw=;
        b=NDZjug65hbj44tejDFZHUCIGZ+N2Ujru2RqY+cmyeQS5M1X4JKnsjCHCny6EAOLOEU
         QXI5DYoYEClMhgXu4J6Tvinzqn2UIYLKiLiePW/Dk2IYLeEEjiC91GdqKksDsr5YTdvU
         fkxce+4n4Fe1De93jE1OWMIiRnuL6/N1FlGnEPEDdYe1+9Kicsj02c36kJo5pCjIGeTC
         zPpE5Pnba+sJSw6yicCqxJqIlVwP7aqu+g9egzDS2dNbosS60t+hJJQr6s07v2Mm7RMt
         CkcXrngw/hbNNsPlgHkKDZNohJnuRRWQkEj5XwWVnFw/ZEjdjS60/Ey48dEtld0/aOQq
         /szQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Xe/cl6rRtOkB7jxwy08Y/J8Ly/46MEA5YF+gQLcZ1Bw=;
        b=Ktsd67QcICtgz1R4s5l90/9cy6RoJfJPTGkb9dPwvHasgAWI5D522/REKEpCQ87+nF
         7gJRhpJwwQ8xyifj6mbaRvowqxWHWKMq06Hq3gSCyD0wb7fTjKgfCZqeblLTg/JslHk0
         vwx6o6RdmQ3YB9qsWCSbWaBo5/SRD3xkrqCm40s3uxhhvrMQA8SqBU0zl/fSpWARq0RG
         NmuTwIZ78Rdsuft1crk01z9DCgkolWCdZrLIZ3BhEicfqxih8o27O6GNLyYVCcVR9lLc
         ORvh37FxCvwbgU469jbqjSFaVJr6nlZWA4O9+orLgZLZMc7bA65WE1OLbyppsHXs6baG
         y0tA==
X-Gm-Message-State: AMke39k/tLi/jH8lG1Sz3aVJxelqHlvS7u6Y0ti+9x1s8tn0tZUTe92COJdTkvuuVgke5g==
X-Received: by 10.84.254.1 with SMTP id b1mr26147909plm.76.1488224004896;
        Mon, 27 Feb 2017 11:33:24 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id v15sm32111717pfk.99.2017.02.27.11.33.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 11:33:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t6300: avoid creating refs/heads/HEAD
References: <20170227092931.7iquwaxomeuuusi2@sigill.intra.peff.net>
Date:   Mon, 27 Feb 2017 11:33:23 -0800
In-Reply-To: <20170227092931.7iquwaxomeuuusi2@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 27 Feb 2017 04:29:31 -0500")
Message-ID: <xmqqzih7whrw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This comes originally from Junio's 84679d470. I cannot see how naming
> the new branch HEAD would make any difference to the test, but perhaps I
> am missing something.

Nah, I think it was just a random string that came to mind and the
topic being "ah we blindly dereference something when showing %(HEAD)"
it was plausible I thought of "H E A D" as that random string before
I used my usual other random strings like frotz ;-)

> I noticed this while digging on a nearby issue around "git branch -m @".
> This does happen to be the only test that checks that we can make a
> branch called refs/heads/HEAD, and I found it because it triggers if you
> try to disallow "git branch -m HEAD". :)

About that "nearby" one, does it even make sense to do the interpret
thing on the <new> name?  I can understand "please rename the branch
I was previously on to this new name" wanting to say @{-1} when the
user does not recall the exact spelling of a long name, but I do not
quite see how "to this new name" part benefits by the "interpret
branch name" magic in the first place.

> If we care about that, though, I think we should make an explicit test
> for "git branch HEAD". But I'm not sure we _do_ care about that. Making
> a branch called HEAD is moderately insane, and I don't think it would be
> unreasonable for us to outlaw it at some point.

Yeah, at that point we would have "test_must_fail git branch HEAD".

>  t/t6300-for-each-ref.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index aea1dfc71..a468041c5 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -558,7 +558,7 @@ test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
>  	test_when_finished "git checkout master" &&
>  	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
>  	sed -e "s/^\* /  /" actual >expect &&
> -	git checkout --orphan HEAD &&
> +	git checkout --orphan orphaned-branch &&
>  	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
>  	test_cmp expect actual
>  '
