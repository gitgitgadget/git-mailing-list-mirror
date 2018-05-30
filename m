Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDEAF1FD4F
	for <e@80x24.org>; Wed, 30 May 2018 02:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934562AbeE3C6D (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 22:58:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38203 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753315AbeE3C6C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 22:58:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id m129-v6so44734693wmb.3
        for <git@vger.kernel.org>; Tue, 29 May 2018 19:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=EugsZswn3pvso+GSEWr4+rZyPDPFbEcyxc2Gp23affI=;
        b=sKodq5NQ5RurLdPdVLDGvn7ddPDd1Mc/I4gCKIJsWQkbq90A4rBZCHcJzapfQYkVlz
         +uS0lmHhverFkvFqBMyg2z0e5TgxX8J+sGTeZLvWX5UOAKlCwzXO+YWqcvIdyM9ET4a/
         L/EGNkzh0b6pndO/2RJxEkwguOZ8Uk2L4SzVurzwnDgixXh9jSNE8BkiR5wHLXyxHwh6
         Lx+ju0/AZXHlc6Ui9/GVClh4aP7osh4AONn6DvhJJBxCZhRfiU2APJ+hD2GZWINe8ME5
         VUg+9Pu5nqqn35faIhFLASVQt0DrD54WqCNAbm7oKHsktdHcmjmLdTLQsaPk5jt5y3A9
         ngQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=EugsZswn3pvso+GSEWr4+rZyPDPFbEcyxc2Gp23affI=;
        b=tydnh5GGCkPouXOQqfGkWB5QHvWqrRvn08BeAFX0WYvnxPR6lz0zsXe8OTNChLjlJ5
         4+ZLTcIZSOIjydy7RFWaA282uUSXy4629Lo7vIHVeiygX+sQ6F8iMi3y9vL2tgGkrwCT
         TMd6wlvZnpY4cl22Qw94MQXKN5pBLIE8LwG2a7wjmHoDuatqmPUeDglJPh/u+3XGeG90
         Nb/Bf1UzYspx76l/I2BJrCIFWt0uowdQNiI6tTZW8uFPqnrwt5DhGDwLF+++lDo3SKnt
         +dksNuTofhADeNO8bHTEXWCih0SveuBfhYhsL21ouObfhtH1+I2OQra90wUfB2uX7ZzQ
         oD1g==
X-Gm-Message-State: ALKqPwdLi5zhrZ+VhtXNLXPJMeLBfaZSP8PY/SghQxogKVu/mpGw0t6+
        eY/QyU6qxRPRRcInhG1Zu44=
X-Google-Smtp-Source: ADUXVKI+5+7TnEVkxCp0A73b+cw3eh5Ju1/aJow8dh6mVmb3truSqkIyGHFBZSWMB2GpotedyGPWgw==
X-Received: by 2002:a1c:9712:: with SMTP id z18-v6mr82386wmd.28.1527649080524;
        Tue, 29 May 2018 19:58:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b15-v6sm29766674wri.14.2018.05.29.19.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 19:57:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] fsckObjects tests: show how v2.17.1 can exploit downstream
References: <20180529211950.26896-1-avarab@gmail.com>
        <20180529212458.GC7964@sigill.intra.peff.net>
        <87a7sif7is.fsf@evledraar.gmail.com>
Date:   Wed, 30 May 2018 11:57:59 +0900
In-Reply-To: <87a7sif7is.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 29 May 2018 23:59:07 +0200")
Message-ID: <xmqqvab5etoo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> The receive.fsckObjects variable only kicks in when someone pushes to
> you, not when you fetch something malicious and someone then fetches
> from you.
> ...

Yes, that is what was described in the release notes as the server
side support.  If you want to avoid fetching from contaminated
sources, that protection applies to both leaf clients and
intermediate relays, and I tend to agree that it is worth helping
those who want to use fetch.fsckObjects (or the blanket transfer.*
variant) the same way.

> Unlike documentation, when we change something in the code we're forced
> to take notice that the test suite changes, ...

But then the test you want to have is not the one you posted, which
is "when disabled, the feature should not kick in and should not
protect you".  That, even together with hot-sounding word "exploit"
in the title, does not have enough sensational value to grab people's
attension as you seem to be hoping to do here.

A test that checks "when enabled, the feature kicks in as expected
and protects you" does make sense.  So is (maybe) additional
description around fetch.fsckObjects if we currently lack one.
