Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406711FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdJ0Pci (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:32:38 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:55195 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdJ0Pci (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 11:32:38 -0400
Received: by mail-qk0-f173.google.com with SMTP id n5so8782590qke.11
        for <git@vger.kernel.org>; Fri, 27 Oct 2017 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=IV7tG6UNRkfId+ZlPpvDbaLAAhZT1CUe/c6l6rSpqyI=;
        b=mACS6cNQpjY5Igsug5GGa/yzQnf0PyhODejjkBZqk0xz6IyUCyWWtfulgrk/qFssoA
         OlB9XCOVoK8E+HjruLgMkjpDP5GEJafBwo6wi4BI3Y4XtHdRwPAyQBo6pWqEojJOXCTO
         LMCDPjr4m7DgkMYlgEUzjKjWH37Wc0Mg3gmMfoZ8NW18JfuXkaCaocnMJ02XfpTxelIH
         37JQ3dvdJ4/HzFQJlRRl2/ZCJf8XSvuo7OOxMPXgTo8AwX6kuX3IVGoNWWlS4XdY8xyX
         f1IHXW6ibKWMGP0f6YOjmwRCIW9wlbeLdAJjOpKy4T1mz8LGe3HyruQjCgcZI61FPSGa
         tqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=IV7tG6UNRkfId+ZlPpvDbaLAAhZT1CUe/c6l6rSpqyI=;
        b=OoSIbUNvvRJOK6Z527/SN2K/fEUx9mSinemzi5V6T3CxsFFkmGSgFDnyPfIBdHyAnG
         d+wthemJJSpJ/6j3DpGqG+kJNgsXg6O6qlU2uhO5ahmbHmNmb3eHV0YIr+618/XwNzvX
         OlKJG+PvC/7Tcpi2Z6RPR1JFzQD/cdbSpRW4c8qIlxNXTyWQvlOVOwd+m8429TD5R+2t
         R9Tdosa5R799CUofEXhYn/6ttet66nyF9jssbNRttHdpGz387A1ouJBnuQxDD6P57TzX
         /0QfmE6JBIJpxdmV+VzuCFJWMCxRgkmXxD/sbeYFkw/15aTxEGRdEv49CTc/6Pe15biC
         LFEA==
X-Gm-Message-State: AMCzsaX7KNO6nK8rvCCsmPCD8iQqv3yrxvWRU9tHRsws9tWW49qwMdxT
        WYMONG6JpaECpQDRqn4eRofbI03I8qqKZTRxP/z15g==
X-Google-Smtp-Source: ABhQp+T6Y+qmNURo25R0PcjBPdp75bPoW2tD/5Ec3fCsU2MgF7lgozTrBKXdavjZOyNw1lAchMKp5ycHG1YdvH4J6FY=
X-Received: by 10.55.136.67 with SMTP id k64mr1404152qkd.26.1509118357288;
 Fri, 27 Oct 2017 08:32:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.28.246 with HTTP; Fri, 27 Oct 2017 08:32:36 -0700 (PDT)
In-Reply-To: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
References: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Fri, 27 Oct 2017 21:02:36 +0530
Message-ID: <CAFZEwPPxuno5ey9qWVVE9=CU5f-BmBZjhQMrHOXS1tFG6r4LkQ@mail.gmail.com>
Subject: Re: [PATCH v16 Part II 1/8] bisect--helper: `bisect_reset` shell
 function in C
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

I forgot to mention. One can find the travis build here[1] which is passing.

[1]: https://travis-ci.org/git/git/builds/293725346

Regards,
Pranit Bauva
