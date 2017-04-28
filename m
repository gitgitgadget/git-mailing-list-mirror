Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74AAD207D6
	for <e@80x24.org>; Fri, 28 Apr 2017 03:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965722AbdD1DJc (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 23:09:32 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36146 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754183AbdD1DJa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 23:09:30 -0400
Received: by mail-pg0-f65.google.com with SMTP id v1so3177140pgv.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 20:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5/YswtORzlzghmDcTQn5KSzVE3tgHrlAvmzpkIY/yMY=;
        b=ftYhPnC6X71OtRBbDh2GmB4A1dfhDIkV5tl3z49ldrvHhWzwCGd6eqbRDUoQPkdDl8
         hJdZ0SY+EmYreuSRaZxXIDaI8qAg2e2v7ax+JOe1GVjaB5DiVq8+51P4yvgVeGfbgFhp
         vnV7XVt0bFMU1GXMGTpoDQRLgqmvMTXf7prZ8GQVWQ66db0GkHAIBt+zQLFCD/kHM87d
         miRYvDztyNe37hBTeMD3LQPU/MsAeNaTO7Y2mGJKoHQ75RTZqq1Aip/MLPB60REbxubz
         /bmUDNK5iebWC9/25hVGzNmpBLA+HCp2S0Ba6IB+6snNWL05PTX94tYkTXImdJlnbHvP
         B7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5/YswtORzlzghmDcTQn5KSzVE3tgHrlAvmzpkIY/yMY=;
        b=tGxwyBT47fY/iuLXG/LuvuBdbWs8Jd1BC7AaTaHAqErNYRb4j/S3NeLWE8ZzgV+ZlR
         ey2of4ScfQL8/wODYQGjlsKwdG218v45expiTJnLBAF0MCS/XL0TgrrWMgweMBIbJYzi
         gWRRczmbhFkBRzOaf35xYtHxbETiTpeiRMrLOiTWlrckpi+AOMdB43mrvFBPfLOwkXJG
         yBm2UtOuv3eUJqH3OAjC1uXygIidBUjuwVP70KCxnZu7LSROqMM1YxuL/6YQGIo8W17W
         dVRZD8OBbPayg3/sokmTwn8LNrLobT939nrtJ0iwExB6m+Ti19Lav6L11tfqBPCTRD97
         h8IQ==
X-Gm-Message-State: AN3rC/4zcxVvPlczORsUJ9KbcDlKF6pGBbawgktTFNa45LRK3XGxNqL+
        /7unuSq56zt0bw==
X-Received: by 10.84.211.65 with SMTP id b59mr11866016pli.17.1493348969716;
        Thu, 27 Apr 2017 20:09:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:51c2:e137:8e5a:b68b])
        by smtp.gmail.com with ESMTPSA id y123sm7300046pfg.52.2017.04.27.20.09.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Apr 2017 20:09:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] t7400: add BSLASHPSPEC prerequisite to 'add with \\ in path'
References: <5b8e0f3a-0b64-1384-d830-5b65a43e44c4@ramsayjones.plus.com>
Date:   Thu, 27 Apr 2017 20:09:28 -0700
In-Reply-To: <5b8e0f3a-0b64-1384-d830-5b65a43e44c4@ramsayjones.plus.com>
        (Ramsay Jones's message of "Fri, 28 Apr 2017 02:53:40 +0100")
Message-ID: <xmqqk265kz2v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Commit cf9e55f494 ("submodule: prevent backslash expantion in submodule
> names", 07-04-2017) added a test which creates a git repository with
> some backslash characters in the name. This test cannot work on windows,
> since the backslash is used as the directory separator. In order to
> suppress this test on cygwin, MinGW and Git for Windows, we add the
> BSLASHPSPEC prerequisite. (see also commits 6fd1106aa4 and c51c0da222).
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> I built v2.13.0-rc1 and ran the test-suite on cygwin this evening and
> had an additional failure, over and above the failures reported for
> v2.13.0-rc0, namely t7400.20. This patch elides that test for cygwin
> (and MinGW and GfW, so it would be good to hear success reports from
> both Johannes).
>
> Thanks!

Thanks.  Will queue and hopefully we can merge it to 'master' before
the next -rc.

>
> ATB,
> Ramsay Jones
>
>  t/t7400-submodule-basic.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index c2706fe47..0d83153f3 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -273,7 +273,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
>  	test_cmp empty untracked
>  '
>  
> -test_expect_success 'submodule add with \\ in path' '
> +test_expect_success BSLASHPSPEC 'submodule add with \\ in path' '
>  	test_when_finished "rm -rf parent sub\\with\\backslash" &&
>  
>  	# Initialize a repo with a backslash in its name
