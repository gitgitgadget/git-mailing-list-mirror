Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B2E11F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 22:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753466AbeGCWMs (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 18:12:48 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:46268 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeGCWMr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 18:12:47 -0400
Received: by mail-wr0-f174.google.com with SMTP id s11-v6so3377820wra.13
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=94wi2zC0cP5TUnTHV/TuDKkYXIbI1sQpAn9nKTfCQoo=;
        b=cJsEBZMhrMrG+yvreHc4zk9isDSQLNMt2PCCEkd7MqUJ/PWQB3IzHVYMNEUnoTT1xj
         FKTrHQjF2vWINAdnHtgJ1+/R4QCMYWL89+VInavgsk+q9n+Go2XszkjeNUb9uampFSJT
         pSzdXJRxv6iVqzFVdiQWE29d9A3IhVazZIq4Xx8HFg767yWBRFI0pP5tJyoufmipqirb
         Z4Lq3o0XhnQSJJsiJUlV1E3xy+8/XFUMovkK2MACt4t8mvT+E5MBWI2raEd5eF8sQIzl
         na/HeqfSowplFC1CfwN8MBxCA6VEbjZWI0v0ZFt7jqe1NjlBLxxOrXU5Xqlfdd8hNVou
         eSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=94wi2zC0cP5TUnTHV/TuDKkYXIbI1sQpAn9nKTfCQoo=;
        b=XQ+hUt9PxGBgn8AL4GDM3lK5yopKmkpxY+lxcIShe+FSx0wNg7NiUeN0jNJWmkSROS
         2McGC67dRHHu5seRd+pjQrZpCCrd0zKgZp+VvaYJusyIlzDh60nS7a6/Uc4fuGciT6iV
         J+UEZySgF3uyE6KpHG2rij5pm9erzd7XqVssAjHRjo3EEZqzgmaNAfNMZ7hxfGKD6nq5
         HFnGPNdqWUTS5KIBm3ey2Z1ZUu45n1RKak+TKVNm6c6AgFsEENPKGP3842tfmRQP23Kv
         x/aUPQ8dzEtFbvAXmdjoN1TjAHN+QSfGAc5xZBmKPi3e3JujMWGgKfQSxhMBB9V350BY
         FpQg==
X-Gm-Message-State: APt69E21zlnjqZeph22BXeGtH7FKAnxcCEFnWbgFfezNZYcS20vAX+hI
        YzGA15evLtbYnjuyDQs2juY=
X-Google-Smtp-Source: AAOMgpcGwlSnEAL7h8mE+s/HOmgCh3erucQF0HYLui/kjZjfVQgeaTekP4fNj69xQUFu7GXo6teung==
X-Received: by 2002:adf:a963:: with SMTP id u90-v6mr24593183wrc.248.1530655965943;
        Tue, 03 Jul 2018 15:12:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f76-v6sm193538wme.30.2018.07.03.15.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:12:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/branch-diff, was Re: What's cooking in git.git (Jun 2018, #07; Thu, 28)
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807031504130.75@tvgsbejvaqbjf.bet>
Date:   Tue, 03 Jul 2018 15:12:44 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807031504130.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 3 Jul 2018 15:05:49 +0200 (DST)")
Message-ID: <xmqq7emcnf37.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Seriously again, I sent a new iteration:
>
> 	https://public-inbox.org/git/pull.1.v3.git.gitgitgadget@gmail.com/

Thanks, will take a look but it is likely that I'll run out of time
today, so please be a bit patient.
