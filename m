Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311D31F453
	for <e@80x24.org>; Mon, 11 Feb 2019 17:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfBKRMM (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 12:12:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40824 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfBKRML (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 12:12:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id q21so18090746wmc.5
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 09:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1+nyMQA+YuvGkujl+8TILf5s1qX3yRl69jbaYk8bVZ0=;
        b=r5tFiqgYgrxUp9ETFeZZAtbnq2felekUX5Io7Iy+7SdI3cLoyiLmhwV2WTu4FtSG5D
         AZKeJvBExg5TZWyw2e5VojiESevLzeqySgTKFGAG/IpHcjbWZzA1Qg7Ypq9Kt+rPg5tY
         8Bica8c4cboZitCKmFwKjLnZud81ANSPlMSMWLG2ztd3JgCY+63vUBa7mCorb0XiOqDc
         D6UpXaA2W1XT5Y+QAUJbeTfwFlQS7TyfsLDonWvcHmQKWcKL6sGuxx1HVoZu2iTsqp2r
         OuGqZNGmnxSw5Fl0RGEaGrM7IPw/5xNHx0n0gVLGRI2l2SPqzDG/ReA6qk3BxjF+ORtZ
         za7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1+nyMQA+YuvGkujl+8TILf5s1qX3yRl69jbaYk8bVZ0=;
        b=WxQ+OA0RXComCLcEgX8ERnnE+Na1EqC9wP2EoSTzs8/xBELfHDUqOJk6TzPOXvqvJq
         4FhZ/zY8IDGntjCiVXdcMqJePxo6ZvqceM7m+eA5Ix9xyR3mpD2usSgvPHGTk0tEra5Q
         qynX1vDc2NMFvU6REviPPfX5zSA3kUCivRgqezxZel00Zg/zot6/QeAeo+Ymy2E5aale
         iZw8pKE312D+yO3iWFzButP4okyMFxZEoLLo7D7mjoqnnfywKhwzQxArAxesLrjKAiN9
         0zB9TgqKYsVBjH1+Et3pHQB5Mpb+3CyBQ8B8VffxFQ4rTYU7XQZ//tUMRfCEloqAs/qJ
         QkSw==
X-Gm-Message-State: AHQUAuZDjWPhcs1As9GJflTTavKsKGns7DUJyc1DkYTfjh0EIWZAyIR3
        lhxnILcYlKbGPgXqw1W87/iBS1M3
X-Google-Smtp-Source: AHgI3IbI7rO0nqd5EwjPt6ehQHNSxcS1KGTD8bIM3fpiPTV6/YrN8kYsxoI7TYIKCxITm1wdyN/QaA==
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr364339wmb.85.1549905128850;
        Mon, 11 Feb 2019 09:12:08 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v1sm22087153wrw.90.2019.02.11.09.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 09:12:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/21] nd/diff-parseopt part 2
References: <20190207103326.10693-1-pclouds@gmail.com>
        <20190207184300.GN10587@szeder.dev>
Date:   Mon, 11 Feb 2019 09:12:07 -0800
In-Reply-To: <20190207184300.GN10587@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Thu, 7 Feb 2019 19:43:00 +0100")
Message-ID: <xmqqo97ii714.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Thu, Feb 07, 2019 at 05:33:05PM +0700, Nguyễn Thái Ngọc Duy wrote:
>> Nguyễn Thái Ngọc Duy (21):
>>   diff.c: convert --patch-with-raw
>>   diff.c: convert --numstat and --shortstat
>>   diff.c: convert --dirstat and friends
>>   diff.c: convert --check
>>   ...
>>   diff.c: convert --no-renames|--[no--rename-empty
>>   diff.c: convert --relative
>>   diff.c: convert --[no-]minimal
>>   diff.c: convert --ignore-some-changes
>
> Nit: convert to what?  Perhaps a 's/$/ to parse-options/' would
> improve the shortlog/oneline output.

But that would be hidden by getting pushed far to the right.

I am wondering if we can do something clever with the <area>: prefix.
For a series like this one, the shortlog output may be better off if
a short token that clearly identifies the topic is used there, e.g.

    diff-parseopt: convert --patch-with-raw
    diff-parseopt: convert --numstat and --shortstat
    ...

or even

    diff-parseopt: --patch-with-raw

perhaps.
