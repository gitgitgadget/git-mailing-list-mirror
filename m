Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B83D20188
	for <e@80x24.org>; Thu, 11 May 2017 01:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbdEKBMd (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 21:12:33 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35798 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753485AbdEKBMc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 21:12:32 -0400
Received: by mail-pg0-f42.google.com with SMTP id o3so6074852pgn.2
        for <git@vger.kernel.org>; Wed, 10 May 2017 18:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cmLabWp1M3nsKE9ByeDCV03CDgR+piiOuCdyWFFrTPk=;
        b=bEz+k16ezrvq2qrSKkoHccumrPfxEUQ5uYeyAbGm0qanh4J0H8jw+OGWQmDjbqEIOY
         okn5+WmCN6HSqBnMYwO89JuIWBTtELypgnL43WRaf1DmzHbEIlkP9seZ4LCcP/E8qtEP
         VXB0qfBpV8NTFyfGsU8GwQ9h9PwPOkU3RBxJbHPDaSqmvAxafp7IBYmWHVJVKBLq2Y3L
         dxQoU61dNEsXNI2rANlmGepSk6a9wS2C2yX08e60fVL1BCED46LZhX6Zj6sHOyzlNtbh
         fXolOI9KxFdMxi6Md6dtnKt3zLXcCxtDNTue/2covixCLakJ9hBHSLzTWEYJPGSBTSqW
         8SVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cmLabWp1M3nsKE9ByeDCV03CDgR+piiOuCdyWFFrTPk=;
        b=fFDq6UQJfbvtdHzdQbGi/vqdEHcQzCKv45OmuU9xPhBslqlMlr6IxVkbDyNowZUMxA
         46RNF9vUb/9t2xk8WOdlxoBGh4r+K2ZJbvetudDHpPqLiUzaaGu4vI9YRswTxsPLue+X
         tqneq48bkXbam13B7ViK+MKE11i0XyYEuJL1Wo0Jj+pH2HblFjK7KI4ksNwUgN/DVa/i
         LHWWLP/BqGEDSXr7C3H/EMI1NbmOHTwj+s+pPi9YcxGnr7mP1Tcfai0rhYkGWgYqt2fa
         H4kGb22pU3CjCpTzLC/JPaA9GmwbT5eVWoHsQz3wm9Gk9c02n0RxIfptfWuQxR4fzhYQ
         ovyw==
X-Gm-Message-State: AODbwcCkmrlOTM2AeOT9NtIw3/QoJeZibz6EnnsghzxrRbSy0XVnSTbx
        +7+yjdkyNp5xzQ==
X-Received: by 10.99.104.199 with SMTP id d190mr9380184pgc.141.1494465151767;
        Wed, 10 May 2017 18:12:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id s186sm186766pfb.98.2017.05.10.18.12.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 18:12:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: What's cooking in git.git (May 2017, #03; Wed, 10)
References: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4F2TL-kZj6y=00UTEhC-4VeDLm1EYOe2_eK=hscSdJ4g@mail.gmail.com>
        <9774445.E3R3CqpI8C@cayenne>
Date:   Thu, 11 May 2017 10:12:28 +0900
In-Reply-To: <9774445.E3R3CqpI8C@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Wed, 10 May 2017 11:04:20 +0200")
Message-ID: <xmqqlgq4w60z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-Noël AVILA <jn.avila@free.fr> writes:

> Le mercredi 10 mai 2017, 10:08:14 CEST Ævar Arnfjörð Bjarmason a écrit :
>> > * ja/doc-l10n (2017-03-20) 3 commits
>> >  . SQUASH???
>> >  . l10n: add git-add.txt to localized man pages
>> >  . l10n: introduce framework for localizing man pages
>> >
>> >  A proposal to use po4a to localize our manual pages.
>> >
>> >  Will discard.
>> >  Has been stalled for too long.
>> 
>> Jean-Noel: Need any help with this?
>
> I restarted on this yesterday....

OK, then I'll discard what is listed there, expecting that we will
see an updated attempt that we can queue in the future.  No rush.

Thanks.

