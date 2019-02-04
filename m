Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 669B31F453
	for <e@80x24.org>; Mon,  4 Feb 2019 21:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfBDVKu (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 16:10:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33946 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfBDVKt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 16:10:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id f7so1474929wrp.1
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 13:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=M0NMoO1IObcAyfsTq5YX3iNAZ5p5km+Qmx5c19zjt2k=;
        b=CqJI1h5LgOCH+PQo1QHs+hbzT/k7g0VSAZvkzAqyqoOyY2/j1m34HFiRQi8VGyMHwc
         EJiSdZ7orLSCqTOVjSRibkLZu8HnJ5y1Mm/d33y1uJfeNWq2Dff/IPdL2bh5DiIYObRw
         edobPoYqCMv14b1K3WaXHSEeWuVyCaT4Z9xYTKu10qoFegUHe4aihw71iS8ObtiIwIN0
         lysRJLduK4yJEOa+tbRu66Kk6i0ZaojTK2zGNi6872+jm5gxbIRPLjEEByIXZpZKqyBA
         25UKuAS5NoFAOop1nhenMeLbhf+JrcK482yKBsCOLhX6tfzWcl6ImRWar5x2ZXe24WTw
         TSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=M0NMoO1IObcAyfsTq5YX3iNAZ5p5km+Qmx5c19zjt2k=;
        b=iZuxHfwKzrhN8LIgJBPS/cAr2e2gC/OTBC9dEPhEwE6/438qyPQ914G1Fk+34Eiui3
         K6K+YAoPR//Q9nuxEhcBiNCaU2lowJZgaZt7skEfxGGvHSuXF1yQG+RUme1aJ1KLZOHz
         OZFSC0i6s0MITfNq6mhHN7le2uXIt9mMdXZSAhKE5Nk9lxELASUlb2IOHVCVO6FORyOK
         l3wJ++kWOjurzDO6ZX1+6A7dqgtt+ejkqI9e0wSDj4clq1ZiD50kkA6YgZPl8xMyjTUw
         9lYwdsNkJR0uOsqDMAXhcnV83ga6i+a+UKw8FHLPn+uUXBYl3xOcTa5hvcZVR8k97vm6
         75lA==
X-Gm-Message-State: AHQUAuZATIDH3pRwIkdhV9SDZzHuN4XdGRpI3fNp5lohs8pbKF4xJ90G
        ng8pMwo5Vd+0TtkwYZAF+0Y=
X-Google-Smtp-Source: AHgI3IYboKjfXSJRmi2Iaikhi+2X4SfiL/rIHP8vky8PksyX0Y7COgb9DWTBs2yYBV0t2uSF2/Kp3Q==
X-Received: by 2002:a5d:47d1:: with SMTP id l17mr941821wrs.319.1549314647366;
        Mon, 04 Feb 2019 13:10:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e9sm16163765wrc.56.2019.02.04.13.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 13:10:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH] diff-tree doc: correct & remove wrong documentation
References: <1292425376-14550-12-git-send-email-pclouds@gmail.com>
        <20190204103618.17992-1-avarab@gmail.com>
Date:   Mon, 04 Feb 2019 13:10:46 -0800
In-Reply-To: <20190204103618.17992-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 4 Feb 2019 11:36:18 +0100")
Message-ID: <xmqqpns7tg2x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>  <path>...::
>  	If provided, the results are limited to a subset of files
> -	matching one of these prefix strings.
> -	i.e., file matches `/^<pattern1>|<pattern2>|.../`
> -	Note that this parameter does not provide any wildcard or regexp
> -	features.
> +	matching one of the provided pathspecs.

Correct.

> -
> -
> -LIMITING OUTPUT
> ----------------
> -If you're only interested in differences in a subset of files, for
> -example some architecture-specific files, you might do:
> -
> -	git diff-tree -r <tree-ish> <tree-ish> arch/ia64 include/asm-ia64
> -
> -and it will only show you what changed in those two directories.
> -
> -Or if you are searching for what changed in just `kernel/sched.c`, just do
> -
> -	git diff-tree -r <tree-ish> <tree-ish> kernel/sched.c
> -
> -and it will ignore all differences to other files.

All of the above give still useful piece of information to the
readers.  I do not think it is a good idea to assume familiarilty
with pathspec limiting to all readers---a new reader must start
somewhere and diff-tree may just be a random place s/he started at.

So I do not think it is a good idea to drop this example or the
section from the page.

> -The pattern is always the prefix, and is matched exactly.  There are no
> -wildcards.  Even stricter, it has to match a complete path component.
> -I.e. "foo" does not pick up `foobar.h`.  "foo" does match `foo/bar.h`
> -so it can be used to name subdirectories.

I agree with the patch that this paragraph should go.

> -An example of normal usage is:
> -
> -  torvalds@ppc970:~/git> git diff-tree --abbrev 5319e4
> -  :100664 100664 ac348b... a01513...	git-fsck-objects.c

Interesting.  This does not work (and I do not think it has ever
worked) for a tree object 5319e4, but it works as advertised for a
commit object.

The description section has this near the top

       If there is only one <tree-ish> given, the commit is compared
       with its parents (see --stdin below).
              
I think s/given,/& it must be a commit-ish and/ would be appropriate
there; please include such a fix in a reroll.

I agree with this patch that it is a good idea to drop this example;
it is more appropriate to use "git show" on the commit-ish in the
case of the given example anyway.

> -
> -which tells you that the last commit changed just one file (it's from
> -this one:
> -
> ------------------------------------------------------------------------------
> -commit 3c6f7ca19ad4043e9e72fa94106f352897e651a8
> -tree 5319e4d609cdd282069cc4dce33c1db559539b03
> -parent b4e628ea30d5ab3606119d2ea5caeab141d38df7
> -author Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005
> -committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005
> -
> -Make "git-fsck-objects" print out all the root commits it finds.
> -
> -Once I do the reference tracking, I'll also make it print out all the
> -HEAD commits it finds, which is even more interesting.
> ------------------------------------------------------------------------------
> -
> -in case you care).
> -
