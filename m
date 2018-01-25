Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1D41F404
	for <e@80x24.org>; Thu, 25 Jan 2018 15:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeAYPHv (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 10:07:51 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:44701 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeAYPHu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 10:07:50 -0500
Received: by mail-wm0-f48.google.com with SMTP id t74so15309371wme.3
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 07:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pG+Bm4fl8BQX8eS8NHIimg7Pzfwbqih8gW3c2c/jbVY=;
        b=dyZiziJBkZrhPHiCyKDio9H4MKEHhxXFS4WTaIi5xUjuQ9HWvV+NUALq8cHhk4Qx+F
         YJwiWcBhn6SJGwk9nPfpyGZ1l/kaJ+224rTZC/BvCGKYw2FLJuyo2bktRG58KRxzxdzQ
         SZ3V92O5htnP5b75+fkE41aRpNwVthD+IBkM8HZMoEHhkE2dcbChpwWOAOSIJG2vKkRo
         eTZA6dqAX5iosEHtrLjY5fkG+bV3tTwWfkM65A8BL4+1pcM1r/NhaAxMO30Tz9rJLd7u
         xVdwA2/hMdEo57tm4biN3lVniPq2kLyHwOU1C7N9d2Cq1LF6G88GAEppkceinRVgc1h6
         3Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pG+Bm4fl8BQX8eS8NHIimg7Pzfwbqih8gW3c2c/jbVY=;
        b=gL6DmU5t/fu6CsTnxmuakAu/ZvjYd2qEmRl+AC8OIc+sghyUHfqGIlGYsQ6gRmyjFx
         9SAUF65RpkGVE7t7BgWaDA5qPmAcrsIB+qphllXKGpMaCf3Mn8+jnyxgoQ9EK9sjPiKH
         i11krfwbAUO4kkzGpikXnpU4T8BzJLSNTNeglJHK2LRqwO9DSnx2Z+a/MDHMhE6U+6Uc
         qE9XMFT6s4VaLWe5Agu9NMgSSNzdPMW6WrYL3JDEicVViZQ2BThBbeaXwWe5tFGKmPc/
         mr5DOZXzMp86WGTyBkUolDw1hiKnXlTavAhXjEj3dHkNge1lJv867zJ07D4v6iwpCu4A
         ByVA==
X-Gm-Message-State: AKwxytc8w6iNkd+P9L5LYpQbebQicxGXvjJ3T7Cvi3yEDyBHJgtLmM36
        dBGUGBGTNOqgJWYZ4SS4K5A+0g==
X-Google-Smtp-Source: AH8x226Ka7lCWb/q6EjmtSBKwxqhfvTh8akDHfbKbZ2GTC7qzWk6xKfQUtbCVNkPtpaMo17rrEYKTw==
X-Received: by 10.28.192.24 with SMTP id q24mr8323879wmf.96.1516892868706;
        Thu, 25 Jan 2018 07:07:48 -0800 (PST)
Received: from [74.125.133.16] (gate.reksoft.ru. [188.64.144.36])
        by smtp.googlemail.com with ESMTPSA id m53sm2362062wrf.75.2018.01.25.07.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2018 07:07:48 -0800 (PST)
Subject: Re: pushing a delete-only commit consumes too much traffic
To:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
References: <e9518459-ebcd-d415-474f-8504472b7a1d@gmail.com>
 <001101d395e8$31d94430$958bcc90$@nexbridge.com>
From:   Basin Ilya <basinilya@gmail.com>
Message-ID: <79fd9c0b-3067-afce-1fcd-507b7c97889e@gmail.com>
Date:   Thu, 25 Jan 2018 18:07:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <001101d395e8$31d94430$958bcc90$@nexbridge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Were the 60Mb of jars previously pushed in a commit that already existed on the upstream?
yes

> Was the delete an actual removal of history or did you commit with the jars deleted, then pushed?
I committed with the jars deleted

> Did you do a merge squash or delete branch to effect the removal.
No




On 25.01.2018 17:24, Randall S. Becker wrote:
> On January 25, 2018 9:15 AM, Basin Ilya wrote:
> 
>> I had a 60Mb worth of unneeded jar files in the project. I created a new
>> branch and performed `git rm` on them. Now while I was pushing the change
>> the counter of sent data reached 80Mb. Why is that?
> 
> Can you provide more info? Were the 60Mb of jars previously pushed in a commit that already existed on the upstream? Was the delete an actual removal of history or did you commit with the jars deleted, then pushed? Did you do a merge squash or delete branch to effect the removal. More info please.
> 
> Cheers,
> Randall
> 
> -- Brief whoami:
>   NonStop developer since approximately NonStop(211288444200000000)
>   UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
> 
> 
> 
