Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E461F42E
	for <e@80x24.org>; Mon,  7 May 2018 10:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeEGKjG (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 06:39:06 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:40338 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeEGKjF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 06:39:05 -0400
Received: by mail-vk0-f42.google.com with SMTP id v194-v6so674710vkd.7
        for <git@vger.kernel.org>; Mon, 07 May 2018 03:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UdJx5wVkFZjcVRzt0/FCoL6dDLTA8A1uyq9K6nAmzbk=;
        b=Ge6a9nbSUKgM8xNYESQAISOOdI6jLLrMQlr6H2esTfOTs4J6Te8SWK4KyCpJRrt4aD
         JxcJc0aN8Vv33dB2Y9EM7lhJfmzh0CR8/FQoZSTc/WXi/2EKAb1HaWIj10v9CAkVx6Pn
         7KMzJ+Spa8Cmp0EVb6AylqdElrnuHFv9Q4lu1fWmXjsh0jM8tqouIIlZQcf9S5t7s2sX
         QWgunsA8U6cDlKrjGN4mn/0JUshj4T41iIIZaGtnwY+f1aPwBEDmyk869okSSN8DWVpg
         L1wjscw6BqNnjw9fR+Ki7BGr7Q0E9fSWu+BswEO5xx1OIYtTaTy4NlP4MnluDCDLLMLR
         nrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=UdJx5wVkFZjcVRzt0/FCoL6dDLTA8A1uyq9K6nAmzbk=;
        b=pn5v71dcWAf8YvWIWUFpR+QIyVcjuUR0B0ZmpAHNV6dv+Xq9Upp2cTZ8IX0vsdaM4O
         K8wN7f7Mfc86b9Dczdj3T4tU/g7fo87x3qoTH31gBzAKvIYUAuGug2SZDfRla8SsC7J0
         qncU34b6NfXWjHAZFGQrKD435i8azXOu19Q1o2eAuV4Iu3GO/bC8T1YzRCu4U8vNte1u
         ZI6+0bHgkz3gfI9smocg3bMT5IXmSxO5qXPzdZHuJEN4tJD1w5LAAypTWsLsla15rzip
         AYt72DgMAcIAmYAlPKKykI/38f32WYlfObtWSMZiwJO7/4/jt6OvIGj5/kavuQVL/dIz
         7Mfw==
X-Gm-Message-State: ALQs6tCP8m6CGjVztd1kdBNXxUmTlrFZyMIDbG+BXi7DSFAOdGeRszVj
        sHfcUu8v04dqiakxKgL5NoAUZ8eOOwv4mOUp5WlIzw==
X-Google-Smtp-Source: AB8JxZptUut8aJ+8cjtLgjqb4fIICJ0W3wm00YGme2UvRnFY23i/hUYMfsDyXIcAgkM4oBO/T60zJFUakW821nGZJUo=
X-Received: by 2002:a1f:c5c5:: with SMTP id v188-v6mr32350123vkf.48.1525689545057;
 Mon, 07 May 2018 03:39:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.22.212 with HTTP; Mon, 7 May 2018 03:39:04 -0700 (PDT)
In-Reply-To: <20180429164232.29337-2-mail@floga.de>
References: <20180429164232.29337-1-mail@floga.de> <20180429164232.29337-2-mail@floga.de>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 7 May 2018 12:39:04 +0200
Message-ID: <CAM0VKjkTu+OkLM3gvX73mWugxArCVmqRBmWGHiKuLiLRNkkNow@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] completion: load completion file for external subcommand
To:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Szeder_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 29, 2018 at 6:42 PM, Florian Gamb=C3=B6ck <mail@floga.de> wrote=
:
> This way we can leverage bash-completion's dynamic loading for git
> subcommands and make it easier for developers to distribute custom
> completion scripts.

The patch and the updated commit message both look good to me.
Thanks for following through.
