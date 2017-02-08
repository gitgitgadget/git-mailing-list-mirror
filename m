Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB991FD6A
	for <e@80x24.org>; Thu,  9 Feb 2017 00:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbdBIALj (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 19:11:39 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34753 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbdBIALi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 19:11:38 -0500
Received: by mail-pg0-f68.google.com with SMTP id v184so16151154pgv.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 16:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sC1DhybxzaO0zQw3/ywPDJkxef6pvd08tNQa0uoxSbo=;
        b=KKds3RoYlOJF7a843bt/KarmDDjxqMk0eQ7bVcIex0OcPZczNx4TtD5y/FPcNPBFA+
         dVXetypAFhK8GGG+2+dEOnWQELN7qbfxw+4AWWpCkbdi8IeUHuudT1GYZ9QPAurLEj9H
         0HjqNQPB6X0AvwjWBiyGRGhIEqvRsox06AcuTbgwO6qjzESWxNyu8MuMk7IVaxWwSph9
         IKfDnm7AhM5lr5UB/U0XCZbGJ7IAbWl6rg9J+aD7lzFArNTOl8Qd6PdkIY/A5DMDVTCf
         glm9P1MNISzGTeD3s6jfCgedd2uuOzcj+dY+ZJGePpR1SCTUysaAICwMMrgggOanrNXY
         rftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sC1DhybxzaO0zQw3/ywPDJkxef6pvd08tNQa0uoxSbo=;
        b=aPyWRB7gCEsQlRi05BPazPTJTyqhbHRQwUZ+ETAPXGrfNLKec0DHNlPakiSqCgdndA
         C3qK5YpvQhix2+yPQuYRtt1hQ09GsX+pHXhca++gMxxlgK0d+1mmMVu4Xnzkyev0ocYp
         bJqtfXRMOJd863EcOnU6StF0TnFi6lhQWcOP7LsPH1tUG0i50fvS0LO5PBjtj5/lMcsR
         dgSu1WNxBkW5XxEn4tTuk98TQxvEVosl54uBoxOrphqoI9N8a4/+fUg6v2m43eDRSQeO
         RvNsnyZnFX7wEjL4HMrDR9E/6UrZ3Qeq9GEQGfurkeQv5cYn5gUO3izzkQLYoZbqxx7M
         uHug==
X-Gm-Message-State: AMke39mEUPLLbIX9qj764Qi8sIHVRvXSKKVUM0F5KSAubpxEfBnNDrttOkjT8122KOL3nQ==
X-Received: by 10.99.160.1 with SMTP id r1mr162581pge.171.1486597475471;
        Wed, 08 Feb 2017 15:44:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id 66sm23082712pfx.29.2017.02.08.15.44.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 15:44:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     git@vger.kernel.org, karthik.188@gmail.com, peff@peff.net,
        bitte.keine.werbung.einwerfen@googlemail.com
Subject: Re: [PATCH v4] tag: generate useful reflog message
References: <20170206222416.28720-1-cornelius.weig@tngtech.com>
        <xmqqpoiv15ew.fsf@gitster.mtv.corp.google.com>
        <20170206222416.28720-2-cornelius.weig@tngtech.com>
        <xmqqshnov0c4.fsf@gitster.mtv.corp.google.com>
        <d0170d3a-3022-3bca-7c80-7ef0b1cf62a0@tngtech.com>
Date:   Wed, 08 Feb 2017 15:44:33 -0800
In-Reply-To: <d0170d3a-3022-3bca-7c80-7ef0b1cf62a0@tngtech.com> (Cornelius
        Weig's message of "Wed, 8 Feb 2017 23:28:37 +0100")
Message-ID: <xmqqfujotfha.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cornelius Weig <cornelius.weig@tngtech.com> writes:

> A version with revised tests will follow.

Thanks; I think this is clean enough.  Let's queue this one and
advance it to 'next' soonish.

