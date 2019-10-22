Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7AE1F4C1
	for <e@80x24.org>; Tue, 22 Oct 2019 19:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387791AbfJVTgD (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 15:36:03 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:45072 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732691AbfJVTgD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 15:36:03 -0400
Received: by mail-qt1-f175.google.com with SMTP id c21so28538101qtj.12
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 12:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QIeUJEQuhMGYb0EekYhy8faEPJ35Ol6kL+2z1Cnkmnk=;
        b=GoKWlJ35URfpPFJsg+Ecyp3wyxM3V9c1nASt72cSVrYDa7bvnm0UYRCI+dXzisSyHF
         x33PqEN/Zt2qJVs3wlbu9LhI3VTMtOUdfQGGhrpaA6dNHzQ6fToupngHEVeoiTGjka6e
         OdwlHcu9rIdTLYdPbBKZ8zBw767XFy5zPEC1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=QIeUJEQuhMGYb0EekYhy8faEPJ35Ol6kL+2z1Cnkmnk=;
        b=au9VPbgUASDR39MvfXJdhgeJGk3X9jxv2mf6B1/OG2esSNKv7UWSPmsPICEoo6AN6j
         a2n0OGiD9Nx461FxlmgO0VMeW9T312oJMm+i8M87tAi60H/wjmrbZdyYCiNybH0fqrC2
         RrijrTxdSN0+PAgbu3kzNiXz12NvM/zED4UEm7WGrZ/ttgVJntn2xLyZyN2jt/ELtiMj
         sPMhPYLquhAzK2Ghcc74YN6J+j/qqzGzKh7SnNIPbs8Aaw+uPpr4OTYrc9K0BycIpMg7
         2ZEoSIU87xaqQUR+hC3kdvpQP488xu4ovkHVF+WdEQ4WRQD+co3nP4p33pzL7M37fNSE
         wgZA==
X-Gm-Message-State: APjAAAVuoO6HUhbE+7Ioaul7DsconOZfua/lHbs00wm4BtcgAQ3BwAVU
        dKRAZt4LcCiPDE27R+BHVirGOQ==
X-Google-Smtp-Source: APXvYqyX7IRstYRlks9ANN/WYt5fcrGZTc0QhGPHEE+uX2UiY+S8d8ymL+kLoHu3WlpmCfDHXTggOQ==
X-Received: by 2002:ac8:183:: with SMTP id x3mr5175573qtf.279.1571772961965;
        Tue, 22 Oct 2019 12:36:01 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id t65sm9611258qkh.23.2019.10.22.12.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 12:36:00 -0700 (PDT)
Date:   Tue, 22 Oct 2019 15:35:58 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC/WIP] range-diff: show old/new blob OIDs in comments
Message-ID: <20191022193558.GC4960@chatter.i7.local>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <20191017121045.GA15364@dcvr>
 <nycvar.QRO.7.76.6.1910222111430.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910222111430.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 09:18:35PM +0200, Johannes Schindelin wrote:
>As to recreating blobs from mails: Wow. That's quite a length you're
>going, and I think it is a shame that you have to. If only every
>contribution came accompanied with a pullable branch in a public
>repository.

Trouble is, those public repositories are transient and may be gone soon 
after the pull request is performed. The goal is to be able to 
reconstruct full code history prior to when it is merged into the 
official repository.

>Instead, we will have to rely on your centralized, non-distributed
>service...

It's actually neither, because mirroring and distributing public-inbox 
repositories is already easy, and we hope to make it easier in the near 
future.

-K
