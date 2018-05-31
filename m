Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40B5D1F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeEaTZM (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:25:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33989 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754050AbeEaTZL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:25:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id q4-v6so3906195wmq.1
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IfQgu2dckqVQWygp17DuJXQ1bURaT8ZiqUyf46AaWAo=;
        b=I5N2JkjJrZ9z9VfxHMupXJXWBRKa/8kvaFxG9vVWaShYksr2uVhKiGm47V8WNuYJvl
         yFrcOjkoUg+vyoEWORDBXhQXuKwW95R1slTfTR6LonDg7fQ3XOjLO9ZSlinAfpKUU5sc
         EvKaQAqf33IICVw1j7sKP6VTBfsm69xx9CCES9I37l0lqFgyF/VynhGvBVSehyPDlShU
         B9TNoXXvtWefs9sX4ZO7r8IuSYiVJoZAGQWS+VCZy6lL93MH7/SAC2p6T8LnSLvFQwqJ
         lJrnHemTyAYnUqsf7GGQa0RQYC6l7T+6buC3XMSIiBHOMbvGZ1yXs8nFJDsrxgmDd3WV
         LLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IfQgu2dckqVQWygp17DuJXQ1bURaT8ZiqUyf46AaWAo=;
        b=lPH7wmuV9ZLcoTplXRTps/GCu8aqgbiyHliNPXOp7B3oyuYE7UVYiCunPGPce4ELVV
         sBATJ7AG5DXMXdWg3yVHWLD5U8i9ZFawc3ezND/pEtnVxc4Jb2VS3DieXwXOoitn9S4+
         IH6dy9u2tmv+WGFR+VlAaMD6qajRgKMibzGoj1AxOV/m17kg3eJ1QzY/YYEhnRGIC8mx
         ogzKzCT5H7TcjAOl0SnUo3583eJRpFygbZSAyfZsyHony72o4lUOeVuRTjzGYKTc6gNg
         Py3uAJOatJoZRsWWbyK9imL6J5DeVe/HdESCRruXzvYfOmgovBGoI3Q5co7+UDDBgSNH
         eQjw==
X-Gm-Message-State: ALKqPwcczJg36OpVuRLC/KCRVyTFTtV3801JXnGzFKFg3ByLExicjmsw
        VgokoLD6g7ZvzRwhhZ4QYmw=
X-Google-Smtp-Source: ADUXVKLM408DtTJOEVsLYCtzkkfggCfKLH5J8bn/oENMDnVcngfG2dUlfpokd3skNjwOKfTOHnnp6w==
X-Received: by 2002:a50:e1c1:: with SMTP id m1-v6mr9269205edl.198.1527794710436;
        Thu, 31 May 2018 12:25:10 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-184-117.w86-199.abo.wanadoo.fr. [86.199.39.117])
        by smtp.gmail.com with ESMTPSA id b1-v6sm1193976edq.82.2018.05.31.12.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 12:25:09 -0700 (PDT)
Subject: Re: [GSoC][PATCH 0/2] rebase -i: rewrite append_todo_help() in C
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20180531110130.18839-1-alban.gruin@gmail.com>
 <a6d6e5c1-e7ea-1131-c798-9d5e44603d87@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <edb744b1-f984-70fc-4639-f0414df8c669@gmail.com>
Date:   Thu, 31 May 2018 21:25:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a6d6e5c1-e7ea-1131-c798-9d5e44603d87@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 31/05/2018 à 19:48, Phillip Wood a écrit :
> Hi Alban, it's great to see you working on this
> 
> On 31/05/18 12:01, Alban Gruin wrote:
>> This series rewrites append_todo_help() from shell to C. This is part
>> of the effort to rewrite interactive rebase in C.
>>
>> The first commit rewrites append_todo_help() in C (the C version
>> covers a bit more than the old shell version), adds some parameters to
>> rebase--helper, etc.
> 
> I've had a read of the first patch and I think it looks fine, my only
> comment would be that the help for '--edit-todo' is a bit misleading at
> the moment as currently it's just a flag to tell rebase-helper that the
> todo list is being edited rather than actually implementing the
> functionality to edit the list

Right, what do you think about something like “appends the edit-todo
message to the todo list”?

> (but hopefully that will follow in the
> future).
> 

This is the next step :)

Cheers,
Alban

