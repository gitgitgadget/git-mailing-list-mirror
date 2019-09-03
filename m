Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67CB21F461
	for <e@80x24.org>; Tue,  3 Sep 2019 12:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfICM53 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 08:57:29 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:50193 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICM53 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 08:57:29 -0400
Received: by mail-wm1-f45.google.com with SMTP id c10so6144339wmc.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 05:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=continuousdelta.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vqRrMIYH1j1q//a+EARdD/BZ3jE+jL2MEKmpk35nwkc=;
        b=YRvh0aVdk+6Km1QEopRTH8tGvezZy+m20Cag2ambj2PqZPz7vUnMnxpUUHEZ8XiWfn
         hUs+EVhAuiCtUeCYOhwf2yZazymHDLxEu9KkqkwYYVlME7wXJqQxxAgzfbVgXaJlnNB5
         DgQk9iBF1BVNnDpHDIE/lFs5/g/utSr7O8BYm2N/CLCD3ZA3yEZ3Qbewo1fkfT581Qcs
         ikeXdFt1gJL7N5E+DDJI4vZvf8/ZPEaTVPvCuo2uZbhqT7c+aQ0UxIYinl1MXk4E5zMd
         PD8PXnXRKCpRKyeOfEXLgayIOhqTQ5Al6bFCD6S4+kbZy8uHnszPSJObMOHNbdUxOiiE
         7Y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vqRrMIYH1j1q//a+EARdD/BZ3jE+jL2MEKmpk35nwkc=;
        b=GEByk8IDkGtfpiX4ZNwBHSqZKiYA55wmXNRYQOONksrGaU+bqwFhs+YTA+cbd/riDU
         WXXQ3hHdaDxMjA/h2PKKeECc8c+YN3oCuuPjWUEaZAIHHBy94kagMPRaoAtBXLVuOL+m
         M9V4iicIyKc42bykXvcWs65qiwDC5si98ab8x7WFmkEHOb9O4ePAb5cPFgucsiHB2D1y
         PJ6j5trEeTH1v3IgIQl4bp/fnwDe+CHjEYAiqQe+zVyHW2cYcBQjsJr9CC/sTAbesBSr
         rrcIdR46pKnysapRwk1Sdub5Ff1AZVHJaZUb7xo8DYJsTnDOwclmCUhmw1ep6GIJUW5e
         0NMQ==
X-Gm-Message-State: APjAAAXReNIUAYIKFChpR673YQAH0C/J7NY4M6jyMpotH/1CqdXUpPo2
        mOOoXx3r7V+SjjNddQHKqBA3jfYfJ5lK9XxrfYqL9gbsWDU=
X-Google-Smtp-Source: APXvYqzeo0EQETQtJ6doabhMBcgw2jKQ/SUrNf5K3KYTqkX1p1V1ujex7zFcMhVulgl0cr4fjyolCx5ZcMfTh3faD8s=
X-Received: by 2002:a1c:a697:: with SMTP id p145mr21841097wme.24.1567515446897;
 Tue, 03 Sep 2019 05:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAEV-cEryZZarfz5SQsRphBXeYMPJW7tdSfY8NYnzb_-ra-pGHw@mail.gmail.com>
 <CABPp-BE0ij8zF22xbvjbcq3vG-VwWjUmjNo45Lsm0BEnH=iZ-A@mail.gmail.com>
 <CAEV-cEp19ehfBwHxh7OGsvTxTchNJLSRZGZXqAsDjyQg-W3rFA@mail.gmail.com>
 <CABPp-BEWn1wHdxWM8cVqmvzYo8HDdUzuh4G-XTN51o8JdvkrCw@mail.gmail.com> <2737a9f3-769d-5dc7-ca4e-ef4dbdde70f6@iee.email>
In-Reply-To: <2737a9f3-769d-5dc7-ca4e-ef4dbdde70f6@iee.email>
From:   Matthew McClure <matt@continuousdelta.com>
Date:   Tue, 3 Sep 2019 08:57:15 -0400
Message-ID: <CAEV-cEr1tHc4zY7hYSUVUFcqO60y1ssXHC1jO20606HzB4QxnA@mail.gmail.com>
Subject: Re: How to track history of personal changes in a repository?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 31, 2019 at 09:32 Philip Oakley <philipoakley@iee.email> wrote:
>
>
> The `assume-unchanged bit` is commonly miss-construed as a promise by
> Git that it will ignore changes to the file.

Maybe `--skip-worktree` would be more appropriate.
