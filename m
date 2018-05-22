Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62B01F51C
	for <e@80x24.org>; Tue, 22 May 2018 02:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbeEVCuF (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 22:50:05 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:40711 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbeEVCuE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 22:50:04 -0400
Received: by mail-wr0-f179.google.com with SMTP id v60-v6so17844528wrc.7
        for <git@vger.kernel.org>; Mon, 21 May 2018 19:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g/a2AoLtWQu9xmniD+/6TSJdb7xZHSSu8hgRCSk5UME=;
        b=dmYcmdSaTYpZJE1Qh/9lUEEMeiVzesFpEQWCoetFX0RpJqSr+tkMF1cHyTVkpFQ92c
         LUVhS5iNQlXYiNOl5Ui9SOnGV0EIa38QCXdRmw3QcCIvR6ShQoHx0fR9EglwxYZTjHBI
         IFdxtPuEJDCCGo5LTjiMv9gQPi06MN1gZZNGH8qUNWz+Y93IjYytDgxeVbsDxqj4wu/W
         JwNt80F24RMg68Q4qK8Y6B1uExepn97EweW7qaXUSFokLs1c1APcFm04Ta3PRiGf+87H
         GV/mUQlQqozvTtij49AmJYhvPXTHLziwCvSJPD45duy3U4IR2i9cRMgXBM7qUKkW9PfH
         jQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=g/a2AoLtWQu9xmniD+/6TSJdb7xZHSSu8hgRCSk5UME=;
        b=U4MfnLwlISNjMB/poHmoTM4gLxxOZ4rn2IwRjcnlmXExlsJ2Mqn2xx76e2RvsNd9Xr
         fXxOmkzy9wZiSDobXVS3P9xeRozmkbLzBGlts1Eztaw8vWwxDBcV7vOFjUXBlP5M5rst
         7CO17CDN7i24JQHrM1SxT79D5g9UNnWvendNVoz4jPRH3/o5MF6b+H8QHEMhFnVwuAhk
         tq1y7fAyN3ef6wiyB4W+S7RmRZZYBaYVhapESKgnVpE8L5JwRXStzG378rQDbVx/ekH3
         TZ27mzT/4dug8pU3wszZ/YJAhdfMCasThT0l6lKPsNzRaffF2ojDdTmLAd7JZoxvZl0b
         jSXg==
X-Gm-Message-State: ALKqPwcFrGpcYKVBnWiLVXwiw8hKfmEGN3weU3G9GsMCtWjMhe6onOez
        Ia9E5/R8og9mxxqkbBDdKrQ=
X-Google-Smtp-Source: AB8JxZokasoc5k7bZD4hvMA4DCjj1udPofQEFIEcRIuVqFwBGyQyXZm3yhz8S1s4WSWDQU50SFFitA==
X-Received: by 2002:adf:ad94:: with SMTP id w20-v6mr18588190wrc.83.1526957402953;
        Mon, 21 May 2018 19:50:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l24-v6sm13699517wrl.60.2018.05.21.19.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 19:50:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: why does "man git-clean" not mention files ignored by core.excludesFile?
References: <alpine.LFD.2.21.1805211221180.18665@localhost.localdomain>
Date:   Tue, 22 May 2018 11:50:01 +0900
In-Reply-To: <alpine.LFD.2.21.1805211221180.18665@localhost.localdomain>
        (Robert P. J. Day's message of "Mon, 21 May 2018 12:24:43 -0400
        (EDT)")
Message-ID: <xmqq603gz9nq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   why is there no mention of files ignored via a user's
> core.excludesFile configuration?

IIUC, core.excludesFile is a much much later invention made long
after everybody lost interest in updating "git clean", let alone its
documentation.  The support for the configuration variable was added
to the internal API used to access exclude mechanism, so "clean",
together with other users of the same API, got it for free when it
was added, and nobody bothered to update the documentation of
"clean".

In other words, a short answer is because you haven't made it to
mention it ;-).

