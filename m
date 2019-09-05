Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 977591F461
	for <e@80x24.org>; Thu,  5 Sep 2019 18:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbfIESwp (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 14:52:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39222 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731865AbfIESwp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 14:52:45 -0400
Received: by mail-io1-f67.google.com with SMTP id d25so7135220iob.6
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5fPw1lr8Yc+PkLiBwcpTTHQmdBj1e80Mknc/pPy9ahM=;
        b=htM14bwjK28kWtu4IBxAERZMZdYkEmuo5+EiaEluEC5W+QDnZB2GrEIH2Z9doIGRsS
         +/uUIaYil0MRRPI3miYYoO+rTIr+9sXE5oRmfyJybyUXNDP98tIo7kQ0w773g/rPILlJ
         aLI/uiRMnIMsvIj2pmzSitKnWvYolWFEn2IiRXVxxMYoij+qDBvRV9jMadjWyTt+iNJ9
         D0zYJ7jAFoT4bSiuejVV3Rw0vKr4SETGy4rJsVPvKY4H0UfAcuSFCzLi7VLNXs1cdtex
         OLTwlqtijcoN3wUP+2cMO6HGrVQQ56kIAaogPleq8FxbaUy47X5Q+lgSh8pMo4eeiW6g
         M8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5fPw1lr8Yc+PkLiBwcpTTHQmdBj1e80Mknc/pPy9ahM=;
        b=BpCkxXcnHsEXr8llGRwjrC/Fnd87WoQeMtEGClY+TSHDNp3wTiGNfSUprlAadzmUOl
         PQoqaqfqy0RkSWiyFJGbIsD9DP/PO7DKHfL29UqfQMvHaC9zImLb++hKuFgF86YQ8qB6
         /g8WHdb+iozNkANhZMjU5uJQI6hjD2sq5Y+6/a9IVSnFUTvgiyilujTzzm2rycv74uco
         3i+q9LBqw9hN53f9d63LyDL1wblpcgqdj2IrQwa2OQJ55mVYgFt16ytv7v59NQGudWkg
         PQ3Net07UXsCi2FPsaopqZOtzqpC+X1lLoYe589XUWpOD+2eMj3s2eyj6RcT/lFH7SmE
         kMIw==
X-Gm-Message-State: APjAAAUw4KHlHnkugPt7Z76C7Hq5+Po4JDmneYRXQWdEsiWepApmZuKK
        FoSASVGfJbENQ67EmoZC49Zr0A==
X-Google-Smtp-Source: APXvYqwc0C3lhOq2sS6QpC6nYJX0DV88EcbxBMbgTp8+P/02KFIb7r7VppUg5cNLyqTSpbdJkEyqEQ==
X-Received: by 2002:a5d:97cf:: with SMTP id k15mr5729049ios.151.1567709564681;
        Thu, 05 Sep 2019 11:52:44 -0700 (PDT)
Received: from localhost ([2601:401:c500:7dd8:47b:fba1:dd5f:7748])
        by smtp.gmail.com with ESMTPSA id z20sm3200018iof.38.2019.09.05.11.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 11:52:44 -0700 (PDT)
Date:   Thu, 5 Sep 2019 14:52:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] t: use LF variable defined in the test harness
Message-ID: <20190905185243.GA50575@syl.local>
References: <xmqqwoeprsp1.fsf@gitster-ct.c.googlers.com>
 <20190904002930.GA76383@syl.lan>
 <xmqq7e6mr4iy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7e6mr4iy.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 11:17:57AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >   - t/t3005: this script calls the variable '$new_line', but could be
> >     renamed to LF and then removed in a second patch
>
> It is worse than that, isn't it?
>
> If it used $new_line, then it would probably have been a good idea
> to somehow make a separate patch related to this one and make a
> series about "use $LF from test-lib", but ever since its beginning
> at 0f64bfa9 ("ls-files: fix pathspec display on error", 2011-08-01),
> $new_line is assigned once but never used in the script.

Ah, thanks for catching it ;-). I think the patch below the scissors is
totally right; there's obviously no need for a preparatory patch here
other than the one you provided.

> Somebody may want to go clean-up the use of various $sq and $SQ
> locally defined by giving a unified $SQ in test-lib.sh, by the way.
>
> -- >8 --
> Subject: t3005: remove unused variable
>
> Since the beginning of the script, $new_line variable was never used.
> Remove it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t3005-ls-files-relative.sh | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
> index 209b4c7cd8..583e467683 100755
> --- a/t/t3005-ls-files-relative.sh
> +++ b/t/t3005-ls-files-relative.sh
> @@ -7,8 +7,6 @@ This test runs git ls-files with various relative path arguments.
>
>  . ./test-lib.sh
>
> -new_line='
> -'
>  sq=\'
>
>  test_expect_success 'prepare' '

Thanks,
Taylor
