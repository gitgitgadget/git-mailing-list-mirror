Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 884DF201A4
	for <e@80x24.org>; Tue, 16 May 2017 21:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbdEPVze (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 17:55:34 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33851 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbdEPVzd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 17:55:33 -0400
Received: by mail-qt0-f173.google.com with SMTP id c13so78135470qtc.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 14:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=pauMGlFd/R71YyeTks8MEBXMJ8XO8qg1nTy4jO3ChGA=;
        b=FteVT7RCpj2s6VkUDSBnkeR3O7KK71g/rr4h/rJ1kSu4D2KhytExvh2EG2uQ9padEm
         RHyZdfu9CSGCBjEQBj31uFqyt3BEQ/OwnA2l/Kc242DlNWrrVnFvgXqGVz3yRG0PE+CN
         PWbwrdUo1x/yQjV0hnH1EAYsX+8NXZi+hTcQzT3YyzMUGmyCbZMmIQGuW1Rtawf2U9/4
         A8vclARKzhRFoneDitjUaSU9WUncYMU3XLmVE0T42yDC0GkCkkAxhaKuxoeszhOvoWkL
         RZvvuyzTRh3Hszo1a8u9gaviQHi9Hn0iAVGKvpSwZ/PT0IJ3oGfG9ocSY3ayEVaENrAz
         L1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=pauMGlFd/R71YyeTks8MEBXMJ8XO8qg1nTy4jO3ChGA=;
        b=UBWXHqs3dx0qvA6pg1nw5y6r2kj9t4gKdL3Y1wSSxSJ08C4E8fMEXhXh5vQcnPnxhD
         /uLJRIJZC2pMi9s2YKGKzFu/0XRFpbQhO1clwBtIUkUYaVE0i0CYv2ur+9E6doJ02yhl
         G9rV6bNCvXr6nRbyQ2UOlhPvVCpJr5hc1H66A1AtqLhKeMzhLCM0MLNtHjipdIB4BS8m
         pCEQ0qpLHYwgjRLsMm3T8WMW1tdnoQTNfQ2VHCR5eZDfb2iOJ5vu+f/qn4YFedQ9HlA5
         hbQ5jlFPOcIZiwpnQf38x5YZDFplXlFtgE5ERV9kzHlzXkYMIByNReQaXoNqPHpAYgoO
         BKqw==
X-Gm-Message-State: AODbwcBnTe2cyYAmK58MTSkYtBHviQ82Vj8Qyg73s5k2xIUCcVxaNzsF
        gLgytVuBJqPdUh5u7Uc=
X-Received: by 10.237.59.20 with SMTP id p20mr132015qte.95.1494971732631;
        Tue, 16 May 2017 14:55:32 -0700 (PDT)
Received: from Matthews-MacBook-Pro.local (146-115-162-193.c3-0.wth-ubr1.sbo-wth.ma.cable.rcn.com. [146.115.162.193])
        by smtp.gmail.com with ESMTPSA id d25sm88108qtg.4.2017.05.16.14.55.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 14:55:32 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Matthew Groth <mgroth49@gmail.com>
Subject: [fixed] error using `git mergetool --tool=meld`
Message-ID: <dbbf2f82-8ef3-2411-d51f-63f94ba7e77a@gmail.com>
Date:   Tue, 16 May 2017 17:55:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I needed to use `git config mergetool.meld.hasOutput false`
