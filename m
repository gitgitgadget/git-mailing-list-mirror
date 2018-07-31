Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0771F597
	for <e@80x24.org>; Tue, 31 Jul 2018 14:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbeGaQkD (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 12:40:03 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:51247 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732369AbeGaQkD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 12:40:03 -0400
Received: by mail-wm0-f49.google.com with SMTP id y2-v6so3457463wma.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sREBjvsG1HJOZCvgF6ZqD9CqRh+xeIqXaHbK1dgSYv4=;
        b=ZnUGLZ2cXT4/aSDwQGmMM/3AqHD2G+qsvUOPCosNLHc6ffvoilCJFNxYWatIxRPIJB
         IYglmZcd5QmYNWrPIUQNwng9Kbxzw+z8kaNSkII2lfhbzu6pnoPicjDZshIXkFOGGsUX
         AjqP4nsTHjYlUzRAZSeQkPgUXTY/Aa6WP61CIDuiCDcaG2mbHQDFzANv6/YsqcQA0wTf
         mMYpcjuAEmWQp1NVXkYpjaDKcJxRYWtQ7vKoRIqM68w1BUJyYbXj/CNLcWtY7QBsIiO2
         haZbew64e6eXVUvsQLD+tV+K+wpAHplojvesKwG+x4OE3ygP20nmwx8SGAiKLXpBRh79
         sDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sREBjvsG1HJOZCvgF6ZqD9CqRh+xeIqXaHbK1dgSYv4=;
        b=Ik9uq/nWwnHTYZAlVxhbzqrXjfnpUNILfacEgQgdfDGW1KcvzdUMVGSjobIYrgXlu+
         ZGhG2tpgmTR/b1FByk9Yf637+6c3vdTab7NNq0spBt5o/U0tedQAcevOEprCwTbbJSMQ
         DPQ/fdqDgRsVQ1RrnX0iRNj5lSYTEMACeyOOd8UPIi84gJdULVQ1xJraFcWBL0rezruo
         9IRq1IWUuQgqDxrk2vh1AN1GFJWilO0ls/hsDTusbmmPAlQ9egUP+8ErCc618DbzCih/
         C20UoIea4/A0/mXWdIPcoxCtj7jbIvVln/qI+ph3D01kY8AZjV9bAVWyIxufGcXSCHE2
         xhDA==
X-Gm-Message-State: AOUpUlHpqvsnB5M2SSXGDR0xCJsBgpRL1Z0kT4bcxANZ2a31rXR3cke0
        cDRttqYAQJzgs+cTMM/uquQ=
X-Google-Smtp-Source: AAOMgpeYALsMFhlhranXPduvnnR4yvREiq8FinzPK4Jd7T3VNn7Wdl4H+Ut4CWiymAYW0BQNTAkajw==
X-Received: by 2002:a1c:910f:: with SMTP id t15-v6mr30108wmd.51.1533049157936;
        Tue, 31 Jul 2018 07:59:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y14-v6sm27645158wrq.45.2018.07.31.07.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 07:59:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] Highlight keywords in remote sideband output.
References: <20180730123334.65186-1-hanwen@google.com>
        <20180730123334.65186-2-hanwen@google.com>
        <xmqqsh40e72x.fsf@gitster-ct.c.googlers.com>
        <CAFQ2z_NL+8LVmv+E4osq2+nx+qVE4P80it8vjLUwib=HJ5k4Lg@mail.gmail.com>
Date:   Tue, 31 Jul 2018 07:59:16 -0700
In-Reply-To: <CAFQ2z_NL+8LVmv+E4osq2+nx+qVE4P80it8vjLUwib=HJ5k4Lg@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 31 Jul 2018 13:03:53 +0200")
Message-ID: <xmqqd0v3e9iz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Mon, Jul 30, 2018 at 11:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > + */
>> > +void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
>>
>> I'll make this "static" to this file while queuing.
>
> Does that mean the patch is in?

It depends on your definition of "is in".  

It does not mean there is no need to update it further before it
graduates to 'master' and becomes part of the next release, if that
is what you are asking.

I saw others commented on the patch, showing general interest in the
feature, agreeing to the approach taken and suggesting improvements.
I am *not* going to respond to these comments and make further
changes myself (you hopefully will), but expect that these review
discussions to find a good terminal point that results in your
sending out the "hopefully the final best version" in some time.  In
the meantime while I am waiting for that, I'd hold onto the version
posted here and build it with all topics in flight that are waiting
for improvements in a similar way by merging it in the 'pu' branch.
And while doing so, I'll minimally modify this initial version so
that the whole thing at least compiles, by making small tweaks like
making a function that should be static static and getting rid of
decl-after-stmt, etc.

That is what I meant by that line, and nothing more.

Thanks.
