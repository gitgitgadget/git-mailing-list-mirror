Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D88601F461
	for <e@80x24.org>; Thu, 11 Jul 2019 05:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfGKFNd (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 01:13:33 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:35254 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfGKFNd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 01:13:33 -0400
Received: by mail-lf1-f41.google.com with SMTP id p197so3138264lfa.2
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 22:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AHzw8Uge+5jFM0hzVOHUqLS8Kre/50a5EDomwnuduLg=;
        b=msiQ4p32cIUl0vNP/3PC6H+/cyiCvf+mE1Lwb7+AJwjzsUFEhXPhY1lLONWgU4hvkT
         XbaERQcRN/vbyzypFYrcyL1NpFUcIM3f9lX3H/yDNg9LEvAYAxpJakl3W9FSc++NboaL
         m/Po2VautIoQleCb37J8HK1c5jBkVhuKtiVHddstKrukya2SgXgRjy+HmDIFds//C9NZ
         Y4qkqUJABcbLn62HSy80YONmudoThRgTraF/oDLzKBpYt3c7rqVk9rg26EZ+JbPwzmH0
         Hsvzpvbozxo7peUDLrSdT8dgqM07eIJLppoLh1/IJbFKZRXZoHltL0UM07Ng6VrQND27
         E6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=AHzw8Uge+5jFM0hzVOHUqLS8Kre/50a5EDomwnuduLg=;
        b=jVfm6I+JzE/TIkHP+ZY/kbkuxXrrkV7Jwv4NHi6n7QoFJM189GRY5pJlbXCU5ljVu9
         ZfQAd/SwUMpnMjoXKiY8cw2sKliGcDNi11SUcPle1Jz+y6F45IaMWrAcSB5CvdSuwSja
         QRuxzeowRsU+geclWgjVqBVCf2dZ7bwS46vC8Z7YNiIOIDjBdBCqi/LBZP43FtO6WCqq
         FjVJ/o1929Jeyzo/kcWeDk6P5rUycC13bVdnVG+ShpkBzjVbIAviXQYfjAbcfoiLlg5+
         VBGNpSzuVwcrNyeAdNxi6Oil+VK9Z91LR3J7Xg/rtcYeC4eNA4y7xTZJFF9vRL9TY1IN
         uhPQ==
X-Gm-Message-State: APjAAAX4Vlnxw7zIG1M8Lo90aUF2Aai6KHs5B3WfxqEmPoPbMUBkMRuq
        q14ZewMyNHfpCuTfTiLE/DDlSRCH
X-Google-Smtp-Source: APXvYqzYceuc10GNpfXdW7wnDVr2p4yhuTW6Vr8k6wXuJXel0Ez8btEai3UTuXiVX9iMVHQdznR7NA==
X-Received: by 2002:a05:6512:244:: with SMTP id b4mr745147lfo.114.1562822010669;
        Wed, 10 Jul 2019 22:13:30 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q2sm591043lfj.25.2019.07.10.22.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 22:13:30 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Elijah Newren <newren@gmail.com>, usbuser@mailbox.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
References: <423596682.8516.1562665372094@office.mailbox.org>
        <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com>
        <1152121968.7459.1562688927235@office.mailbox.org>
        <CABPp-BHpkcOSkTrNDPGWRgSJgbqkc0PRqMqmesg7tQdS5TfMDA@mail.gmail.com>
        <275487563.12198.1562691633735@office.mailbox.org>
        <CABPp-BGPLxR7NgXRHppLy_W0c=Odhhns2RjcQ4iWKKQMz+SpDQ@mail.gmail.com>
        <CAGyf7-FW-_4AbWE735-=7WjZAaTLHOT_QuWOoHKAjOzZCbWhFA@mail.gmail.com>
        <xmqqtvbtu9uo.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 11 Jul 2019 08:13:28 +0300
In-Reply-To: <xmqqtvbtu9uo.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 10 Jul 2019 09:34:39 -0700")
Message-ID: <87sgrdf91j.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

[...]

> The "the tip being merged into the mainline must always be
> fast-forwardable",

It's rather "the tip being merged into the mainline must be fast-forwardable the
first time it is merged".

> however, is not consistent with the topic branch workflow, and I do
> not mean this in the sense that you should never rebase just before
> submitting (which is a bad practice). For an initial merge of the
> topic to the mainline, the project can keep rebasing to the
> then-current tip of the mainline, and as long as they can afford the
> cycle to test the result, "record the range of the topic branch by
> making a redundant merge" would work.

Yes, that's exactly it, and, as the rule holds for the first topic merge
only, the rest of workflow is as usual, no drastic changes.

Overall, it only ensures the first merge of the topic is semantically
simpler, nothing more.

-- Sergey
