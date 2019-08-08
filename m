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
	by dcvr.yhbt.net (Postfix) with ESMTP id 851BB1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 20:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390191AbfHHUt4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 16:49:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37694 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730768AbfHHUt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 16:49:56 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so69953244qkl.4
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 13:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g/wGYpEvrtHvnNrZD0Tk4Gup2AJS7mtbt54K/ljUp6Q=;
        b=nR+BrZXWXD4pCaVWgeRDjkU/Zrlk2hGH1ic9+0mH+W6qJ+wODuRw1KTMIxvitDTr1C
         jtQ+P129dYj+keyhJlfU9nQ+7OVtzdmfQlnkbYg146epCWZ4HZXG6Aenff86pmiLl2sY
         /Cw34a3IbkIfLRGAV2EyJICvzz5qGxEmoJSH77FDFO/jco+i9+t4vM067XCTyADXRaKu
         64+Ze9Ckpt+xi5zeDqWJ0oDgfls+Wwfi8XWeLn6YiTLQjvoqFJoCqMD+fbJC5pANh4kV
         eEllpPyH2W4LOCbN6r9eXpjLWQ41OCZ8T9u90cgM6cHa6lAl8ErnNHNRWlQDqUFrBki8
         cLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g/wGYpEvrtHvnNrZD0Tk4Gup2AJS7mtbt54K/ljUp6Q=;
        b=X8+bJ7haFxyp7NFOecTG0OFqIuUetRIo8IXKAT13TMOBUu03r7M6vOLmwF3bI1ExpW
         d3ThekbSzpo/9a9MWG9KO62esM0IsEaJF3DMNkZe60qNvYP7O1mehKazQ+mKlhVRtppo
         AYX/Urlf+L5R0slCu1OPplX5y75wS5q/X/Py3q6FIStIVcBMGAWzqMFquLHrFVBegRsO
         4nQhqIkv5/RB7vHPUBpmgl1jUWEVLU7xqNBlJOdjHL/WTxXPhbXFtPvpOWkY9AK5jSlo
         BSE09nJDOv7xJhrn/48QJG5dUzK63MkYZBo894GLshrudpUXEzeK5IdzSvll46LjICAr
         n8AA==
X-Gm-Message-State: APjAAAV9bFSh1qy06N8Ob8+S2DAlJ5/hp0z3Qx9R17+TJPW8zC7++LrE
        H3EvGyYPReF3IZrY9Q05bSA=
X-Google-Smtp-Source: APXvYqzfgZzG3me5/NbSLszPqlvmVJMTb71xrZPBYKmMDKTuKf6XkPcLAbTUjl1nhVvPZ6DiFLDikg==
X-Received: by 2002:a37:270a:: with SMTP id n10mr15285620qkn.434.1565297395262;
        Thu, 08 Aug 2019 13:49:55 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7487:521b:1543:4364? ([2001:4898:a800:1012:25bb:521b:1543:4364])
        by smtp.gmail.com with ESMTPSA id 131sm42862163qkn.7.2019.08.08.13.49.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 13:49:54 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] repo-settings: create feature.experimental setting
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        carenas@gmail.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.292.v2.git.gitgitgadget@gmail.com>
 <pull.292.v3.git.gitgitgadget@gmail.com>
 <2e153fac22dc5c27fc85efc802785edc0c9d78ad.1564515324.git.gitgitgadget@gmail.com>
 <CABPp-BGppXSt9i4SXTizgPXap-YgHBwHTVrvwDpg98zvpYRwcQ@mail.gmail.com>
 <xmqqd0hffpoz.fsf@gitster-ct.c.googlers.com>
 <4fe2cb63-2d6c-d8d5-5531-9ea6d624a85a@gmail.com>
 <CABPp-BGo5spDbk34YwAPGqT1Xgsr1dHm6OhxY1xKFQxQaotBig@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1a2bf8e1-5cc1-c626-9dfc-dd6dc58fa0ad@gmail.com>
Date:   Thu, 8 Aug 2019 16:49:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGo5spDbk34YwAPGqT1Xgsr1dHm6OhxY1xKFQxQaotBig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2019 4:31 PM, Elijah Newren wrote:
> On Thu, Aug 8, 2019 at 12:12 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 8/8/2019 2:59 PM, Junio C Hamano wrote:
>>> Elijah Newren <newren@gmail.com> writes:
>>>
>>>>> --- a/Documentation/config/merge.txt
>>>>> +++ b/Documentation/config/merge.txt
>>>>> @@ -54,7 +54,8 @@ merge.directoryRenames::
>>>>>         moved into the new directory.  If set to "conflict", a conflict
>>>>>         will be reported for such paths.  If merge.renames is false,
>>>>>         merge.directoryRenames is ignored and treated as false.  Defaults
>>>>> -       to "conflict".
>>>>> +       to "conflict" unless `feature.experimental` is enabled and the
>>>>> +       default is "true".
>>>>
>>>> I have a hard time parsing that changed sentence.  Perhaps something like:
>>>>    ...unless `feature.experimental` is enabled in which case the
>>>> default is "true".
>>>> ?
>>>
>>> That reads better.
>>>
>>> But I am not sure about the wisdom of controlling between conflict
>>> and true with this feature macro in the first place.
>>>
>>> Between "conflict" and "true", the former forces the end user to
>>> verify (or allows the end user to veto) the auto resolution by the
>>> heuristics and is always a safer if more cumbersome option.  It's
>>> not like blindly trusting the directory rename heuristics is the
>>> bright future for all users, is it?
>>>
>>> I would not set rerere.autoUpdate to true when feature.experimental
>>> is set; for exactly the same reason, I do not find it reasonable to
>>> set this to true with feature.experimental macro.
>>
>> OK. I can remove it from the feature.experimental variable.
>>
>> Shall I keep the enum logic and the use of repo-settings.c? I can split
>> them out into a separate patch.
> 
> Good question.  In part, I was looking at this ds/feature-macros
> series because my cleanup-merge-api series[1] has some minor conflicts
> with it.  I'm a little unsure what route I should take with my series
> now.  Some choices:
>   * keep this logic in your series in a separate patch, and have me
> rebase my series on yours.
>   * drop this logic from your series since it may not be needed
> anymore, making our two series independent again.
>   * move this logic into a separate patch of yours but making that
> patch part of my series instead; that'd be easy with the enum logic,
> but the repo-settings.c stuff appears to depend on your other
> patches...
> 
> Thoughts or preferences?

I've done the work in my GGG PR [1] to split the commit into two,
with the merge.directoryRenames on top. I created a tag [2] at that
commit and I'll send my v4 without changes to merge.directoryRenames.

I'll let you decide if you like placing the config in repo-settings
or not (or want to adapt the enum logic in a different place).

Thanks,
-Stolee

[1] https://github.com/gitgitgadget/git/pull/292
[2] https://github.com/derrickstolee/git/releases/tag/merge.directoryRenames
