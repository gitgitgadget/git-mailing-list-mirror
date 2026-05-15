Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9253F0ABC
	for <git@vger.kernel.org>; Fri, 15 May 2026 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837614; cv=none; b=bUSbLrDjYidFHO4uiUGVE4ckl9zh+g1rh8/ply/Z5kGqzsI5I9VljZyhS4uQjLG/MVjsQtL0DjlVZXwlPYjMtDrVJhgB5a7kRgsqa4Yhdj8uXNfswrOgev9HatvVI3Z6bF4K77LRMEhR9Sgi+ctm9VP/wwKeNcbw1s86riVVKrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837614; c=relaxed/simple;
	bh=uTr8OQ3Oo/8xKWImbNf5CVBbcwhpq43WMllaT0nVgSQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C9va6QnKuXZSjQUDdLyUAIca8T6gNuQ4v7squQAEItlegEl+JN6por4yr5X9NGRtaVUN/cQ2zO3suDmiplPrfdO1O45I049AImMHLkeel8jC7WGhpncPw3Xuh0h5o3pifCJzxB7zjCEWUSibOGYV4u6Odpr8zSjZfsCJL+BDexc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9H2m3NK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9H2m3NK"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44509921fbcso4599113f8f.3
        for <git@vger.kernel.org>; Fri, 15 May 2026 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778837611; x=1779442411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTcYjq+p5Jeo3KcsQPCg1ZgELsXfH8aBYUhuapvpftg=;
        b=P9H2m3NKWxb6pnL/Jo/WLOevZGPcqikrdw7BF+fMOL7n4qn2RMbt8glBtFkUhtqpDY
         hMvcKvD1LeYrvybQajgh/7A7DWkPMgRY26Xfhpnds/VD5pg+bh00Fio0b4smVFD3wVkK
         2EyzPOiyJNukDa3+GqNXmS4ER+m3IEs52uJEo54RoybjHDUXQbasdj29o8b5EGQrkUTd
         8TABz/i8yFBRGE2EZ/KaslJL3HNA2rpE/jccIEu9jPF/XqM7SKLR24Ke6E2uuh46jmPI
         9pQS0DWijt33N0x+hwzY6psq5D4X0Ve67aPolQysh2sZzSlPKfEx3BzxQgTrr784t0hS
         E+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837611; x=1779442411;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTcYjq+p5Jeo3KcsQPCg1ZgELsXfH8aBYUhuapvpftg=;
        b=tAorgfEYnIOwMbin3EM1Mqgf2rbTMoBu7BDEJl/AUQXaTpU8n1i9RtaYCmiZiPxXAd
         rZ5IxfRU6MBYBC6zOhmKkt9smM0CZoVt/oeD5VmpZPgGXgAsFAsQkSWhupCCW484qxs5
         Qa6YM+s+MneziWEOOq2EHLNfZbcCWon8bO4MqWfPNs8Z3s8g9XcA4yx2RkP9IKLi0/NV
         BXsv2cKzno7+0YHcrYRCZRPBaBBedx+LdRm36PkEigRj7YwEpRcZ0XyDWOe3qE3ivBKc
         vDSEcZ5h7+QLofGTHfJbaeN0MF1y/D6NoSBKFwbTfKXHB3wCzb2VV2hwikIAJUmu+cMT
         JJhw==
X-Gm-Message-State: AOJu0YxrYXVM77tE6xE8GBeT2KepdwcPDpHIni2a9qgZJnXd2kx1qRzQ
	4pjJ0Dj92Vt1/ZmIL+yNLl+MR1xfSum6AbY5s5Sl4Isr1BvjewH5Zfoz
X-Gm-Gg: Acq92OFEKOkHQaV9dwdKCs9Jm6brtG/d4iDG2lSRz8Ai4goo/8bYkMJouKMqNiRrOb/
	ZvuQ9fXGduv0iCFD/SsoOYXHeo/sV4TXgmvJuBzR2UXIwOZnEIBXnUxJsSApLrFjGsA9pj9YgcS
	+mv47nBTPCdxSwWqxJToXPYzAWQmfwZk13XkwbLTx0iO3Vm11qWP5LtmeNFevKDKJuB6cedFT0d
	NYN6mO8hBW8HKFD4luEEogDQULpr38IHHdr6l4PSJuApo1x8wTDJ9JV+o3wpd0fo0R5cMLng94n
	APCVSwX2KIxRGUqE0An1+SwbfUecTcO2DmpowMx/zHdONzDVphhCsi5Wg/k5h6YAKkcLCsvrSoT
	bZ2teOIImF5BJEC+ynWEAc06vr2tkKrPA+pK08FA9b9q+0fgwIdKXneh6gi7of29PuAbbdWOE5w
	JYGOev6yySbDrOOJKGBowoZ1JepnNbRYq00yT7c9fwZ3kl7H8EoCWTh2xTtsQwSXsVyYajrXgsQ
	IFLxw==
X-Received: by 2002:a05:6000:2910:b0:45a:e3dd:5865 with SMTP id ffacd0b85a97d-45e5c5a0475mr4119859f8f.13.1778837610488;
        Fri, 15 May 2026 02:33:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17d3:2101:5ed:447d:e5d1:52d7? ([2a0a:ef40:17d3:2101:5ed:447d:e5d1:52d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm14130804f8f.32.2026.05.15.02.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 02:33:29 -0700 (PDT)
Message-ID: <2e8b9b1b-6a69-4e94-95ea-7f587435bfce@gmail.com>
Date: Fri, 15 May 2026 10:33:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH 0/1] graph: add indentation for commits preceded
 by a root
To: Pablo Sabater <pabloosabaterr@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
 karthik.188@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com,
 siddharthasthana31@gmail.com, chandrapratap3519@gmail.com
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
 <26d887d2-6ec2-4af1-b0bd-8e9b017bb4dd@gmail.com>
 <CAN5EUNQCsKD0CJqDi43i2JVBQQChAZVt_THQ1wGpdeydNHHCFw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAN5EUNQCsKD0CJqDi43i2JVBQQChAZVt_THQ1wGpdeydNHHCFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/05/2026 18:45, Pablo Sabater wrote:
> El jue, 14 may 2026 a las 17:15, Phillip Wood
> (<phillip.wood123@gmail.com>) escribió:
>> On 02/04/2026 22:17, Pablo Sabater wrote:
>>> When having a history with multiple root commits and drawing the history
>>> near the roots, the graphing engine renders the commit one below the other,
>>> seeming that they are related, which makes the graph confusing.
>>>
>>> This issue was reported by Junio at:
>>>     https://lore.kernel.org/git/xmqqikaawrpx.fsf@gitster.g/
>>>
>>> e.g.:
>>>
>>>     * root-B
>>>     * child-A2
>>>     * child-A1
>>>     * root-A
>>>
>>> [...]
>>   >
>>>     * root-B
>>>       * child-A2
>>>      /
>>>     * child-A1
>>>     * root-A
>>
>> I'm rather late to the party here, but personally I find the indentation
>> a bit confusing, it would be clearer to me if we had a blank line after
>> a root commit
> 
> Hi,
> 
>>
>>       * root-B
>>
>>       * child-A2
>>       * child-A1
>>       * root-A
>>
>> It takes the same amount of vertical space but keeps the children of
>> root-A together.
> 
> I have mixed feelings about which approach to choose.
> The idea of a blank line was thought at
> https://lore.kernel.org/git/xmqq8s8vvw9m.fsf@gitster.c.googlers.com/
> but Junio argued against it for having an extra row because the
> indentation he proposed didn't collapse, however I find indentation +
> no collapse the most confusing one.
> I'd say that I'm fine with both approaches, blank line or indentation
> + collapse.

I'm afraid I don't understand this - what does it mean for the 
indentation to collapse, or not collapse. Looking at the examples Junio 
gave they look quite nice to me, though I'd find it clearer if


  | | *  12345678 2021-01-14 merge xxxxx@xxxx into the history
  | | |\
  | | | \
  | | *  \  23456789 2021-01-12 merge citest into the main history
  | | |\  * 5505e019c2 2014-07-09 initial xxxxxx@xxxx
  | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) 
Added defau
  | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from 
f7daf088)

was rendered as


  | | *  12345678 2021-01-14 merge xxxxx@xxxx into the history
  | | |\
  | | | *  5505e019c2 2014-07-09 initial xxxxxx@xxxx
  | | *    23456789 2021-01-12 merge citest into the main history
  | | |\
  | | | *  3e658f4085 2019-09-10 (wiki/wip-citest, origin/wip-citest) 
Added defau
  | | | *  ad148aafe6 2019-09-10 Added default CI/CD Jenkinsfile (from 
f7daf088)

>>> without the patch:
>>>
>>>     * A root
>>>     * B root
>>>     * C root
>>>     * D1 child
>>>     * D root
>>>
>>> with the patch, the indentation cascades:
>>>
>>>     * A root
>>>       * B root
>>>         * C root
>>>           * D1 child
>>>        _ /
>>>       /
>>>      /
>>>     * D root
> 
>    * A root
> 
>    * B root
> 
>    * C root
> 
>    * D1 child
> 
>    * D root
> 
> Here I think a blank line looks worse, too much space for just 5
> commits and becomes one extra line which if this were like up to 7 or
> more parentless commits one after the other would be more noticeable.

But there shouldn't be a blank line between D and D1 so the two 
alternatives take up the same amount of vertical space, the main 
difference being whether D1 appears next to D

     * A root     * A root
                    * B root
     * B root         * C root
                        * D1 child
     * C root         _/
                    /
     * D1 child    /
     * D root     * D root

Of course if the indentation was smarter it would take up less room and 
look better than having blank lines

     * A root
       * B root
         * C root
     * D1 child
     * D root

> But there are cases that blank line might be better:
> 
>    * 10_A2
>    * 10_A1
>    * 10_A
>      *   10_M
>     /|\
>    | | * 10_D
>    | * 10_C
>    * 10_B
> 
> Feels like a shower of commits instead of an indented merge.

Yes, that is a bit confusing. I think the thing I find confusing with 
this approach is that we're treating the commit rendered below the root 
commit specially, rather than treating the root commit itself specially. 
To me it is the root commit that's the odd one out because it does not 
have any parents, but we treat the commit that's rendered below as the 
odd one by indenting it relative to its parents.

> Pro to the blank line, the parentless check is the same and it's just
> printing a '\n' at the right spot, while indent i'm mimicking like if
> there was a commit there.
> Anyways, I think in the majority of the cases the indentation +
> collapsing looks better.
> Sorry for the brief reply, I'm busy today.

No need to apologize, it seemed quite comprehensive to me

Thanks

Phillip

> Regards,
> 
> --
> Pablo
> 
>>
>> Thanks
>>
>> Phillip
>>
>>> This is done by adding a is_placeholder flag to the columns, the root commit
>>> is actually there but marked as a placeholder
>>>
>>> e.g.:
>>>
>>>      * root-B
>>>     (B) * child-A2
>>>       /
>>>      * child-A1
>>>      * root-A
>>>
>>> (B) would be root-B column with the placeholder flag active.
>>>
>>> Then teaching the rendering function to print a padding ' ' when meeting a
>>> placeholder column outputs the second example.
>>>
>>> There could also be the case where there are multiple roots
>>>
>>> without the patch:
>>>
>>>     * A root
>>>     * B root
>>>     * C root
>>>     * D1 child
>>>     * D root
>>>
>>> with the patch, the indentation cascades:
>>>
>>>     * A root
>>>       * B root
>>>         * C root
>>>           * D1 child
>>>        _ /
>>>       /
>>>      /
>>>     * D root
>>>
>>> the _ / might look weird but that's how the collapsing rendering does it
>>> for big gaps, this case being from the 4th column to the 0th column.
>>> Another patch could change the collapsing rendering for placeholders ?
>>> I haven't done it to keep it minimal, but a follow up could make it
>>> to be straight '/'. This would make it bigger but easier for the eye to follow.
>>> IMO is not worth it, but opinions are welcome.
>>>
>>> The patch also adds tests for different cases like a root preceding multiple
>>> parents merges and the examples above.
>>>
>>> There could be some edge cases still so any testing is very welcome.
>>>
>>> Pablo Sabater (1):
>>>     graph: add indentation for commits preceded by a root
>>>
>>>    graph.c                      |  68 ++++++++++++++++--
>>>    t/t4215-log-skewed-merges.sh | 136 +++++++++++++++++++++++++++++++++++
>>>    2 files changed, 198 insertions(+), 6 deletions(-)
>>>
>>>
>>> base-commit: 256554692df0685b45e60778b08802b720880c50
>>

