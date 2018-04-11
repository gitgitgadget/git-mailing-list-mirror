Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825171F424
	for <e@80x24.org>; Wed, 11 Apr 2018 06:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeDKG7D (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 02:59:03 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38524 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752445AbeDKG7C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 02:59:02 -0400
Received: by mail-wm0-f44.google.com with SMTP id i3so1703952wmf.3
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 23:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gIV5NXxawcD72RymOZ4B16ohoLQXUwO4Z0XLiVgIzus=;
        b=dRJ4kJQDZw9b35oSwj0ZnDxk93aaE9HHQuIOtKI1JcLqFXUxDoKAqYWnexh1U7CE+v
         1cWcrdNrKta/q87NxH/99mQNVAC0Im7dx12r4CMctKVSIc/p0cKzxw/8ixJs/fbcEqMF
         uo/L2o9HtEGm88/B45dE6Zm8RENWI7hCiD6z3+/qY5zbCNuBbneKUVUVAoDDWT0IAaHY
         OvynG1FV2gM9ix8OWvt99i25HlfzFjNCN3csqITqFfaaflc/reedCZ2dYhP3Mp8gBrsn
         JjeaYzdHG+XvDCBJovyqlAozWixPTk49S8l1ZLMzr6welcoEZNnWFBB1TDquUu8iVriP
         GzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gIV5NXxawcD72RymOZ4B16ohoLQXUwO4Z0XLiVgIzus=;
        b=DWGzUbgxmkfLRgxaMyQfkR8XOEr6mQ8/1o1K+5m6uUxX8Ri/5BY91M/t9PvNaGWXW7
         PjmikHnhuZHklAfBL/3sO+Z7/ynFHypKUCLgKiITkQRE1/GDq85NxPyAPrJhEWFN8cpK
         Kg5H02i0t37jDylsbVc62LOaaC/jl3xWUs1X+ejkScSKibCFtt6Vdj+qgL2bGnIBth+A
         e3TQuQ6CX/WhByyR0OH4kFW4xM1I3jLTa8IQFL2rSDNNEwyP3wTWsvi4u+WZ1Pfbzb0u
         dkroO5OUQxL8DgdxflX1XP9egK5mafmLfQLsAMxwUYN4ICDMNOkl1RSojL9zBRjVoDAO
         HZVg==
X-Gm-Message-State: ALQs6tCSAi6Xynm2zaHPYaZJzkoa3Jbv7LHBlEz30U3UbKp8OwIxOcKc
        BZWAgJ6a5wn61Gb0p36SnT8H8tmr
X-Google-Smtp-Source: AIpwx48bznGik96e7LQSgsttkrEPct4wBRh79SkbfHrhS6mjZj0Du9cHW5a1cTENYm7IYKDuUOj/Ew==
X-Received: by 10.28.191.20 with SMTP id p20mr1549196wmf.100.1523429940521;
        Tue, 10 Apr 2018 23:59:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p5sm1160044wmf.37.2018.04.10.23.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 23:58:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "alexmv\@dropbox.com" <alexmv@dropbox.com>,
        "blees\@dcon.de" <blees@dcon.de>,
        "bmwill\@google.com" <bmwill@google.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin\@gmx.de" <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v1 1/2] fsexcludes: add a programmatic way to exclude files from git's working directory traversal logic
References: <20180410210408.13788-1-benpeart@microsoft.com>
        <20180410210408.13788-2-benpeart@microsoft.com>
Date:   Wed, 11 Apr 2018 15:58:59 +0900
In-Reply-To: <20180410210408.13788-2-benpeart@microsoft.com> (Ben Peart's
        message of "Tue, 10 Apr 2018 21:04:24 +0000")
Message-ID: <xmqqr2nm44b0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

> +void fsexcludes_free() {

Write this line like so:

        void fsexcludes_free(void)
        {

> +void fsexcludes_free();

void fsexcludes_free(void);
