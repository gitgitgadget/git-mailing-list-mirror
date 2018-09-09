Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BEB31F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeIIMyR (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 08:54:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33111 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeIIMyR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 08:54:17 -0400
Received: by mail-io1-f65.google.com with SMTP id r196-v6so4637483iod.0
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+gMT1UjihGex1pKhUthLRahDuHMqkQTyvii+rIPps0=;
        b=GpVTR3/j1IDQ96UtOjHtQM3bmsllzwKxrQoqrGzdwOH7x/2tzv2p3Gqc3I753dWYfW
         wJRDYAyrUSeYraVmHZd8XutX37SQa2wTK8kSp+Hk4mx2oI1XQcEDs60tHbFwykxHk+eI
         9JJCmrPyZ2BpsYg/km2wNKENUgqE8RqlNF1KDvPJeczxCRgC6OhtruaWujE0C5KWFZO5
         FsxFXaSx5ssV1K4oPG2tAS7/U80Bk7bvh7+QYSUTuSmVcEH0iyD+Zrkf0raE+dW3ihE/
         0n/6HmnYbAuqxtI3mgUgoEd3v/aRN9WH1xCPemX504H5P0xnwBWbQ28sc9DkIuIEGTcq
         AGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+gMT1UjihGex1pKhUthLRahDuHMqkQTyvii+rIPps0=;
        b=fhNN+d/VuKLd5DLIJoBPQqgLthPrziCTNHuvQ26pJkOmSYQWfxq2bXQtlqDiuoMNwT
         LCw8J5dqMLTs8KGMxZPgxzvt1F6Xn4VgUjc3KE54xlsO3xmYGuUjAgJAMoJmfiKyPjdL
         oLmddN3OwQuuXaA+8Ht3kuVxgn3of0Q1gpDBRxkzxudwczbyb+vDSdacB80DElgE4o3F
         2x6c4YoNiCNhMYxKkN5fKgUUAlg9wi7QiBsoshqhUuqcWjn0V+Hsq+lqdli3v5ncrROH
         cOCiJsG4Ca1Q2DcU9voy3sUvTIsjXQb1MJOkavhl2RIki+s8EeKxUnERFceC9rGA2KnJ
         VHFQ==
X-Gm-Message-State: APzg51Az+lARLOoywG+uheXMq9RMsqjvk9DLvoR42a8Ul6BDTl6A/cC7
        V5/ZHnHd0Q2a/3EatumTSvKzJqAvOt9g6V8Ilx0=
X-Google-Smtp-Source: ANB0VdZXf9n2BTJI5KbLHic0DBA7yrttE7bDiLIIIQUdE7RgaJRg7bpIVEKOuS+niMqQdFWkk5fnj4dTgdx4AwR0xtg=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr11441374ioe.282.1536480328048;
 Sun, 09 Sep 2018 01:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180903180932.32260-1-pclouds@gmail.com>
 <20180903180932.32260-25-pclouds@gmail.com> <xmqqo9dd6kx1.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kZhQJ7TbTuuDO_k-p80rGnOTjVcHf0aoq2+=pG4bwetNA@mail.gmail.com> <xmqq7ejz4pvq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7ejz4pvq.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 9 Sep 2018 10:05:01 +0200
Message-ID: <CACsJy8CepuW3DG2AbMiHdoUELHfBmMSZDtPJMzLRHUWwshvivw@mail.gmail.com>
Subject: Re: [PATCH v2 24/24] Rename functions to avoid breaking in-flight topics
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 11:04 PM Junio C Hamano <gitster@pobox.com> wrote:
> > now and here, but at some later date, we would want to
> > 'git revert 24/24' after fixing all in-flights of today.
>
> No.  We do not want to revert the whole thing.
>
> If the function that takes a_repository is called repo_rerere(), as
> opposed to just rerere(), it should keep that name after we
> deprecate the function rerere().
>
> We will want to get rid of #define that gives a thin wrapper and
> make everybody use the API that requires a_repository parameter.
>
> And from that point of view, it is backwards not to introduce
> repo_rerere() when rerere.c gains a variant that can work in an
> arbitrary repository, not limited to the_repository, and fix it up
> saying "oops, we were wrong and this will break topics in flight" at
> the very end.

In the end, there's no variant, only one function that always takes
'struct repository *' and I wanted to keep the shorter name 'rerere'.
But let's go with adding repo_rerere() and deprecating rerere(). If it
turns out later that repo_rerere is too long (or it's repo_xyz
everywhere) then we can do another rename.
-- 
Duy
