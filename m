Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37F0C1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934983AbeF0SJz (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:09:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36936 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934797AbeF0SJy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:09:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id n17-v6so5928496wmh.2
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QSHGQy7+LccY8eq9T5k7QOD9w2VHdES7GESRRq6WBfw=;
        b=SPxmdwUTu0n4X6lLogCM96jTiXzPgivFC4PwscjDUVs0FgNMCIqXjcuzHcn3f3yFND
         Aefd792UWR/qh1BhYPvSQ47m0TcZSAfy1S8vOKg1zrdp/uTwh9v0yjDNMfoSlwttb/1I
         2IzPlKVh8ph0Or4o8hG4c+Pxwu9/rGlYYwmy48b7uccCuU2WZ3nJpPmjdP3R7ZnrY0gW
         6BZjMYUUXlD8TX/omAYqOYjzK7VJ5hfIOjJ2azj0ymeAB2zvYCujFAaullLnmwqmjADi
         0m/Lm2VmY2p7iOChm80vgoFEPbcdcoSRTnGFHSEhjTp04OEkqSKtVFCdeY3dlgRBzdkU
         A70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QSHGQy7+LccY8eq9T5k7QOD9w2VHdES7GESRRq6WBfw=;
        b=eGNn6efvXmq3O9v3vG0JSI9AZC4pL0H1Wa70nEaiAqsUc2ylw3i22rzVvANQcJbf2m
         XAG5tKt8SgvhP2g5DaVCnNwYBN///eNi844ddYibPL6AazMBgT5ls77EJPiabmDdgU0S
         NxrV5Qh87wU7ThBEapc3rcVNmzU5I5z3HcBvu0dE/vfeFHG7M/zAkyI50y8+i03+Nmq5
         X1IvHYFIBgzrQqnaOmuksLIrRS2nbrl3NYw9L/96n2Lld6UZOZP8mCrZ0l0djY3zus6A
         mqh4lIIXLVhLpaZYx2CFSHx+NjelkobF109941c9Ba6EGHa0IoeaVpQo14HeM4hJH/wM
         1qVw==
X-Gm-Message-State: APt69E34VL9ZjRlcIxnBL9sBNxuWsVIWi3Ix2bIQai5M1kVrhelh0GDe
        0CqA0FB7sWY7pGZOHFJDMck=
X-Google-Smtp-Source: AAOMgpfc7cdB5IxqcW51yqRbAGZm4NHyEhHO1jiU7Qexs8ND2E3GaR3AGNWjscw8CnFm+P0TwBD/Ig==
X-Received: by 2002:a1c:e041:: with SMTP id x62-v6mr5441459wmg.155.1530122992984;
        Wed, 27 Jun 2018 11:09:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 203-v6sm8993953wmp.23.2018.06.27.11.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 11:09:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 22/22] commit-graph: update design document
References: <20180608135548.216405-1-dstolee@microsoft.com>
        <20180627132447.142473-1-dstolee@microsoft.com>
        <20180627132447.142473-23-dstolee@microsoft.com>
Date:   Wed, 27 Jun 2018 11:09:51 -0700
In-Reply-To: <20180627132447.142473-23-dstolee@microsoft.com> (Derrick
        Stolee's message of "Wed, 27 Jun 2018 09:24:47 -0400")
Message-ID: <xmqqmuvgf6ds.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> The commit-graph feature is now integrated with 'fsck' and 'gc',
> so remove those items from the "Future Work" section of the
> commit-graph design document.

Nice ;-)
