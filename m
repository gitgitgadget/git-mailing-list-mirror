Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E1F20373
	for <e@80x24.org>; Mon, 13 Mar 2017 19:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbdCMTYd (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:24:33 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:32949 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753833AbdCMTYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:24:16 -0400
Received: by mail-qt0-f195.google.com with SMTP id r45so7464691qte.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+ockHom/Hu4uC2aJz06DUkG2m+OVHtl7Qz7qe1BoGHU=;
        b=E+QHJu4+bswO8VnCo6SefTmIrw5/PjXiSt1AZwwCd2u4btgeIkxarM7FH9J1tBrh7z
         AzRjdCaIrm7wKtW61Ixs02RVFIwD06t4FO1ouRHr8gqQNfZ9FmVnoQtpclYf2sNUiFbI
         rT5xHfG502Fskr81UCG0UB2KZ4bt3F855T/VE0VA2/KmloIihzlcBa/O+HEQsKJaEoag
         b4eAOL8TK/2pnVwhvyGEJgBq7sZ3T9ydyP/NVH6ZvygoPq3UDwGt1sYKi6qXPR91uamM
         yTJuKWjWyVaXjBdhTV4y65pvMcm4K9sZUtLTF0YwMVw2ucA9PZ0Y5veO6b6/ozn1KiZ5
         di6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+ockHom/Hu4uC2aJz06DUkG2m+OVHtl7Qz7qe1BoGHU=;
        b=c8zxZ5gtKF88OgTIiD5p3zTEDffzaX6sofflQQqR2vzuMQTOKTEeRGGwebRYJO8SK8
         I50A0Ks2msXOGhIy1QubFE3e4qQWp9kEJ3HGaF8CF7fPritq3ctxUKUlsyyBRbah4iQr
         RY04UVBi8Yju+45z+rUBAvG3giMxUBsFKMa2PEQUSVOgc3bOsJEx4VBPzCziz37qo2tr
         e9GKJ3A0++gRvrvU7DC7dPle8TDYdAzWFZ6CUli2ksGsRt7bLqZ0Fcd3J9ItUsRf25tz
         9L7OLIvQIvQPqdcNuWXXQBYUFR8DMraRinWquwaYaBOFbiqLjwPTXsQ5fOu/DPlUzj5C
         lZ9Q==
X-Gm-Message-State: AMke39nQL/S0jC31+3uWaCsTn0ugwnJNhpgxycyyPbJV8F5c3gj9dOJGGEi6yNjvP5BdDA==
X-Received: by 10.200.41.75 with SMTP id z11mr33705710qtz.183.1489433050005;
        Mon, 13 Mar 2017 12:24:10 -0700 (PDT)
Received: from dhcp-ccc-4425.eduroam.cornell.edu (nat-128-84-124-0-329.cit.cornell.edu. [128.84.125.73])
        by smtp.gmail.com with ESMTPSA id g15sm12791689qte.58.2017.03.13.12.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 12:24:09 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [GSoC][PATCH 2/3] credential-cache.c: Make git use XDG_CACHE_HOME
 for credentials
From:   Devin Lehmacher <lehmacdj@gmail.com>
In-Reply-To: <xmqqd1dlro8p.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 13 Mar 2017 15:24:08 -0400
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E6DDA0B8-D062-45E7-97E1-D233A9BE1865@gmail.com>
References: <20170313172232.96678-1-lehmacdj@gmail.com>
 <20170313172232.96678-3-lehmacdj@gmail.com>
 <xmqqtw6xrquw.fsf@gitster.mtv.corp.google.com>
 <20170313190349.wbg7nfmrxvvzc5zv@sigill.intra.peff.net>
 <xmqqd1dlro8p.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3259)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> They wouldn't.  It was my oblique way to say "it is unclear from the
> patch description and the code why this is a good idea---it needs to
> be explained better" ;-).

Ok, I will submit a new patch with a better explanation.

Devin

