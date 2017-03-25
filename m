Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031991FC19
	for <e@80x24.org>; Sat, 25 Mar 2017 01:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935775AbdCYBCm (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 21:02:42 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33774 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936140AbdCYBCl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 21:02:41 -0400
Received: by mail-lf0-f54.google.com with SMTP id h125so1914801lfe.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 18:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FUFLxEVJdZqTS3csJaNQD+JXJl5Nq0W4T82XfXUnU/s=;
        b=p6LTua50n5AYToYHJLe4iuWK96QpHj0qacummeQmT9UhDZuE2Jx9I3e1W6bonp8jHg
         S87wu2hvoZrqE7UIz9BCVcObDT0x0bTLjpE2L70PWDAqGkltGXMOaMcMKMOScDOJO/Uq
         sbOdoV0KjUZ37d6umYChN62jyecu0CDY5uOTCT/6hIIrDSmOXwAQTfWylpVX4f8FMxxn
         HfF8vGPx3EM/NCUR3J9Mt5nLwc1WJC7wP9z+JaVmwJ/i5kdCWOgk3Yvw5tF1Q9DqG8M+
         mW/26Y0G9OsFxwnSpg/8m6xwJtMB7/C0qd1Aj7xm8f2fBZwEb3QpeJ6TooTawap3iutR
         ErEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FUFLxEVJdZqTS3csJaNQD+JXJl5Nq0W4T82XfXUnU/s=;
        b=mT2CvCEF8Ef/LpwvVsradVuzSWN+Q1t/ifOJHfLtoImTJjRwk1kQ66vKb2dtmbMWBr
         b/mH8xCoTX8prkGzyQE6D2yIxm/u6MSZBoCBndVLPXf6Am66dG5/BYsZNYbMyr9XzIJn
         JmbdK42wC3dmnmBawF1DwiU+THbmr4Ttqsc8sWGfYZb+bxsdXsuHkxv8xsS+m2tqumVc
         qWb/VC/zzr0HD8nYCGiAfMSqZEW26s8Ng2Ib1GcX0IPTpS96S2zL7TG9CKyrahRVb93Z
         dGvI4kM0905lQ/1DJcfSS11pNDdTX7zm7qpFRqHxGx/gV1GB7chH+AN5twyRsyf33tsJ
         GzGg==
X-Gm-Message-State: AFeK/H3aNkCNhLe1/1YZkoihZHo9Cplttl2Gf1GPL7xNOF2MLPoA6AMm4v7B6rOmHgeSOZycPGm7mFh2ha3FpQ==
X-Received: by 10.25.219.213 with SMTP id t82mr5400611lfi.75.1490403759143;
 Fri, 24 Mar 2017 18:02:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.18.73 with HTTP; Fri, 24 Mar 2017 18:02:08 -0700 (PDT)
In-Reply-To: <CAEA2_RLZztaRwcppwS45XfXO1n_VKw5547uScOhQON=ktttW8g@mail.gmail.com>
References: <1490328420-75901-1-git-send-email-bnmvco@gmail.com>
 <CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com> <CAEA2_RLZztaRwcppwS45XfXO1n_VKw5547uScOhQON=ktttW8g@mail.gmail.com>
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Fri, 24 Mar 2017 22:02:08 -0300
Message-ID: <CAEA2_RJ6OjLjS5yGjvd+S0iH+Zv0Zs6StGMv3_9ON6hVzD-85A@mail.gmail.com>
Subject: Re: [PATCH] [GSoC] remove_subtree(): reimplement using iterators
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Fri, Mar 24, 2017 at 2:02 PM, Stefan Beller <sbeller@google.com> wrote=
:

> Welcome to the Git community!

Thank you!

> Please use a more imperative style. (e.g. s/Uses/Use/ ...
> s/and simplfying/which simplifies/)

Thank you. Will do in a second version of this patch.

> Thanks for this link. It gives good context for reviewing the change,
> but it will not be good context to record as a commit message.
> (When someone looks at a commit message later on, they are usually trying
> to figure out what the author was thinking; if there were any special cas=
es to
> be thought about. Was performance on the authors mind? etc)

> So I propose to put the link into the more informal section if a
> reroll is needed.

Perfect. I will remove it from the message.

> Instead of constructing the path again here based on relative path
> and the path parameter, I wonder if we could use
>
>     if (unlink(diter->path))
>         ..
>
> here? Then we would not need the strbuf at all?

Yes, we can! Thank you for the pointer. Will be in the next version of the
patch.

> Also we'd need to handle (empty) directories differently for removal?

From what I've tested, we do not need to do it.

> Do we need to check the return code of dir_iterator_advance
> for ITER_ERROR as well?

I believe not =E2=80=93 it only tries to perform an operation if we have IT=
ER_OK. Since
ITER_ERROR would end up in a no-op anyway I don't see how a check for it
would be useful.

>
>
> >         }
> > -       closedir(dir);
> > +
> >         if (rmdir(path->buf))
> >                 die_errno("cannot rmdir '%s'", path->buf);
>
> This would remove the "top level" directory as given by path.
> When reading the dir-iterator code, I am not sure if this is
> also part of the yield in dir_iterator_advance.

I've tested it, and it does not yield in there.

Thank you for the advice, and as stated, will submit a v2 of the patch
in short notice.

Thank you,
Daniel.
