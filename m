Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A34CC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 12:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43834207FF
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 12:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zivver.com header.i=@zivver.com header.b="duXx3dKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLJMLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:11:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54873 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLJMLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 07:11:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so2907182wmj.4
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 04:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zivver.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lqzdQcV3AB/K7NRDi6C/ITfA8TB2s5qzvWqHmX4oSYo=;
        b=duXx3dKjxtM3e9SBAsE2qf/Epivchg0tO0mn6Chpu430cuaYKmcuy3X8a7kmRnwMnd
         ngoryEW9Lp4BeXLJOvUzEACYbfLCAS7MUKlA2wHSjLvvP7xeBpo9arnqze1GXgNCAOE6
         zmS3npxY97bHMeYrSiXJNb7CwQia4mLpgkz48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lqzdQcV3AB/K7NRDi6C/ITfA8TB2s5qzvWqHmX4oSYo=;
        b=bwhyG/ya6ABJ5mdFrlazAD7CWo8Mh5k6fXQCdH5fq44fz1pDZ65Qbew3mrZErf9WzY
         9NSxl+W8P1oJ2lCoOGzTuEg8DoQFfkuNVnszTDwLY/EbgcGwQat4MJ9CFrbAxQAxer82
         BZPTm8El0cG4g9jco6KuZaMPtPunP+6hTTfizQhy6m1TnYGx9CgKcGrJZ5UK6gu0wXnI
         wSEckp86x2me4c6LYTdQhRhUtYZwLGQ35aP+Ht2gmXmd8ZFgLHABGa4tXjSxbbC5auzb
         HJo+V1wiTuc9+orkwcrT6UK41hkgm7PnZyuPrFRdgLQXOva+Ce1ZQ2qYsEwz7/LsFjAI
         8Ouw==
X-Gm-Message-State: APjAAAU8/hrVb0sMjn+OVkfqC1zfzlmTzVeOzW1/y72W5F9tkBzwxCyN
        yi6/WomAULty7XalmLRfLn/cmuMmhbM=
X-Google-Smtp-Source: APXvYqzlaeCnKJjE8aKVJc79T0r638yA8pcn0xLvXl1d43R9WspM/4XcS4vsCslKAT6oOmVY0lEK1w==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr4610892wmi.166.1575979882004;
        Tue, 10 Dec 2019 04:11:22 -0800 (PST)
Received: from ?IPv6:2a00:a000:8:16::2d7? ([2a00:a000:8:16::2d7])
        by smtp.gmail.com with ESMTPSA id i8sm3028853wro.47.2019.12.10.04.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 04:11:21 -0800 (PST)
Subject: Re: [PATCH] git-gui: allow closing console window with Escape
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
References: <20191206222040.toj4enbbbbamnrww@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1912071723010.31080@tvgsbejvaqbjf.bet>
 <20191208194046.csf35b7rgycst2vc@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1912091014220.31080@tvgsbejvaqbjf.bet>
 <1313cb5b-9d6a-f038-bda3-757b4e55bf33@zivver.com>
 <20191210120219.zc4k5dih25ae3da6@yadavpratyush.com>
From:   Vasili Novikov <vasilii.novikov@zivver.com>
Message-ID: <949c8fca-bf7d-ebde-4f28-10cf193c0411@zivver.com>
Date:   Tue, 10 Dec 2019 13:11:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191210120219.zc4k5dih25ae3da6@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,
Sorry if threading was broken: Thunderbird possibly doesn't fully 
support mbox import that I used. Or I did it unproperly. Either way, 
hope it's correct now.

Thanks for explaining. I misunderstood the purpose of the window. If 
it's a slow ongoing task, then indeed it should not be closeable with 
Esc. I'd say it makes sense to allow Esc to work when it gets into 
"Success" state though, as in the screenshot.


Thanks,
Vasili

On 10/12/2019 13.02, Pratyush Yadav wrote:
> Hi Vasili,
> 
> Please try to not top-post on the list.
> 
> On 09/12/19 04:53PM, Vasili Novikov wrote:
>> What have console windows to do with git gui though? I'd work under the
> 
> Well, the window/popup in question is internally named "console" and is
> defined in lib/console.tcl. It is used by many parts of git-gui that
> need to execute a command and show the output to the user.
> 
>> following assumptions:
>> * we're talking about a GUI window, not a TUI one
>> * the window has no useful information at all except the fact that something
>> has "finished", is "done". There are no actions that you can take except to
>> dismiss the window.
>   
> It also shows you the output of a command currently in progress (like
> git-push). My main argument with avoiding Escape is that people often
> expect Escape to stop an ongoing command. In this case though, closing
> the window does not actually stop the command. It keeps going on in the
> background.
> 
> But since the window is gone, people might think the command they were
> running has stopped, which might lead to some unexpected results.
> 
>> If we agree on the following assumptions, then I see these real-world
>> examples:
>> * Mousepad > About > Esc = closes the popup
>> * Firefox > About > Esc = closes the popup
>> * Thunar > select any file and ask its properties > Esc = closes the window
>> * file-roller (GNOME compressed archive manager) > Extract archive > Observe
>> success window upon completion > Esc = closes the window.
> 
> In this case, the thing is done. There is no ongoing task. Not quite the
> case with the console window in git-gui, which can also show ongoing
> tasks.
>   
>> Are there any real-world examples where `Ctrl W` or `Esc D` work but `Esc`
>> doesn't, to consider these alternatives as more intuitive to users?
>>
>>
>> On 09/12/2019 10.18, Johannes Schindelin wrote:
>>> Hi Pratyush,
>>>
>>> On Mon, 9 Dec 2019, Pratyush Yadav wrote:
>>>
>>>> On 07/12/19 05:24PM, Johannes Schindelin wrote:
>>>>>
>>>>> On Sat, 7 Dec 2019, Pratyush Yadav wrote:
>>>>>
>>>>>> It is often expected that popup windows like the console window be
>>>>>> close-able with Esc.
>>>>>
>>>>> Seeing as the console windows is not your regular popup window with an
>>>>> "OK" button, I could see how it would be all too easy to close the window
>>>>> via the Esc button all too easily, annoying users.
>>>>
>>>> I'm not sure why it is "too easy" to hit Escape. If you're hitting Esc
>>>> (which for most people is pretty far from other more frequently used
>>>> keys) you expect _something_ to happen. People don't just spam Esc for
>>>> no reason, do they?
>>>
>>> Is it possible to issue a command in that console window? If yes, Esc D is
>>> what people like me would possibly use to delete entire words.
>>>
>>> Even if not, if there is no "OK" button, it would annoy me no end if the
>>> Escape key closes the window (it is not a dialog box, after all).
>>>
>>>>> For windows like the console one, I would expect Ctrl+W a much more
>>>>> natural keyboard shortcut to close it.
>>>>
>>>> But, that "something" the user expects to happen could also be "stop the
>>>> command". AFAIK, Esc is often expected to stop commands. But closing the
>>>> console window won't actually stop the command. It will keep running in
>>>> the background, and when the command is done, the window will open again
>>>> showing the final output.
>>>>
>>>> So all in all, I do think Ctrl-W would be a better idea. Will re-roll.
>>>
>>> Thank you,
>>> Dscho
>>>
>>
>> -- 
>> Vasilii Novikov
>> Software Developer
>> vasilii.novikov@zivver.com
>>
>> ZIVVER B.V. • Koningin Wilhelminaplein 30 • 1062 KR Amsterdam
>> www.zivver.com • +31 85 01 60 555 <+31-85-0160555>
>> Follow us on: twitter <https://twitter.com/zivver_nl>, facebook
>> <https://www.facebook.com/zivver> and linkedin
>> <https://www.linkedin.com/company/zivver>
>>
>> ✓ Voldoe jij al aan de GDPR-wetgeving?
>> <https://get.zivver.eu/nl/gdpr-checklist/>
> 

-- 
Vasilii Novikov
