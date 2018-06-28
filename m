Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9601F516
	for <e@80x24.org>; Thu, 28 Jun 2018 16:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965572AbeF1QSD (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 12:18:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55160 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934236AbeF1QSC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 12:18:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id i139-v6so10312744wmf.4
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EGx/q/JU6BwsjURzkZ175Y3tJffnKVocboVuxZ5Lq+I=;
        b=sDdqcR/vy/R4Cbul0mk+pqls3GKU+9XwONi1WJSE3T4+y99DOXz/7Lc9z9fueLIdtk
         tyJqCH4rXuDzCRvHrLjN8Zn2euz6GHh1R1PnHXNpmK/VJzIhSX6KEp1DF0OI4lQt7g7M
         RM7zVogkcil8cTP/f6WXuZgS0idgYP+IEdJe1dL2oq62ULzBvDo0sr6+tSrTZG4pP2Jt
         iR0l+w673DSJJ+y13kIXHl9H1lrIXNVFGs5frWHYk5CO6aXrKILSRPtPDwZziI9ZvYKN
         vraUHyjqjEO/bxaPaUN7KYLDiGRrzUipJAYT/BaMcY8gzUDl5ILKPdkZvzRFdFNzrfuJ
         b8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EGx/q/JU6BwsjURzkZ175Y3tJffnKVocboVuxZ5Lq+I=;
        b=L46I/y7YTR5A529LJRoEldIEzMmSr1IXQJK/+cLg3JTr5elbxqtRrAIQ57xtNYZO+1
         avBNhCiBbB4wGlBOdZdgfjqRMoDlI5ipdq8LRpv4PvpzFNPGDwWw4zMss24nJzk4qnDY
         ZCOAIO5B1hylj8q7W14LIumjh6Oa6pgwOHvr4f7uczainoV5GX6Pr424ZhzcmYBXc41x
         Ma2/ReA3Z268A3E+4MOLn7iOsYW1eJMPph5s93dD5kc5CdaYDPqvHRYLiqCg13bvkeUL
         pVXOqlXg2cEUDjlL1fV/bW6xJEYKjW9mGc4F3DIIbuyOwviGXodKZXY51Q6+YIzePwOg
         0OZg==
X-Gm-Message-State: APt69E1CBAmnqGURvCWfcek/2FZYOzVaE1Xii7sJZorgVUeLqY0pBpsi
        /gAmhSQPZHy8eBCWc7UsMbo=
X-Google-Smtp-Source: AAOMgpesmN1eLaR7PiUrF+270m02Umkk3XJKeNWPzjWUid4jeF5YqANn4XFkIIZQuRW3km1v5IVVDA==
X-Received: by 2002:a1c:574b:: with SMTP id l72-v6mr9017081wmb.56.1530202681407;
        Thu, 28 Jun 2018 09:18:01 -0700 (PDT)
Received: from [192.168.0.137] (5-13-221-130.residential.rdsnet.ro. [5.13.221.130])
        by smtp.gmail.com with ESMTPSA id 139-v6sm12039382wmu.47.2018.06.28.09.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 09:18:00 -0700 (PDT)
Subject: Re: [PATCH v6 3/4] stash: convert branch to builtin
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, joel@teichroeb.net
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
 <ac0a24da8a583a137176d1d215df65bb1a3ada0e.1529943789.git.ungureanupaulsebastian@gmail.com>
 <nycvar.QRO.7.76.6.1806270018580.21419@tvgsbejvaqbjf.bet>
 <xmqqfu18f4zz.fsf@gitster-ct.c.googlers.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <5677e7cd-a0f9-194c-a7bd-5eea48c56e3d@gmail.com>
Date:   Thu, 28 Jun 2018 19:17:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqfu18f4zz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 27.06.2018 21:39, Junio C Hamano wrote:
> This is primarily because cmd_$foo() is designed to be replacement
> of "main()" in usual programs---it is allowed to assume the global
> variables it uses have their initial values and nobody cares the
> state it leaves behind when it returns.  Argument parser may flip
> bits in file-scope static variables to record which options are
> seen, assuming that these variables are initialized to all-zero, and
> that assumption would not hold for the second call to cmd_$foo(),
> etc.  cmd_$foo() also is allowed to call die() when there is an
> unrecoverable error condition in the context of carrying out $foo; a
> scripted Porcelain that used $foo as a building block to implement a
> larger operation (e.g. "stash" that used "checkout" to switch to a
> different branch) may want to react to the failure and do something
> extra (i.e. "git checkout || do something more").
> 
> Using run_command() interface would not cause any of these problems;
> the subcommand will run in a clean environment, and the caller can
> react to its failure.
> 

Thank you a lot for this great explanation. When I will submit a new 
iteration, I will make sure to replace calls of `cmd_$foo()` with 
`run_command()` (or with API, if possible).

Best regards,
Paul Ungureanu
