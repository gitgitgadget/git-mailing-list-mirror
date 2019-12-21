Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76232C2D0C0
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 10:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115582072B
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 10:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="RdI1IEfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfLUKTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 05:19:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38271 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLUKTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 05:19:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so11773285wrh.5
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 02:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ts/pXBciwikOTwSdFZcpXJV1OQ1/UH8j0hSIK9ArHhk=;
        b=RdI1IEfjZXpeHAI+Lf4R8Ih+X7fEl62qTj1PGQpAtSKvAE4K2pMCQx4YnVtYDv8zMt
         eBuGn/KbjMHrGtX3dMqO1uuxbvpYF001pimiBOg+LKhjVCoMh8H/jNhDUFGgqstq3CpG
         Vt+O1ZlnSZdp6kIskmW2YbcOlWV7t4YNq5Rw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ts/pXBciwikOTwSdFZcpXJV1OQ1/UH8j0hSIK9ArHhk=;
        b=L4Mr10zkJk//yEBiX8lXsQMGjPOH7vGOzaZCTwIMNB5BAQBNAfOI3E1ijv6Khr2bQ5
         sNy8kLC4wooWaCPEj5Dxbd7LWRf6a6OdyvUYg9+I9U+uILFymv2MvKa3hiz8m/6UfMr8
         MPZfPjQIBRCZgZb19u54/b5DmMsJBHXCLuG8C+AteifiScCTMLGAtNVo4kGy+6ZkxE2R
         SoE8Qa4D9fZO+rtJKrN7O2aC5Ncu0ZuaXEsThYr59QEKm1wK0GkhkM57i2dUXuIEbttz
         rYVYv72ZZOA1EEmrnuXJj7UjOW2s7ipCu9FRqv5eMnpwszokjJnO3EN+wGrI+NRW896K
         8Ung==
X-Gm-Message-State: APjAAAWWC3EX0MPJfgRd5f2PCqWlaNsxybd0tgr5wCDWjIyikd/vd75A
        dHu6G9ZEkGi6Ksiwt4Xja3b9yr6j4+HXU5mhYz7Ctg==
X-Google-Smtp-Source: APXvYqwznuikDNJ9zPLXy8aA4EAndUJp0UAQdejtEYxIfEdZaOp5b0BznvVyyMiDZ7d7+gbnAKpsTvrJH40kupn6h8g=
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr20891083wru.318.1576923554194;
 Sat, 21 Dec 2019 02:19:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
 <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com> <xmqq8sncj991.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8sncj991.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 21 Dec 2019 10:19:03 +0000
Message-ID: <CAE5ih7-ptmmb2UurBw+k+2ZjZQuOkLJ3c-eBoOXKrPX0CJeErA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] git-p4: Usability enhancements
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>, Ben Keene <seraphire@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 16 Dec 2019 at 20:39, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Some user interaction with git-p4 is not as user-friendly as the rest of the
> > ...
> >
> > Ben Keene (4):
> >   git-p4: yes/no prompts should sanitize user text
> >   git-p4: show detailed help when parsing options fail
> >   git-p4: wrap patchRCSKeywords test to revert changes on failure
> >   git-p4: failure because of RCS keywords should show help
>
> The reviews on the list seem to be in favor of these and I didn't
> see much wrong (I think I fixed up an indented empty line) in the
> series.  I'd appreciate a blessing from a git-p4 expert, though.
>

$ git log --reverse --oneline --abbrev-commit
origin/maint..origin/bk/p4-misc-usability
e2aed5fd5b git-p4: yes/no prompts should sanitize user text
   - looks good to me

608e380502 git-p4: show detailed help when parsing options fail
   - also looks good to me

c4dc935311 git-p4: wrap patchRCSKeywords test to revert changes on failure
   - why not just catch the exception, and then drop out of the "if-"
condition and fall into the cleanup section at the bottom of that
function (line 1976)? As it stands, this is duplicating the cleanup
code now.

89c88c0ecf (origin/bk/p4-misc-usability) git-p4: failure because of
RCS keywords should show help
  - strictly speaking, the code does not actually check if there *are*
any RCS keywords, it just checks if the filetype means that RCS kws
*would* be expanded *if* they were present. The conflict might be just
because....there's a conflict. As it stands this will be giving
misleading advice. I would get it to check to see if there really are
any RCS keywords in the file.

> Thanks.
