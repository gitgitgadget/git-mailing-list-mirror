Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13388C04AA5
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 12:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbiHYMAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 08:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241367AbiHYL7y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 07:59:54 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E82E09C
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 04:59:50 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3376851fe13so501672137b3.6
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 04:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MaUI2JttgOcijLh5G9PRDhb4+pVAUiKuoy7xZ8eoz9o=;
        b=jk2X3t8WbAw9pIPPbEvv+nPa9a59ztKcLbo+GZu5yNRZn5ClBZOZHbwsZvhseh447I
         Ht67YUoDWn7YEqQn9o9F83e0Iy7vw65YjhJf6+vj+92piEXPu4tjZnHLRLfiwe3of57J
         7y6mfQVrOcZn4vk8q8h1hqt2/zVzX407nFaJWxmPpMfy4uxD5avl+tWlVhhT4zBRpl56
         V+1146urx8p8dUyi9cqTgxI0HLFyUn+C+280uRuAZF+zypetaYeBsLz3JmSFNVFSyY8a
         OIH4hUCqcTfv/6NIzW/M2Oiwkh8mJzFzV1BsMuz/8DU7FyXNO3UWG6SpUuBVFXijpjx6
         XKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MaUI2JttgOcijLh5G9PRDhb4+pVAUiKuoy7xZ8eoz9o=;
        b=dOazGANklepkWkqvs9NZW8XwnAtEm8L79IegeRG4B3GBOyf/E5L/LniYSHv22xIEtR
         GTjz8ZMb6S1Ja6q2+/oBMSvQoiweqQ47hBQjEx3x5I5Ft7dcP+m+1thwf2fzzvvqnA1M
         EdfuDZlA+j4z70dRnBVnR7NSZNnTd4agLsr89YnCS6KlwF72bHS6naOhXWhPkzcMRo62
         x5/NJoRXwteDRwsHxsTVpoLZ7YalgRMmb3HoC67pKaDQ/qMlvplgwQ74RxQ7dOKtKs4X
         WHKOcQkCtf5fUc8EReK9t1p152FwoLKLsybfBg8mCu389uzrjjHhxvtNryDxq/IoREZN
         3lVQ==
X-Gm-Message-State: ACgBeo3Nbxee2KwajiVyJ84fnk2kbU9FKY3qPDCHNI/K6X0F0FdFCbmg
        qR1l7eaDYDUJIst9IgK4mWkiyfci83nhYIHtVdAzz4wCp+I=
X-Google-Smtp-Source: AA6agR5Ta8MXnJI/hytLwtdKJ8JAQ5J4Lag6DbUAJPusFF9RbEBQ5CMeqvOtPdZQDmKjvpzR8hsUM2Q+uIVQLubhmYQ=
X-Received: by 2002:a05:6902:10ca:b0:671:3616:9147 with SMTP id
 w10-20020a05690210ca00b0067136169147mr2861930ybu.105.1661428789946; Thu, 25
 Aug 2022 04:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD2kMXHxvg1tKVNLhY0Gweq2YrD7+tHmZXKwguYzRQ1Qpg@mail.gmail.com>
 <20220823140630.159718-1-christian.couder@gmail.com> <xmqq4jy18q7h.fsf@gitster.g>
In-Reply-To: <xmqq4jy18q7h.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 25 Aug 2022 13:59:38 +0200
Message-ID: <CAP8UFD0EfhDo9ZMNSYp8YVHXJs6mYtSBs=hwoFZWWF3xZ0wjpg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: clarify whitespace rules for trailers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Maxwell Bernstein <tekk.nolagi@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2022 at 8:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > -When reading trailers, there can be whitespaces after the
> > -token, the separator and the value. There can also be whitespaces
> > -inside the token and the value. The value may be split over multiple lines with
> > -each subsequent line starting with whitespace, like the "folding" in RFC 822.
> > +When reading trailers, there can be no whitespace inside the token,
> > +and only one regular space or tab character between the token and the
> > +separator.
>
> That may have been the intent, but does it match the behaviour?
>
>         static ssize_t find_separator(const char *line, const char *separators)
>         {
>                 int whitespace_found = 0;
>                 const char *c;
>                 for (c = line; *c; c++) {
>                         if (strchr(separators, *c))
>                                 return c - line;
>                         if (!whitespace_found && (isalnum(*c) || *c == '-'))
>                                 continue;
>                         if (c != line && (*c == ' ' || *c == '\t')) {
>                                 whitespace_found = 1;
>                                 continue;
>                         }
>                         break;
>                 }
>                 return -1;
>         }
>
> When parsing "X  :", first we encounter 'X', we haven't seen
> whitespace, 'X' passes isalnum(), and we continue.  Then we
> encounter ' ', we haven't seen whitespace but it is neither isalnum
> or dash, so we go on without hitting the first continue.  We are not
> at the beginning of the line, we are seeing a space, so we remember
> the fact that we saw whitespace and continue.  Next we see another ' ',
> we do not hit the first continue, we are not at the beginning of the
> line, and we are looking at ' ', so we again continue.  Finally, we see
> ':' that is a separator and we return happily.
>
> The code seems to be allowing zero or more space/tab before the
> separator.

Yeah, I agree. I misread the code. I will send a new version soon.

Thanks.
