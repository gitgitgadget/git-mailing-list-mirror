Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EFD720401
	for <e@80x24.org>; Thu, 22 Jun 2017 03:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbdFVDBc (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 23:01:32 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34468 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbdFVDBb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 23:01:31 -0400
Received: by mail-pg0-f68.google.com with SMTP id j186so670903pge.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 20:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=HLdV8bbvgk28WC4lX8JNb7zhPXIVhJ1dW5FwzJhgEHk=;
        b=aUOsvqdyh2MlBVxP3XBouB7dI3y3XZP8TwoVTyU0nY3bqJSwxfDhJ3+FlUWvR0R+IH
         U/lGnvO2Ypydw0fx+UJ6zYC9fnFShKazgJjya5we0vrrOqtNeczTEh2h2WYtwl/1qEMJ
         uAsu1FK8v9zwJyUyZPajjYwkTUyZokf7JvU/zJn42TZOR7sOsQkTHj3bqsDTiJI05XC8
         3repuGCYFnU1fQ4fBzY1RaTgEGu4QB3/lonO/ksY+CLmpYJ5jOQtQt/37fZPzjCB+zua
         +VCeZ1nj4CwwgpL+jWDcMuhbGtS+X/1l+Nc/nTH7SWn/JoyQBLBI70jO3+IbLek+HWHA
         Oa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=HLdV8bbvgk28WC4lX8JNb7zhPXIVhJ1dW5FwzJhgEHk=;
        b=THcMsUvzMrVH+mIJpSKApEkZ1BuxmhNlblWHWjAFtZmVlR0mpf2LTNibPFn8cS+zbd
         pZMxE/YpXr6PPFBftYP+ARr62GfTrTIarN1b/yc434Rw7zBsQWyeuXSFZl28EhaB4n3a
         K7xGKW11K5iId3hHbAK0rktdjR+mS6n0orKF9uIEWhcPPKFlxNa1VMk3GARmxM3F46AV
         mIZCya8nUZnVIB2ffOL4jfgLaAT9VpaJif+bJ3rCOH4aAwiVN2KJDNZrcbxK2nT0ePmA
         GIqS8Ro18QZuomNIxM/Ri8Icj74TUaT1Ub3AoZWUMJJPwX5R15BTShpnt8nV6DCiYllU
         7Dsw==
X-Gm-Message-State: AKS2vOzjFNeZ+7jEs/ZZK4EykeMfwkSRFuxdXuxi1sZ50x8GAEfhSwOQ
        EIoWkSEwqwFCnw==
X-Received: by 10.99.155.1 with SMTP id r1mr357881pgd.273.1498100490685;
        Wed, 21 Jun 2017 20:01:30 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id d185sm263322pgc.39.2017.06.21.20.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 20:01:30 -0700 (PDT)
Message-ID: <1498100480.1687.2.camel@gmail.com>
Subject: Re: [PATCH/FINAL] status: contextually notify user about an initial
 commit
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        peff@peff.net, git@vger.kernel.org
Date:   Thu, 22 Jun 2017 08:31:20 +0530
In-Reply-To: <xmqq1sqcn568.fsf@gitster.mtv.corp.google.com>
References: <1498012463.1487.2.camel@gmail.com>
         <20170621023729.3200-1-kaarticsivaraam91196@gmail.com>
         <1498055714.20886.1.camel@gmail.com> <87fuet8kbs.fsf@gmail.com>
         <1498068974.32360.9.camel@gmail.com>
         <xmqq1sqcn568.fsf@gitster.mtv.corp.google.com>
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

On Wed, 2017-06-21 at 19:10 -0700, Junio C Hamano wrote:
> You can check by downloading what you sent out (I showed you how in
> the other thread).
> 
> It seems that there are funny non-breaking spaces in the additional
> text below "---" but before the diffstat, but they are not part of
> patch text anyway.
> 
> You seem to havespelled "Ævar" differently (perhaps difference
> between NFD vs NFC ???) which seems to confuse mailinfo, but I don't
> have time to dig into it myself (it is quicker for me to edit your
> Signed-off-by: while queuing).
> 
> Ah, wait... it's not like Ævar is relaying your work; it's more like
> some code / tests were given by him to you to incorporate into this,
> so I suspect that two S-o-b: from you two should be in the reverse
> order.  I'll swap them while queuing.
> 
> Thanks.
So, from this I conclude the following,

"Never user e-mail clients to send patches. They seem to be bringing in
all sorts of surprising changes."

This is just a consequence of not following the advice in
Documentation/SubmittingPatches. This won't repeat in future. 
(expecting, I could hold to that statement :))

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
