Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4116202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 13:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754954AbdGKNRy (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 09:17:54 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32904 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752533AbdGKNRx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 09:17:53 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so16817891pgb.0
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=0jrsbI+/OiAor00HNUDujCrt7HpLU1XJi7aodOeSnhM=;
        b=A2lTXg8AtvWP955CQX0/Sbnwa4oHmsegRfXWDeyXejzgrOAR9S/QtsPC9P8QuveIvq
         7cs98+fElHNlaAABTUCHIz1Jx1plvMm44lsHpk4Lr/CW1dMhICtfBvYfHGBgf7ALhg7I
         ctJ+J3KdSnEMD+wYzn1C6cH/CjAeqzjIY8s5fw804yYOOVx2vKjMpy47rvIIZGT5ik56
         J3obuDB8n5vNvRvmQW/eKGkD8Ux9Y/rCT+kdwn0IEYK7CXTp17hy+xMlt9nP9P+1kL+r
         ZXQtMO+LfWfxkiAePqsGHW2H3lMnuvy1ihDgc9+SmwK/N8LUbz1N28275aMwC3Xox+zf
         NvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=0jrsbI+/OiAor00HNUDujCrt7HpLU1XJi7aodOeSnhM=;
        b=XQ0FRp/5RoPvhCYS3pvY7JpCWAJDduNwqteFMQnNn2eDBdH7V02WRckRUX37hBIANv
         qw9UccFNMfH4D8QBLofCITdDf+rVx/9rLiniPV4rMaLSRPfQVzQ11LQasrviimt7Zy93
         V6+wF7+rIxbjVqMrTVkrwmHvfcl6x3Z4m8TfQIdGscggLkn3hjZgW6VRFeaON8G4YmHr
         jjKMCg1IFeS1Hp/mVYm/2I2U0U7admmz1copyNWT6agJNbQ3vzI6My4VLyA228Vho+qE
         Jb/1OKT8hc87SRw9XSDJ+Mtf6WBp8O1cG4cV4df+GdFEIv/kMf4jZRl8sHXE7j84FRRX
         Cj6Q==
X-Gm-Message-State: AIVw1131L1xwTcRYZP9mYU6oSbajEmnZB5C/UY3qYW0WWjGnZU8NGtIK
        t3dxJCHFcnxzbg==
X-Received: by 10.99.123.81 with SMTP id k17mr19821598pgn.71.1499779072812;
        Tue, 11 Jul 2017 06:17:52 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id c191sm38311855pga.15.2017.07.11.06.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 06:17:52 -0700 (PDT)
Message-ID: <1499779083.1740.3.camel@gmail.com>
Subject: Re: [PATCH 3/4] hook: add signature using "interpret-trailers"
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>, gitster@pobox.com
Cc:     git@vger.kernel.org
Date:   Tue, 11 Jul 2017 18:48:03 +0530
In-Reply-To: <2e957be5-980b-1d7b-812f-bf18d12313d6@ramsayjones.plus.com>
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
         <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
         <20170710141744.8541-3-kaarticsivaraam91196@gmail.com>
         <2e957be5-980b-1d7b-812f-bf18d12313d6@ramsayjones.plus.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note: Re-attempting to send mail due to rejection
On Mon, 2017-07-10 at 16:13 +0100, Ramsay Jones wrote:
> 
> Again, s/signature/sign-off/g, or similar (including subject line).
> 
Thanks! Forgot that in the course of splitting the patches and
modifying them.

-- 
Kaartic
