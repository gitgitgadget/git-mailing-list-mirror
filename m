Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FFAA1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 18:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbfAOSSO (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 13:18:14 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45743 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbfAOSSO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 13:18:14 -0500
Received: by mail-pg1-f202.google.com with SMTP id y8so2165858pgq.12
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 10:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=irpjtg8NWdCCbBHmrx17ld8xwNEhh2Tc+K2Up5GbjBo=;
        b=Hhz1G5++tP4Svi7Sr+h/p1OeLj0+uYSGUkcb4XF5Luuv66seCX4D9jeTH6V4Z4o0SO
         uzz9tzMpoJxHwqUafkBYR13WYvlyE9vdB0R0YfbgQJXXIQQ3WtY7lPIaVNIZQlevwUbD
         kNHdlj9EbzF+0Zul+C4LJ7pE4Gl5U9s/6OmPV77poXTpo9wh7mln78uLwj4BJ+4Y2SiR
         bX8TXkUY4MGuDOYCbUId5OWPChl5SngB2XEYRlgRqt/fjcNI+DSHY+UhHm/YRcYAzKcQ
         ZaWgKJ6HA65D2JQ/MXe7yFdn+/9Klhp95yS3UBnflPe+CNziLBR43z5JhnY2cXeSi+B9
         yZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=irpjtg8NWdCCbBHmrx17ld8xwNEhh2Tc+K2Up5GbjBo=;
        b=pLgYW8d7O8y8AKnmTYWGk3TI7VpmRSw9FdMzbVdD4py4S+PLwi09qTYJG3HkPSAlSn
         +9uVpYRMgOAwdsjPDc9KLRyUQDcQpu/Bt7Q+PkT7801bhgvm6EtTHGtMMpyHnF2DAeU3
         37OgV35gEMtW4FgkCbU1PgeuUb4yRBdSAm2y/0Pv1na3Z7if2IzTpHUN9scrI1wGJeIb
         8ffILoRWqa6BFTwyVtOetIHfQbh9nyC7uI3DkDS4bU+IMKFz6XyFWGAEfHE50ALoNC3d
         8FlBr3s+xfHcd4PRR8feI8CckmIMLhglY47GLLXCil42gIpekDsGcrU/3/Gm8sSxKWK/
         D8rg==
X-Gm-Message-State: AJcUukcGUkxiURe2FPwJNiY3Vs7677CH6IdJ53nqQJL2zfYZ2byn9x9o
        Vu0jdjNfXM6Dd+MS2OxnPLCXzfyQQ7/lP8NDyea+
X-Google-Smtp-Source: ALg8bN6f+IUJ1uingfTv8ts4Ngbipoi1malJYuhvtxR65BRoZB8safLLZKBOs4S+ZFuhyrH3BEwz0EeYooMqTciOqvXu
X-Received: by 2002:a17:902:8681:: with SMTP id g1mr1563642plo.38.1547576293539;
 Tue, 15 Jan 2019 10:18:13 -0800 (PST)
Date:   Tue, 15 Jan 2019 10:18:10 -0800
In-Reply-To: <xmqqbm4juhoc.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190115181810.249142-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqbm4juhoc.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 1/4] pkt-line: introduce struct packet_writer
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> The patch itself look quite noisy, but in esssense, at the lowest
> level we used to have a single format_packet() that was used to
> write out normal payload and an error message prefixed with "ERR ";
> now the users of the function are updated to call one of the two
> helper functions, packet_writer_write() or packet_writer_error().
> Most of the patch noise comes from the helper functions at higher
> levels getting updated to pass the packet_writer struct through the
> callchain.
> 
> Which makes tons of sense.

Yes, that's right. Thanks.

> > It will be convenient for a future patch if writing options
> > (specifically, whether the written data is to be multiplexed) could be
> > controlled from a single place, so create struct packet_writer to serve
> > as that place, and modify upload-pack to use it.
> 
> I've singled out "ERR " in my comment above, but this only refers to
> "multiplexed".  Are there reasons why we want multiplexing other
> than the "are we sending payload, or an error message"?

The main reason is to allow progress and keepalive messages at any time,
actually. I'll add this paragraph at the start of the commit message:

    A future patch will allow the client to request multiplexing of the
    entire fetch response (and not only during packfile transmission), which
    in turn allows the server to send progress and keepalive messages at any
    time during the response.
