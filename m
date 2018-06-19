Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34AE81F403
	for <e@80x24.org>; Tue, 19 Jun 2018 22:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeFSWhU (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 18:37:20 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:47229 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeFSWhT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 18:37:19 -0400
Received: by mail-io0-f202.google.com with SMTP id 140-v6so1248375iou.14
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 15:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=NemboJazoLORCzPWrZvCnbBCHo5vEYEXFzOgzG5QigQ=;
        b=SzlWc72J5TY2PyDeG76XLYdDthDvFKenIMWLNoM+lWCiZXpgEpiR0an8thoDyf6rWO
         /lEJFU2Oa1Fp7cX7RcMWm8A24O5jOFRv2DuOjuoDyQET5J70UmkzRwvm5SNRBj7lZ5WU
         eezOPHE3L9Rma7FpXEvL91t28sUFMyzzXkZNTm5w4bAS12FxME3zi1VpmhoSMSVqLGnm
         MHCPmOp2KyJVXF+AvgFLisB1GLExJKvlHwle0asZ+aELv1zA9KTDTUFfWdeZXb08EyqL
         uHjUvUSfYbU961uDXGdr48hkP7j47qmP7q1lqAACoOvlr56vR9qsmfPusyspylW54I9O
         zZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=NemboJazoLORCzPWrZvCnbBCHo5vEYEXFzOgzG5QigQ=;
        b=KGInmey/cLWcugd8T/2NjlVbH+xX+tnq/ImoQWCiVnHuxjJFQ35YN0fvRuYZBQucSR
         7UO8ZWpSUJ0bxWKT4Ih8syKo4+CKdri2akr155iAbr1mMOJmmKLP8yFVuY2jPlmYHzr6
         S42zRhOxhVaF/fYIpAHYVsXknprYiUvK34gvBPRC17TSPEMiJW9J2HGD5modpqKnrbp/
         27mqFhNc92RwJeTW0svHTbguKtgwdu5zm5ORfyKjebEZQgwHjlgv9HakWORYKY9DAzrx
         meE6k1TIMe58iR5Q9Ba0y0m/sjBGbTmSpVscq7HsrZrlUux9ZTrVdQvUOkXHnZDyOM0a
         sYPQ==
X-Gm-Message-State: APt69E3U1yYDouaXPy2JwXaN0uQOCbwSoDUaDrJDMd+bOGgvrfrUDbSa
        LOreANx9Z1b9H6W6R0IibjSzNNN+oZu2pcn0TShn
X-Google-Smtp-Source: ADUXVKK51AuVADyoar4XIAX5bo3mO52X4LZFrK7fuv2DqatrRh/HWhxVnRXtkfDWKCDGJlWPQRPEPst2sybFgOG3KF2D
MIME-Version: 1.0
X-Received: by 2002:a24:fa85:: with SMTP id v127-v6mr7123552ith.11.1529447838789;
 Tue, 19 Jun 2018 15:37:18 -0700 (PDT)
Date:   Tue, 19 Jun 2018 15:37:12 -0700
In-Reply-To: <CAGZ79kZtEZA1rvgfSCS+m4dsrB86Cf-XiePWQmeU-kCNxP_NLQ@mail.gmail.com>
Message-Id: <20180619223712.127990-1-jonathantanmy@google.com>
References: <CAGZ79kZtEZA1rvgfSCS+m4dsrB86Cf-XiePWQmeU-kCNxP_NLQ@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: The state of the object store series
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Floating on the mailing list, not cooking yet:

One more is my bitmap one here:

https://public-inbox.org/git/cover.1528397984.git.jonathantanmy@google.com/

It's not in any branch yet, as far as I can tell, so I've just sent out
an e-mail letting Junio know [1].

[1] https://public-inbox.org/git/20180619222749.124671-1-jonathantanmy@google.com/
