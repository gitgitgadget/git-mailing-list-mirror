Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611061F453
	for <e@80x24.org>; Tue, 16 Oct 2018 06:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeJPNsu (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 09:48:50 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:39218 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJPNsu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 09:48:50 -0400
Received: by mail-wr1-f49.google.com with SMTP id 61-v6so23902592wrb.6
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 23:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YCaS5vQjRJiHgUueSJgvrupPDtgQmWEuE+lm7ZOvQEQ=;
        b=D6hI8L+XPMEUbOreCy7N1sVGGS8On62oIUPmwmrJCNCvGuaNyvmklIICt9IiKhRStV
         /nP7dTvQfkgk4KlxTuIU9gU7mQoQEsnJfpt3BGr1jMBxk4DymDRA8J3h1tgZn5yBTut8
         V1KQ+c9j1VLY6TDX+7hX+MQKYrxs15m3BKCCFLR4Si4/Jo6JwJHEtAm1o0m7MFjfo6qQ
         /M9W5XzMg0MYKa8YSoZZXt4gobFbhx8pIt9KmRCgkPbrnTfKgCzeC4MIfIQ3RsS9z9pP
         sQAC9PwWoxeWIwJmKiZJcsewg2Tk2AYA0xfgFxPHpuqJ98bmxmOBHSGF/Iy2xayaSrkU
         oTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YCaS5vQjRJiHgUueSJgvrupPDtgQmWEuE+lm7ZOvQEQ=;
        b=esp/TvyPa2Uytr5E88HvGTpVaFTDjoPZ0NdfG2YdJX3p7djmeMzIQxELW/TuHxPs/6
         rysADr7Cq6Ab3LWWuUYUkiNyXO+p0GQ2vhv7zTTjVw8xhDKgYzqKqDfpP6UWx66/JxcW
         VkSEM3x2ipUjToYBc+ZzfIkTeYoMTdWWznKm1Fb/aj1P/Lx0BOfmqyOAJBBt30R2IP5V
         q95pyV/Gfp15dF3Nc/AttiauzPqaN52OFFyev3Vheq3vHo+5LDHAaMsiff+5UhoafYYd
         TNVqJl5dzpD/52hF0SeCSAsQtYjvQ+zltTj5fydRrop3JS6YnjUpZSwO45FTWjwQyVWv
         nsgA==
X-Gm-Message-State: ABuFfoiFwWcr6vw7NJ9UIbK4WYYy+xLPYH9NwwJFt7UWd7jfgCBIO+h3
        En+1r4Rn4ZDfBuiPspZAPyc=
X-Google-Smtp-Source: ACcGV61SovK7kByvqWMCNzZpIPZYklL+drf70A7Ch30OTDMedn58TZYjNJgco3S9qZFhG/ZjgGQjoA==
X-Received: by 2002:adf:a481:: with SMTP id g1-v6mr18440214wrb.167.1539669600990;
        Mon, 15 Oct 2018 23:00:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e14-v6sm11477957wrt.76.2018.10.15.23.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 23:00:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] branch: introduce --show-current display option
References: <xmqqva68dqip.fsf@gitster-ct.c.googlers.com>
        <20181012133321.20580-1-daniels@umanovskis.se>
Date:   Tue, 16 Oct 2018 14:59:59 +0900
In-Reply-To: <20181012133321.20580-1-daniels@umanovskis.se> (Daniels
        Umanovskis's message of "Fri, 12 Oct 2018 15:33:21 +0200")
Message-ID: <xmqqk1mizb1c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniels Umanovskis <daniels@umanovskis.se> writes:

> +test_expect_success 'git branch `--show-current` works properly with worktrees' '
> +	cat >expect <<-\EOF &&
> +	branch-one
> +	branch-two
> +	EOF
> +	git checkout branch-one &&
> +	git worktree add worktree branch-two &&
> +	(
> +		git branch --show-current &&
> +		cd worktree &&
> +		git branch --show-current

This is not wrong per-se, but

		git branch --show-current &&
		git -C worktree branch --show-current

would be shorter.

> +	) >actual &&
> +	test_cmp expect actual
> +'
