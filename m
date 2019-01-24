Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9DA1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 19:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfAXTSy (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 14:18:54 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:43029 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbfAXTSy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:18:54 -0500
Received: by mail-qt1-f170.google.com with SMTP id i7so7946698qtj.10
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 11:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TPMuiMC43Z9SZBF2XadKMbCD2znyZnGKdz9sPCnISZY=;
        b=hriXhFc44sgErrhf+XnBQBja3UcgI5E9fGGwYzRFEgockNV7m1jJFP4xyZYXAuG4gq
         IadiXKr4rH1MZtHJQmvr1hRZkrUgclNrfdXx8eQXZWzWkO/9O8NdoaR5p6C8bRARFJMc
         6hHimoutOTnfeMTgFrU/IGP07Ea7h7KASVW4w8py35d8XHlQ0PBhUKI6rJ4oKdRSbyLk
         gAv1UQGSYOJFFVm1sNaTljAGCI7g87PlQj20N/VOW99cAaIUB5/BfmjL1ciGIM8W7lkr
         XkMm+jsdIBDms6L0UFLphSTSlXKzDnodrSLC5CkRp+SFvqc7/DuqMqhjvNP4LxA/0/1I
         f1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TPMuiMC43Z9SZBF2XadKMbCD2znyZnGKdz9sPCnISZY=;
        b=Pg1c5cSh5z02NzLx+XOYLe+axbJ08vvEHMH2iQkMbVUsQZ52My2SUz36bnxW3t+oDn
         la449VAOO+QxFyHKbY4lQCv92+MXnVEbTiwtw5nKQ93C8xCaMNZwucDI09pm0Cd/1QJ8
         P/NuE/XgfLT4zxm0JBlnrTludCFeaeJvD09DR2L1vH6ge7Xearkv9xaQQfqTT7yMnUU7
         qLxIKbNrhkkg/Gk5p1lrtZDsa5kaQwJ0upohvEZd2seHMOugX4PrcVnD3yHzGNCCOXPz
         s2n9Rbe1rvN8ni3cZgHnRB+5ZbjeH1mpT3fUeMHWMJTulEVfUOrrm5DfBGkmutacTZ4J
         mJFw==
X-Gm-Message-State: AJcUukfqmNl+2Ey75Rvpr5nfqjKWUWyWMCVKDMCC2rLWE4my542uCnVW
        NX19aLcx9br7Rqcf7cXgkOm4tdJY
X-Google-Smtp-Source: ALg8bN4LqPRyH9WROtdyvE93w8bcOE/6eAJ0UIFJd/zBSfoJsDhsNY0nHHs4YY/sRGgicoJF6ymEAA==
X-Received: by 2002:a0c:e105:: with SMTP id w5mr7241598qvk.234.1548357532985;
        Thu, 24 Jan 2019 11:18:52 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:a010:321f:4bbb:82c4? ([2001:4898:8010:0:8946:321f:4bbb:82c4])
        by smtp.gmail.com with ESMTPSA id x5sm74322519qtc.43.2019.01.24.11.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 11:18:52 -0800 (PST)
Subject: Re: Git Test Coverage Report (Sat Jan 19)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <6addc879-a792-202f-2aeb-7097ea344894@gmail.com>
 <xmqqa7jp53d2.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7aaec7c8-6cf9-fbd5-fbaf-60b110e2bac7@gmail.com>
Date:   Thu, 24 Jan 2019 14:18:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7jp53d2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2019 1:15 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> Here is today's test coverage report.
>>
>> Also, there has been some feedback that it can be hard to manually
>> match up uncovered lines with names at the bottom of the summary. The
>> suggestion was to auto-generate an HTML report that could be posted to
>> a public page and referenced in this mail for those who prefer
>> that.
> I wanted to "grep" for lines attributed to certain commits that
> appear in the list, by filtering lines that begin with enough number
> of hexdigits, except for those object names, but the attempt failed
> miserably because of the line wrapping (which probably comes from
> the assumption that it is OK because the "text/plain; format=flowed"
> would not care).  If you can keep the long lines (due to the object
> names and line numbers prefixed to each line) unsplit, it would be
> more useful to locate and isolate lines.
This is likely more a problem with my workflow (pasting the report into 
Thunderbird and sending) than with the content itself.

If I instead created a text document and sent it with `git send-email`, 
then would the line endings work the way you want?

Thanks,
-Stolee
