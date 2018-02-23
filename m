Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECC5E1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 16:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeBWQfx (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 11:35:53 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50319 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751430AbeBWQfw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 11:35:52 -0500
Received: by mail-wm0-f65.google.com with SMTP id k87so5767269wmi.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 08:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=G/3eoQOCjestVr7i5D9V7rBNnq/3n0EE/oLKtTXen0g=;
        b=kkciOoM064Uk+xvrUNX/Gp56we3no5gDinpbjNZ2NcyB8HY+mMXDk7pE3O3zNKsiVB
         mG9Qw0OV9rGrvIQLHAIxdkIj3vAzQdcqaOEwsuP4LWTtGey5qv2usBGwpgqObT0VBRAL
         NbGDvbFPxPzUetOJjEJ0WoWKdMgCaoXcdqbP84M77OS1vqZbJ89vCTyKb1ijy+Uf8N81
         g386oHIbwhpnDoXKOBI2F3uLag3P5dknq9sLnAnmmnaSuPHKwflQYy7toPh/99hsGQOa
         +1vOuT9nMqI4pEgkgR/oG/zrD2dMezankm0o0q+Yg3LLRkmJpC/JqPpggIbbu09HiGYb
         pyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=G/3eoQOCjestVr7i5D9V7rBNnq/3n0EE/oLKtTXen0g=;
        b=e2AjB9MEPewnPD3r5uJTy2MJPvDB/ZXL6Z4QQMsfV5NQAt9Ck1GnpAbL1gWMTD7k8g
         cRqxR5z9/yuLS66IIiLbANdzUcULSFW8Fti+3hxJiGbIH2T0I7M5RsqUUMlYy3FGXQcH
         Vkuxop75y+nFmlUKgnMG6wvPNlylaQKvjLdUVaKCVzPX6+oxciaopYFI7to+MqQbIMWO
         xt9dBVjmJJTAQsEkDBXSaF6po5B1oGftSNXfN1r61gimMgXNGMoIgYL0zu9d30Wk/KjG
         BLOGzq7SQZvBcq0ErV0Tlvb8MiEqryDebyx5Ngs4nFf5osi1J92I+L9viQOO4u120Y9d
         0TPw==
X-Gm-Message-State: APf1xPBq0RD0NO9lebSiT+N/Xt2NKfyikb30sp1SQnVsTybm6zYsU3dC
        ojcABEhucabhO2tA/bOcSX5tCS5+
X-Google-Smtp-Source: AG47ELvsI2tLyOG8uGD8QyFOWdisyKUi8KbK7Jt39v+XoVoYR/i1oJpZZ1Ejemg/AwWr3sharmYemA==
X-Received: by 10.28.87.20 with SMTP id l20mr2069026wmb.48.1519403751202;
        Fri, 23 Feb 2018 08:35:51 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e67sm4575431wmf.7.2018.02.23.08.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 08:35:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
References: <20180215152711.158-1-lars.schneider@autodesk.com>
        <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
        <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com>
        <20180216165815.GA4681@tor.lan>
        <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
Date:   Fri, 23 Feb 2018 08:35:49 -0800
In-Reply-To: <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com> (Lars
        Schneider's message of "Thu, 22 Feb 2018 21:00:45 +0100")
Message-ID: <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> I still think it would be nice to see diffs for arbitrary encodings.
> Would it be an option to read the `encoding` attribute and use it in
> `git diff`?

Reusing that gitk-only thing and suddenly start doing so would break
gitk users, no?  The tool expects the diff to come out encoded in
the encoding that is specified by that attribute (which is learned
from get_path_encoding helper) and does its thing.

I guess that gitk uses diff-tree plumbing and you won't be applying
this change to the plumbing, perhaps?  If so, it might not be too
bad, but those who decided to postprocess "git diff" output (instead
of "git diff-tree" output) mimicking how gitk does it by thinking
that is the safe and sane thing to do will be broken by such a
change.  You could do "use the encoding only when a command line
option says so", but then people will add a configuration variable
to turn it always on and these existing scripts will be broken.

I do not personally have much sympathy for the last case (i.e. those
who scripted around 'git diff' instead of 'git diff-tree' to get
broken), so making the new feature only work with the Porcelain "git
diff" might be an option.  I'll need a bit more time to formulate
the rest of my thought ;-)

