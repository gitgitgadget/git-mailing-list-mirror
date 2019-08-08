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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5207D1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 19:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405023AbfHHTMl (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 15:12:41 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38127 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404713AbfHHTMi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 15:12:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id u190so6085281qkh.5
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fxGf4poNKczUS34aYXadOMzULCOC00vsTXLRsADoy/I=;
        b=MczoAqMXZG7C5qr9WDRf1eEVzmxTEJmuusZ6wph0kdjDXAuV5Bt0ia0gD4Xh0bYdkG
         sXEY0v4e6aogxEjYRU3m4zN5HT95DwL8pLf1eFp0/0YWXiV5kmAftktwum4VlGyIKi4u
         PBC3iTjK0lbbJ4pEXKCpsOGAX5Ww7HGi9SPoxbpGIvL+HUTdklhRPQISgBla+yxXqwqb
         s8VmacgipJQil9hIf34bFVLjybQ9J5R7xHVbnEctx8YKNW62CHobrU+4bgcIziEm+0Hf
         AgrNkzpl/78pIanpW6sFmR1h7iK2k7nGN4SnHX+SvcJZj0xscpdponqqAfKS5ojM3C02
         8mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fxGf4poNKczUS34aYXadOMzULCOC00vsTXLRsADoy/I=;
        b=aHebwPEpLvVdO9tWf7u6utVEsoNkKOlRzJz8sNApgJo2xuabeetZHfV6vAADLfLpJk
         6qWhuNVTzx0+4blD2CGXpQSXLxR6GYTVtzQtYkYE/bpeOa0pQSD/bApzdiFUh5CX+hMc
         SXvfMrp9f2cRSDz//RbXBn+ZMU59/tCHoI/J/Hzk70DZzW5GjYg44l6kFCGSgM/wlMne
         quIDfrYy905lmg6QX0IVNOugjjkpzS9Boqwa2U3YLZ5nPSKpU7LcaNviwz8Nm9EWBfmZ
         svRel/kte1hTjcPZ7obtY/Vp5mTzQWyReOfPQ4Vuh3n4nauhAOq+wIIo3KJOoYM0HY3w
         g/Bw==
X-Gm-Message-State: APjAAAVurleQQxt1wDrPvmcxngBlrSsDBwQ4D6hSfmatMz3C1sU1k+OD
        LVfAz50e5bDYkDboy6O5KQE=
X-Google-Smtp-Source: APXvYqx4/M79wiy3ruFFsPAmC8z9TUiAtecrzxCPRl3AH6NfkJXOxPWOEpzPVJcmf5RTdLgT0O+Kvg==
X-Received: by 2002:a37:f50f:: with SMTP id l15mr15364692qkk.326.1565291557433;
        Thu, 08 Aug 2019 12:12:37 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7487:521b:1543:4364? ([2001:4898:a800:1012:25bb:521b:1543:4364])
        by smtp.gmail.com with ESMTPSA id b34sm2620698qtb.49.2019.08.08.12.12.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 12:12:36 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] repo-settings: create feature.experimental setting
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
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
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4fe2cb63-2d6c-d8d5-5531-9ea6d624a85a@gmail.com>
Date:   Thu, 8 Aug 2019 15:12:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0hffpoz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2019 2:59 PM, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>>> --- a/Documentation/config/merge.txt
>>> +++ b/Documentation/config/merge.txt
>>> @@ -54,7 +54,8 @@ merge.directoryRenames::
>>>         moved into the new directory.  If set to "conflict", a conflict
>>>         will be reported for such paths.  If merge.renames is false,
>>>         merge.directoryRenames is ignored and treated as false.  Defaults
>>> -       to "conflict".
>>> +       to "conflict" unless `feature.experimental` is enabled and the
>>> +       default is "true".
>>
>> I have a hard time parsing that changed sentence.  Perhaps something like:
>>    ...unless `feature.experimental` is enabled in which case the
>> default is "true".
>> ?
> 
> That reads better.
> 
> But I am not sure about the wisdom of controlling between conflict
> and true with this feature macro in the first place.
> 
> Between "conflict" and "true", the former forces the end user to
> verify (or allows the end user to veto) the auto resolution by the
> heuristics and is always a safer if more cumbersome option.  It's
> not like blindly trusting the directory rename heuristics is the
> bright future for all users, is it?
> 
> I would not set rerere.autoUpdate to true when feature.experimental
> is set; for exactly the same reason, I do not find it reasonable to
> set this to true with feature.experimental macro.

OK. I can remove it from the feature.experimental variable.

Shall I keep the enum logic and the use of repo-settings.c? I can split
them out into a separate patch.

-Stolee

