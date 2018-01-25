Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A09D1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbeAYOP0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:15:26 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:41361 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbeAYOPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:15:25 -0500
Received: by mail-wm0-f41.google.com with SMTP id f71so14875800wmf.0
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lpRZJmT7cMzILEgK9eSEBNb48AH4JqPxjm+7dKro3zE=;
        b=C0XzrNUG/9wdVZxxn5SCrAeVQuA1YX060YB/2LC1c1CIfC7rvSvy/F0UetfNAh6TBC
         wDWNlLuppSTheR0Y+z2vzo6kcM3vPVCdxE3Yaj1tXLbktwMFPdJRVVjpZ/MkjcyUdYoI
         nBMFj/dr3N8CC1pbiYRD1hFlNDmUfTkQEU2PaQBs/ccWevJEkNhc3SL8wI8MY+pMX/3J
         SwHqb6/JWneEBSS7AKAowboD+wYjjph6BH5GJjkCWLuxIFR34C02RfWI3gHo0GzeheXQ
         lxvwyRK3EyptJP5cEaPftnXfeSrcZeReMB3Mn8HxH1T32GI7j8pimtlzZjLxwMZCmrv3
         I9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lpRZJmT7cMzILEgK9eSEBNb48AH4JqPxjm+7dKro3zE=;
        b=RMLapqsMNu6t/eQIldn+U76+ngs38dHzIWoylQ293ze6wzpLwSKoqZkfjByHDqh7Vm
         YXbh+8Y1XBdQsl3VUD/DOTXd5LczVtpquyh+5cCGU8/L9FZt9JmI7ALmakrUps+lycew
         4FgnGYMYWIyt8IFIn41CS1viJGii2/QNLmLDslN7UpfO2PaYZYFr4SLqH5CCaDG016pK
         FDvXdkGygCeD/Ox62wKITQa+XuYdQh0MGIMHRjYjZNwDXXdj2c1KhWyD+p2ECvuULSQA
         aas1fZ4pUbAiaPvUrVIiXIMWO35m5lXGUM5AV4O+uzJdfMXJk1yjaDpZ0HXe6laH4kQ8
         TZIw==
X-Gm-Message-State: AKwxytc1CDwAIl+HmqZ6tWSclVcOjFk8GKVl4olfaajvQHbNLso4sFxL
        od19wyAOllj9a0h6NcmACfKUgw==
X-Google-Smtp-Source: AH8x225T3W+XZ2W7H8L3eZrYhjWB1Ci6EUNOxb/ly2eq2IAJnTCBZrLoVyrqbGAKbdyKlqdIsujvIw==
X-Received: by 10.28.209.137 with SMTP id i131mr7468303wmg.1.1516889723980;
        Thu, 25 Jan 2018 06:15:23 -0800 (PST)
Received: from [74.125.133.16] (gate.reksoft.ru. [188.64.144.36])
        by smtp.googlemail.com with ESMTPSA id k69sm1622862wmg.8.2018.01.25.06.15.22
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2018 06:15:22 -0800 (PST)
To:     git@vger.kernel.org
From:   Basin Ilya <basinilya@gmail.com>
Subject: pushing a delete-only commit consumes too much traffic
Message-ID: <e9518459-ebcd-d415-474f-8504472b7a1d@gmail.com>
Date:   Thu, 25 Jan 2018 17:15:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi list.
I had a 60Mb worth of unneeded jar files in the project. I created a new branch and performed `git rm` on them. Now while I was pushing the change the counter of sent data
reached 80Mb. Why is that?
