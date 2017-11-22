Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4BE520954
	for <e@80x24.org>; Wed, 22 Nov 2017 15:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbdKVPTs (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 10:19:48 -0500
Received: from mail-pl0-f44.google.com ([209.85.160.44]:44360 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbdKVPTp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 10:19:45 -0500
Received: by mail-pl0-f44.google.com with SMTP id v15so910018plk.11
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 07:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neulinger-org.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=FumanC7x9Sl0UX5yJmk+lg9Sbye7MMDjybmPNh6sCuE=;
        b=VNoQdWnpdJAwuUqTsG/i2G51wdWqAfB3PJdItHhsRvdP5/21K3oyE1ymdSsZuWdeLb
         H7JjkwDziM9hxSyRiyeUbVJF6r7yyDXStgnP4g5Hf4wmcPKoUT2KJDDr2oiPKEenYqAd
         9T6sqTgsLnFWBX1ypPqiBnYwiz1jq+X4Fu+Ul8GYEARJJ3NvT6VKc8+pOIoyaBbF53Ik
         /w3FEMlsdHs83upVAACi62waHzEzPtiBemPinI4bQLkkR8jVvfuUcTd7xSUgWN9GBhrE
         N+ZbKIXNZOTHonWsKVZNOQMWdn20awWeSby0Ff5N6LsXs8Fm+JEIENJD2P63GjFxDa/C
         z8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=FumanC7x9Sl0UX5yJmk+lg9Sbye7MMDjybmPNh6sCuE=;
        b=GeecI8SFFQ+fstMWEF0fz5kwn5YvC4sFlb6Q4R9C7I4n2n9FRJ+6M7+eGMeGdng/Yf
         PVvUdeZnLcm0o2zeX9WOWNAu2t9Gs9+CDs5nQZb3gtxPcszAqTMmX/gXb1ESwxp2KRY7
         IeNIg/deM5peDBYfFtOuCV5fb6jMbz0Zf+AnwiaVl8awRIrnAaXpZtYt9AWJXpz3t3NW
         8fFre2VuwFCXsZlhteuEGf8NF0TBz5IH3cjV4sbSePhEPmn36/rq/9/B1LyV9tnBJ81N
         G20YtU/hYJ75yCvWPiPev/hVh5/7HSX8Lm5p8kVFhk9bOJDgt6O9qA0dEupcqILdL4Fm
         3oNg==
X-Gm-Message-State: AJaThX6dWaQJ+s3wa918ykvLFePk2n0wUyAsx2wxd1gvDoTGGa15Bfqj
        1uWqOu24ACkEhZmF0sS8CHE51MIa
X-Google-Smtp-Source: AGs4zMaPaUA240lbULw3g933KIyz+h1Uh9FE90sPnmkmQSSAA1/n6nv2hS6Q+YuUflcvOmdW6jrMXQ==
X-Received: by 10.84.248.142 with SMTP id q14mr21499102pll.102.1511363984746;
        Wed, 22 Nov 2017 07:19:44 -0800 (PST)
Received: from infinity.srv.mst.edu (infinity.srv.mst.edu. [131.151.93.93])
        by smtp.gmail.com with ESMTPSA id g7sm31559307pfj.13.2017.11.22.07.19.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 07:19:43 -0800 (PST)
To:     git@vger.kernel.org
From:   Nathan Neulinger <nneul@neulinger.org>
Subject: git status always modifies index?
Organization: Neulinger Consulting
Message-ID: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
Date:   Wed, 22 Nov 2017 09:19:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101
 Thunderbird/57.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Current code appears to always attempt an index refresh, which results in file permission changes if you run a 'git 
status' as a privileged account.

Would be nice if there were an option available to ask git status to NOT update the index.

Even better would be if it was smart about the situation and would not refresh the index if it can see that file 
ownership would change as a result of updating the index. To me this is following principle of least surprise. Running a 
"query" operation would not normally be expected to result in write/modify activity.

-- Nathan
------------------------------------------------------------
Nathan Neulinger                       nneul@neulinger.org
Neulinger Consulting                   (573) 612-1412
