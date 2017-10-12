Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31AEA20372
	for <e@80x24.org>; Thu, 12 Oct 2017 12:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbdJLMEc (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 08:04:32 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:54912 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbdJLMEb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 08:04:31 -0400
Received: by mail-qk0-f179.google.com with SMTP id n5so913596qke.11
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8YyrWNYmsuRLGQ580Q9A5SfTmnG5r/duEhvJ0nDHzwI=;
        b=qD+UbJMKjJW5AmjrOYE5dZ5G6JF5xJe4/Cx7e0+oN48pf9l6i/Z23wZnxA9nzsAfJY
         ajMeTasgAe4no0UiICkmI59aukEdLVmHGDCMVfWz55Hn0N8tgIWZKYIydnQlJ/YoHav5
         GxsV7f4FAptsLjydXcGUnHy0nrwHPaxEwh3hoIrabWZJ/h6KW3v+h2hthfWSKiNFs4bs
         wOcuB8ZnyYzhkktO9YoDMA0pFYzihCecz7NBAGz3zlitmZo9jYMJTltck/mI48PAoown
         MW/e1ar6K5Z4fYVzzPmoC3/kN4iza9ThUuFGcZOB+3x02PiPJrkbRMOTdwNFwfbllSsV
         0+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8YyrWNYmsuRLGQ580Q9A5SfTmnG5r/duEhvJ0nDHzwI=;
        b=Rz24gTzXlHmDDjtW4R7Y2h64ycVNwRUfFdAWS7+BRWNUkTYYAPFD/uvVFfWH34Cgb7
         oQEH9XwkNrcsvx5fnvyU2w8Kgxd8TGDykt+AcZBBLEnq+5WPsi01RR16DyZUoFHabIb1
         WNqeXLEMlMugTj3O0j2nH1DnsgCmm88h/BUl3Qia5GBrDBO+EeuQKghEnbzwi4v8HCbB
         SK5Q2bKRYRb3iiNtde70I/6ITnJJoECQi4S0e0wSR22BiA8l2ullVS5DnIFc1pdQQvcx
         i+RYgWzChQobNOmqhX2GRtgQ9F4OBAKhJBS6fsLFrelQ08TREiw1tQXERQ5IOhT36yqH
         Nv4g==
X-Gm-Message-State: AMCzsaVXJnfncI9GymvLfyM/MZWGJQ7Zja9hoFzuXtb/dITihlVtI+Xj
        HcoJha0C2SSGt82tFHroAEY=
X-Google-Smtp-Source: ABhQp+QiVzG3Wa//oHnw7kf+xo4KT+r65/Oclck0sPjUhamsTqxo4t8L2ILR1ZRVi9HNMvtAJRarsw==
X-Received: by 10.55.212.80 with SMTP id l77mr110049qki.82.1507809870534;
        Thu, 12 Oct 2017 05:04:30 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id 49sm9659463qtq.1.2017.10.12.05.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Oct 2017 05:04:29 -0700 (PDT)
Subject: Re: [PATCH v5 0/4] Improve abbreviation disambiguation
To:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
References: <61168095-d392-39d2-ba65-823525239b5c@gmail.com>
 <20171012120220.226427-1-dstolee@microsoft.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3261c086-01d9-42aa-5e82-002a4da37275@gmail.com>
Date:   Thu, 12 Oct 2017 08:04:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171012120220.226427-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2017 8:02 AM, Derrick Stolee wrote:
> Changes since previous version:
>
> * Make 'pos' unsigned in get_hex_char_from_oid()
>
> * Check response from open_pack_index()
>
> * Small typos in commit messages
>
> Thanks,
>   Stolee
>
I forgot to mention that I rebased on master this morning to be sure 
this doesn't conflict with the binary-search patch that was queued this 
week.

Thanks,
  Stolee
