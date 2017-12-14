Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A826D1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 17:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753947AbdLNRlM (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 12:41:12 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:43275 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753684AbdLNRlL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 12:41:11 -0500
Received: by mail-wr0-f176.google.com with SMTP id z34so5828304wrz.10
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 09:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0j9SPQDUA0nb5teMcLYGn5/x4jgwkB7KnUvJnPCCYbs=;
        b=Afsmz2yRG04YjbHdxWGRXg3OlBMhoHMMu8HZPV65T6FK0FIToSNxrIKQ6U4oKCbX/v
         wkhUoN2JogTdH10qh3ut652a5TxH31GjctHHw2lWq55z4iseoVBJ+4M8Xhn0kh3tWCUi
         f9EGCwJrDaePEaVKPXAjX5/V1i4nEL74TXvVLGgJ6lPHwvIX7DdyeXLjAsX1uhLAj1ci
         DlXX0scePI3hguyQAmXuu4noecq39K+rBqJzw61f0FJ4/4lUHUSvnTuvR+iBIlmNCpAr
         7Af4np9Y+91yZ6SFE/d8+Pgl07fgfmG3HcgyRICnyN3Tn/xAw37pSR0Ngy41XyJphjG5
         Iuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0j9SPQDUA0nb5teMcLYGn5/x4jgwkB7KnUvJnPCCYbs=;
        b=rx0lzQwn0cJM0rlyNfK7LGi4ZQ9ARGxWpi7erl3xQPvsMf6yNfOHyWdMbA8TEF4ovD
         74IKI69R/JCrG+4w6QiLFX7MnxrLkvVLe3RAPEsaeRQb3XbFKGZtD/xpKiK2uvuHZ1Pi
         +4hS4hsB4NsCkkVgNR7phi3x8ZDz4xwAQZbYF1zg3X/aBffMCL+/bYjl5V0G2V3FE/Z1
         jsx6nQRyAoCuFe4ozlM7Y4byECe8uMuyDTSAbp7CnrXhT3BpaqCkrIV/j3MYlyDhXkXU
         s2M4Y9L/x/56UafpcBpEPRS8yeMITuQyaSqb++j004UqT0VHb0m3xsXGqLkUSJqFCokM
         ZMSQ==
X-Gm-Message-State: AKGB3mJRRkIZwFLURZ0mZUDmM3ekbqYqjluEjRKioH1846k7G4dvSx8Q
        /483az9OUE3uIndl/GWmQlY=
X-Google-Smtp-Source: ACJfBotln++cu5HWG173nI2r9HqlGmzGML8NlMEbvGMCiJG/Od8XgWusLGdnZ91qeVcMvi9ukBS0oA==
X-Received: by 10.223.182.19 with SMTP id f19mr6508443wre.81.1513273269856;
        Thu, 14 Dec 2017 09:41:09 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id k5sm6514286wmg.21.2017.12.14.09.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Dec 2017 09:41:08 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1ePXVL-00061m-TX; Thu, 14 Dec 2017 18:41:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #03; Wed, 13)
References: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 14 Dec 2017 18:41:07 +0100
Message-ID: <87zi6lb424.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 13 2017, Junio C. Hamano jotted:

>
> * ab/simplify-perl-makefile (2017-12-11) 1 commit
>   (merged to 'next' on 2017-12-13 at 1b791d2503)
>  + Makefile: replace perl/Makefile.PL with simple make rules
>
>  The build procedure for perl/ part has been greatly simplified by
>  weaning ourselves off of MakeMaker.
>
>  Will merge to 'master'.

I noticed this tiny grammar error in the commit message which you may
want to amend (or maybe it's not worth it since it's in next already):

    As a side-effect of these general changes the perl documentation
    now only installed by install-{doc,man}, not a mere "install" as
    before

That should be:

    As a side-effect of these general changes the perl documentation is
    now only installed by install-{doc,man}, not a mere "install" as
    before

I.e. it's missing an "is" between "documentation" and "now".
