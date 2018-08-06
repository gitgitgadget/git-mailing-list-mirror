Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63F44208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 08:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeHFKwR (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 06:52:17 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53459 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHFKwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 06:52:16 -0400
Received: by mail-it0-f68.google.com with SMTP id 72-v6so16350256itw.3
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 01:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pYERaGwKXqgP/hok1L/sSFWnTqeIa2WXai347+Fy4w0=;
        b=X0iYGLPZ8K5lovUlJed+q+y0xtX3z6YKDJEUIaHUPJnlHanivw/TSPjiMLLxEqy8H6
         cr3rIClliC6u75ZVkm1OhQ+RNyeDKz1GzVuIXd/A/YDZVLie09TMcqQtFuKnt0k0bRU8
         CSKQL6VTBu7H2MuS9ubXJyUfE/1b3yRa0dv1OLeZetRJRmfrwpFX8lXLnqGVmIO4lver
         P42MiCq7jWZ6FHETjy6kjTfVKvyMgghSh/ESGlKuHbQlDVf6/DsLIcb9379hzvF1aTWc
         5tcKdxtiif+kevdXgAN+9L8dlkXQprsPJGU8maR6yKWtvui+jVqJnlwdlQglqbJtZL2w
         Ae6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pYERaGwKXqgP/hok1L/sSFWnTqeIa2WXai347+Fy4w0=;
        b=pARV42k+5FmPNxpdi0aKD25Q8rvM+DVul8rkPPbmH+CxN2uCQYtaXGjzvOHpF+yMmo
         2wfZrkRoSJWzXkslxbxnbLi0yK/P2Z8TbBlbu3KJpltSMkpFGM+9eZtRAtQ7gUdvYmNw
         Wb27Y4L9Ic1aWfy4q6LcuSiHMQTViOU4V4Xf5BsaK72YjXeny65ppbiKKLjY2B7VmZtD
         TpszZ4PYEEm9m0TXIGFlClmXP2KKehY67hhxgBLxoPn60QTXIzDK18hAubaYCTbKxp8z
         l5P5AWeVSzGDM9nqr4ZxUEVuOG5wLoRE92Gfu1L46tKdg8cSxFWt6sHXh9XcbvASRB6i
         10Ow==
X-Gm-Message-State: AOUpUlEA22lbyUnEXhFU2Ek31Kk/jO8rF9dmqxrVPxIwxID5UQaIZgB5
        Vz6MQpIr0i1H/goUtBwF779um6imq3k2Non8DeZk9kyP
X-Google-Smtp-Source: AAOMgpc/WA91s+ykce2dUZVQHaQSxg0Pm7SzukcnoyNIeaTxOWOYD/iIRGYdSoabcmugZZ+k1dHwvpq7L7hA2NKcxys=
X-Received: by 2002:a02:6016:: with SMTP id i22-v6mr12409483jac.8.1533545055256;
 Mon, 06 Aug 2018 01:44:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 01:44:14 -0700 (PDT)
In-Reply-To: <CAP8UFD2Ri6N33UhZSHOvxtxiCBC13-1rpa_ZByY9dsyPjmaC8A@mail.gmail.com>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-4-chriscool@tuxfamily.org> <xmqqk1pkzhuo.fsf@gitster-ct.c.googlers.com>
 <xmqqfu08zhh7.fsf@gitster-ct.c.googlers.com> <CAP8UFD2Ri6N33UhZSHOvxtxiCBC13-1rpa_ZByY9dsyPjmaC8A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 6 Aug 2018 10:44:14 +0200
Message-ID: <CAP8UFD3uruf94d7eV9Fy25h19y_KV8uZeaZN71F_xFM2XrspWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] pack-objects: add delta-islands support
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 5, 2018 at 7:40 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Jul 24, 2018 at 7:11 PM, Junio C Hamano <gitster@pobox.com> wrote:

> This is the new documentation:
>
> -> Refs are grouped into islands based on their "names", and two regexes
> -> that produce the same name are considered to be in the same
> -> island. The names are computed from the regexes by concatenating any
> -> capture groups from the regex, with a '-' dash in between. (And if
> -> there are no capture groups, then the name is the empty string, as in
> -> the above example.) This allows you to create arbitrary numbers of
> -> islands. Only up to 7 such capture groups are supported though.
>
> I added the last sentence above, but I wonder if it is 7 or 8.

Actually after reading the man page again, it looks like the first
element in the array we pass is used for "the entire regular
expression's match addresses", so we only get 7 capture groups (not
8).

> The code is the following:
>
> -> static int find_island_for_ref(const char *refname, const struct
> object_id *oid,
> ->                    int flags, void *data)
> -> {
> ->     int i, m;
> ->     regmatch_t matches[8];
> ->     struct strbuf island_name = STRBUF_INIT;
> ->
> ->     /* walk backwards to get last-one-wins ordering */
> ->     for (i = island_regexes_nr - 1; i >= 0; i--) {
> ->         if (!regexec(&island_regexes[i], refname,
> ->                  ARRAY_SIZE(matches), matches, 0))
> ->             break;
> ->     }
>
> I also wonder if the above is enough to diagnose end-user input when
> it requires more captures than we support. A quick look at the man
> page of the regex functions wasn't enough to enlighten me. Any input
> on these issues is very welcome!

Taking a look at how we use regexec() in our code base, it looks like
it might be better to use regexec_buf() defined in
"git-compat-util.h".

I am not completely sure about that because apply.c has:

    status = regexec(stamp, timestamp, ARRAY_SIZE(m), m, 0);
    if (status) {
        if (status != REG_NOMATCH)
            warning(_("regexec returned %d for input: %s"),
                status, timestamp);
        return 0;
    }

Though the above uses a regex that is defined in apply.c. The regex
doesn't come from the config file.

Actually except the above there is a mix of regexec() and
regexec_buf() in our code base, which are used with only 0, 1 or 2
capture groups, so it is not very clear what should be used.

And anyway I still don't see how we could diagnose when the end user
input requires more captures than we support.
