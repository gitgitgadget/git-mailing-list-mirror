Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBF7C1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 15:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbeK1Cqx (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 21:46:53 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54396 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbeK1Cqx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 21:46:53 -0500
Received: by mail-it1-f195.google.com with SMTP id m123-v6so10653082ita.4
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 07:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jJItO925JCRdnqFQaJ2BAEKRnk1f/JbgyYflFzZcXDA=;
        b=I0kKkDYIgIuj87dXanIvnvnk1dFkBjzLAcRJHjSAF9iNMuyE53LGOE3pniJq5YGi4h
         ql1wiBlzbBF6kFPluH8JPvg0iLBblCJWACX2e8ljFj+nErE9bH3153tnGDk5hHDcnWCF
         4Pq5XjrneQCeN2SQIS6LSPxaDQt0xJqIzMfmTAqAiCU+O6l1f/nUwrAXfEjiGPPsvU9a
         dc3KAeffXYyMkXoyejuwor/YtWXLZQzybuaG6CevL4wG2iA1KvuG5xijIX3uROXnouDD
         dXBiK2uEjczLpLSgRCHNgSGDz+Xf86Epgsy0uVQ7Y+k6PxRW7k0M6CNEFrsrL9J6FPfR
         yJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jJItO925JCRdnqFQaJ2BAEKRnk1f/JbgyYflFzZcXDA=;
        b=CqEkiT++0ffdrM/+EEvQn75DEhJIJt76ztEb+oHiOD34CUPMaOvorssjl/UGdIK/wG
         s7HMXd+d/Jixz6ww3e4aSIcSqBre3JWkT1epbhVu4KhrlFLjpS3omklXWL3pj8WIlpSK
         Wkva24iwG3XSlrRSadoEGFl/MbCVFmof4jCvgb23wvF8K+IixfC2Qln7iQsyslIIHPu4
         X0IeaTRlhzu/f4Arh1WehK0/7mJqfkk/K/t9nKfxQmadjgJJYxym8NBYZOze9sBeXA6u
         yIph5DqsoUkhoHeYpYI/pEcHDMk46GCNnx3ZkmeUPt5jkrSfWPjX33W0/ztDMtmQ0lOD
         dMQA==
X-Gm-Message-State: AA+aEWaeMPLD1liJ94SvgX3p3EAhmrv3gonlLtLj3Q3eE9PhbS63cJlC
        s6Qg0jIcxHk+4nbZd0lsWloJcKdR3+iomuKWYOE=
X-Google-Smtp-Source: AFSGD/UYsCuoUYwfdvWz9skZ5j4RqfOFpJNkxavduFwYJA55EdNL6hJJVp5YOiYbT74asleYipRg0Sce6yQSPa6tg6c=
X-Received: by 2002:a24:19d5:: with SMTP id b204mr26159020itb.6.1543333713598;
 Tue, 27 Nov 2018 07:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20181127100557.53891-1-carenas@gmail.com> <CAPig+cT1ruGsd-7yXV3Oxs2_9zOh-d4HgZiQ-OVZzHc1buo4FQ@mail.gmail.com>
In-Reply-To: <CAPig+cT1ruGsd-7yXV3Oxs2_9zOh-d4HgZiQ-OVZzHc1buo4FQ@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 27 Nov 2018 07:48:19 -0800
Message-ID: <CAPUEsphe5E4ZrLy=NmuAHhdE4jOjYhAstOzHRNtBcuwrhvwbvg@mail.gmail.com>
Subject: Re: [PATCH] config.mak.dev: enable -Wpedantic in clang
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, dev+git@drbeat.li, pclouds@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 2:53 AM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> On Tue, Nov 27, 2018 at 5:06 AM Carlo Marcelo Arenas Bel=C3=B3n
> > +ifneq ($(filter clang10,$(COMPILER_FEATURES)),)
> > +CFLAGS +=3D -Wpedantic
> > +endif
>
> Should this condition be tightened to match only for OSX since there
> is no such clang version number in the rest world outside of Apple?

instead, I changed it to clang4 and tested it in a FreeBSD 11 box I
was able to get a hold off, would that work better?
will update patch accordingly then

Carlo
