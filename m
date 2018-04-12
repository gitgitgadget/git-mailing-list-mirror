Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB2C1F404
	for <e@80x24.org>; Thu, 12 Apr 2018 23:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbeDLXzz (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 19:55:55 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:37077 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753296AbeDLXzy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 19:55:54 -0400
Received: by mail-it0-f41.google.com with SMTP id 71-v6so1107091ith.2
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 16:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=C3eaHNfej2xzWK5P0u6C6anCOcduKqOmcoTxf5PZVVo=;
        b=ujoXEQ1b3GpFS11J0v3IQg6Vg0a98/BXDQqqOFiQiL3dH27mS++jbaGkHXBP4cstKz
         reX11y7OONYHmOWykHiDnF0lSh8eZbIcz12qzG3Tc6AMAqAoQR4VreCZA5m3j+ZiyMGO
         scLRG/RTbLpGsQTTJF+TvvYZP11g8ZhUmr7wZezy6LJqIG3uou/fX9L1nn1p+MbRRNFv
         wck/P/fmr8rgLtvey349qmOcOGICxu7x4CkQ++5FPfaNvGjL12S0YZPzjz6qBQcL+dan
         ypyWWvfNtVCggNQlYIiMiYURvWz494G7IruDd9VrIORDSXwedOQb1qICAbDxsm7pySdu
         oFUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=C3eaHNfej2xzWK5P0u6C6anCOcduKqOmcoTxf5PZVVo=;
        b=fxcTHv4Hi8HmLJ7R51SaDvtUO6WnfltazflcMNUuiQ2bFW2BAS8GMGBQlyV/QI/xT8
         imFVj/R8G+pQQk0JAV3ccAIKUFrZoWvqviL7X38G7Lnfw8eeYUnlhQrLUw2OVTYw9FEZ
         QsJM4Evk8Ey15tofkhfvsB42keeS2LDUxx/Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=C3eaHNfej2xzWK5P0u6C6anCOcduKqOmcoTxf5PZVVo=;
        b=q6SvBV5YQvxlMTPRQ/83MWS4v3ic7BB1zvdO4DWcn8RvAt8KjriPAG0c2EzqOD9Rt4
         4QypwoE0k89X3ukzFOvF2jd5n0iOnVDWtx9Ggi+lIIAHZMU1hXFBYK4jSvWaOvQTAZhR
         rzuVgmHpeXvyekUQtZnB3KJw62v2a+RiFzIupQIh99LzAd3bwWKMQPorjUzi7mKmT7zU
         mmOx+nXP8rwkjzwwX4M/1m+WqRdTvZDwbZwLvo8knDafSSkayicixGjlnMiPGYbjPy28
         k1FErHnu33NOG33X/1S4rmg2UtltS6IRVTKQLCAv+HZXaBvgLRWKPyXQmoI9seG/wk6E
         T1Tg==
X-Gm-Message-State: ALQs6tBTtOkx0DfwMhDG/CeV0Vr97JhpZmS+5ldhfneJg/NrK11Gt9jc
        uhice/NMcOtezxposPnuiS17b4Xe8FfCeAdC/epqIu2Y
X-Google-Smtp-Source: AIpwx48MkhJOAOHT0y3xJDeinbuoIPhPuBMy2tdkr/wp4aBHrmHd/XwyGFO/6CSrTvjuHteuAwQGDE2KAuZi8eB6UMg=
X-Received: by 2002:a24:5b02:: with SMTP id g2-v6mr3232907itb.100.1523577353626;
 Thu, 12 Apr 2018 16:55:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Thu, 12 Apr 2018 16:55:53 -0700 (PDT)
In-Reply-To: <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com> <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Apr 2018 16:55:53 -0700
X-Google-Sender-Auth: Bse4hxV0a-rkelSetueaOyKHQg0
Message-ID: <CA+55aFw5mpEcEpPTOWych-kjNLc8pEn8FdjJHe2u7HUBBLy-Fw@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ Talking to myself ]

On Thu, Apr 12, 2018 at 4:41 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Oddly, that *already* has the check:
>
>         if (mfi.clean && !df_conflict_remains &&
>             oid_eq(&mfi.oid, a_oid) && mfi.mode == a_mode) {
>                 int path_renamed_outside_HEAD;
>                 output(o, 3, _("Skipped %s (merged same as existing)"), path);
>
> but that doesn't seem to actually trigger for some reason.

Actually, that check triggers just fine.

> But the code really seems to have the _intention_ of skipping the case
> where the result ended up the same as the source.
>
> Maybe I'm missing something.

The later check that does

                /*
                 * The content merge resulted in the same file contents we
                 * already had.  We can return early if those file contents
                 * are recorded at the correct path (which may not be true
                 * if the merge involves a rename).
                 */
                path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
                if (!path_renamed_outside_HEAD) {

will see that 'path2' is NULL, and not trigger this early out case,
and then this all falls back to the normal cases after all.

So I think that 'path_renamed_outside_HEAD' logic is somehow broken.

Did it perhaps mean to say

                path_renamed_outside_HEAD = path2 && !strcmp(path, path2);

instead?

See commit 5b448b853 ("merge-recursive: When we detect we can skip an
update, actually skip it") which really implies we want to actually
skip it (but then we don't anyway).

Also see commit b2c8c0a76 ("merge-recursive: When we detect we can
skip an update, actually skip it") which was an earlier version, and
which *actually* skipped it, but it was reverted because of that
rename issue.

Adding Elijah Newren to the cc, because he was working on this back
then, an dis still around, and still working on merging ;)

               Linus
