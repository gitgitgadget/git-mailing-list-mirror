Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0977201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 21:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbdF3VbD (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 17:31:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34677 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753035AbdF3VbC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 17:31:02 -0400
Received: by mail-pf0-f194.google.com with SMTP id c24so3717645pfe.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 14:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RhIQhf+DY7PgGca3IJBo1dSx1k7p8vgEIK8pKP+xf4k=;
        b=E/RiQSm4RBUnebctJYC2wHaJEKBbzv6Mtzm7aFJXu/z0Ngwp6XDFf+Fhj04lDnuviD
         MVrCP1GJ/E/SWbOUKtouqFiQziaP2ZPTlKAVzHI8ev4wy5DiCriTP7oteOvQmQgVXVPC
         3ff6II4Q2PTr+Z8IkQvqXIxaonwBmUa/gcI52fi2aI6Jt5scs3eXNIIHqkI6bHOQYfbh
         lweITqJi/UYDV3yQOTvutNZFdquaP+qn4HZWaRGttSBkGUBmN/Nq1LktEgCQ6kFRlRXT
         +V8zjQaxO+p4h0DNFZrmC+4wob91jNPkI+hqgelLCXmjx6vPLzH0Kb++mlww8vBCAms4
         +aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RhIQhf+DY7PgGca3IJBo1dSx1k7p8vgEIK8pKP+xf4k=;
        b=GnAX5N0MOydlPDFAYP5bJ9EaoCliAymZ2Pk0+S4sB397jQzsQwudx/LMoyI/MPT7Zz
         y58PsTOCxU7WZKV8op0ZAhM/0TaG7KqFarIEPXDeQ+rtejDErao2hnAH1RrM23bjc5Md
         Wwp1lN4BG90Yxu4R4DFrMPuyvxDEMEtYW6PRLzJ1vCqSMn32AHBuaXsGYmGACDR+II+V
         NEGQ17OdoZQZxSKcFTyBoAleMy07LsHPotvTE130NZqcljsdSUyxBOaywMpS/7syazM2
         bbxTyils7JBuOtR5Pc3RFZkRmQg3mXL+CG5a52bVRQFkd8UpY3XD0CHGtZLSDUnATzl0
         cb9Q==
X-Gm-Message-State: AKS2vOxI5M40YJNp0h7C3fICSTK3/jsVa3qboaOABZtbSRb/reelA8pU
        1OZKc2cK7K7F/A==
X-Received: by 10.98.32.200 with SMTP id m69mr24554769pfj.5.1498858261752;
        Fri, 30 Jun 2017 14:31:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id o73sm19956848pfi.2.2017.06.30.14.31.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 14:31:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v9 0/7] convert: add "status=delayed" to filter process protocol
References: <20170630204128.48708-1-larsxschneider@gmail.com>
Date:   Fri, 30 Jun 2017 14:30:59 -0700
In-Reply-To: <20170630204128.48708-1-larsxschneider@gmail.com> (Lars
        Schneider's message of "Fri, 30 Jun 2017 22:41:21 +0200")
Message-ID: <xmqqwp7tp3ho.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Will queue.  I personally feel that this is polished enough for 'next'.

Thanks.
