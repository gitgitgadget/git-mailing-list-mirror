Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B4C1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 08:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJPPtg (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 11:49:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51211 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeJPPtg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 11:49:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so21244440wmf.1
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 01:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4TCAkwHTM7rRvV5ImKd0NNZcaQ0yGssnBYuiueVYmp8=;
        b=ZndzRDF46ruqDqQA1cucoa2MIJ6r2MkOyKulun+6yw/5VN8A1x8lMNYqk3jaOYm9GA
         xDrUw+5rkUvCOMJjh48n1GTGBRKobbRC+SYKEW4NYQHDUhteQg4vcMLu5edLQrRvHPay
         aaFwhVB6jRiu//gqrud1akowNzsCsFB1VxMqEIcWG9Epc/GDlbP8ygzghkMb6JGTV2Yo
         xqr6Qz8KmEQL63tF82t/6TFd89bDxiv+HkT51cPRkOAy8ml4E2tXwbNi/ax/4ol3ZVzY
         GpvFWLzjx0RQqYLxHDAhgazULMCvRMgbhMK9qerbY9+jtJphUn+a6MAWpEpACz6bHC+k
         WZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4TCAkwHTM7rRvV5ImKd0NNZcaQ0yGssnBYuiueVYmp8=;
        b=Oikp+srSDe/25hubV/K9H7ZihlBrHP/hCtHRGAZS7zs2X+C/xFaZRrWaJT6VO2PEmF
         uApTdHzTPcMIiTJp60CxexDt3y7oTvGDg5vVaRqcZWYPfFDEA19lIL6IJUO5wA/4ryiE
         Kh7OJmYIrY8QEAsyWQ8UADW01bnmnHghaC1c1Lgu3+wlXhFjbRFdVxuAZfHijusITwju
         eiYdwtnIoqIADCdEzdjkJqH5cgUN8HuOfw8zo8k58lUSIBpufsWX4hs/0i590762AQds
         94B4TjY1O/EibcL3tlzKaCspxVWhpk9t/m2xK8GHxb6mTh/e0FHULgVgQqupcicxmcLc
         4y1w==
X-Gm-Message-State: ABuFfoiyPzSM0R9rqw4+p+8T5cwnC04aVgob1CjoUGc8yNc8zl5CQmNr
        I9JGXMZNoOvYY7H1Q1TQLXk=
X-Google-Smtp-Source: ACcGV61eAKxlvTw613cXFNYkaJ+3PsL2vc5d30S9rqG6XSOvf2G/PqEoZXiFSmSXPiz0duRiznp22Q==
X-Received: by 2002:a1c:89cd:: with SMTP id l196-v6mr15448915wmd.7.1539676822443;
        Tue, 16 Oct 2018 01:00:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d16-v6sm10391912wrw.78.2018.10.16.01.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 01:00:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Hesse <list@eworm.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] subtree: make install targets depend on build targets
References: <xmqq8t2y1o4y.fsf@gitster-ct.c.googlers.com>
        <20181016075624.30176-1-list@eworm.de>
Date:   Tue, 16 Oct 2018 17:00:20 +0900
In-Reply-To: <20181016075624.30176-1-list@eworm.de> (Christian Hesse's message
        of "Tue, 16 Oct 2018 09:56:24 +0200")
Message-ID: <xmqqy3ayxqwb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Hesse <list@eworm.de> writes:

> From: Christian Hesse <mail@eworm.de>
>
> Now that we have build targets let the install targets depend on them.
> Also make the targets phony.
>
> Signed-off-by: Christian Hesse <mail@eworm.de>
> ---
>  contrib/subtree/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, will queue.

> diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
> index 6906aae441..4a10a020a0 100644
> --- a/contrib/subtree/Makefile
> +++ b/contrib/subtree/Makefile
> @@ -69,11 +69,11 @@ install: $(GIT_SUBTREE)
>  
>  install-doc: install-man install-html
>  
> -install-man: $(GIT_SUBTREE_DOC)
> +install-man: man
>  	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
>  	$(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
>  
> -install-html: $(GIT_SUBTREE_HTML)
> +install-html: html
>  	$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir)
>  	$(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)
>  
> @@ -98,4 +98,4 @@ clean:
>  	$(RM) $(GIT_SUBTREE)
>  	$(RM) *.xml *.html *.1
>  
> -.PHONY: FORCE
> +.PHONY: FORCE man html install-man install-html
