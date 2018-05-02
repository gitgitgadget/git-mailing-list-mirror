Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2069E21847
	for <e@80x24.org>; Wed,  2 May 2018 04:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbeEBEe5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 00:34:57 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34114 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbeEBEeu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 00:34:50 -0400
Received: by mail-wr0-f169.google.com with SMTP id p18-v6so12479503wrm.1
        for <git@vger.kernel.org>; Tue, 01 May 2018 21:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nzDGm5VAAW7/1bHjuSy1P6fgovUbIvXPVLUM4X3xQP0=;
        b=cDpNiDFWY97KiD+Qsgk1LTm01Q7IWc/SXgz/mTEVGy/Z8rp9817OVXwZXIBWrrvlHG
         XW650HjO7/A1IALOAw5MISiG+OpDihY3RC/fKkiRAKnoOxIRc5/6pWsJAf2ag53Ljn5H
         BYDbYHljhlWEoCutIQyTV19uUV3BGwoQNU4sMz8WZIZZecvVFTGww8wMmGXin7yl0VBh
         kYJ5S4DnsB5ElK2k5Yq2EjG6iayhGAjjohvkcyMpEmp4j8sGxPMPMeOeFm7RlG7gDaqJ
         Iz5jd3HT2sRluz9nqWLZt8aCtu2TIFxwnjT2XZspFmefPV91nzPC3OSlLxI2EhUFS5Q4
         gH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nzDGm5VAAW7/1bHjuSy1P6fgovUbIvXPVLUM4X3xQP0=;
        b=MkNy1r84pCwG0Zi1EY4MwWfwbPNshTaVvJNbibdyooqeNyxM/+lbZNEzZGkpVvCHPK
         1/QKOON0i3uh5ag9vYOs22pKRlFiVgJIg0Bu6m2Ml66XPwAejmsNy4qVFkBfjlwksY7J
         QxUR7/zJt1NQ2cPgGQA3QKlstkSpQgCujY5jXS2sAwPQX/mW8uZ/vPbEJafqB4FmtRtE
         quFSdFbuSNHHW3hUXJjRZioUhsK8ebphRsrUr+SdMR3GtIqNnv6T4Ah6aRT/YTNVQ3BG
         SNdvy91xdZ5B+azgOOkt7EeRDGy/fsixBDrJQgh8lA3dv8QdM0AjJqfRxGc/2JSeJdku
         iNOw==
X-Gm-Message-State: ALQs6tDYfnZG16Li+mq96odT9e8ZVGgRoFAvNXue+dZxdkgxwR/sHBV3
        PUFBYIHi/GNA97GEOLwW2+8=
X-Google-Smtp-Source: AB8JxZrct9Jd3WclwimS98Kke/uAcZWu4dYxX0ntV1xelBoaOX2hluP8gWViNyA8xz3CRC/zSQGTIA==
X-Received: by 2002:adf:e90f:: with SMTP id f15-v6mr14196956wrm.167.1525235689352;
        Tue, 01 May 2018 21:34:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j76sm27083809wmf.33.2018.05.01.21.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 21:34:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Casey Fitzpatrick <kcghost@gmail.com>, git <git@vger.kernel.org>
Subject: Re: git-submodule is missing --dissociate option
References: <CAEp-SHXo2fnyUSMDqJnfOkh_R21R2FjFUtQ14u9s6-tV039tHg@mail.gmail.com>
        <CAGZ79kZQ3ce8QTJy2Siiuoz=pa6qWweNc8GTpoygkvKuoFXaAA@mail.gmail.com>
Date:   Wed, 02 May 2018 13:34:48 +0900
In-Reply-To: <CAGZ79kZQ3ce8QTJy2Siiuoz=pa6qWweNc8GTpoygkvKuoFXaAA@mail.gmail.com>
        (Stefan Beller's message of "Mon, 30 Apr 2018 11:19:08 -0700")
Message-ID: <xmqqin86wu8n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> As far as I am aware this can be worked around with 'git repack -a'
>> and manual removal of the objects/info/alternates file afterward.
>> Though I don't know if this results in a less speedy clone than
>> dissociate would.
>
> That is an interesting workaround!

It's not just "workaround", but actually is an implementation of
that exact option, no?
