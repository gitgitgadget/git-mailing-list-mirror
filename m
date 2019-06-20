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
	by dcvr.yhbt.net (Postfix) with ESMTP id 94DBB1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 09:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfFTJe6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 05:34:58 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:36226 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfFTJe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 05:34:58 -0400
Received: by mail-wm1-f51.google.com with SMTP id u8so2426097wmm.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YfA1yYC0RxwiUc1ObIt9a249uNc6/Kt35iTG8AH0mNU=;
        b=tmZkZmi0NSQqGEGLDIXdH+R6xnNkKOcUnoaNiTmEgfzM0hfWaIi6DO6P6a88sgtX4s
         LEVzGzt1hqFvcB1w+Wf7sZhBbWlCcXebFEaozgEUq7tNwM1E73PMsLxhTTLqXW5y0VV8
         yYOsVnTqBeUYmBg/otjTqm5YO5duJzObr2W8Eezbkb/RO1EGqAccrO30bs2DjhnjXhL7
         50JfKrSkkQL1IGwc4lg6nrmAnZQGFpdxCzQ06/NgBrnGBKoOLdgqNIs/Gy7SjHbl0TKu
         Zje/ob78eyxQmM61fxa/hKPw5QHhrRwgyX6uHihsQiBZiMtU3DI6J2/RwHBDlxydPoLr
         TLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YfA1yYC0RxwiUc1ObIt9a249uNc6/Kt35iTG8AH0mNU=;
        b=WzYI8PI0OP2hRAp+CUxot9n5XoSyZ6ezOawTVJ0tXs0HZ5HAVTHABYtilqyjCaL2Ey
         taSfjkP+5VUzClIigqS43bcF95ex/PekWyYVAcLhnwcxCHRPD4GWMTSt3/9MIepsxUmk
         IUaLO9hPjHyoV1xPhVurMTGbS7c9E4uF3Bn8cnLBKYKdnuf0xYnKRw0JB/WkRrU4nmRb
         rdzBDbuERfmz7oFe8DGsApP9sHEUGsiA3V17oyH/x9owRhqiZA4DzFpUxuW1QepAPhhX
         Xwi0w+K+/VKa8kDRc0jhtJzGTE/Um2vj7FfQpPmzRHhwwek/KXO5eYt5YiJfYni1asxu
         CVbQ==
X-Gm-Message-State: APjAAAVmreuJ9g0FFIKIqLPWXWWt+KeDkIvluXZLQQuHLBlCOJxHSDn8
        7dWn14NZO47uFhVRwUgBjvRN4Axi
X-Google-Smtp-Source: APXvYqxAdf3hqp08uNoczqbkOb2LkINRBfahffCw/7OrRYDOnZRnDEsLkumBaMa2eGZXvRT7YIYAwQ==
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr2019593wma.172.1561023295636;
        Thu, 20 Jun 2019 02:34:55 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id n1sm16399260wrx.39.2019.06.20.02.34.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:34:55 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: pw/rebase-abort-clean-rewritten, was Re: What's cooking in
 git.git (Jun 2019, #04; Fri, 14)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1906172001490.44@tvgsbejvaqbjf.bet>
 <2a37d4c2-6eec-548d-0bd0-12bbd49c8071@gmail.com>
 <xmqq7e9jsh8j.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b2afef27-96f8-b262-2cda-4c22dc604d2d@gmail.com>
Date:   Thu, 20 Jun 2019 10:34:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <xmqq7e9jsh8j.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & dscho

On 18/06/2019 04:30, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Yes I sent it just before I went offline, but that's a while ago now
> 
> Yup.  IIRC, you told us not to look at the patch "for now" as you
> would be offline, and I was fully expecting that a regular review
> exchange would happen after you come back.
> 
> I do not recall seeing much discussion, though, but ...

You're right there hasn't been much discussion I assume dscho is happy 
with the new version if he's asking for it to be picked up.

>>> Phillip, I was under the impression that all reviewer comments had been
>>> resolved. Does that match your impression?
>>
>> Yes, I think it's ready. Thanks for prompting me dscho, I'd seen this
>> was on hold and then forgotten to write to Junio
> 
> ... if you resolved "all reviewer comments", it must have seen
> sufficient review, in which case let's merge it to 'next'.

Thanks

Phillip
> Thanks.
> 
