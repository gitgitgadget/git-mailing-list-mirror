Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20221F954
	for <e@80x24.org>; Wed, 22 Aug 2018 11:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeHVOZe (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 10:25:34 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:46806 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeHVOZe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 10:25:34 -0400
Received: by mail-qk0-f177.google.com with SMTP id j7-v6so854322qkd.13
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 04:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmS/rw+9JJIEl7wdfHiQ9CL0HJJuwRuwYZdnzvWH0G4=;
        b=rXkXjgf1oN3RBC4F3xm/JE0+q2vC9s7bC4ZzGxOfQMMCZIGvTdQJdKAzVBdY9zKXh9
         p9W0lkvZOA1VFhGzxfX82OMx3H8h6mmUZBtLoSteqoqIY3ImgJ+Jb+1j69I0UE6HsSI4
         ROttDbJosy0MpwabreTKwQOIJrGeHaUHCJEMMa58/hCcDmWzgPkk7OQ7Y1d5rrFPiqnd
         FTjO0Zdq1ptZwl3s2IwbZ9RwL/WfOzsnF/dsXJIcObFIC4JH8bEYRPFKuSE0KB6mF+0e
         SE6YG9QqPXO82gydeqgDv/+XOejftCE0mgMP6XrKx74fKf1q6sshQi0IYEF1ATG8J+Sp
         cgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmS/rw+9JJIEl7wdfHiQ9CL0HJJuwRuwYZdnzvWH0G4=;
        b=iJxMab3Skm0VC+rqnHNkI6Q/RNJD31RMGXtraWczwNZxVBmaeWW/IZWkqRatmn/0JN
         Oj5Bvp7YwCi9fEmcVQX5z8OddUNPXeFDY4PkPtIoLKqc4lhxzAIAmZ0otKRipg/ukX/6
         2lSebLDtOyeqLwEVb/Jz6gDFRmH06BeXVHV9ocATAxKCAbIiTw8JF+aRwzQGdkBb+pj8
         UGIedFnvxpd+Lx+kgwJefCcDNpWTPk7so0UUXImEMffH4/vyMM1rNKjVjZvNwz4GKb9B
         6RgtEKCCJm9dIBT1RM/rpfqPaJ5HiM2g++wDfsz88rxdYfDubMrmAoBDwszkMGrWFPcG
         shzg==
X-Gm-Message-State: AOUpUlGkib7gSQ0iNPq++F8yx6t4VtD7XJJosDN/dpps0V0CjsxQar+w
        sj6XF9WMNBFX11EVHGkZtj9ZpK+9acQOsBKVWjR21w==
X-Google-Smtp-Source: AA+uWPxfE3bSCBw5VqHJdwqcXPAnhJLMJ0DVlzS6cd9/A9kCO+qFD6e4MMqyRHE+lc8ru6WjL5UqO9B2h9dsj9ntpxs=
X-Received: by 2002:a37:c3cf:: with SMTP id r76-v6mr50336458qkl.150.1534935668989;
 Wed, 22 Aug 2018 04:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180714214443.7184-1-t.gummerer@gmail.com> <20180805172037.12530-1-t.gummerer@gmail.com>
 <20180805172037.12530-11-t.gummerer@gmail.com>
In-Reply-To: <20180805172037.12530-11-t.gummerer@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 22 Aug 2018 13:00:55 +0200
Message-ID: <CACBZZX6xvsZ4K86b53ura6zENs2p0SBjwYYG=h0TNem3wnEbuQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] rerere: teach rerere to handle nested conflicts
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 5, 2018 at 7:23 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:

Late reply since I just saw this in next.

> Currently rerere can't handle nested conflicts and will error out when
> it encounters such conflicts.  Do that by recursively calling the
> 'handle_conflict' function to normalize the conflict.
> [...]

Makes sense.

> --- a/Documentation/technical/rerere.txt
> +++ b/Documentation/technical/rerere.txt

But why not add this to the git-rerere manpage? These technical docs
get way less exposure, and in this case we're not describing some
interna implementation detail, which the technical docs are for, but
something that's user-visible, let's put that in  the user-visiblee
docs.
