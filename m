Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044E220372
	for <e@80x24.org>; Thu, 12 Oct 2017 20:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbdJLUUk (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 16:20:40 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:46742 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbdJLUUj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 16:20:39 -0400
Received: by mail-qk0-f180.google.com with SMTP id k123so2639365qke.3
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4fZvQDyS8+D00123FDdgpdDUL9lPslM/uHv685VCf+4=;
        b=VSLiUk50+bPq/EUUUn1BqY0Zo0Nki3wVTU1CHA75QBa4TGzkZpL7vDBK92d0nd/xdh
         nQoIrsFpBNxJpcCngfmN+/xJtN5P6mksKdELiO3TLQEVYmmcD4WBU7P3TaPtBCceiVr1
         /Ja+0uZ3/d+iDeNzg96VHUh22DyG5GtigJGctk1HQA83BTDm3VuNH25Vl2LZ7pThV2ff
         DSp+kTHY4GyIyvgo0OxFaJ1An/l4a4AUZBucGMvQou/iFNlZJ/EgOt0n7oO6teIuvwS8
         mYyG2LrThsbBXoUdm4v5dxESx/4a5idcwzoPK7DwBxa6VUSbAb+aP//W+AH6kr4fgbDx
         FTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4fZvQDyS8+D00123FDdgpdDUL9lPslM/uHv685VCf+4=;
        b=R4Ch3vDyYvB2c47FoI9PyLXsYNguSHnC6aBGmrdRaLyjPxwMv9leQtdEPYL6gA0dVQ
         86ZLvR74mgxeZiVzm8CwB0KyC0ybb2m1AK8TlfFklryiUs0nkxdzd8+byeabD3z6WM3t
         MFYlPq6fOx06fH11ID8vRDIBljZNObYn1yzUq9UAcMQ+aK7YYtMFoH0v+ghpB98/O5QD
         5UMRroFTAcJ8uuWxKkOcnvZYU7LSI0vueE0IgRIZ0Ru7pCYm51PPwQq0UwIYebRFY9DT
         4eV1kYkl7YOK9gubBeLZG8/uDGwAvui+XTKCrQabSvY55GhPBqKz+Xj9jZrlXn6Pw+Pp
         BgUg==
X-Gm-Message-State: AMCzsaWSmMf4KT/J2OyFT+3FFBpzkg1m0bL4Be8lHfQTnwx/8rdT9IeQ
        wJxpFU9gKnPnASfgX8VCptY=
X-Google-Smtp-Source: AOwi7QAp3pW606mwxJKQuZvr25/wvqpcJZCfHOlvOgM38aOoC4fkKV4WIZAfyL36nJCqHLJwvcHLFQ==
X-Received: by 10.55.33.71 with SMTP id h68mr2312496qkh.109.1507839639138;
        Thu, 12 Oct 2017 13:20:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id m5sm9727128qkd.97.2017.10.12.13.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Oct 2017 13:20:38 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Teach Status options around showing ignored files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sbeller@google.com
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171011133504.15049-1-jamill@microsoft.com>
 <xmqq60bl2iyp.fsf@gitster.mtv.corp.google.com>
From:   Jameson Miller <jameson.miller81@gmail.com>
Message-ID: <cdf54fae-806e-c5b7-4420-da66bfcd196a@gmail.com>
Date:   Thu, 12 Oct 2017 16:20:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq60bl2iyp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/11/2017 10:33 PM, Junio C Hamano wrote:
> Jameson Miller <jameson.miller81@gmail.com> writes:
>
>> Changes in v2:
>>
>> Addressed review comments from the original series:
>>
>> * Made fixes / simplifications suggested for documentation
>>
>> * Removed test_tick from test scripts
>>
>> * Merged 2 commits (as suggested)
>>
>> Jameson Miller (5):
>>    Teach status options around showing ignored files
>>    Update documentation for new directory and status logic
>>    Add tests for git status `--ignored=matching`
>>    Expand support for ignored arguments on status
>>    Add tests around status handling of ignored arguments
> Please make sure these titles mix well when they appear together
> with changes from other people that are completely unrelated to
> them.  Keep in mind that your "git status" is *not* the most
> important thing in the world (of course, it is no less important
> than others, either).  Perhaps
>
>      status: add new options to show ignored files differently
>      status: document logic to show new directory
>      status: test --ignored=matching
Thank you for the suggestions - I will update the  commit titles in my 
next round.
>
> etc.  Rules of thumb:
>
>   (1) choose "<area>: " prefix appropriately
>   (2) keep them short and to the point
>   (3) word that follow "<area>: " prefix is not capitalized
>   (4) no need for full-stop at the end of the title
>
>

