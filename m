Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11586C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 20:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjCUUiz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 16:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUUiy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 16:38:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85C737F38
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 13:38:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id dw14so4452097pfb.6
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679431128;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Am/vczGg7GepS9jwBONVhLNfKY5aku/bOuxY1SwY540=;
        b=GgywuKUPo67ATyQ9geeb3Gdt8GA1TzBOFQ5WnUFsszC54VMli6CH7D+yrMzR7T2dcs
         KTKGVqJk2zVfOlWFZte8XqwpuWPHzwzhnwaCfSjeISec21xFGkVgKOCT9DeGIePeZ0O6
         8UL9v4oj1e+3y5e51cvpnQmo6YK8s49vuMA+QVbvtwAmacQSNkHRpMF+FpBQ2vwjFToM
         fHLsgITUO8udhWfKW0MAMkMw37lGSGxzyjS7MqZXt1WMiQivrytYGMX9hiaO7geHt7q5
         7JZ/m5OwdbiEfhUqWBBggdd1lPbly7tHa17omDyhhBNjslGrBwbgpqfoipTtRziyqnbK
         V4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679431128;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Am/vczGg7GepS9jwBONVhLNfKY5aku/bOuxY1SwY540=;
        b=d+4MuQEJckWy+u9je2BEev+8RZjDP/tjFKF8i+FmThuVRzFzue2mHjIeni6pFCon43
         p0FH9dxlZ4RV4dHga63ArRyii/TKHxyLvo4JTDfmRgl50AtjESMql8J6YMswPINYL9DO
         fGHklxLZJU8jc7PeUbPh0jU9diF1l/U5AmhEIX3cFamq959XIxoquGGUT2NvdjZtx8kY
         dkw3PTki2X1+22VFEDs6pbxaDoWgqo6JTknMr0x7KRZ0ndOdSi8qyYR8QyFYgbr6Rkvz
         Az6Dt8ekT+pzFVv6AmI7uKe0LuKtdhgTHUMcLSTBUG1+K3pD1lHbMZaVuXoHs8dLz1Oz
         B1OA==
X-Gm-Message-State: AO0yUKVMJDvYkzqHGj4siqcAAStiMQd2nr9PoB8dyfZT2PvjpG0M+9vi
        InxMPx4Ems9S/8yagOgfIzk=
X-Google-Smtp-Source: AK7set+HVAXMDqs/gGfT06ttbURe/cdb9CN23CHaRymtIT6Fnn50vjyPK6KrqeQ6sjirRu5hW5sGhw==
X-Received: by 2002:aa7:97a9:0:b0:627:e42f:b76d with SMTP id d9-20020aa797a9000000b00627e42fb76dmr833970pfq.12.1679431128088;
        Tue, 21 Mar 2023 13:38:48 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id s5-20020a63e805000000b00502f1256674sm8634533pgh.41.2023.03.21.13.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:38:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] doc: remove GNU troff workaround
References: <20230320190047.79836-1-felipe.contreras@gmail.com>
        <20230321173206.GC3119834@coredump.intra.peff.net>
        <xmqqcz52hu7n.fsf@gitster.g>
        <20230321181702.GI3119834@coredump.intra.peff.net>
        <CAMP44s22GzW6rFEEbNo8Bx3oKhf6occ6+Y8hP+vcp8bid-kqWw@mail.gmail.com>
Date:   Tue, 21 Mar 2023 13:38:45 -0700
In-Reply-To: <CAMP44s22GzW6rFEEbNo8Bx3oKhf6occ6+Y8hP+vcp8bid-kqWw@mail.gmail.com>
        (Felipe Contreras's message of "Tue, 21 Mar 2023 12:34:51 -0600")
Message-ID: <xmqqcz51hmay.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So yeah, it was fixed back in 2010.

Thanks, all.  Queued.
