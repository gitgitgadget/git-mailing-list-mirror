Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D56A1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 20:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfIDUq1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 16:46:27 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45968 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIDUq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 16:46:27 -0400
Received: by mail-ua1-f65.google.com with SMTP id j6so7167134uae.12
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=67pp53TK1xR4n95YAe+KmwzwcolJpW3vWG143e0SF70=;
        b=UqAE6h1vTU5IGJhE1GKP3t7YzdHRu7jVzFw9xXaGyDvrCo2Xg4Q5ieZPy4kBMypS2M
         hLE5i26hPOU0rDr/aVfTsEKdA8q4WF3FwOrFGGguF4l96FgArmyP6VX+YQNYHYs8TUaB
         nCdBcDIIwczxokDew1ywBov+vuF0AzD41kBpjVIRx5Nbui3+YHPut/ECN2CjyKb5BI10
         Nk03tvsibbJ4S68j5G2nz4ac4nsMqXgWFMSe5UZQ4T+oPIwSqBy77elTE5hH7wfLXjYW
         +kkiPkd+u0ygDjpiksqkc40307WoTcY2Lzdf7pXDOPODfSNb0S0qlslhsLpxyU6vCOIf
         iSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=67pp53TK1xR4n95YAe+KmwzwcolJpW3vWG143e0SF70=;
        b=JX6jodT2uIv9lnA7YO+3kupEO30oCgqGqmEr0uacPZneHQiMQg24WYupCUVnQdXUhg
         jTlDIzOwUj493CMbtVlMfzf/t5pH3WEraZJTZ6dqzvR2ySt2cSZZRNqYcJlNsKwWOwbp
         zAtcnE6iSxfPYKsgoHjBudCJn7Zk+b9zglsj9j3DDNbjyC7E1a53etbEZERsJd+qdZaz
         OQ2N/LjpJfEXAMB5OslO7o6tPRAX6UayWEKTBDIoyCRCWygag2k6bB66cARA7aWDdVuj
         gJQftaN3szsBOnwdxiQ+6mx0ECBdFs6HsKk85av3rZ6qn5niilc2yyy7PDsB6bfMOzJq
         DD5w==
X-Gm-Message-State: APjAAAUNA0NYEg/fkyR2KYHa16E2zOkcllFr/yD4AbSpIjhLo35YI5Fu
        SuJRxkAExp0AfPXShiv6sRVbv8j5o1ZRLZqIGn0=
X-Google-Smtp-Source: APXvYqyoqS1Lu65/vBr5olPgPoLkMOF+OPJN6yZimbLH9hNy1ewZVQU45C43TYYQ9jFlX2uXy+VhGLD6XzPLZ1LrgME=
X-Received: by 2002:ab0:758a:: with SMTP id q10mr3679359uap.76.1567629985963;
 Wed, 04 Sep 2019 13:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <62ef03a2938ac0d2158b1c3201c7f10e52e30ecb.1567627609.git.bert.wesarg@googlemail.com>
 <CAPig+cTZiOBwaM-BE-19CzJuZ4NwCZTaDc22WuY+bv8BLP=rrQ@mail.gmail.com>
In-Reply-To: <CAPig+cTZiOBwaM-BE-19CzJuZ4NwCZTaDc22WuY+bv8BLP=rrQ@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 4 Sep 2019 22:46:14 +0200
Message-ID: <CAKPyHN0B++3w7GgTPCE6P=rWBivknfqA0YZnJdz3htbOCa0g+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-gui: add horizontal scrollbar to commit buffer
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 4, 2019 at 10:31 PM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> On Wed, Sep 4, 2019 at 4:10 PM Bert Wesarg <bert.wesarg@googlemail.com> w=
rote:
> > While the commit message widget has a configurable fixed width, it
> > nevertheless allows to write commit messages which exceed this limit.
> > Though it does not show this content because there is not scrollbar for
> > this widget. No it is.
>
> "No it is" what?

=E2=80=A6there is no scrollbar for this widget. Now there is.

fixed

>
> > Suggested-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> > Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
