Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF7211F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965048AbeAXSrZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:47:25 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33381 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964989AbeAXSrY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:47:24 -0500
Received: by mail-pg0-f67.google.com with SMTP id u1so3325599pgr.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 10:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uzkKSp5e2N7L5A9/z29ga8u2V1Ldo4T8czLxiVpqjBY=;
        b=QdubvBrmMEb3HUh27AVb0mHbrD0XQM5qXInKrJaWZV7S/jONL2j+hhPejOy6B4j3Wf
         tWe0Ou0OnLCihZvO3TSYrWwS1NBdeoOkNF+UkfahQ5Q/+n4AllzZeLHP62Rhea+ulCfu
         xSqQIhNE5BSzlW4O8/A4fqj97f1Iq7TGm+HxZmcewH+vOiZll0GndKo3N6luW1Kcdr5a
         UiKl4WU1dWqPv1DuIpVyazJ7UonpY1XXc+l1jhFyiH430sm78kUrO+s04NFoy/Pi7g1K
         KQeUr28w2WYFv0ZzTf7PXuDCGEIBfJZFI4nqUv/Q/3jQqlbq5uMsewvW+9yRU0bYlL7P
         IRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uzkKSp5e2N7L5A9/z29ga8u2V1Ldo4T8czLxiVpqjBY=;
        b=bVfPlzBZkq7WNOW5RFawhLcHB4yAcA+dU3ljawVApvTCZplqv0JR2wECUYbY3tLjuJ
         QsRtaK/l/76ndt5RjAlkacV94NQVWs4BITJEUKXZLo4XXYQeA55rOlxs/WP2zzkeKOVL
         XmK33JhmJofA/0BtABvTqDC4inqk/imCYBMkoC0CesaI4r4+f53df6s2oH9ZVFUglFPf
         92pFFpEd/8nraaK2BRWtKBVNIbhftKBxRL6XILbGZ6lSwSIF1iEYdN5gDgpKZT8tFXqt
         PH8N9iI9pb7/Ebx4GVAeagFqLI4yhAOUgJFWeJG2fr8lND2wRzVffKoIoLqqejGhHBnr
         e1sw==
X-Gm-Message-State: AKwxytdrAX6j8yBZ1rjBNvL6Xe9TPiDxyLj2RwB9FAzjv+9JHNxfin0p
        7aDQ9yC/vS0ZNBvAkRyR3fi1N10Jl4Q=
X-Google-Smtp-Source: AH8x2268YG+5e6VPAjZB5bJWaCzwSREBjy0Kz/R71PvpoRJWeoa2PnrM0anOrSoJXt4CcQfdb83eSg==
X-Received: by 10.101.97.165 with SMTP id i5mr333230pgv.55.1516819643289;
        Wed, 24 Jan 2018 10:47:23 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id m83sm11483033pfk.107.2018.01.24.10.47.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 10:47:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Isaac Hier <isaachier@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Implement CMake build
References: <20180123001648.24260-1-isaachier@gmail.com>
        <CAG6xkCZn6m2n0rDvpN6MmZcOr2hJBRCfhrppC37f-DUj3_JZsw@mail.gmail.com>
Date:   Wed, 24 Jan 2018 10:47:21 -0800
In-Reply-To: <CAG6xkCZn6m2n0rDvpN6MmZcOr2hJBRCfhrppC37f-DUj3_JZsw@mail.gmail.com>
        (Isaac Hier's message of "Wed, 24 Jan 2018 08:45:03 -0500")
Message-ID: <xmqqpo5zdrgm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Isaac Hier <isaachier@gmail.com> writes:

> I realize this is a huge patch, but does anyone have feedback for the
> general idea?

I personally am not interested, especially with the justification
given in the cover letter.

Perhaps the one in this patch may be "mostly complete", and I am
sure you can make it "complete" against a frozen target, but it is
unclear to me how you envision keeping the completeness up to date.

Whenever a developer needs to introduce a new build knob, the
support for it needs to be implemented in not just Makefile but now
also in this other thing.  Unless there is an automated
bi-directional gateway to allow those who have been writing and
reading Makefile not to worry about those who wants to build with
CMake, and vice versa, you are forcing everybody to do the same work
twice, no?

Choice of build procedure for a project is like choise of SCM to
store its source file.  If the new system is 10x better to make it
worthwhile to educate everybody to use it, switching to a new system
and ditching the current one *is* a reasonable thing to propose and
consider.

But I do not think you are proposing to switch, and I do not think
you are convincingly arguing that it is 10x better than the current
one, either.  
