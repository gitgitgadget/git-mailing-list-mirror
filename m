Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57BD1F461
	for <e@80x24.org>; Sun, 19 May 2019 23:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfESX2v (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 19:28:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47035 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfESX2u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 19:28:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so12473019wrr.13
        for <git@vger.kernel.org>; Sun, 19 May 2019 16:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CM97SpuY4AwhHwb07cUaf9UG5ZxhnRHZQk9B8BJD/lk=;
        b=Ubc6jjWjYCjru7d0T/zh7AmYVQ9y1rLqDk84ioo2PcZheuVFxku4cqZZyehYpcCsvj
         yIOD3A/jRv1hoJHQIBQW0995siiCaCYfMfIYM2D7uYgdpznO1v/+hL9cSAw6w5wPbY4Q
         ABxdWbx5Qkk8dpNwWQzEo39D8RisBqV8cEAi0QUCGnjiaU1UuCEobL/6G4qxRqgPnFdb
         ojCmUfKvsONHJg0Abeq98USd1nVCBiqb5AjSXcMKO4o5BChHBOD9hEh3+v8eKuWq9MRw
         sptZLziQ4wQ3PuLI5JIGfzup7rdMgFuJXKzV0sh7DLs2BZDZ8VajexWEAFJpKucjWDAA
         Fkrg==
X-Gm-Message-State: APjAAAU5V+qN1HpwpLwlKrWyHpg83+Kb9GKVOBtgKwPIgxrETfUTPFsf
        l2oKaLwH5q/iNhQROVnfQEwkjCspz1yv2w6ODYg=
X-Google-Smtp-Source: APXvYqyFRvEXcuNFYTGOQMK1xtZXDnCcTKJ8G3yQsxoYtVCXbnyPj9yb8tLyrWlxsq7QqS0I+SWgJs4J2pIKrGdt36E=
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr26853112wre.9.1558308529007;
 Sun, 19 May 2019 16:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190519050724.GA26179@sigill.intra.peff.net> <20190519051031.GA19434@sigill.intra.peff.net>
In-Reply-To: <20190519051031.GA19434@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 May 2019 19:28:37 -0400
Message-ID: <CAPig+cTDzhaRD8MMqFp2EwGmhsR3u=t9en4+JkU2Vkz-S4Bu5A@mail.gmail.com>
Subject: Re: [PATCH 1/3] transport_anonymize_url(): support retaining username
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 19, 2019 at 2:37 PM Jeff King <peff@peff.net> wrote:
> [...]
>   - credential_form_url() parses a URL and decodes the specific

s/form/from/

>     elements, but it's hard to convert it back into a regular URL. It
>     treats "host:port" as a single unit, meaning it needs to be
>     re-encoded specially (since a colon would otherwise end
>     percent-encoded).
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
