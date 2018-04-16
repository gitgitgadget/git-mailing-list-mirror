Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6711F404
	for <e@80x24.org>; Mon, 16 Apr 2018 02:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDPCD0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 22:03:26 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:41946 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeDPCDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 22:03:25 -0400
Received: by mail-io0-f182.google.com with SMTP id r69so9966657iod.8
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 19:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PaKsyJ/AQ+Jqvuy8AGZosReCo0zG1i5YFFwQWj4OgP8=;
        b=RGv07tqiDNzZv6YIEfGBUX4xmMvcGViZKgtTaxAQ8kJNPm5mq1CyzWdc4blUH8CH8p
         CmjN+J+ppVUxi5nPhUdfVd9z5BpMX/+3N4y9tmWTcMsehL/wkPkGcUcrVEf9/3LolOAn
         R5M4OaMiEVC3bJnU9y6xVN5GovP+8payCrlrNUfb2DGhJXS6sF+uo1aY6MINxJY/Hwvr
         Zy4dxtNlkozK6r8ehLnYIbHIa9aUY/R4IBQW0jLQrhjEmoSkSjopAU7Xj8kVpcnaHceM
         RA1kTJg54qXkAeN24g5Yh4oEtRKBpi0sVABvS0UWybkcCbMKVLs2JQpcY/8OlXN7rKnm
         k6IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PaKsyJ/AQ+Jqvuy8AGZosReCo0zG1i5YFFwQWj4OgP8=;
        b=T1qS+WzBBL6qqNQtCXS6jzSsUnru1Pso5TLiHDhHAcLMfCtsMZX8EFHUVeY4DeMbMi
         GGIqFfi0G4/aKyXFPLKaDZCgtXFga9R4EydkOE3E5vswmTbh+psuUzeOMmyeTuEaaLKc
         FhWUWSRkLhPidOGSlFT0cD3WOyvJ6oEH7TEyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PaKsyJ/AQ+Jqvuy8AGZosReCo0zG1i5YFFwQWj4OgP8=;
        b=SKbUGZpdXSsdNKVq30No5fZstO1HXv5BTrs0yPoRIsz+0l5UHxHp1bT7M5zVexMy3t
         fGp5fzIMPGuILAek9uzWtP3mYB/PLpk3S9hHdip9LlQv0DQzIIQEXxZ9nQ2OyyRsM5/5
         h3KnlNIAp5EAaFPdXD6MXOT2SFy9W5dYz/aFBqkNBMcyPCLIwWCc8H94JnA2d9uL3N3C
         PIZakeVyj+IqGqtwqBLQGNKUdnF9CRewhe8v2KPdViA5PIJPPLZvTgplGM1eecp69Z5h
         x3zeFq13qK4Nxm+Eo7OScvqSODKQ1TEcNPjlwJ0wNc5wbaBiQdZdxmpkdMI9j7wLGugt
         rxxQ==
X-Gm-Message-State: ALQs6tBucAYSB087XF4mIazMp7T1PK6s4Nbik4FIvVdw5zyBQn6ufq2I
        HFIxwk6z9HJBJN59og4qSt82QL5sJ4KG6N58D6M=
X-Google-Smtp-Source: AIpwx4+HBS6m/55fcn9Eow4DZaONQJUHsFB8vWJYucb+fjaVEHxpAZtNhewoU0WxdGrYgQxBfjcdgJDPLZh7g2TyZCc=
X-Received: by 10.107.47.215 with SMTP id v84mr7050894iov.48.1523844205041;
 Sun, 15 Apr 2018 19:03:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Sun, 15 Apr 2018 19:03:24 -0700 (PDT)
In-Reply-To: <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
 <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
 <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
 <CA+55aFwwVZDetd-SobOzzLQW4_GEwm3krxEGR+cpqzkzK-yiwQ@mail.gmail.com>
 <CABPp-BHQsOSCJiPU9Ku5b67QTkAjnEBrhx04mTXf2QdPBriHmw@mail.gmail.com>
 <CA+55aFwi9pTAJT_qtv=vHLgu=B1fdXBoD96i8Y5xnbS=zrfSzg@mail.gmail.com> <xmqqbmekylgc.fsf@gitster-ct.c.googlers.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Apr 2018 19:03:24 -0700
X-Google-Sender-Auth: 16UuelDsp6HJvEkOTwILDObnLus
Message-ID: <CA+55aFxP8j7YbYaRXt-8Y0n8cHafB=FPKMy8gKFYH5QsKX4S=Q@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 15, 2018 at 6:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I think Elijah's corrected was_tracked() also does not care "has
> this been renamed".

I'm perfectly happy with the slightly smarter patches. My patch was
really just an RFC and because I had tried it out.

> One thing that makes me curious is what happens (and what we want to
> happen) when such a "we already have the changes the side branch
> tries to bring in" path has local (i.e. not yet in the index)
> changes.  For a dirty file that trivially merges (e.g. a path we
> modified since our histories forked, while the other side didn't do
> anything, has local changes in the working tree), we try hard to
> make the merge succeed while keeping the local changes, and we
> should be able to do the same in this case, too.

I think it might be nice, but probably not really worth it.

I find the "you can merge even if some files are dirty" to be really
convenient, because I often keep stupid test patches in my tree that I
may not even intend to commit, and I then use the same tree for
merging.

For example, I sometimes end up editing the Makefile for the release
version early, but I won't *commit* that until I actually cut the
release. But if I pull some branch that has also changed the Makefile,
it's not worth any complexity to try to be nice about the dirty state.

If it's a file that actually *has* been changed in the branch I'm
merging, and I'm more than happy to just stage the patch (or throw it
away - I think it's about 50:50 for me).

So I don't think it's a big deal, and I'd rather have the merge fail
very early with "that file has seen changes in the branch you are
merging" than add any real complexity to the merge logic.

                Linus
