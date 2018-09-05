Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6D01F404
	for <e@80x24.org>; Wed,  5 Sep 2018 17:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeIEV6s (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:58:48 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:38256 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbeIEV6r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 17:58:47 -0400
Received: by mail-ed1-f50.google.com with SMTP id h33-v6so6714457edb.5
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8otiQqs+6fTFSnfO9Ku57DPncmcrQLl8NP2RbpEc+rg=;
        b=TR+myKr5UrVc+kHWBkN5vHa+R5AOTV0Q7koKAbdnTbpRKTjaBJvYqKOB4WAh5YLx+o
         LgYkXHC+p6MwE2ECkHPN+wPCGE0251TEUjET/kX7dPxLty9UJOWMwXy+Uuyo1A9PziKx
         yIV2mQa1V0nHofLH07jKsFtXmdoSWJ9QNFYfk53dX7c8wMY0p+JhjK9bbfkYd3svSH2Z
         Mknt35HYjYaLKD171h0qoGcOkZu0RFKB+fb492IIJLxMoOCS2OPktD/BFosk3OlBFCIu
         o/zCnJvLVFGCrJFGdmrBJxG5SOoi5CTG4EKxf7OvWLco7SXyz7R3zrcjE8TFjinK3JFl
         sxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8otiQqs+6fTFSnfO9Ku57DPncmcrQLl8NP2RbpEc+rg=;
        b=InrfdbLgVspsOj7Yc2qJk7RH29cZvCktHMR/fiUSZxMb1i1FK78eZSbCUSPoIQJB9U
         oc0wtaVMBILr1uTbaPwyOgQ/oN2xM99JM0UMF8XSWX31V1q+sn2Kc4VEri2oYbKvv8/L
         NVEkW04HNq35nPLbpYyc/UFqo6HreqF6Tcz5qh6ah0+G4sSELUIWPDQa0O5GX+S+VnxE
         gCFvr1sHxO/8KU4vNQmKZSa5vKgGb7sxG+wevNCSQbzKfXQ4P6t+A7J9fWm3pxfyvIvn
         tOAanhH6CIAXU7nARygnnAWyx75Tf9OJhF82IG3mkDPoxP569hweIdebMyz6ff//iJLs
         hKTQ==
X-Gm-Message-State: APzg51DPzkILGzeUEdxuA1oKZU1X+sJWkj/Pwc3evMNDOEcfOzeSp9hV
        NHW1X4wjfMMzKXx2HceYpUiQ/IOLoh8zb0wjxXGP+3DT
X-Google-Smtp-Source: ANB0VdZSrT6yOHtu3n2IUmafXZMkDqtPJ99Kf8tBj9yWQrd/a+vAodUwN7zGCQRQ4EXnR7osdr+y5kojxlqU/FHUWwM=
X-Received: by 2002:a50:b603:: with SMTP id b3-v6mr43718431ede.181.1536168457198;
 Wed, 05 Sep 2018 10:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8B1UDN26tWPvOtixSBiFF6bYP2BtK2n1u4W-tWdVeKK1A@mail.gmail.com>
 <2293750.yp9BkL5mAn@thunderbird> <32028230.38oFsPliiV@thunderbird>
In-Reply-To: <32028230.38oFsPliiV@thunderbird>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 5 Sep 2018 10:27:26 -0700
Message-ID: <CAGZ79kb5MnUyX9BkFDyFQ7HQ4nXGeo66OUHMPaumfeHgM7e46w@mail.gmail.com>
Subject: Re: How to handle patch series conflicts
To:     "Stephen & Linda Smith" <ischis2@cox.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 10:25 AM Stephen & Linda Smith <ischis2@cox.net> wrote:
>
> Junio -
>
> On Tuesday, September 4, 2018 10:27:26 AM MST Junio C Hamano wrote:
> > > t7500-commit.sh
> > > t7501-commit.sh
> > > t7502-commit.sh
> > > t7509-commit.sh
> >
> > These seem to have organically grown and it is very likely that ones
> > later introduced were added more from laziness.
>
> How does the project prefer to handle patches that conflict.  Renaming t7501-
> commit.sh will conflict with a patch set that I submitted over the weekend
> [1].  Should I treat them as totally separate?

When doing a rename, this should merge fine without much complication,
so I'd think it is fine to treat them separately. That way they can be merged
to next/master independently.
