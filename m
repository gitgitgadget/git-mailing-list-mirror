Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF301F404
	for <e@80x24.org>; Tue, 27 Feb 2018 00:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeB0AAF (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 19:00:05 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:41558 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeB0AAE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 19:00:04 -0500
Received: by mail-ot0-f176.google.com with SMTP id w38so2163249ota.8
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 16:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nWRauJhb/gsHPcK47mTJ+fmiOG9zDZLQ45PpgvmFu1M=;
        b=P5QCa2fTN6AEA6ECawxRszxBTcgg1goNb3SFXjneBuY9uO8CnvLqFujg5sKYyMgy5S
         s9IJ7ckpHgFujiX04I0d0NoraQtOBUh3Qmh5Pj9B7tT8+TtP/sG1SZ6MEVVSB+D1pzWE
         eeqKjqb+uP0scY5EkGVU/RVGcz5QO000EgCY7B0AdKdyKB//47FFRSUFuMO+FkK7AkRK
         WF1VjyItmMzd7zJDJBrM38yJ44MneWgXwm7XAB+JL6ZiKzhHuLco74jLy8tG1sLSi27J
         Horu1GeLFIhr2q7YQRmSRK2ZrphIfO9AqxstB+mJmEmycIh2UA7ntI02NhlEvpsYgC+p
         MJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nWRauJhb/gsHPcK47mTJ+fmiOG9zDZLQ45PpgvmFu1M=;
        b=UuZ1B9PS0eX/fwWYhHz5BtXEsvMhMSGg4XDqLCfIeOB1mxakyQjn7nmqYLf/mTALoq
         VEv9JU1MyEz/W50UN6FFJL4JisWB9wy2NgDokiaxtWbYRDkurq/OwzszlBUUj6/5B4P/
         toZVOVFbJp9MVDyBu9i27TjmTp7DCfpYKooJWwhm+VbzIb1pXQMt9k9IiTN3Axj6M9wi
         KBIPaGDR6/OVr1dV0CbWt++ugQian6/ituAGmvdnQzcRVQfnuIEMdFik3BGroRZQuaLq
         tG3bWZ2xxogR4BdE/Ia6meJ5iw/gDNdaE6DmL5J3j/8g3Jgi5LXu2XJvF/gst9I7UZEn
         6APg==
X-Gm-Message-State: APf1xPBC+4FP+ZORqUuItd1btvSSYdhbR/MuxnvT84Tm6oo9dRQ99NtZ
        VOkd87hsPvJP/kOoGp7AUyMM0JnUijOd+u8MOeM=
X-Google-Smtp-Source: AG47ELt8SfRxWD6xRLlOTN6B6YpJJNRXMv/AxvZdrfaF5nL2oUOXXlPV2LYzUOI23FCVwGz4SeCWGZlpVvTwOZn9dsc=
X-Received: by 10.157.54.161 with SMTP id h30mr9337021otc.173.1519689603466;
 Mon, 26 Feb 2018 16:00:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 26 Feb 2018 15:59:33 -0800 (PST)
In-Reply-To: <CAGZ79kZDhoWWPpoENwvE6esxzdJvTnL4EAxGX5HV=DwDtDOEgw@mail.gmail.com>
References: <20180221015430.96054-1-sbeller@google.com> <20180224004754.129721-1-sbeller@google.com>
 <20180224004754.129721-2-sbeller@google.com> <20180226093040.GA10479@ash> <CAGZ79kZDhoWWPpoENwvE6esxzdJvTnL4EAxGX5HV=DwDtDOEgw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Feb 2018 06:59:33 +0700
Message-ID: <CACsJy8Csr+u9S5hs=jyEqpb3=4zpR8Ap9ks29jV4YFO1eSR5vQ@mail.gmail.com>
Subject: Re: [PATCHv4 01/27] repository: introduce raw object store field
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 2:28 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Feb 26, 2018 at 1:30 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Fri, Feb 23, 2018 at 04:47:28PM -0800, Stefan Beller wrote:
>>>  /* The main repository */
>>>  static struct repository the_repo = {
>>> -     NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash_algos[GIT_HASH_SHA1], 0, 0
>>> +     NULL, NULL,
>>> +     RAW_OBJECT_STORE_INIT,
>>> +     NULL, NULL, NULL,
>>> +     NULL, NULL, NULL,
>>> +     &the_index,
>>> +     &hash_algos[GIT_HASH_SHA1],
>>> +     0, 0
>>>  };
>>>  struct repository *the_repository = &the_repo;
>>
>> I wonder if we should do something like this. It makes the_repo
>> initialization easier to read and it helps unify the init code with
>> submodule.
>>
>> No don't reroll. If you think it's a good idea, you can do something
>> like this in the next series instead.
>>
>> -- 8< --
>> diff --git a/check-racy.c b/check-racy.c
>> index 24b6542352..47cbb4eb6d 100644
>> --- a/check-racy.c
>> +++ b/check-racy.c
>
> totally offtopic: Do we want to move this file into t/helper?

No wonder both Jeff and I missed this program (he didn't convert it to
use cmd_main, and I didn't move it to t/helper). This git-check-racy
is added in 42f774063d (Add check program "git-check-racy" -
2006-08-15) and is not part of the default build. You need to manually
update Makefile first to build it.

Right now it's broken (multiple definition of 'main'). If you add
init_the_repository() or something similar, just leave this file
untouched. Maybe I'll fix it later, separately. Or perhaps I'll move
this functionality to git-update-index if this is still worth keeping.
-- 
Duy
