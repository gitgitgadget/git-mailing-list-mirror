Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E0CC433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 22:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39CD820748
	for <git@archiver.kernel.org>; Wed, 20 May 2020 22:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgETW0F convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 20 May 2020 18:26:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43792 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgETW0E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 18:26:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id i15so4710713wrx.10
        for <git@vger.kernel.org>; Wed, 20 May 2020 15:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0hhWhmQsxpL4UYOKj/jmurVQ7hEvipYxj7/Ltac2YBA=;
        b=IE6mTFx2YGSn9LKm9Z18jnaftvVjagRU9oNMVaT4GBwInZcYSYqlGSi9QJGkulLmc+
         mYkk3x4MTS9PJeKPeJ6lfRilcLjvZ7ESfsVz5BNYxeuokf8UqyBO4rpCBi4saC3w+dvm
         Y6KRfgCb9l49dxKs02Voz7ovGP7fJDnPGGSt+VdqfOY7bxFV7Xa2V36pfxXkdOjBp5ne
         2fwYaVmrMgKAfBaNhmBxwf9g19iFnyGoS3XwUFt00vrGiArebGj4PSz9V77nGxhkup6q
         YE3uAfPhKlWG412I3plzHJ3xy0SsD/Qt8Asz9tqE0MK/pk51CZ31CyJkxVC1pTZAT6EL
         FbMQ==
X-Gm-Message-State: AOAM5318EvQYBxaoXdYDjFPB8Ev9/HKm+HY8HWUPFBdHWLfadu9o36Qf
        ns1el7RdxfqL3shao2zEaL5Uufoydl2p7joIIww=
X-Google-Smtp-Source: ABdhPJzoQB4GyPHZtH9NuArl2LCV8ixV6mIa04MRg8oP1KTkXxVz/Jm60BoPeRL0AC+f/gqPRPxXGisDPBm2E5/BeYc=
X-Received: by 2002:adf:fccd:: with SMTP id f13mr6145628wrs.386.1590013562025;
 Wed, 20 May 2020 15:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200520195214.62655-1-carenas@gmail.com>
In-Reply-To: <20200520195214.62655-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 20 May 2020 18:25:51 -0400
Message-ID: <CAPig+cT4kv1D6O5XnaihTODnoGtVeDdDmsPLX2g380r4+YK51w@mail.gmail.com>
Subject: Re: [PATCH] bisect--helper: avoid segfault with bad syntax in start --term-.+
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 3:52 PM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> 06f5608c14 (bisect--helper: `bisect_start` shell function partially in C,
> 2019-01-02) adds a lax parser for `git bisect start` which could result
> in a segfault under a bad syntax call.
>
> Detect if they are enough arguments left in the command line to use for

s/they/there/

> --term-{old,good,new,bad} and throw the same syntax error the old shell
> script will show if not.
>
> While at it, remove and unnecessary (and incomplete) check for unknown

s/and/an/

> arguments.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
