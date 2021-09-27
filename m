Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35EDC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 17:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DBE36113A
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 17:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhI0RtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 13:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbhI0RtB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 13:49:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56249C094278
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 10:38:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q17-20020a25b591000000b005a07d27bbdaso16789702ybj.3
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZZIiTHjQWlsScjtX9FmUus/PzJePFMWNreQmyhysFbg=;
        b=HHObGrRGEYJrIjl4m+XqkdAki6WNm6IViGBEJq1Ij06JxSgbHT22xHu9yjFD4DgQJP
         S8ks8vE1JO8gBldGMOpSVBhpDfI+KqHekst2u3S2nX98x3ciZx0vJyAMgeNsnHUIZub8
         l3b9Wt9eK+GYHgYtWjAcaKLcky2b8VGOP8FFpO4ojieQ6Xz+zuydysUZ9wsxhb8hdO9P
         ZSCHyjwbpAKPzEyCpw7Mxo1JHOOiTqPYq7TIXpLM+RpD971pdQmykkXwTrIEQ3QR5Bz6
         sm5nSdViwYLJR4UVzhqflKg9MB4mF6TEIdxT/pz6JoY30C7clYd/4/8mWeUTeInU0Gf1
         4Myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZZIiTHjQWlsScjtX9FmUus/PzJePFMWNreQmyhysFbg=;
        b=u+3P44UX+M+A4mE1baN/+u9PCVGdCA7AXJX98jSwjwcH930aZlracqLu5Rxa6wHqmR
         NfxR+loj9109jMK7TCAla02t3ofEAA5UqbfutTebDjO0/gQqmMOTK/d+6x/nrX9L/SZO
         ADAT3agdvrfxayO8ahumCmE18d4M9b3EXGSJvrZ8HEghGIs3Lbmi1+xpQSypIKxTGbvg
         ZoYf6LX+9bFpYZHHjqMfCIL+ck4R5KDsJo2vJqJ7s9gFOWsNiZ0ZDBJaXiljI7ul3tMF
         lHk0fWJVhp6YzjpP0ag9RPU58PTLeYBQrhczwtOV6JzzugJQyzlmaXvPx15NTjqc94ma
         SAQQ==
X-Gm-Message-State: AOAM532odE3HrxrTFs1YLdHEmAWB8w0RmPDccw8GXWUmQgOts/DrE4G1
        hamACO9BYpyBzjAVRasEAwnQMUSg18E/Su5qo7Gl
X-Google-Smtp-Source: ABdhPJyUcfIbTIBIcnUJYjSiuaG605SWuCYh+lRQQfXAb88CDZKpPeGF3iNtToyNO66k97RBL4aTyqYY90xMrkSRcsgz
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:77c7:: with SMTP id
 s190mr1163606ybc.531.1632764301914; Mon, 27 Sep 2021 10:38:21 -0700 (PDT)
Date:   Mon, 27 Sep 2021 10:38:18 -0700
In-Reply-To: <YU4Zse+dAeDg8RqV@coredump.intra.peff.net>
Message-Id: <20210927173818.528679-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YU4Zse+dAeDg8RqV@coredump.intra.peff.net>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: Re: [PATCH 01/16] t7900: clean up some more broken refs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -277,7 +277,7 @@ test_expect_success 'incremental-repack task' '
>  
>  	# Delete refs that have not been repacked in these packs.
>  	git for-each-ref --format="delete %(refname)" \
> -		refs/prefetch refs/tags >refs &&
> +		refs/prefetch refs/tags refs/remotes >refs &&
>  	git update-ref --stdin <refs &&
>  
>  	# Replace the object directory with this pack layout.
> @@ -286,6 +286,10 @@ test_expect_success 'incremental-repack task' '
>  	ls $packDir/*.pack >packs-before &&
>  	test_line_count = 3 packs-before &&
>  
> +	# make sure we do not have any broken refs that were
> +	# missed in the deletion above
> +	git for-each-ref &&

For what it's worth, I verified that a fatal error is indeed caused in
"git for-each-ref" if refs/remotes was not deleted. This patch looks
good.
