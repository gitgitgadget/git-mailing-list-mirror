Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46910200B9
	for <e@80x24.org>; Fri,  4 May 2018 16:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbeEDQ2R (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 12:28:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39589 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeEDQ2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 12:28:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id f8-v6so5858506wmc.4
        for <git@vger.kernel.org>; Fri, 04 May 2018 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:cc:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=eLVNa/0v0lUsl1Dbuda64ajsSt0RAxnBWYNITI2mW5s=;
        b=SMpxAicasZQiskIXxplP2ixafmjoEFrnlFQO5SnlB9y0xurRel4yk2pUlq7JLnYXXU
         EU/8N5S0aW8qfPy5QD4Y56iv8hbmHm5J3aGvzImIWtLuKiEIdmGWAC9NjevrwKvUsqEb
         hjXMJxHvaLE9gG5ZUmr5FNIBlVp8brceOkED13/VB+6BHeA+wyjKHpi/HLJahqeKPVja
         Jgy6VmXeu19WeDGsmYqvnA98D0sCh8ATiZHoDzNT9k6f6l8FyE9/so8wNQl7AgOI9ytv
         0wUCEmMzpjIG5mrgwORuSdOeV2Fum4zREllvL9DW5Veh3MhC0K2K81AeNg1IFD4c6HVQ
         jwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=eLVNa/0v0lUsl1Dbuda64ajsSt0RAxnBWYNITI2mW5s=;
        b=N74haBJ6LqQdnBnZnHEihY68+TH3QBTjrHtDqo2dHGMhPT7TSAyNv186g5QL1K+rWt
         PerKQd7FJGz0uhgmaXdszxYBmK84d2itchY3GtE1ReSdmWWkrQv3f1oLCISC9mAm35eH
         xJ3OlvJi2sBQtv6jI34baHfb0WuJ0aaZsGaoN/gCtQ7iBBpuwsyjLz3r/Ao5sqPKzVM7
         8xPRZhFApOxfjzfBg+iPkF6z8IdO9U6xlyFokdaFpyshqAIGSatDGCRIKH8Pxp9fz6qK
         wxjdzaax9biQOemOofAlM2xUNB7hGOWeYV/s4Xj6chj/hAk2AN/zHh7UoNORKSVrtNNE
         d8eg==
X-Gm-Message-State: ALQs6tB1QAHf3ClFkx0+zEnQO0DnHJlMDl3NRuh8QftDalcf8OSemXbg
        hcO4CyyQTLrMN9N95+80sXc=
X-Google-Smtp-Source: AB8JxZqyLngp852paexNi7bKBPTa/gFblD4E+H/1lXPhOwEzqykc3K5qbYVU5EhkQtXMTFIH8rndYg==
X-Received: by 10.28.195.85 with SMTP id t82mr17825366wmf.129.1525451295018;
        Fri, 04 May 2018 09:28:15 -0700 (PDT)
Received: from [192.168.1.28] (17.252.114.89.rev.vodafone.pt. [89.114.252.17])
        by smtp.gmail.com with ESMTPSA id 131-v6sm3041563wms.34.2018.05.04.09.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 09:28:14 -0700 (PDT)
From:   =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twopensource.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: git update-ref fails to create reference. (bug)
Message-ID: <cced9e2c-7d02-47fd-109a-1185eed13e63@gmail.com>
Date:   Fri, 4 May 2018 17:28:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While trying to create a pseudo reference named REF pointing to the
empty tree iff it doesn't exist, I stumbled on the following:

I assume both are valid ways to create such reference:
 	a) $ echo -e option no-deref\\nupdate REF $(git hash-object -t tree /dev/null) 0000000000000000000000000000000000000000 | git update-ref --stdin
 	b) $ git update-ref --no-deref REF $(git hash-object -t tree /dev/null) 0000000000000000000000000000000000000000

While a) works, b) will throw:
	fatal: could not read ref 'REF'

Bisect seems to point to:
2c3aed138 (pseudoref: check return values from read_ref(), 2015-07-15)

Thanks,
Rafael Ascensão
