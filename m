Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FD3B1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 15:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJPXJS (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 19:09:18 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54275 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeJPXJR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 19:09:17 -0400
Received: by mail-it1-f194.google.com with SMTP id l191-v6so33571979ita.4
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8ZIW+O7uoAE1m/QCwudb3XewbhglQ7ggE9kHyOsZe4=;
        b=WFY8I+i7Jh3JtjOvvzh3BfylX3hmCa+fsDZnF+LF4iJLVXGd/BMZb5UQQTfdGgwSk7
         jYBbfd7kZi2MerfVUfSX5FSZJCYNQckWIVvbABr7AazJA/yu8cxwQlsJ/Pxayps04lPF
         YtVOnhamjw2gFma0nhWBiaXr5CWECRgK/wq3ep8iTY6cqgdZevUwkcDhbm8jLrw/r50c
         LwpoRCPyyrBgrTZv6gpTa0BQcy3L8Q1l0bnoMVtMuWW9rvkudsufjlFWTYMUjlk5WTjH
         5TfU+ngczrPBYBP0/r6TMtsPqdmwHCQzoqOEBkcU4+2VwmMzt98gSbYG+tEJW50XWEw4
         /MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8ZIW+O7uoAE1m/QCwudb3XewbhglQ7ggE9kHyOsZe4=;
        b=hcVOAEgiFyr3dTTQtqOQuXRWMN5d38wSNnka8yShVCR1PpqYNN6k77nsLBAgXHPAPq
         NoWbUtvNIPGA/22nGYZHJEsfd47LxcBfF7p509VnNkdRtsImuq4TahMoop+qGdVZPmH3
         jdn7JgxeD5vgIsrNhIRxyCJgye7jgxyUo3nG5xYh7VzHMoF5Pw3LcrR74bEKLN7rG0Z5
         shbLIXL9b+TUDmafIfz7XJF01WYwGF3Lq6xG9GhOwvx/lrZIF49PmaUgQGBV+XUtl4Lx
         ns4W1CB7qIwjrgdBnHem8tnFjjYjeoRKUMC3vxGKfkFlHlHqLrVJFg1ybn2BlHiy2Psa
         FBIA==
X-Gm-Message-State: ABuFfog4zyJ5E2qQTzHLwP5scP7cMxmQN4X402k2WO9bgOITqj7G4o67
        Qos06Kdiedc/FTyQI8vPAS7dWpH1eeZvX7k8JYc=
X-Google-Smtp-Source: ACcGV63PMLBPKehp8lkF4rZu2FOyERHta3+SC0HoJCUVSj464vSLa33LikRjbXP6ChGYrc9iYwW2rqtgY+SjHEdkU8w=
X-Received: by 2002:a24:a343:: with SMTP id p64-v6mr14031726ite.10.1539703101179;
 Tue, 16 Oct 2018 08:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net> <20181015021900.1030041-2-sandals@crustytoothpaste.net>
In-Reply-To: <20181015021900.1030041-2-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 16 Oct 2018 17:17:53 +0200
Message-ID: <CACsJy8DPBkRyPYF7Vfh0bQHJDvDZcmp54wjzRxG4Ho40SkMTSg@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] sha1-file: rename algorithm to "sha1"
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 4:21 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> The transition plan anticipates us using a syntax such as "^{sha1}" for
> disambiguation.  Since this is a syntax some people will be typing a
> lot, it makes sense to provide a short, easy-to-type syntax.  Omitting
> the dash doesn't create any ambiguity, but it does make it shorter and

"but" or "and"? I think both clauses are on the same side ... or did
you mean omitting the dash does create ambiguity?

> easier to type, especially for touch typists.  In addition, the
> transition plan already uses "sha1" in this context.
>
> Rename the name of SHA-1 implementation to "sha1".
>
> Note that this change creates no backwards compatibility concerns, since
> we haven't yet used this field in any serialized data formats.

But we're not going to use this _string_ in any data format either
because we'll stick to format_id field anyway, right?
-- 
Duy
