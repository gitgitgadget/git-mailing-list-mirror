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
	by dcvr.yhbt.net (Postfix) with ESMTP id 65C651F462
	for <e@80x24.org>; Thu, 20 Jun 2019 11:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfFTLm5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 07:42:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33572 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfFTLm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 07:42:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so2730221wru.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 04:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XzfELHfZKZ2cE3+/yi8x1aQ8dJsM/d0+eOnEMhKRCH4=;
        b=rnbiLuwuzChrH1DeksWPHfrTUafiwVaxIfNhZQ2JK1whXij+yYX6Kytt5bKVvOXxd5
         DR1eAlYJH7Yfi8ptNUxQ3RP6i59nwImqmyu0naWgE1XC4zyihLgLKWMe4SmsWM3tPO3T
         xGKGb42TaXDWg6m41N1fKbZs4lmfC4sXFrKHewqFiNB52xHI99MCLbY4jLs1MGit5Pcq
         8eKqexlnnSeEfuoq1oiCKoVqbw0sci0Ttx67IuQQplSS9AHfZFstePp+13oStIYx/KDF
         4DwrAqKqufaVuTzd23zLJiuafuUDOyuMiSBmwQINUBKdx+db27vVQ7tR+iwqWXoR3GHw
         17AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XzfELHfZKZ2cE3+/yi8x1aQ8dJsM/d0+eOnEMhKRCH4=;
        b=KclPdY4eZITn0mjpPnD1d+M+tX2UCnUWkniUES1isbnCWdiGm8BDDDbnympXRqzZcz
         K9ENrnPOZOfSw91qzoUTpiBExKKP8TOph8lPIPGTk3ZAaZkI0ncI8mdW2Hm8jn85tmmW
         gtJCCrdK6lm4XIJhz71g6ep0mxIzAD8odLy4nZTf0V7e3WQqo1ggDvA6sto/XlH+VYYv
         IDx55uCkKsa/xXKCzFIJ/S9UCMZ6WdZ8jiL9QeEbi+SmFY6IVUBJ3YHP6E2ymC2HPQBW
         U/HPUqEo6TH4W/D4uPDLCog4lloy+eYMnGSBdvZhWLS5mTEStzGtkmuZA7ho8+4ywF3M
         yAhw==
X-Gm-Message-State: APjAAAVuZLPHHghK6nMV8l4qNXp1F5z2BPNZ1Mn2sLMDnfnyYuAD+kZy
        JgHzzfOoikk/VXUjwm9FXKc=
X-Google-Smtp-Source: APXvYqzpE9w863LXs4AUAplwCbOzhvHTzp1oGIg31hY6VBr1+t5qUMKUkz2VjKnMqvdKiYxtRgP1mA==
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr26103852wrx.29.1561030974871;
        Thu, 20 Jun 2019 04:42:54 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id t198sm5633881wmt.2.2019.06.20.04.42.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 04:42:54 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 4/5] cherry-pick/revert: add --skip option
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood@dunelm.org.uk, t.gummerer@gmail.com
References: <0047b8c6-8a58-7546-2ae8-19c4ab668fa3@gmail.com>
 <20190620103401.29654-1-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b6cf26b0-51b7-0c63-fb1c-4da1eb3666cb@gmail.com>
Date:   Thu, 20 Jun 2019 12:42:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190620103401.29654-1-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 20/06/2019 11:34, Rohit Ashiwal wrote:
> Hi Phillip
> 
> On 2019-06-20 10:02 UTC Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>>> +test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
>>> +	pristine_detach initial &&
>>> +	git rm --cached unrelated &&
>>> +	git commit -m "untrack unrelated" &&
>>> +	test_must_fail git cherry-pick initial base &&
>>> +	test_path_is_missing .git/CHERRY_PICK_HEAD &&
>>> +	git cherry-pick --skip
>>
>> If you change this to --continue rather than --skip the test also
>> passes! I think we could fix this by checking if HEAD has changed if
>> CHERRY_PICK_HEAD/REVERT_HEAD is missing and not dropping the last
>> command in the todo list in that case when we continue.
> 
> I don't think I fully understood this. At this point --skip is essentially
> --continue. How is checking unmoved HEAD and unchanged todo uniquely related
> to --skip flag (or for that matter any _flag_)?

My point is that --continue should reschedule the failed pick and try to 
pick it again - it should not silently skip a failed pick and  --skip 
should skip it.

Best Wishes

Phillip
> 
> Thanks
> Rohit
> 
