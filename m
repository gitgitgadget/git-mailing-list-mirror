Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8168C1F46C
	for <e@80x24.org>; Thu,  9 Aug 2018 19:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeHIVxN (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 17:53:13 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39885 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeHIVxN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 17:53:13 -0400
Received: by mail-yw1-f67.google.com with SMTP id r184-v6so6116666ywg.6
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8Dx15MOomzOimcUuZw40syaptqA9Emgl9IjhnI5rhs=;
        b=mRZ9rLXqnrwpj5qwvq+669ihpSAOwmPromiemLDcc+iazs1Li3BS90+Ff6ZLpFb+qU
         KotvE9sV554nOcxhJcGJ69GcOM539+Jd44HJ/eE0uKGS1gNkq+Okukn5k/cs/NeRSQXf
         pqQn+sLuDRUo2IpNqVEcYfxp+Xdi1G2olFAq/Z5DKbFx4NcDelrKUJRoHFyQsHVIMrUp
         G+VeZ8ZYdKHs215l3BMzD5HZMnLmykajybwDT2GeHgzWnCfZAReZZwwY5ReZ+YUuXdKp
         CU1/1Yg0gJ5FAOJ+Pf2ipl36fNho48KCgHz7VlNor9N0oTuSySXGqkBGcfP6/X58vJi6
         yHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8Dx15MOomzOimcUuZw40syaptqA9Emgl9IjhnI5rhs=;
        b=VX3Ygky1fN8Gl+lSsTG2VAUk+rcB0ElGQjBVfVsTBx6pRCWDcd94G4bZ8CqH6BYXI7
         hX7PXkC4Sv5OEtVYJ2dbF0GZ1/gIDLSlXezmsqOHFrcbrXqWEajhRZtxzviW9fKHoZwT
         P4o3iE4eZ73jd6DleCbQhf1aDeekEJx2tSm99G5eNBNJnRrtAxhFhbn+TC6Tu5MvgPIy
         kegSkfTJAEfgMLzuju4YuIkWi8sPGqWsIam4PSRi0v5SWEXDoBTx2doE+fzmRPp3qdgC
         0KaQDK3VbJVhE1gTA1tL9IwR2LFYCJyB5KO1jx4caZx+qF+uD+w6UEx3q4my2igamRBA
         L7IQ==
X-Gm-Message-State: AOUpUlE8gLwoDYBLEi1zYqJtf2CkEF9jUwmtK4ZxQCjkRsgN0tmXIcXv
        sQ4NlYiVq56Dv9ajg17o6VQasqYIkHX7LTkpfjc=
X-Google-Smtp-Source: AA+uWPwSoF5ViKHnpL/pQ8tvcsLL95n0STu0N0+njoin5LS95didF0GS9B084ucurfL4QlWlIFlhiqRKx12ScOHNmjM=
X-Received: by 2002:a1f:a0d6:: with SMTP id j205-v6mr2219442vke.23.1533842816944;
 Thu, 09 Aug 2018 12:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BHxJyWsAQ3FkfdC-5Vqe3d7wWZm-hVYd0-afNY9dEgMeQ@mail.gmail.com>
 <20180806224547.8619-1-newren@gmail.com> <20180806224547.8619-2-newren@gmail.com>
 <xmqqbmabcuhf.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbmabcuhf.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Aug 2018 12:26:44 -0700
Message-ID: <CABPp-BH8oiJ17K6OHCikAxk8Jy9M7mSA=WCVX9KosTC+p4rE4w@mail.gmail.com>
Subject: Re: [RFC/WIP PATCH 1/1] merge-recursive: make file/directory
 conflicts easier to resolve
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 9, 2018 at 10:36 AM Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> > File/directory conflicts are somewhat difficult to resolve; by way of
> > contrast, renames are much easier to handle.  For file/directory
> > conflicts, we already have to record the file under a different name in
> > the working copy due to the directory being in the way; if we also record
> > the file under a different name in the index then it simplifies matters
> > for the user, and ensures that 'git reset --hard' and 'git merge --abort'
> > will clean up files created by the merge operation.
>
> Yeah, and then our file "path" renamed to "path~2" to make room for
> directory "path" they introduced, can be relocated to its final
> place in the merge resolution, e.g. "git mv path~2 path/ours" or
> "git mv path path.theirs && git mv path~2 path".

Yes.  :-)

> Of course, "git rm" and "git mv" must work sensibly, if we want this
> change to be truly helpful--but if not, they need to be fixed ;-)

That actually brings up an interesting question.  Right now, if given
a path that appears in the index but at a stage greater than 0, git mv
will fail with "not under version control".  Obviously, that error
message is a lie in such a case, but what should it do?  Print a more
accurate error message ("Refusing to rename file until you remove
conflicts and git add it"?)  Or, what I'd prefer, rename the entry (or
entries) and keep the higher stage number(s) -- is there an unseen
danger with doing this?

(Alternatively, if there is only one entry with stage greater than 0
and it has no other conflicts, one could envision git mv doing the
rename and dropping to stage 0 at the same time, but that sounds a bit
dangerous to me.)
