Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C4A01F404
	for <e@80x24.org>; Wed, 28 Feb 2018 17:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934032AbeB1R5a (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 12:57:30 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55507 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934702AbeB1R5N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 12:57:13 -0500
Received: by mail-wm0-f66.google.com with SMTP id q83so6704369wme.5
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 09:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8UJq6C6IcA8V9zasp+/E43tXFP77F09hLlqK+D+WAl8=;
        b=uIFW1A9C7FWyvQJw8evXLFGieRRvqCKt8PdAqXSBPeZBigMgBz2re4117uzBtL508h
         qUvl+W9FqmFE/WctcFVQ0al8bhT1a9bTz3ePG9lAaSur1TIvcOiSOxWwUc+633h0LEUC
         rddD23vijkSJkeoy0ANXvRhsFEwntjEr3CAyrKywPYxL+2OuaXyfTl47oaNXr0OGCjS6
         ai6aN9S+BJzvBBK58u3BwjbnEocaHnpeJ7QXm07BGM5dyNhclYIluJqT3cnOxw/ZHs1I
         YGBdq5Q7VrSCHoWEQND9vILpm+//e3Ceft2F06k6KZoEEyu7EnyLHuJ6YxRPyUBfLS24
         NVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8UJq6C6IcA8V9zasp+/E43tXFP77F09hLlqK+D+WAl8=;
        b=OMRmchNivsrYwZ3CnK8VsCnpU1pwtfC9vLQ+gtZ/8o3pgzr7K7kKqYCgORrm58N2t/
         Q0XxRiXXFfxddtB27EPU0z/NK6iSPoXD0wZs1HzsASOu/vl4rAqzdKeKM6dLJTaq1YxR
         f6/GZoYGTuKhrYt5/vKqW7vqToa8JLSHM7bIH5luku6rVL1pq+IrF325cX7uIRXRpmep
         wmusFvxSW6up4gXeCAInfEgGhFVxPoXbAszWUna+AY8PSBBRTjSwyWdl045yfS0dsfkz
         nBfYdbv7h26SUzCITmO6D265wKzUBaz5fH3mVy7Enmy4VM6UqieA4efYggr8s0qVafIJ
         jHJQ==
X-Gm-Message-State: APf1xPBjxqx/+xGooI+KVOdJhUY5AJMcmyYKF2PmzIIv+jrJzljd8+4W
        Bdl62GejxXGprA1PTg7mre0B97R5
X-Google-Smtp-Source: AG47ELs/Dj0gi67Jpv6nkEvrAJnyY/8/0wPRi22Mi5zJXXhUgiJ3FktloAlLV1Bb43Gt7195Ig00gQ==
X-Received: by 10.28.213.68 with SMTP id m65mr13907728wmg.130.1519840632019;
        Wed, 28 Feb 2018 09:57:12 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 188sm2436912wmx.12.2018.02.28.09.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 09:57:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH 00/11] Moving global state into the repository object (part 2)
References: <20180228010608.215505-1-sbeller@google.com>
Date:   Wed, 28 Feb 2018 09:57:10 -0800
In-Reply-To: <20180228010608.215505-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 27 Feb 2018 17:05:57 -0800")
Message-ID: <xmqq371lm1zd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This applies on top of origin/sb/object-store and is the continuation of
> that series, adding the repository as a context argument to functions.

Wait a minute.  Is that topic ever shown to work well together with
other topics in flight and are now ready to be built upon?  I had an
impression that it is just starting to get serious reviews.  

Sorry, but I am behind ;-)
