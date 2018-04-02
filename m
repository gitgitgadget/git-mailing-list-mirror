Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E623E1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 18:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbeDBSdA (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 14:33:00 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45364 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbeDBSc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 14:32:59 -0400
Received: by mail-wr0-f193.google.com with SMTP id u11so15033309wri.12
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=J1hSbS9Wgw53iTVfbE0WolQwG6KGsx7P8EAXUCZyGmc=;
        b=hVVBdgRhdoYyTvhUvia/FayTXt91tBc3sOIo8VlAbTtjh8zCpm9Tc5vVRMSjLhveQo
         Q9XaSxff1D4mMzvjXjwPWb21g95aaSZzmWguHZ7WhT8EDMZ4bgdWhT+yVL0RaroHrdJg
         HNzo/+9bG0U1Abf42f1ayuffKFfIToOqX8vuKmPMKjZpxAcA2yOXGtczdvpBnjVcY3LA
         i9BfSqkMf/29xITL7YBvXtP8cjYQCXa6xeJcn2+oxqO7cqHKyhGvb/NdfNhavnTdG5PL
         9DPJ7KQCoR4OINFY2LTIinwvYvgj+KPDLv1F5gU61Y9puU5Nb8S8+acsON/XpmD89SyM
         4/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=J1hSbS9Wgw53iTVfbE0WolQwG6KGsx7P8EAXUCZyGmc=;
        b=LLxzqbBqlNvgIFhGXNA5T47gERW9Qn14qAoMIRqhZSCvO23bVWuYzeDPk8MSCh0lPy
         HpyR5MoRpPug2oxDoORCpiy8ryzSTKasgT7B/6tr9eBJEVoQQMWdHyuk++R3qDheq0tc
         luYi5df3JnPbqrXyUqj2UMto6zcIn4R/QdKnyFYqeUgqlzDd4C1Pv4vwozpAVGDXeLHg
         8X6/f+UYekxIv5hcykavhrtBYtyiFwhjhaHkAFS75+2pG+j6PQHOFLY7yR3t+nPfiTMu
         2Ca4V97dsXxPFbS5sM1t0AtbOcIE9KdSdIs4Da/io6YjpsltiE4C9QH2t7OhXtlC/je8
         6pUg==
X-Gm-Message-State: AElRT7FoX5lDr2F+MOCLm/3cKkCOBDmCUFxGcJvr8Sn/6OO+fiCsq+od
        aAUHeisWbcvWlH1rj79M2DMROLGg
X-Google-Smtp-Source: AIpwx4+yWUM5T3DR5TYQYEO3PnvwyB5mQF4HETreLMR5sj6yNjsmV1mJqbGuHjuMoFWKcNnFzjXNRg==
X-Received: by 10.223.128.40 with SMTP id 37mr8007507wrk.73.1522693977800;
        Mon, 02 Apr 2018 11:32:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b185sm122819wmb.48.2018.04.02.11.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 11:32:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ls-remote: create option to sort by versions
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
        <87605aw1ue.fsf@evledraar.gmail.com>
Date:   Mon, 02 Apr 2018 11:32:56 -0700
In-Reply-To: <87605aw1ue.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 02 Apr 2018 08:37:29 +0200")
Message-ID: <xmqqbmf1zcfb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> This is a sensible thing to want, but why not follow the UI we have for
> this with git-tag? I.e. --sort=<key> & -i (or --ignore-case)? Of course
> ls-remote doesn't just show tags, so maybe we'd want --tag-sort=<key>
> and --ignore-tag-case or something, but the rest should be equivalent,
> no?

Yeah, and if we can reuse more of ref-filter.c machinery (which was
factored out of for-each-ref and tag you suggested borrows from),
that would be even better.  In the context of ls-remote, however, we
cannot inspect the object (we typically do not have them yet), so it
may not be practical, but I agree with your suggestion---we should
match the behaviour at the UI level at least when we can.

