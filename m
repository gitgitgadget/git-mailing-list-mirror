Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A59A1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 20:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbeHAW2s (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 18:28:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37788 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbeHAW2s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 18:28:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so11393000pgq.4
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=n5rEGsgyaFp14ijF6MJShqLbqhk9DCiIJHn9PLxAUV8=;
        b=XDIPV06BJ8Cy7nOsZr6CPOSGPHbL26gUXAgz/1N/AREw2FeJ/sqm+UodoOyLplp98j
         jNfbPdA5k9Gf9IzpTHiaQ1rvTdnVrlkx579pXTgi56FbmLA5JOYHxq+njy89KBC1lsWS
         lqGL/7rHNuGMF6DbezVIKtG3SKf6/lQy54152gWdAU/iXl6njvd5d1Yti6T1Z170Xc66
         fWfNIG3A+9rF8SzoCcY36i1B3oocZ3QCz2oYfObFXE+bStW4cZvbRktPXRP0VycF6WEE
         /Ob1EY0r+6Y4lA5NWtPNGSCDxhQpoJcbdnlwTE2Qv+jkyYCe7l38zTqq936GDAE5CJXy
         ySuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n5rEGsgyaFp14ijF6MJShqLbqhk9DCiIJHn9PLxAUV8=;
        b=g/MCtY4D/XxSJJXbB6UdlC4OA84DbE7bG7TVzV3s1bU4YrM3J8Ha3biydCjgFRnbVN
         zdfizdWVAkg9zbLV1Gby+eQi3BKsTTxb/J5Yv1cYhT9uzujSO+tteXIn5pSsoq75AoVu
         EBQEQ26b4TBucRgHWgjSSDfKVvETiTvf+eCrp/JZyisNG8eOpAsPlfAKE7WAuoUVsbHO
         5vdvrp1gFkHZ8emFwTCMeqG0eGB4/sIEAvwOseaKaY3yj86Uylqnm8+Ia+Z/Px+Ua06/
         3IYXB4NU/tBHBjSogK8YByLLLpdhMlNofh5PijgLCYYLl0qeBbbyJSxUf61HuTwWGf2S
         YpCg==
X-Gm-Message-State: AOUpUlGtvzfhRl9zx85lS9Q3WQ8pE2fGCcX+Giz+Zkj5aWfAYcFFYc/p
        EI4QDiZNeq+eId+bg2oQZ3M=
X-Google-Smtp-Source: AAOMgpfx+38WE92mOY/IHV0Beo4NIyRXk0w/26Ae8TvM6yWrKRbAxYBGODn9KtAtj9W4aOsQtOzBHQ==
X-Received: by 2002:a62:ee06:: with SMTP id e6-v6mr28269686pfi.2.1533156074247;
        Wed, 01 Aug 2018 13:41:14 -0700 (PDT)
Received: from [192.168.5.149] (143.120.102.199.static.airbits.net. [199.102.120.143])
        by smtp.gmail.com with ESMTPSA id r23-v6sm10396786pfd.144.2018.08.01.13.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 13:41:13 -0700 (PDT)
Subject: Re: [PATCH v2 17/18] commit-reach: make can_all_from_reach... linear
To:     Jonathan Tan <jonathantanmy@google.com>, dstolee@microsoft.com
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com
References: <20180720163227.105950-18-dstolee@microsoft.com>
 <20180723204112.233274-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <699cb8a9-dafc-8450-b992-0fb5c8afe1c2@gmail.com>
Date:   Wed, 1 Aug 2018 16:41:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180723204112.233274-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/23/2018 4:41 PM, Jonathan Tan wrote:
>> +		if (parse_commit(list[i]) ||
>> +		    list[i]->generation < min_generation)
> Here...
>
>> +					if (parse_commit(parent->item) ||
>> +					    parent->item->date < min_commit_date ||
>> +					    parent->item->generation < min_generation)
> ...and here, would parse_commit_or_die() be better? I think that a
> function that returns a definitive answer (either the commits are
> reachable or not) should die when the commits cannot be parsed.
I'm hesitant to add _or_die() here, when the previous implementation 
only used parse_object() or parse_commit(), so would not die when 
parsing fails. The same holds true for the other methods that call 
can_all_from_reach().

Thanks,
-Stolee
