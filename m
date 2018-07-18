Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822D41F597
	for <e@80x24.org>; Wed, 18 Jul 2018 23:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbeGRXya (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 19:54:30 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:38624 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeGRXy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 19:54:29 -0400
Received: by mail-wr1-f50.google.com with SMTP id v14-v6so6213344wro.5
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 16:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L05AEdowP2f/wy68EhUVXEx645gg2NsxhcBvYwVXpAE=;
        b=SkaeajjX7tyLpmZg+85ln4vDQQzkBovp0TovcL9ezBSvidoirR1qfQxf/QFYJrwadL
         2835uFt2ckYeBy1Mu0tfU5NB5YuYkXvHEbBUHY6D8tGs2iA9ixl67W+BWQVBnKvb5I7S
         geZC5ym4qfH7TcJJr06a3v4f8naqHISPgj3zdJCYakk8x1CHcFrtu3LUIp0eI3gl1mIw
         5+/7tRKqGhY3inkVaa4yjUTAdSUpoPBn7AgCHoU7MgBlVetbDEezCId0sIAJEtnUkSIq
         fxFUbojcgQ3qNesgfLXVo5aE60oYvTGEY1RctXaauZbD6z024OCpVOtZ0+7B3mKpjqKo
         A66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L05AEdowP2f/wy68EhUVXEx645gg2NsxhcBvYwVXpAE=;
        b=pRLTwQ7+Zbm7Qd11FkSYkPrYi/7e5HRBYVxsXDwc0I4OmmdUpjME30kgM5jvL4wv+Y
         OTpXDSnG6W6+LN/q/od4TS/pgkF82+7Q6nYYa6IIxfmflzsJeh/8sOe9CeyKcs19ybJU
         Lj3oRmEcU/d01kGBuJewbYSKuXn+IFUIJiRdQ6eettuPq2NMQINJKuJDUeb/1J7mA1Dg
         IS5hssYxHn5hS3Tnd5S209pzf/q7s2PJnRbGjC6fQGmvn93hP/2YO+xcJH+sVtWuBCcO
         cYdoHGvtoJTK1a+8OaN4juO6Y7XDRSqgK4MsMgfrvIfPxhLGkzbLlQKqWl+dZRceL78k
         G1wQ==
X-Gm-Message-State: AOUpUlHcqErBqzp+yRK6czxD5E5U0uiwHonx5mODHiIhEHb20zbPY5JL
        +jw2SRnNzknpWCqqoMMAi0Lv7s9V
X-Google-Smtp-Source: AAOMgpco7umn9GGv7Af6L4N3D+MuOHcHIocygLvGLWAg9ciBaQgyH+s1NIXAorTcGAaanbHrPWL9cA==
X-Received: by 2002:a5d:4acc:: with SMTP id y12-v6mr5362954wrs.132.1531955658614;
        Wed, 18 Jul 2018 16:14:18 -0700 (PDT)
Received: from [192.168.0.137] ([82.78.255.161])
        by smtp.gmail.com with ESMTPSA id b13-v6sm6770892wrn.17.2018.07.18.16.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 16:14:18 -0700 (PDT)
Subject: Re: [RFC PATCH 5/6] sha1-name: Teach `get_oid_with_context[_1]()` to
 be gentle
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
 <dc1abfca46cd536f060b9097b9f2d1a64988f932.1531778417.git.ungureanupaulsebastian@gmail.com>
 <xmqqefg1oeuk.fsf@gitster-ct.c.googlers.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <2763ef16-cbbd-e371-4522-9948a1f05812@gmail.com>
Date:   Thu, 19 Jul 2018 02:14:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqefg1oeuk.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

> This points us back to "only-to-die" which was "gently" before
> 2e83b66c ("fix overslow :/no-such-string-ever-existed diagnostics",
> 2011-05-10).  I think we have to keep them both, as only-to-die
> means more than just being not gentle, and we cannot revert the
> renaming s/!gently/only-to-die/ done by 2e83b66c and teach GENTLY to
> more codepaths, I think.  But I might be mistaken and we may be able
> to get rid of only-to-die at the end of this series.  I dunno.
> 
> In any case, what's the reason why this new "gentle" option is
> incompatible with "only-to-die"?

"GET_OID_GENTLY" would be used in the case we want to handle
fatal errors, while "GET_OID_ONLY_TO_DIE" means that if
there is any fatal error, we can just exit. They are not compatible
because that would mean that if there is any fatal error, the
program should die and not die at the same time.

Thank you for taking time to look over these patches!

Best,
Paul
