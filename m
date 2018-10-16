Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D38B1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 02:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeJPJxW (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 05:53:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37506 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeJPJxV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 05:53:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id 185-v6so21571303wmt.2
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 19:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q6rtaORS3fVbWsrnnqCkXcFMpzX7uOQxwzFsZ6Hu6s0=;
        b=PQ/XY8RRGWAc+unNSSe+B4SejfPt1FkW5AMf7ajhdA/4T9xfwN5rXyYxjPxlYfdGLL
         KRILBdFjlcugbJQX7fOKcM5aSKuepw0OGVuuOnLtvz5fMvPlUKBqgJFsLmB0VcPmUx16
         qUb5qDNerZ0yoLMlLY+UyQJU+ja2FjnvYeViT6omrCx6xwnH6t/nxlZdlM/8EczKKETE
         WKEQ5tHAooLL+BOToogAzAtjGYHtIZZZijjjuNMOJphoAsbMJBi0vKG6pFEYzKduZQv7
         5VLz6UJMzoRA1gLKijoeNEbt2aECYKGRBfTwZxiqIi5n80fxRsQxRSYLtcI02b6RquFb
         FHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=q6rtaORS3fVbWsrnnqCkXcFMpzX7uOQxwzFsZ6Hu6s0=;
        b=D6kbaS4dGfBtH9jxqe/CcFpYngxs4NCLmn2cCk+GzAMRATeRKUKUyF2i1xUC/uCqnW
         L5nsetNMwP7f4yxeXCdK5VaR197vSXzossbhr2seyWTxyEWRtovoo1gbrxAqtVFgRwY8
         AFauxJ+uPfGj8w3o83bVy+5qe+fD/8RWS1PB/zniwyGpENH5NhHPyXMFywa5SOoluKAM
         T1ujdEOVwMngYKNVBzIAvFR+fEnJh68zazUaymd72BGh5YVTx5icoY6qyKNYc9iUYeH5
         JVf5yV+Qc0MiOj4ZvJjpdhVjSH/ouDoSfHV6zt1e6WlrPcCT1JAr1fPGB4kAiboBX51L
         A5Fw==
X-Gm-Message-State: ABuFfogd+7t27GVhVVbdz6oneDzdftFXUCU6MMAk5ScZc3Ze6A51iRjF
        UEJoFZSPa93ePUOwcXvrx3U=
X-Google-Smtp-Source: ACcGV60R1C6NGG3JmBRMVLmLu4DjZulChhvLgi+IVignTBvQuT+IefCpeYdiJ2VBYBjwzH7UYCKs8g==
X-Received: by 2002:a1c:cb05:: with SMTP id b5-v6mr14492887wmg.44.1539655522075;
        Mon, 15 Oct 2018 19:05:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a12-v6sm8533283wrr.71.2018.10.15.19.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 19:05:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Hesse <list@eworm.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] subtree: add build targets 'man' and 'html'
References: <20181007073036.30643-1-list@eworm.de>
        <xmqqmurmmt9j.fsf@gitster-ct.c.googlers.com>
        <20181015231501.5a7524b0@leda>
Date:   Tue, 16 Oct 2018 11:05:20 +0900
In-Reply-To: <20181015231501.5a7524b0@leda> (Christian Hesse's message of
        "Mon, 15 Oct 2018 23:15:01 +0200")
Message-ID: <xmqq1s8q4pen.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Hesse <list@eworm.de> writes:

> Junio C Hamano <gitster@pobox.com> on Wed, 2018/10/10 11:26:
>> As 'contrib' material without real maintenance, I do not care too
>> deeply, but shouldn't this change be more like this to avoid
>> duplicating the list of targets?
>
> Probably, yes.
> Do you want to add this yourself or do you want me to send an updated patch
> or one on top of the last change?

In principle either is fine but keep in mind that I'll likely forget
if you leave it up to me.
