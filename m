Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC8ED1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 13:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfFYN04 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:26:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47091 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfFYN04 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:26:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so17833202wrw.13
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PP5CjdXBmcHEEtCX+W/4tCQfmimozy5XJoAVUyn4c0I=;
        b=OHV0KbLq0psDlqEz1qkuKGX2aJfXovACfwQeU4FlDOtFn050ld6NzsDS9vCIVTQ7j3
         6r1gz0W6BNVlbt8Z5/HOAAlTwcLV/kt7G82QYG3XCo0Y2omAm3pa1x/37Fsp1NsjomPz
         GorpxhOkoKPt6iQwElkSbHkJoDTNYMN13EhTrXinGS4r8jSyDyG0HjGSijbKzhbpgckn
         tH10EVJa1jbUs6kaChcKjJfGAomlPwjVsJFEcspcgbCtzos7pgHT4weLyqEACyJUx9vG
         T18XtSnrSWQLJ7ipKMGSlmZIpv/DsdCuqOT+vu7Kct7dIC5jkwXikxsnNlZqDl1AmQji
         GhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PP5CjdXBmcHEEtCX+W/4tCQfmimozy5XJoAVUyn4c0I=;
        b=H64HFBiqxcEZuBiXXJiYCPfRpzRNVb1Bo2iwYbVBVvMcXDYsaVvcjcma3WA4U4oe/K
         taYtTnDTYCzq7+g5wIJKWTJMK3VL/pUKuHv4INXiIl3khmmK1S/j+RK77V6AvpkdcKHC
         JtpUto2GmuQWUmyhgtwYY3VkoOt3std+NBXCB6zxB4oUowWFhXInS+tdBjXpuvN+xVBp
         w5Nhp0+bE7mZ1r/h1cCAVuyufnz5JOGlE6y2HUwmou/bRJin658mOXzLsWVoTAAhz+Gf
         NJ9cqooCxkm8AKUs9d8gdfmCVEEhhnXrYOaA3Gpx7w2ZpvhLKnzw6rkKdweJyvpX2OQH
         c7rg==
X-Gm-Message-State: APjAAAWCiATDA6qb3Tej0TDAGACchTofknFkoMCptoGixJZ/sIBVX2nr
        BeFYDouT6HZ0lD5htHGZw4w=
X-Google-Smtp-Source: APXvYqwaJl/hN7X3mP+XxKjEfCcoXk1tN3fGGO38gMjMbSgGvWcHutwXoYj8/PkUGRJzGp9/cv/SSg==
X-Received: by 2002:adf:9003:: with SMTP id h3mr34925355wrh.172.1561469214913;
        Tue, 25 Jun 2019 06:26:54 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id t15sm12065596wrx.84.2019.06.25.06.26.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 06:26:54 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] Wip/quieter sequencer status parsing
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.275.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <21a27493-220d-3c4c-63c0-7ffe60e19c49@gmail.com>
Date:   Tue, 25 Jun 2019 14:26:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <pull.275.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please ignore the 'Wip' in the title, I forget to edit it on gitgitgadget

Best Wishes

Phillip

On 25/06/2019 11:11, Phillip Wood via GitGitGadget wrote:
> If we cannot parse the oid in the sequencer todo file do not show an error
> when running git status but instead report that a cherry-pick or revert is
> in progress. This addresses a confusing error message reported in
> https://public-inbox.org/git/3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com/
> 
> These patches are based on maint
> 
> Phillip Wood (3):
>    sequencer: always allow tab after command name
>    sequencer: factor out todo command name parsing
>    status: do not report errors in sequencer/todo
> 
>   sequencer.c            | 43 +++++++++++++++++++++---------------------
>   t/t7512-status-help.sh | 16 ++++++++++++++++
>   2 files changed, 37 insertions(+), 22 deletions(-)
> 
> 
> base-commit: b697d92f56511e804b8ba20ccbe7bdc85dc66810
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-275%2Fphillipwood%2Fwip%2Fquieter%C2%A0sequencer%C2%A0status%C2%A0parsing-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-275/phillipwood/wip/quieter sequencer status parsing-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/275
> 
