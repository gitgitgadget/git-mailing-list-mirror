Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 061DF1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 18:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfGASrk (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 14:47:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37441 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGASrj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 14:47:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so11871129qkl.4
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+FNzhor+C05GzS8/7N5AnRRAXAiwAj+nnegmjmJDIZI=;
        b=UiMhMgGrU2n5fy2JNGBV9hMopick0yQo6jS7Rwx2yaGNMyMfDTEhY2Oyz1g7RftR+c
         pAcxI0MfugqFPliDLfkf5Skl1/mfi9eADxGunF18sOdwR/piqDoFIXRSuvX2aTzI1scy
         QAt/BkZAxt39ihVb5yfwvsmwikryiPpq7ZpRL1m8T81QLN+aqeQARrcTHKakg6zwUHq1
         twEk/JPxYKtoox3kR6jkRyVfrtOwMCFL6tlTzx4z4o+eweBZzMiLD4GR30C3OHyW/MZu
         jJ9rZymmGopTDUDqASToDHh3YX5xxvoRHD+w6KiL/0qEjX7lxb7SX8HgkZP+N31FEajy
         PK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+FNzhor+C05GzS8/7N5AnRRAXAiwAj+nnegmjmJDIZI=;
        b=UqGItFy3g4dfv0WLu9LFSi2iAeBp5GKQSlfvu6uVoVKPGff7jKUN9bVYIZsRxXjLEc
         s7k+azqAFIFRpyWnbut562uOhObVEMLvAk5NUe6RltQGcXBOdSqmJml90ByqSAZ74rcl
         /WEHwIGwtHV/j7PM4eD8wr6sKEx1MyTfE35HWceiUqqSfhMSTo7iW33XP2m+TtFfuR6G
         wz4iULKK9US+EcriRCdHcveUR4WZ3sEpy1InR30rvij1pcSusdUNzHAynfCTMlfx/HX9
         HR9lBP8L3nLCuSilJ9MgmlSCKftF7w4i7l3upcsTKg2ZtutZeRzY+WtZwaVu+LVpl5zo
         KlzA==
X-Gm-Message-State: APjAAAWypJbcm/LjvWiAciVnrH22bZvYry7nPEa7xNvSVJnjBQNNSuAF
        o+9/KDSC0iyGoCdu4k1QrzY=
X-Google-Smtp-Source: APXvYqzjNazsemodo3ISkDoFNEWGi8K+VdK4TgqPhfk/qMc7WGdliijs02lk6apgEcmlyd9RLCmN+A==
X-Received: by 2002:a37:6982:: with SMTP id e124mr21181253qkc.291.1562006858785;
        Mon, 01 Jul 2019 11:47:38 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:858c:78f0:58f6:666c? ([2001:4898:a800:1010:36c2:78f0:58f6:666c])
        by smtp.gmail.com with ESMTPSA id o54sm6114998qtb.63.2019.07.01.11.47.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 11:47:38 -0700 (PDT)
Subject: Re: [PATCH] t5319: don't trip over a user name with whitespace
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.261.git.gitgitgadget@gmail.com>
 <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
 <CAPig+cRpOHRgtCXXiqAZtmEtkWnMy7=4GsTVv0XB9R3fF0-66A@mail.gmail.com>
 <1a5bb5f9-e090-7f42-ec3f-cd74bcad831f@kdbg.org>
 <20190630222537.GA21696@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1907011409420.44@tvgsbejvaqbjf.bet>
 <b1f6a752-6edd-d86c-7d69-7624a2c5407f@gmail.com>
 <3645e8cf-3538-7a4e-a54a-f58dc39510e1@kdbg.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f42b441e-b6ff-464a-6351-739993472ca6@gmail.com>
Date:   Mon, 1 Jul 2019 14:47:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <3645e8cf-3538-7a4e-a54a-f58dc39510e1@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/1/2019 2:22 PM, Johannes Sixt wrote:
> Am 01.07.19 um 14:30 schrieb Derrick Stolee:
>> On 7/1/2019 8:11 AM, Johannes Schindelin wrote:
>>> Or we stop introducing new Perl calls, and use the perfectly fine
>>> `test-tool path-utils file-size` command:
>>>
>>> https://github.com/git/git/blob/v2.22.0/t/helper/test-path-utils.c#L302-L312
>>>
>>> This solves not only portability problems but also avoids yet another
>>> obstacle into making a `NO_PERL` test suite run really work without Perl.
>> Thanks! This does seem like the best option. Thanks for bringing this to our
>> attention. Here is a diff, and I'll prepare a full patch:
> 
> Thanks. Please also explain why the first of the two tests does not fail
> with a large --batch-size (unless it is obvious for people who know a
> bit about multi-pack-index, of course).

Sorry about missing that. Here is an explanation:

The --batch-size=X option determines how much data we want to move in
a single operation. Based on this value, we select packs greedily as
follows:

  1. If a pack has size at most X, include it.
  2. If our total pack size is greater than X, stop.

At the end of this process, if we have zero or one packs we do nothing.
That is why a small size does nothing.

Also, if our total pack size is smaller than X, we do nothing. Our
batch is not "full" enough to merit the work. This is why a large size
does nothing.

Thanks,
-Stolee
