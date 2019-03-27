Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB3D20248
	for <e@80x24.org>; Wed, 27 Mar 2019 08:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfC0I0N (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 04:26:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39794 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfC0I0M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 04:26:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id t28so17817517qte.6
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 01:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=99wOYG05UX+3cIqZUsrV/nGlB5WGXeI11gwTN09d9wQ=;
        b=uo47xwefTTCzK1GX83XRWv6fuwsJ8x0Y2rXorXqTfquaoVFqTUHSffZbZtDbSYB0oz
         aI7IYMCEJi8it95oy7+qfCq+f6TjPcr3N/A0TNFmu9mwis9VE8FzYYAEWxirBTKaIcyF
         5tMHs6VASA1AYizChOc5d6t7kypVg6xeRpKEHnh4FcapZC6dDNAGlIm9sVzenhcF9e1U
         zQXSk+eSG3xcwC4kzWZjG0zcw632m8LFNTRzqb9PXj0ySwrlQLNFK1vWjaq/3n75eBw3
         I8sZsjnttKs4wV1VxQH6Tzw+xTLvVFShWD8l7d5T+sa69F3xTa2aCrz/yzGFpSUMcRJW
         MG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99wOYG05UX+3cIqZUsrV/nGlB5WGXeI11gwTN09d9wQ=;
        b=M87ZHJRjZht8n/CR3kx74A0OZbJjgYj8mjQJLDOmx2orv34dvFC0vUastHR+bLVPXB
         2mrOlOuBoLvLyhgXJeWpltlXDb/cnkLWwS774p8ZDbykB0c5A82RwoiPEuhuvEbqGtHv
         objohIcQaJrdoY52gq1rulOR1TXkuc2kxSBCnRG6VxtgMZcOVp8Y+wSjmd4gdSVPtc0z
         tN+zz/wqGuYecJbLNMqM3n4nmcVTC7NnoX4Lg9rMRV2nV6CQQXxAqlR8X9Hr08GQA3Uv
         iKRrXQzKayhZJ7hNBIDOyh5GAP6L/A82HUpDCCjxj2bG0/YLaJlpZ+9MmG+sfqSfvVV6
         YOAg==
X-Gm-Message-State: APjAAAVeK9tgbTDnyl7WcT8wUZ57az/GoEQqF96G7oFOb8O6KrQc1zzy
        FFvFryA0zRk45eJhPNYrpeQwnABr5Opqwr+g6Xcqn268juM=
X-Google-Smtp-Source: APXvYqxNIU8XDDlxjVuSvTIBSkhom+O30ztu+CqwLZXkEvNDi2KlMnXtJwi5v5YSuBIScYDEUvaWJeYBLnLN/rQh/b8=
X-Received: by 2002:ac8:74d9:: with SMTP id j25mr26710187qtr.98.1553675171795;
 Wed, 27 Mar 2019 01:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190324235020.49706-1-michael@platin.gs> <xmqq5zs7oexn.fsf@gitster-ct.c.googlers.com>
 <CAJDYR9RWUmXzh9Pn3qGBXAxNf70-SMKUCB3wwXVYKRTKOy8F_g@mail.gmail.com>
 <b077afed-d143-506e-977e-6edf2492f75f@google.com> <CAJDYR9R77_+gfOgLXX_Az8iODNRyDTHAT8BAubZeptEWJViYqA@mail.gmail.com>
 <20190325233516.GB23728@sigill.intra.peff.net> <CA+P7+xo-AHmB+Wv0Z+dpgshhmqSLEb41T-JP+NKJD8DAFARA5w@mail.gmail.com>
 <CAJDYR9RVz6ZKQ-vdC8O3LYZnGeBcGHCRtL0m6UoRrKDBsUoFOw@mail.gmail.com> <CACsJy8D8yBK9p9Rgy+wk8cMfPLG7qanvGA-LcmmHmjbaMnvBLQ@mail.gmail.com>
In-Reply-To: <CACsJy8D8yBK9p9Rgy+wk8cMfPLG7qanvGA-LcmmHmjbaMnvBLQ@mail.gmail.com>
From:   Michael Platings <michael@platin.gs>
Date:   Wed, 27 Mar 2019 08:26:00 +0000
Message-ID: <CAJDYR9T40xaSpmL_e00WWXzxEm_j0pcTqBhvr=5mu-fTpKodmQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Fuzzy blame
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>,
        Barret Rhoden <brho@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Another good place to keep these revs is git-notes,
> which probably could result in faster lookups too and can be made
> visible in git-log.

Oh wow, I really like this. A major concern I had about the revisions
file was that you don't know what a revision ID will be until it's
upstream. If you can specify *in the commit message itself* what
options should apply to git blame for that revision then that problem
is solved. And if you change your mind later, or want to ignore a
pre-existing revision then git-notes solves that problem.

So I'm thinking you just have a commit message like this:
"
Make all function names snake_case
git-blame-ignore: fuzzy
"
And users who have blame.ignoreRevs set will have the -F/--fuzzy
option applied to that commit.

> But that's in addition to --ignoreRevsFile, not replacing it.

I disagree. ignoreRevsFile has the major problem that the file will
need updating every time you rebase a commit to be ignored, and you'll
need to remember to edit it for cherry picks. Let's not have that
option as I think it will add unhelpful complexity.

-Michael
