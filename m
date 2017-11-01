Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26400202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 22:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933541AbdKAWqz (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:46:55 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:46044 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933510AbdKAWqy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:46:54 -0400
Received: by mail-qt0-f170.google.com with SMTP id p1so4648698qtg.2
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 15:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yi5ENeie32upzxwSQ81UAnZbSHp3ArBdOobZ2/MkwW0=;
        b=KTCBahZiT8W6aRtR9lJ5CTsp/DkTtKP/XmpflTV3AoCT8TjuKhZ0kq3kQHMsLvT+5w
         fZKxOBlhfwW9XZ7qyUlAvpW8JlZibsRabXY/RVxQ5miN0u1tNc/DGYtYscrNncRjTClq
         FEPa2UF9lEhXUd6T7iDzp4Q1sR3q3g+UTTLdtadWVFBbiI3CzhzDE47Ck5uiHDmq8Kyy
         zenrmh4QLPWR5bRmWQMD4dx+lKMavZEs5SH3t28vyf/ivysoaXRd5rTlcwmZrd1yYCpB
         8GDSiWFaOgZedX0fGMJ1J8DDfocf2V5wdgp8afpJ/CK+G1HWyBU8ylKGARBiJKJ7O8nj
         eTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yi5ENeie32upzxwSQ81UAnZbSHp3ArBdOobZ2/MkwW0=;
        b=R2eIg5sylTd2dUiBGiv1WMJmeNgHv3hDRSXgrph3VLSabIgtc73CaZ5rrZgybzSF24
         lWptB46fuTk0q9yv4EnyEURqM3VAMh2aYvDoAENbpGJhitKYAvYRQOHSF0yYMJvM1IPG
         yQ5wyND5RO7qPloDvk36S+O/Gb+sCWx19F/SbRapsFzQzObt6cueR4Q02+x6p9vl9040
         +t6JaqoR/6sIRD8w85BGwwtyXu6uqQpSCzbFZdkidMpAiSMjuElDqH1Y9oNd1uFvvtj6
         JgAUDky999rvYCIUoCNyftURXGVeBAzi1Dcrmc125re0CXiT5Mwsp9u7+T3yNy6/v4NY
         Wp4A==
X-Gm-Message-State: AMCzsaVHKCW4AsBo2Ak6a5uF0dmyuxMc/Bou6V4LVaRVO5wh37X1pWuR
        BhTk9TspzoJN5MLgkGfQPEN5PZntnkpYbWnyekZ8+kfz
X-Google-Smtp-Source: ABhQp+QOp+GATel9nl1KVbbh9aFyLRqyhpsqZYXei1Jzd6m/hqb/RVB/MX2fA/6SHVnWvSGqA/s2c5munYZRdi5JWYI=
X-Received: by 10.200.40.146 with SMTP id i18mr2330454qti.79.1509576413282;
 Wed, 01 Nov 2017 15:46:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 15:46:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1711012337270.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-3-sbeller@google.com> <xmqqr2tiveqp.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711011316590.6482@virtualbox> <CAPc5daWpUMOCYyK=S8JiAV5DHF6BYDff8wH0N6QDeR=nvOXnLA@mail.gmail.com>
 <CAGZ79kY-yooE4cZK0Sxh3AL32wi66PRh1LzB8e3djq=bnLDHFg@mail.gmail.com>
 <alpine.DEB.2.21.1.1711012307060.6482@virtualbox> <CAGZ79kbYshVjUh2XhbLHtYmnRuFaCmuWZJZd7HifKAqJbNBPfw@mail.gmail.com>
 <alpine.DEB.2.21.1.1711012337270.6482@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 15:46:52 -0700
Message-ID: <CAGZ79ka+EO8U2dDxquH0ypBvOQHy-nDy0Fcdw6j_iTGNWDmsJQ@mail.gmail.com>
Subject: Re: [PATCHv2 2/7] revision.h: introduce blob/tree walking in order of
 the commits
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>, Kevin D <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 1, 2017 at 3:39 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> not ok 1 - witty title
>>
>> That is all we want to care about here?
>
> We care about the loop body being executed successfully *each time*. A
> better counter example:

Good point. I'll use return in that case. Thanks!

Stefan
