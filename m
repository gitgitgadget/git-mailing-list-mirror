Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D982DC43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 13:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC56020663
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 13:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kawSB3R7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCYNwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:52:04 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:32992 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgCYNwE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 09:52:04 -0400
Received: by mail-pl1-f171.google.com with SMTP id g18so840286plq.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 06:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vY/JLAy5HaYTMnf/ZWPUFQYL5jN2CXekN9tDBrYng10=;
        b=kawSB3R7KQ6LAjb5joUjAyoXSTM+3zgFKE50cnEY8ZxcKYxOTYqNrUge5zslnphz03
         dFzTVyPAMPr0sR5L1YwQxDXrrr8izzDSupdZbPbc1F5UNNwKRoQERGj3A/2KFAjtb1C1
         3IgIJZgyu4sV1RE7L/r4VTNw0kV/c/QttH+EcbmyHbCriZQWw5Sw7rTWoASyj5kFv4u1
         iv2oOtdAyMaMMZIEh0uhwMuVmEyugk3XpPpC//WfN6wIINEU82koTZjnYIi4+hnG+/7O
         X7T1f4vvDuVdssBmE681MGoYY/1p3RrUSIBVgBzzKycd6fM5lhCf3euS+ywctwPfVqtS
         hhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vY/JLAy5HaYTMnf/ZWPUFQYL5jN2CXekN9tDBrYng10=;
        b=piutzC7atMPRvPwky7FZ2kgSraDLZCuhfHGWYqRpAFeY7RAcTNxXjql3WnR8hNiino
         DxUS0rHx0SX2ixaPTzBbgvHnKtObNjhQZ7UwLR5+ar/KZIoHODUhto6WU3jMBoxpD0Oo
         +yy2kzXqDDnmx3x2hL+bN162nkW43MrRFCAE3l0GtVaNLK03g+ISZ1Ci7mvrWrXID3Dc
         wpyb4t3Sb9P/5tHGoWrUmtxptwz/QDlzenVsh0446SullRdxeO23MQdr2wvAc9C935nT
         lS0pU62N4hRjaC1TkbVgAyyJ9TuIj+JGIEcZ7A7fbfcgnhfF8BtFW6fBm6KLemGDm2Br
         aAZw==
X-Gm-Message-State: ANhLgQ34d99ithFca34DPkPeZu4njgg74xIWiClZ0IPCmCLF/o0MrijN
        nfxKUTR+9xPUo5MvC8D9ZRsC7e68cuc=
X-Google-Smtp-Source: ADFU+vtiQlI3pgTw55n46uxAvh4PXy7bMFGQkCdXramWQ4P15wV3UEtfZQSAycp5XK4YhaD6yAwg0Q==
X-Received: by 2002:a17:902:b586:: with SMTP id a6mr3332404pls.239.1585144323221;
        Wed, 25 Mar 2020 06:52:03 -0700 (PDT)
Received: from [192.168.2.6] ([43.247.159.138])
        by smtp.gmail.com with ESMTPSA id j1sm18555016pfg.64.2020.03.25.06.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 06:52:02 -0700 (PDT)
Subject: Re: [GSoC] Query regarding Microproject
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <CAGNOEmugZDWpvAHsOzmm_Fqo_Vj5GcC--GfTg3JHPm701HjBXA@mail.gmail.com>
 <CAP8UFD2bgzvc2K2Sj4HSeXo16kB8D8se=+=Y7gp6FN+4Y3C1BQ@mail.gmail.com>
 <47a1db25-914a-2e59-c0a6-6d0ff77bc2aa@gmail.com>
 <d676674d-7ab5-b476-8dbb-2b3323db2c89@gmail.com>
 <CAP8UFD3fAQyiXsO0w_uG6Oe8EfvkL6=ijUqHp4j8GD8A50Jo+g@mail.gmail.com>
From:   Shanthanu <shanthanu.s.rai9@gmail.com>
Message-ID: <165cc039-2092-2520-e23e-5734fd3fc0f8@gmail.com>
Date:   Wed, 25 Mar 2020 19:21:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3fAQyiXsO0w_uG6Oe8EfvkL6=ijUqHp4j8GD8A50Jo+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 24/03/20 1:01 am, Christian Couder wrote:
>> So shouldn't the test file itself have mentioned (say as a comment at
>> the top
>> or in a separate README) that it was expecting subversion 1.8 or lesser on
>> the system? I am using Ubuntu 18.04 and by default the package manager
>> installs subversion 1.9.
> It would be better if the test could be fixed to work with subversion
> 1.9. Otherwise the test could perhaps check the subversion version and
> run only if subversion is version 1.8 or lesser.

Yeah that makes sense. I will try to look into how the tests can be
fixed to work with svn 1.9.

>> This issue might also be present in other git-svn test files. (I haven't
>> checked
>> though, not sure how to run just git-svn tests)
> Maybe with something like:
>
> $ cd t
> $ prove --jobs 8 t91*-svn*.sh

Thanks. I ran the command and found that all tests (except t9119) fail for
svn 1.9 and pass for 1.8.
t9119 gives the below output for svn 1.8:
skipped: skipping svn-info test (SVN version: 1.8.13 not supported)

't9119-git-svn-info.sh' seems to already have the code to check
the version of subversion. So we could use the same code to check
the correct version in 'lib-git-svn.sh'?

Note that I haven't checked which all subversion versions work for
a given test (only know that svn 1.8 works for all).

