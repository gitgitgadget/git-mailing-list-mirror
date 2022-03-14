Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E73C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 10:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbiCNKkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiCNKkt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 06:40:49 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E5735264
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 03:39:40 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id l24-20020a4a8558000000b00320d5a1f938so19638145ooh.8
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 03:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXxOOtq8OmpKEVxZIJndKgSbbzUjcanl7yWPw1YWHSk=;
        b=aW/2W8GLlILLYMKbFY1eJoHsPoi/Ujzl/y2CNphOd06HuLyYSRrCZP6koXBF7dgPtW
         CafRG/SYRjE2rb7cyNuQLcx0iNGNFvc3UOiHq4Ky5HNRMjEDP3q5+exRlG+Bqu4XJGrf
         G6bvARlAkseyZ9QT6i0zCREHiEzTbnOpQKLiFHAOvqdMcLr7VaKUBJ9jbU62jQElMWVq
         uXgpI3gOwvKx+qgL1vwG99yBkLRRKj7EUVz8Mf0Srfs8zhAb/GQSGWyM3Y5PWZsPhXN0
         WXlnW9aRGUbJl8PSYj/ck9NiQTF3dSaDPYaMoupAJTxI/1zCUnsvQYWciX/8/uqjUC1T
         8vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXxOOtq8OmpKEVxZIJndKgSbbzUjcanl7yWPw1YWHSk=;
        b=RELPNKxGeGNfa9lP2IXqbYen1dDuWm8+OPGFIvw2hTvlATY0sMh8NG68yxp1LFJZwH
         prqsR2zWcY8cKYFmwy/tpLOsvfopm4HIJh3xJA0lGQdrpXxr+RHrOVrkBBxmvucMG4d5
         scIhHvX8GHQO+as+LY3u/Fd4dluW0i3swaBHWGZi39BNtSE5WbswNEk9wo/IDHfBmCkR
         4/xzb5apAmfHT2+MJSAI30ze0u4we+Lss0Ro7AzHPh8GXVWaekN10DREHGSFIHKsaDpU
         X6BmjJw3mE86OvU9eml4qv3VmbVaoEJ6oUzsqSwEY0qSugEQg75t5DiwczGvhzAWo4X/
         /21w==
X-Gm-Message-State: AOAM533RbWEjIljpyQFb2x8Ux42QVftUhf8AdB8RCY9i9AuRJjEsGC+n
        nkhzkPW21EFwnR++Xs+l7l9IRgskwahkanmbs5bMcz2jDBw=
X-Google-Smtp-Source: ABdhPJzF3qybp+ev7cIAkAGcvtfB5ZCyzeWO55/UxROXbqTYxdW+3hXRtCcvyCala+jUurzbrl/b74Gsh2WC1YZLB5w=
X-Received: by 2002:a05:6870:eca1:b0:da:b3f:3229 with SMTP id
 eo33-20020a056870eca100b000da0b3f3229mr10915075oab.217.1647254379409; Mon, 14
 Mar 2022 03:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220314002327.243915-1-gitter.spiros@gmail.com> <xmqqh781t7ks.fsf@gitster.g>
In-Reply-To: <xmqqh781t7ks.fsf@gitster.g>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Mon, 14 Mar 2022 11:39:31 +0100
Message-ID: <CA+EOSBkJtcvKJ1D1hMuWB0EkrGEfP7Dua6gP8MDHehto1r+E3A@mail.gmail.com>
Subject: Re: [PATCH 6/6] attr.h: remove duplicate struct definition
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno lun 14 mar 2022 alle ore 06:40 Junio C Hamano
<gitster@pobox.com> ha scritto:
>
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
> > Subject: Re: [PATCH 6/6] attr.h: remove duplicate struct definition
>
> I do not see other 5 from 1/6 thru 5/6 on the list.
I'm sorry. It was my mistake in producing the patch. There are no
other cases like this.

Thanks for your patience
>
> If this is a leftover bit follow-up to the 5-patch series whose
> cover letter was <20220313195536.224075-1-gitter.spiros@gmail.com>
> we often see such a message
>
>  - with subject numbered as [PATCH 6/5]
>  - as follow-up to the same cover letter.
>
> The patch text looks good, and we can see from the output of
>
>  $ git grep '^struct .*;' \*.h |
>    sort | uniq -c | sort -n | grep -v '^ *1 '
>
> that this is the only duplicated opaque struct declaration in the
> header files.
>
> For now, I'd assume that is the case and queue it on the same topic
> branch as the other five.  Thanks.
>
> > struct index_state is declared more than once.
> >
> > Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> > ---
> >  attr.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/attr.h b/attr.h
> > index 3732505eda..3fb40cced0 100644
> > --- a/attr.h
> > +++ b/attr.h
> > @@ -121,7 +121,6 @@ struct git_attr;
> >  /* opaque structures used internally for attribute collection */
> >  struct all_attrs_item;
> >  struct attr_stack;
> > -struct index_state;
> >
> >  /*
> >   * Given a string, return the gitattribute object that
