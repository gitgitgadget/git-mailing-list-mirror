Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95AB41F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 20:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJHD7q (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 23:59:46 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:38302 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeJHD7q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 23:59:46 -0400
Received: by mail-wm1-f54.google.com with SMTP id 193-v6so6379732wme.3
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XR1sCEaBdZSVNWfok/RCgQq6T+iZZXlukoDtEcmBpYA=;
        b=a3LH+ZFJ2NV/2OEkI9LazMwkA7BqgwCFNbSUHOyC7NKXjvkQwvz3mcpXBRIZglIRZn
         tBozsmmEZGFFVinqjH+g7ri28KvoSxEMPD4YIqeJ+BDbzZgJ5Q1+oVJhNoymkoGg3FdL
         CN7Z3PGsV3BajMpxA4wUShN8hR+JIAIFTq6AfNNoFRURxJ0Ha6yJGJkI1Rs0CFDkV2Kk
         HEnE/ph4F373F8Y7TH4gZRTyyZ6Mb277t7D8Qp1tA3W5Rxr49oghTahpem59YWwnGcQI
         9bcwQev8pprxWk/uajL1EW/g1XcCYQ8Gmfr+cp8Zj7Xc9oCLMDERJB871PEkYwQ8AQwO
         Cxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XR1sCEaBdZSVNWfok/RCgQq6T+iZZXlukoDtEcmBpYA=;
        b=jKWk/BYlEUVcMnAnLr+NbieBFipGFNlwSZU+JvnrI5OZZgLHV8Bn2XyqvmKB2p136F
         F2aJkHChPeiQvdIw4DtKiKrYXp23NasjpI4zcqeFSMhkgtzT8gXne9Xubj1LDuZ/N8zc
         jFgb0aB2etaYYNSOAMubFHKIKSHsGjFZWslbLM6X6bj6o9PNQWf07NqwzvxYaFQHXC98
         hMxPEOHyq2JQIcc304h/beg1a0b5HL7Qja8xARjHZoTULoS/PEr0ZoZ6ISdtvvO83X2B
         cJotv5x+dNBpH9SKqLFmUuXSVlcBQO6kwTdaAdf29a/e9vU/2kvsuKwNIxMG7sq2O1zr
         kiHw==
X-Gm-Message-State: ABuFfog56raSjP17HDEF3W68ftM4wsDAEapJ5pulFpTS1q5TZgCJFGJ8
        jcfXlt2V4bS9wWpUYxBIEEM=
X-Google-Smtp-Source: ACcGV63LjSNlr70lj5LWJN/6pobyxwMT+zntgIXMKwV1yWmTqdF9NW5ORuRjWlGZJSvHenXzegsbMQ==
X-Received: by 2002:a1c:6c09:: with SMTP id h9-v6mr12780152wmc.95.1538945474986;
        Sun, 07 Oct 2018 13:51:14 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-60-162.w92-136.abo.wanadoo.fr. [92.136.157.162])
        by smtp.gmail.com with ESMTPSA id a18sm11011903wrx.55.2018.10.07.13.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 13:51:14 -0700 (PDT)
Subject: Re: [PATCH 00/15] sequencer: refactor functions working on a
 todo_list
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <63f7c10f-9379-06d8-6b40-c527b2ec8504@gmail.com>
Date:   Sun, 7 Oct 2018 22:51:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181007195418.25752-1-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 07/10/2018 à 21:54, Alban Gruin a écrit :
> At the center of the "interactive" part of the interactive rebase lies
> the todo list.  When the user starts an interactive rebase, a todo list
> is generated, presented to the user (who then edits it using a text
> editor), read back, and then is checked and processed before the actual
> rebase takes place.
> 
> Some of this processing includes adding execs commands, reordering
> fixup! and squash! commits, and checking if no commits were accidentally
> dropped by the user.
> 
> Before I converted the interactive rebase in C, these functions were
> called by git-rebase--interactive.sh through git-rebase--helper.  Since
> the only way to pass around a large amount of data between a shell
> script and a C program is to use a file (or any declination of a file),
> the functions that checked and processed the todo list were directly
> working on a file, the same file that the user edited.
> 
> During the conversion, I did not address this issue, which lead to a
> complete_action() that reads the todo list file, does some computation
> based on its content, and writes it back to the disk, several times in
> the same function.
> 
> As it is not an efficient way to handle a data structure, this patch
> series refactor the functions that processes the todo list to work on a
> todo_list structure instead of reading it from the disk.
> 
> Some commits consists in modifying edit_todo_list() (initially used by
> --edit-todo) to handle the initial edition of the todo list, to increase
> code sharing.
> 

And it’s based on the 8th version of my patch series “rebase -i: rewrite
in C”.

