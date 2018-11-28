Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1B71F609
	for <e@80x24.org>; Wed, 28 Nov 2018 15:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeK2CgK (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 21:36:10 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50539 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbeK2CgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 21:36:09 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so5002210iti.0
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 07:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Uohni6nTrA1d/+P1/Jd9tcyEToY+PWnlAnxuwLYmvo=;
        b=I3/tATHD6YcTalRclqXH5UX3sA2L6liY0UZvXQUoGTM0m7CoukdCwslgUI/uPOjBK1
         R+aVMVw62fjtg/MKUVepu4gJU2G3KTgVng2OIKQ17PFv7TC8bKLGYfK//ujXsZ5GxUta
         zMO9i7S5gbJWdP5oYSK3aH+zVxT4esZxCu2ibzD5xuASlJoXRxOi6CTFMSbaOeeMpH6s
         k7/AruEGAlvrph4veY58+Q0t6vZJDqfbmI7zg9XcsuRrVoMrV4oT2q6+8LEBS569dVrR
         1oIYdlaXnA6t4iaOa5RG7sg2MaRf10RBkjvv1duEkg59ah93Wi8qyio5vQ3zY7/PbDJH
         0uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Uohni6nTrA1d/+P1/Jd9tcyEToY+PWnlAnxuwLYmvo=;
        b=OiGPl2V0kWuJl4kzfJlCaLSFv1OeB02Uadext6MR34yGb7/Aw/N1Jy1h9GsqNY9RfS
         pXhKAB+dv4/R20/W9jUPOWiKYCkPrf6jqQh3JgI7diQZj6Ju6NeegUj8+6pDc2W0c+ug
         Qd5/T3h6P7q6S75FqByfJ1ds0RY5pZoNkbZGDzWbaDLW2S16APAjmJ5HNy1UGUleo4nD
         KRh7KpZdY6Zz3G/oblVdYTkmkS/Feeh32j170PZyI39oSCkmx7S6IoiBR3eJHd4uOWVs
         C2YezZo4VinsZpcKTauIiYyVToU/IumqqVZTPjvRswOopde9r67CmvuwZO0S19xrt7si
         xzHg==
X-Gm-Message-State: AA+aEWaatF/SEsquqz73F6Byyltr4WF03dish6gQ1HqtjedqSrgr4IBX
        SgyM8Rjp4jy2DNCnFHqo+ba8Z6VdUB8j0YfDeqg=
X-Google-Smtp-Source: AFSGD/VYsdwIXPECA9CRRvNizndRqrNlMkQt3/RVUvFPSpsrXYyTSyBr+BoVpRLx7BgAB5pLe4rlkDbjYGnGzhvxr4o=
X-Received: by 2002:a24:f589:: with SMTP id k131mr2963372ith.10.1543419246460;
 Wed, 28 Nov 2018 07:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-8-pclouds@gmail.com> <xmqqbm69spp4.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm69spp4.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Nov 2018 16:33:39 +0100
Message-ID: <CACsJy8BBeRDY85rJLzeJRFSazEn1rZ8JGN6_vwAr2ia=FaiLNg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] Suggest other commands instead of "git checkout"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 7:04 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > The assumption made is here
> >
> > - "git checkout" is a horrible monster that should only be touched
> >   with a two-meter pole
> >
> > - there are other commands that can achieve the same thing
>
> Thanks for clearly spelling out the assumptions.  It is good that
> this step cames at the end, as the earlier 6 steps looked reasonable
> to me.

I see my deliberate attempt to provoke has failed :D Giving your view
of the new commands as "training wheels", I take it we still should
make them visible as much as possible, but we just not try to hide
"git checkout" as much (e.g. we mention both new and old commands,
instead of just mentioning the new one, when suggesting something)?
--=20
Duy
