Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70EC01F42D
	for <e@80x24.org>; Tue, 27 Mar 2018 09:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeC0JAe (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 05:00:34 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38297 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbeC0JAd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 05:00:33 -0400
Received: by mail-qt0-f195.google.com with SMTP id c23so4323797qtj.5
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 02:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bUD8YIlfl5VzKMF3d2ZxbH0XbdRAO0GjfPHbm4rjoro=;
        b=OrpWRkK7Alud8C6ARburVmfIHXZ4P68AikeWGpxz9SDD72cI+pY2UFKBMdrnVJSjiT
         3ZFbuHdMp6y6hpywRnZDs3/XbEaaaR+W8HbvaVZwSyV7O1/HnGzjAm6vV3uc1VObiKPK
         gdi57do8dgPOOrZv5nyDl3RMfd2g60DAVQfRse+NYJm+SDgcHhbZcpbuYy0FiZvRKLqo
         EItDGLpsW0t+uQfRgQ/6dYFP9dRUss5zB4oZLqI2w1NHiUP/teyeY+3dmL0+u4wJYmTC
         Wvv4qBW/3YPRNej/XmMyC3yrex+M2/x1uxQ/4hf0TYzfHesiqsSEsbh6tyVYVlP2Mwxb
         a4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bUD8YIlfl5VzKMF3d2ZxbH0XbdRAO0GjfPHbm4rjoro=;
        b=si4H/0Y6L5j8ACOiVdxsjoCWPB/EnhUTNJDcUYMi4KAhK5qC3/mtYeP7zYxCjpRktj
         M9+W5+vjrdIm1xSqWcmy5qHz6w/OQm5nfu1wzW5v6efZ8q1oJGXqrJ/0jmUm6z17gQMr
         vDIOaDIQxUNbvGat0omrN4peVH+X2sw+v1E2fdpgD0ceBgcxoRM4JtAtP7b/PRlSx2Sw
         iLHpCI1xNba2RKkx8pY3qNdqAx3dbAdQJt4vfwpVoh2Lm+jY691rQNpvf6gSvl04w44K
         0lQ2I+N0NxrIwx4yYliAKYn1UQsvwCasGbOOf7xw9wdvexYEBRwjANsGEFG9EpLAQyUF
         0BBg==
X-Gm-Message-State: AElRT7EYNWM5abhPmOxaooB8tTeMhZIq0IztWaP4LaXjynH75bK4eUrb
        9hj5tcFq4w5OlpFC9JlBdFa4yn9FgwjWhtyIH8c=
X-Google-Smtp-Source: AG47ELuBTkJLxgSsg5jcEb55EuUUNZ1JALo0fylwcR3ManMKALTm+cje75H10hyJeh0YKLPPz6vDuBCGo40wsBFjpaA=
X-Received: by 10.237.42.56 with SMTP id c53mr61281305qtd.199.1522141232504;
 Tue, 27 Mar 2018 02:00:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 27 Mar 2018 02:00:32 -0700 (PDT)
In-Reply-To: <20180325134947.25828-4-t.gummerer@gmail.com>
References: <20180317222219.4940-1-t.gummerer@gmail.com> <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180325134947.25828-4-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 27 Mar 2018 05:00:32 -0400
X-Google-Sender-Auth: sJ7HnYfUdZCQZZ7PjRfYycmPnHc
Message-ID: <CAPig+cQQUbBihLeBRemLHnx42E9b_qUt-mKgDyRRy0-UQTYBKw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] worktree: remove force_new_branch from struct add_opts
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 9:49 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> The 'force_new_branch' flag in 'struct add_opts' is only used inside the
> add function, where we already have the same information stored in the
> 'new_branch_force' variable.  Avoid that unnecessary duplication.

When I was reviewing your original dwim-ery series (inferring 'foo'
from 'origin/foo'), I noticed that 'struct add_opts' had accumulated a
number of unnecessary members over time, including this one. My plan
was to submit a patch removing all those pointless members after your
dwim-ery series settled, however, I never got around to it.

This patch might be a good opportunity for doing that cleanup
wholesale, removing all unneeded members rather than just the one. (If
so, you'd probably want to move to this patch to the front of the
series as cleanup before the meatier changes.) Anyhow, it's just a
thought; feel free to respond with "it's outside the scope of this
series" if you're not interested in doing it.

> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
