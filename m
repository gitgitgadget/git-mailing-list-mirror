Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30E201F6AC
	for <e@80x24.org>; Thu,  5 Jul 2018 15:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeGEPfP (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 11:35:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40578 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbeGEPfO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 11:35:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so11675347wma.5
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 08:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/cWVB14oJV+7QfnoEMTrZ1Jqp4pM84+Yhf2BPZmBUSg=;
        b=nDqgdYKIMndJ61j0vX/siDVVxRZHt9XKlb6/OwU0iL5pf/FzXIAMV6m/aJwBHmtvvg
         XopH1dspiPhONRonJA8BpVmHynbdixaOiOZL1SbqdGRNL/kueAjCzzvllPfSCJyke1zz
         ULxLEaUt693LnfmjVBEIqLmMGacK3jKp/UncJoeN+PfcqZJWvubYM/QGbkeCpUWMZFA0
         wBv1hluVrhYQIUtIOC84JEOLm4zHvBuSu83FOHe3yhWtFO+Vco92VYL1H2Jr9sXp9JJ8
         ZuDoqsFLd+iDMsdmF5tmSWgFFf2TV4HJ4J0B7avBrqq0fmJY4kGOCs0e/vbSftUayV7E
         lU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/cWVB14oJV+7QfnoEMTrZ1Jqp4pM84+Yhf2BPZmBUSg=;
        b=GyT+J3wW9OS5n77rMa7BqtI3tFLirZc3wNcY43de4OPfJAyZ4Xt54d7zFmuObmQgxX
         G9EpTHhDvGS/8JzGHtAlf1NTCQrkel/XAfKHRKhoaERiwAXDLtk/BuaAW8vO8pcQ4ZSH
         T3tJ4jXmnqqF4NydrCJe9S/sSNcWKcarn4s3hcBGHLai+pFjMM1Yhm4nkFShzEQNuthh
         NQRKy1Wqe2bx20E273GO/OF8sPwz3GLB7PRIpjn9MOwlWeQlxPEq52LMDyoLVat+pd+D
         MsIRYk8PdL9vw8kqH0Dx4qjN9Uornf/jCJMYi5/OttZHkCebjL/SZAkKt50dc0wjXuIM
         1Yjw==
X-Gm-Message-State: APt69E0foEBanRsmHLGB/yx665GQmrXFAL393GAunsH22/tXUuzNNKN+
        sftyy3Eq4ybGK0Bqw4X6JQE=
X-Google-Smtp-Source: AAOMgpeXGzAVn98r39kcWUxc8iG0knoPC39Ga3suGro9cqNcf69DMp0ekFTgXBKZTaJZ3uW+wardrg==
X-Received: by 2002:adf:87f1:: with SMTP id c46-v6mr4869204wrc.246.1530804913451;
        Thu, 05 Jul 2018 08:35:13 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.gmail.com with ESMTPSA id c18-v6sm8852926wrq.17.2018.07.05.08.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 08:35:12 -0700 (PDT)
Subject: Re: [GSoC][PATCH v2 1/7] sequencer: make two functions and an enum
 from sequencer.c public
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
References: <20180702105717.26386-1-alban.gruin@gmail.com>
 <20180702105717.26386-2-alban.gruin@gmail.com>
 <xmqqsh50oyu4.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <d9ee3afd-2464-0a7c-d55f-951b89777d27@gmail.com>
Date:   Thu, 5 Jul 2018 17:35:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqsh50oyu4.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 03/07/2018 à 22:20, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> -enum check_level {
>> -	CHECK_IGNORE = 0, CHECK_WARN, CHECK_ERROR
>> -};
>> -
>> -static enum check_level get_missing_commit_check_level(void)
>> +enum missing_commit_check_level get_missing_commit_check_level(void)
> 
> The new name definitely is better than "check_level" in the global
> context, but "missing_commit" is much less important thing to say
> than "this symbol is to be used when driving 'rebase' (or even
> 'rebase-i')", I think.  "enum rebase_i_drop_commit_check" with
> "get_rebase_i_drop_commit_check()" perhaps?
> 

I don’t really like those names, but the function and the enum should
eventually move to rebase-interactive.c and become static again, so we
could revert their names in due course.

Cheers,
Alban

