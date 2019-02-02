Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C4D1F453
	for <e@80x24.org>; Sat,  2 Feb 2019 10:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfBBK53 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 05:57:29 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39562 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfBBK53 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 05:57:29 -0500
Received: by mail-io1-f67.google.com with SMTP id k7so7988336iob.6
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 02:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73MbtVvttERuD7AIsNhuLT/W3Mpg0IibdHh4i1sAALQ=;
        b=k2z/C9Q7kvHrjF4v70pNigz7LKUjNhZis7I7bo9Ax7Kl/s2am7UGTOqWvsG7fdRGUp
         ZMaJ7YGNgzFLhGbzCmd23ythYIFQHA+t45BZuzF/Tq8HMeR34ff5Ixq73423TGRbwFvP
         FypfhULRPIBz0VIBQyhceyOeulllGGEKtLt3yMfIuv/28oJ8Ch1LJMUZw8Cim4lZr7LO
         13F4CRb4ZBTXi79yzlS/TQr5z+xTwpLuT1zgpM3a/88mW/AWQUdkLXu6V29uLisXsYNP
         3q6rNzRueQFtlgq+f3L8mRZ+jHhuqayDL3gu6qXhegjs/GHWccXqFDBepjAgVuoB3icE
         rIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73MbtVvttERuD7AIsNhuLT/W3Mpg0IibdHh4i1sAALQ=;
        b=g87c9SPZ6Pm5rQ3cHlyJKtOlBUjphTDXI60VDFo+gO27lurapw6mwblYrEH1rqIYKY
         UXFPgK0xXf6HMd3NbjH1NnMxlI0LMEp1DbeyZOmRmPv3Lsdlqxl16aa94/1TUrp6L/GS
         v9D/BT7eArDhkwqVc5GHdiFUcr7k/aphUTYrXEcy7fGxgIVG/ABONF/ADUdJwT6l8ZHk
         6GY4LXjUy7hqpW1a3ZZN+IqeOnH5IKoXBA9EoD5f9tD+KDm680P/jVX+KvetcLsoueuh
         RC0YGRn0avc+B/YsVZ4OHlhr21WyKEgdmzvyz/SM2nhys5cftt4Jcrvalb0YaSectb+W
         dN/w==
X-Gm-Message-State: AHQUAubAVsUxe3LVMh2OWOQVoNskoRI9oI7snFGhB7DG4ZhPwSjrDiaC
        pfd8WDVUh9KQno2Ef34Iut5x759Q5BCwkZSyCas=
X-Google-Smtp-Source: AHgI3IbOSqaHjY0XfJyL2E+D1lPzfy68jkTSrLVTtykgvL03w4yRyZSYUAfyzsEDOIR+qfhFx3FcdvaKMaeYaTaZ21o=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr21520976ior.282.1549105048895;
 Sat, 02 Feb 2019 02:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-7-t.gummerer@gmail.com>
 <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
 <xmqqva40lps2.fsf@gitster-ct.c.googlers.com> <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
 <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
 <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
 <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com> <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
 <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 2 Feb 2019 17:57:01 +0700
Message-ID: <CACsJy8BsVWtn5MdWCDwDfGq5SHgzK7CDvhhscKi+EJ_5Q_D9jg@mail.gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 2, 2019 at 12:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > Of course we could just do --index and --worktree, each option
> > restores the respective part. Then it's combinable (and extensible in
> > the future). But then "git restore" means "git restore --index
> > --worktree" and typing "git restore --index" effectively removes the
> > default "--worktree", which seems a bit twisted.
>
> Or "git restore --no-worktree" (essentially, instead of saying
> "keep", say "no" to mean "negation").
>
> Incidentally, "git restore --no-index" does not have a counterpart
> in "git checkout", but I think it is probably a good thing to add;
> as it has to do far more than "git cat-file blob $tree:$path >$path"
> these days.

Oh yes, I occasionally need that too.
-- 
Duy
