Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E6EC1F424
	for <e@80x24.org>; Thu, 29 Mar 2018 10:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751008AbeC2KKd (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 06:10:33 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34014 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC2KKc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 06:10:32 -0400
Received: by mail-qk0-f193.google.com with SMTP id z184so5430239qkc.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 03:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=y7PCCAHmqolVLmrQcvtG5Q2h2kzwR7KO6xKvodTm4hc=;
        b=lEgCwvoc0Y2xpci3YfF3+L3HT62D/JJsyjyDMPbQSKouvt2ZYX7r2/bOutOdQQupot
         6PItkth5/rEPJMzg38NVp4VgBFh7cp3ey8JxUQN8s0OYRaq9tX8hRXALQnQAMKUkbuCb
         Ce7bZ3OiroPYr08C0ZHJMQ+qeZXyaRYKd9rQ8bYW0zQOvONUtC7sEAdTuzr4jHsoHamS
         5I1+rbka3pY6U0xzvpVhQV5mJ9AEXFqdqGz8z3hIWUIcml1TibmechsHBq79tn/Gcvdz
         pa8ECSJ0/YvHA8Neb2a/YkF6VD0NiAgu68D1GxKAq3dVIm3t65c6RY5vHfREmY+IHSlQ
         soTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=y7PCCAHmqolVLmrQcvtG5Q2h2kzwR7KO6xKvodTm4hc=;
        b=QZysLpsu6nxlgNKIPpD8oh6iI7On82o69oR6oUDkTU3UKqSN+JSgAYMTjP+a1+0Y75
         Hk2RNSKJEkbcKx1pKOAyNDexEk8TNOKKmu+FTSOLWO/lrIJTzl4+U5TJ9h2ZvDMnafwI
         sGvXf2r6gjQCSy+KrsU27CC/sXH7sIOybGEDozeKz2LjFtQSp98en71/YPYP97u+ARP7
         BC7Vo/PMoSkAYCUGY8NqwZS28uUT+7pr739UDLyM4qO1TB3RjctW8uS4/8H2rGl3YZf+
         DF1TTcC6Bg0NKpGHGkU9aEsVCNjhI7O7+VcykjV3O6jPnbdS0MPEKvP0YXA/C+NX+8gf
         eRqQ==
X-Gm-Message-State: AElRT7GV67466XMFBQeTKwZUmfXpNqG4HIwZKmbuSbIFaLOkZrINTvVw
        010QBgKVeJ2IrtyKOe3mR9Oy2ehyf4voxDmIEbHLmw==
X-Google-Smtp-Source: AIpwx4/IwjWMwzB48Mf3i0uxp/vjIbnjBvyGzjvPv/kCkfJrokKSNypuHNHXvTrgHvEsvdLWomCYNMXIybJv7kJMgKU=
X-Received: by 10.55.156.79 with SMTP id f76mr10046248qke.36.1522318232037;
 Thu, 29 Mar 2018 03:10:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Thu, 29 Mar 2018 03:10:31 -0700 (PDT)
In-Reply-To: <20180328222129.22192-2-joel@teichroeb.net>
References: <20180328222129.22192-1-joel@teichroeb.net> <20180328222129.22192-2-joel@teichroeb.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 29 Mar 2018 06:10:31 -0400
X-Google-Sender-Auth: bimp2ErwjmFXewcCFYDyzaIU41A
Message-ID: <CAPig+cQHC_nO_CpVLm7m_iNq1AuCGb5nzqN4EokAYf9NVdfuWA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] stash: improve option parsing test coverage
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 6:21 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> In preparation for converting the stash command incrementally to
> a builtin command, this patch improves test coverage of the option
> parsing. Both for having too many paramerters, or too few.

s/paramerters/parameters/

> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
