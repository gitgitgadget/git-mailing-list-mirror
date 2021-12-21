Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF19C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 19:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbhLUTBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 14:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241230AbhLUTBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 14:01:16 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0A3C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:01:16 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id jw3so118895pjb.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=zfT4NLH71tbc13EhTbjFLlTmL5sYaRdZNAhishGqzvQ=;
        b=IyXEHA3DfrNMyFeA99/T+fOSn+cd5BJN0almR9zvrkOYwmebHLqEAilCtojNzmcLIX
         6rzGjSZiKnTw7jwBvMyJazVmftMwauRRECk1BBrrKwE665HsfSeoZAzmexgklu5Dk6t6
         Ia4GpTPBcYGzp7JOiUnlsU6TfNVZFFI09uV3RYhsRxXMRleKmTDaA2NP7RgdSgI1z/sK
         YQ37PvOP0VgCTBK39ikTtG9yJBtJMq9Z2B7WsT7g73ddkRTJYrAB0KH0C6T5DCS0DRo0
         NaVcZu9nJwshgntaDgfLD3hw7jLS046tM8AtWGc2oGHAz+Dcd1M2mN9PK2RdpjsPdE+X
         c5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=zfT4NLH71tbc13EhTbjFLlTmL5sYaRdZNAhishGqzvQ=;
        b=QmJ74ZMoWBS3ZBHTolKdNHdLyYlBd6KMQifx69LW1g5RevZY23UMPaI11O8Sj67P/9
         masvezlWpux1hTwQfkrxpt1rEQdBFiOQ83qWoFxBMs32EuCwjDGlOavInk73vGPQBxb9
         9U1W50HZ54+uVVFMznrm4AaLYPHyIe7wkTqbEOp5/OcXWORB1uSf/3gS+Er4peSLsFtk
         rfK1o3L7jvAF1lEx9GaF7kcwUw07PlT6CQPXPtJ0oZRfSlO79ajmI+Lf/FEzwFkOVx1R
         gVDAiuJ3ybkyC+TEKszIKagMKcW3pJoSe2S7/b5jUy9AiDimQVmgJIXZlG/Sr7sl9di8
         ceYA==
X-Gm-Message-State: AOAM530vWIkiA97yjVb3fkGMKiC7OYNtUA6lkgWmehjwGbpmW5zo/XQe
        4IlukHd1nYgUcBMxSRLt3H/gsw==
X-Google-Smtp-Source: ABdhPJyb7Dx8B9Fq2Xw5BZhugao8DDMSzZShuInGLXZhpun1lc3jYQAWma6Tz+zZtqmRMj3vMLeURg==
X-Received: by 2002:a17:90b:4a89:: with SMTP id lp9mr5691604pjb.6.1640113275513;
        Tue, 21 Dec 2021 11:01:15 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:e4d8:c4fc:fa70:c18e])
        by smtp.gmail.com with ESMTPSA id a4sm3341738pjw.30.2021.12.21.11.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:01:15 -0800 (PST)
Date:   Tue, 21 Dec 2021 11:01:09 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] l10n: README: call more attention to plural strings
Message-ID: <YcIkdXcLgzUk3+Jc@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <25107068cbbf8c9ce6886e66e25dff19e072583f.1639425295.git.steadmon@google.com>
 <xmqqa6h4b24o.fsf@gitster.g>
 <YbfC5/+Q7lPp0G2i@google.com>
 <CANYiYbF31o-sQYU-OjJk=pQR5RHM0k7jqmEhiKGLeO3Suu1khQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANYiYbF31o-sQYU-OjJk=pQR5RHM0k7jqmEhiKGLeO3Suu1khQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.16 09:10, Jiang Xin wrote:
> On Tue, Dec 14, 2021 at 6:02 AM Josh Steadmon <steadmon@google.com> wrote:
> >
> > On 2021.12.13 13:56, Junio C Hamano wrote:
> > > Josh Steadmon <steadmon@google.com> writes:
> > >
> > > > In po/README.md, we point core developers to gettext's "Preparing
> > > > Strings" documentation for advice on marking strings for translation.
> > > > However, this doc doesn't really discuss the issues around plural form
> > > > translation, which can make it seem that nothing special needs to be
> > > > done in this case.
> > > >
> > > > Add a specific callout here about marking plural-form strings so that
> > > > the advice later on in the README is not overlooked.
> > > >
> > > > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > > > ---
> > > >  po/README.md | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/po/README.md b/po/README.md
> > > > index dcd8436c25..fd1e024dd3 100644
> > > > --- a/po/README.md
> > > > +++ b/po/README.md
> > > > @@ -219,7 +219,10 @@ General advice:
> > > >    they're part of Git's API.
> > > >
> > > >  - Adjust the strings so that they're easy to translate. Most of the
> > > > -  advice in `info '(gettext)Preparing Strings'` applies here.
> > > > +  advice in `info '(gettext)Preparing Strings'` applies here. Strings
> > > > +  referencing numbers of items may need to be split into singular and
> > > > +  plural forms; see the Q\_() wrapper in the C sub-section below for an
> > > > +  example.
> 
> Wouldn't it be better if we add a new rule ("Strings ... an example.")
> after this one?

Fixed in V2, thanks!
