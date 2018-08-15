Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45B191F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbeHOTDx (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:03:53 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:33035 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbeHOTDx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:03:53 -0400
Received: by mail-wr1-f45.google.com with SMTP id g6-v6so1594666wrp.0
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V9dJSJbpeC7DtATIY1ExvZHgjKrJpZsg/ehC6a2+H90=;
        b=FqR3/46UQtecdAQRG0ow8zpVCpIV/LRR/uuHbhIEguAJHHCgBCZo3L/5XVk+j8H4Uo
         0w/ZqJqPW1kNIBchsOp32z6/RfuTMcE/dnR2oiiC2lKSgYIRSJbJuFv8RIvRX7j/PU6r
         U1gm4rqi1Hau/VFtI9wdA5LDaOk5cTSrkN72sxot5WIKbVkOr8S7W70xH+LO/bpQNbl4
         BraIzkng7K0diccaULf4KmuR6oVuC6OlUPziQgbzc9kNkMCAvfZDWWNipogCiR0cxFat
         7YvFciX0Paitt6as9OB5NYnyGsRXMvX9IjBCl3TwrwvyCdXE9xHOrKD9kgj/+Tjs5LqP
         dSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V9dJSJbpeC7DtATIY1ExvZHgjKrJpZsg/ehC6a2+H90=;
        b=GUw8NegrlZBSDUxslteo/MZdPzW0MHIshLerAR98YZJVZp0NmwjGSrX1erJjL77XNh
         QSqfIRFTQ9sHLxzUn5pbhvIkYKVoMuzlybM/4cCiTpQ6yyNH436FN3F9CPkC/TEsM48G
         7rtzGOANkFWyzwEDaPMbthg2Lcs+ANbzhboiIEuVmfkX1nyBdT6DfAErIAmRlOsGoAEE
         wUKPff8qDrtiAAk3kwpcaAdnY9nyQ2eDYfceMgb06ziCll4Qo5KfNa0mR99n6S5Jwzmn
         k6UwzG8C4Y5M4QOLxUQ+S9k2RpWC91GcIaNLjo8cR96sN4aJypq8hq6GAQ8Um2MW25xd
         vKqQ==
X-Gm-Message-State: AOUpUlENpg7YmXoVXAEdV8Dy3wbYuI3T667E8coF7RCYPh5lqQ4Tc91Q
        xmf+0a8PrHiHZ8eLfggDH5n+7Q6X
X-Google-Smtp-Source: AA+uWPwX9YrFnBR8hO3DaxKcBWxkVsGCr4NKxhqji9vJBQteKx1SQRl2jA4oPwl5OH5SSLk8nU3XTA==
X-Received: by 2002:adf:e3c5:: with SMTP id k5-v6mr16114560wrm.94.1534349466436;
        Wed, 15 Aug 2018 09:11:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r140-v6sm3348478wmd.7.2018.08.15.09.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 09:11:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, danshu@microsoft.com,
        marc@marc-stevens.nl
Subject: Re: [PATCH 0/9] Add missing includes and forward declares
References: <20180811043218.31456-1-newren@gmail.com>
        <87mutts3sz.fsf@evledraar.gmail.com>
        <CABPp-BEADR15gOrH+GBQxKLZR2fCQwhaPWgf3VS--Z0bTNP0rA@mail.gmail.com>
        <20180811173406.GA9119@sigill.intra.peff.net>
        <xmqqr2j25dlm.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHZoWn-mZjop+n9PJ0+A4tZFrU6vJE+A7iSeHDXcDc=Yg@mail.gmail.com>
        <xmqqftzgxjww.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGtuxmeLTFTmsRvaK6J0jA9Sa3wx3rR0Ov8nJkxL4aqqA@mail.gmail.com>
        <xmqqzhxnmy9m.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHLa2vEGHMc28pEAC9tVmQjpsrTKivCNof0MX-fQMOCRg@mail.gmail.com>
Date:   Wed, 15 Aug 2018 09:11:04 -0700
In-Reply-To: <CABPp-BHLa2vEGHMc28pEAC9tVmQjpsrTKivCNof0MX-fQMOCRg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 15 Aug 2018 08:55:39 -0700")
Message-ID: <xmqqzhxnk3tz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>
>> But please remind me not to merge this round down to 'next', for the
>> "enum" forward decl gotcha.
>
> I'll send out a new round shortly.  Would you like me to squash the
> last patch (the one that had two hunks with minor conflicts with other
> topics in next and pu) into the first patch, or would you rather I
> dropped that patch and waited to submit it until later?

Either way is fine, especially if you looked at the intergration
result from yesterday and resolution of these conflicts looked
reasonable to you.
