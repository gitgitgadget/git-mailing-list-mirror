Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56182089D
	for <e@80x24.org>; Sat, 29 Jul 2017 02:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbdG2Cbx (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 22:31:53 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:38727 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753159AbdG2Cbx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 22:31:53 -0400
Received: by mail-vk0-f47.google.com with SMTP id o19so22421638vkd.5
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6jxO5kXRB2c+Q1fSZkG/Wto6IGP8xke3AfiGaYAJ1sk=;
        b=GAF+eSTrBghTzbWuukPqNIxVUxZJnSRfE1l2Q/CQ463NSB19nJRGioJ+sQ0ai4Xsdf
         Yk5f8PGQbXU3xQSMLBTT8J7DGC7b5eEhT6T2BXeOWlPO2hsbe8zZpNt0ihYxNBeBJY6f
         WngAIeX+iJL9B2rkvtlPE2FBkuwwm+t7CRHFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6jxO5kXRB2c+Q1fSZkG/Wto6IGP8xke3AfiGaYAJ1sk=;
        b=XU1TtDM/L274CZmu4XqwtvN0kdca2M9moVzivssfCG8GZNVESib99pl2FrxP2glM2c
         MQjiImlQKqQCEgukOJDWnFg8bVLnw9wF4i4xDP0h2AybeAGLR+j5tduaVrSdo914KYX6
         cNPtqRtu8VS08r/cwlgqpSr9knK1112LcSMtO89TBbDyMLsV2PDSglV3dqKAnnUz4LHs
         4fSgdj0jENnGyJCD9wRxE+/AluhW5LGUICBmY1kS/g4+IHlO+eapQZkr9rcpOCqE2FCN
         27WDe31SLP8Gk2+ZgmOP8JinMCvKG1bJ0dwA++UqyyxDNdU12uzQlP00Pbiu9jsOYqUO
         MlrA==
X-Gm-Message-State: AIVw111L1ScVim86qFw+LqnygNi+L7+aV5nleQaEqOieHim9vXHhDW3E
        ridsrwfOPZ6XigvEgXzcPnEc6n4ZRIm8
X-Received: by 10.31.60.78 with SMTP id j75mr6562028vka.38.1501295512245; Fri,
 28 Jul 2017 19:31:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.137.4 with HTTP; Fri, 28 Jul 2017 19:31:31 -0700 (PDT)
In-Reply-To: <CAMy9T_F9oH926ShUGpFqJz4bMrJofvbsfb0_oME2NhsYvObq9Q@mail.gmail.com>
References: <CAJo=hJvxWg2J-yRiCK3szux=eYM2ThjT0KWo-SFFOOc1RkxXzg@mail.gmail.com>
 <CAMy9T_GeE5Xh7HJ7VZPX5B5SGUmjUbELER07-u0se5Y0ZJ5YtQ@mail.gmail.com>
 <CAJo=hJvR_rV356Mna0cMoTY2mrVnG9MH39wDS1tLCRT1h_f65Q@mail.gmail.com> <CAMy9T_F9oH926ShUGpFqJz4bMrJofvbsfb0_oME2NhsYvObq9Q@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Fri, 28 Jul 2017 19:31:31 -0700
Message-ID: <CAJo=hJt5A6wL1i4d8WAivL-+LymZd_M6XjUBJ+vVoYfvuVm23w@mail.gmail.com>
Subject: Re: reftable [v3]: new ref storage format
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 28, 2017 at 7:18 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On Fri, Jul 28, 2017 at 3:12 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> I'm with you this far, and like the {min,max}_update_index in the
>> header. I'm concerned about update_index in 32 bits. At some point you
>> need to reset the counter, or the repository is broken. 4b updates is
>> enough for anyone? I'd feel better about this being a 64 bit field.
>
> Yes, I was a little bit nervous about 32 bits, too. But that's a *lot*
> of updates: one per second for 136 years. If that limit were ever
> reached, there could be a compaction step, where any update indices
> that don't have associated reflog entries are "compacted out" of the
> numerical sequence and the remaining indices are renumbered
> contiguously.

I considered that, but its a bit of a pain for the writer to renumber
the remaining records.

> But it's ok with me to make it 64 bits. Usually those extra bytes
> would be appear as FFFFFFFF and so should prefix- and zlib-compress
> well.

That was my thought. Within a single reference these will prefix
compress right out, and zlib will fix any sins within the log block at
restart points.
