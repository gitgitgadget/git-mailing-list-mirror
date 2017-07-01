Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF58820209
	for <e@80x24.org>; Sat,  1 Jul 2017 12:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbdGAMIT (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 08:08:19 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35185 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbdGAMIS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 08:08:18 -0400
Received: by mail-pf0-f178.google.com with SMTP id c73so79277478pfk.2
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 05:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=3HMdATmBHOHlTvgsl2Ipik8lghT9gP/eeoo4axA9V6k=;
        b=o563oItRDpGOk+MfwfrZKqYN8ngg//nJNAH0kZGxLKQtZLZvl+t47VzFdc3VwA2eAx
         vTYHCv+wCdPQ4pUUiKW1mBpQSPAtLtEsLJcsxZaeXLeER9AnW2QYTP2BwUnvHPRdYh1q
         SZhvYUOkdIcOVU3lr/m3bvj3WHs3QQj2RdZ8pVZH46Mx/cf1fQhiDq2GMD/M9h7Khm/R
         UJ63ddystIFihdD5Vcs1ktdmQMl4pQtOuEXMAEO2u1qI0y/V/MFE9LmXnMT7YwskkjFg
         UeAImckW0NaUO2aBfCwj+5yC4E7qfFOG8RxvEoA/rxIOrbTtHGU/09zW1VQ3NYaw7YNc
         VRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=3HMdATmBHOHlTvgsl2Ipik8lghT9gP/eeoo4axA9V6k=;
        b=QNW5AvMyt7AhHAUhQYf8YwYtcMThupViPvyx1ao1JcS0euBnnMe+OUrIOb2vbb+c2N
         zGuJ3T16GX+X6+tOnFoVAcne2NAdH1bagrP8TU7dcC4j3v1xm1w93Mo+gzWz91xKGjt3
         ZDPrM/UMk1dhVB7E/O+szIPsLIqcZHsq2pLtLbstx7SVBG1FUK1v34+hMQqVuEolfpyg
         DSk4CvY/uyH5o6HzqWru8s4S+OYJfoHN60G9bFI58v5abE3Yq8DIp048eNWzb23k1a2U
         XKwBNEnS5/4G6IVvARGgCC6/qey5yS2Ktw5fbCf6yQLAm0EOvUu/jsfoSFKqL6GngZzn
         9jDA==
X-Gm-Message-State: AIVw111gxDD6lBGCclkThQu6mEplzmj5Qt4Y9Sq8P+4ATIA3E+7GliBb
        MD8Agl2dfI+yqg==
X-Received: by 10.101.77.6 with SMTP id i6mr527057pgt.43.1498910897568;
        Sat, 01 Jul 2017 05:08:17 -0700 (PDT)
Received: from unique-pc ([182.73.79.179])
        by smtp.googlemail.com with ESMTPSA id e63sm22964057pfb.18.2017.07.01.05.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Jul 2017 05:08:16 -0700 (PDT)
Message-ID: <1498910895.1849.1.camel@gmail.com>
Subject: Re: [PATCH 2/2] commit-template: distinguish status information
 unconditionally
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date:   Sat, 01 Jul 2017 17:38:15 +0530
In-Reply-To: <87mv8oe5zc.fsf@gmail.com>
References: <1498792731.2063.5.camel@gmail.com>
         <20170630121221.3327-1-kaarticsivaraam91196@gmail.com>
         <20170630121221.3327-2-kaarticsivaraam91196@gmail.com>
         <xmqqa84pttmh.fsf@gitster.mtv.corp.google.com>
         <1498874344.2245.0.camel@gmail.com> <87mv8oe5zc.fsf@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-07-01 at 13:44 +0200, Ævar Arnfjörð Bjarmason wrote:
> Just as someone reading this from the sidelines, very nice to have
> someone working this part of the UI, but it would be much easier to
> review if you included before/after examples of changes

That's a good comment. Will try to follow that in future. :)

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
