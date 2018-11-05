Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EF381F453
	for <e@80x24.org>; Mon,  5 Nov 2018 02:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeKEMCc (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 07:02:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43436 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKEMCb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 07:02:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id y3-v6so7441547wrh.10
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 18:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vJetQHY5e6HNZcAglZ8XLgfEqXaMsunqOb07mL2YgYY=;
        b=nLfwvaOgVE6BBN6e+UklBNDFI/Sb91ghD2VR0NjLgWS06fqICJU9NavjtJKjyPYgXa
         WMqk0h1hDGvwBpxMAh8/rIatYKqACXgBT288owzIYkV5o6fQ8SrXWqQGDxa85v1CvVSN
         xtUMwV/F9BnVjQyCbPt8HCJRMs2xHCmTM26i7c7bfC24peGMRoQI2Ia+GecZmm6jCoth
         AFl5rR9IeqGqQQfEjgifLPc9PSw2RbfKvuC2lF0BA/ratQfseY3vimlg9cLKLLfIwp9U
         kIGC1NBhbCHTF+OGrvQiI4zODWprYfByxLlpOrghG+jbyQSC5vXJyVA0Y7owx5wKHBPL
         WjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vJetQHY5e6HNZcAglZ8XLgfEqXaMsunqOb07mL2YgYY=;
        b=cx+Ob80v4lCHQrDk761Banmb1Vi0BShWUVvr30xtyrr493GM1VXVGDzshLb2ritwTH
         n97uCTCg6q9+x2IKlSZP4l6oMcMZcIXUmgl0keacA48pQySnTavqfmcyDc5/IGjnM8aW
         ogJ1H/PomxeVWP4I+wrKHs6PaFGs08g83jmb6OMqsnHiVL8UKeSnnwOa166+dzNI6qeH
         gKXKAKpLM9fkZd9qE/iIzKqMUa5bvxTqqDyQx6UeFeYWqt/tjGVfhVCYqvoYtnSCXWhB
         QHRZ9OrIdGVlfydQsMTf5d8mXO4si9OYWERtZCP3EyHlwD7Q35pJtTDZDReHI2nTBka7
         p4SA==
X-Gm-Message-State: AGRZ1gJ9qooVgmkZqg6NGhqC7J5bw6ENnx/E+9t5r20Syru1bssLb+QL
        wTSZYq/MvRydzZs3YrfA5NtH0nO4g5w=
X-Google-Smtp-Source: AJdET5cWPzgup5msoa4zHymWKztqZJebxZJpJDJ+5J6pqFxIUDQcFDZlaarzorMAiut2zhJPwF76tg==
X-Received: by 2002:adf:f9d2:: with SMTP id w18-v6mr17966583wrr.134.1541385908318;
        Sun, 04 Nov 2018 18:45:08 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 137-v6sm5983453wmo.43.2018.11.04.18.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 18:45:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 00/12] Base SHA-256 implementation
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
        <20181104234458.139223-1-sandals@crustytoothpaste.net>
Date:   Mon, 05 Nov 2018 11:45:06 +0900
In-Reply-To: <20181104234458.139223-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 4 Nov 2018 23:44:46 +0000")
Message-ID: <xmqqefc0jl8t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series provides a functional SHA-256 implementation and wires it
> up, along with some housekeeping patches to make it suitable for
> testing.
>
> Changes from v4:
> * Downcase hex constants for consistency.
> * Remove needless parentheses in return statement.
> * Remove braces for single statement loops.
> * Switch to +=.
> * Add references to rationale for SHA-256.
> * Remove inclusion of "git-compat-util.h" in header.

You ended up not doing the last one, judging from the interdiff
below.  I think it is OK to leave the header in.

Thanks, will replace.
