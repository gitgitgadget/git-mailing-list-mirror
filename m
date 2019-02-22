Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256B81F453
	for <e@80x24.org>; Fri, 22 Feb 2019 07:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfBVHvR (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 02:51:17 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52713 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfBVHvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 02:51:16 -0500
Received: by mail-it1-f195.google.com with SMTP id r11so1773013itc.2
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 23:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gvk5/u3LfZ0qjJhzYEIF50SwsEKEej+Skz7+eawTJ54=;
        b=YRDii0CXJDifivPR9osaJr/81F503gx09CRU6CGh81v9Dd7at0rI22ZHu1Lu2P3BGb
         bLXyPqAeO87jLCLRwgWY9xKBPcAjrkvgcBLejyhWMjD4SpawpUedw6k/31uT4fs0Cn2C
         uK77slW1oy+mX0O88JKzS6Sgr1RFTlA5COvNCuU2W7jSjsSEJ8qRbdJnZDT+/JJcefL7
         fXkjaejqG00pzZrlBL1p78EbjH1nrAcAToB1Nqwu1sPyXaPicm1iMRu7m6anQYNLWcE4
         2EXSry+ZYIYz59SU1k1yq3gFiI5bEv5tZcn+1tB3bzaMXrrsCY0LD7khHKRAfE2v3mVc
         WzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvk5/u3LfZ0qjJhzYEIF50SwsEKEej+Skz7+eawTJ54=;
        b=cO4jRZo+P4KPkM6yKKlFSX6rcSNhn5O4w6MeAR0RJ9INYqFF4hmhOfJkXCUIhbb9ET
         nqAaeZCP9DKXpG5hqTb/CSj2dtCNfcO6HLW1R3YVgdxz/JmCoxfNAmgsB4gPg69qMAb7
         ce3hH0OWcjd45JbWLgJKW2czLur0ISJvDzgIho8YpWmbZX5BD2f/zO/ZhqCxBeqmskQY
         g5xFD52LM3MzI1jDxXIQLwjx0ZRTh64UDgLRCKMuPNrjUt0txrSwVMiNFkQaG+nqCWK0
         VgFfBOtX9umDTukrJSFkGcULUEzfQT6T+2fO1RdxU6zoPhy9EK9jS1rUeFTzqhGE9e08
         6wvg==
X-Gm-Message-State: AHQUAuYln3Aw6qgCCbCFDJigKvN+dFjUCkll4+F3UNfGYCtRnXJ41uJh
        twARlRqdE9fUjxQBoHmJhhwhg7jonn3TcFHgg5k=
X-Google-Smtp-Source: AHgI3IYz0CxBqX25JLfrUrRYxOT+m/ecAt0VrRYTd9qSXABKC80GE7bFDnfYy+NRezg39phru8waM1fGdxNw62/K+AM=
X-Received: by 2002:a24:c056:: with SMTP id u83mr1337288itf.10.1550821875835;
 Thu, 21 Feb 2019 23:51:15 -0800 (PST)
MIME-Version: 1.0
References: <xmqqlg28snv0.fsf@gitster-ct.c.googlers.com> <20190222062606.GD10248@sigill.intra.peff.net>
In-Reply-To: <20190222062606.GD10248@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 22 Feb 2019 14:50:49 +0700
Message-ID: <CACsJy8A1cqWkomePW8i6veNT+WP2nq_kAZHay74ZgZFsz-d+nw@mail.gmail.com>
Subject: Re: [PATCH] format-patch: notice failure to open cover letter for writing
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <junio@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 1:28 PM Jeff King <peff@peff.net> wrote:
> > diff --git a/builtin/log.c b/builtin/log.c
> > index 3e145fe502..43fc9a07df 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -1047,7 +1047,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
> >
> >       if (!use_stdout &&
> >           open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
> > -             return;
> > +             die(_("Failed to create cover-letter file"));
>
> I'd suggest s/F/f/ in the message to match our usual style, though I see
> this code has a lot of capitalized errors already. :)

Thanks! The lowercase wins over uppercase [1] 1517 to 327.
Unfortunately it's a tie in this file. But I think it's still good
that new messages stick to lowercase.

[1] counting error/warn/die only with

git grep 'die[_a-z]*(_("[A-Z]\|error[_a-z]*(_("[A-Z]\|warning[_a-z]*(_("[A-Z]'
-- \*.c
-- 
Duy
