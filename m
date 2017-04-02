Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD3B1FAFB
	for <e@80x24.org>; Sun,  2 Apr 2017 09:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdDBJ7A (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 05:59:00 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36043 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdDBJ66 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 05:58:58 -0400
Received: by mail-lf0-f65.google.com with SMTP id n78so10663261lfi.3
        for <git@vger.kernel.org>; Sun, 02 Apr 2017 02:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RbptFVkoonSqORLS/bdb4xqEm08t18YMlbb0lw8IVN0=;
        b=o+BjFMf/LtwvHI+bLJHpTqMWGMXiCtrM0Z0DIUkMlDZx40oTiSxQmjJqJZkfPT6rO1
         ph3lmq0sDcE+5jmtgSaNu+4ytfFrjMkZesMbO4yLUC6iEDPU5na5TkkaZrvVAhWqmO6x
         mtB4uTITocM+ksUMw1dOoxoVBLnWzc+NqSjDY7d8oj7B9Y3J/G6ilhMX2N0xe3O11f8w
         N6ZJYZcUqgpmXMDLNqO0z+FwO2bwm9y4Gl5UtQvYghQob2KUwksBKJF/TX4hxE9VRukl
         YlVPfwyRYwjo1LVimycSDRaoaCK8RlpEnsnyMNcYqKOIGTpu5Zn3ufYd/XenNVLPlm5E
         t6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=RbptFVkoonSqORLS/bdb4xqEm08t18YMlbb0lw8IVN0=;
        b=Z29UauUvrMBHQBNqNuXNWTr9N/naxBuG6M6rsGShtlajcPKG1npBpIRAI7dKebrugf
         JEGu0k6Qm/YzLORv2QWAy5vSRV5Ff+ZJqZKJUSrHvYn51PXuvg+s9OXy8SGTAtJ7xO7e
         mSbR/PxViiAtvHNBwfw8ktN1BoFBsvGg5M8ILYnKkAe9JtC1/z0JPmoBqVE9zsvImXWD
         2mQsfJtfkpdw8VEz3mZ1Qnb8g+0svRM8ufg8qhjF8wQ/1I2BeMiHmTFdq3rdhfS6JfS4
         aOneFXaH66eb92TLsHfiuHP0TynZz64Lo+GiwAflC95eA7K1JlDlocrLIJbTUsLgHVMK
         RXQA==
X-Gm-Message-State: AFeK/H3SJbE1/VHZfNakbrEXJBBJDecKSMJ3a+e+GKCCTpTuNOPIimZ69XegGAqb8j7tXg==
X-Received: by 10.25.221.66 with SMTP id u63mr3606089lfg.52.1491127136925;
        Sun, 02 Apr 2017 02:58:56 -0700 (PDT)
Received: from [192.168.1.26] (abpo61.neoplus.adsl.tpnet.pl. [83.8.56.61])
        by smtp.googlemail.com with ESMTPSA id h62sm1891947lfh.62.2017.04.02.02.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Apr 2017 02:58:55 -0700 (PDT)
Subject: Re: [PATCH] contrib/git-resurrect.sh: do not write \t for HT in sed
 scripts
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20170331173214.47514-1-git@jeffhostetler.com>
 <20170331173214.47514-2-git@jeffhostetler.com>
 <xmqqo9whxmrq.fsf@gitster.mtv.corp.google.com>
 <xmqqy3vlw3f9.fsf@gitster.mtv.corp.google.com>
 <CAPc5daWU5XDVNiYk_pTFk_qziuDr6W2XDHXXH-0oR49_KiCUYA@mail.gmail.com>
 <xmqqd1cwwyr5.fsf_-_@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7028b4eb-aa2b-aaf6-764d-cffab24a9968@gmail.com>
Date:   Sun, 2 Apr 2017 11:58:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqd1cwwyr5.fsf_-_@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 01.04.2017 o 06:14, Junio C Hamano pisze:

> Just like we did in 0d1d6e50 ("t/t7003: replace \t with literal tab
> in sed expression", 2010-08-12), avoid writing "\t" for HT in sed
> scripts, which is not portable.

I guess it is not possible to use HT variable (similar to LF that we
have in t/test-lib.sh, and which is defined by some scripts) set to
literal tab

  HT="	"

wouldn't work there, is it?

Using this variable would make literal tab character more visible.
-- 
Jakub Narębski

