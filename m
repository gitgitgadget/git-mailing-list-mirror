Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8332B1F42D
	for <e@80x24.org>; Wed, 30 May 2018 02:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934360AbeE3CqU (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 22:46:20 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:35890 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753245AbeE3CqT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 22:46:19 -0400
Received: by mail-wr0-f171.google.com with SMTP id f16-v6so12576635wrm.3
        for <git@vger.kernel.org>; Tue, 29 May 2018 19:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UHr0j09JO2RGwP6eHbJYoMFOSrWVpb9XTqn4U6mAzlw=;
        b=UPV3pxtuexNYDz8HLFlcKFFpBwwmt5zNtq6aGjGQK8ifPacvheHGcRJ0uhNxENfcpy
         xOfJDkMdEjTT+VisnpruVHb6s4RlmrR6m+ALo58M1HSXLwAMeZzj/cZKf6Spq1htM208
         gjDNuMrsLdxrm0EPj1+sTYdGETHuJKfSykRv3eAFAVKIQaTGtUlCDksl0kNLJdW+g3HF
         sUJ4pYw/ezk1WkCKbZkKThgXkuSpa+/tF3ZmeO2Kys3v1F4FlCPPOnUPz3CeYa/dvO44
         EINS0dcsKva9WeUXqgvivRCMZSCaIEpLYi3z8tfO9nHNW7BRa8rAmz9CFv1gqsPAzkBx
         2r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UHr0j09JO2RGwP6eHbJYoMFOSrWVpb9XTqn4U6mAzlw=;
        b=RMP4zquQTOMZOc6AaaPjr7Y2nPz7Y4HYHBXck3BjQEQcRyDFoU6TmMM0XaeZOKp5jD
         wshnJdchnlC97AXpNFfqeBb1VACEW3e1R2elbMHAUoHqAF5dVf2PyXJ8iDSEWlnj5lXT
         HODRqPQ4eOVMFDYJrUxzjpPV2+0AJTWvfj9X4AeKyaMGC6PkUhwjKM6Jff5/qS7sEFjo
         11Gu/4IJ6KJT9fsAEVoI10OxrK4s+BB/E0NRIX1cj6mCMjxco0xz4GnpvQ+Kgu1LZwkd
         mJyq8d6QbSNCQkc6Btu4M7vFVLkYugpGsWAeN0OHKc5MjnonAvIGNgCIUEp/AlRf8cEf
         GFaQ==
X-Gm-Message-State: ALKqPwcQUHyei13UAsTAU+6dlBL4YfZMjSrVSToOdn2/677GvXHN4/Uz
        9iIQoEzvUXPC0Y4LJKGfIFQ=
X-Google-Smtp-Source: ADUXVKII9v8hfZ8Ifa40xpvE0p+mRjkumjHY0NvBgasjnnnTnPIBrLy7mZXwOp7IDXbohijwHQJcSA==
X-Received: by 2002:adf:a3c3:: with SMTP id m3-v6mr528247wrb.208.1527648377630;
        Tue, 29 May 2018 19:46:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k17-v6sm320841wmc.23.2018.05.29.19.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 19:46:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Is origin/HEAD only being created on clone a bug? #leftoverbits
References: <87bmcyfh67.fsf@evledraar.gmail.com>
        <xmqqo9gyey13.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 30 May 2018 11:46:16 +0900
In-Reply-To: <xmqqo9gyey13.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 30 May 2018 10:24:08 +0900")
Message-ID: <xmqqbmcxg8sn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  - When we fetch from a remote that has refs/remotes/$name/HEAD, and
>    if the protocol notices that their HEAD today is pointing to a
>    branch different from what our side has, should we repoint ours
>    to match?  
>
>    I am leaning against doing this, but mostly out of superstition.
> ...
>    interested in".  But once fetch starts messing with where
>    origin/HEAD points at, that would no longer be the case, which is
>    why I am against doing something magical like that.

Well, I shouldn't say "I am against" on the last line; rather, "I
feel uneasy".
