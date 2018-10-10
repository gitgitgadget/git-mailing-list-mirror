Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BEAA1F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 11:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeJJTDX (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 15:03:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40403 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbeJJTDX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 15:03:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id w67so4990906ota.7
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UQq+JjGx5FY+yHuzPwWmZqDqHe0aRRpKVv2wZwhQIzU=;
        b=vDYRxB8KsAlLEsZG0+lOWW/mPirxtdm5F3o0omsAvXcxe2nDSbFpeq5CZIOydnyaBP
         uK5apHTH4EG7HJotk9jCpbv91JBWIAvx4gV0HFw2mMhVNeA/XHT2atXZhV5Gzy81gR3S
         HXxAms9ZcXfjioBWy3Rk7Ysg0RYBX4dPhJLkl0WafmGc+3z+tI/F7k5b8/KHFnML5HFU
         +4gbpUyu37DIZ+cY2e4MkPvWzeoE2gOqrclf+as9iS+o9tbX6a8VNsGSxEPAodB+x6Xa
         UShmR6An9E099KZypzWuDPF1FuOym31Zzhz8cHZyuebxbgSDr/7s/k47bTo0nunZKbKc
         qrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UQq+JjGx5FY+yHuzPwWmZqDqHe0aRRpKVv2wZwhQIzU=;
        b=nleInkQ4Xe5KPyC8Kgds/zZDCjhJd8OzIKSI9MpdQU8DmaNeqCOHVd1RuzgeXFKVB2
         b4jSbZpwIzowekhcH/k89gA6weYG/HEj6t6Onf25HE8e3eApQbg7bQ0takhQ7YPi6YFQ
         aTCDOqAYWNfILyj5H1epWXN6kiA7g9ruqq3Vqdbga6KzNpZGf3r7vEwhjfym7TocnUo7
         dqxr6ZmYC0AqHSPdRX1TPFovFr2RfDpafOZcQ7ak3vV51FQ6q4dRQ1QKV+yj+RpdJi8V
         cXu2zLmHpw/2/fZWwKamxcxKDnEQ1vFvzAdvey3C/FUJEhBWOlCHpHPqN/So0R9Xq/TL
         3NEQ==
X-Gm-Message-State: ABuFfoiBGni1cUXARjHHvmzxeoSn4mfgYUJtbQTn/Xfh4EuptyOrBk8Y
        O6shJXu3DBg+SwjhjCnOq6UnrN+BIEVjgoTOs+A=
X-Google-Smtp-Source: ACcGV63SZgVG0RyuE67kCEjAVnIv3f/O6elw4jz+RknYlj87xzX1CQE6qjc7YXkkN9iTCF1jPQCqYWFiF8qi7NsHWnw=
X-Received: by 2002:a9d:30c2:: with SMTP id r2mr18807068otg.143.1539171697346;
 Wed, 10 Oct 2018 04:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com>
 <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com>
 <20181009234502.oxzfwirjcew2sxrm@dcvr> <xmqqd0sims6s.fsf@gitster-ct.c.googlers.com>
 <CACPiFCL0oTjN+-aYgKEDtKC0gYwkv6RLMwakdJV85PJ5XQej6g@mail.gmail.com> <878t36f3ed.fsf@evledraar.gmail.com>
In-Reply-To: <878t36f3ed.fsf@evledraar.gmail.com>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 10 Oct 2018 07:41:25 -0400
Message-ID: <CACPiFCKMF2di=waQ5reRtjUFEjuE6DkxxLcN-YnF-SqgE_m=_Q@mail.gmail.com>
Subject: Re: git svn clone/fetch hits issues with gc --auto
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, e@80x24.org,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 7:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> As Jeff's
> https://public-inbox.org/git/20180716175103.GB18636@sigill.intra.peff.net=
/
> and my https://public-inbox.org/git/878t69dgvx.fsf@evledraar.gmail.com/
> note it's a bit more complex than that.

Ok, my bad for not reading the whole thread :-) thanks for the kind explana=
tion.

>  - The warning is actionable, you can decide to up your expiration
>    policy.

A newbie-ish user shouldn't need to know git's internal store model
_and the nuances of its special cases_ got get through.


>  - We use this warning as a proxy for "let's not run for a day"

Oh, so _that's_ the trick with creating gc.log? I then understand the
idea of changing to exit 0.

But it's far from clear, and a clear _flag_, and not spitting again
the same warning, or differently-worded warning would be better.

"We won't try running gc, a recent run was deemed pointless until some
time passes. Nothing to worry about."

>  - This conflation of the user-visible warning and the policy is an
>    emergent effect of how the different gc pieces interact, which as I
>    note in the linked thread(s) sucks.

It sure does, and that aspect should be easy to fix...(?)

> So it's creating a lot of garbage during its cloning process that can
> just be immediately thrown away? What is it doing? Using the object
> store as a scratch pad for its own temporary state?

Yeah, thats suspicious and I don't know why. I've worked on other
importers and while those needed 'gc' to generate packs, they didn't
generate garbage objects. After gc, the repo was "clean".

cheers,



m
--=20
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
