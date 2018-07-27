Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40DFD1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 19:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbeG0VJK (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 17:09:10 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:45866 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389162AbeG0VJK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 17:09:10 -0400
Received: by mail-wr1-f42.google.com with SMTP id t13-v6so6121421wrv.12
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4izaOtavDXvr4S2T/trUnfG9mhuyWH1zN8gZlGjIFCA=;
        b=jQE/p50UbyahoRGFhxjQBfIu2z6t1IUKeRoVdyi6jwRLNcMI3sJi5r6hi6BY485RP7
         0qDySuK5Ik/07QGD7SQW27rZ9Bk/XAnDrnPpmnSYzS6eU/l/iW11ytkX548p55auMXvX
         KBpBWvNzGO2FAeSXPLMX+u//9KCbsE8CCWyXe1LHejgvk9I8/L/H3iahEoEr5VXa5bdb
         x9u9C/DKkPYHQklIaEjLOFe8NsQh+Qt70H0fCOY+IMDJG5vMQu5q5cVQUi3vqfOwUM8I
         /9EoB/YrTDWKU+Cb/6pIeKLvIKPYMt1VmlcCFIjM9poNe/kGJE0sLtPpQQlffSIn+lFy
         Cd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4izaOtavDXvr4S2T/trUnfG9mhuyWH1zN8gZlGjIFCA=;
        b=SKqKtXyWX/I2hyU0OFkjL8AghnmhNC2dw0F3/71bbArniOlj0fObAmS0ukGqQjXW/c
         j6XiIgQ4OAqaY9M3O6KC9Iw10pVwASdQdbtjFqMLVAn3K4Uo2XttFuoNgGvHMp6teAq4
         bSyvUCgF/AHexSt1rLn1JFP53DhiJGgCzTfBCJfFXPkFzuE4dcV+ML1gkZRR82eWQRvy
         qUIYPZW+x4kBImCqrYg1cj763OkfBHb6Mset5/6fgTa420LwIIpiWg4STImQeaZC3vZs
         hYZDU/QMlgbBJEuxplA043sr3RxolCwB3olQNHSuDY3CQE4LD+HtVToPkJmWlCy0IZuT
         Tomg==
X-Gm-Message-State: AOUpUlGd15cw2Z7APeqfum13c2DWIU3B4T+H8bFz2uUxKYknp4vpXLFk
        K74FM0c7zchDaVbMtpoD0FI=
X-Google-Smtp-Source: AAOMgpc/sgulYnnRBgIoKVV3rLwqqzf5SlU4HFUxw+pWttASep61yj01XMZRC4DnEguphI5VoCAczg==
X-Received: by 2002:adf:c891:: with SMTP id k17-v6mr6487163wrh.6.1532720746740;
        Fri, 27 Jul 2018 12:45:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 71-v6sm3738188wmq.17.2018.07.27.12.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 12:45:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 05/10] config doc: elaborate on fetch.fsckObjects security
References: <20180525192811.25680-1-avarab@gmail.com>
        <20180727143720.14948-6-avarab@gmail.com>
Date:   Fri, 27 Jul 2018 12:45:45 -0700
In-Reply-To: <20180727143720.14948-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 27 Jul 2018 14:37:15 +0000")
Message-ID: <xmqqeffomphy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> +For now, the paranoid need to find some way to emulate the quarantine
> +environment if they'd like the same protection as "push". E.g. in the

We probably should mention that you can immediately prune, as these
unwanted crufts are unreferenced.  That would probably be a lot easier
workaround for the intended readers of this document than "find some
way to emulate".
