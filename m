Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6639F1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 15:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753051AbdLMPiO (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 10:38:14 -0500
Received: from mail-ua0-f176.google.com ([209.85.217.176]:46200 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751975AbdLMPiN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 10:38:13 -0500
Received: by mail-ua0-f176.google.com with SMTP id t24so1827362uaa.13
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 07:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n2ojoldjuLfXVZRoTbGjloQioW2DLGPWwGoiw5wiiH0=;
        b=AhjmWhH9r39S87Cj3HMwI5/EeOfAUnX0qZKudT45lLPfXeOyunSVnp/73GswobCAXw
         CEuKYc2bo1Ua6yaM7jG1nIiFHd5ILdwtgBg9U6bHlEvp1sO4M9AMR6RQ9sYJgUKZ02cP
         paR7uv3DUkldyEtirk86Dw5ulfiLExes16dsRZOuvXa2lis8gXUNHhaYgmQv1MrZN+Ef
         oTTTLZt8Zq4aRmXkyudfUsmqi1e6z4bM16naBhO2CBq4W3AsaaLQ/KS5MtfBSgPy7AJk
         cPt+7yuvl/6vmOxG424+y6rRD9GwQ9x9r/wQ3C1+PZB84lQsJfPGzFQREJm/lu8KwiQr
         CLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n2ojoldjuLfXVZRoTbGjloQioW2DLGPWwGoiw5wiiH0=;
        b=smg/MBaim8Oea+0ORETAFFhQ/EVOdEw5cw8Bv1JsmKjtgThGUz/aZ5m5fD5P4dkW3e
         XfMxmx/0djEt/MD6Xzy4Cfe1PSBIYuZgLY3wlsw2bRfvYWzZFczItGmxCrnFddOo92On
         orFJjhYF+OrsnHkHTyr2XFTWU0HWKn8exBYkJPmTskfx1O17rlkiofp6mAv/Ng4i/DYn
         3dDHYGRyUVz03dG8bydk1LsGz0k6lR23jctc7XYBpiZIJIMPfa6c0YqXH6Jedwa8LZ2H
         ZjtAVgqltz2xvxDtXrRzCgJZWG6A7mWl5YdgeqlJyvQjwFYZhYCyEOQ5WW2CYpgRkPcu
         UCcw==
X-Gm-Message-State: AKGB3mKbJ11ecqlWFV57qjOm4BG+j4AS/T8xGItsIBGPnUUw5qFmaE+v
        iLS6jvOyNRT5wgphUzsEjAjOwDEiVWOhrCT9nFM=
X-Google-Smtp-Source: ACJfBotZDfj7z8pBNPyCU7P6RcLCAPkmOjg3hZV+9T9kP8dnJP9J3sCsECHhjGwzjvcQCMA/VcvKmi5XQ2aye6WaKQo=
X-Received: by 10.159.61.90 with SMTP id m26mr8355197uai.40.1513179492465;
 Wed, 13 Dec 2017 07:38:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Wed, 13 Dec 2017 07:38:11 -0800 (PST)
In-Reply-To: <CAPc5daU1b1sJPK37sjMKdr=xY5yg3qaHk9PPdgJ1JH9KvJxatQ@mail.gmail.com>
References: <20171129014237.32570-1-newren@gmail.com> <xmqqh8svxwpm.fsf@gitster.mtv.corp.google.com>
 <CAPc5daU1b1sJPK37sjMKdr=xY5yg3qaHk9PPdgJ1JH9KvJxatQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 13 Dec 2017 07:38:11 -0800
Message-ID: <CABPp-BG8rZtVarrfapWOzOhsS0-WnUS5g8cDZW0hLnUgQhNJ4A@mail.gmail.com>
Subject: Re: [PATCH v4 00/34] Add directory rename detection to git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 12, 2017 at 6:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> OK, it seems that I managed to make this test pass under poison build
> (see https://travis-ci.org/git/git/jobs/315658242)
>
> Please check https://github.com/git/git/commit/e5c5e24ad91a75b5a70c056fe6c6e3bfb55b56fc
> and sprinkle its fix to whichever original commits in the series that
> need fixing.

Will do; sorry for the problems.  Thanks for finding and fixing.
