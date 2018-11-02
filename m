Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334101F453
	for <e@80x24.org>; Fri,  2 Nov 2018 15:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeKCBCr (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 21:02:47 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:45678 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbeKCBCr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 21:02:47 -0400
Received: by mail-io1-f44.google.com with SMTP id p83-v6so1679061iod.12
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKbFLOgVvIb3vFtBAnQXjkR0qnR1Ka3BMT1zY6SaUUA=;
        b=AbWA6dcqJ367Ys3j+eexl7ZG/M4LHe4ZZwxerB79fYSIOEbXhGP1NAGVpWt/AfKhlj
         F8VLRseO9G1D7x5YNBtFRXdh4tiKRDiU+0CnFvcoamYnDiNO8QPx8ErSLayAAPv+hPVs
         1qOhi++K1dDR1F/1S9OsVC/95iyP5OxfTl6h7RJSg4+UXAKWdquQOQfv26L0R1bTEOMN
         vaHQ638iag589+KkZ4hQMoasIjZ8yXcB1b283yQ5LO5k+ywO0CXXEIClEzDY+PuxOVgy
         KSoV5dHL/upcA+EAKMAA3wOmJtVZpfW7qiD2cae/UHlZJfr09KlMqu85AS9E5sgsccyw
         5Ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKbFLOgVvIb3vFtBAnQXjkR0qnR1Ka3BMT1zY6SaUUA=;
        b=EbpkeX3MHjk5b5tOaLTtIMTKpmT2HUjBA4SPRMoP+6amA1pDQMouFCOd/YUKRv24/L
         NcByFUBBCjpfz4zXeOP4GsF0rDzvqJBDaugb9NGrW7X4ob4n434r2vnE/sxZX88gYzbv
         kHJ5+9gqL6LUlSOvoMDNfN2+6srkterPrZADLc8wbRbBB3ehcmv0NRLruo/s2J1Ie+kX
         aerGby5kCMPc/fUR1g6eyB9tpWoq9s/HobPJgoEOhSf83pfCUhJNPeH4sXve31sMG9Bk
         LNsZxpafEudGXmRjra66cGf0eaUDf4J+hj4NiqySEcKxhPj497/g432kB+oYJtFBrpYF
         vveA==
X-Gm-Message-State: AGRZ1gJ/tNaBwUKXrrKQEXF36oB/EGIk7RbWoh/KeXEC7sHGRhukm6TW
        aEcovJi/jjV/q60PofXDk0OFRM+OJ1jooXyusbW1ag==
X-Google-Smtp-Source: AJdET5dI38Su62961wceGD79NDSm6UpKl0o3shCQ+H/mZqmwl1PrQ7ITf2meGelpc9f8VgrmmW59+NbAsMDzI2lspyc=
X-Received: by 2002:a6b:6f06:: with SMTP id k6-v6mr7986635ioc.236.1541174113597;
 Fri, 02 Nov 2018 08:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAFd4kYBDWMvVgDmNTzwOK9Q7n_Fb0NrvNAFgHtKvkLkRFWqUKw@mail.gmail.com>
In-Reply-To: <CAFd4kYBDWMvVgDmNTzwOK9Q7n_Fb0NrvNAFgHtKvkLkRFWqUKw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Nov 2018 16:54:46 +0100
Message-ID: <CACsJy8CPUBEmgu+jZPadAwbs8GbjEOVPcuDeoQV7m8DE3iCk5A@mail.gmail.com>
Subject: Re: Understanding pack format
To:     khanzf@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 2, 2018 at 6:26 AM Farhan Khan <khanzf@gmail.com> wrote:
>
> Hi all,
>
> I am trying to understand the pack file format and have been reading
> the documentation, specifically https://git-scm.com/docs/pack-format
> (which is in git's own git repository as
> "Documentation/technical/pack-format.txt"). I see that the file starts
> with the "PACK" signature, followed by the 4 byte version and 4 byte
> number of objects. After this, the documentation speaks about
> Undeltified and Deltified representations. I understand conceptually
> what each is, but do not know specifically how git parses it out.

If by "it" you mean the deltified representations, I think it's
actually documented in pack-format.txt. If you prefer C over English,
look at patch-delta.c

-- 
Duy
