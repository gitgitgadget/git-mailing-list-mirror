Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3205A20248
	for <e@80x24.org>; Tue, 19 Mar 2019 01:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCSBMU (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 21:12:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45571 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCSBMU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 21:12:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id v21so12467967pfm.12
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 18:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GVcVM8/EKBT+OAhr03JjPatbZZV+2gFZ8i1X9FReB30=;
        b=emr4/Na+ZCE57k2xm5WYb8bMIMcEtZ7BXLKZAyaHfZU9jdHrFoI8OsUFYONIlFQaK6
         cfXHXYNVvPVsnK7oz0VMvnbjHG38RtApZbn45oNx4fllHMkTYLYfJb40SO6G1DJ6Lwsh
         zreZPkIMbipM2qXDx7pg9BCOdtNtSgoGxGTlR0pEC+jYt97W/ikl3Uqyv4V8ZgycB7Vp
         99cVE+KQLLYYsGQtEPj0zIhGfPBZQ0Pf8snx5Y1CIhcQboJx0ZI8oCc1gLMTRwlI9d2x
         XF6/N5fNAfYjEIe8flx79O+UOWh0/WqzUtAqcjuqYb0lA/7isnEcMAn2TCbR5FOQL7Ul
         uUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GVcVM8/EKBT+OAhr03JjPatbZZV+2gFZ8i1X9FReB30=;
        b=JKClZ5FQePbd55vr0VURacy/BF9yYMrkTr69OO+ZVD+FFluZJSeFiIKGzeSUjCI0u4
         lfMYgf3mypT0WsjJ5a5LSUIe5kweR7fw1BtzZo7O0Jv6UHPUYzh+vXLkk0QSmzeo+3fL
         HmmlwIvBtcSkMBuFxinS0ckRMxxIektVDufN/d1yNAZTKdOTZxP6ZsT8d01nwU5AXKb7
         cqPSIaBVOAdHXUH7kjw0Oh+QBEd0OIYvFoH+7yIDYrYHkYkgDyXPsuH2dCEKjnssfK5O
         SNXjkLmww53oZlDFqhFDV1XNlXyJ/xT6FJ5aO3UVIBZAhhuLLuIaw8qrU/CbKbVS1vTL
         dqkQ==
X-Gm-Message-State: APjAAAW+GUaAgFHAHe+oQfQngNE2G2W3r8sgKh55ygJO7Kz9kHUznJHN
        122h3TDUipzGmfqex4R73/k=
X-Google-Smtp-Source: APXvYqyFOBduVqZKcf24oQhLJN4Q3hSspUdVKot3nVaNds4X6SBdIW1SsXLChhvll4+sX2myFw82ug==
X-Received: by 2002:a65:614f:: with SMTP id o15mr20181918pgv.383.1552957939572;
        Mon, 18 Mar 2019 18:12:19 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id x19sm15460828pfm.108.2019.03.18.18.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 18:12:18 -0700 (PDT)
Date:   Mon, 18 Mar 2019 18:12:17 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
Message-ID: <20190319011217.GA20393@dev-l>
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
 <CACsJy8DU02_kOqAHhU5EgMHKmkNSGdvt+7XzSHoZDB+b9sDRqg@mail.gmail.com>
 <xmqq5zsg3cl6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5zsg3cl6.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 03:45:25PM +0900, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> >> -       This is synonymous to the previous form.  If <commit> on
> >> +       This is synonymous to the previous form.  However,
> >> +       users should prefer the previous form over this form
> >> +       as this form may be more confusing due to the same
> >> +       notation having a logically conflicting meaning in
> >> +       linkgit:git-rev-list[1]-ish commands.  If <commit> on
> >>         one side is omitted, it will have the same effect as
> >>         using HEAD instead.
> >
> > This is fine as-is. But another option to reduce even more exposure of
> > these forms (both <commit>..[<commit>] and <commit>...[<commit>]) is
> > to delete these forms in "DESCRIPTION" section and add maybe "EXOTIC
> > SYNTAX" (or something) section after "OPTIONS" for just them.
> 
> There is no other way to express A...B (well, short of spelling it
> out as "$(git merge-base A B) B"), so while it makes quite a lot of
> sense to discourage A..B (simply because .. is unnecessary and can
> be replace with a string with one fewer letter in it, namely " "),
> I am not sure if it is wise to throw the three-dot form into the
> same basket.
> 

Perhaps we could add an option to use the base as a comparison,
something like "git diff --compare-base A B" which would mean 
"git diff $(git merge-base A B) B".

If we do this, we could keep feature-parity while deprecating the
confusing "range-notation" for diff. Then, we could possibly move .. and
... into a "RANGE-BASED SYNTAX" section and call it a day.

I now personally don't think that deprecating it in the code (or even
adding a warning) would be worth the effort since the syntax is so
ingrained in common usage. However, I believe that we should encourage
new users to avoid the range-syntax if possible.
