Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 294672047F
	for <e@80x24.org>; Sat, 23 Sep 2017 10:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbdIWKup (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 06:50:45 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34508 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdIWKuo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 06:50:44 -0400
Received: by mail-pg0-f67.google.com with SMTP id u18so2110317pgo.1
        for <git@vger.kernel.org>; Sat, 23 Sep 2017 03:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=p2JYxLqpXjiZA/fe4Za+R9nA4ZEHW4ih8eFgaV2n8kg=;
        b=LlhQiKrF5IT8uJp7Xk+T2onYJzWtQteSA1atvSqk/hQJKKjXZ2jLUzzD/PfUvNyJhm
         3LQUaKZAstMB8+VGzH/kvYjcyu0vqhsVPiM9mGRMbOaWjtw3QVmsz+m1JiC5FAME2wZJ
         FEhpwSb6u/oyOo1obXuzy4Pft+v6r4OuBwukVCg9jGAPR9ATqInF0/1XbW6UrVRi9Wh/
         zgUFos2B1D0uA75SKmm038h+9CBD67Uj+uHD8SkbIbMbAiC8EqPR6f3VI1ilW7+JD8f1
         e/INpQY+QoYff5eT/sf79WMWroh3CxWaXKqfrhMjxkvfc0N4mE/m2/DttQxNQDqQQtbn
         40Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=p2JYxLqpXjiZA/fe4Za+R9nA4ZEHW4ih8eFgaV2n8kg=;
        b=Q6mXEej0VG39LpW1CO/rej0acLN9rX5cy46+q11kUBGii6iKFSCyUvGS6M0UtDF21M
         lImVp+hIvERBpRixzkRS46OqQIRfLxzbUO5p2olSN40dAGWd0J2phpeeNZYzRH40WQBk
         uVilV5ZUMzV6aJ7XxRsBoTi0zEBqrhueGmw3eWF4giOSyhxmjKggeO2apSLOYw6RLvWM
         yQLBjbQigMVslZAwNaqaZnhOcMDF3sicAVnJf6mX1+MEzFpbZdM4hT5i30uyr8W1wKGX
         NB6PN9YZ8MusNdJGgmfvIq1RMhweneaQer9ZdLuhPpUaBITVtohYInxY3eNIduOpKZTM
         AIFA==
X-Gm-Message-State: AHPjjUgq0BAL5jKscOPxTFEakKfdeyWENC0mxFsy2KV+/3zPT+tVeQ/J
        Y1QxfwtHRKcnfcR929+p7dpIIKgn
X-Google-Smtp-Source: AOwi7QC3eu+kpCDt2ql4LtrTHQjCyC5lM1JQUQJ26uqbol+BR56KCtYNCgaRvOawS3LBEvPRX8HVuQ==
X-Received: by 10.84.238.201 with SMTP id l9mr1794982pln.159.1506163843862;
        Sat, 23 Sep 2017 03:50:43 -0700 (PDT)
Received: from ?IPv6:2405:204:70c5:34d4:f862:3e2d:a1bf:681d? ([2405:204:70c5:34d4:f862:3e2d:a1bf:681d])
        by smtp.gmail.com with ESMTPSA id m87sm3188530pfi.122.2017.09.23.03.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Sep 2017 03:50:42 -0700 (PDT)
Subject: Re: [RFC PATCH 5/5] builtin/branch: give more useful error messages
 when renaming
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170919071525.9404-6-kaarticsivaraam91196@gmail.com>
 <CAGZ79kYMagCFS765NtOBDxDJYaXMyA4-=xxi3JMxbga638b6Yg@mail.gmail.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <2e91fd2e-3c8a-ff93-ff6f-4a30191d1249@gmail.com>
Date:   Sat, 23 Sep 2017 16:20:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYMagCFS765NtOBDxDJYaXMyA4-=xxi3JMxbga638b6Yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 21 September 2017 02:27 AM, Stefan Beller wrote:
>
>> It's conventional to report that 'tset' doesn't exist rather than
>> reporting that 'master' exists, the same way the 'mv' command does.
>>
>>      $ git branch -m tset master
> This is not the 'mv' command as promised? So this is just
> to demonstrate the (still fictional) better error message?

Yes

> Maybe use a real 'mv' command here?

It didn't want to do that to avoid preserve continuity. I'll change the 
commit
message a little to fix this.

---
Kaartic
