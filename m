Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41C6F20D12
	for <e@80x24.org>; Thu,  1 Jun 2017 02:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbdFACAK (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 22:00:10 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33008 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFACAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 22:00:09 -0400
Received: by mail-pf0-f195.google.com with SMTP id f27so5521092pfe.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 19:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zrRwg+S3PwcXyT4NXgAunvfrH//VGoyisz+EEyK67H4=;
        b=biBEUeE/1cd4xuI1MYW4+YpWzggOJbbcnXs/ugevnnU26E3CF9fAmA70qFi84Piz9O
         Nh/NNoQL48bG/iNXp/tewuZYuZrd0mC91FssmQ/x4ta0EzuffC9b735/vm4PUqqACXtk
         C3TfJu/DnZk64VzfHV9lTCRci5u8P0YjV0I/jGh/wCYOCO0BjnMy+3x5ZOCllRA/Fuus
         qf74Hnr3hwGVSRgO6/QJAuz8rlEoRsvrwLbNKxGavfrqMQc0c36uaFzrwjfDvN7jes6x
         ahzfafNc8Mz3lqVSmTB75/sKdXLOYjnNT+vJrEnO6WR7FgJN68Q23ZZGGNGeCv1p8G7f
         CL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zrRwg+S3PwcXyT4NXgAunvfrH//VGoyisz+EEyK67H4=;
        b=Cm0Nr02WM9VF01m4DzkpEtw/w2KfrFT4MI8Z2z5E3gAhvW8oe7t4iE4XcvPFvtq/KA
         /SXmeNs02nbuJK9a0ul/MqFKkaTvl4CDo5G16yhUgj/s1wAR38c2I7YLWaaG49BiNawl
         Ll7po7JxreG4oCw3oifmsgkunc1dLNmsz4uKAIhzfQpyZQ27iWvlaWerq6THvPsRG2Yc
         Xe/q6HtlDGIOQ2UDQaRB4leubrJ5E4mN6Kc31o+dRKhIgjl7uLVK55seE9sv4XvNXhKZ
         fxTNm+XFmC3Fia4b5TnTdhayQqkoP8G9OIhvCVHDH/hLd7kYvMQ6oVnR4dHRmCqGZM92
         34KA==
X-Gm-Message-State: AODbwcD9ctHR9M3y+3Js28Wd/cq0qMgVRXUwTn3gnG4xwgZcmxvN+B4U
        89RSCC66fvKvjA==
X-Received: by 10.98.145.26 with SMTP id l26mr33867168pfe.36.1496282407760;
        Wed, 31 May 2017 19:00:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id w10sm34935119pge.48.2017.05.31.19.00.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 19:00:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/3] rebase -i: Add test for reflog message
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170531104213.16944-2-phillip.wood@talktalk.net>
Date:   Thu, 01 Jun 2017 11:00:06 +0900
In-Reply-To: <20170531104213.16944-2-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Wed, 31 May 2017 11:42:11 +0100")
Message-ID: <xmqq37bk8o2h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Check that the reflog message written to the branch reflog when the
> rebase is completed is correct. This checks for regressions for the
> fix in commit
> 4ab867b8fc rebase -i: fix reflog message
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

Good idea.  Thanks.

>  t/t3404-rebase-interactive.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 5bd0275930b715c25507fc9744c8946e7f73900b..37821d245433f757fa13f0a3e27da0312bebb7db 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -169,6 +169,13 @@ test_expect_success 'reflog for the branch shows state before rebase' '
>  	test $(git rev-parse branch1@{1}) = $(git rev-parse original-branch1)
>  '
>  
> +test_expect_success 'reflog for the branch shows correct finish message' '
> +	printf "rebase -i (finish): refs/heads/branch1 onto %s\n" \
> +		"$(git rev-parse branch2)" >expected &&
> +	git log -g --pretty=%gs -1 refs/heads/branch1 >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'exchange two commits' '
>  	set_fake_editor &&
>  	FAKE_LINES="2 1" git rebase -i HEAD~2 &&
