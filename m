Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A87671F453
	for <e@80x24.org>; Fri, 28 Sep 2018 19:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeI2CTd (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 22:19:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40635 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeI2CTd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 22:19:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id o2-v6so3293946wmh.5
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 12:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B15MnO+YCod5yWTh3x2LXufhLydpNQIPTi7qgJoBEug=;
        b=VppqiPBEKIqBZbVAkcpG/x2uSNoDrPAwC5AFkBD7AFWOqt1OjtSb9mZauTKxxAwIjO
         El5nlIPPxEivBtdX7XXBuuNZlEUxRoQGysFkFvh0eyFBUven09mgXSbUXeAITxWwWZx/
         5YKF/ds1/GfGWRot7SlztKBufV+5wrajcwxwQVpXI3l1YWD4mqaxcHjg0adCViCRlR7d
         boShbxUAyxq+dbGzPlxrye5zp374g1Sfq30rd9y69bWP5H9cIV+8osBaPyzzjm4Imyve
         nH9V5a1w5NvZXgy9VcjYyRHqd6d+cUepMmR8koYBqMBCVQ7XWsKB51acVu406fYu4I4X
         1tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B15MnO+YCod5yWTh3x2LXufhLydpNQIPTi7qgJoBEug=;
        b=YKrxO+pMHeFFKFI7CsAhSG68jLG85Bh58YeDaqZGUhHA1b8cFoRIRfbkrF/fUiZ7t9
         FSW8mEZnOIgo4CvDjQepProVVvJk8DqvjqTgoTDPwEXETcOE4kvTIVdZaqZA+XX61vwv
         EhAcdpKbPg8QI0DHiIYbCKx69Cfc6ZEgdrcfLf125yfrKo22q12pU8y+xs+SAiU20KtC
         xD1OYAIwEcN1XKd68FQi+4pW9uEFNoQB2BMKup72LncBAeQRLrbKRzPMJazDU4f+pIUK
         CJpUlk2+YT6U4pNq8lIE/7N5vy8c9pkWnqb5DS0qkyq/Xs740sF/BQvB6LWFc3ZXUxxh
         cc6w==
X-Gm-Message-State: ABuFfoi9h8mAMTl4lS9FxyX5fFzTNKLy1qgNZEhpxPSTJ4P/maFp6HFq
        36vARfwmzjuTX2l86qYUsS4=
X-Google-Smtp-Source: ACcGV61GZh6VRGxuceVrSpJcHHocA8Gj0KiCaIbzE9KiqqAlH8KFfxsSBc8dBhHcUHStRBhjqroGJQ==
X-Received: by 2002:a1c:5459:: with SMTP id p25-v6mr2648471wmi.129.1538164452936;
        Fri, 28 Sep 2018 12:54:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j66-v6sm7319652wrj.28.2018.09.28.12.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 12:54:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
        peff@peff.net
Subject: Re: [PATCH] strbuf.h: format according to coding guidelines
References: <xmqq5zypefcp.fsf@gitster-ct.c.googlers.com>
        <20180928173033.159192-1-sbeller@google.com>
Date:   Fri, 28 Sep 2018 12:54:11 -0700
In-Reply-To: <20180928173033.159192-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 28 Sep 2018 10:30:33 -0700")
Message-ID: <xmqqr2hdbdp8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So let's format strbuf.h in a way that we'd like to see:
> * omit the extern keyword from function declarations

OK

> * name all parameters (usually the parameters are obvious from its type,
>   but consider exceptions like
>   `int strbuf_getwholeline_fd(struct strbuf *, int, int);`

I am mildly against giving names to obvious ones.
