Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71B91F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbeGMRBN (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:01:13 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:37249 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729622AbeGMRBN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:01:13 -0400
Received: by mail-vk0-f68.google.com with SMTP id h22-v6so18528216vke.4
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5kLICefGkVJEu0wY0eL5R+M+C7pQjVoh3mF8qak62ZE=;
        b=NP5EBk/57WFoYxNr9ASHjbB3nB5W1MOVoBTrUOhH21S138lboZgXlDtlZgGBXEi5vC
         +kgdvsVcEVeQv3r7Y2Ua/pRZzfSmCfF6PkSYIEdOt2Et5XrBdKluaMvg5wXbaB2VIRkx
         TSlRX/g+6uuL16QoZU/hXQ5CQMUFEShqqs7WDnSuUoH7MDhxUxktLVXWfA7bfWPm40g1
         q3A07PnM0Wt4QZF6XH4WIz/3VcNbSRBfWH3rnmoPsrtZCxOCyeU9Nz+ngfTROE/hCOBe
         Hc1QEZgroP3QgRtvtNOECoIM7ODMue1gDIB+QJvqLfz8Ygc5n/PkCpz2E0eWdUThPtKJ
         znjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5kLICefGkVJEu0wY0eL5R+M+C7pQjVoh3mF8qak62ZE=;
        b=rXf2wGrfmjOdLEAcYb073vmR7k6ZaQgPbrQixDScXOHDSvwX8T3rPdSqAfjwHVzyZz
         6eW0tys8SLJizb+u7CnNCHGlxGJKTOBmA0JQIiqQcbdB6Dg2WqTKa4/QudbU+9aZopKw
         fYBZKO7Ic6Px4gQ+Lw7nTeQfHB4xJEjF6GK8VoR7B7v7Q19a369RnQXYIPLbb6Uu6BSi
         oPJq8VETNkd0zdRgdL7TyZWqh+tQJFEqFU1QsRqgT4sC5WRARgY6XFboddgGcwJApf6v
         ptWOCanlBn0PmV5T0oeyPciZwQVhBy+Tt7iTxfbGGmxPkhthRFkgW4Baj+9GR93U9yVV
         j+Xg==
X-Gm-Message-State: AOUpUlGOPgb3pRs53UNxvRnRLsU5R+591hdQ/g+NJbnYj+TzLOvuTgYE
        Inn0yg8OIuoHXLVYjBjxqy0bKI0aJ9oavXgT6cM=
X-Google-Smtp-Source: AAOMgpcVnbfnhKY7V2W+PZOXXa033oSRkhGiEYLzWO/4gE+TA/tHiR4ZmM2fZCbKRXWy8hTmSm/1XIDvPItmkJdI+jw=
X-Received: by 2002:a1f:a182:: with SMTP id k124-v6mr4228749vke.118.1531500347712;
 Fri, 13 Jul 2018 09:45:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 09:45:47
 -0700 (PDT)
In-Reply-To: <20180713163331.22446-1-newren@gmail.com>
References: <20180711051834.28181-1-newren@gmail.com> <20180713163331.22446-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 13 Jul 2018 09:45:47 -0700
Message-ID: <CABPp-BGtrsAzvT7=95vKUXveQ=3X6FkAc5VgEYBNRXSzsqY0DA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Address recovery failures with directory/file conflicts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 13, 2018 at 9:33 AM, Elijah Newren <newren@gmail.com> wrote:
> This patch series fixes several "recovery" commands that outright fail
> or do not fully recover when directory-file conflicts are present.
> This includes:
>    * git read-tree --reset HEAD
>    * git am --skip
>    * git am --abort
>    * git merge --abort (or git reset --merge)
>    * git reset --hard
>
> Changes since v1 (full range-diff below):
>   - Make use of test_write_lines, as suggested by Eric.
>   - Provide a little more explanation in one of the commit messages, as
>     suggested by Junio.

I forgot to mention: there is also an expected failing merge --abort
testcase in en/t7405-recursive-submodule-conflicts (currently in pu),
and the fact that this series does not fix that testcase is known.
For the curious...

This read-index-unmerged series is part of the solution for the
problem highlighted in t7405; in fact, the similarity between
file/directory and submodule/directory conflicts is such that this
patch series does also happen to fix recovery problems for many
submodule/directory conflicts as well.  However, additional work is
needed when the same path is found under both the submodule and the
directory, and the testcase in en/t7405-recursive-submodule-conflicts
is precisely one of those cases that needs additional work.

(This is just a long winded way of saying that this series and
en/t7405-recursive-submodule-conflicts don't conflict or duplicate
each other.)
