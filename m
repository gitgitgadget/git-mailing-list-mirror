Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CABBB1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 21:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeIABRL (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 21:17:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39458 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIABRL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 21:17:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id o37-v6so12352962wrf.6
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=JqIUSNrcVpHeJFrk8Ut9hNhwkjSTZG74H3BQwzFijs4=;
        b=jjenHZu/5Ge9+dXzrTQndoS8khYxEY24n9y2+Q4q3yKWR9YFC8/jXiHejyTuEJ9spn
         HZ0g8bJNAuic0r9ue32gtKJOL6s1d6CX1l7FXQcox4IQmkQ7jL7cgkqgfWPnU/dX7glk
         d66mHvvH5tH6UkA89vGGF99lAJZXuN5AyLN0T2NxMfc5bSdMDRv0FkWOmChbfHNy/+M6
         D7avz/KfLcMxkOZEXs3eDpHQ0cHvkmcDPvzUPwkKLouXZZgyd5af0CviLJumysoQEUqM
         Gc/9oGymwPBxgG7RnzSroXIJv6QswycuueO3ViIb2q0AM8PL5Ec9BJflDAFuz7DlMPag
         Xh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=JqIUSNrcVpHeJFrk8Ut9hNhwkjSTZG74H3BQwzFijs4=;
        b=LEVef4c1i/sBnsWLts5xW3RHQPC+iJnePyYVtgvn6NfrAqQyj1MKc+kV7P1HnNOJlo
         TVjyxjLe9sHrxY2BNpkscZERRZlgzWd3K9ItnCDF2UCNNVoeE2KM0KQwQbsxOpMoCVoF
         kp+uc8Kc7Yr9DH+K83YeOO7PkKC+sGo65FJxuTNzFLalXt9MPf99onKqJ6seUnlZZLii
         uKJT9Q0feDsj8LT7Vrj1NLMFLtUVOZSFazKD3SQ8HhFOMxhCSUtnjittOF59qyeKOkli
         J9Hz2wzOyCdemuarteuZ9/4T3GUMM5agzH6LSR33lQCAn/3m3itkTunu21RhD+7y9yZ1
         TEvg==
X-Gm-Message-State: APzg51BpqK97DhF3STB1D4PhBHZWDmzmo4yn3LaWYk0On5BQ9yxRNP21
        0jKyBfNXs9mzeW808KmxxYk=
X-Google-Smtp-Source: ANB0VdbsG9Sh+NIOMu9oqZaDGmYpn64hhHEMaZkZYc7ca1/prvw8YmJ64PPA8ea41vPvIKSzztApUQ==
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr2058782wrd.67.1535749674023;
        Fri, 31 Aug 2018 14:07:54 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m68-v6sm10089939wmb.10.2018.08.31.14.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 14:07:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v5 2/9] push tests: make use of unused $1 in test description
References: <20180830201244.25759-1-avarab@gmail.com>
        <20180831201004.12087-3-avarab@gmail.com>
Date:   Fri, 31 Aug 2018 14:07:52 -0700
Message-ID: <xmqqftyu1byv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Fix up a logic error in 380efb65df ("push tests: assert re-pushing
> annotated tags", 2018-07-31), where the $tag_type_description variable
> was assigned to but never used, unlike in the subsequently added
> companion test for fetches in 2d216a7ef6 ("fetch tests: add a test for
> clobbering tag behavior", 2018-04-29).
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t5516-fetch-push.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 539c25aada..62d5059f92 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -969,7 +969,7 @@ test_force_push_tag () {
>  	tag_type_description=$1
>  	tag_args=$2
>  
> -	test_expect_success 'force pushing required to update lightweight tag' "
> +	test_expect_success 'force pushing required to update $tag_type_description' "

Of course, $1 needs to be inside "dq-pair" for $tag_type_description
to be substituted ;-)  So I'll tweak it while queuing.

All the other ones in this series looked sensible to me.  Will
replace.

Thanks.

>  		mk_test testrepo heads/master &&
>  		mk_child testrepo child1 &&
>  		mk_child testrepo child2 &&
