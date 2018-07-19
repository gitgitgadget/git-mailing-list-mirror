Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217B71F597
	for <e@80x24.org>; Thu, 19 Jul 2018 19:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbeGSUME (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 16:12:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54460 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731960AbeGSUME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 16:12:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so7298929wmb.4
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Mcx0QKm72lp4dyutCWQGv0g8TXqumHd8N6HayMMzMY8=;
        b=QjObcLKaNXTVziSDfS1czUi/EM5uegfKUO2PW9PzZaIwRZspGVAi3Ywt2nofOuX/rQ
         b/WuNihV6JDeq6ukTDzWJmjrn+kiiQRwuB+qTFc2pE1z1gr9T5YyqSO9xUEZSL2dOmyw
         fbTSm9YOlZMks/SBoKn9eMBCoMwbRlq5Ae5wLkfd+8vhc/varzF1cWYZqO+mEewzRhCH
         /2k3RQncwNztguZonLUS6LS67+BW4QHR/G/TskfFu9y9EPvXSA4AUUnBrAZgE34hAMFG
         MlPfOYhsIYrJ0G0MM9s2fbXzDOFssxxZZsGcRSGydLl8K7b/+0RStD5mBtXq1b2/Uxhq
         ViQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Mcx0QKm72lp4dyutCWQGv0g8TXqumHd8N6HayMMzMY8=;
        b=GHkMVxFhtiD6H4XjI8ybxhkw0pTwVSzfcg1qsVU0GHX1IE6c3DnFKfDDMmwU3wPlYD
         9ov+5DJ7y/Bz+zK1vibx96CI6NHuRfqAki2xPkDOeIde+FEsztPfDacNUMqSc15j27Ko
         zfEUQnEPCbCld6+ufnRuXxyfOFBF73Er7FU93HB7H6fmn6z0XVSC2PXybebTY16GyxiP
         uHi/sO7jxKodPL0ZtOpYeyHZTlo6aDHNRCEqk04dSeHaQoP1GE5VdylhLnsXOC9NluA2
         Zh7XZdWgM9wOTRiTfoKB3hnHCJLSY7wgbv9JeJjMy+p7hVzieQxFSRirXCdhA/Cb1QEC
         uQTQ==
X-Gm-Message-State: AOUpUlH32pXadr/JT+PfT2QnnRz8oz24PV9kkrR2U8bCR6o6CTXOHAOQ
        euFoDZ9JQ3aAeuS1zZwrKxs=
X-Google-Smtp-Source: AAOMgpdbzmR7bFl8Fvu5x8qO1fkKkNFI8o/2Yy5Pa9lkHWFXA99puv9PTBuf0MPZ3KFFlJNvFg4KWQ==
X-Received: by 2002:a1c:6b90:: with SMTP id a16-v6mr4864127wmi.74.1532028449634;
        Thu, 19 Jul 2018 12:27:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z11-v6sm10757443wrm.94.2018.07.19.12.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 12:27:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
References: <20180718225110.17639-1-newren@gmail.com>
        <20180719054424.GB23884@sigill.intra.peff.net>
        <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
        <20180719151640.GA24997@duynguyen.home>
        <xmqqlga7do3r.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 19 Jul 2018 12:27:28 -0700
In-Reply-To: <xmqqlga7do3r.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 19 Jul 2018 12:25:44 -0700")
Message-ID: <xmqqh8kvdo0v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Imagine that you create a delta and set its size (which happens to
> fit in the entry) and then create another whose size does not fit in
> the entry.  How does oe_delta_size() know not to look at
> pack->delta_size[] and instead look at e->delta_size_ when it wants
> to know the delta for the first one?  IOW, shouldn't there be a
> "backfill" procedure when oe_set_delta_size() notices that we now
> switch to pack->delta_size[] array?

Ah, ignore this.  That is what happens in the prepare_ thing.

