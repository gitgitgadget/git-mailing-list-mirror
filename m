Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E471FCC7
	for <e@80x24.org>; Wed,  8 Feb 2017 07:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753808AbdBHHpU (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 02:45:20 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36536 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753800AbdBHHpT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 02:45:19 -0500
Received: by mail-vk0-f50.google.com with SMTP id t8so95296255vke.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 23:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GlhumNiGAO/J/HjKeOewQKiSTFpyIaB+zLKjs6G3GAM=;
        b=EzpZ7k6a1F52B5HIdGPem7tfp/Vi27t5zAmJudOVKZ4P3688L2L6HWAJswKd9Z1vBv
         k730g4RGeOXgLtvT4wQrvQqWXvbhvddWQCtLNj32oseMK0J/aBx87LI09B7POhx7w/ps
         QiEmjqU3vhVphuGcbe9+DgYKmXUdV0MdIm2VL2qnkRtIIJnUCanONl6yZNT7lXyYMkLH
         P6/0a69Cp17VP6FNVUa+TgeydpDn4U+IE+KwrLGUG+hF3OJrZJufZmpvPlaRhq0Bcon4
         lJA/YF+KPEfrnEyikdtWBEvxK6Go7S+X5cz+gVPa4hlXZoVZoKbQy164xAW85ae0CpJj
         fZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GlhumNiGAO/J/HjKeOewQKiSTFpyIaB+zLKjs6G3GAM=;
        b=p52dvmL0jqi6xMLL9dPRr3mKNSinuxehxZTZsJHtfkFS+96sfV0k6QjkUV/jsFGp79
         Dp1jKI94pRNhWLuRo4TJICfHEiUluEPECFWRnXXWPtOPvE6dI0aOL99Wp3pCpTM/c9GJ
         efZbecgLGHqvP5muaH4VKB7+qG9rMURbTgkDWhNFEiG8j9Vfunt06tBwtSltlgYwCO7A
         +6nxJ2ASRQ5vOz++2FbqEmeqryx39a2g9Z0X/SQUyDt/rkmo2UpGgWIIiImDsE8ejDxO
         dYw0OnKcd5thzzL+QzXojonp1Ehlue3cuHabRj2sGIvCf86IhYvnH92pkrD+MtAyUzgg
         ocyw==
X-Gm-Message-State: AMke39mZq6pPRssiP94xKrW1CcI+V5Oh/71ZJVWWE2yz1paRXk8DvU/uzm2/I0kHWPwjRgVFaFRHAqLfD2+Z2A==
X-Received: by 10.31.115.142 with SMTP id o136mr9437772vkc.139.1486539900386;
 Tue, 07 Feb 2017 23:45:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.34.48 with HTTP; Tue, 7 Feb 2017 23:44:20 -0800 (PST)
In-Reply-To: <CA+P7+xqg9b+49P6bO65E0q4a87BkNL76XGiUjcMg+UmDcU=WPg@mail.gmail.com>
References: <CANOj2JG5VuDtS30PfOrZ=4q8pTv_frY7=p+0g=UW3yV6ev+1KQ@mail.gmail.com>
 <CABURp0qbKMfngfsC5pQeO+qyRPxa21vi090hMWDtLd+BBH_3Jg@mail.gmail.com>
 <CAJZjrdWbqvBRtyyfhgAt1E9ZdTUaz+Zpk7iGasNoeSuFJbsKog@mail.gmail.com>
 <CA+P7+xoZHOtURfbBbHHTpC3DsGxaGOVToqmW5wTg2EniRpL-Cg@mail.gmail.com>
 <CACsJy8CWJvwSnmdpMg=atu+M8=4ksrTAYTgZyF5U7JnOCnPAkg@mail.gmail.com> <CA+P7+xqg9b+49P6bO65E0q4a87BkNL76XGiUjcMg+UmDcU=WPg@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 8 Feb 2017 01:44:20 -0600
Message-ID: <CAJZjrdU1qz9H5P0uB-PnpN_WoEtRVA9SQN_5pBPJzvzsYVby_A@mail.gmail.com>
Subject: Re: Request re git status
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Phil Hord <phil.hord@gmail.com>,
        Ron Pero <rpero@magnadev.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 12:30 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Feb 7, 2017 at 10:13 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Wed, Feb 8, 2017 at 2:18 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>> Personally, I think that the fact that Git forces the user to think
>>> about it in terms of "oh I have to fetch" instead of that happening
>>> automatically, it helps teach the model to the user. If it happened in
>>> the background then the user might not be confronted with the
>>> distributed nature of the tool.
>>
>> I agree. But I think there is some room for improvement. Do we know
>> when the last fetch of the relevant upstream is? If we do, and if it's
>> been "a while" (configurable), then we should make a note suggesting
>> fetching again in git-status.
>>
>> This is not exactly my own idea. Gentoo's portage (i.e. friends with
>> apt-get, yum... if you're not familiar) also has this explicit "fetch"
>> operation, which is called sync. If you haven't sync'd in a while and
>> try to install new package, you get a friendly message (that helps me
>> a couple times).
>> --
>> Duy

Arch's pacman -S sync operation also has the -y flag, which updates
the local package databases, and can be used in conjunction with the
-u upgrade flag to upgrade repositories.

> That seems reasonable.
>
> Thanks,
> Jake

To be clear, I'm not advocating changing the *default* behavior of git
status; I agree that it wouldn't make sense. And although personally I
constantly update remotes manually (to the point where I abhor using
pull), I do think there's room to add an option to "fetch the
remote-tracking branch" to git status.
