Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF7C1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 17:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422812AbdAIR6D (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 12:58:03 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33372 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422779AbdAIR6C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 12:58:02 -0500
Received: by mail-pf0-f173.google.com with SMTP id y143so11565101pfb.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 09:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KGjR2qGKi6C9iSaR2TogMXx21ubECTBRqrR7G+0Ei9g=;
        b=f9TtNeZ8T+Ete9lC0yBJnnfuZXwyzbg4g3kbYOoy6+CWu0iHF2lecAQ//S8stb84di
         LITgt0ep/p2WIFIKgRt728DPq4aQTPQnOHamFjFn1xmrWr8D7TCA7cWqGZK20MSRNDp0
         L5mPsH2cowIrlnBiiTVqYRHrB1q4uPJWf3kayvxsKYyKSI8H3HU/hbldonpuf9JNS38d
         ngvYfeIzVTDsaWg2yJ2A7AUG3ELNc4wPJhBcmdqY7Advdk83N7Y05aE0C1DPnPNRiuW4
         9AX4q+xcOICLvCq2B4iu/2pRiYffg5FoCQPjQTmtGboTD5u3CmrU2Zjc+UYNpN5sR6s7
         II8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KGjR2qGKi6C9iSaR2TogMXx21ubECTBRqrR7G+0Ei9g=;
        b=afbu+k2Eq7PWCHbmdxkjhxRfGeB9NoCCLNpQAi60ooEjMct1PY8p6tDbbJqnlpaod4
         uVDhP6KN6kJETHB/1oQzWnluTI/r73FVkrITeUXK0VmgKi0E/JHlSQKiGTyocb85cjAK
         1QJoq2MAXfGUoJn/6eDIRALmVJrQCVd4u+cMKjWH58wZ4NZN70a/fY+4MhCzcwqF9QzV
         PuOXJWBmCji9TbBoqYhMj0moBH/pKhJsI58cs4YREA8poKI8hdH16db9PQVztcm+UFwe
         GvlqL5qz3A8183DLaZY0q93HUe+rgjibm+V0aiJN1WpyQ7Bna1dXXetb4YnEepmfhk/M
         PocQ==
X-Gm-Message-State: AIkVDXJ3RfZRsczFUGIJQaet+IW3xluvs3Oi90beI03Gq5emNzZVGEl3yKA+0W3X+GLZ0Rpx
X-Received: by 10.99.146.13 with SMTP id o13mr165682747pgd.3.1483984681718;
        Mon, 09 Jan 2017 09:58:01 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:cb5:8f45:2d29:8a81])
        by smtp.gmail.com with ESMTPSA id s3sm181106296pfe.27.2017.01.09.09.58.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 09:58:00 -0800 (PST)
Date:   Mon, 9 Jan 2017 09:57:59 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/16] pathspec cleanup
Message-ID: <20170109175759.GA62878@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
 <CACsJy8CM6FfHpVuqby=hjPmiYAxvJjzr1W6LdO5B82KQnTmmog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CM6FfHpVuqby=hjPmiYAxvJjzr1W6LdO5B82KQnTmmog@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/07, Duy Nguyen wrote:
> On Thu, Jan 5, 2017 at 1:03 AM, Brandon Williams <bmwill@google.com> wrote:
> > Changes in v5:
> > * Move GUARD_PATHSPEC to prevent checking if pathspec is null twice.
> > * Mark a string containing 'mnemonic' for translation.
> 
> Argh.. I've run out of things to complain about! Ack!

haha! Well thanks again for your help in reviewing this series!

-- 
Brandon Williams
