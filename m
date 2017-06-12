Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB801F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 19:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbdFLTBs (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 15:01:48 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36814 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbdFLTBr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 15:01:47 -0400
Received: by mail-pg0-f52.google.com with SMTP id a70so48772035pge.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R8emvLqFTX9kJ/HWUajAgmU8bwDz64C5aaxFDWuio4A=;
        b=fiCYoLKY0xAis3KLRssyyB5z4p1XiTf1CNg5xuRS2KAxjbOJj3f8QRkb3d70YsSZ3V
         W2tJ1dPGEGwl0Oeux27Oz/6XzlaQPiU0UjhCSA1F4s555K/SBtHczLiL1DSsmlTleI1K
         yIgmRTDof9zs1N5O9I+VG8lo06xDOVJt3e3O8vs6B6ISo8piZSdXJ4BtMrj4oHTqG+Ag
         3tmPDvuIZjcJz/j+BmtfH5AfDjwHBbQs+oMnah9amV/6qRs/eXngxFdUcdsMx8T679J0
         LdVEfS7EeLuXckWe3n8STQh82ajJ+ZTiqD4Mm7K8cxJ+7fPce537wnxqcTGGlbMkKfdp
         Etyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R8emvLqFTX9kJ/HWUajAgmU8bwDz64C5aaxFDWuio4A=;
        b=Dr6kZLUT02YKVBrd/0sOVk0lwKbz8+XEkfqfQ4P5uoZsI6l/A5dxCuu1NklE/MQEC8
         hJgXLdOEZLbrf2q1kFf9HE1657n1xVGd2bRAJlvU6bmdYu2aUW5E6wkD+Eh3Drf1XXYD
         phPbgNI70e0R7OqyQ8bda+3x5hoM6AcbhkdAi54xYq5Q8d3VHUU6wMywUqLuKYGL6gv9
         92XB9jIH7O1b8gJP5RM+L1ioDI1FVQlB5VuneC0/8f4GJMloheGlntMPnqJD3SVt5RmG
         JzfN++R7u5AjeRcBJjJggqRYTf5wlHSfYoyIINHWiWaZSqX90ho8NT7DbsssQik56SK7
         qV5w==
X-Gm-Message-State: AODbwcDaxkMo7E/b38IrKf0pFF6t5IHb1MYe5aCCMGhX5XX/+YIvLx+I
        4ZhJJEpKI+rQdyMX
X-Received: by 10.84.232.8 with SMTP id h8mr58335542plk.278.1497294105815;
        Mon, 12 Jun 2017 12:01:45 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a1c6:b49e:dc41:58c])
        by smtp.gmail.com with ESMTPSA id n71sm20218971pfg.46.2017.06.12.12.01.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 12:01:45 -0700 (PDT)
Date:   Mon, 12 Jun 2017 12:01:40 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v2 00/32] repository object
Message-ID: <20170612120140.3da90194@twelve2.svl.corp.google.com>
In-Reply-To: <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
References: <20170531214417.38857-1-bmwill@google.com>
        <20170608234100.188529-1-bmwill@google.com>
        <20170609174034.61889ae8@twelve2.svl.corp.google.com>
        <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 10 Jun 2017 02:07:12 -0400
Jeff King <peff@peff.net> wrote:

> I do agree that "pass just what the sub-function needs" is a good rule
> of thumb. But the reason that these are globals in the first place is
> that there are a ton of them, and they are used at the lowest levels of
> call chains. So I have a feeling that we're always going to need some
> big object to hold all that context when doing multi-repo operations in
> a single process.

=46rom my experience with the codebase, it seems that most of these config
variables are static (file-local). This means that the lowest levels of
call chains could probably get away with storing per-repo configs in a
static hashmap or associative array keyed by repo (if they cannot just
pass the config around).

Having said that, if it did come to the hashmap, I probably would prefer
just putting the config in the repo object too. So maybe that is the way
to go.
