Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 371D01F424
	for <e@80x24.org>; Wed,  9 May 2018 15:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964950AbeEIPz0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 11:55:26 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:32849 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935151AbeEIPzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 11:55:25 -0400
Received: by mail-ot0-f170.google.com with SMTP id l22-v6so40724979otj.0
        for <git@vger.kernel.org>; Wed, 09 May 2018 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ea6kCIJ0fdz1yQUP4xxJH6KbvXZiOygnnhAb9djgW+U=;
        b=WJPBJhqHWw3d8dSReoFUmuicriGek664wiO1OgbcM9GlOA8H4FE+ravh9yChDBQBJ2
         +Yh4sUvHMUOhz03SmIvZzYPMTtJ3FX+jgQqah2fbNmSAmfqUPgNJQF44r60WqxVeM6jb
         h3tUQ3WUiNJboJ/pefJnSzdoueUa/M1FyzNwCkiEFbAf4dQV6d1vN4cs5byKGXaYa5eT
         pS1V02Iz4L04eIdW3q1UaHv3wl3ZrnmjHggNgaFkZDOMx9tkhKBcO/o6SbT7r7wlAdEs
         Ak60s4ATdXJ5ec44AykwKuJIK0VEVoTLw601ZjfKYBVpi9JWwwX7CeDC/jPSJwepClB8
         +SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ea6kCIJ0fdz1yQUP4xxJH6KbvXZiOygnnhAb9djgW+U=;
        b=RRyc4OiEA7aMfVAWtvZ4VxdJbYWbSljLIGQ6jxgMu2tdnd1y/3exmc3pEdhcFUbCAt
         de0+vg+wVUyLUp+qAAjR36RZIXpSftddc4P4u8Xmtuk8DwybK/C4ZuHSlBWRFSNKGCSJ
         nu9pCUl7QkBbcAsrMht4gCb9PiwG2Go2obGL3lVQuNPgF54PSy65sKidweYijR2UvIK3
         dXIdUJXhC78DZNVQ20S4l0t8WC4ugCiM4Awie0mxqQ0IGi6wXbICN6LtgQ5pEtYLhxvq
         oE+1g7vipjEGKwN9VT/GDYLpFRoEtsoID+TkTvUmYYIyiEMlAekks+02H6fXTVUTyM9z
         mbTg==
X-Gm-Message-State: ALKqPwdJbQhH8T0MRd3M3xitOBHyGX4rxYrJiUkhlBZEZoQlGx5ZyP96
        rdjO5oeO8bxKWx4UJQGifCw0jV2yp3sQj1K004E=
X-Google-Smtp-Source: AB8JxZrjtmzIQT4PKEkc6NRyO0qYnI+rrR+M6pNlzjjUDCwH98DENRsqaGXuLi906b5APHNnenaa4u1oYqhnHvd5DQQ=
X-Received: by 2002:a9d:c61:: with SMTP id 88-v6mr5925585otr.173.1525881325231;
 Wed, 09 May 2018 08:55:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 9 May 2018 08:54:54 -0700 (PDT)
In-Reply-To: <CAGZ79kbgxFJ-+t=50r9gVMTm4xomh+pgm81r2QLnDvTqxpxV6g@mail.gmail.com>
References: <20180507225916.155236-1-sbeller@google.com> <20180508193736.14883-1-sbeller@google.com>
 <20180508193736.14883-14-sbeller@google.com> <20180508130431.287a9f273a847c375b3b1e2b@google.com>
 <CAGZ79kbgxFJ-+t=50r9gVMTm4xomh+pgm81r2QLnDvTqxpxV6g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 May 2018 17:54:54 +0200
Message-ID: <CACsJy8A3xBz8_MEN-dUcSh317AQn03EP7=TOQ99vzo5zyyd_jg@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] alloc: allow arbitrary repositories for alloc functions
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 10:37 PM, Stefan Beller <sbeller@google.com> wrote:
>>> +void release_tree_node(struct tree *t);
>>> +void release_commit_node(struct commit *c);
>>> +void release_tag_node(struct tag *t);
>>
>> Do these really need to be defined in alloc.c? I would think that it
>> would be sufficient to define them as static in object.c.
>>
>> Having said that, opinions differ (e.g. Duy said he thinks that release_
>> goes with alloc_ [1]) so I'm OK either way.
>
> I would have preferred static as well, but went with Duys suggestion of
> having it in alloc.c.
>
> I can change that.

Heh I thought you would make them static ;-) I just wanted to keep
release logic outside that object pool, which is clearer and also
makes it easier to replace it with mem-pool.c later. I'm ok with
making it static. Or if you do export these, please move them close to
the parse_* functions where memory is actually allocated. E.g.
release_commit_node() is moved to commit.c, close to
parse_commit_gently(), release_tree_node() close to
parse_tree_gently().
-- 
Duy
