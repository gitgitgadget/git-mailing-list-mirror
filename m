Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 684AE20248
	for <e@80x24.org>; Thu, 11 Apr 2019 17:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfDKRoT (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 13:44:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43168 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKRoT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 13:44:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so3802776wrx.10
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 10:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOmtKRvShOj1mjFBB6xhBL6FXl3GgG3VynEvx1ggrDg=;
        b=RTZGHHj5qhZqrn23kv9W4L+vYlUoPrUAY8+Hhpib14Zc6kMbVwgLJLqn284Fbylycx
         xIEcnN/nfoEyZubJOIczsT6DTHKJIXqE2Cm9WfOO59s9A66sDfYm7tCi0lKCKXihwDY0
         ggsasc2de0C1M7jpvgLYGtLeZ3Cz1i47JuHeRfr88/y5I4GS6CsgPGGnxcgwjkeEYrQE
         Piu/ChLriu3/viOsOX5cTll0yj+y1ZTZql16ZHGliK4fc+kdI3Vbjq5sQtHdKofRDfek
         Q++o3G+Pm7ich2qZCx2d7yBrfObrC5yyoBlQlTX9GPYlvGbQZp35FFGNWzAhRyTFFy0d
         zZLQ==
X-Gm-Message-State: APjAAAX9fbu/h2a4EdfmnhQG1ZJmDSu75JdlyhUusFKlON5FXZ1q4Dtg
        Wy17IaTHjM3qVexEtC1NGfIaQXj2fhmtQ9fbCXATYA==
X-Google-Smtp-Source: APXvYqybxOkh/FcRwERwYdJj31HlyW7df7/esz9NL7yP9Zd7GtJV0CYfnIVHb0zQHBvddxhzPGV/JFeXXE4W2fab4gQ=
X-Received: by 2002:adf:eaca:: with SMTP id o10mr33937632wrn.273.1555004657486;
 Thu, 11 Apr 2019 10:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190410233450.765424-1-sandals@crustytoothpaste.net>
In-Reply-To: <20190410233450.765424-1-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 11 Apr 2019 13:44:06 -0400
Message-ID: <CAPig+cT5-r=QqVDcD7viJj0-fPp+6OjnKq8aP4NLwKNdrAHFKw@mail.gmail.com>
Subject: Re: [PATCH] send-email: default to quoted-printable when CR is present
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 10, 2019 at 7:35 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> [...]
> Note that we are guaranteed to always correctly encode carriage returns
> when writing quoted-printable since we explicitly specify the line
> ending as "\n", forcing MIME::QuotedPrint to encode our carriage return
> as "=OD".

s/=OD/=0D/

(That is, replace capital "O" with zero "0".)
