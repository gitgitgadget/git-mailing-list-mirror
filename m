Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9266D20285
	for <e@80x24.org>; Sun, 27 Aug 2017 18:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdH0SoI (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 14:44:08 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33697 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdH0SoH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Aug 2017 14:44:07 -0400
Received: by mail-wr0-f177.google.com with SMTP id p37so2119515wrc.0
        for <git@vger.kernel.org>; Sun, 27 Aug 2017 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=JW2AqwpzSi+mjA54EVLE+DBeV6klQvh07KMRIMJDLfI=;
        b=mP2ok6AI0lrssPbCm4F/nVOzDBXDNR6Wjw4m8bwubFPCrC5zai/xOxG5GtSWWQpPzD
         pNUr8fcJjKqreLUdncjYa3+LDpaCKwm819qoBcrcZov0qZ03pEhasYSR5VNn70E6Ga4j
         dHSUWiOOnyEj4qqbiZ+CC05NBAQhlayLr3K5Dj2rVzP91e81FqEpVdFaSa99DAqqpNHz
         2B18uVT26VTvptupfx1JEczzKxIMI6+UYhmqgkqxTqA1xxLbMmkjYO9QTlPr7WqxaKQL
         orvI3+T3c+/AwEgqL4yErBSwe10PrCLiBXqo++OstE0aysbj32xI0F1Imej61QqLEH35
         XvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=JW2AqwpzSi+mjA54EVLE+DBeV6klQvh07KMRIMJDLfI=;
        b=KWZzwhoDUqkL+7u9H0l9rzseLCEvSoor03vmj3yvD7ddXlohP2y4wD1qEgPbUI5OkA
         2ni5h2m+oVwx3JqK2Kz1ueZudVLVGpVvt39NGMrsS3g9DCNaeAwz9+AFZoYoticaw8yu
         0AmWmhsbgpxxWnuvu1mqj8DWb11zjMrh/ORe9v+umrj5Q4FPNvjqnXHRrUs0FZcKpi8S
         dE+xAemfNLZRy9oIqSb3bi5vXgyHb6pw7vAlXncr1IKlkIAWWPlx8u3l11FLeYxeZM1q
         glyMSUyisOFM0doofYDBOEi3gMr9Ql1cMGh0n2aheTudfnRSAHxXQwLB5n6hEKBOM3jN
         AtRQ==
X-Gm-Message-State: AHYfb5huJ4xRIVg0esWlpnkjZCDy8P2lNnodXMviPze+j1ogb5xWIP2+
        ITPa6t6bBBPwMa2CHfA=
X-Received: by 10.223.180.69 with SMTP id v5mr2672900wrd.199.1503859446042;
        Sun, 27 Aug 2017 11:44:06 -0700 (PDT)
Received: from [10.32.248.91] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id s1sm9157368wra.75.2017.08.27.11.44.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 27 Aug 2017 11:44:05 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Automatically delete branches containing accepted patches?
Date:   Sun, 27 Aug 2017 20:44:06 +0200
Message-Id: <8AF4A868-628B-42AE-B75E-4DF19F7C7A89@gmail.com>
Cc:     Jeff King <peff@peff.net>
To:     Git Users <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have lots of git/git branches and once in a while some patches make it 
into git/git master. If this happens I would like to delete my branch
with the patch automatically. That's not easily possible as the hashes 
on my branches are, of course, not the same as the hashes on git/git.

How do you deal with this situation? Do you manually delete your 
branches or do you have some clever script to share?

Thanks,
Lars
