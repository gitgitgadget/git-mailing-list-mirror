Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CC63200B9
	for <e@80x24.org>; Mon, 21 May 2018 13:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeEUNRn (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 09:17:43 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34664 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeEUNRm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 09:17:42 -0400
Received: by mail-qt0-f195.google.com with SMTP id m5-v6so18843460qti.1
        for <git@vger.kernel.org>; Mon, 21 May 2018 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4FsIGvCq8uXZ4HZAMs992/b1BmNoiArqexe9xLaVkPA=;
        b=c6YadpnDl+hb1/r5RiulHk0Yi8Hn8Xc0CrlrZTQATfyi/cpVfp/X9mxIihO4DShqBz
         jobthsOBJc6hPKFWA5sX2rQqgmmcQDln8zMSWCNYdBmYeCOVO2YfMu9DlQqRfls4YqWt
         W/K9rMBpIz24vIAuc5IxRFYajcYnTSyCqLEC7Q2G9xU8/hHj7y3QRK8tNtg+KbMsM6Sa
         O1RAuWdUW+VSVnxgmPJa3JR9y39Vd4Gu6GgyjqRE+0P1uFwt3Rr0M4X5fRUz4FORVpd/
         Lr4NgxyRjUbpI4W1zHdkrxW2VWwCXKWJ9z4QL/Da3/wdqICnVNahIJvqdmDJOBkZIx4C
         iPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4FsIGvCq8uXZ4HZAMs992/b1BmNoiArqexe9xLaVkPA=;
        b=okLu/wEtTJ4Vs63zlBPHvVGWHtQtH4EGKAsRmZ4Iw1iM3Jj+JVPyX5AR3JlDI0OBHp
         Gqsw+sPvO+jF3JH+8UW0U77nP8+ANTRlBhpNONa+uPmGuBNpCR79urIPiZr6j2QNoOxs
         dAqiqZIHVhVOUyL0wc2BvUeobwF6+ST1BpwRus/h0S5fFf8eH/omYkX2J5/zYOZKWFJ2
         xsSxuISuCE6KwrBgjHCswknQRHN4Jl2tTFPieqVfVUENl6qDp6ajG/iDv0gk5YDtqqBB
         TZj20qxxQTAzs2D2fHh84Jjt2PWnXlmce6nCSXPsocKA5LECPUfWPLe1q/gUanLzQ+jR
         3YzQ==
X-Gm-Message-State: ALKqPwcJv4+CXP8/cGFj2JsN/aAPCpHz3DgdIlDQjulmOq9UacTh3Ulr
        DLM3MgL0cswEMPwnJ1JqSWU=
X-Google-Smtp-Source: AB8JxZqvZTIXhxVgvmP0aXyO7uwbSwFQ/p0IaDMApp+8cBfjqUCyEyrFL98BlcPxxrFoZO1I3NFUOA==
X-Received: by 2002:a0c:98db:: with SMTP id g27-v6mr17549692qvd.229.1526908661778;
        Mon, 21 May 2018 06:17:41 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id o14-v6sm11629762qta.23.2018.05.21.06.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 May 2018 06:17:40 -0700 (PDT)
Subject: Re: [PATCH v4 00/28] Hash-independent tests
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Stefan Beller <sbeller@google.com>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
 <20180521020147.648496-1-sandals@crustytoothpaste.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <63adc6e2-19c6-72c9-1c56-47503e128231@gmail.com>
Date:   Mon, 21 May 2018 09:17:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521020147.648496-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/20/2018 10:01 PM, brian m. carlson wrote:
> This is part 2 in the series to make tests hash independent.
> 

Do you plan to update those tests that hard code the SHA of the index 
file itself?  For example, t1700-split-index.sh has hard coded values 
for the SHA and currently only supports different hard coded values for 
V4 indexes vs others.
