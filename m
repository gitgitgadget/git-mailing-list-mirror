Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03E681F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 16:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755164AbdFLQLZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 12:11:25 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32997 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754569AbdFLQLW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 12:11:22 -0400
Received: by mail-pf0-f193.google.com with SMTP id w12so6850614pfk.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W4xva//hoPIkybxKTN4OHp5BkOD1ywa9D6GbzrLsEKI=;
        b=jSaLCgmUU9hIYwYuebVGHA4C5/skc/pIgPtDVI1679cJHzMi0oHh8cV+iqX7+rSBRb
         2T0uQUO6m9oVrxejuFnttHPiohuyzGJDNXUIpmycz1X2pEyiCEjH0x4Jv0OTJhenLOY2
         9a9TOTlxNltA9PbXv2aX5ATeYfBKeEJX4muPjJMqTcz8SBUCF7X4tHzq4phsb7SXNBGS
         PnKh0gcRaCSd6vaJAorlEoqyTVoET8vBbu76/wgPNgeTezC8vf/D1wCWBtWv/zkjkkZn
         wH6afIbI/ZBwC0zTs0UgQV6ZrXdmp7ed2mBhUX3RZnSHZc3NeCGdwR2mG7OgzOqbVEft
         6vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W4xva//hoPIkybxKTN4OHp5BkOD1ywa9D6GbzrLsEKI=;
        b=pasylfNl0rUmxyqgW9cyv8sJQJjJfJqRDHQcP8SJy3LsUPHxJSN7/qsVNhLfoPDXNh
         apLU2qUffLKxK5fWpYNMKKiRcno2GBMZGytMa8sbJd13l+WDSOlJCbLGPnUleHHaeBLV
         3SHJ/EbkYI2T/PEk2Y2O/kzz3oxMfCkWxAEt6HIVD/V3iJ/R7+aCgf6q6hdXBCeLIWGS
         dJOx79+Xi4fpFJRbyokuOI/VbSO3YIZOwJ/35dhe3DYg7DPBO91usI5woWXi8jI6Leth
         5pai3aIpZP94xBTv8oDbe/yNONe52uBW/53NbihEoADzlS3+NVykLzJLUFOHLCTlRUwp
         GAGg==
X-Gm-Message-State: AODbwcD5Q6WAMa9OcJCKP/7NeRMJM73L0oto3GnjdB7KW9br/R8eNUmn
        RNseiQmVCIfyAQ==
X-Received: by 10.84.216.24 with SMTP id m24mr56255450pli.281.1497283876522;
        Mon, 12 Jun 2017 09:11:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id o13sm11544489pfa.120.2017.06.12.09.11.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 09:11:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] send-email: Add tocmd option to suppress-cc
References: <6367777092d93a62cc83c444061dde853ba3369e.1495107179.git.viresh.kumar@linaro.org>
        <20170612043313.GE5297@vireshk-i7>
Date:   Mon, 12 Jun 2017 09:11:15 -0700
In-Reply-To: <20170612043313.GE5297@vireshk-i7> (Viresh Kumar's message of
        "Mon, 12 Jun 2017 10:03:13 +0530")
Message-ID: <xmqq8tkxp4nw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 18-05-17, 17:05, Viresh Kumar wrote:
>> This adds tocmd option to suppress-cc command which already supports
>> cccmd and others.
>> 
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  Documentation/git-send-email.txt | 1 +
>>  git-send-email.perl              | 8 ++++----
>>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> Ping !!

Pong?

I didn't get the impression that in the discussion that led to your
patch (or in any response to the patch) we established that it is a
good idea to change the behaviour of suppress-cc unconditionally
like this patch does.

