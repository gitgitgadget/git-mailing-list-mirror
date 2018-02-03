Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7682F1F404
	for <e@80x24.org>; Sat,  3 Feb 2018 21:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753962AbeBCVef (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Feb 2018 16:34:35 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39841 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753344AbeBCVed (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Feb 2018 16:34:33 -0500
Received: by mail-ua0-f195.google.com with SMTP id e18so16423172ual.6
        for <git@vger.kernel.org>; Sat, 03 Feb 2018 13:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DFI0UxUawC/K9gLoI7H4X00SMdCOz3+jqS98UuE+qfs=;
        b=n2Ie5ctkWySIG8uiI1U/cQ6oPVm2FRX883jC9fMOcHcZ3pg0jj2eDnzm9ej7kYMPfh
         sMCnWMw9HWTKZvNDS6pGR4gVqIgLRlZqABS1vqZPTz/gWe4kYFg3rAexfkG7HN05C10h
         9FobrpT/DEf+SwmOZO8p49StdsMokpycGn1WNPbbd+d1ieAcevoKI8E6LpNRJHy9QLit
         QHe0eeUJXl/vUQheUG+bmyeG8ss5D7OnKunZMHCTWJRlCegQoY81ZDy0WX/ySVkWcaXM
         /MhVKxiqfRZtfKU7guBBf6bIHuzak2/Amo/7rDq2x7kLBrODzffTIlLGd5Bngr3XUQdp
         +pCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DFI0UxUawC/K9gLoI7H4X00SMdCOz3+jqS98UuE+qfs=;
        b=Aw+fNkheTvy77WiAuJ2HaGrHHu2epgYCOP8yFcspB+yIDEmyITNOGVWBJOeo08HPeE
         EHqTnn4pIMhV8n2lBOrLG40wLZxukMK+4kGLFy+4mhcvglLOcVMarqeiBQ+AHCDIHYlN
         3pdeB7ARMIznc9YLG6zl1pWlcO0TBZNFV8kMgEb5ji8mKIBlxHYVE9A4KgEpMeJUuJKf
         ZcOPpBPnIEztp/AjiVGvtZw6uRwD8QY4saCI6UExWddchpaPjTu98VWH3OxC7g2RnjEt
         tQACyQ2Rpn+6/R/g509B1UFYmpYutt3O/YNwDbFwdqHMQr+FWamL6FiZxMdqkh4FJlak
         CI5Q==
X-Gm-Message-State: AKwxytdsMGPXYZs0VS8oqhN4X6/jBMEHu4x9zYsToqfmzDsREl9uo85+
        nk55IqFaqxFteo1Al95ipEiUWGSZbiZvpgkS73c=
X-Google-Smtp-Source: AH8x226gfqWXse8eYGJugPaqI9/W2nU1wWmfIebWAcPn3N4zjIVtAgshi82NfOg3ppGtn87/m7eUdVA51HRTERS8iRU=
X-Received: by 10.159.50.105 with SMTP id y38mr24666060uad.123.1517693672613;
 Sat, 03 Feb 2018 13:34:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.33 with HTTP; Sat, 3 Feb 2018 13:34:32 -0800 (PST)
In-Reply-To: <CAGZ79kYcmq9JyD4smH1Vdm5YOFXRXjhYhhHYjNV=Z7mxz2UVGw@mail.gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-18-newren@gmail.com>
 <CAGZ79kYcmq9JyD4smH1Vdm5YOFXRXjhYhhHYjNV=Z7mxz2UVGw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 3 Feb 2018 13:34:32 -0800
Message-ID: <CABPp-BGc0F5023yY1wRb3Gy+oXdbHAibkHYr35+zE=OnT2bQmQ@mail.gmail.com>
Subject: Re: [PATCH v7 17/31] merge-recursive: add a new hashmap for storing
 directory renames
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 2, 2018 at 4:26 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:

>> +static void dir_rename_init(struct hashmap *map)
>> +{
>> +       hashmap_init(map, (hashmap_cmp_fn) dir_rename_cmp, NULL, 0);
>
> See 55c965f3a2 (Merge branch 'sb/hashmap-cleanup', 2017-08-11) or rather
> 201c14e375 (attr.c: drop hashmap_cmp_fn cast, 2017-06-30) for an attempt to
> keep out the casting in the init, but cast the void->type inside the function.

Fixed (locally).

>> +struct dir_rename_entry {
>> +       struct hashmap_entry ent; /* must be the first member! */
>> +       char *dir;
>> +       unsigned non_unique_new_dir:1;
>> +       struct strbuf new_dir;
>> +       struct string_list possible_new_dirs;
>> +};
>
> Could you add comments what these are and if they have any constraints?
> e.g. is 'dir' the full path from the root of the repo and does it end
> with a '/' ?

Good idea, will do.  To help you out with the rest of your review:

yes, dir is full path from the root of the repo, but no it does not
end with a '/'.  The same two constraints hold for how I store
directories in other variables as well.

If someone renames multiple files in a single directory to several
different other directories, then possible_new_dirs is used
(temporarily) to track what those other directories are and how many
files were moved from `dir` to that directory.  The 'winner' (the
target directory with the most renames from `dir` to it) will be
recorded in new_dir.  If there is no 'winner' (a tie for target
directory with the most renames), then non_unique_new_dir is set.
Once we can set either non_unique_new_dir or possible_new_dirs, then
possible_new_dirs is unnecessary and can be freed.

> Having a stringlist of potentially new dirs sounds like the algorithm is
> at least n^2, but how do I know? I'll read on.

Yes, I suppose it's technically n^2, but n is expected to be O(1).
While one can trivially construct a case making n arbitrarily large,
statistically for real world repositories, I expected the mode of n to
be 1 and the mean to be less than 2.  My original idea was to use a
hash for possible_new_dirs, but since hashes are so painful in C and n
should be very small anyway, I didn't bother.  If anyone can find an
example of a real world open source repository (linux, webkit, git,
etc.) with a merge where n is greater than about 10, I'll be
surprised.

Does that address your concern, or does it sound like I'm kicking the
can down the road?  If it's the latter, we can switch it out.

> This patch only adds static functions, so some compilers may even refuse
> to compile after this patch (-Werror -Wunused). I am not sure how strict we
> are there, but as git-bisect still hasn't learned about going only
> into the first
> parent to have bisect working on a "per series" level rather than a "per commit"
> level, it is possible that someone will end up on this commit in the future and
> it won't compile well. :/
>
> Not sure what to recommend, maybe squash this with the patch that makes
> use of these functions?

I'm unsure as well; I can combine it with 19/31 but I thought that
keeping them separate made it slightly easier to review both.
