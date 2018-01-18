Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4411FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 17:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932089AbeARRm6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 12:42:58 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:44464 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755513AbeARRm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 12:42:57 -0500
Received: by mail-pf0-f171.google.com with SMTP id m26so15184933pfj.11
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 09:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ln1vqB1sv96tMPLh78hXya3SrV0QM1I0FCRO+fSS6R0=;
        b=dtDW9U1TznYGoiVm7bHSRjMWai8JEma4MfIiS9dhtTVipQHshyHSJwwez9Lh4SJF31
         j2IUWEfb+6SoJq3XohHVgHsVYiRnOlCjvRi5aNBrMo2dleJadtZAJT6lFQZKSTYbDnzS
         IdGcFlIhHL3G10/qhQZf8+l3VPgOotFUqiegKqbWa4a/D5MD7PrP619IIpqHsoKQHfXp
         fb27LFVOij5irRcnOMXPz4ga2YNmPBYI4zQOfinO6pCfwlkiYUaQ+gm8EpcTrsW7cpdP
         M6J2jqPk14raxQ9zZ94FUe8IeY5ml9fdvqwznGvNoQqsQ/W8BqXunkMO0FaudlrAN1Ta
         GIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ln1vqB1sv96tMPLh78hXya3SrV0QM1I0FCRO+fSS6R0=;
        b=CLgeqHzMKr7pflUUfN1JIjfTcLNo8FBeVLbmgt0uuE2sTeNEX8JfbHj3AFrojLFHXO
         chdB9x59e5CBuvmNvQ40Vq/O19rkwfkoclNDiF/6670gVbDJM0gmUPHgJSpHs7Ld1amC
         FPFkoZlZ5vlna3ATm5cTXqhXRrqg6A+3UuR0qprI77D7S/LlqbClvLg7S1msw2gpkE+h
         3qKquaaZFxNhqV6wKmDGVbD32GHGtKeomqXKH9I5CPC7OsKpUoSXEe8jZ/HYTGHQ/HBU
         wAoUJONIdYwzDfBjJRKLR0ezuBK52iweqzehHXAzfU/9mDqnulpN8wFEsGPN1uzZyqPr
         s2Ww==
X-Gm-Message-State: AKwxytf+r+ShcDaNNO3TMNws8+5PyhlL5tTCoe07vUSoG0Jiapnp221R
        obGCWWo88/bU7yrQ388CeuFEOQ==
X-Google-Smtp-Source: ACJfBotzq1x5K98UXFh1bHbG6Orn0ShJYdjA3cUORIA3SyLeYrbGyjKXJy5JGFWl/nMY+EcDyts+kw==
X-Received: by 10.101.73.71 with SMTP id q7mr15216771pgs.66.1516297377018;
        Thu, 18 Jan 2018 09:42:57 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:517d:a339:72a2:bdb8])
        by smtp.gmail.com with ESMTPSA id u71sm9767461pfd.37.2018.01.18.09.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 09:42:56 -0800 (PST)
Date:   Thu, 18 Jan 2018 09:42:55 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?Nguy=E1=BB=85n_?= =?UTF-8?Q?Th=C3=A1i_Ng=E1=BB=8Dc?=
         Duy <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>
Subject: Re: [PATCH 00/11] Some fixes and bunch of object_id conversions
Message-Id: <20180118094255.5d0b27269b5f94cdc2faa6b3@google.com>
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Jan 2018 15:50:52 +0100
Patryk Obara <patryk.obara@gmail.com> wrote:

> Patch 1 is not directly related to object_id conversions but helped with
> debugging t5540, which kept failing on master for me (spoiler: it was Fedora
> fault).  It helps with debugging of failing git-push over HTTP in case of
> internal server error, so I think it might be worthwhile.

This patch seems reasonable to me - it is a little strange that,
currently, an error message is printed upon an XML error and upon
failure of start_active_slot(), but not when the slot cannot be run.
This patch fills the gap.

> Patch 2 is a small adjustment to .clang-format, which prevents unnecessary
> line breaks after function return type.

I'm not very familiar with clang-format, so no comment from me here.

> Patch 6 is a tiny fix in oidclr function.

Ah, good catch. I would write the memset line as
"memset(oid, 0, sizeof(*oid))", but the existing one is fine too.

> All other patches are progressive conversions to struct object_id with some
> formatting fixes sprinkled in. These should be somewhat uncontroversial, I hope.

I've looked at those and they appear to be obviously correct.
