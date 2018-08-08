Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD60208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeHHRhX (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:37:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40917 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeHHRhW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:37:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id y9-v6so3153877wma.5
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QofmQVHB3j7Fq4bs3GTfxpX2T9r6OY367SwJXNoozXI=;
        b=JhFqSUDuaZZFGe8bgHzyqvEjDFzj3b6LNIXyxcIFwbU27z9uxXPrW5UsSumglQCFRv
         O5tLYUYN0VUiMYGWz5dk8jDx/QC0Fjl74jq6UsXeJogymHnSNyBXHKHZfOvManXkNjtE
         Oo0U1l40nx4Ief9w7EI44PKvwxK4HAcoaREejM4psFz1LgnTymm7o+sKyo3AxfqYAq9C
         9Eq1c1ci8C3RsU9PSUbnqOrVsRI+RaZRLH26dAcxsqt2cICOOLqi45MQ7PHZvfFsH63s
         QXtPY51K+je1TgUh6si5X7E3/5u/f3O6BwSJcLHUOVFdxAvagwUxzgsJnSqUC6LJ9HrS
         vfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QofmQVHB3j7Fq4bs3GTfxpX2T9r6OY367SwJXNoozXI=;
        b=jKnUc5kMDfylkjwpdycVh5ibj6saPIeKlw3ht7W/cd8E4IVLI+5rzLIo/cx846ZWyi
         /QCT4Y2ElTl+nUzF0qTkDfZcrbDGyY8KYQH65gXpNgCGqf78K7P2k4meMHpR5JFJEk+a
         /D0afBtDBW5dETKbGyh42a9P2ZsEkoRsIDErK8WF87xt4WHyreeOETNN5jH0S3Footym
         K7X+QbuLHwun1/2R46KH/s/9lQox2ccUmh85iRuHKREcZapgj6fL0CR2aOalVvew2XRn
         j1SLIwIcPq+Ut00M643v2Fy4dbmPatKj+N/hA8uk6xJPW8HZ1oDeh6ZrOm9RbrqRfSV1
         e/eQ==
X-Gm-Message-State: AOUpUlEDqv8zThZiAUuwZ2JsHWndi7sifxa4X8jWfqhkjGMYo+YQgWGh
        NXQ/uYd0WGSbgVgol+fuvMQ=
X-Google-Smtp-Source: AA+uWPzuumL6Dd/K6ri8gi61VayN9A7eyMKCEZk+oXp7yrWZVJMUE7FHiri76BIBsNZDpeaKV8mwbQ==
X-Received: by 2002:a1c:b6d6:: with SMTP id g205-v6mr2351488wmf.17.1533741434568;
        Wed, 08 Aug 2018 08:17:14 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-30-228.w86-222.abo.wanadoo.fr. [86.222.29.228])
        by smtp.gmail.com with ESMTPSA id l72-v6sm13164213wma.17.2018.08.08.08.17.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:17:13 -0700 (PDT)
Subject: Re: [GSoC][PATCH v5 02/20] rebase -i: rewrite append_todo_help() in C
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180731180003.5421-3-alban.gruin@gmail.com>
 <d83efc2e-3538-9547-244f-ca7653498c22@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <d8f0e5a2-f621-7847-5113-df4a6da11151@gmail.com>
Date:   Wed, 8 Aug 2018 17:16:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d83efc2e-3538-9547-244f-ca7653498c22@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 07/08/2018 à 15:57, Phillip Wood a écrit :
>> +	if (ret < 0)
>> +		error_errno(_("could not append help text to '%s'"), rebase_path_todo());
>> +
>> +	fclose(todo);
> 
> You should definitely check the return value and return an error if
> appropriate as fputs() might not actually write any data until you try
> and close the file.
> 

Is this worth a reroll, as this goes away in a later patch (refactored
in 08/20, removed in 12/20)?

> Best Wishes
> 
> Phillip
> 
>> +	strbuf_release(&buf);
>> +
>> +	return ret;
>> +}
>> diff --git a/rebase-interactive.h b/rebase-interactive.h
>> new file mode 100644
>> index 0000000000..47372624e0
>> --- /dev/null
>> +++ b/rebase-interactive.h
>> @@ -0,0 +1,6 @@
>> +#ifndef REBASE_INTERACTIVE_H
>> +#define REBASE_INTERACTIVE_H
>> +
>> +int append_todo_help(unsigned edit_todo, unsigned keep_empty);
>> +
>> +#endif
>>
> 

Cheers,
Alban

