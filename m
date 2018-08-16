Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B9BB1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 14:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391427AbeHPR5E (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 13:57:04 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38502 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391394AbeHPR5E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 13:57:04 -0400
Received: by mail-wm0-f43.google.com with SMTP id t25-v6so4617840wmi.3
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BSsqJ0kxeXVyaSY8tHglmDjr3z3NbMGRZtPxcQPIlCQ=;
        b=Jyvjtjzw+Iu8VSn4TbuzhGfX/y2Ugd20Qvbln4CCuZdp/QBC2ii504MoF8RRFuNlSk
         EiBviQoPztxWzJv61KCyLzzfc4p8T90tO2KrEH2SwGGRHEqYa0Xy/eni3S4Ws0iHma2l
         rc/GcWczotn67BAKVaRQqQEuf2y9AHohSGeBSFH+FAVkqluAa892PY6JPpzglo7LfriJ
         rYoBKrGKG7TEPnyVZfIRvFZFuHGzpp4TExjqdZXdzRH9l/nijCymeMfvxB2ZJd1jGHQA
         h325YoGcaSJtJJ9KstYePCVmdcM4smARWac4ATCjp7VkeSZi+JCEHWKyM2hBndQxtvj2
         DcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BSsqJ0kxeXVyaSY8tHglmDjr3z3NbMGRZtPxcQPIlCQ=;
        b=gxGHL01qtZGlBa9wvyG+qmmA9gG6Pa1enVAl9IcnBe50J5gI5VWQzgoGyC8N+wGfXb
         TeSD2G/BO8zpvg4uOA1SiEayHSadNr7yUBIVWE9ZFFnafflGCbkLhd/bhPTIv4wawLZH
         K+YLzBU1KrUFeaGQbDMFCETJfUdfUcCgnzDZJLx0ytHbcUVuEG3vUY3faf2QTkFWS6Lu
         GnSfck/VdJ9s/acMpn7ouHmgcDE+4zVaNx7+ywahtE2VPE/D5aOCHM0DRP+H1wJa9+kx
         75iVhwiXuNJ/oHvkcLw9E7MGXkYp06+rjvjHVXcKYKt2DJ5yyH7YMuYE8zgIIzQwo+9L
         klZQ==
X-Gm-Message-State: AOUpUlEor0GWzHoSYhcpjsXmjPrBv8lDI907MXnDun+VDb8WqgOq8z6H
        iO1sZMzg/KNfGTK59qpmPrDN0YPO
X-Google-Smtp-Source: AA+uWPwzkf36ujjDupJqMdBBZKFQvzNNsoIEX1oh644b4MYGkZOuPF9aME+lS04wr5I2kO9G7tKMVg==
X-Received: by 2002:a1c:838a:: with SMTP id f132-v6mr16694119wmd.127.1534431482126;
        Thu, 16 Aug 2018 07:58:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p12-v6sm19352363wrw.3.2018.08.16.07.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 07:58:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2018, #03; Wed, 15)
References: <xmqqpnyjgroj.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kar1UwZEX9d=+e57ZJCy7YaqKSPExOexp8_t=G1VjwY2g@mail.gmail.com>
Date:   Thu, 16 Aug 2018 07:58:01 -0700
In-Reply-To: <CAGZ79kar1UwZEX9d=+e57ZJCy7YaqKSPExOexp8_t=G1VjwY2g@mail.gmail.com>
        (Stefan Beller's message of "Wed, 15 Aug 2018 19:35:23 -0700")
Message-ID: <xmqqlg96gxza.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>
>> * sb/config-write-fix (2018-08-08) 3 commits
>>  - git-config: document accidental multi-line setting in deprecated syntax
>>  - config: fix case sensitive subsection names on writing
>>  - t1300: document current behavior of setting options
>>
>>  Recent update to "git config" broke updating variable in a
>>  subsection, which has been corrected.
>>
>>  Expecting a reroll.
>>  cf. <CAGZ79kZ1R8sxmtfgPOQcpoWM7GWV1qiRaqMq_zhGyKBB3ARLjg@mail.gmail.com>
>
> That reroll happened and you picked it up,
> cf. https://public-inbox.org/git/20180808195020.37374-1-sbeller@google.com/

Thanks for a quick update.  I do not think I saw any other issues
raised and a quick rescan of the patches does not raise any flags,
so perhaps we should mark it to be merged to 'next' soonish.

