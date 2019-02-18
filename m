Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C321F453
	for <e@80x24.org>; Mon, 18 Feb 2019 19:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfBRTl6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 14:41:58 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34313 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfBRTl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 14:41:58 -0500
Received: by mail-yb1-f193.google.com with SMTP id j62so7229406ybb.1
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 11:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d96iHWSvQUGWMlC3GKCyKlisF+VJNmGwVyRV6oNw38o=;
        b=X1iycLEWzmoHqcg5WRVBpPOk+837QCXk/RNJiBUxho+czjg1tceqI4eCYesYwOrw90
         q3Feho5p6K6ELElhoXzGzOBhm/A4OTPen2QuJIZbQSSRPrmSMIsAHqm9+hPR6+v/nCrg
         RP0yE/QNEX4ZQNhYPT+yWJK1MMksnEP1haOuh8bZmXKtqh/K6NSekjTl0aqh7fFJNbTB
         lhCR5YKQE6d52cGEv57pPiNm6SBaMs+UDFLbGOdviKVVTllIXz77LzVjOu7hbK2+n6Fp
         JHBoDnXD6Nc5kh3WmLc4MGz4flMhRj96q0gT9jHnHezTLHv8Tt48OMVnuTP39NHru7gA
         NcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d96iHWSvQUGWMlC3GKCyKlisF+VJNmGwVyRV6oNw38o=;
        b=KWj/XVI5YMKMim7TQxA5VJwNsY0gKXLe8gsZWBz09qxrou3l4Ac6mEisHdeFeBjIEK
         hGRd6zIG4IGOtcm6OBFaCpnml1FABIC3qi21nmKrOSraqTLx2eg+FkU33/daiyEX7QQR
         jxmyTn643flvxc2ueQbBduCUoJV2rB6hs4Fawj4pQgcz5j85mJWcPMYsJc8kOgyIZIn7
         BdC9pv9pV0Ma9X/mqcUICG+uUUdVR6K9XQTZTvKgEMqFiV6SdHvToukr08WyEtHuY0C1
         SO/1EVHtW5Kg87fgMS4n26MJxvPEeWf6QBg982Dixkwl0XMcI8Bg6JzNrb/pdCsgvCMb
         YWRg==
X-Gm-Message-State: AHQUAuYBNYAt7wY0bMxAHjmU//Xi541EbZsFNDjCFSd65WdwtqYhrRMc
        C1RirFQiKuXO32Y3iMCta+l1J5Kh
X-Google-Smtp-Source: AHgI3Ib/z3bqXIEz17AF9kxluqIPIdgcUIhxPwCXSaKnJoJPaxOvd4DCWWwIatsm4qc9DkNTVBQirg==
X-Received: by 2002:a25:6b0c:: with SMTP id g12mr20797168ybc.217.1550518916994;
        Mon, 18 Feb 2019 11:41:56 -0800 (PST)
Received: from [192.168.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id i188sm5666511ywa.88.2019.02.18.11.41.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 11:41:56 -0800 (PST)
Subject: Re: How to get next commit that just after a specified commit
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org
References: <87mun0j9vv.fsf@evledraar.gmail.com>
 <xmqqimxnbdfq.fsf@gitster-ct.c.googlers.com>
 <87ef8bjrqv.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8f4bc4cf-cfe4-ddf5-cee3-294ebc5fc88c@gmail.com>
Date:   Mon, 18 Feb 2019 14:41:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <87ef8bjrqv.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/13/2019 4:36 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Feb 13 2019, Junio C Hamano wrote:
> 
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> Their point in comparing it to git is that there's nothing intuitive in
> the UI that exposes this information for the *current* graph, whereas in
> fossil this is a built-in command:
> https://fossil-scm.org/xfer/help/descendants
> 
> Perhaps this information is cheaper to extract these days with the
> commit graph and we could expose it somehow?

I believe the recent changes (collected in commit-reach.c) that improve
'git branch --contains' or 'git tag --contains' are important in helping
this descendants list. There is likely more work to be done to show this
list in a rev-list call.

Thanks,
-Stolee 
