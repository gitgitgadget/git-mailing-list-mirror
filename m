Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EC041F516
	for <e@80x24.org>; Fri, 29 Jun 2018 15:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936841AbeF2P4T (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 11:56:19 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38216 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936157AbeF2P4R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 11:56:17 -0400
Received: by mail-wm0-f43.google.com with SMTP id 69-v6so2572601wmf.3
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yFP1Zzz0sVXqNjUOOz9y0I+fyU1USc0jpocOw8HXn7E=;
        b=WWbfWByB0nr/aqis9ut3qj+rg6Ury50iSqfqe9LzBQSvSfqzpFX8WuayzaNEdBRaUd
         CIMo+ZD68iyR7XYoesacxuN3h8NPF2ZpANDBcO8XfzupoeoxWMnyY5vtiGJWtRnY4lsd
         +kpVrpdzyy7XITuf5vYmsE6a/atLJhsymFyTrfeLcilqABIe+OfcfZzGNhDzxb+eW9dk
         M3NJQo0xTt2PdB1KxRO/uQPyZIBJEfh5WCbhdwGTaPxh4ocPVNyXHYEU02gDfKQ8H75c
         vslsDK8RHKjnd0CkHd5lninPvIvc7UgDom5rIm7DhB66KRV1oGBDOwpt/LWr3OBcwhIL
         B3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yFP1Zzz0sVXqNjUOOz9y0I+fyU1USc0jpocOw8HXn7E=;
        b=t6KI4g6ABjTU5tPBUvoyjVBEjg+i5onmmayyRWJvORgZZMedMafsGUxAV7DGLQNkhU
         FwECJ96lrD2j/1lVnCeXK9dIazLIwyj7kOzl6LpSqRQH0CLWGAGfWRYSRiZYTgBFzBwy
         4YxmFcvZjc3IntdDzgoKDBjIFkkyVB3TGwg3Ddt3ck5Gc68E9kAknJ522xZLwtuU6IVO
         dXpO3Sx7xySIKIV8rgPMc6aCu1oo9Czl5v1LwkJIBRSJlsBoAHf24P7L65gBsAV1IVkS
         OSnUuNllh7NZ54Py31+epB1dKOX69QteZjTXt7QvPcucrEbrlXK9D4Qj7LUO6gNXbKdA
         59oQ==
X-Gm-Message-State: APt69E0P27JgsyklYTwxUbgi/QzVexNiEhNGcF8gdyu+jZLqpAop+pnK
        jmIdk8y8hfP1L8jtIypFN7w=
X-Google-Smtp-Source: AAOMgpcnuF3IQWHd2LNjLPaT5cz3JpNTn/oI+lm5ghpmVUaWnzgqbylUS/OV+m55hg+XPDqNzyKYXw==
X-Received: by 2002:a1c:b1d7:: with SMTP id a206-v6mr2270745wmf.61.1530287775819;
        Fri, 29 Jun 2018 08:56:15 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k90-v6sm2831771wmi.30.2018.06.29.08.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 08:56:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Aaron Schrab <aaron@schrab.com>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: use configured comment character
References: <20180628020414.25036-1-aaron@schrab.com>
        <xmqqh8lmwsso.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1806291607501.74@tvgsbejvaqbjf.bet>
Date:   Fri, 29 Jun 2018 08:56:12 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1806291607501.74@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 29 Jun 2018 16:12:00 +0200 (DST)")
Message-ID: <xmqq8t6xwpr7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In short: the code is fine, but yes, I had to convince myself by looking
> through the code. (Hinting at a possible improvement of the commit
> message.)

Yup, that exactly was what I was hoping readers to realize.
