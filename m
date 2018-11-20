Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B40C51F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 15:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeKUBbY (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 20:31:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43046 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeKUBbX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 20:31:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id i7so284925qtj.10
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 07:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=igCbH9WWKApdNX0w0W81c49+wlEY6ent6uFu45uSYMI=;
        b=aX8dLeQgGd+QECyjSxTMrAltH43LwpCwrW/n8+8xpIUVM1qjo5VyDJUjb0U5KjVwnh
         3kyk+HtonFXf4GtiBl2QTPFCRF5AWItWFHBnTtM6TbnOgHCIRO20aaI9Ik05P0VkfYhN
         42N1hrU3HU0ZtrhJjRfB5sFVJYSyF1tDHPWmkFvAkMRAbkdwwcE30mXlsuVXbIJnxFbQ
         J+gzl2KZi21mluLvvsiKOT9jqrPo5q/TXgmg/qNKzi6iB3zaSeb4Tk+//F1NL/Fi8a5H
         4egd3hPv4JlRkyEQsOh4mUX69stMadPOLy5HXMlhwso1XPqJfZZZdRx0QmemqCXaetVB
         Rk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=igCbH9WWKApdNX0w0W81c49+wlEY6ent6uFu45uSYMI=;
        b=LOgtUc4CVKNTSpRKBCQxyrdnWIsQIwaOR3VOFOw4SeqZmjRqfAGBYw+5aCX/SZZqXd
         bRov3mVEg/vObbyaS7VgXBpx3YwWBGEz+LjZERwa3MKxxbgoE8RlYAZI90NMnYmPKglB
         5fKvL7V+TtgLOqCHBQMldFg5QOWDTxFSfFQZ6OmZnsK87E7h8gAYM8MDsLnzfX/0d+KP
         9yV3uWFePF6EKvsU2TBYmDgaopnwPDfrtiP/9nscLUGRVNsoRXHU0ZNMpj0DoOOJuW4C
         0YKM5k6v+V4JovgUKa+qCdgoFN43JXUO+B42fLn+0BR1zWQ7mi/1aNDBN8hvRrQkcFYC
         ooXA==
X-Gm-Message-State: AGRZ1gLPXZM06W49o2sGxOL1yTeboBouvHAlPOuBfjNR15jWdMEBKL/x
        7JQBTW+sq2RfK2jCkBg4eZk=
X-Google-Smtp-Source: AFSGD/UOl+59ztCNfn7+1/o6lNT/3o8FGLBiuvqB+h4yjtuExIbLdBIMBKLYIxJg06CohbAWC7r2/g==
X-Received: by 2002:ac8:45c9:: with SMTP id e9mr2204116qto.273.1542726108594;
        Tue, 20 Nov 2018 07:01:48 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id w22sm21454033qtw.71.2018.11.20.07.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:01:47 -0800 (PST)
Subject: Re: [PATCH 1/5] eoie: default to not writing EOIE section
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>, jonathantanmy@google.com
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com> <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com> <20181120061147.GB144753@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <7a3bf106-a8ce-c64a-3015-d8543feee4d9@gmail.com>
Date:   Tue, 20 Nov 2018 10:01:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181120061147.GB144753@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/20/2018 1:11 AM, Jonathan Nieder wrote:
> Since 3b1d9e04 (eoie: add End of Index Entry (EOIE) extension,
> 2018-10-10) Git defaults to writing the new EOIE section when writing
> out an index file.  Usually that is a good thing because it improves
> threaded performance, but when a Git repository is shared with older
> versions of Git, it produces a confusing warning:
> 
>    $ git status
>    ignoring EOIE extension
>    HEAD detached at 371ed0defa
>    nothing to commit, working tree clean
> 
> Let's introduce the new index extension more gently.  First we'll roll
> out the new version of Git that understands it, and then once
> sufficiently many users are using such a version, we can flip the
> default to writing it by default.
> 
> Introduce a '[index] recordEndOfIndexEntries' configuration variable
> to allow interested users to benefit from this index extension early.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Rebased.  No other change from v1.
> 
> As Jonathan pointed out, it would be nice to have tests here.  Ben,
> any advice for how I could write some in a followup change?  E.g. does
> Derrick Stolee's tracing based testing trick apply here?
> 

I suppose a 'test-dump-eoie' could be written along the lines of 
test-dump-fsmonitor or test-dump-untracked-cache.  Unlike those, there 
isn't much state to dump other than the existence of the extension and 
the offset.  That could be used to test that the new settings are 
working properly.

