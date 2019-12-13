Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3016CC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 03:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6352253D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 03:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1P3lkF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbfLMDAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 22:00:48 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38391 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731496AbfLMDAs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 22:00:48 -0500
Received: by mail-ot1-f67.google.com with SMTP id h20so4483232otn.5
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 19:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ULxmJIeOQRwd2s9s69i8/3jE9NZHgtU6KAqwlfKM0P8=;
        b=F1P3lkF6QC4ZiKgrzVOBjHsGWgXUKlgk6CDipY2OfBP7xUWCcgqIrAF4rZP8zK5Mlu
         awipzDDtduWl6c/A+PIh8zM6IjltWDAjssn75yGMMICobgRrSnZiCIiIVxz7rGDABM0q
         1TO3S+pO9j73K3sMs/1sEVo6cYC2YFDLtTpPpnU7a7i/kxKn/6y2HIPdW3P/xH+o/kjg
         vxwiDeUQK4qpY01Ai3AKUMS5nx7hED56JoYWA1e2CqLjI1EDdR4licuruhvqEjzlRbV7
         dEijYTwUJ7NjBUVas5LeRZDWQ21Z3veVgSsGrZ8VqS32LdTcPYF3GDLsy3enks1+XDxs
         XSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ULxmJIeOQRwd2s9s69i8/3jE9NZHgtU6KAqwlfKM0P8=;
        b=or46WOqvVS5j0dYdr1vxi1oqGbEFWNZeulvDOuu31hjuKCnZtDbMEtcP5VAPHRm+/w
         SXKtDCLsXW3fPlms4+ntkfnfh1FpJSmVd7mbGdbTBMQikIl9ClgxN6gaBZXNAs53IBV1
         Dm/mUaErHNhgsKCy/Bsk5iHamZnOZcpOAx9nfsKFz6S5qWAIu1NyyOEnsvkvfHfNRQzd
         7+3AFLdryGMq0QRGvE+y16vZ/os1K/9Lp7MTS3nvZZEg50rP462CzhmQoXVMdjMTa9MU
         PQvRd8dgNcjE6o8jKQaPdmdsYZEl9dS8ggzgD2RdkpePeR4h3jC35G1nGP4Ep2H1orNa
         BnXw==
X-Gm-Message-State: APjAAAVNksNVC278UAX8jv89+EmwNEklB9ZzyoCg8YhCDrh71jDj5WXi
        bF8RD9ft0UCpk+oStHFkkeo=
X-Google-Smtp-Source: APXvYqy+7priZ7mjjeWdoJXE81HuhCBfzb/DbYdtqXT0qpN+M7n7LViAEg8HTcEMQZko42lkjk6n3Q==
X-Received: by 2002:a9d:6f0a:: with SMTP id n10mr12515184otq.54.1576206047609;
        Thu, 12 Dec 2019 19:00:47 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k6sm2833818otb.65.2019.12.12.19.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 19:00:46 -0800 (PST)
Subject: Re: [PATCH v3] MyFirstContribution: add avenues for getting help
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Kerry@google.com, Richard <richard.kerry@atos.net>
References: <20191213013128.6268-1-emilyshaffer@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f3037862-b8f7-d674-4b1e-7b9df3fa49cd@gmail.com>
Date:   Thu, 12 Dec 2019 22:00:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191213013128.6268-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/12/2019 8:31 PM, Emily Shaffer wrote:
> With https://public-inbox.org/git/20191114194708.GD60198@google.com/ we

We are trying to move to lore.kernel.org, I think.

> now have a mentoring mailing list, to which we should direct new
> contributors who have questions.
> 
> Since #git-devel's traffic is fairly low, it should be OK to direct some
> questions there too. Mention some of the conventions in case folks are
> unfamiliar with IRC.
> 
> Because the mentoring list and #git-devel are both a subset of Git
> contributors, finally list the main Git list and mention some of the
> posting conventions.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> Since v2:
> 
> - Removed a double slash in a URL
> - public-inbox -> lore.kernel.org

Ah, I see you mentioned it here and in the contents. Commit messages
are harder to keep straight, in my experience.

> +==== https://lore.kernel.org/git[git@vger.kernel.org]
