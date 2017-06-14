Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007FB1FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 04:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750735AbdFNEko (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 00:40:44 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34223 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbdFNEkn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 00:40:43 -0400
Received: by mail-lf0-f52.google.com with SMTP id v20so83780741lfa.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 21:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GFvVSih4p7SfDU4pSDWVMKZTKWzShiC2HEUsYImT7TY=;
        b=O3PpZ+QdiVmG2r3icu0J3VfFzubk6gwuAH6FDnvAVhFzZid1wP2ZeVrHQorx90HNdG
         2Z8OLx6fbNJ+VeKN31pvN7ppSm7YtITcsbas+Eg2vON+q62vKgjCNDCFD3UsA3+ukGIm
         c43Rvu4Nt/4k9AbRgMw3i2oWSlxa5utQlIgm0GbViRLONqS5+pUZA4IQttJ6qsigL0tC
         2KSWXBbkXaZ7tXqOEEGYDGP7tuRE7Q09le3iyfaAutBlwCd2HP4HCW8uFBtfzKmdSbiB
         /Y3l3ijOFMqjAl1H0XOZf2/r3u4ONgkOBgKUxoNVblPcXQbOpXmCdUNtZVccA19YKczt
         XtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GFvVSih4p7SfDU4pSDWVMKZTKWzShiC2HEUsYImT7TY=;
        b=df6htYswUhwMTpLCC7ypQYD70j4rJdhjGBzbEaCUmJKj2yHXkFmuXlzTh5knw0SnWZ
         5JCDeHZBDr18OKADDdH2aIaVYyk7+8uZ28EdXFOgctQKCMvF2rws47qUvNjIni9FPwl/
         LpiOuidTRgZuNtXWE7LwSMrPrD5+cJ6TfiilFL0Vm876ymUBAPmO5AKLdkqabDffRu8D
         kjsi7E3nHSTdkd+nk9R4sTVvgH/cO1Pnzro6ZQ63DQiiGaaxQgpQetq1oZkFZ90YrmFC
         2C7aaKihSk61j97nN43in4U1EulBmT4fVcKFDOWn7DnEdUYKbV64WDRDBloaa56YN8NO
         Tiag==
X-Gm-Message-State: AKS2vOxkFShjlV2uiXff0wcB1Q4qOx6pD/2p4vRcmtMl3H54+h3e6E8d
        uqI7ZbtbgF2jrgNkjoM3VdRctMpAtQ==
X-Received: by 10.46.9.4 with SMTP id 4mr956045ljj.23.1497415241692; Tue, 13
 Jun 2017 21:40:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.79.17 with HTTP; Tue, 13 Jun 2017 21:40:21 -0700 (PDT)
In-Reply-To: <20170613220532.GO133952@aiede.mtv.corp.google.com>
References: <20170612213406.83247-1-bmwill@google.com> <20170613210321.152978-1-bmwill@google.com>
 <20170613210321.152978-5-bmwill@google.com> <20170613210806.GJ133952@aiede.mtv.corp.google.com>
 <20170613213815.GP154599@google.com> <20170613215138.GM133952@aiede.mtv.corp.google.com>
 <CAPc5daWpXnkNyuGNtFi4YTyB+Np5Yw8yZCGwu5VNzv+WON1u2Q@mail.gmail.com> <20170613220532.GO133952@aiede.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 13 Jun 2017 21:40:21 -0700
Message-ID: <CA+P7+xrw_T7pqtKXcU_KZ+9NFV9rETdqFrKPK_nyXJg8Le_ZvA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] config: don't implicitly use gitdir
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 3:05 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Junio C Hamano wrote:
>> On Tue, Jun 13, 2017 at 2:51 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>> What is the next step, then?  You can find the notion ridiculous but
>>> it's how this project has worked in my experience (and how other
>>> projects with similar patch-based workflows work).
>>
>> Does "patch-based" have much to do with this? I agree that distributed
>> nature of the development would bring this issue, but I tend to think that
>> using merge/pull based workflow would not alleviate it--am I mistaken?
>
> Thanks, you're right.  Distributed is the relevant feature.
>
> The same issue can even come up when using a centralized version
> control system like Subversion or Perforce --- without attention to
> API compatibility, someone's change that was thoroughly reviewed and
> well tested locally in a developer's working directory can introduce
> subtle breakage once they run "svn commit", causing it to merge with
> the latest upstream changes.  The problem becomes more likely the more
> distributed a project is since each developer becomes less aware of
> the other changes that their modifications need to be compatible with.
>
> Jonathan

Which would be why early integration (pu) and a good test suite are
for. However, it's much easier to catch if you change the name when
the function no longer behaves the same. In this case I guess you
could argue that the part that changed wasn't part of the API...
However, I think I'd lean towards "we had code depending on it, so yes
it was".

It's ok to add new functionality only obtained by new flags or
similar,  but not ok to break potentially existing callers.

Thanks,
Jake
