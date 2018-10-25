Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DE61F453
	for <e@80x24.org>; Thu, 25 Oct 2018 13:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeJYV7D (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 17:59:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34098 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeJYV7C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 17:59:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id z2-v6so9810998qts.1
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 06:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dss9H/fxNR/B0guoBm876TzpjUy47hluB1KeKySpstI=;
        b=nSUQOfPVnwYwn8m735Z+U/QQBl+1qs/pZuNd8LlHg3ksPunfTZvzBYySOZb1X88pkZ
         +0/qoF7tHSYklHm5yX8hqCTCKzgTlmpJW3P7k4UKg12VYVWXXpSFtAihIAg1WQCXvvUh
         IUIOk3mwEgZW5VndIpe9Dzt+9ObZUZ5R5Efgc1fH47P9wUO6YLVCFnbfCc6ZZn38nmfK
         Tan67GgReQ1cMH0TfY9MNU28aRai/lKtbxCyAK/xJf9nyKg+IHoYNqufKPxX1kqcCRLL
         tIKCfSLubaIeFDCr/s93rBbI1G2++czl97a1iRzGbFFbJ0HGhjFJ9Su1q0Fz2hcND3lH
         +iLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dss9H/fxNR/B0guoBm876TzpjUy47hluB1KeKySpstI=;
        b=l+zkXBfGTa7ansg1DyIYx12txdOJh7s4u57JC9Tfgu6A/8KV4axdZb32krWbJOlNZ8
         m3j6aYNXshOhDySWFUCNzmG7meYPgLG/UUYKXH1LGnOIuPxpUgfT97fRSxI4KbGWvt/o
         zVvuLYAVmwbfNwgqpwoJ1AKuQY4UR+af/+GoBAZzEuZ3Kt/atSkLokL9a8fNTz0wRJzE
         EcrLfkeLSJSDzTKCb2LZnNkaO7ypmeuJsyAfKmsRG3JVnPUdxj61ndN9CzdmdaH+IhxM
         /oLyy3r3PUgh8AX146FR/NxXBThFCfRWhVKaWpAgy+TgVjQR6Z9Cf/a6cdqJyL2bWVES
         w72g==
X-Gm-Message-State: AGRZ1gIzruG7pYMY99vllLJ7TpWM/PMbvHdMdM/c+lItz/GtSogeGY6z
        FeZwue+yIerpWnvqDLPnuQ0=
X-Google-Smtp-Source: AJdET5f2mhAkFbS8SpMaRIHzeiZLfHY7eZmD3g1miiPf3/vniVnMY1pzbignYaZAgNe1F02poKwP2g==
X-Received: by 2002:a0c:d002:: with SMTP id u2mr1497987qvg.92.1540473976949;
        Thu, 25 Oct 2018 06:26:16 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 50-v6sm7685825qty.48.2018.10.25.06.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 06:26:16 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] reset: add new reset.quiet config setting
To:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, peff@peff.net,
        sunshine@sunshineco.com
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181023190423.5772-1-peartben@gmail.com>
 <20181023190423.5772-3-peartben@gmail.com>
 <3c31d5c3-df46-69e3-c138-30a93d9b3ce4@ramsayjones.plus.com>
 <xmqqpnvyk4jc.fsf@gitster-ct.c.googlers.com>
 <xmqqbm7igyw6.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <7daf3329-15c4-d3de-227d-5c729b9cb824@gmail.com>
Date:   Thu, 25 Oct 2018 09:26:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqbm7igyw6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/25/2018 5:26 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> To be honest, I find the second sentence in your rewrite even more
>> confusing.  It reads as if `reset.quiet` configuration variable
>> can be used to restore the "show what is yet to be added"
>> behaviour, due to the parenthetical mention of the default behaviour
>> without any configuration.
>>
>> 	The command reports what is yet to be added to the index
>> 	after `reset` by default.  It can be made to only report
>> 	errors with the `--quiet` option, or setting `reset.quiet`
>> 	configuration variable to `true` (the latter can be
>> 	overriden with `--no-quiet`).
>>
>> That may not be much better, though X-<.
> 
> In any case, the comments are getting closer to the bikeshedding
> territory, that can be easily addressed incrementally.  I am getting
> the impression that everbody agrees that the change is desirable,
> sufficiently documented and properly implemented.
> 
> Shall we mark it for "Will merge to 'next'" in the what's cooking
> report and leave further refinements to incremental updates as
> needed?
> 

While not great, I think it is good enough.  I don't think either of the 
last couple of rewrite attempts were clearly better than what is in the 
latest patch. I'd agree we should merge to 'next' and if someone comes 
up with something great, we can update it then.
