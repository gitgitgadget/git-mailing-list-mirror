Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26361F453
	for <e@80x24.org>; Fri,  9 Nov 2018 19:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbeKJEqB convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 9 Nov 2018 23:46:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37976 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbeKJEqA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 23:46:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id d19so3454107qkg.5
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 11:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MmwP4IXiwmPqVCDoTRdMyj2vLxaa40YlI97QOKhW8Rk=;
        b=H7uSX5CIjzOJciTLr9HT8dZG1Nr4xOzYIWxXMnPvuvBJN9Bon9qpseXw+uKj7oRfwN
         FhYBp/Mig/X6cB1X3q6y0FrBkWtRT4Z+pHC29KFcFia/4O/RpQYm5clYtZhv+XbrCib2
         1duNL2Lzsd1BqvzHEzruuE1oZkBPOLQ1Fv/XQ66S4AWDj39CssdL6zp5Qhmo5Ylec6zA
         qjyOOkDywrjf3xqeZ9LeMYmb16MRPcoETDh6r9ZBKrol6ceBdEP2Ja1NR/dXVWpJaf8r
         AxynicverWKTau6wpagidUpoXdO6v0e9gikSEg1jAEljyqS7kHlB6cGbsh7qDxaIkWu7
         fXTA==
X-Gm-Message-State: AGRZ1gI7Q1EIFwn9KwFqw47kJGJI+NKd2Guoot5bWgIGXz6XeyzJQWf8
        yycGHFQ5A2e9tUlFsPkPkYa/2tWG0TPA9LR9tSb1dA==
X-Google-Smtp-Source: AJdET5fRqY3kcFgdbom8C44JhSDz9viv9fJOC0k+N9SSVH/0YBgbCY87MT1wbxaIZBhXWmLmc/Y52yl6jEb5VJvFqKQ=
X-Received: by 2002:ac8:36ba:: with SMTP id a55mr9676399qtc.236.1541790246982;
 Fri, 09 Nov 2018 11:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20181031105947.27562-1-tboegi@web.de> <20181109144638.5330-1-tboegi@web.de>
In-Reply-To: <20181109144638.5330-1-tboegi@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 9 Nov 2018 14:03:54 -0500
Message-ID: <CAPig+cQE_2JTctQzCKmhMAqaFKf_MMBdEUS6kU41ZbyvUft0JQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Upcast size_t variables to uintmax_t when printing
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 9, 2018 at 9:46 AM <tboegi@web.de> wrote:
> When printing variables which contains a size, today "unsigned long"
> is used at many places.
> In order to be able to change the type from "unsigned long" into size_t
> some day the future, we need to have a way to print 64 bit variables

s/day/& in/

> on a system that has "unsigned long" defined to be 32 bit, link Win64.

s/link/like/

> Upcast all those variables into uintmax_t before they are printed.
> This is to prepare for a bigger change, when "unsligned long"

s/unsligned/unsigned/

> will be converted into size_t for variables which may be > 4Gib.
>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
