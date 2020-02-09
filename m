Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F20C2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 21:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475702080C
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 21:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBIVKB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 9 Feb 2020 16:10:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43247 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgBIVKA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 16:10:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id r11so1846675wrq.10
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 13:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TDCSG6kcA6lmRsHLPGuYtCFKQtI+uDT/3NkMBOKY9HQ=;
        b=UznmWFXwsRzfYSGdTB9t8jxA+GE2sgNNjf2i067le0NeJ1IPQwIon9RzRAuFSMFePx
         eHMIargQKmsJkPh708nVor7l+zSHdrM3e1HNwNhEtctQyVVBpDOrynTIrAS44lTLaWhI
         nYSZ2astydx9/dHZzsL+1nVS/JfJv5kpMlOIEQxXHbBgWXJOqgPCXqBdXZla+pyxpzm9
         QDDlZmW/Ekqb+/4PZr2W1z/3w6dmSMdufVqoZvltF7m7PFNd6VHS4QVpz2cM6yfmCyJ9
         WXX3VDc1VEhAe9SbyoG3tvzkuvFfTIV5GDf7VPRMQP7UjhRCi9MGrJfDYEKA+HYsOcMh
         R3rw==
X-Gm-Message-State: APjAAAVFk0WpPkvMvLqtovWnEsVfxLIhY9og6D5uRervJHXQY2F6Meea
        kucpDk7IMRBwekKIajAtSsrKy84QJsR4yQnqKMk=
X-Google-Smtp-Source: APXvYqzTUvwrTUf4qfmLiic5SFLK4KBtV4Fj7NvswqzaDdY1sUSHix5i+8eG9kKv3wZX9xf7xrAYrBicYuQCMOfyMNQ=
X-Received: by 2002:a5d:4a0f:: with SMTP id m15mr12617842wrq.415.1581282598681;
 Sun, 09 Feb 2020 13:09:58 -0800 (PST)
MIME-Version: 1.0
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de> <b31c46a8-380b-3528-27a5-a2dddacaf837@web.de>
 <CAPig+cQdJ0NJSWZN-2ckeLB7RfU9GZ7LGvVX4y+Q1daPnW8WsA@mail.gmail.com> <60b491a1-2b71-d5a5-398f-e6743e2c617a@web.de>
In-Reply-To: <60b491a1-2b71-d5a5-398f-e6743e2c617a@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 9 Feb 2020 16:09:47 -0500
Message-ID: <CAPig+cQCwxopnwC+VYgS39QpaSW10JWW4HZGYzeq+psvB1bLMA@mail.gmail.com>
Subject: Re: [PATCH v2] strbuf: add and use strbuf_insertstr()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 9, 2020 at 1:28 PM René Scharfe <l.s.r@web.de> wrote:
> Am 09.02.20 um 18:36 schrieb Eric Sunshine:
> > Digging deeper, though, I have to wonder why this bothers inserting
> > "Content-Type: " at all. [...]
>
> Do you care to send a follow-up patch (or one against master if you're
> not convinced by my reasoning given above)?

It's unlikely I will get to it any time soon. I'm still sitting on
unfinished patches I started 1.5 years ago and have a queue of "git
worktree"-related tasks on my To-Do list.
