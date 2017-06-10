Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 293371F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 04:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbdFJE3V (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 00:29:21 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35313 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbdFJE3U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 00:29:20 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so9315390pgc.2
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 21:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q7FWLpQl3fASSf9x3UHJvsGot8lKSZx6cDBzk/9m+OM=;
        b=DxUFT1eB+ylchb8wm++8LTuXhARqcZv5anD/3z4oTRx4spFwUQre+v+/A6mqHN1gzg
         AVdLVDCHqNuGL7GMRX99mJsm1tXnYsd/LCUYi15GjsJCYmwShes9UtG80tLVacqF04X/
         kSr3rS3l4lVo0TqN1PWzX84IHv8iZRydjyqr1fcSfcKKKYXqQTB5xTGOw2FD0Sp4qo3C
         L2rc8RMjmc74B8TdxExVdQ4yrBv3dViYL9suN3Mekf4k+v2J/JOPxIgA6tqwwDaFN1z2
         mVIRI2e15NzBteTPvG35SxvnpVdotiIbvTK35n107+RDIsQGLUv1eYh35x/lyn7SPPu0
         Rn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=q7FWLpQl3fASSf9x3UHJvsGot8lKSZx6cDBzk/9m+OM=;
        b=XyHFMmPNlqf4IpHWPMfEwN394E9wKvARum5+n5F0e1lGr07O3v3hysL+4ry9XqNshj
         Q8OFu2+bWEPACCQIz6J3gUaOCf8Stz4u25P7oF75fk/qgMgROB1pPFmS3BwSKwKhs/Hr
         3StwFzrZlgcxBPdvlrYsZobSja0tsbVqkSvz8yEGnXOg+b8NHOXrUSCc8XtwRUQ+QTBB
         6zyEsgOHhDG7vClIiN4RO8TPblKmmeJpLxj22tzEc1XfN0+OCLXdzqJbx9GMXGO/hzDU
         ONlsW/LKffskGcEwndB5oc+bHKzck2VkHp6hVyv/78yUI6V0bP0W7rHiGID5FerLjfmI
         q8Vw==
X-Gm-Message-State: AODbwcBs9o/VUhFFJfXonY4jJl3zZyI6HHo6Wdqtau3DYXMuqXaYutUf
        iw0hizUS4oYaHw==
X-Received: by 10.84.213.129 with SMTP id g1mr41821934pli.202.1497068959862;
        Fri, 09 Jun 2017 21:29:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d192:93c8:4f75:5879])
        by smtp.gmail.com with ESMTPSA id p76sm5553784pfa.53.2017.06.09.21.29.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 21:29:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 5/8] t1308: relax the test verifying that empty alias values are disallowed
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
        <b9e212d508e9103037da2070cc0aaed530ea7473.1496951503.git.johannes.schindelin@gmx.de>
Date:   Sat, 10 Jun 2017 13:29:18 +0900
In-Reply-To: <b9e212d508e9103037da2070cc0aaed530ea7473.1496951503.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 8 Jun 2017 21:53:44 +0200
        (CEST)")
Message-ID: <xmqq37b84g9t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We are about to change the way aliases are expanded, to use the early
> config machinery.
>
> This machinery reports errors in a slightly different manner than the
> cached config machinery.
>
> Let's not get hung up by the precise wording of the message mentioning
> the lin number. It is really sufficient to verify that all the relevant
> information is given to the user.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t1308-config-set.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index ff50960ccae..69a0aa56d6d 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -215,7 +215,9 @@ test_expect_success 'check line errors for malformed values' '
>  		br
>  	EOF
>  	test_expect_code 128 git br 2>result &&
> -	test_i18ngrep "fatal: .*alias\.br.*\.git/config.*line 2" result
> +	test_i18ngrep "missing value for .alias\.br" result &&
> +	test_i18ngrep "fatal: .*\.git/config" result &&
> +	test_i18ngrep "fatal: .*line 2" result

Just judging from the looks of these, it appears that the updated
messages are more descriptive than the original.  Am I mistaken?

If so I think the log message undersells the changes made by the
series by sounding as if you are saying "we are too lazy to bother
giving the same message, so here is a workaround".

In any case, s/lin number/line number/ is needed ;-)
