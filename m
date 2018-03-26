Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E0A71F404
	for <e@80x24.org>; Mon, 26 Mar 2018 19:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeCZT1a (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 15:27:30 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:52824 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeCZT13 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 15:27:29 -0400
Received: by mail-wm0-f49.google.com with SMTP id l9so17562247wmh.2
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 12:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Gsdpq/28Ml1GVs0jaNcKk2B39Z+rEGmxaeZqXP9Vkmc=;
        b=UCkdXm4rh4GZN9sKNpDmcB07ADh6Um2bkZODBm8pJORabqqPaHigH62BDW96RYdw7p
         SvEtiO0gKHjR/GYG8FSTZBwqYYrCSJVGZF5WEgGWeoGhD54tucB8dSwaOCvAjH97TF43
         2fScdVP0OJ5F1oJQaTONI2wbSf2L0UHWfRrsKgd45sfHRl10bCYwMZFW3cTOYdZQDWAf
         qhCXPkcxU4bAmsix80Ym7OeX0E3B/J7XyNpJigncjarz8ZX1fXqAIgq4zZVTvb6QN6Fg
         50cjmIH11IXy7Qx9JK9oYjiWe2NDYd9o6vHhq5p1fvyBtXJRgpv9CdBuZanpDMPRkT6s
         oLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Gsdpq/28Ml1GVs0jaNcKk2B39Z+rEGmxaeZqXP9Vkmc=;
        b=bf+GGdDjG/1EevXavjw7vkpUmPJgHADFHOirBgZELaMjVXTefHWlEJwm0uTtZ9nzyR
         v3cMzDXMbiuP9q1/X4KD939zqBRoqEHsF/7APChTZgtEYW4cJ0kZYM3Fby066TEM7ZaC
         322+33cOICG637qYyzAL9QduovkSEL13fJN+4v1KG6X+stF9j3nvrR/gZwSb4Zbv6X5e
         CoFA2mXgAjnBerkE8yOY0H2Eg86dw0zBKN932wTxg+MV2VsZwUd4g6PbXhJgPBjC2pX3
         DBArgGoUBNoU0g6dZPDmeyI4jBlubY7QDfARXkRMxrXpFGL+XrrynZmQQyvjviVZ5gW+
         O39Q==
X-Gm-Message-State: AElRT7HyhK5+9n6D6N3l/FACd1vhvHl6sUpliM/pIS7OzvaqPNx6F5TK
        YUXvf0DkKo6r+5dXQh7pJk4=
X-Google-Smtp-Source: AG47ELuVHv2/NUNIRZfmKqn/biZ9F4iobcel0X+Q+q7Z0m0kYfkG7ZnNOKCmXs2oMro5W7/8DMCQdA==
X-Received: by 10.28.1.197 with SMTP id 188mr16065621wmb.49.1522092448091;
        Mon, 26 Mar 2018 12:27:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z9sm24740510wrz.4.2018.03.26.12.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 12:27:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 00/27] sb/object-store updates
References: <20180303113637.26518-1-pclouds@gmail.com>
        <20180323172121.17725-1-pclouds@gmail.com>
        <CAPig+cQ=u2xVaptpVzVd3g_RO+9kTWVitD4V7zpZFuL+a3wmtg@mail.gmail.com>
        <20180324053144.GA11420@duynguyen.home>
        <CAGZ79kbkc2d-EHDTWP1GvCU62=ogZbP0ffxOHZamdQK+3h1yJw@mail.gmail.com>
        <xmqq8taed7ze.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 26 Mar 2018 12:27:27 -0700
In-Reply-To: <xmqq8taed7ze.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 26 Mar 2018 11:09:25 -0700")
Message-ID: <xmqqy3iebpsw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> Thanks for driving this when I was away!
>>
>> With the fixup patch, both series are
>> Reviewed-by: Stefan Beller <sbeller@google.com>
>
> I think everybody involved agrees that these two you cited above are
> already in good shape.  Let's have them in 'next' for the remainder
> of this cycle and go incremental, and merge them to 'master' soon
> after 2.17 final is tagged.
>
> Thanks all for working well together.  

Just FYI, when merging the topic nd/pack-objects-pack-struct to a
codebase with these two topics, because the former adds a handful of
inline functions that wants to see packed_git but all existing
sources have relied on the rule that cache.h is included early and
the fact that packed_git was declared in there, the change in
sb/object-store to move the structure declaration to object-store.h
causes quite a trouble.  I plan to resolve this with an evil merge
to include object-store.h from pack-objects.h to resolve this with
minimum damage to topics in flight.


