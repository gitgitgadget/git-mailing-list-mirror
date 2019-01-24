Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3BEA211B5
	for <e@80x24.org>; Thu, 24 Jan 2019 09:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfAXJb3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 04:31:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40677 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfAXJb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 04:31:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so5651101wrt.7
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 01:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=IzLOqiBetxa6FBoFfjH2b+CSp0s+laU0PwUkl6JW8X8=;
        b=K1UUrpkRYXrJ+C8fGfwCCdHDxG4Ya+AJkt3mpQ/hUBO7/xcaOT1974nOSHuXWwmerl
         OcgVlyVNxuOAedBZgKmXCLvgo+jn7hL7VPJNApBZJ49B0+CS10KW506wLYKVJZEotjGe
         SAZEXEYrl+u/kMXD3rTtx5Tohsz4NzBL0WCovExK01HfvjcT/G3gEfhoNx6pf35PTI9U
         XYKQNx5xYRHb9U5qwvuu9xTfRLrSvaEfZXQRPd/d6Pg3PA9cQKaOhr462/sE+eWPahxw
         acP/OgTzQSLGCKXGOaKGf7O3Pv0WkqvjgXORyQjdk+Z1Ou46Ncm1P0kLJybpPlvrHMDR
         WBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=IzLOqiBetxa6FBoFfjH2b+CSp0s+laU0PwUkl6JW8X8=;
        b=KqbL5zynXRKjrX2kB7iRmZMs/huEB97jybP96f80T92XwRQfED0EZO5+Ueozx2OFzh
         K8Pn0RZDvLNysCPIeiSmXh4msLnBsrj8BCLERTgcMxLtONsITklZsB0n2uMTOdVCLFpA
         Jl7ls7CISTaerGokDBIVHp8JNmC0Xl3aUChOgPGn1MtgqDdfP/KI2sD5KSA0N7To3K9o
         xhF5im2A3Hnvz2A1fSns7T4hsYwKLKoT2hawPVIVTs5xuVXsS4EJt/betuRbQFHcBD88
         MqRZGLg1Qj/FkJ/s6nJG7bthvxITqKEysz49waFC14f8jI9XN6yOgd2CO7nxCeFdrq6X
         VgeA==
X-Gm-Message-State: AJcUukf3QZpwuHnec3TPn4vCPj7QvrtnLhJpTwoL/AwHPViAGjQkStm+
        lCeWRgPHVMTXPrsGNXH6sDU=
X-Google-Smtp-Source: ALg8bN7vAcbkgy6G/cSKwMenoAMyL/g9e1lq7J8+YSc3Y6iFGm0MfQ7gUaNjINdej0Ohcke6VAqOIQ==
X-Received: by 2002:a5d:64c7:: with SMTP id y7mr6230815wrv.207.1548322287138;
        Thu, 24 Jan 2019 01:31:27 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id 199sm67296197wmh.21.2019.01.24.01.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 01:31:26 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/6] commit-graph: add --version=<n> option
References: <pull.112.git.gitgitgadget@gmail.com> <e7ae3007f55efcccd8827ce7d8db5f9dc180cb39.1548280753.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <e7ae3007f55efcccd8827ce7d8db5f9dc180cb39.1548280753.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Jan 2019 10:31:25 +0100
Message-ID: <87a7jq4d1u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 23 2019, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Allo the commit-graph builtin to specify the file format version

"Allow"
