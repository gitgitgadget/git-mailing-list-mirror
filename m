Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7E7C001DF
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 21:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjGMVyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGMVyK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 17:54:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ADB1FEE
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:54:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cad564b45e1so1019109276.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 14:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689285249; x=1691877249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yewYCxklCLdSqRR2Ec/5IB9hNiv5YSntsHhU1OEwmAA=;
        b=u22HpqhpRLA5wNh2PufL3V9q2c+SljyY3i6OEUVJkrw9ypE23VKUeGodZQER050Aq5
         Wj5p6KfQi5ON2bisFlEZW9l9S+qkdWk2LMWMxfzgm+YkkW1fHKzGjOOGWZA4pyNOdMFp
         Ju/18g2XXknBpbs86/d787vNryfgLUm91Mzo+k3ds9PPsuVKyvINLNfwknzcX8WvGtki
         1+EXzKJlasXHF5400lwSPoxEE++MZHtenj5nB1cwFhNxIDhMx82Dmguf3hA2z5DEZFkA
         ccb23P7YxHN+kfvBWilN1JT5/DkfFYEy7CVd6rSFtZswvQlj9NxuohWj3BNfMK3Vp72m
         G6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689285249; x=1691877249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yewYCxklCLdSqRR2Ec/5IB9hNiv5YSntsHhU1OEwmAA=;
        b=TVqM1x7Ahnf0lE9IOKw7TqXwEYhiTfYNMbK9jRHu4i6973lqStcklIMyn9BaZhjDCt
         QhkbFKHvSc97NWHBJEDVhqQYwKJJwKZvh+qKoGTON2b3qHyisP/mJ1uBXZUwir+xx+v3
         BNoIez+JqRkjN6GLh9uJfIm9Bpq3KV0w5egVnSvuvFLX187riVePVI+81UCsfK+J9KPN
         pjD/eW8uurj+JfMEVcCfAORIDRDJa9IEJGu8Tz6XKP19vn9CzuQEUD0dNXeTS45Ob11E
         BneWPE1BrBgKFJwakw6Xw4FAC005UbFRarbMXbfrkJcZKiJIYSJHtSBAy9WTZwtTpqoc
         DMEw==
X-Gm-Message-State: ABy/qLa8ISEgk/qHKdYp55XBzWBPskJ/LOw1vGaivy0rnhzfiXmejP3t
        3xHM47+EFUpAKO0GhZnORaKBRADYOx8=
X-Google-Smtp-Source: APBJJlH+GDK7Bm3OBpXSNyIE17IF11BBAAqbWxdD6jXfhrWLrw9dgLD1ecL9RV7Svs57GaSKbsb+ANmfNOo=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:216:0:b0:cb1:918b:d19b with SMTP id
 22-20020a250216000000b00cb1918bd19bmr17106ybc.0.1689285248985; Thu, 13 Jul
 2023 14:54:08 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:54:07 -0700
In-Reply-To: <xmqqa5w76jig.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
 <55bed55cb8859ac7b5b4f464232258f410b4d202.1688778359.git.gitgitgadget@gmail.com>
 <xmqqa5w76jig.fsf@gitster.g>
Message-ID: <owly351rh400.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 4/5] SubmittingPatches: remove confusing guidance about
 base branches
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> For these reasons, remove the guidance _without_ preserving the meaning
>> of the underlying principle, and instead add an overview of the four
>> named branches.
>
> Meaning that this rewrites the guidance

Yes.

> and changes the meaning of the underlying principle?

Hmm, no. I think I should have written in my commit message instead:

--8<---------------cut here---------------start------------->8---
For these reasons, remove the guidance while still preserving the
meaning of the underlying principle by adding an overview of the four
named branches.
--8<---------------cut here---------------end--------------->8---

However, I now think deleting the "base your work on the oldest branch
that your change is relevant to" text was unnecessarily harsh. I think I
can reword it to make it sound less contrary to the accompanying bullet
points.

Will update in v2.

>> -In general, always base your work on the oldest branch that your
>> -change is relevant to.
>> +The following branches are the typical starting points for new work:
>> +
>> +* maint
>> +* master
>> +* next
>> +* seen
>> +
>> +These branches are explained in detail in linkgit:gitworkflows[7].
>> +Choose the appropriate branch depending on the following scenarios:
>
> Please never suggest to build anything on 'next' or 'seen'.  They
> are inappropriate to base your work on, if your topic wants to have
> a realistic chance to graduate to 'master'.

I only included "next" and "seen" here just below "maint" and "master"
because they were included as OK-places to start new work (albeit in
exceptional cases) in one of the bullet points:

--8<---------------cut here---------------start------------->8---
* In the exceptional case that a new feature depends on several topics
  not in `master`, start working on `next` or `seen` privately and
  send out patches only for discussion. Once your new feature starts
  to stabilize, you would have to rebase it (see the "depends on other
  topics" above).
--8<---------------cut here---------------end--------------->8---

> If you are making tree-wide changes, while somebody else is also
> making another tree-wide changes, your topic may have severe overlap
> with the other person's topic.  In which case, you may be tempted to
> build on 'next' that has the other person's topic, but doing so would
> mean you'll not just depend on the other topic, but with all the
> other topics that are already in 'next'.

Good point. I will include this tip in v2 (seems like
something that would be especially helpful for newer contributors).

> That would make the basic choices simpler.
>
>  * If you are fixing bugs in the released version, build on 'maint'
>    (which may mean you have to fix things without using new API
>    features on the cutting edge that recently appeared in 'master'
>    but were not available in the released version).
>
>  * If you are adding new features, build on 'master'.
>
> Under exceptional circumstances that you need to depend on a
> selected few topics that are already in 'next' but not in 'master',
> you may want to fork your base-branch from 'master', merge these
> selected few topics to it, and call that your base-branch (which
> nobody else has).  And then you build on top of it.  When sending
> patches out, because your synthetic base-branch is something only
> you have, you'd need to communicate how you created it in your cover
> letter to allow others to recreate it.

I strongly agree that this is simpler. One thing I would change is to
use a phrase like "start your work" instead of the word "build" because
the latter on quick glance could be misinterpreted as literally building
(compiling/packaging) the project.

Will incorporate in v2 (thank you for the suggestion; will credit you in
a "Helped-by: ..." trailer).
