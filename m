Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A9F1FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 13:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbdJFNTv (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 09:19:51 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:53597 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbdJFNTu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 09:19:50 -0400
Received: by mail-it0-f53.google.com with SMTP id n195so5171696itg.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NmvHcRO2oZDM7YV1Zfz78D+QSJUCv7eAlXHnBFWkhRQ=;
        b=M/QPBN8ypplFU1qVM//mZS8asmRkc18ypffLB1GE2rVvhthvqvUJvqq2QOHPMzzUuO
         cRY+I5ZpGGHAwmZV9KuQiZXx+cRwjEioVqX2FzngZemVZWrE8VVw1veXwjrj61z4S5ZM
         BGHhzFf5o+5BQhOVH8emHYD+PplGRFaeEtE7fEZZN3AFyF7ZZKlP1Pn9sq4uSny+yLT+
         sbtj1E2ggi6N9H82llq9NidwQq+LFkUmHi7wF0THwQJE0TIu6iVlyVFjm9G8jkZfgVtB
         paziaMn6xQoSPc6eupKWPNnQMEYfvnVLlPvKt7tDmYzp3wR8GhZXuiX+LS51MA5lo5BR
         X67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NmvHcRO2oZDM7YV1Zfz78D+QSJUCv7eAlXHnBFWkhRQ=;
        b=DSHQ7+Cn/LFW+sGmLIPlxCQ8dhC6GDSGgWdJTHpSt66XqskYVirFaw8QxShyVyYnvJ
         d1i4ng0s0PZTgcVZYNQ08gXXRTg0vLqc+HylWOxCCdkniVQmpdBVt/PrEQUUwr4lON5n
         9GLu3oyKiGZcOmwcCLGr6P+PpZwz+3Hn0K0hF0DId7mw2/zQ7XK1nIR5jBRHFbOw+sbK
         75LAYlAQa7fHcz5X0XHyOvHi9uOD03ps99gM8jW3tyQqh16dl5N9c+fze0C7xqaebM6d
         j6VQOrBqX/1V+6d+bm4zryNcFkXubKfx5NFjsMcSyqU0vKLdzFvBzKuhQT7dB+7GUhHJ
         3gbA==
X-Gm-Message-State: AMCzsaUvMJKX+LbQsduzpeFOHcosMlEOLgduWOkW1+8GczQacfgz7cNo
        QkU7shPkOXzr0HLcym3CoyXm/clpf9fPYXz3gFE=
X-Google-Smtp-Source: AOwi7QDHp7L4MjF/P3COVGNvNUEDDSh6t7lsqiUGCeqWYjNcGaa09hdce58embMh4F4wwy/Wfu8L6hDIZmsAyfCfx1w=
X-Received: by 10.36.166.69 with SMTP id r5mr2377823iti.67.1507295989760; Fri,
 06 Oct 2017 06:19:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.115.198 with HTTP; Fri, 6 Oct 2017 06:19:48 -0700 (PDT)
In-Reply-To: <fe023f38-01cc-2257-bbfe-3f4310193b41@redhat.com>
References: <20171005132243.27058-1-pbonzini@redhat.com> <CAP8UFD1X-aRN5sAB5PQt04jL_92APK279bjNf=Zt_x8KOxyL+A@mail.gmail.com>
 <748131b7-bddd-08c2-ff72-9fd1a63ef6a0@redhat.com> <CAP8UFD28vVx51xhDgQVesm356XAjfwb286baER-U6VOC+4NL4w@mail.gmail.com>
 <fe023f38-01cc-2257-bbfe-3f4310193b41@redhat.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 6 Oct 2017 15:19:48 +0200
Message-ID: <CAP8UFD2_ZC4J4eRxq04TJ6-xyK5oTqHM2qd+5HfPV7jcoShvqw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] interpret-trailers: introduce "move" action
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 6, 2017 at 2:39 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 06/10/2017 14:33, Christian Couder wrote:
>> Ok. I think you might want something called for example
>> "replaceIfIdenticalClose" where "IdenticalClose" means: "there is a
>> trailer with the same (<token>, <value>) pair above or below the line
>> where the replaced trailer will be put when ignoring trailers with a
>> different <token>".
>
> So basically "moveIfClosest" (move if last for where=end, move if first
> for where=begin; for where=after and where=before it would just end up
> doing nothing)?

First yeah these would not make sense anyway if where=after or where=before.

Now it would be strange to have "moveIfClosest" without having "move"
first and I don't see how "move" would be different from the existing
"replace".
Or maybe "move" means "replaceIfIdentical", in this case I think it
would help users to just call it "replaceIfIdentical".

Also there is "addIfDifferentNeighbor" so we already have "Neighbor"
which means "just above or below". Then if we use "Closest" I think it
will be harder to distinguish it from "Neighbor" than if we use
"Close".

That's why I think "replaceIfIdenticalClose" is better. It could
enable us to eventually use a regexp like
"(add|replace)(If(Different|Identical)(Close|Neighbor)+)+"  to parse
the add* and replace* options.
