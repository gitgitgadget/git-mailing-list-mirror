Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED5E200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 08:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755311AbcLZIPO (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 03:15:14 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35904 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754712AbcLZIPN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 03:15:13 -0500
Received: by mail-lf0-f65.google.com with SMTP id t196so8143078lff.3
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 00:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0v83I4ftIoO5M3entJrz92knOvlwWcGYNhhfg2+i9ps=;
        b=qw16foxRVuIkhUzGXJljOHAH5KzPUaPSG8jf4b3mVj/xIzn+iIh8vDAUtalsSwUvJz
         jqdZRVRfFhWz22/t18Buqw0QBwHjcuibeomkUOXMdhba94jUeR02jdu9PzsTk2t/LknM
         5sn3kvLJwe9JaGKUXN+X0ZEzmbREs/QNdx1WWmXKc0saSwhtqUmLvLriNFp1QOoBhxKq
         CcXZ1x4Z6MuF/npt+GhSlP5l4AlyGoLPqLjHhtPp8QAow+/rq/OjycyQPl2hQTBuORFW
         ytarIG/jtOl69t9FEAXB8W8+O+i4d5aXchkZ4iRuojSoaAQPPQmERE5vDi2AVVBN2MEI
         FPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0v83I4ftIoO5M3entJrz92knOvlwWcGYNhhfg2+i9ps=;
        b=XzkKEpVW0j12HBhf+V6797U2znMLLIs4MsCVAzHZnLErUzrKgecaLqISW66M6/CZeZ
         7/7e/OiTlHJVIRbSWDdEBz7DlykGaoSBLK2UNKQgkI4TkUbnWEp6tUxbKvlkmjgm/Dew
         zbrf8ju3iPcX0ASb2vfo1Qsx2L844REs7fYHpUPICw+GtRbM3pHp4LWXPT4Tu28j+Okq
         MMGKAQjji19rPkadQM9LR0yn60sUKkw+pfCd3euKFcQ/HETIqWZYjMvB1aBZ1wA3JH3R
         XLj/pr8h81ps99R1JE2EKnTojwf0L1qrMguSCgpTxhJBOw4EEU5hXycF1LLoe4nbPj+/
         68DQ==
X-Gm-Message-State: AIkVDXJvJL1jBx2P593WsLuyNUDlFiEuzY83eH6xgYvQfQiXZudG/onKkmB4ANCLEuqbaL8OJsCCaRKfYwM2Ag==
X-Received: by 10.25.99.73 with SMTP id x70mr9436686lfb.81.1482740108662; Mon,
 26 Dec 2016 00:15:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.152.13 with HTTP; Mon, 26 Dec 2016 00:15:08 -0800 (PST)
In-Reply-To: <20161219111442.GA24125@ash>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
 <20161217145547.11748-3-chriscool@tuxfamily.org> <20161219111442.GA24125@ash>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Dec 2016 09:15:08 +0100
Message-ID: <CAP8UFD0MWm_VNC=8Cyz4UgD1-DWM3D1JUY2YPh=9AwnXJRjufA@mail.gmail.com>
Subject: Re: [PATCH v2 02/21] config: add git_config_get_split_index()
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 12:14 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Dec 17, 2016 at 03:55:28PM +0100, Christian Couder wrote:
>> diff --git a/config.c b/config.c
>> index 2eaf8ad77a..c1343bbb3e 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1709,6 +1709,16 @@ int git_config_get_untracked_cache(void)
>>       return -1; /* default value */
>>  }
>>
>> +int git_config_get_split_index(void)
>> +{
>> +     int val = -1;
>
> Is it redundant to set default value here because it's not used
> anywhere? The "return val;" will always have the new value from
> git_config_. And you don't use "val" in error case.

Yeah, it is redundant, so I will not set the default value here in the
next version.
