Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F6D1F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 21:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034660AbcIVVBW (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 17:01:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36764 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936347AbcIVVBV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 17:01:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id b184so16084424wma.3
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Dzuz1qX7IYY4Fyso2APIWV5psiD3Fj6SgJ52yNvWQ4=;
        b=pXxzQX8rM7mo407NpKR4Y2CCce+MfzYijlsk3Q/d0hTdvNN3q5fG2fQEVMen4qGTHh
         0L6F+lfv1ZwQmtouFg41hinv6AWhF9AMUUa/bAghgRJG+KLXZ2ElxM/ZDk/0oCFbkfeD
         lqUqJtVjMSvkTLK34KOP9aABNr+P0w3VXhv2ShmmlXAjzEv143EkGgrqSw5835L5O8/8
         RRtTNsr9I4UWHrEUwnqYcF0L3UF/jd+KCp6BPY80MVWVgNSHfjYApfnkb25y2OOWJKF7
         YeQMMBi3LVCFNxMlQ86Xwun4ayNlRcNASTwemYXziEAi523ehEKsD96Yo9YLbh8Il3uS
         n9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Dzuz1qX7IYY4Fyso2APIWV5psiD3Fj6SgJ52yNvWQ4=;
        b=VVd8UYDhmbNwVq2GLMx/xMscYZb2OCeSY25dQbJfIb/Ehj8jYY4wLnQrpo9sPsSlaF
         1Nul+nSewENu8G+Y7UFM7GqAEZDOkyAjJVDBCFcmtiXgHSuV+JziTbEoPgDLPWFQxCik
         z2r0M85721e0zvqXMvL1pc4S1w+tabfn7bC0iYhXkIsfocxAXnKncxclloPSdRKXo4hT
         jqhccEJ+PecpiPHh5Qpnx/fJqFLlVcKKj0KLTeaVe7AG9XR9uVOvkZfIM6R9MkJPCIH5
         cW/6jGOJdFmAH8vZDKJjJShitX9zakL1Ttfq6Q0W7sveUUjyS0Cw6OTaY5FSpFbqs5UG
         ZIPA==
X-Gm-Message-State: AE9vXwOSLq4TmKoBXQxZpoq7LsG4Xy0tD4Vg0gL+foA5huimMW8O36r0szeM8O6TPIWw2A==
X-Received: by 10.28.45.214 with SMTP id t205mr9403836wmt.107.1474578080287;
        Thu, 22 Sep 2016 14:01:20 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id au10sm3878314wjc.12.2016.09.22.14.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Sep 2016 14:01:19 -0700 (PDT)
Date:   Thu, 22 Sep 2016 22:01:41 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH tg/add-chmod+x-fix 2/2] t3700-add: protect one --chmod=+x
 test with POSIXPERM
Message-ID: <20160922210141.GH8254@hank>
References: <cee3c784-8f03-c524-2f67-d35cb3755a41@kdbg.org>
 <5effaf36-d017-3ff1-1de1-d9b303c04f23@kdbg.org>
 <20160920193444.GG8254@hank>
 <xmqqtwd986ml.fsf@gitster.mtv.corp.google.com>
 <xmqqa8f16kup.fsf@gitster.mtv.corp.google.com>
 <c3aefd9d-b794-21a1-619e-bce6a3c2cf47@kdbg.org>
 <xmqq60pp6jor.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq60pp6jor.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/21, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > But I came to a different conclusion as I said in a message that
> > crossed yours. I hope Thomas can pick up the baton again.

Sorry for not getting back earlier, my git time is quite limited
unfortunately.

> Yeah, our mails crossed, apparently, and I do agree with your
> reasoning.  How about this, then?

Thanks, both the reasoning and the patch below make sense to me.

> -- >8 -- 
> From: Johannes Sixt <j6t@kdbg.org>
> Date: Tue, 20 Sep 2016 08:18:25 +0200
> Subject: [PATCH] t3700-add: do not check working tree file mode without POSIXPERM
> 
> A recently introduced test checks the result of 'git status' after
> setting the executable bit on a file. This check does not yield the
> expected result when the filesystem does not support the executable
> bit.
> 
> What we care about is that a file added with "--chmod=+x" has
> executable bit in the index and that "--chmod=+x" (or any other
> options for that matter) does not muck with working tree files.
> The former is tested by other existing tests, so let's check the
> latter more explicitly and only under POSIXPERM prerequisite.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t3700-add.sh | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 16ab2da..924a266 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -361,13 +361,11 @@ test_expect_success 'git add --chmod=[+-]x changes index with already added file
>  	test_mode_in_index 100644 xfoo3
>  '
>  
> -test_expect_success 'file status is changed after git add --chmod=+x' '
> -	echo "AM foo4" >expected &&
> +test_expect_success POSIXPERM 'git add --chmod=[+-]x does not change the working tree' '
>  	echo foo >foo4 &&
>  	git add foo4 &&
>  	git add --chmod=+x foo4 &&
> -	git status -s foo4 >actual &&
> -	test_cmp expected actual
> +	! test -x foo4
>  '
>  
>  test_expect_success 'no file status change if no pathspec is given' '
> -- 
> 2.10.0-515-g9036219
> 

-- 
Thomas
