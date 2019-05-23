Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0900D1F462
	for <e@80x24.org>; Thu, 23 May 2019 00:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfEWAsm (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 20:48:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34769 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfEWAsm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 20:48:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so5873424wma.1
        for <git@vger.kernel.org>; Wed, 22 May 2019 17:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=+47TQCMi+ISKXN6B5P0emI4Z19ie2yC6T+H5pxCzAcs=;
        b=m+RTwpP5MfHpZAX75ZZ4NmCw4HwvcIqI6H1eenihl6wAJLpeVNPs5CgsVxmGPjhGlc
         Z3hK/3t8AAV+ClacRwGExs9Pszf2t5RaAui7lhjjTmCCPmSVo8nS2+brFeDOphk45hCZ
         3M1ParsFLTKPkLPZWj5qZNIX2wXVb+cV8vQZMc1rsuO63gCxGFqLkRNdhA4RPtmbvi01
         eRh6wTrP6YmlfTGFaj/LR3ejmwdn+N6XicfIrh+nXRxdpJQCYAaKpoy4J3m/9Mh44dLV
         1NLT5JQPy64f+/9C+StHkIHN7ej3wqbxrO6k8Z3VLbrPwj+5ZPu9FNU3q4A7ej8G0hiC
         5Kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=+47TQCMi+ISKXN6B5P0emI4Z19ie2yC6T+H5pxCzAcs=;
        b=CNt9WVF16813n0pU5JDGu4C0gkkNY9J0kzZL9zsIUhWUb08MP/gue9/WWQrdwrVEX8
         pzNw/p/7JF8yrqyOzutgO0sIHSWOC5KVO27DklwHN2JgHcRcVIplYgzqU/YfjBLxSKOj
         SKG23xiia+EuUhnTDjv18awNtq6tRQI44HkOGlZznBEeoJP9l1Bx0+A0b4MWs4vtw4e6
         Tce0FiQmfASXF83+w6t0W96Kj+PfoXqvcjGsR6xRsAhWwHRAXl+/hld9EU4dn9QRGEF1
         bcOmf4rif0T4evg1UdNk5jC73G7wmVClo3kiTOW3goli8kXoMaapyIiCLBrtOKBrRp0m
         N5Bw==
X-Gm-Message-State: APjAAAWIcRv8D9o2E8nJgJSeTVkVfCMut8LIKNd0Wuo02fLThUgvEbn4
        MGDCNt5/UYRFbSdApO7YEfg=
X-Google-Smtp-Source: APXvYqxlBfPTD+6g2gmvZytZe+R0n0H1ts1ZSK4DgY+sMk2680FLDP94+99qTwrU5Yqmlw0KPhBlww==
X-Received: by 2002:a05:600c:551:: with SMTP id k17mr9336508wmc.35.1558572519888;
        Wed, 22 May 2019 17:48:39 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id m16sm5779965wrb.5.2019.05.22.17.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 17:48:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Add an option to suppress adding a specific email address
References: <87d0kaj98f.fsf@xmission.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <87d0kaj98f.fsf@xmission.com>
Date:   Thu, 23 May 2019 02:48:38 +0200
Message-ID: <87y32yt2qh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 23 2019, Eric W. Biederman wrote:

> Make it easy to suppress stable@vger.kernel.org.  Long story short it
> is desirable to have ``Cc: stable@vger.kernel.org'' on many bug fixes
> sent to the linux kernel.  It is not always desirable to actually the
> stable maintainer immediately as the patches are still being reviewed
> etc.  Actually cc'd the stable maintainers in the linux kernel is not
> even really necessary as they will always find the tag after the patch
> has been merged in the commit body.
>
> So I am adding yet another suppress command "suppress-addr" that will
> take an email address keep that email address from being automatically
> added to a destination the email will be sent to.

I have a rewrite of much of the adjacent code queued in "next", can you
check if applying it to that branch makes this work as you expect?

Whether it does or not, this change should have a corresponding test
update to t/t9001-send-email.sh, so we can just run that to see if it's
doing the right thing.
